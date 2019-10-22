# (C) 2001-2019 Intel Corporation. All rights reserved.
# Your use of Intel Corporation's design tools, logic functions and other 
# software and tools, and its AMPP partner logic functions, and any output 
# files from any of the foregoing (including device programming or simulation 
# files), and any associated documentation or information are expressly subject 
# to the terms and conditions of the Intel Program License Subscription 
# Agreement, Intel FPGA IP License Agreement, or other applicable 
# license agreement, including, without limitation, that your use is for the 
# sole purpose of programming logic devices manufactured by Intel and sold by 
# Intel or its authorized distributors.  Please refer to the applicable 
# agreement for further details.


package require cmdline
package require dom::tcl
load_package report

# If no input file specified, pop UI
# After the DOM has been read, work on the replacement
# Set up a replacement dict, check for validity, then run the replacement
# If anything is specified on the command line, use that
# If the replacement dict is not 1:1, post as messages or set up the GUI
# When the user runs convert in the GUI, do the validation

# July 2016
# - Update get_ip_info to work in Standard and Pro
 
################################################################################
# Clean out <session jtag_chain and jtag_device attributes
# Store register fanout of clock in <instance element

################################################################################
proc main { args } {

  set options {
    { "stp_file.arg" "" "STP File name" }
    { "xml_file.arg" "" "XML File name" }
    { "mode.arg" "build" "Build or strip hierarchies" }
  }
  array set opts [::cmdline::getKnownOptions args $options]
  
  # Verify the values for -mode
  switch -exact -- $opts(mode) {
    "build" {
      set input_file $opts(xml_file)
      set output_file $opts(stp_file)
      # Take the rest of the inputs as placeholder to replacement instance maps
      # If there's not an even number of remaining args, error out
      set manual_map [dict create]
      if { 0 != ([llength $args] % 2) } {
        post_message -type error "Specify <placeholder> <replacement instance>\
          space-separated pairs"
        return
      } elseif { 1 < [llength $args] } {
        foreach { p r } $args
        dict set manual_map $p $r
      }
    }
    "strip" {
      set input_file $opts(stp_file)
      set output_file $opts(xml_file)

      # The list of things to adjust comes in the rest of the args
      set num_args [llength $args]
      if { $num_args == 0 } {
        post_message -type error "Specify at least one hierarchy to change"
        return
      }
    }
    default {
      post_message -type error "Specify build or strip for -mode <mode>"
      return
    }
  }
  
  # Read in whatever file we're starting with
  post_message "reading $input_file"
  if { [catch { read_xml -file $input_file } dom] } {
    post_message -type error $dom
    return
  }
   post_message "read xml"
  switch -exact -- $opts(mode) {
    "build" {
      # Get the things that need to be updated in the STP
      # Keys are the placeholder strings for replacement, values are the ip core
      # names
      set placeholder_to_ip_core_name [get_name_replacement_dict -dom $dom]

      # Invert the dict so the keys are the ip core names and the values
      # are a list of the placeholder(s) for that core instance.
      set ip_core_name_to_placeholders [dict create] 
      dict for { placeholder ip_core_name } $placeholder_to_ip_core_name {
        dict lappend ip_core_name_to_placeholders $ip_core_name $placeholder
      }
      
      # Match up the ip core names with what is in the design
      set ip_core_name_to_instances [dict create]
      foreach ip_core_name [dict keys $ip_core_name_to_placeholders] {
        set instances_of_ip_core [get_ip_info -instances_from_name $ip_core_name]
        dict set ip_core_name_to_instances $ip_core_name $instances_of_ip_core
      }
      
      # Validate that there are instances in this design for all the cores
      # in the STP
      set missing_cores [list]
      dict for { ip_core_name instances } $ip_core_name_to_instances {
        if {0 ==  [llength $instances] } {
          lappend missing_cores $ip_core_name
        }
      }
      # In the first version of the script, there can be some cores that
      # misreport their ip core names and instance paths. Override this check
      if { 0 } {
      if { 0 < [llength $missing_cores] } {
        post_message -type error "The SignalTap II file could not be generated\
          because some IP cores in it were not found in your design" \
          -submsgs $missing_cores
        return
      }
      }
      
      # The number of values per key in ip_core_name_to_instances must be
      # greater than or equal to the number of values per same key in
      # ip_core_name_to_placeholder
      # If that is not true, the target design has fewer instances of a core
      # than were put into the original STP file
      # This is never an issue with the first batch of STP/XML files, by
      # inspection
      if { 0 } {
      set bad_cores [list]
      dict for { ip_core_name instances } $ip_core_name_to_instances {
        set placeholders [dict get $ip_core_name_to_placeholders $ip_core_name]
        if { [llength $placeholders] > [llength $instances] } {
          lappend bad_cores $ip_core_name
        }
      }
      if { 0 < [llength $bad_cores] } {
        post_message -type error "The SignalTap II file could not be generated\
          because it includes more instances of some IP cores than are in your\
          design" -submsgs $bad_cores
        return
      }
      }
      
      # If every ip core name maps to one placeholder, and every ip core name
      # maps to one instance, we can create the stp automatically, replacing
      # each placeholder with the corresponding instance.
      # Otherwise we need user intervention.
      set show_gui 0
      set mapping_widget_options [list]
      # actual_replacements is the 1:1 mapping of placeholders to instance
      # strings. Populate it from the command line manual map, then automatically
      # if possible, then pop the GUI and fill remaining entries
      set actual_replacements [dict create]
      # Say where we got the various maps for reporting purposes
      set reporting_info [list]
      dict for { placeholder ip_core_name } $placeholder_to_ip_core_name {
        # If we specified something on the command line for manual_map, always
        # use that
        if { [dict exists $manual_map $placeholder] } {
          dict set actual_replacements $placeholder [dict get $manual_map $placeholder]
          lappend reporting_info $ip_core_name $placeholder \
            [dict get $manual_map $placeholder] "command-line entry"
          continue
        }
        # This placeholder was not specified on the command line. Try to match
        # automatically
        set new_ip_core_instances [dict get $ip_core_name_to_instances $ip_core_name]
        set num_instances [llength $new_ip_core_instances]
        if { 1 == $num_instances } {
          # This is the expected situation; nothing special to do
          dict set actual_replacements $placeholder [lindex $new_ip_core_instances 0]
          lappend reporting_info $ip_core_name $placeholder \
            [lindex $new_ip_core_instances 0] "single instance in design"
        } else {
          # 0, 2 or more
          set show_gui 1
          lappend mapping_widget_options [list -ip_core_name $ip_core_name \
            -candidate_instances $new_ip_core_instances \
            -hier_replacement $placeholder]
        }
      }
      # End of dict for - we've walked through all the things to replace
      
      # Maybe pop the GUI if necessary
      if { $show_gui } {
        ui::assemble_picker_only
        ui::init_data
        foreach temp $mapping_widget_options {
          ui::add_core_mapping_widget {*}$temp
        }
        set done 0
        while { ! $done } {
          # Draw the dialog, get the index of the button the user pushed
          set dialog_response [ui::display]

          # User pressed cancel
          if { 1 == $dialog_response } { return }
          
          # Validate user selections. Assume we'll be valid
          set is_valid 1
          catch { array unset user_ip_map }
          # These are the selections from the dialog
          array set user_ip_map [ui::get_user_ip_map]

          # Go through each placeholder and corresponding replacement string
          # Keep track of which ones are not valid, to tell the user
          set invalid_entries [list]
          foreach user_replace_placeholder [array names user_ip_map] {
            # First do a sanity check that the user made a selection/entry
            set user_replace_instance $user_ip_map($user_replace_placeholder)
            if { 0 == [string length $user_replace_instance] } {
              set is_valid 0
              continue
            }
            # Yup, user selected/entered something.
            set name_col [get_names -filter $user_ip_map($user_replace_placeholder) -node_type hierarchy]
            if { 1 != [get_collection_size $name_col] } {
              # Didn't match only one thing. Redo.
              set is_valid 0
              lappend invalid_entries $user_ip_map($user_replace_placeholder)
            } else {
              foreach_in_collection name_id $name_col {
                set user_ip_map($user_replace_placeholder) [get_name_info -info full_path $name_id]
              }
            }
          } 
          
          if { ! $is_valid } {
            tk_messageBox -type ok -title "Instance not found" -message \
              [join [linsert $invalid_entries 0 "The following instance(s) could not be found in the design:"] "\n"]
          }
          set done $is_valid
        }
        
        # Now go through the validated user_ip_map and put into actual_replacements,
        # and the report structure
        foreach { placeholder new_ip_core_instance } [array get user_ip_map] {
          set ip_core_name [dict get $placeholder_to_ip_core_name $placeholder]
          dict set actual_replacements $placeholder $new_ip_core_instance
          lappend reporting_info $ip_core_name $placeholder \
            $new_ip_core_instance "specified in GUI"
        }
      }
      
      set signal_sets [dict create]
      dict for { placeholder new_ip_core_instance } $actual_replacements {
        # What are we replacing with?
        set foo [list]
        set num_replaced [adjust_hier -dom $dom -remove $placeholder \
          -insert $new_ip_core_instance -unreplaced_var foo]
        set num_clocks_replaced [adjust_hier_for_clock -dom $dom -remove $placeholder \
          -insert $new_ip_core_instance -unreplaced_var foo \
          -signal_set_var signal_sets] 
        remove_hier_replacement_entry -dom $dom -placeholder $placeholder
        if { 0 < [llength $foo] } {
          post_message -type warning "Some node names in the SignalTap II file\
            do not exist in this design." -submsgs $foo
        }
        if { 0 < [dict size $signal_sets] } {
          post_message -type warning "You must set the acquisition clock in the\
            following signal sets" -submsgs [dict keys $signal_sets]
        }
      } 

      # Write the file
      if { [catch { write_xml -file $output_file -dom $dom } res] } {
        post_message -type error $res
        return
      }
    }
    "strip" {
    
      foreach instance $args {
        set ip_core_name [get_ip_info -name_from_instance $instance]
        
        if { 1 != [llength $ip_core_name] } {
          post_message -type warning "Could not find instance $instance in\
            the list of IP cores in this project"
          continue
        }
        
        # Save the tap point driven by the acquisition clock
        if { 0 } {
        if { [catch { store_clock_dest_tap_points -dom $dom } res] } {
          foreach msg $res {
            post_message -type error $msg
          }
          return
        }
        }
        
        set placeholder [clock clicks]
        set unreplaced [list]
        set signal_sets [dict create]
        set num_replaced [adjust_hier -dom $dom -remove $instance \
          -insert $placeholder -unreplaced_var unreplaced]
        set num_clocks_replaced [adjust_hier_for_clock -dom $dom \
          -remove $instance -insert $placeholder \
          -unreplaced_var unreplaced -signal_set_var signal_sets]
        if { 0 < $num_replaced } {
          mark_stp_with_hierarchy_replacement \
            -dom $dom -placeholder $placeholder \
            -ip_name [lindex $ip_core_name 0]
        } else {
          post_message -type warning "No nodes found in instance ${instance}\
            in file ${input_file}"
        }
        if { 0 < [llength $unreplaced] } {
          post_message -type warning "Some node names in the SignalTap II file\
            did not match the IP core you specified." -submsgs $unreplaced
        }
      
      }
      # Done walking the instances to strip

      # Write the file
      if { [catch { write_xml -file $output_file -dom $dom } res] } {
        post_message -type error $res
        return
      }
      
      # End of strip
    }
  }
  # End of switch $opts(mode)
  
  post_message "Finished processing file"
}

