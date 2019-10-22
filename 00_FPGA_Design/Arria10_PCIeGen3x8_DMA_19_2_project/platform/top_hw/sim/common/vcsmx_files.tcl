source [file join [file dirname [info script]] ./../../../ip/top_hw/top_emif_0/sim/common/vcsmx_files.tcl]
source [file join [file dirname [info script]] ./../../../ip/top_hw/top_DUT/sim/common/vcsmx_files.tcl]
source [file join [file dirname [info script]] ./../../../ip/top_hw/top_onchip_memory2_0/sim/common/vcsmx_files.tcl]
source [file join [file dirname [info script]] ./../../../ip/top_hw/top_clk_0/sim/common/vcsmx_files.tcl]

namespace eval top_hw {
  proc get_design_libraries {} {
    set libraries [dict create]
    set libraries [dict merge $libraries [top_emif_0::get_design_libraries]]
    set libraries [dict merge $libraries [top_DUT::get_design_libraries]]
    set libraries [dict merge $libraries [top_onchip_memory2_0::get_design_libraries]]
    set libraries [dict merge $libraries [top_clk_0::get_design_libraries]]
    dict set libraries altera_merlin_master_translator_191 1
    dict set libraries altera_merlin_slave_translator_191  1
    dict set libraries altera_merlin_master_agent_191      1
    dict set libraries altera_merlin_slave_agent_191       1
    dict set libraries altera_avalon_sc_fifo_191           1
    dict set libraries altera_merlin_router_191            1
    dict set libraries altera_merlin_traffic_limiter_191   1
    dict set libraries alt_hiconnect_sc_fifo_191           1
    dict set libraries altera_merlin_burst_adapter_191     1
    dict set libraries altera_merlin_demultiplexer_191     1
    dict set libraries altera_merlin_multiplexer_191       1
    dict set libraries altera_merlin_width_adapter_191     1
    dict set libraries altera_avalon_dc_fifo_191           1
    dict set libraries altera_avalon_st_pipeline_stage_191 1
    dict set libraries altera_mm_interconnect_191          1
    dict set libraries altera_reset_controller_191         1
    dict set libraries top_hw                              1
    return $libraries
  }
  
  proc get_memory_files {QSYS_SIMDIR} {
    set memory_files [list]
    set memory_files [concat $memory_files [top_emif_0::get_memory_files "$QSYS_SIMDIR/../../ip/top_hw/top_emif_0/sim/"]]
    set memory_files [concat $memory_files [top_DUT::get_memory_files "$QSYS_SIMDIR/../../ip/top_hw/top_DUT/sim/"]]
    set memory_files [concat $memory_files [top_onchip_memory2_0::get_memory_files "$QSYS_SIMDIR/../../ip/top_hw/top_onchip_memory2_0/sim/"]]
    set memory_files [concat $memory_files [top_clk_0::get_memory_files "$QSYS_SIMDIR/../../ip/top_hw/top_clk_0/sim/"]]
    return $memory_files
  }
  
  proc get_common_design_files {USER_DEFINED_COMPILE_OPTIONS USER_DEFINED_VERILOG_COMPILE_OPTIONS USER_DEFINED_VHDL_COMPILE_OPTIONS QSYS_SIMDIR} {
    set design_files [dict create]
    set design_files [dict merge $design_files [top_emif_0::get_common_design_files $USER_DEFINED_COMPILE_OPTIONS $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_VHDL_COMPILE_OPTIONS "$QSYS_SIMDIR/../../ip/top_hw/top_emif_0/sim/"]]
    set design_files [dict merge $design_files [top_DUT::get_common_design_files $USER_DEFINED_COMPILE_OPTIONS $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_VHDL_COMPILE_OPTIONS "$QSYS_SIMDIR/../../ip/top_hw/top_DUT/sim/"]]
    set design_files [dict merge $design_files [top_onchip_memory2_0::get_common_design_files $USER_DEFINED_COMPILE_OPTIONS $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_VHDL_COMPILE_OPTIONS "$QSYS_SIMDIR/../../ip/top_hw/top_onchip_memory2_0/sim/"]]
    set design_files [dict merge $design_files [top_clk_0::get_common_design_files $USER_DEFINED_COMPILE_OPTIONS $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_VHDL_COMPILE_OPTIONS "$QSYS_SIMDIR/../../ip/top_hw/top_clk_0/sim/"]]
    return $design_files
  }
  
