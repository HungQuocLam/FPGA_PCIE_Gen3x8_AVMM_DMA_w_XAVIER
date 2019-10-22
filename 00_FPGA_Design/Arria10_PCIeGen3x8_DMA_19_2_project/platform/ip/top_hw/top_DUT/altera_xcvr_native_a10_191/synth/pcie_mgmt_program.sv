// (C) 2001-2019 Intel Corporation. All rights reserved.
// Your use of Intel Corporation's design tools, logic functions and other 
// software and tools, and its AMPP partner logic functions, and any output 
// files from any of the foregoing (including device programming or simulation 
// files), and any associated documentation or information are expressly subject 
// to the terms and conditions of the Intel Program License Subscription 
// Agreement, Intel FPGA IP License Agreement, or other applicable 
// license agreement, including, without limitation, that your use is for the 
// sole purpose of programming logic devices manufactured by Intel and sold by 
// Intel or its authorized distributors.  Please refer to the applicable 
// agreement for further details.


// Revision 2.0
package pcie_mgmt_program;

  import pcie_mgmt_functions_h::*;
  import pcie_mgmt_commands_h::*;
  import altera_xcvr_native_pcie_dfe_params_h::*;

  task automatic pcie_mgmt_program;
  ref prom_struct_t prom_set;
  begin
    // Read the calibration status
    f_sleep                     (SLEEP_DELAY, prom_set);
    f_read_reg                  (ADDR_CALIBRATION, prom_set);

    //////////////////////////////////////////////////////////
    // All for-loops are done via handshake from the CPU to the SM
    // This way, the loops can be parameterized via channel, and 
    // the looping won't require adding a new reg to the memory
    //
    // ** IMPORTANT **
    //  Don't know what I'm going to put here yet, but there has
    //  to be something important, right?
    //////////////////////////////////////////////////////////
    f_label                     (PRGM_BEGIN, prom_set);

    // Clear all pio_out
    f_write_pio_bit             (PIO_OUT_ERROR,0, prom_set);
    f_write_pio_bit             (PIO_OUT_RUNNING,0, prom_set);
    f_write_pio_bit             (PIO_OUT_SW_GEN_1_2,0, prom_set);
    f_write_pio_bit             (PIO_OUT_SW_GEN_3,0, prom_set);
    f_write_pio_bit             (PIO_OUT_PHASE2_CTLE,0, prom_set);
    f_write_pio_bit             (PIO_OUT_PHASE2_DFE,0, prom_set);
    f_write_pio_bit             (PIO_OUT_RESTORE_MODEB,0, prom_set);
    
    // Set Tag for beginning of program
    f_load_result               (32'b0, prom_set);          //  Since the address store works off of r0... set r0 first
    f_store_mem_address         (prom_set);               //  Store r0 into the mem address

    // Begin!
    // First check for the "Go!"
    // We hit the Go! - Set a bit to indicate SM is running
    f_wait_for_pio_bit          (PIO_IN_GO, 1, prom_set);


    //////////////////////////////////////////////////////////
    // Decode the incoming PIO to determine which steps to run
    // then jump to the correct section of the code.  If none
    // of the bits are asserted, then assert the error bit
    // and go to the beginning of the program
    //////////////////////////////////////////////////////////
    // Read PIO[1] - Are We rate switching to Gen3
    f_read_pio_bit              (PIO_IN_SW_GEN_3, prom_set);

    // Jump!
    f_jump_not_equal_zero       (PRGM_SW_GEN3, prom_set);


    //////////////////////////////////////////////////////////
    // Read PIO[2] - Are we entering Phase 2 Equalization; check ctle
    f_read_pio_bit              (PIO_IN_PHASE2_CTLE, prom_set);

    // Jump!
    f_jump_not_equal_zero       (PRGM_PHASE2_CTLE, prom_set);


    //////////////////////////////////////////////////////////
    // Read PIO[2] - Are we entering Phase 2 Equalization; run DFE
    f_read_pio_bit              (PIO_IN_PHASE2_DFE, prom_set);

    // Jump!
    f_jump_not_equal_zero       (PRGM_PHASE2_DFE, prom_set);


    //////////////////////////////////////////////////////////
    // Read PIO[3] - Are we returning to Gen1/2
    f_read_pio_bit              (PIO_IN_SW_GEN_1_2, prom_set);

    // Jump!
    f_jump_not_equal_zero       (PRGM_SW_GEN1_2, prom_set);

    //////////////////////////////////////////////////////////
    // Read PIO[3] - Are we returning to Gen1/2
    f_read_pio_bit              (PIO_IN_RESTORE_MODEB, prom_set);

    // Jump!
    f_jump_not_equal_zero       (PRGM_RESTORE_MODEB, prom_set);


    //////////////////////////////////////////////////////////
    // None of the PIO were asserted... we have an error
    f_write_pio_bit             (PIO_OUT_ERROR,1, prom_set);
    f_sleep                     (SLEEP_DELAY, prom_set);
    f_write_pio_bit             (PIO_OUT_ERROR,0, prom_set);

    // Return to the beginning
    f_load_result               (FORCE_JUMP, prom_set);
    f_jump_not_equal_zero       (PRGM_BEGIN, prom_set);


    //////////////////////////////////////////////////////////
    // Code for returning to Gen1/2.  The CTLE values are hard
    // coded.  We want to first assert the signal to indicate
    // we are switching back.  We can use this to verify the
    // jump and the code.  At the end of the 
    //////////////////////////////////////////////////////////
    // We made it this far... we must be returning to Gen1/2
    // Code for entering Gen1/2
    f_label                     (PRGM_SW_GEN1_2, prom_set);

    // Assert the signal to indicate we are running Gen1/2 switch
    f_write_pio_bit             (PIO_OUT_SW_GEN_1_2,1, prom_set);
    f_write_pio_bit             (PIO_OUT_RUNNING,1, prom_set);

    //<-- Put Code Here -->//
      f_read_reg                (31'h167, prom_set);
      f_modify_reg              (32'h3E, GEN1_GEN2_CTLE_VAL, prom_set);
      f_write_result_to_reg     (31'h167, prom_set);

      // Clear all DFE Taps
      // Read second address for a channel... DFE Tap 1
      f_read_reg                (32'h14F, prom_set);
      f_modify_reg              (32'hFF, 32'h00, prom_set);
      f_write_result_to_reg     (32'h14F, prom_set);

      // Read second address for a channel... DFE Tap 2
      f_read_reg                (32'h150, prom_set);
      f_modify_reg              (32'hFF, 32'h00, prom_set);
      f_write_result_to_reg     (32'h150, prom_set);

      // Read second address for a channel... DFE Tap 3
      f_read_reg                (32'h151, prom_set);
      f_modify_reg              (32'hFF, 32'h00, prom_set);
      f_write_result_to_reg     (32'h151, prom_set);

      // Read second address for a channel... DFE Tap 4
      f_read_reg                (32'h152, prom_set);
      f_modify_reg              (32'h7F, 32'h00, prom_set);
      f_write_result_to_reg     (32'h152, prom_set);

      // Read second address for a channel... DFE Tap 5
      f_read_reg                (32'h153, prom_set);
      f_modify_reg              (32'h7F, 32'h00, prom_set);
      f_write_result_to_reg     (32'h153, prom_set);

      // Read second address for a channel... DFE Tap 6
      f_read_reg                (32'h154, prom_set);
      f_modify_reg              (32'h3F, 32'h00, prom_set);
      f_write_result_to_reg     (32'h154, prom_set);

      // Read second address for a channel... DFE Tap 7
      f_read_reg                (32'h155, prom_set);
      f_modify_reg              (32'h3F, 32'h00, prom_set);
      f_write_result_to_reg     (32'h155, prom_set);

      // Read second address for a channel... DFE Tap 8
      f_read_reg                (32'h157, prom_set);
      f_modify_reg              (32'h7F, 32'h00, prom_set);
      f_write_result_to_reg     (32'h157, prom_set);

      // Read second address for a channel... DFE Tap 9
      f_read_reg                (32'h158, prom_set);
      f_modify_reg              (32'h7F, 32'h00, prom_set);
      f_write_result_to_reg     (32'h158, prom_set);

      // Read second address for a channel... DFE Tap 10
      f_read_reg                (32'h159, prom_set);
      f_modify_reg              (32'h7F, 32'h00, prom_set);
      f_write_result_to_reg     (32'h159, prom_set);

      // Read second address for a channel... DFE Tap 11
      f_read_reg                (32'h15A, prom_set);
      f_modify_reg              (32'h7F, 32'h00, prom_set);
      f_write_result_to_reg     (32'h15A, prom_set);

    //<-- End Code Here -->//

    // Indicate channel is done
    f_write_pio_bit             (PIO_OUT_RUNNING,0, prom_set);

    // If PIO_IN_GO isn't low, then we havn't completed all channels.  Repeat
    f_sleep                     (SLEEP_DELAY, prom_set);
    f_read_pio_bit              (PIO_IN_GO, prom_set);
    f_jump_not_equal_zero       (PRGM_SW_GEN1_2, prom_set);

    // Return to Beginning
    f_load_result               (FORCE_JUMP, prom_set);
    f_jump_not_equal_zero       (PRGM_BEGIN, prom_set);


    //////////////////////////////////////////////////////////
    // Code for entering Gen3
    // When entering Gen3, restore the DFE settings from the mem
    //////////////////////////////////////////////////////////
    // We made it this far... we must be returning to Gen1/2
    f_label                     (PRGM_SW_GEN3, prom_set);

    // Assert the signal to indicate we are switching to Gen3
    f_write_pio_bit             (PIO_OUT_SW_GEN_3,1, prom_set);
    f_write_pio_bit             (PIO_OUT_RUNNING,1, prom_set);

    //<-- Put Code Here -->//
      // Reading from the first address for a channel... CTLE value
      f_read_reg                  (32'h167, prom_set);
      f_convert_ctle              (prom_set);
      f_write_result_to_reg       (32'h167, prom_set);
      f_inc_mem_address           (prom_set);

      // Read second address for a channel... DFE Tap 1
      f_read_reg                  (32'h14F, prom_set);
      f_modify_reg                (32'hFF, 32'h00, prom_set);
      //f_mod_mem_value             (32'hFF, prom_set);
      f_write_result_to_reg       (32'h14F, prom_set);
      f_inc_mem_address           (prom_set);

      // Read second address for a channel... DFE Tap 2
      f_read_reg                  (32'h150, prom_set);
      f_mod_mem_value             (32'hFF, prom_set);
      f_write_result_to_reg       (32'h150, prom_set);
      f_inc_mem_address           (prom_set);

      // Read second address for a channel... DFE Tap 3
      f_read_reg                  (32'h151, prom_set);
      f_mod_mem_value             (32'hFF, prom_set);
      f_write_result_to_reg       (32'h151, prom_set);
      f_inc_mem_address           (prom_set);

      // Read second address for a channel... DFE Tap 4
      f_read_reg                  (32'h152, prom_set);
      f_mod_mem_value             (32'h7F, prom_set);
      f_write_result_to_reg       (32'h152, prom_set);
      f_inc_mem_address           (prom_set);

      // Read second address for a channel... DFE Tap 5
      f_read_reg                  (32'h153, prom_set);
      f_mod_mem_value             (32'h7F, prom_set);
      f_write_result_to_reg       (32'h153, prom_set);
      f_inc_mem_address           (prom_set);

      // Read second address for a channel... DFE Tap 6
      f_read_reg                  (32'h154, prom_set);
      f_mod_mem_value             (32'h3F, prom_set);
      f_write_result_to_reg       (32'h154, prom_set);
      f_inc_mem_address           (prom_set);

      // Read second address for a channel... DFE Tap 7
      f_read_reg                  (32'h155, prom_set);
      f_mod_mem_value             (32'h3F, prom_set);
      f_write_result_to_reg       (32'h155, prom_set);
      f_inc_mem_address           (prom_set);

      // Read second address for a channel... DFE Tap 8
      f_read_reg                  (32'h157, prom_set);
      f_mod_mem_value             (32'h7F, prom_set);
      f_write_result_to_reg       (32'h157, prom_set);
      f_inc_mem_address           (prom_set);

      // Read second address for a channel... DFE Tap 9
      f_read_reg                  (32'h158, prom_set);
      f_mod_mem_value             (32'h7F, prom_set);
      f_write_result_to_reg       (32'h158, prom_set);
      f_inc_mem_address           (prom_set);

      // Read second address for a channel... DFE Tap 10
      f_read_reg                  (32'h159, prom_set);
      f_mod_mem_value             (32'h7F, prom_set);
      f_write_result_to_reg       (32'h159, prom_set);
      f_inc_mem_address           (prom_set);

      // Read second address for a channel... DFE Tap 11
      f_read_reg                  (32'h15A, prom_set);
      f_mod_mem_value             (32'h7F, prom_set);
      f_write_result_to_reg       (32'h15A, prom_set);
      f_inc_mem_address           (prom_set);

      //////////////////////////////////////////////////////////
      // Read the PIO bit
      // Use the compare result function as an inverter... when the input
      // is 0 and we compare it with 0, it will stay 0, else it will
      // 1.  To load taps, create a multi-cycle pulse
      f_read_pio_bit              (PIO_IN_CONTINUOUS_DFE, prom_set);
      f_compare_result            (32'b1, prom_set);

      // Jump to skip loading the DFE taps to adaptation
      f_jump_not_equal_zero       (PRGM_SKIP_DFE_LOAD, prom_set);

      // Load the DFE Taps into the adaptation block
      //    adp_dfe_fxtap_load    = RADP_DFE_FXTAP_LOAD_1
      f_read_reg                  (32'h15B, prom_set);
      f_modify_reg                (32'h2,32'h2, prom_set);
      f_write_result_to_reg       (32'h15B, prom_set);

      // create an extended pulse
      f_sleep                     (SLEEP_DELAY, prom_set);

      // Clear the load signal for the DFE taps
      //    adp_dfe_fxtap_load    = RADP_DFE_FXTAP_LOAD_0
      f_read_reg                  (32'h15B, prom_set);
      f_modify_reg                (32'h2,32'h0, prom_set);
      f_write_result_to_reg       (32'h15B, prom_set);

      // Skips loading the DFE taps
      f_label                     (PRGM_SKIP_DFE_LOAD, prom_set);

    //<-- End Code Here -->//

    // Indicate channel is done
    f_write_pio_bit             (PIO_OUT_RUNNING,0, prom_set);

    // If PIO_IN_GO isn't low, then we havn't completed all channels.  Repeat
    f_sleep                     (SLEEP_DELAY, prom_set);
    f_read_pio_bit              (PIO_IN_GO, prom_set);
    f_jump_not_equal_zero       (PRGM_SW_GEN3, prom_set);

    // Return to Beginning
    f_load_result               (FORCE_JUMP, prom_set);
    f_jump_not_equal_zero       (PRGM_BEGIN, prom_set);


    //////////////////////////////////////////////////////////
    // Code for entering Phase 2
    // When running phase 2, wait for the GO signal, which should
    // be after a 12ms timeout.  At which point, save the CTLE
    // setting, and read out the value before enabling DFE manual
    // mode.  once in manual mode, jump and let the Master SM
    // change the channels before starting again.  In the meantime
    // the Master SM will run a 10ms timeout.  After the 10ms,
    // save the DFE settings into the memory
    //////////////////////////////////////////////////////////
    // CTLE Time - read out the CTLE value
    // TODO: Do I need to save the originals?
    f_label                     (PRGM_PHASE2_CTLE, prom_set);

    // Assert the signal to indicate we are switching to Gen3
    f_write_pio_bit             (PIO_OUT_PHASE2_CTLE,1, prom_set);
    f_write_pio_bit             (PIO_OUT_RUNNING,1, prom_set);

    //<-- Put Code Here -->//
      //////////////////////////////////////////////////////////
      // Set the testbus
      // Set the test mux value to point to CTLE
      f_read_reg                (32'h14C, prom_set);
      f_modify_reg              (32'h3F,32'h1B, prom_set);
      f_write_result_to_reg     (32'h14C, prom_set);
      
      // Wait 5 cycles, then read the value out and compare it to verify we
      // wrote the correct testbus
      f_sleep                   (TST_MUX_DELAY, prom_set);

      // Read out the value
      f_read_reg                (32'h177, prom_set); // Backup... in case 171 is a different setting
      f_st_reg_to_address       (prom_set);

      //////////////////////////////////////////////////////////
      // Disable the Adaptation Mode B and configure to Adaptation Mode E
      //    pdb_fxtap4t7          = FXTAP4T7_ENABLE
      f_read_reg                (32'h123, prom_set);
      f_modify_reg              (32'h8,32'h8, prom_set);
      f_write_result_to_reg     (32'h123, prom_set);

      //    adp_dfe_fxtap_en      = RADP_DFE_FXTAP_ENABLE
      //    adp_dfe_fltap_en      = RADP_DFE_FLTAP_ENABLE
      f_read_reg                (32'h148, prom_set);
      f_modify_reg              (32'h3,32'h3, prom_set);
      f_write_result_to_reg     (32'h148, prom_set);

      //    adp_dfe_fxtap_bypass  = RADP_DFE_FXTAP_BYPASS_0
      //    adp_dfe_fltap_bypass  = RADP_DFE_FLTAP_BYPASS_0
      //    adp_dfe_fxtap_hold_en = RADP_DFE_FXTAP_NOT_HELD
      f_read_reg                (32'h15B, prom_set);
      f_modify_reg              (32'h15,32'h0, prom_set);
      f_write_result_to_reg     (32'h15B, prom_set);

      //    adp_vga_bypass        = RADP_VGA_BYPASS_1
      f_read_reg                (32'h160, prom_set);
      f_modify_reg              (32'h1,32'h1, prom_set);
      f_write_result_to_reg     (32'h160, prom_set);

      //    adp_dfe_mode          = RADP_DFE_MODE_0
      f_read_reg                (32'h14D, prom_set);
      f_modify_reg              (32'h7,32'h0, prom_set);
      f_write_result_to_reg     (32'h14D, prom_set);
      
      //    adp_ctle_adapt_cycle_window  = RADP_CTLE_ADAPT_CYCLE_WINDOW_0
      f_read_reg                (32'h163, prom_set);
      f_modify_reg              (32'hE0,32'h0, prom_set);
      f_write_result_to_reg     (32'h163, prom_set);

      //    adp_1s_ctle_bypass    = RADP_1S_CTLE_BYPASS_1
      f_read_reg                (32'h166, prom_set);
      f_modify_reg              (32'h1,32'h1, prom_set);
      f_write_result_to_reg     (32'h166, prom_set);

      //    adp_4s_ctle_bypass    = RADP_4S_CTLE_BYPASS_1
      f_read_reg                (32'h167, prom_set);
      f_modify_reg              (32'h1,32'h1, prom_set);
      f_write_result_to_reg     (32'h167, prom_set);

      //////////////////////////////////////////////////////////
      // Write back the CTLE Manual setting
      f_convert_ctle            (prom_set);
      f_write_result_to_reg     (32'h167, prom_set);

      // Index to the start of the next channel's CTLE memory address
      f_load_mem_address        (prom_set);
      f_add_to_reg              (NUM_ADDR_PER_CHNL, prom_set);
      f_store_mem_address       (prom_set);

      //////////////////////////////////////////////////////////
      // Start the DFE
      //    adp_adapt_control_sel = RADP_ADAPT_CONTROL_SEL_1
      f_read_reg                (32'h149, prom_set);
      f_modify_reg              (32'h10,32'h10, prom_set);
      f_write_result_to_reg     (32'h149, prom_set);

      //    assert adp_start = radp_adapt_start_0
      f_read_reg                (32'h149, prom_set);
      f_modify_reg              (32'h20,32'h0, prom_set);
      f_write_result_to_reg     (32'h149, prom_set);

      //    rstn by adp_adp_rstn = radp_adapt_rstn_0
      f_read_reg                (32'h149, prom_set);
      f_modify_reg              (32'h40,32'h0, prom_set);
      f_write_result_to_reg     (32'h149, prom_set);

      //    rstn by adp_adp_rstn = radp_adapt_rstn_1
      f_read_reg                (32'h149, prom_set);
      f_modify_reg              (32'h40,32'h40, prom_set);
      f_write_result_to_reg     (32'h149, prom_set);

      //    assert adp_start = radp_adapt_start_1
      f_read_reg                (32'h149, prom_set);
      f_modify_reg              (32'h20,32'h20, prom_set);
      f_write_result_to_reg     (32'h149, prom_set);

    //<-- End Code Here -->//

    // Indicate channel is done
    f_write_pio_bit             (PIO_OUT_RUNNING,0, prom_set);

    // If PIO_IN_GO isn't low, then we havn't completed all channels.  Repeat
    f_sleep                     (SLEEP_DELAY, prom_set);
    f_read_pio_bit              (PIO_IN_GO, prom_set);
    f_jump_not_equal_zero       (PRGM_PHASE2_CTLE, prom_set);

    // Return to beginning
    f_load_result               (FORCE_JUMP, prom_set);
    f_jump_not_equal_zero       (PRGM_BEGIN, prom_set);


    //////////////////////////////////////////////////////////
    // DFE time - read out the DFE converged values
    // We are still in Phase 2, however the 10ms are up,
    // and we can now store the values for the DFE
    //////////////////////////////////////////////////////////
    f_label                     (PRGM_PHASE2_DFE, prom_set);

    // Assert the signal to indicate we are reading out DFE
    f_write_pio_bit             (PIO_OUT_PHASE2_DFE,1, prom_set);
    f_write_pio_bit             (PIO_OUT_RUNNING,1, prom_set);

    //<-- Put Code Here -->//
      // Set the starting address for DFE
      f_load_mem_address        (prom_set);
      f_add_to_reg              (NUM_ADDR_CTLE, prom_set);
      f_store_mem_address       (prom_set);

      // Check the PIO in for continuous dfe... we need to skip the TAP hold
      f_read_pio_bit            (PIO_IN_CONTINUOUS_DFE, prom_set);
      f_jump_not_equal_zero     (PRGM_SKIP_DFE_HOLD, prom_set);

        // Assert the Hold for DFE -- Might need to be moved
        //    adp_dfe_fxtap_hold_en = RADP_DFE_FXTAP_HELD
        f_read_reg              (32'h15B, prom_set);
        f_modify_reg            (32'h10,32'h10, prom_set);
        f_write_result_to_reg   (32'h15B, prom_set);

      // Used to skip the DFE HOLD on the Taps
      f_label                   (PRGM_SKIP_DFE_HOLD, prom_set); 

      // Setup the test mux for DFE
      f_read_reg                (32'h171, prom_set);
      f_modify_reg              (32'h1E,32'h16, prom_set);
      f_write_result_to_reg     (32'h171, prom_set);

      // Read back TAP 1
      f_read_reg                (32'h14C, prom_set);
      f_modify_reg              (32'h3F,32'h1E, prom_set);
      f_write_result_to_reg     (32'h14C, prom_set);
      f_sleep                   (TST_MUX_DELAY, prom_set);
      f_read_reg                (32'h176, prom_set);
      f_st_reg_to_address       (prom_set);
      f_inc_mem_address         (prom_set);

      // Read back TAP 2
      f_read_reg                (32'h14C, prom_set);
      f_modify_reg              (32'h3F,32'h1F, prom_set);
      f_write_result_to_reg     (32'h14C, prom_set);
      f_sleep                   (TST_MUX_DELAY, prom_set);
      f_read_reg                (32'h176, prom_set);
      f_st_reg_to_address       (prom_set);
      f_inc_mem_address         (prom_set);

      // Read back TAP 3
      f_read_reg                (32'h14C, prom_set);
      f_modify_reg              (32'h3F,32'h20, prom_set);
      f_write_result_to_reg     (32'h14C, prom_set);
      f_sleep                   (TST_MUX_DELAY, prom_set);
      f_read_reg                (32'h176, prom_set);
      f_st_reg_to_address       (prom_set);
      f_inc_mem_address         (prom_set);

      // Read back TAP 4
      f_read_reg                (32'h14C, prom_set);
      f_modify_reg              (32'h3F,32'h21, prom_set);
      f_write_result_to_reg     (32'h14C, prom_set);
      f_sleep                   (TST_MUX_DELAY, prom_set);
      f_read_reg                (32'h176, prom_set);
      f_st_reg_to_address       (prom_set);
      f_inc_mem_address         (prom_set);
      
      // Read back TAP 5
      f_read_reg                (32'h14C, prom_set);
      f_modify_reg              (32'h3F,32'h22, prom_set);
      f_write_result_to_reg     (32'h14C, prom_set);
      f_sleep                   (TST_MUX_DELAY, prom_set);
      f_read_reg                (32'h176, prom_set);
      f_st_reg_to_address       (prom_set);
      f_inc_mem_address         (prom_set);

      // Read back TAP 6
      f_read_reg                (32'h14C, prom_set);
      f_modify_reg              (32'h3F,32'h23, prom_set);
      f_write_result_to_reg     (32'h14C, prom_set);
      f_sleep                   (TST_MUX_DELAY, prom_set);
      f_read_reg                (32'h176, prom_set);
      f_st_reg_to_address       (prom_set);
      f_inc_mem_address         (prom_set);

      // Read back TAP 7
      f_read_reg                (32'h14C, prom_set);
      f_modify_reg              (32'h3F,32'h24, prom_set);
      f_write_result_to_reg     (32'h14C, prom_set);
      f_sleep                   (TST_MUX_DELAY, prom_set);
      f_read_reg                (32'h176, prom_set);
      f_st_reg_to_address       (prom_set);
      f_inc_mem_address         (prom_set);

      // Read back TAP 8
      f_read_reg                (32'h14C, prom_set);
      f_modify_reg              (32'h3F,32'h25, prom_set);
      f_write_result_to_reg     (32'h14C, prom_set);
      f_sleep                   (TST_MUX_DELAY, prom_set);
      f_read_reg                (32'h176, prom_set);
      f_st_reg_to_address       (prom_set);
      f_inc_mem_address         (prom_set);

      // Read back TAP 9
      f_read_reg                (32'h14C, prom_set);
      f_modify_reg              (32'h3F,32'h26, prom_set);
      f_write_result_to_reg     (32'h14C, prom_set);
      f_sleep                   (TST_MUX_DELAY, prom_set);
      f_read_reg                (32'h176, prom_set);
      f_st_reg_to_address       (prom_set);
      f_inc_mem_address         (prom_set);

      // Read back TAP 10
      f_read_reg                (32'h14C, prom_set);
      f_modify_reg              (32'h3F,32'h27, prom_set);
      f_write_result_to_reg     (32'h14C, prom_set);
      f_sleep                   (TST_MUX_DELAY, prom_set);
      f_read_reg                (32'h176, prom_set);
      f_st_reg_to_address       (prom_set);
      f_inc_mem_address         (prom_set);

      // Read back TAP 11
      f_read_reg                (32'h14C, prom_set);;
      f_modify_reg              (32'h3F,32'h28, prom_set);
      f_write_result_to_reg     (32'h14C, prom_set);
      f_sleep                   (TST_MUX_DELAY, prom_set);
      f_read_reg                (32'h176, prom_set);
      f_st_reg_to_address       (prom_set);
      f_inc_mem_address         (prom_set);

      //////////////////////////////////////////////////////////
      // Check the status of continuous DFE.  If the status is set, skip manual DFE
      // and jump to the end of writing back the tap values.  At that point write the 
      // bits to enable Mode 4.  If we do run manual DFE, force a jump at the end to 
      // skip the continuous DFE Mode 4 write
      f_read_pio_bit            (PIO_IN_CONTINUOUS_DFE, prom_set);

      //  Skip manual DFE
      f_jump_not_equal_zero     (PRGM_SKIP_MANUAL_DFE, prom_set);

      //////////////////////////////////////////////////////////
      // Disable DFE One time, and switch to manual manual
      //    adp_dfe_fxtap_en      = RADP_DFE_FXTAP_DISABLE
      //    adp_dfe_fltap_en      = RADP_DFE_FLTAP_DISABLE
      //    adp_vref_en           = RADP_VREF_DISABLE
      //    adp_vga_en            = RADP_VGA_DISABLE
      //    adp_ctle_en           = RADP_CTLE_DISABLE
      f_read_reg                (32'h148, prom_set);
      f_modify_reg              (32'h1F,32'h0, prom_set);
      f_write_result_to_reg     (32'h148, prom_set);

      //    adp_dfe_fxtap_bypass  = RADP_DFE_FXTAP_BYPASS_1
      //    adp_dfe_fltap_bypass  = RADP_DFE_FLTAP_BYPASS_1
      f_read_reg                (32'h15B, prom_set);
      f_modify_reg              (32'h5,32'h5, prom_set);
      f_write_result_to_reg     (32'h15B, prom_set);

      //    adp_vref_bypass       = RADP_VREF_BYPASS_1
      f_read_reg                (32'h15E, prom_set);
      f_modify_reg              (32'h1,32'h1, prom_set);
      f_write_result_to_reg     (32'h15E, prom_set);

      //    adp_ctle_adapt_cycle_window  = RADP_CTLE_ADAPT_CYCLE_WINDOW_7
      f_read_reg                (32'h163, prom_set);
      f_modify_reg              (32'hE0,32'hE0, prom_set);
      f_write_result_to_reg     (32'h163, prom_set);

      // Might have to disable DFE Hold
      //    adp_dfe_fxtap_hold_en = RADP_DFE_FXTAP_NOT_HELD

      //////////////////////////////////////////////////////////
      // Load the DFE Manual
      // Potential enhancement: Call Gen3_SW to set all the DFE Taps
      // For now, finish, and then make an immediate call to run Gen3 SW
      // Restore the address for the start of the Memory
      f_load_mem_address        (prom_set);
      f_sub_from_reg            (NUM_ADDR_DFE, prom_set);
      f_store_mem_address       (prom_set);

      // Read second address for a channel... DFE Tap 1
      f_read_reg                (32'h14F, prom_set);
      f_modify_reg                (32'hFF, 32'h00, prom_set);
      //f_mod_mem_value           (32'hFF, prom_set);
      f_write_result_to_reg     (32'h14F, prom_set);
      f_inc_mem_address         (prom_set);

      // Read second address for a channel... DFE Tap 2
      f_read_reg                (32'h150, prom_set);
      f_mod_mem_value           (32'hFF, prom_set);
      f_write_result_to_reg     (32'h150, prom_set);
      f_inc_mem_address         (prom_set);

      // Read second address for a channel... DFE Tap 3
      f_read_reg                (32'h151, prom_set);
      f_mod_mem_value           (32'hFF, prom_set);
      f_write_result_to_reg     (32'h151, prom_set);
      f_inc_mem_address         (prom_set);

      // Read second address for a channel... DFE Tap 4
      f_read_reg                (32'h152, prom_set);
      f_mod_mem_value           (32'h7F, prom_set);
      f_write_result_to_reg     (32'h152, prom_set);
      f_inc_mem_address         (prom_set);

      // Read second address for a channel... DFE Tap 5
      f_read_reg                (32'h153, prom_set);
      f_mod_mem_value           (32'h7F, prom_set);
      f_write_result_to_reg     (32'h153, prom_set);
      f_inc_mem_address         (prom_set);

      // Read second address for a channel... DFE Tap 6
      f_read_reg                (32'h154, prom_set);
      f_mod_mem_value           (32'h3F, prom_set);
      f_write_result_to_reg     (32'h154, prom_set);
      f_inc_mem_address         (prom_set);

      // Read second address for a channel... DFE Tap 7
      f_read_reg                (32'h155, prom_set);
      f_mod_mem_value           (32'h3F, prom_set);
      f_write_result_to_reg     (32'h155, prom_set);
      f_inc_mem_address         (prom_set);

      // Read second address for a channel... DFE Tap 8
      f_read_reg                (32'h157, prom_set);
      f_mod_mem_value           (32'h7F, prom_set);
      f_write_result_to_reg     (32'h157, prom_set);
      f_inc_mem_address         (prom_set);

      // Read second address for a channel... DFE Tap 9
      f_read_reg                (32'h158, prom_set);
      f_mod_mem_value           (32'h7F, prom_set);
      f_write_result_to_reg     (32'h158, prom_set);
      f_inc_mem_address         (prom_set);

      // Read second address for a channel... DFE Tap 10
      f_read_reg                (32'h159, prom_set);
      f_mod_mem_value           (32'h7F, prom_set);
      f_write_result_to_reg     (32'h159, prom_set);
      f_inc_mem_address         (prom_set);

      // Read second address for a channel... DFE Tap 11
      f_read_reg                (32'h15A, prom_set);
      f_mod_mem_value           (32'h7F, prom_set);
      f_write_result_to_reg     (32'h15A, prom_set);
      f_inc_mem_address         (prom_set);

      //////////////////////////////////////////////////////////
      // Force a jump to skip continuous DFE
      // This jump is only executed when we run manual DFE; in continuous we
      // use a jump to skip the manual process (including this jump)  If we
      // use this jump, go ahead and skip manual
      f_load_result             (FORCE_JUMP, prom_set);
      f_jump_not_equal_zero     (PRGM_SKIP_CONT_DFE, prom_set);

      // label for the end of manual mode
      f_label                   (PRGM_SKIP_MANUAL_DFE, prom_set);

      // Switch adaptation from Mode 8 to Mode 4 to support loading
      //    adp_mode              = RADP_MODE_4
      f_read_reg                (32'h149, prom_set);
      f_modify_reg              (32'h0F,32'h04, prom_set);
      f_write_result_to_reg     (32'h149, prom_set);

      // label for the end of continuous DFE
      f_label                   (PRGM_SKIP_CONT_DFE, prom_set);

    //<-- End Code Here -->//

    // Indicate channel is done
    f_write_pio_bit             (PIO_OUT_RUNNING,0, prom_set);

    // If PIO_IN_GO isn't low, then we havn't completed all channels.  Repeat
    f_sleep                     (SLEEP_DELAY, prom_set);
    f_read_pio_bit              (PIO_IN_GO, prom_set);
    f_jump_not_equal_zero       (PRGM_PHASE2_DFE, prom_set);

    // Return to beginning
    f_load_result               (FORCE_JUMP, prom_set);
    f_jump_not_equal_zero       (PRGM_BEGIN, prom_set);


    //////////////////////////////////////////////////////////
    // If we hit a global reset or enter detect
    //////////////////////////////////////////////////////////
    f_label                     (PRGM_RESTORE_MODEB, prom_set);

    // Assert the signal to indicate we need to restore the original
    // Adapation Mode settings
    // TODO: should these be hard coded or do we need to save them?
    f_write_pio_bit             (PIO_OUT_RESTORE_MODEB,1, prom_set);
    f_write_pio_bit             (PIO_OUT_RUNNING,1, prom_set);

    //<-- Put Code Here -->//
      //////////////////////////////////////////////////////////
      // We are reseting... Restore Mode B
      //    adp_dfe_fxtap_en      = RADP_DFE_FXTAP_DISABLE
      //    adp_dfe_fltap_en      = RADP_DFE_FLTAP_DISABLE
      //    adp_vref_en           = RADP_VREF_ENABLE
      //    adp_vga_en            = RADP_VGA_ENABLE
      //    adp_ctle_en           = RADP_CTLE_ENABLE
      f_read_reg                (32'h148, prom_set);
      f_modify_reg              (32'h1F,32'h1C, prom_set);
      f_write_result_to_reg     (32'h148, prom_set);

      // Switch adaptation from Mode 4 to Mode 8 to support running
      // continuous CTLE.  If we are not in continuous DFE, skip
      f_read_pio_bit            (PIO_IN_CONTINUOUS_DFE, prom_set);
      f_compare_result          (32'b1, prom_set);
      f_jump_not_equal_zero     (PRGM_SKIP_DFE_MODE_8, prom_set);

        //    adp_mode              = RADP_MODE_8
        f_read_reg                (32'h149, prom_set);
        f_modify_reg              (32'h0F,32'h08, prom_set);
        f_write_result_to_reg     (32'h149, prom_set);

      // SKIP Mode8
      f_label                   (PRGM_SKIP_DFE_MODE_8, prom_set);

      //    adp_vref_bypass       = RADP_VREF_BYPASS_0
      f_read_reg                (32'h15E, prom_set);
      f_modify_reg              (32'h1,32'h0, prom_set);
      f_write_result_to_reg     (32'h15E, prom_set);

      //    adp_vga_bypass        = RADP_VGA_BYPASS_1
      f_read_reg                (32'h160, prom_set);
      f_modify_reg              (32'h1,32'h1, prom_set);
      f_write_result_to_reg     (32'h160, prom_set);

      //    adp_1s_ctle_bypass    = RADP_1S_CTLE_BYPASS_0
      f_read_reg                (32'h166, prom_set);
      f_modify_reg              (32'h1,32'h0, prom_set);
      f_write_result_to_reg     (32'h166, prom_set);

      //    adp_4s_ctle_bypass    = RADP_4S_CTLE_BYPASS_0
      f_read_reg                (32'h167, prom_set);
      f_modify_reg              (32'h1,32'h0, prom_set);
      f_write_result_to_reg     (32'h167, prom_set);

      // Restore Gen1/2 rates
      f_read_reg                (31'h167, prom_set);
      f_modify_reg              (32'h3E, GEN1_GEN2_CTLE_VAL, prom_set);
      f_write_result_to_reg     (31'h167, prom_set);

      // Clear all DFE Taps
      // Read second address for a channel... DFE Tap 1
      f_read_reg                (32'h14F, prom_set);
      f_modify_reg              (32'hFF, 32'h00, prom_set);
      f_write_result_to_reg     (32'h14F, prom_set);

      // Read second address for a channel... DFE Tap 2
      f_read_reg                (32'h150, prom_set);
      f_modify_reg              (32'hFF, 32'h00, prom_set);
      f_write_result_to_reg     (32'h150, prom_set);

      // Read second address for a channel... DFE Tap 3
      f_read_reg                (32'h151, prom_set);
      f_modify_reg              (32'hFF, 32'h00, prom_set);
      f_write_result_to_reg     (32'h151, prom_set);

      // Read second address for a channel... DFE Tap 4
      f_read_reg                (32'h152, prom_set);
      f_modify_reg              (32'h7F, 32'h00, prom_set);
      f_write_result_to_reg     (32'h152, prom_set);

      // Read second address for a channel... DFE Tap 5
      f_read_reg                (32'h153, prom_set);
      f_modify_reg              (32'h7F, 32'h00, prom_set);
      f_write_result_to_reg     (32'h153, prom_set);

      // Read second address for a channel... DFE Tap 6
      f_read_reg                (32'h154, prom_set);
      f_modify_reg              (32'h3F, 32'h00, prom_set);
      f_write_result_to_reg     (32'h154, prom_set);

      // Read second address for a channel... DFE Tap 7
      f_read_reg                (32'h155, prom_set);
      f_modify_reg              (32'h3F, 32'h00, prom_set);
      f_write_result_to_reg     (32'h155, prom_set);

      // Read second address for a channel... DFE Tap 8
      f_read_reg                (32'h157, prom_set);
      f_modify_reg              (32'h7F, 32'h00, prom_set);
      f_write_result_to_reg     (32'h157, prom_set);

      // Read second address for a channel... DFE Tap 9
      f_read_reg                (32'h158, prom_set);
      f_modify_reg              (32'h7F, 32'h00, prom_set);
      f_write_result_to_reg     (32'h158, prom_set);

      // Read second address for a channel... DFE Tap 10
      f_read_reg                (32'h159, prom_set);
      f_modify_reg              (32'h7F, 32'h00, prom_set);
      f_write_result_to_reg     (32'h159, prom_set);

      // Read second address for a channel... DFE Tap 11
      f_read_reg                (32'h15A, prom_set);
      f_modify_reg              (32'h7F, 32'h00, prom_set);
      f_write_result_to_reg     (32'h15A, prom_set);

    //<-- End Code Here -->//

    // Indicate channel is done
    f_write_pio_bit             (PIO_OUT_RUNNING,0, prom_set);

    // If PIO_IN_GO isn't low, then we havn't completed all channels.  Repeat
    f_sleep                     (SLEEP_DELAY, prom_set);
    f_read_pio_bit              (PIO_IN_GO, prom_set);
    f_jump_not_equal_zero       (PRGM_RESTORE_MODEB, prom_set);

    // Return to beginning
    f_load_result               (FORCE_JUMP, prom_set);
    f_jump_not_equal_zero       (PRGM_BEGIN, prom_set);

  end
endtask
endpackage 