################################################################################
# Call read_xml whenever user chooses an input file
# If it comes back with an error, the dom has to be invalidated
# Pop return errors as dialog box in GUI mode or post_messages in script mode
proc read_xml { args } {

  set options {
    { "file.arg" "" "XML File name" }
  }
  array set opts [::cmdline::getoptions args $options]
  
  if { [string equal "" $opts(file)] } {
    return -code error "A file name is required"
  }
  
  if { ! [file exists $opts(file)] } {
    return -code error "File not found: ${opts(file)}"
  }
  
  if { [catch { open $opts(file)} fh] } {
    return -code error "Error opening file: ${fh}"
  }
  
  if { [catch {read $fh} xml_content] } {
    catch { close $fh }
    return -code error "Error reading file: ${xml_content}"
  }
  
  catch { close $fh }
  
  if { [catch {::dom::parse $xml_content} xml_dom] } {
    return -code error "Error parsing ${opts(file)}: ${xml_dom}"
  }

  return $xml_dom
}

##############################################################################
# Write the in-memory tasks list object to the specified file.
# The name must be staw_tasks.xml to be recognized by TimeQuest
proc write_xml { args } {

  set options {
    { "file.arg" "" "File name of the tasks list" }
    { "dom.arg" "" "The DOM to serialize" }
  }
  array set opts [::cmdline::getoptions args $options]
  
  if { [string equal "" $opts(file)] } {
    return -code error "A file name is required for write_xml -file"
  }
  
  if { [catch { open $opts(file) w} fh] } {
    return -code error "Error opening file for writing: ${fh}"
  }
  
  if { [catch { puts $fh [clean_xml -dom $opts(dom)] } res] } {
    return -code error "Error writing XML: ${res}"
  }
  
  catch { close $fh }
  
  return -code ok
}