  proc get_design_files {USER_DEFINED_COMPILE_OPTIONS USER_DEFINED_VERILOG_COMPILE_OPTIONS USER_DEFINED_VHDL_COMPILE_OPTIONS QSYS_SIMDIR} {
    set design_files [list]
    set design_files [concat $design_files [top_emif_0::get_design_files $USER_DEFINED_COMPILE_OPTIONS $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_VHDL_COMPILE_OPTIONS "$QSYS_SIMDIR/../../ip/top_hw/top_emif_0/sim/"]]
    set design_files [concat $design_files [top_DUT::get_design_files $USER_DEFINED_COMPILE_OPTIONS $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_VHDL_COMPILE_OPTIONS "$QSYS_SIMDIR/../../ip/top_hw/top_DUT/sim/"]]
    set design_files [concat $design_files [top_onchip_memory2_0::get_design_files $USER_DEFINED_COMPILE_OPTIONS $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_VHDL_COMPILE_OPTIONS "$QSYS_SIMDIR/../../ip/top_hw/top_onchip_memory2_0/sim/"]]
    set design_files [concat $design_files [top_clk_0::get_design_files $USER_DEFINED_COMPILE_OPTIONS $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_VHDL_COMPILE_OPTIONS "$QSYS_SIMDIR/../../ip/top_hw/top_clk_0/sim/"]]
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_merlin_master_translator_191/sim/top_hw_altera_merlin_master_translator_191_g7h47bq.sv\"  -work altera_merlin_master_translator_191"
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_merlin_slave_translator_191/sim/top_hw_altera_merlin_slave_translator_191_x56fcki.sv\"  -work altera_merlin_slave_translator_191"   
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_merlin_master_agent_191/sim/top_hw_altera_merlin_master_agent_191_mpbm6tq.sv\"  -work altera_merlin_master_agent_191"               
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_merlin_slave_agent_191/sim/top_hw_altera_merlin_slave_agent_191_ncfkfri.sv\"  -work altera_merlin_slave_agent_191"                  
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_merlin_slave_agent_191/sim/altera_merlin_burst_uncompressor.sv\"  -work altera_merlin_slave_agent_191"                              
    lappend design_files "vlogan +v2k $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_avalon_sc_fifo_191/sim/top_hw_altera_avalon_sc_fifo_191_e5eqkcq.v\"  -work altera_avalon_sc_fifo_191"                                         
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_merlin_router_191/sim/top_hw_altera_merlin_router_191_6xefe7y.sv\"  -work altera_merlin_router_191"                                 
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_merlin_router_191/sim/top_hw_altera_merlin_router_191_m64leea.sv\"  -work altera_merlin_router_191"                                 
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_merlin_router_191/sim/top_hw_altera_merlin_router_191_4hnp2yy.sv\"  -work altera_merlin_router_191"                                 
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_merlin_router_191/sim/top_hw_altera_merlin_router_191_tjsusja.sv\"  -work altera_merlin_router_191"                                 
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_merlin_router_191/sim/top_hw_altera_merlin_router_191_svxrzci.sv\"  -work altera_merlin_router_191"                                 
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_merlin_router_191/sim/top_hw_altera_merlin_router_191_u6cxpni.sv\"  -work altera_merlin_router_191"                                 
    lappend design_files "vlogan +v2k $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_merlin_traffic_limiter_191/sim/top_hw_altera_merlin_traffic_limiter_191_fakurfy.v\"  -work altera_merlin_traffic_limiter_191"                 
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../alt_hiconnect_sc_fifo_191/sim/top_hw_alt_hiconnect_sc_fifo_191_7qtmpqq.sv\"  -work alt_hiconnect_sc_fifo_191"                              
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../alt_hiconnect_sc_fifo_191/sim/alt_st_infer_scfifo.sv\"  -work alt_hiconnect_sc_fifo_191"                                                   
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../alt_hiconnect_sc_fifo_191/sim/alt_st_mlab_scfifo.sv\"  -work alt_hiconnect_sc_fifo_191"                                                    
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../alt_hiconnect_sc_fifo_191/sim/alt_st_fifo_empty.sv\"  -work alt_hiconnect_sc_fifo_191"                                                     
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../alt_hiconnect_sc_fifo_191/sim/alt_st_mlab_scfifo_a6.sv\"  -work alt_hiconnect_sc_fifo_191"                                                 
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../alt_hiconnect_sc_fifo_191/sim/alt_st_mlab_scfifo_a7.sv\"  -work alt_hiconnect_sc_fifo_191"                                                 
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../alt_hiconnect_sc_fifo_191/sim/alt_st_reg_scfifo.sv\"  -work alt_hiconnect_sc_fifo_191"                                                     
    lappend design_files "vlogan +v2k $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_merlin_traffic_limiter_191/sim/top_hw_altera_merlin_traffic_limiter_191_2coyymi.v\"  -work altera_merlin_traffic_limiter_191"                 
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_merlin_traffic_limiter_191/sim/altera_merlin_reorder_memory.sv\"  -work altera_merlin_traffic_limiter_191"                          
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_merlin_traffic_limiter_191/sim/altera_avalon_st_pipeline_base.v\"  -work altera_merlin_traffic_limiter_191"                         
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_merlin_traffic_limiter_191/sim/top_hw_altera_merlin_traffic_limiter_191_kcba44q.sv\"  -work altera_merlin_traffic_limiter_191"      
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_merlin_burst_adapter_191/sim/top_hw_altera_merlin_burst_adapter_191_7422xpi.sv\"  -work altera_merlin_burst_adapter_191"            
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_merlin_burst_adapter_191/sim/altera_merlin_burst_adapter_uncmpr.sv\"  -work altera_merlin_burst_adapter_191"                        
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_merlin_burst_adapter_191/sim/altera_merlin_burst_adapter_13_1.sv\"  -work altera_merlin_burst_adapter_191"                          
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_merlin_burst_adapter_191/sim/altera_merlin_burst_adapter_new.sv\"  -work altera_merlin_burst_adapter_191"                           
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_merlin_burst_adapter_191/sim/altera_incr_burst_converter.sv\"  -work altera_merlin_burst_adapter_191"                               
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_merlin_burst_adapter_191/sim/altera_wrap_burst_converter.sv\"  -work altera_merlin_burst_adapter_191"                               
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_merlin_burst_adapter_191/sim/altera_default_burst_converter.sv\"  -work altera_merlin_burst_adapter_191"                            
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_merlin_burst_adapter_191/sim/altera_merlin_address_alignment.sv\"  -work altera_merlin_burst_adapter_191"                           
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_merlin_burst_adapter_191/sim/altera_avalon_st_pipeline_stage.sv\"  -work altera_merlin_burst_adapter_191"                           
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_merlin_burst_adapter_191/sim/altera_avalon_st_pipeline_base.v\"  -work altera_merlin_burst_adapter_191"                             
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_merlin_demultiplexer_191/sim/top_hw_altera_merlin_demultiplexer_191_2v5jvsa.sv\"  -work altera_merlin_demultiplexer_191"            
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_merlin_demultiplexer_191/sim/top_hw_altera_merlin_demultiplexer_191_mozyuqi.sv\"  -work altera_merlin_demultiplexer_191"            
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_merlin_demultiplexer_191/sim/top_hw_altera_merlin_demultiplexer_191_bggfk5a.sv\"  -work altera_merlin_demultiplexer_191"            
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_merlin_multiplexer_191/sim/top_hw_altera_merlin_multiplexer_191_4ow47rq.sv\"  -work altera_merlin_multiplexer_191"                  
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_merlin_multiplexer_191/sim/altera_merlin_arbitrator.sv\"  -work altera_merlin_multiplexer_191"                                      
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_merlin_multiplexer_191/sim/top_hw_altera_merlin_multiplexer_191_hgsyksi.sv\"  -work altera_merlin_multiplexer_191"                  
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_merlin_multiplexer_191/sim/altera_merlin_arbitrator.sv\"  -work altera_merlin_multiplexer_191"                                      
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_merlin_multiplexer_191/sim/top_hw_altera_merlin_multiplexer_191_ku3jpgy.sv\"  -work altera_merlin_multiplexer_191"                  
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_merlin_multiplexer_191/sim/altera_merlin_arbitrator.sv\"  -work altera_merlin_multiplexer_191"                                      
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_merlin_demultiplexer_191/sim/top_hw_altera_merlin_demultiplexer_191_hzqd6da.sv\"  -work altera_merlin_demultiplexer_191"            
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_merlin_demultiplexer_191/sim/top_hw_altera_merlin_demultiplexer_191_gbjax7a.sv\"  -work altera_merlin_demultiplexer_191"            
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_merlin_multiplexer_191/sim/top_hw_altera_merlin_multiplexer_191_pj2odpy.sv\"  -work altera_merlin_multiplexer_191"                  
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_merlin_multiplexer_191/sim/altera_merlin_arbitrator.sv\"  -work altera_merlin_multiplexer_191"                                      
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_merlin_multiplexer_191/sim/top_hw_altera_merlin_multiplexer_191_lrmpvga.sv\"  -work altera_merlin_multiplexer_191"                  
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_merlin_multiplexer_191/sim/altera_merlin_arbitrator.sv\"  -work altera_merlin_multiplexer_191"                                      
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_merlin_multiplexer_191/sim/top_hw_altera_merlin_multiplexer_191_25cmumq.sv\"  -work altera_merlin_multiplexer_191"                  
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_merlin_multiplexer_191/sim/altera_merlin_arbitrator.sv\"  -work altera_merlin_multiplexer_191"                                      
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_merlin_width_adapter_191/sim/top_hw_altera_merlin_width_adapter_191_i6xyepy.sv\"  -work altera_merlin_width_adapter_191"            
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_merlin_width_adapter_191/sim/altera_merlin_address_alignment.sv\"  -work altera_merlin_width_adapter_191"                           
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_merlin_width_adapter_191/sim/altera_merlin_burst_uncompressor.sv\"  -work altera_merlin_width_adapter_191"                          
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_merlin_width_adapter_191/sim/top_hw_altera_merlin_width_adapter_191_ff67b3i.sv\"  -work altera_merlin_width_adapter_191"            
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_merlin_width_adapter_191/sim/altera_merlin_address_alignment.sv\"  -work altera_merlin_width_adapter_191"                           
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_merlin_width_adapter_191/sim/altera_merlin_burst_uncompressor.sv\"  -work altera_merlin_width_adapter_191"                          
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_merlin_width_adapter_191/sim/top_hw_altera_merlin_width_adapter_191_op7abui.sv\"  -work altera_merlin_width_adapter_191"            
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_merlin_width_adapter_191/sim/altera_merlin_address_alignment.sv\"  -work altera_merlin_width_adapter_191"                           
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_merlin_width_adapter_191/sim/altera_merlin_burst_uncompressor.sv\"  -work altera_merlin_width_adapter_191"                          
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_merlin_width_adapter_191/sim/top_hw_altera_merlin_width_adapter_191_jigh62i.sv\"  -work altera_merlin_width_adapter_191"            
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_merlin_width_adapter_191/sim/altera_merlin_address_alignment.sv\"  -work altera_merlin_width_adapter_191"                           
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_merlin_width_adapter_191/sim/altera_merlin_burst_uncompressor.sv\"  -work altera_merlin_width_adapter_191"                          
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_merlin_width_adapter_191/sim/top_hw_altera_merlin_width_adapter_191_zevtati.sv\"  -work altera_merlin_width_adapter_191"            
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_merlin_width_adapter_191/sim/altera_merlin_address_alignment.sv\"  -work altera_merlin_width_adapter_191"                           
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_merlin_width_adapter_191/sim/altera_merlin_burst_uncompressor.sv\"  -work altera_merlin_width_adapter_191"                          
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_merlin_width_adapter_191/sim/top_hw_altera_merlin_width_adapter_191_6qisuny.sv\"  -work altera_merlin_width_adapter_191"            
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_merlin_width_adapter_191/sim/altera_merlin_address_alignment.sv\"  -work altera_merlin_width_adapter_191"                           
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_merlin_width_adapter_191/sim/altera_merlin_burst_uncompressor.sv\"  -work altera_merlin_width_adapter_191"                          
    lappend design_files "vlogan +v2k $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_avalon_dc_fifo_191/sim/top_hw_altera_avalon_dc_fifo_191_7gx45aq.v\"  -work altera_avalon_dc_fifo_191"                                         
    lappend design_files "vlogan +v2k $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_avalon_dc_fifo_191/sim/altera_dcfifo_synchronizer_bundle.v\"  -work altera_avalon_dc_fifo_191"                                                
    lappend design_files "vlogan +v2k $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_avalon_dc_fifo_191/sim/altera_std_synchronizer_nocut.v\"  -work altera_avalon_dc_fifo_191"                                                    
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_avalon_st_pipeline_stage_191/sim/altera_avalon_st_pipeline_stage.sv\"  -work altera_avalon_st_pipeline_stage_191"                   
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_avalon_st_pipeline_stage_191/sim/altera_avalon_st_pipeline_base.v\"  -work altera_avalon_st_pipeline_stage_191"                     
    lappend design_files "vlogan +v2k $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_mm_interconnect_191/sim/top_hw_altera_mm_interconnect_191_scrfrry.v\"  -work altera_mm_interconnect_191"                                      
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_merlin_router_191/sim/top_hw_altera_merlin_router_191_ghvit4y.sv\"  -work altera_merlin_router_191"                                 
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_merlin_router_191/sim/top_hw_altera_merlin_router_191_allu66q.sv\"  -work altera_merlin_router_191"                                 
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_merlin_demultiplexer_191/sim/top_hw_altera_merlin_demultiplexer_191_r6ta55q.sv\"  -work altera_merlin_demultiplexer_191"            
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_merlin_multiplexer_191/sim/top_hw_altera_merlin_multiplexer_191_kmkxadi.sv\"  -work altera_merlin_multiplexer_191"                  
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_merlin_multiplexer_191/sim/altera_merlin_arbitrator.sv\"  -work altera_merlin_multiplexer_191"                                      
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_merlin_demultiplexer_191/sim/top_hw_altera_merlin_demultiplexer_191_uowkhiq.sv\"  -work altera_merlin_demultiplexer_191"            
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_merlin_multiplexer_191/sim/top_hw_altera_merlin_multiplexer_191_vxddwui.sv\"  -work altera_merlin_multiplexer_191"                  
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_merlin_multiplexer_191/sim/altera_merlin_arbitrator.sv\"  -work altera_merlin_multiplexer_191"                                      
    lappend design_files "vlogan +v2k $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_mm_interconnect_191/sim/top_hw_altera_mm_interconnect_191_3pabmzq.v\"  -work altera_mm_interconnect_191"                                      
    lappend design_files "vlogan +v2k $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_reset_controller_191/sim/altera_reset_controller.v\"  -work altera_reset_controller_191"                                                      
    lappend design_files "vlogan +v2k $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_reset_controller_191/sim/altera_reset_synchronizer.v\"  -work altera_reset_controller_191"                                                    
    lappend design_files "vlogan +v2k $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/top_hw.v\"  -work top_hw"                                                                                                                               
    return $design_files
  }
  