##############################################################################
# Returns a string with the serialized DOM.
proc clean_xml { args } {

  set options {
    { "dom.arg" "" "The DOM to serialize" }
  }
  array set opts [::cmdline::getoptions args $options]

  if { [catch { dom::serialize $opts(dom) -indent 1 } res] } {
    return -code error "Error serializing DOM: ${res}"
  }
  # Not sure why the DOCTYPE causes problems here.
  regsub {^.*<!DOCTYPE session>\s*} $res {} res
  return $res
}

################################################################################
# Process the STP to generate the XML file
proc process_stp_to_xml { args } {

  set options {
    { "dom.arg" "" "DOM" }
  }
  array set opts [::cmdline::getoptions args $options]

  # Save the clock connectivity
  set hier_replacement [generate_and_mark_stp_with_hierarchy_replacement \
    -dom $opts(dom)]
  adjust_hier -dom $opts(dom) -remove $ip_core_hier -insert $hier_replacement
}

################################################################################
proc process_xml_to_stp { args } {

  set options {
    { "dom.arg" "" "DOM" }
  }
  array set opts [::cmdline::getoptions args $options]

  set hier_replacement [get_and_remove_hierarchy_replacement -dom $opts(dom)]
  adjust_hier -dom $opts(dom) -remove $hier_replacement -insert $ip_core_hier
  # Set the clock name
}

################################################################################
# wire, node, net, clock
#      post_message "Checking that all names in SignalTap II file exist in design"
#      set missing_names [check_names -dom $dom]
#      if { 0 < [llength $missing_names] } {
#        post_message -type error "The SignalTap II file has names that don't exist\
#          in this design" -submsgs $missing_names
#        return
#      }
proc check_names { args } {

  set options {
    { "dom.arg" "" "DOM" }
  }
  array set opts [::cmdline::getoptions args $options]

  set missing [dict create]
  
  foreach type [list "wire" "node" "net" "clock"] {
    set dom_nodes_of_type [dom::selectNode $opts(dom) "//${type}"]
    foreach dom_node_of_type $dom_nodes_of_type {
      set name [dom::element getAttribute $dom_node_of_type "name"]
      if { ! [string equal "" $name] } {
        if { 0 == [get_collection_size [get_nodes -nowarn $name]] } {
          dict set missing $name 1
        }
      }
    }
  }
  return [dict keys $missing]
}

################################################################################
# Returns the name of an IP given an instance path, or the instances given
# a name
proc get_ip_info { args } {

  set options {
    { "name_from_instance.arg" "" "Instantiation path of the IP core" }
    { "instances_from_name.arg" "" "Name of the IP core" }
  }
  array set opts [::cmdline::getoptions args $options]

  load_report

  # Walk through the report, checking whether the IP core name asked for
  # matches each row
  set to_return [list]
  
  # Make sure the report exists
  # Walk through all the panels because there can be multiple IP Cores panels
  # with one per partition
  foreach report_panel_name [get_report_panel_names] {
    # Match both Analysis & Synthesis||Analysis & Synthesis IP Cores Summary
    # in Quartus Prime Standard, and *||Spectra-Q Synthesis IP Cores Summary
    # in Quartus Prime Pro
    if { ! [regexp {Synthesis IP Cores Summary$} $report_panel_name] } { continue }

    set id [get_report_panel_id $report_panel_name]
    if { -1 == $id } {
      # This would be highly unusual.
      post_message -type error "Can not find report panel ${report_panel_name}"
      continue
    }
    
    # Make sure the columns exist
    set ip_core_col [get_report_panel_column_index -id $id "IP Core Name"]
    set entity_instance_col [get_report_panel_column_index -id $id "Entity Instance"]
    
    if { -1 == $ip_core_col } {
      post_message -type error "Can not find IP Core Name column"
    }
    if { -1 == $entity_instance_col } {
      post_message -type error "Can not find Entity Instance column"
    }
    if { -1 == $ip_core_col || -1 == $entity_instance_col } { return -code error }
    
    # prev_match must start with a space - something that will not match.
    # The zero-length string will match in the regexp below
    set prev_match " "
    set num_rows [get_number_of_rows -id $id]
    for { set row 1 } { $row < $num_rows } { incr row } {
      set data [get_report_panel_row -id $id -row $row]
      set ip_core_name [lindex $data $ip_core_col]
      set entity_instance [lindex $data $entity_instance_col]
      # Take off the top-level entity name
      # This will not match in Pro, which does not have a leading |
      regsub {^\|.*?\|} $entity_instance {} entity_instance
      
      if { ! [string equal "" $opts(name_from_instance)] } {
        # We're asking for the IP name given the instance
        if { [string equal $entity_instance $opts(name_from_instance)] } {
          lappend to_return $ip_core_name
          # Only one instance will ever match
          break
        }
      } elseif { ! [string equal "" $opts(instances_from_name)] } {
        # We're asking for the instances given the IP name
        if { [string equal $ip_core_name $opts(instances_from_name)] } {
          # Sub-cores of an IP can have the same IP core name.
          if { [regexp $prev_match $entity_instance] } {
            # This entity instance is a sub-core of our core.
            # Don't save it for return, and don't update prev_match
          } else {
            # This entity instance does not match the previous,
            # so it's a new core; save it, and update prev_match to avoid
            # sub-cores of _this_ core
            lappend to_return $entity_instance
            set prev_match [string map { \[ \\\[ \] \\\] \| \\\| \\ \\\\ } \
              $entity_instance]
          }
          # Don't break - there may be multiple instances of a core
        }
      }
    }
  }
  
  unload_report
  
  return $to_return 
}

################################################################################
# Remove the specified hierarchy from design names in the DOM or
# put in a new hierarchy
# Have one proc for inserting and removing, so two procs can't get out of
# sync. Everywhere we remove, we will have to insert.
proc adjust_hier { args } {

  set options {
    { "dom.arg" "" "DOM" }
    { "remove.arg" "" "What to remove" }
    { "insert.arg" "" "What to insert" }
    { "unreplaced_var.arg" "" "Var name for unreplaced list" }
  }
  array set opts [::cmdline::getoptions args $options]

  set num_replaced 0
  upvar $opts(unreplaced_var) unreplaced
  
  # Escape the hierarchy name
  regsub -all {\|} $opts(remove) "\\\|" pattern
  regsub -all {\[} $pattern "\\\]" pattern
  regsub -all {\]} $pattern "\\\[" pattern
     
  # wire name, bus name
  set wire_nodes [dom::selectNode $opts(dom) "//wire"]
  foreach wire_node $wire_nodes {
    set wire_name [dom::element getAttribute $wire_node "name"]
    if { 1 == [regsub ^$pattern $wire_name $opts(insert) without_hier] } {
      set without_hier [string map [list \{ "" \} ""] $without_hier]
      dom::element setAttribute $wire_node "name" $without_hier
      incr num_replaced
    } elseif { ! [regexp {^\d+\|} $wire_name] } {
      lappend unreplaced $wire_name
    }
  }
  set bus_nodes [dom::selectNode $opts(dom) "//bus"]
  foreach bus_node $bus_nodes {
    set bus_name [dom::element getAttribute $bus_node "name"]
    if { 1 == [regsub ^$pattern $bus_name $opts(insert) without_hier] } {
      set without_hier [string map [list \{ "" \} ""] $without_hier]
      dom::element setAttribute $bus_node "name" $without_hier
      incr num_replaced
    } elseif { ! [regexp {^\d+\|} $bus_name] } {
      lappend unreplaced $bus_name
    }
  }
  set node_nodes [dom::selectNode $opts(dom) "//node"]
  foreach node_node $node_nodes {
    set node_name [dom::element getAttribute $node_node "name"]
    if { 1 == [regsub ^$pattern $node_name $opts(insert) without_hier] } {
      set without_hier [string map [list \{ "" \} ""] $without_hier]
      dom::element setAttribute $node_node "name" $without_hier
      incr num_replaced
    } elseif { ! [regexp {^\d+\|} $node_name] } {
      lappend unreplaced $node_name
    }
  }
  set net_nodes [dom::selectNode $opts(dom) "//net"]
  foreach net_node $net_nodes {
    set net_name [dom::element getAttribute $net_node "name"]
    if { 1 == [regsub ^$pattern $net_name $opts(insert) without_hier] } {
      set without_hier [string map [list \{ "" \} ""] $without_hier]
      dom::element setAttribute $net_node "name" $without_hier
      incr num_replaced
    } elseif { ! [regexp {^\d+\|} $net_name] } {
      lappend unreplaced $net_name
    }
  }
  set level_nodes [dom::selectNode $opts(dom) "//level"]
  foreach level_node $level_nodes {
    set trigger_expr [dom::node cget $level_node -nodeValue]
    set num_regsub [regsub -all $pattern $trigger_expr $opts(insert) \
      trigger_expr]
    incr num_replaced $num_regsub
    set trigger_expr [string map [list \{ "" \} ""] $trigger_expr]
    dom::node configure $level_node -nodeValue $trigger_expr
  }
  
  return $num_replaced
}

################################################################################
# Set the sof name
proc set_sof { args } {

  set options {
    { "dom.arg" "" "DOM" }
    { "sof_name.arg" "" "Override the default SOF name" }
  }
  array set opts [::cmdline::getoptions args $options]

  # Get the revision name of the sof through quartus(revision)
  global quartus
  
  # Allow a forcible specification of the SOF, or look for it in the output
  # files directory
  if { ! [string equal "" $opts(sof_name)] } {
    set sof_name $opts(sof_name)
  } else {
    # The SOF will be in the output files directory if it is specified
    set sof_path [list]
    set output_dir [get_global_assignment -name OUTPUT_FILES_DIRECTORY]
    if { ! [string equal "" $output_dir] } { lappend sof_path $output_dir }
    lappend sof_path ${quartus(revision)}.sof
    set sof_name [file join {*}$sof_path]
  }
  
  # Warn if it wasn't found, but continue anyway
  if { ! [file exists $sof_name] } {
    post_message "Could not find SOF ${sof_name}; generating STP file\
      anyway."
  }
  
  set root [dom::selectNode $opts(dom) "session"]
  dom::element setAttribute $root "sof_file" $sof_name
}

################################################################################
# Generate a string that will be an invalid Verilog/VHDL identifier
# that will be a placeholder for swapping in the new design names
# Returns the placeholder for 
proc mark_stp_with_hierarchy_replacement { args } {

  set options {
    { "dom.arg" "" "DOM" }
    { "placeholder.arg" "" "Place holder for hierarchy replacement" }
    { "ip_name.arg" "" "Name of the IP core" }
  }
  array set opts [::cmdline::getoptions args $options]

  set root [dom::selectNode $opts(dom) "session"]
  set new_replacement_el [dom::document createElement $root \
    "hier_replacement"]
  dom::document createTextNode $new_replacement_el $opts(ip_name)
  dom::element setAttribute $new_replacement_el "placeholder" $opts(placeholder)
}

################################################################################
proc get_name_replacement_dict { args } {

  set options {
    { "dom.arg" "" "DOM" }
  }
  array set opts [::cmdline::getoptions args $options]

  set to_return [dict create]
  set root [dom::selectNode $opts(dom) "session"]
  set name_replacements [dom::selectNode $root "//hier_replacement"]
  foreach name_replacement $name_replacements {
    set ip_core_name [dom::node cget [dom::node cget $name_replacement -firstChild] \
      -nodeValue]
    set placeholder [dom::element getAttribute $name_replacement "placeholder"]
    dict set to_return $placeholder $ip_core_name
  }

  return $to_return
}

################################################################################
# Removes an element from the session tag
# Do this before serializing the STP file
# Returns nothing
proc remove_hier_replacement_entry { args } {

  set options {
    { "dom.arg" "" "DOM" }
    { "placeholder.arg" "" "Placeholder for entry to remove" }
  }
  array set opts [::cmdline::getoptions args $options]

  set root [dom::selectNode $opts(dom) "session"]
  set hier_replacements [dom::selectNode $root "//hier_replacement"]
  foreach hier_replacement $hier_replacements {
    set placeholder [dom::element getAttribute $hier_replacement "placeholder"]
    if { [string equal $placeholder $opts(placeholder)] } {
       dom::node removeChild $root $hier_replacement
    }
  }
}