  proc get_elab_options {SIMULATOR_TOOL_BITNESS} {
    set ELAB_OPTIONS ""
    append ELAB_OPTIONS [top_emif_0::get_elab_options $SIMULATOR_TOOL_BITNESS]
    append ELAB_OPTIONS [top_DUT::get_elab_options $SIMULATOR_TOOL_BITNESS]
    append ELAB_OPTIONS [top_onchip_memory2_0::get_elab_options $SIMULATOR_TOOL_BITNESS]
    append ELAB_OPTIONS [top_clk_0::get_elab_options $SIMULATOR_TOOL_BITNESS]
    if ![ string match "bit_64" $SIMULATOR_TOOL_BITNESS ] {
    } else {
    }
    return $ELAB_OPTIONS
  }
  
  
  proc get_sim_options {SIMULATOR_TOOL_BITNESS} {
    set SIM_OPTIONS ""
    append SIM_OPTIONS [top_emif_0::get_sim_options $SIMULATOR_TOOL_BITNESS]
    append SIM_OPTIONS [top_DUT::get_sim_options $SIMULATOR_TOOL_BITNESS]
    append SIM_OPTIONS [top_onchip_memory2_0::get_sim_options $SIMULATOR_TOOL_BITNESS]
    append SIM_OPTIONS [top_clk_0::get_sim_options $SIMULATOR_TOOL_BITNESS]
    if ![ string match "bit_64" $SIMULATOR_TOOL_BITNESS ] {
    } else {
    }
    return $SIM_OPTIONS
  }
  
  
  proc get_env_variables {SIMULATOR_TOOL_BITNESS} {
    set ENV_VARIABLES [dict create]
    set LD_LIBRARY_PATH [dict create]
    set LD_LIBRARY_PATH [dict merge $LD_LIBRARY_PATH [dict get [top_emif_0::get_env_variables $SIMULATOR_TOOL_BITNESS] "LD_LIBRARY_PATH"]]
    set LD_LIBRARY_PATH [dict merge $LD_LIBRARY_PATH [dict get [top_DUT::get_env_variables $SIMULATOR_TOOL_BITNESS] "LD_LIBRARY_PATH"]]
    set LD_LIBRARY_PATH [dict merge $LD_LIBRARY_PATH [dict get [top_onchip_memory2_0::get_env_variables $SIMULATOR_TOOL_BITNESS] "LD_LIBRARY_PATH"]]
    set LD_LIBRARY_PATH [dict merge $LD_LIBRARY_PATH [dict get [top_clk_0::get_env_variables $SIMULATOR_TOOL_BITNESS] "LD_LIBRARY_PATH"]]
    dict set ENV_VARIABLES "LD_LIBRARY_PATH" $LD_LIBRARY_PATH
    if ![ string match "bit_64" $SIMULATOR_TOOL_BITNESS ] {
    } else {
    }
    return $ENV_VARIABLES
  }
  
  
}