################################################################################
# clock has special behavior to replace
proc adjust_hier_for_clock { args } {

  set options {
    { "dom.arg" "" "DOM" }
    { "remove.arg" "" "What to remove" }
    { "insert.arg" "" "What to insert" }
    { "unreplaced_var.arg" "" "Var name for unreplaced list" }
    { "signal_set_var.arg" "" "Var name for signal sets" }
  }
  array set opts [::cmdline::getoptions args $options]

  set num_replaced 0
  upvar $opts(unreplaced_var) unreplaced
  upvar $opts(signal_set_var) signal_sets
  
  # Process each signal set separately
  set signal_set_dom_nodes [dom::selectNode $opts(dom) "session/instance/signal_set"]
  
  foreach signal_set_dom_node $signal_set_dom_nodes {
  
    set signal_set_name [dom::element getAttribute $signal_set_dom_node "name"]

    # Get the name of the acquisition clock for this signal set
    set clock_dom_node [dom::selectNode $signal_set_dom_node "clock"]
    set clock_name [dom::element getAttribute $clock_dom_node "name"]

    # If the name is blank, do nothing to it
    # If the remove matches, do the replacement
    
    # Escape the hierarchy name
    regsub -all {\|} $opts(remove) "\\\|" pattern
    regsub -all {\[} $pattern "\\\]" pattern
    regsub -all {\]} $pattern "\\\[" pattern
    
    if { 1 == [regsub ^$pattern $clock_name $opts(insert) without_hier] } {
      set without_hier [string map [list \{ "" \} ""] $without_hier]
      dom::element setAttribute $clock_dom_node "name" $without_hier
      incr num_replaced
    } elseif { [regexp {^\d+\|} $clock_name] } {
      # The clock name was already replaced with the numeric string
    } else {
      # The clock name did not match and was not a numeric string
      # Blank it
      dom::element setAttribute $clock_dom_node "name" ""
      lappend unreplaced $clock_name
      # On the build, keep track of signal sets that will need user attention
      dict set signal_sets $signal_set_name 1
    }

   }
   return $num_replaced
}

################################################################################
# In each clock element, save the data_index of a tap point it fans out to,
# so the appropriate connection can be made later
# Returns an error if a clock can't be traced to any tap points
# Returns nothing if successful, but modifies the DOM
proc store_clock_dest_tap_points { args } {

  set options {
    { "dom.arg" "" "DOM" }
  }
  array set opts [::cmdline::getoptions args $options]

  set problems [list]
  set to_do [list]
  
  # Process each signal set separately
  set signal_set_dom_nodes [dom::selectNode $opts(dom) "session/instance/signal_set"]
  
  foreach signal_set_dom_node $signal_set_dom_nodes {
  
    set signal_set_name [dom::element getAttribute $signal_set_dom_node "name"]
    post_message $signal_set_name
    # Get the name of the acquisition clock for this signal set
    set clock_dom_node [dom::selectNode $signal_set_dom_node "clock"]
    set clock_name [dom::element getAttribute $clock_dom_node "name"]
    
    # Do preliminary checking of the acquisition clock existence
    set clock_node_collection [get_nodes -nowarn $clock_name]
    if { 0 == [get_collection_size $clock_node_collection] } {
      lappend problems "No acquisition clock source named ${clock_name} found\
        in this design, but it is used in signal set ${signal_set_name}"
      continue
    }
    post_message $clock_name
    # Get all the node nodes, which are in data and setup views
    set node_dom_nodes [dom::selectNode $signal_set_dom_node "//node"]
    
    # Verify one of these tap points is driven by the clock
    set has_connection 0
    foreach node_dom_node $node_dom_nodes {
      set data_index [dom::element getAttribute $node_dom_node "data_index"]
      set tap_point_name [dom::element getAttribute $node_dom_node "name"]
      post_message "checking data index $data_index tap point $tap_point_name"
      if { [string equal "" $data_index] || [string equal "" $tap_point_name] } {
        # Make sure the XML node has a name and a data index
#        post_message [dom::node stringValue $node_dom_node]
        continue
      }
      # Make sure the tap point node exists in the design
      
#      set tap_point_name [dom::element getAttribute $wire_node "name"]
      set path_col [get_path -from $clock_node_collection -through [get_pins -hier *|clk] \
        -to $tap_point_name]
      if { 1 == [get_collection_size $path_col] } {
        # Good - we have a path from the clock to the register
        set has_connection 1
        break
      }
    }
    post_message "has connection $has_connection"
    if { ! $has_connection } {
      # No paths found? Highly unlikely. Regardless, it's catastrophic.
      lappend problems "Could not verify connections from acquisition clock\
        ${clock_name} in signal set ${signal_set_name}"
      continue
    }
    
    lappend to_do $clock_dom_node $data_index    
  }
  
  # Report on all problems at the end
  if { 0 < [llength $problems] } {
    return -code error $problems
  }
  
  # No problems? Update the XML all at once
  foreach { clock_dom_node data_index } $to_do {
    dom::element setAttribute $clock_dom_node "drives_tap_point_with_data_index" \
      $data_index
  }

  return -code ok
}

################################################################################
# Put in appropriate names for the clock elements
# There are all kinds of ways this could require manual updates after the fact.
# When this runs, always remove the data_index pointer in the clock element
# so it's valid STP. Update the clock name if the tap point exists in the
# target design, if it has only one clock path to it
# I think there is more benefit to leaving a clock name in and unreplaced,
# than there is risk. At worst, the compilation will fail or the name will
# possibly collide with another clock in the design (unlikely). At best, the
# user can extract some useful information from the old name about what to
# connect to now
proc update_clock_names { args } {

  set options {
    { "dom.arg" "" "DOM" }
  }
  array set opts [::cmdline::getoptions args $options]

  set problems [list]
  set to_do [list]
  
  # Process each signal set separately
  set signal_set_dom_nodes [dom::selectNode $opts(dom) "//signal_set"]
  
  foreach signal_set_dom_node $signal_set_dom_nodes {
  
    set signal_set_name [dom::element getAttribute $signal_set_dom_node "name"]

    # Get the data_index driven by the acquisition clock for this signal set
    set clock_dom_node [dom::selectNode $signal_set_dom_node "./clock"]
    lappend to_do $clock_dom_node
    set desired_data_index [dom::element getAttribute $clock_dom_node "drives_tap_point_with_data_index"]
    
    # Get all the node nodes, which are in data and setup views
    set node_dom_nodes [dom::selectNode $signal_set_dom_node ".//node"]
    
    # Find the node with the specified data_index
    set found_node 0
    foreach node_dom_node $node_dom_nodes {
      set data_index [dom::element getAttribute $node_dom_node "data_index"]
      set tap_point_name [dom::element getAttribute $node_dom_node "name"]
      if { [string equal $desired_data_index $data_index] || ![string equal "" $tap_point_name] } {
        # We found the node
        set found_node 1
        break
      }
    }
    
    if { ! $found_node } {
      # Can't find the node? Highly unlikely. Regardless, it's catastrophic.
      lappend problems "Internal error finding a node with data_index ${desired_data_index}"
      # No clock name replacement to do
      lappend to_do ""
      continue
    }
    
    # Does the tap point exist in the new design?
    if { 0 == [get_collection_size -nowarn [get_names $tap_point_name]] } {
      lappend problems "You must choose an acquisition clock for signal set\
        ${signal_set_name}. The tap point used to automatically choose the\
        acquisition clock was not found: ${tap_point_name}"
      # No clock name replacement to do
      lappend to_do ""
      continue
    }
    
    # We did find the tap point. Make sure it's driven by one clock
    set path_col [get_paths -through [get_pins -hier *|clk] -to $tap_point_name -npaths 1000]
    set num_paths [get_collection_size $path_col]
    if { 0 == $num_paths } {
      # Catastrophic.
      lappend problems "You must choose an acquisition clock for signal set\
        ${signal_set_name}. No clock was found driving the tap point used to\
         automatically choose the clock: ${tap_point_name}"
      # No clock name replacement to do
      lappend to_do ""
      continue
    } elseif { 1 > $num_paths } {
      # There was more than one path to the clock
      # Could happen with clock switchover
      lappend problems "You must choose an acquisition clock for signal set\
        ${signal_set_name}. Multiple clocks were found."
      # No clock name replacement to do
      lappend to_do ""
      continue
    }
    
    foreach_in_collection path_id $path_col {
      set from [get_path_info -from $path_id]
      set from_name [get_node_info -name $from]
      lappend to_do $from_name
    }

  }

  # We always want to remove the data_index pointer so the STP file is valid
  foreach { clock_dom_node clock_node_name } $to_do {
    dom::element removeAttribute $clock_dom_node "drives_tap_point_with_data_index"
    if { ! [string equal "" $clock_node_name] } {
      dom::element setAttribute $clock_dom_node $name $clock_node_name
    }
  }
  if { 0 < [llength $problems] } {
    return -code error $problems
  }
  return -code ok
}

################################################################################
# Returns a list of clock signals driving a collection of registers
proc get_clock_signals_driving_registers { args } {


}

################################################################################
# Helper proc to return a dict mapping clock targets to clock names
proc get_clock_target_mapping { args } {

  set target_map [dict create]
  
  foreach_in_collection clock_id [get_clocks] {
    set clock_name [get_clock_info -name $clock_id]
    set target_col [get_clock_info -targets $clock_id]
    foreach_in_collection target_id $target_col {
      set target_name [get_node_info -name $target_id]
      dict lappend target_map $target_name $clock_name
    }
  }
  
  return $target_map
}

namespace eval ui {
  
  variable dom
  variable stp_dialog
  variable core_list_display_num
  variable stp_dialog_vars
  variable core_frame
  variable user_ip_map
  variable stp_dialog_vars
  
  namespace export init_data add_core_mapping_widget assemble display \
    get_user_ip_map
  
  ################################################################################
  proc init_data { args } {
  
    set options {
      { "dialog_vars.arg" "" "List of any dialog vars to init" }
      { "ip_map.arg" "" "List of any IP mappings to init" }
    }
    array set opts [::cmdline::getoptions args $options]

    # Initialize the var that is used to uniquify each item in the core
    # list scrolled window. It's also used in the GUI label
    # Things that use it are responsible for incr'ing it
    variable core_list_display_num
    set core_list_display_num 1
    
    # Clear all child widgets out of the core_frame
    variable core_frame
    foreach w [winfo children $core_frame] {
      destroy $w
    }
    
    # Clear out all textvariables for the dialog
    variable stp_dialog_vars
    array unset stp_dialog_vars
    array set stp_dialog_vars [list \
      "input_file" "" \
      "output_file" ""]
    
    # Clear out all IP core mappings
    variable user_ip_map
    array unset user_ip_map
    
    # Initialize with anything that came in
    array set stp_dialog_vars $opts(dialog_vars)
    array set user_ip_map $opts(ip_map)
  }
  
  ################################################################################
  # 
  proc get_user_ip_map { args } {
    variable user_ip_map
    return [array get user_ip_map]
  }
  
  ################################################################################
  # Add an item to the core_frame
  proc add_core_mapping_widget { args } {
  
    set options {
      { "ip_core_name.arg" "" "IP core name" }
      { "hier_replacement.arg" "" "String for hierarchy replacement" }
      { "tap_points.arg" "" "List of tap points to show" }
      { "candidate_instances.arg" "" "List of instances of IP core in user design" }
    }
    array set opts [::cmdline::getoptions args $options]
  
    variable core_list_display_num
    variable core_frame
    variable user_ip_map
    
    set tf [TitleFrame ${core_frame}.tf${core_list_display_num} -text "IP Core ${core_list_display_num}"]
    set f [$tf getframe]
    set cnl [label ${f}.cnl${core_list_display_num} -text "IP core name:"]
    set cne [Entry ${f}.cne${core_list_display_num} -text $opts(ip_core_name)]
    set cnil [label ${f}.cnil${core_list_display_num} -text "IP core instance:"]
    set cncb [ComboBox ${f}.cncb${core_list_display_num} -values $opts(candidate_instances) \
      -textvariable [namespace which -variable user_ip_map](${opts(hier_replacement)})]
#    bind ${cncb}.e <1> [namespace code [list paste_in %W]]
    #{ paste_in %W }
    
    # Grid the component widgets
    grid $cnl $cne
    grid $cnl -sticky w
    grid $cne -sticky we
    grid $cnil $cncb
    grid $cnil -sticky w
    grid $cncb -sticky we
    grid columnconfigure $f 1 -weight 1
    
    # Pack the frame into the scrolled window
    pack $tf -side top -fill x -expand true
    
    incr core_list_display_num
  }
  
  ##############################################################################
  proc paste_in { entry_widget } {
  
    $entry_widget delete 0 end
    post_message "Widget contents is [$entry_widget cget -text]"
    if { [catch { selection get -selection PRIMARY } cc] } {
      if { [catch { selection get -selection CLIPBOARD } cc] } {
        return
      }
    }
      
    post_message "clipboard contents is $cc"
    $entry_widget configure -text $cc
    post_message "widget contents is [$entry_widget cget -text]"
  }
  ################################################################################
  # TODO - enable paste
  # bind $efil <Control-v> { paste_in %W }
  #    $cbcol setvalue first

  proc assemble { args } {
  
    variable stp_dialog
    variable stp_dialog_vars
    variable core_frame
    variable core_list_display_num
    variable stp_dialog_vars
    
    package require BWidget
    init_tk
    
    set stp_dialog [Dialog .stp_dialog -modal local -side bottom -anchor e \
      -title "Generate SignalTap II File" -cancel 1 -transient yes -parent .]
    $stp_dialog add -name close -width 10
    
    set f [$stp_dialog getframe]
    
    # The XML input file widget
    set ifl [label $f.ifl -text "XML Template File:"]
    set ife [Entry $f.ife -textvariable [namespace which -variable stp_dialog_vars](input_file)]
    set ifb [Button $f.ifb -text "..." -command [namespace code pop_open]]
    grid $ifl $ife $ifb
    grid $ife -sticky ew
    
    # The IP core mapping
    set iptf [TitleFrame $f.iptf -text "IP Core Mapping"]
    grid $iptf - - -sticky ewns
    set ipf [$iptf getframe]
    pack $ipf -fill both -expand true
    set ipfl [label $ipf.l -text "The SignalTap II instance you generate\
      will tap signals in the following IP cores.\
      \nChoose the appropriate instance for each IP core name."]
    pack $ipfl -side top -anchor nw
    set ipsw [ScrolledWindow $ipf.sw]
    pack $ipsw -side top -fill both -expand true
    set core_sf [ScrollableFrame $ipsw.f -constrainedwidth true]
    $ipsw setwidget $core_sf
    set core_frame [$core_sf getframe]
#    $core_frame config -bg yellow
        
    # The STP output file widget
    set ofl [label $f.ofl -text "SignalTap II File:"]
    set ofe [Entry $f.ofe -textvariable [namespace which -variable stp_dialog_vars](output_file)]
    set ofb [Button $f.ofb -text "..." -command [namespace code pop_save]]
    grid $ofl $ofe $ofb
    grid $ofe -sticky ew
      
    grid [frame $f.bottom] - -
    # pack [frame $f.bottom] -side top -fill both -expand true
    
    grid columnconfigure $f 1 -weight 1
    grid rowconfigure $f 1 -weight 1
    
    wm protocol .stp_dialog WM_DELETE_WINDOW [list $stp_dialog enddialog 0]  
  }

  ##############################################################################
  proc assemble_picker_only { args } {
  
    variable stp_dialog
    variable core_frame
    variable core_list_display_num
    
    package require BWidget
    init_tk
    
    catch { destroy .stp_dialog }
    set stp_dialog [Dialog .stp_dialog -modal local -side bottom -anchor e \
      -title "Choose IP Core Instances for SignalTap II File" -default 0 \
      -cancel 1 -transient yes -parent .]
    $stp_dialog add -text OK -width 10
    $stp_dialog add -text Cancel -width 10
    
    set f [$stp_dialog getframe]
    
    # The IP core mapping
    set iptf [TitleFrame $f.iptf -text "IP Core Mapping"]
    grid $iptf - - -sticky ewns
    set ipf [$iptf getframe]
    pack $ipf -fill both -expand true
    set ipfl [label $ipf.l -text "The SignalTap II instance you generate\
      will tap signals in the following IP cores.\
      \nChoose the appropriate instance for each IP core name."]
    pack $ipfl -side top -anchor nw
    set ipsw [ScrolledWindow $ipf.sw]
    pack $ipsw -side top -fill both -expand true
    set core_sf [ScrollableFrame $ipsw.f -constrainedwidth true]
    $ipsw setwidget $core_sf
    set core_frame [$core_sf getframe]
#    $core_frame config -bg yellow
              
    grid [frame $f.bottom] - -
    # pack [frame $f.bottom] -side top -fill both -expand true
    
    grid columnconfigure $f 1 -weight 1
    grid rowconfigure $f 1 -weight 1
    
    wm protocol .stp_dialog WM_DELETE_WINDOW [list $stp_dialog enddialog 1]  
  }
  
  ################################################################################
  proc display { args } {  
    return [.stp_dialog draw]
  }

  ################################################################################
  proc pop_open { args } {  
    variable stp_dialog_vars
    set result [tk_getOpenFile -filetypes {{"XML Files" {".xml" ".XML"}}} \
      -initialfile $stp_dialog_vars(input_file) -parent .stp_dialog]
    if { ! [string equal "" $result] } {
      set stp_dialog_vars(input_file) $result
      # Read the XML file and update the success/error status
      if { [catch { read_xml } res] } {
        # Pop an error dialog or post a message
        # Can't continue after this
      }
    }
    
  }

  ################################################################################
  proc pop_save { args } {
    variable stp_dialog_vars  
    set result [tk_getSaveFile -filetypes {{"SignalTap II Files" {".stp" ".STP"}}} \
      -initialfile $stp_dialog_vars(output_file) -parent .stp_dialog]
    if { ! [string equal "" $result] } {
      set stp_dialog_vars(output_file) $result
    }
  }

  ################################################################################
  # Call read_xml whenever user chooses an input file
  # If it comes back with an error, the dom has to be invalidated
  # Pop return errors as dialog box in GUI mode or post_messages in script mode
  proc read_xml { args } {
  
    variable stp_dialog_vars
    variable dom
        
    if { [string equal "" $stp_dialog_vars(input_file)] } {
      return -code error "A file name is required"
    }
    
    if { ! [file exists $stp_dialog_vars(input_file)] } {
      return -code error "File not found: ${stp_dialog_vars(input_file)}"
    }
    
    if { [catch { open $stp_dialog_vars(input_file)} fh] } {
      return -code error "Error opening file: ${fh}"
    }
    
    if { [catch {read $fh} xml_content] } {
      catch { close $fh }
      return -code error "Error reading file: ${xml_content}"
    }
    
    catch { close $fh }
    
    if { [catch {::dom::parse $xml_content} xml_dom] } {
      return -code error "Error parsing ${stp_dialog_vars(input_file)}: ${xml_dom}"
    }
  
    set dom $xml_dom
  }
  
  ##############################################################################
  proc build_map { args } {
  
    variable dom
    
    # Get the things that need to be updated in the STP
    # Keys are the placeholder strings for replacement, values are the ip core
    # names
    set placeholder_to_ip_core_name [get_name_replacement_dict -dom $dom]

    # Invert the dict so the keys are the ip core names and the values
    # are a list of the placeholder(s) for that core instance.
    set ip_core_name_to_placeholders [dict create] 
    dict for { placeholder ip_core_name } $placeholder_to_ip_core_name {
      dict lappend ip_core_name_to_placeholders $ip_core_name $placeholder
    }
    
    # Match up the ip core names with what is in the design
    # Key is an ip core name, value is a list of the instances of that core
    # in this design
    set ip_core_name_to_instances [dict create]
    foreach ip_core_name [dict keys $ip_core_name_to_placeholders] {
      set instances_of_ip_core [get_ip_info -instances_from_name $ip_core_name]
      dict set ip_core_name_to_instances $ip_core_name $instances_of_ip_core
    }
    
    # Validate that there are instances in this design for all the cores
    # in the STP
    # Sometimes, the IP core name is wrong
    set missing_cores [list]
    dict for { ip_core_name instances } $ip_core_name_to_instances {
      if {0 ==  [llength $instances] } {
        lappend missing_cores $ip_core_name
      }
    }
    if { 0 < [llength $missing_cores] } {
      post_message -type error "The SignalTap II file could not be generated\
        because some IP cores in it were not found in your design" \
        -submsgs $missing_cores
      return
    }
    
    # The number of values per key in ip_core_name_to_instances must be
    # greater than or equal to the number of values per same key in
    # ip_core_name_to_placeholder
    # If that is not true, the target design has fewer instances of a core
    # than were put into the original STP file
    set bad_cores [list]
    dict for { ip_core_name instances } $ip_core_name_to_instances {
      set placeholders [dict get $ip_core_name_to_placeholders $ip_core_name]
      if { [llength $placeholders] > [llength $instances] } {
        lappend bad_cores $ip_core_name
      }
    }
    if { 0 < [llength $bad_cores] } {
      post_message -type error "The SignalTap II file could not be generated\
        because it includes more instances of some IP cores than are in your\
        design" -submsgs $bad_cores
      return
    }

    # If every ip core name maps to one placeholder, and every ip core name
    # maps to one instance, we can create the stp automatically, replacing
    # each placeholder with the corresponding instance.
    # Otherwise we need user intervention.
    
    catch { array unset temp_vars; array unset temp_map }
#    array set temp_vars [list "input_file" $opts(input_file) "output_file" \
#      $opts(output_file)]
    dict for { placeholder ip_core_name } $placeholder_to_ip_core_name {
      # What are we replacing with?
      set new_ip_core_instance [dict get $ip_core_name_to_instances $ip_core_name]
#      ui::add_core_mapping_widget -ip_core_name $ip_core_name \
#        -hier_replacement $placeholder -candidate_instances $new_ip_core_instance
      set foo [list]
      set num_replaced [adjust_hier -dom $dom -remove $placeholder \
        -insert $new_ip_core_instance -unreplaced_var foo]
      set num_clocks_replaced [adjust_hier_for_clock -dom $dom -remove $placeholder \
        -insert $new_ip_core_instance -unreplaced_var foo] 
      remove_hier_replacement_entry -dom $dom -placeholder $placeholder
      if { 0 < [llength $foo] } {
        post_message -type warning "Some node names in the SignalTap II file\
          do not exist in this design." -submsgs $foo
      }
    } 

  
  }
}
# end of ui namespace

################################################################################
proc find_toplevel_cores { args } {

  load_package report
  load_report

  # Make sure the report exists
  set ip_cores_full_panel_name "Analysis & Synthesis||Analysis & Synthesis IP Cores Summary"
  set id [get_report_panel_id $ip_cores_full_panel_name]
  if { -1 == $id } {
    post_message -type error "Can not find report panel ${ip_cores_full_panel_name}"
    return -code error
  }
  
  # Make sure the columns exist
  set ip_core_col [get_report_panel_column_index -id $id "IP Core Name"]
  set entity_instance_col [get_report_panel_column_index -id $id "Entity Instance"]
  
  if { -1 == $ip_core_col } {
    post_message -type error "Can not find IP Core Name column"
  }
  if { -1 == $entity_instance_col } {
    post_message -type error "Can not find Entity Instance column"
  }
  if { -1 == $ip_core_col || -1 == $entity_instance_col } { return -code error }
  
  # Walk through the report, checking whether the IP core name asked for
  # matches each row
  set to_return [list]
  # prev_match must start with a space - something that will not match.
  # The zero-length string will match in the regexp below
  set prev_match " "
  set num_rows [get_number_of_rows -id $id]
  for { set row 1 } { $row < $num_rows } { incr row } {
    set data [get_report_panel_row -id $id -row $row]
    set ip_core_name [lindex $data $ip_core_col]
    set entity_instance [lindex $data $entity_instance_col]
    # Take off the top-level entity name
    regsub {^\|.*?\|} $entity_instance {} entity_instance
    
    if { [regexp $prev_match $entity_instance] } {
      # This line is a sub-core of the previous match
    } else {
      lappend to_return $entity_instance
      set prev_match [string map { \[ \\\[ \] \\\] \| \\\| \\ \\\\ } \
        $entity_instance]
    }
  }
  
  unload_report
  
  return $to_return 
  
}
#main {*}$quartus(args)
if { 0 } {
      if { [string equal "" $opts(stp_file)] } {
        # If there is no file specified, prompt for one
        init_tk
        set result [tk_getSaveFile -filetypes {{"SignalTap II Files" {".stp" ".STP"}}}]
        if { [string equal "" $result] } {
          # The user cancelled, return with no action
          return
        } else {
          set output_file $result
        }
      } else {
        set output_file $opts(stp_file)
      }

}

proc test { args } {

destroy .stp_dialog
ui::assemble
ui::init_data
ui::add_core_mapping_widget -ip_core_name alt_e100 -hier_replacement 0101010101 -candidate_instances { top|fiddle top|biz top|bar|fiddle }
ui::add_core_mapping_widget -ip_core_name alt_pcie_hip -hier_replacement 01010101010 -candidate_instances { top|fiddle top|biz top|bar|fiddle }
ui::display

}