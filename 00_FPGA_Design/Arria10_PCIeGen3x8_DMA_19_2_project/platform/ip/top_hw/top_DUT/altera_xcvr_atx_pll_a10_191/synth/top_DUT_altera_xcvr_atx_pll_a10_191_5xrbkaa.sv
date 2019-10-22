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


 
//------------------------------------------------------------------
// filename: altera_xcvr_atx_pll_a10.sv.terp
//
// Description : instantiates avmm and lc-pll
//
// Limitation  : Intended for NightFury
//
// Copyright (c) Altera Corporation 1997-2012
// All rights reserved
//-------------------------------------------------------------------
//
// NOTEs
// - comments marked with OPEN means there is an issue that needs to be resolved but cannot be done due to lack of information.
// - comments marked with TODO means there is an issue that needs to be resolved and there is enough information already for the issue to be resolved.
//
//-------------------------------------------------------------------


// OPEN should we remove timescale?
`timescale 1 ns / 1 ns

module top_DUT_altera_xcvr_atx_pll_a10_191_5xrbkaa
#(  
    parameter enable_debug_info = "true",                          // RANGE false|true      NOTE: this is simulation-only parameter, for debug purpose only

    parameter atx_pll_regulator_bypass = "reg_enable",
    parameter atx_pll_pfd_delay_compensation = "normal_delay",
    parameter atx_pll_xcpvco_xchgpmplf_cp_current_boost = "normal_setting",
    parameter atx_pll_pfd_pulse_width = "pulse_width_setting0",

    parameter atx_pll_l_counter_enable = "true",                   // RANGE true (false)
    parameter atx_pll_fb_select = "direct_fb",                     // RANGE (direct_fb) iqtxrxclk_fb
    parameter atx_pll_bonding_mode = "cpri_bonding",               // RANGE (cpri_bonding) pll_bonding NOTE CPRI is for external feedback mode without feedback compensation bonding and PLL is for external feedback with feedback compensation bonding
    parameter atx_pll_prot_mode = "basic_tx",                      // RANGE "unused" (basic_tx) "basic_kr_tx" "pcie_gen1_tx" "pcie_gen2_tx" "pcie_gen3_tx" "pcie_gen4_tx" "cei_tx" "qpi_tx" "cpri_tx" "fc_tx" "srio_tx" "gpon_tx" "sdi_tx" "sata_tx" "xaui_tx" "obsai_tx" "gige_tx" "higig_tx" "sonet_tx" "sfp_tx" "xfp_tx" "sfi_tx"
    parameter atx_pll_silicon_rev = "20nm5es",                     // RANGE (20nm5es) "20nm5es2" "20nm4" "20nm3" "20nm4qor" "20nm2" "20nm1"
    parameter atx_pll_bw_sel = "low",                              // RANGE (low) medium high
    parameter atx_pll_dsm_mode = "dsm_mode_integer",               // RANGE (dsm_mode_integer) dsm_mode_phase
    parameter atx_pll_reference_clock_frequency = "0 ps",
    parameter atx_pll_output_clock_frequency = "0 ps",
    parameter atx_pll_m_counter = 1,                               // RANGE (1) 2 3 4 5 6 8 9 10 12 15 16 18 20 24 25 30 32 36 40 48 50 60 64 80 100
    parameter atx_pll_ref_clk_div = 1,                             // RANGE (1) 2 4 8
    parameter atx_pll_l_counter = 1,                               // RANGE (1) 2 4 8 16
    parameter atx_pll_dsm_fractional_division = "1",               // This is a string value of a 32 bitvec
    parameter atx_pll_tank_band = "lc_band0",                      // RANGE (lc_band0) lc_band1 lc_band2 lc_band3 lc_band4 lc_band5 lc_band6 lc_band7
    parameter atx_pll_tank_sel = "lctank0",                        // RANGE (lctank0) lctank1 lctank2
    parameter atx_pll_hclk_divide = 1,                             // RANGE (1) 40 50
    parameter atx_pll_cgb_div = 1,                                 // RANGE (1) 2 4 8
    parameter atx_pll_pma_width = 8,                               // RANGE (8) 10 16 20 32 40 64

    parameter atx_pll_primary_use                = "hssi_x1",
    parameter atx_pll_lc_mode                    = "lccmu_normal",         // RANGE (lccmu_pd) lccmu_normal lccmu_reset
    parameter atx_pll_lc_atb                     = "atb_selectdisable",    // RANGE (atb_selectdisable) atb_select0 atb_select1 atb_select2 atb_select3 atb_select4 atb_select5 atb_select6 atb_select7 atb_select8 atb_select9 atb_select10 atb_select11 atb_select12 atb_select13 atb_select14 atb_select15 atb_select16 atb_select17 atb_select18 atb_select19 atb_select20 atb_select21 atb_select22 atb_select23 atb_select24 atb_select25 atb_select26 atb_select27 atb_select28 atb_select29 atb_select30
    parameter atx_pll_cp_compensation_enable     = "true",                 // RANGE false (true)
    parameter atx_pll_cp_current_setting         = "cp_current_setting0",  // RANGE (cp_current_setting0) cp_current_setting1 cp_current_setting2 cp_current_setting3 cp_current_setting4 cp_current_setting5 cp_current_setting6 cp_current_setting7 cp_current_setting8 cp_current_setting9 cp_current_setting10 cp_current_setting11
    parameter atx_pll_cp_testmode                = "cp_normal",            // RANGE (cp_normal) cp_test_up cp_test_dn cp_tristate
    parameter atx_pll_cp_lf_3rd_pole_freq        = "lf_3rd_pole_setting0", // RANGE (lf_3rd_pole_setting0) lf_3rd_pole_setting1 lf_3rd_pole_setting2 lf_3rd_pole_setting3
    parameter atx_pll_cp_lf_order                = "lf_2nd_order",         // RANGE (lf_2nd_order) lf_3rd_order lf_4th_order
    parameter atx_pll_lf_resistance              = "lf_setting0",          // RANGE (lf_setting0) lf_setting1 lf_setting2 lf_setting3
    parameter atx_pll_lf_ripplecap               = "lf_ripple_cap_0",      // RANGE lf_no_ripple (lf_ripple_cap_0) lf_ripple_cap_1
    parameter atx_pll_d2a_voltage                = "d2a_disable",          // RANGE d2a_setting_0 d2a_setting_1 d2a_setting_2 d2a_setting_3 d2a_setting_4 d2a_setting_5 d2a_setting_6 d2a_setting_7 (d2a_disable)
    parameter atx_pll_dsm_out_sel                = "pll_dsm_disable",      // RANGE (pll_dsm_disable) pll_dsm_1st_order pll_dsm_2nd_order pll_dsm_3rd_order
    parameter atx_pll_dsm_ecn_bypass             = "false",                // RANGE (false) true
    parameter atx_pll_dsm_ecn_test_en            = "false",                // RANGE (false) true
    parameter atx_pll_dsm_fractional_value_ready = "pll_k_ready",          // RANGE pll_k_not_ready (pll_k_ready)
    parameter atx_pll_vco_bypass_enable          = "false",                // RANGE (false) true
    parameter atx_pll_cascadeclk_test            = "cascadetest_off",      // RANGE (cascadetest_off) cascadetest_on
    parameter atx_pll_tank_voltage_coarse        = "vreg_setting_coarse1", // RANGE vreg_setting_coarse0 (vreg_setting_coarse1) vreg_setting_coarse2 vreg_setting_coarse3
    parameter atx_pll_tank_voltage_fine          = "vreg_setting3",        // RANGE vreg_setting0 vreg_setting1 vreg_setting2 (vreg_setting3) vreg_setting4 vreg_setting5 vreg_setting6 vreg_setting7
    parameter atx_pll_output_regulator_supply    = "vreg1v_setting1",      // RANGE vreg1v_setting0 (vreg1v_setting1) vreg1v_setting2 vreg1v_setting3
    parameter atx_pll_overrange_voltage          = "over_setting3",        // RANGE over_setting0 over_setting1 over_setting2 (over_setting3) over_setting4 over_setting5 over_setting6 over_setting7
    parameter atx_pll_underrange_voltage         = "under_setting3",       // RANGE under_setting0 under_setting1 under_setting2 (under_setting3) under_setting4 under_setting5 under_setting6 under_setting7
    parameter atx_pll_is_cascaded_pll            = "false",                // RANGE (false) true
    parameter atx_pll_is_otn                     = "false",                // RANGE (false) true
    parameter atx_pll_is_sdi                     = "false",                // RANGE (false) true
    parameter atx_pll_side                       = "side_unknown",         // RANGE (side_unknown) left right

	parameter	atx_pll_lf_cbig_size             = "lf_cbig_setting0" ,		// RANGE (lf_cbig_setting0) , lf_cbig_setting1 , lf_cbig_setting2 , lf_cbig_setting3 , lf_cbig_setting4 
	parameter	atx_pll_iqclk_mux_sel            = "power_down" ,		    // RANGE iqtxrxclk0 , iqtxrxclk1 , iqtxrxclk2 , iqtxrxclk3 , iqtxrxclk4 , iqtxrxclk5 , (power_down)
	parameter	atx_pll_enable_hclk              = "hclk_disabled" ,		// RANGE (hclk_disabled), hclk_enable 
	parameter	atx_pll_calibration_mode         = "cal_off" ,		        // RANGE (cal_off), uc_rst_pll , uc_rst_lf , uc_not_rst 
	parameter	atx_pll_datarate                 = "0 bps" ,		        // RANGE  
	parameter	atx_pll_device_variant           = "device1" ,		        // RANGE (device1), device2 , device3 , device4 , device5 
	parameter	atx_pll_initial_settings         = "true" ,		            // RANGE (false), true 
	parameter	[4:0] atx_pll_l_counter_scratch  = 5'b00001 ,		        // RANGE (5) 
	parameter	[2:0] atx_pll_n_counter_scratch  = 3'b001 ,		            // RANGE (3) 
	parameter	atx_pll_powerdown_mode           = "powerup" ,		        // RANGE (powerup) , powerdown 
	parameter	atx_pll_sup_mode                 = "user_mode" ,		    // RANGE (user_mode) , engineering_mode 
	parameter	atx_pll_vco_freq                 = "0 hz",		            // RANGE  
	parameter	atx_pll_fpll_refclk_selection    = "select_div_by_2",       // RANGE (select_div_by_2), select_vco_output
        parameter       atx_pll_lc_to_fpll_l_counter     = "lcounter_setting0",     // RANGE (lcounter_setting0) .. lcounter_setting31
        parameter       [4:0] atx_pll_lc_to_fpll_l_counter_scratch = 5'b00000,     // RANGE (5)

   	parameter hssi_pma_lc_refclk_select_mux_powerdown_mode = "powerup",   // RANGE (powerup) powerdown     
    parameter hssi_pma_lc_refclk_select_mux_silicon_rev = "20nm5es",          // RANGE (20nm5es) "20nm5es2" "20nm4" "20nm3" "20nm4qor" "20nm2" "20nm1"
    parameter hssi_refclk_divider_silicon_rev = "20nm5es",		      // RANGE (20nm5es) "20nm5es2" "20nm4" "20nm3" "20nm4qor" "20nm2" "20nm1"
    parameter hssi_pma_lc_refclk_select_mux_refclk_select = "ref_iqclk0",  // RANGE (ref_iqclk0) ref_iqclk1 ref_iqclk2 ref_iqclk3 ref_iqclk4 ref_iqclk5 ref_iqclk6 ref_iqclk7 ref_iqclk8 ref_iqclk9 ref_iqclk10 ref_iqclk11 iqtxrxclk0 iqtxrxclk1 iqtxrxclk2 iqtxrxclk3 iqtxrxclk4 iqtxrxclk5 coreclk fixed_clk lvpecl adj_pll_clk power_down     

    parameter hssi_pma_lc_refclk_select_mux_inclk0_logical_to_physical_mapping = "ref_iqclk0",           // RANGE (ref_iqclk0) ref_iqclk1 ref_iqclk2 ref_iqclk3 ref_iqclk4 ref_iqclk5 ref_iqclk6 ref_iqclk7 ref_iqclk8 ref_iqclk9 ref_iqclk10 ref_iqclk11 iqtxrxclk0 iqtxrxclk1 iqtxrxclk2 iqtxrxclk3 iqtxrxclk4 iqtxrxclk5 coreclk fixed_clk lvpecl adj_pll_clk power_down
    parameter hssi_pma_lc_refclk_select_mux_inclk1_logical_to_physical_mapping = "ref_iqclk1",           // RANGE (ref_iqclk0) ref_iqclk1 ref_iqclk2 ref_iqclk3 ref_iqclk4 ref_iqclk5 ref_iqclk6 ref_iqclk7 ref_iqclk8 ref_iqclk9 ref_iqclk10 ref_iqclk11 iqtxrxclk0 iqtxrxclk1 iqtxrxclk2 iqtxrxclk3 iqtxrxclk4 iqtxrxclk5 coreclk fixed_clk lvpecl adj_pll_clk power_down
    parameter hssi_pma_lc_refclk_select_mux_inclk2_logical_to_physical_mapping = "ref_iqclk2",           // RANGE (ref_iqclk0) ref_iqclk1 ref_iqclk2 ref_iqclk3 ref_iqclk4 ref_iqclk5 ref_iqclk6 ref_iqclk7 ref_iqclk8 ref_iqclk9 ref_iqclk10 ref_iqclk11 iqtxrxclk0 iqtxrxclk1 iqtxrxclk2 iqtxrxclk3 iqtxrxclk4 iqtxrxclk5 coreclk fixed_clk lvpecl adj_pll_clk power_down
    parameter hssi_pma_lc_refclk_select_mux_inclk3_logical_to_physical_mapping = "ref_iqclk3",           // RANGE (ref_iqclk0) ref_iqclk1 ref_iqclk2 ref_iqclk3 ref_iqclk4 ref_iqclk5 ref_iqclk6 ref_iqclk7 ref_iqclk8 ref_iqclk9 ref_iqclk10 ref_iqclk11 iqtxrxclk0 iqtxrxclk1 iqtxrxclk2 iqtxrxclk3 iqtxrxclk4 iqtxrxclk5 coreclk fixed_clk lvpecl adj_pll_clk power_down
    parameter hssi_pma_lc_refclk_select_mux_inclk4_logical_to_physical_mapping = "ref_iqclk4",           // RANGE (ref_iqclk0) ref_iqclk1 ref_iqclk2 ref_iqclk3 ref_iqclk4 ref_iqclk5 ref_iqclk6 ref_iqclk7 ref_iqclk8 ref_iqclk9 ref_iqclk10 ref_iqclk11 iqtxrxclk0 iqtxrxclk1 iqtxrxclk2 iqtxrxclk3 iqtxrxclk4 iqtxrxclk5 coreclk fixed_clk lvpecl adj_pll_clk power_down

    parameter enable_mcgb = 0,                                             // RANGE (0) 1
    parameter enable_mcgb_debug_ports_parameters = 0,                      // RANGE (0) 1
    parameter hssi_pma_cgb_master_silicon_rev = "20nm5es",                 // RANGE (20nm5es) "20nm5es2" "20nm4" "20nm3" "20nm4qor" "20nm2" "20nm1"
    parameter hssi_pma_cgb_master_prot_mode  = "basic_tx",                      // RANGE "unused" (basic_tx) "basic_kr_tx" "pcie_gen1_tx" "pcie_gen2_tx" "pcie_gen3_tx" "pcie_gen4_tx" "cei_tx" "qpi_tx" "cpri_tx" "fc_tx" "srio_tx" "gpon_tx" "sdi_tx" "sata_tx" "xaui_tx" "obsai_tx" "gige_tx" "higig_tx" "sonet_tx" "sfp_tx" "xfp_tx" "sfi_tx"
    parameter hssi_pma_cgb_master_cgb_enable_iqtxrxclk = "disable_iqtxrxclk",   // OPEN in atom default is enable in _hw.tcl default is disable // RANGE disable_iqtxrxclk (enable_iqtxrxclk) 
    parameter hssi_pma_cgb_master_x1_div_m_sel = "divbypass",                   // RANGE (divbypass) divby2 divby4 divby8
    parameter hssi_pma_cgb_master_ser_mode = "eight_bit",                       // RANGE (eight_bit) ten_bit sixteen_bit twenty_bit thirty_two_bit forty_bit sixty_four_bit
    parameter hssi_pma_cgb_master_datarate = "0 Mbps",

    parameter hssi_pma_cgb_master_cgb_power_down                     = "normal_cgb",                  // RANGE normal_cgb (power_down_cgb)                           
    parameter hssi_pma_cgb_master_bonding_reset_enable               = "allow_bonding_reset",         // RANGE disallow_bonding_reset (allow_bonding_reset) 
    parameter hssi_pma_cgb_master_observe_cgb_clocks                 = "observe_nothing",             // RANGE (observe_nothing) observe_x1mux_out   
    parameter hssi_pma_cgb_master_optimal                            = "true",                        // RANGE (true) false   
    parameter hssi_pma_cgb_master_op_mode                            = "enabled",                     // RANGE (enabled) pwr_down             
    parameter hssi_pma_cgb_master_tx_ucontrol_reset_pcie             = "pcscorehip_controls_mcgb",    // RANGE (pcscorehip_controls_mcgb) cgb_reset tx_pcie_gen1 tx_pcie_gen2 tx_pcie_gen3 tx_pcie_gen4  
    parameter hssi_pma_cgb_master_vccdreg_output                     = "vccdreg_nominal",             // RANGE (vccdreg_nominal) vccdreg_pos_setting0 vccdreg_pos_setting1 vccdreg_pos_setting2 vccdreg_pos_setting3 vccdreg_pos_setting4 vccdreg_pos_setting5 vccdreg_pos_setting6 vccdreg_pos_setting7 vccdreg_pos_setting8 vccdreg_pos_setting9 vccdreg_pos_setting10 vccdreg_pos_setting11 vccdreg_pos_setting12 vccdreg_pos_setting13 vccdreg_pos_setting14 vccdreg_pos_setting15 reserved1 reserved2 vccdreg_neg_setting0 vccdreg_neg_setting1 vccdreg_neg_setting2 vccdreg_neg_setting3 reserved3 reserved4 reserved5 reserved6 reserved7 reserved8 reserved9 reserved10 reserved11   
    parameter hssi_pma_cgb_master_input_select                       = "lcpll_top",                   // RANGE lcpll_bot lcpll_top fpll_bot fpll_top (unused)      
    parameter hssi_pma_cgb_master_input_select_gen3                  = "unused" ,                     // RANGE lcpll_bot lcpll_top fpll_bot fpll_top (unused) 
	parameter hssi_pma_cgb_master_pcie_gen3_bitwidth                 = "pciegen3_wide" ,		      // RANGE (pciegen3_wide) pciegen3_narrow parameter	powerdown_mode = "powerup" ,		//Valid values: powerup , powerdown 
	parameter hssi_pma_cgb_master_powerdown_mode                     = "powerup" ,		              // RANGE (powerup) powerdown 
	parameter hssi_pma_cgb_master_sup_mode                           = "user_mode" ,		          // RANGE (user_mode) engineering_mode 
	parameter hssi_pma_cgb_master_initial_settings                   = "true", 	                      // RANGE (false) true 

    parameter hip_cal_en                                        = "disable",                     // Indicates whether HIP is enabled or not. Valid values: disable, enable
    
    
    // NOTE following are constants, not meant to be changed in instantiations
    parameter SIZE_AVMM_RDDATA_BUS = 32,
    parameter SIZE_AVMM_WRDATA_BUS = 32,

    // instantiate paramters for embedded debug
    parameter rcfg_shared                 = 0,
    parameter enable_pll_reconfig         = 0,
    parameter rcfg_jtag_enable            = 0,
    parameter rcfg_emb_strm_enable        = 0,
    parameter rcfg_profile_cnt            = 2,
    parameter dbg_embedded_debug_enable   = 0,
    parameter dbg_capability_reg_enable   = 0,
    parameter dbg_user_identifier         = 0,
    parameter dbg_stat_soft_logic_enable  = 0,
    parameter dbg_ctrl_soft_logic_enable  = 0,
    parameter calibration_en              = "disable",
    parameter enable_analog_resets        = 0,      // (0,1)
                                                    // 0 - Disable pll_powerdown and mcgb_rst reset input connections. Still allows soft register override
                                                    // 1 - Enable pll_powerdown and mcgb_rst reset input connections

    parameter rcfg_separate_avmm_busy     = 0       // (0,1)
                                                    // 0 - AVMM busy is reflected on the waitrequest
                                                    // 1 - AVMM busy must be read from a soft CSR

    /// TODO all other pll parameters needs to be added
) (
    input pll_powerdown,                           
    input pll_refclk0,          
    input pll_refclk1,          
    input pll_refclk2,          
    input pll_refclk3,          
    input pll_refclk4,          
     input mcgb_aux_clk0,                      
    input mcgb_aux_clk1,
    input mcgb_aux_clk2,
    input [1:0] pcie_sw,

    output tx_serial_clk,                   
    output tx_serial_clk_gt,
    output pll_locked, 
    output pll_pcie_clk, 
    output pll_cascade_clk,                    
    output atx_to_fpll_cascade_clk, 
    
    input  mcgb_rst,
    output [5:0] tx_bonding_clocks,               
    output mcgb_serial_clk,                      
    output [1:0] pcie_sw_done,  

    // NOTE: reconfig for PLL
    input reconfig_clk0,
    input reconfig_reset0,
    input reconfig_write0,
    input reconfig_read0,
    input [9:0] reconfig_address0,                        // OPEN [9:0] is bus size defined somewhere
    input  [SIZE_AVMM_WRDATA_BUS-1:0] reconfig_writedata0,
    output [SIZE_AVMM_RDDATA_BUS-1:0] reconfig_readdata0,
    output avmm_busy0,
    output reconfig_waitrequest0,
    output pll_cal_busy,
    output hip_cal_done,

    // NOTE: reconfig for CGB
    input reconfig_clk1,
    input reconfig_reset1,
    input reconfig_write1,
    input reconfig_read1,
    input [9:0] reconfig_address1,
    input  [SIZE_AVMM_WRDATA_BUS-1:0] reconfig_writedata1,
    output [SIZE_AVMM_RDDATA_BUS-1:0] reconfig_readdata1,
    output avmm_busy1,
    output reconfig_waitrequest1,
    output mcgb_cal_busy,   
    output mcgb_hip_cal_done,   
    
    // NOTE: Debug related not in hw.tcl
    output clklow,
    output fref,    
    output overrange,
    output underrange     
    /// TODO include other any other ports for debugging?       
);

   localparam avmm_interfaces = ((enable_mcgb==1) && (enable_mcgb_debug_ports_parameters==1)) ? 2 : 1;
   localparam RCFG_ADDR_BITS = 10;

   localparam  MAX_CONVERSION_SIZE_ALT_XCVR_ATX_A10 = 128;
   localparam  MAX_STRING_CHARS_ALT_XCVR_ATX_A10  = 64;

   localparam  lcl_enable_analog_resets = 
   `ifdef ALTERA_RESERVED_QIS
     `ifdef ALTERA_XCVR_A10_ENABLE_ANALOG_RESETS
       1;  // MACRO override for quartus synthesis. Connect resets
     `else
       enable_analog_resets; // parameter option for synthesis
     `endif // ALTERA_XCVR_A10_ENABLE_ANALOG_RESETS
   `else
     1; // not synthesis. Connect resets
   `endif  // (NOT ALTERA_RESERVED_QIS)


   function automatic [MAX_CONVERSION_SIZE_ALT_XCVR_ATX_A10-1:0] str_2_bin_altera_xcvr_atx_pll_a10;
     input [MAX_STRING_CHARS_ALT_XCVR_ATX_A10*8-1:0] instring;

     integer this_char;
     integer i;
     begin
       // Initialize accumulator
       str_2_bin_altera_xcvr_atx_pll_a10 = {MAX_CONVERSION_SIZE_ALT_XCVR_ATX_A10{1'b0}};
       for(i=MAX_STRING_CHARS_ALT_XCVR_ATX_A10-1;i>=0;i=i-1) begin
         this_char = instring[i*8+:8];
         // Add value of this digit
         if(this_char >= 48 && this_char <= 57)
           str_2_bin_altera_xcvr_atx_pll_a10 = (str_2_bin_altera_xcvr_atx_pll_a10 * 10) + (this_char - 48);
       end
     end
   endfunction

   // String to binary conversions
   localparam  [127:0] temp_atx_pll_dsm_fractional_division  = str_2_bin_altera_xcvr_atx_pll_a10(atx_pll_dsm_fractional_division);
   localparam  [31:0] atx_pll_dsm_fractional_division_bin = temp_atx_pll_dsm_fractional_division[31:0];
   
   localparam  lcl_adme_assgn_map = {" assignments {device_revision ",atx_pll_silicon_rev,"}"};

   // upper 24 bits are not used, but should not be left at X
   //assign reconfig_readdata0[SIZE_AVMM_RDDATA_BUS-1:8] =  0;
   assign reconfig_readdata1[SIZE_AVMM_RDDATA_BUS-1:8] =  0;

    //-----------------------------------
    // reconfigAVMM to pllAtoms internal wires  
    // interface #0 to PLL, interface #1 to CGB 
    wire  [avmm_interfaces-1    :0] pll_avmm_clk;
    wire  [avmm_interfaces-1    :0] pll_avmm_rstn;
    wire  [avmm_interfaces*8-1  :0] pll_avmm_writedata;
    wire  [avmm_interfaces*9-1  :0] pll_avmm_address;
    wire  [avmm_interfaces-1    :0] pll_avmm_write;
    wire  [avmm_interfaces-1    :0] pll_avmm_read;

    wire  [avmm_interfaces*8-1  :0] pll_avmmreaddata_lc;                        // NOTE only [7:0] is used
    wire  [avmm_interfaces*8-1  :0] pll_avmmreaddata_refclk;                    // NOTE only [7:0] is used
    wire  [avmm_interfaces*8-1  :0] pll_avmmreaddata_mcgb;                      // NOTE only [15:8] is used
    wire  [avmm_interfaces-1    :0] pll_blockselect_lc;                         // NOTE only [0:0] is used
    wire  [avmm_interfaces-1    :0] pll_blockselect_refclk;                     // NOTE only [0:0] is used
    wire  [avmm_interfaces-1    :0] pll_blockselect_mcgb;                       // NOTE only [1:1] is used

    //-----------------------------------

   //-----------------------------------
   // reconfigAVMM to top wrapper wires  
   // interface #0 to PLL, interface #1 to CGB 
   wire  [avmm_interfaces-1    :0] reconfig_clk;
   wire  [avmm_interfaces-1    :0] reconfig_reset;
   wire  [avmm_interfaces*8-1  :0] reconfig_writedata;
   wire  [avmm_interfaces*9-1  :0] reconfig_address;
   wire  [avmm_interfaces-1    :0] reconfig_write;
   wire  [avmm_interfaces-1    :0] reconfig_read;
   wire  [avmm_interfaces*8-1  :0] reconfig_readdata;
   wire  [avmm_interfaces-1    :0] reconfig_waitrequest;
   wire  [avmm_interfaces-1    :0] avmm_busy;
   wire  [avmm_interfaces-1    :0] pld_cal_done;
   wire  [avmm_interfaces-1    :0] hip_cal_done_w;

   // AVMM reconfiguration signals for the hardware
   wire [avmm_interfaces-1:0]     avmm_write;
   wire [avmm_interfaces-1:0]     avmm_read;
   wire [avmm_interfaces-1:0]     avmm_waitrequest;
   wire [avmm_interfaces*8-1:0]   avmm_readdata;

   // AVMM reconfiguration signals for embedded debug
   wire [avmm_interfaces*8-1:0]   debug_writedata;
   wire [avmm_interfaces-1:0]     debug_clk;
   wire [avmm_interfaces-1:0]     debug_reset;
   wire [avmm_interfaces*10-1:0]  debug_address; 
   wire [avmm_interfaces-1:0]     debug_write;
   wire [avmm_interfaces-1:0]     debug_read;
   wire [avmm_interfaces-1:0]     debug_busy;
   wire [avmm_interfaces-1:0]     debug_waitrequest;
   wire [avmm_interfaces*8-1:0]   debug_readdata;

   // Wires for control signals from the embedded debug
   wire                           pll_powerdown_int;

   // Wires for disconnecting pll_powerdown and mcgb_rst
   // When the parameter "lcl_enable_analog_resets" is set to 0, these wires will be driven to 0.
   // When the parameter "lcl_enable_analog_resets" is set to 1, these wires will be connected
   // to the pll_powerdown and mcgb_rst inputs.
   wire pll_powerdown_input;
   wire mcgb_rst_input;

   // Analog reset masking. We always connect analog resets for simulation. 
   // For synthesis it is parameter controlled or MACRO overridden
   generate
   if(lcl_enable_analog_resets == 1) begin
     assign pll_powerdown_input = pll_powerdown;
     assign mcgb_rst_input      = mcgb_rst;
   end else begin
     assign pll_powerdown_input = 1'b0;
     assign mcgb_rst_input      = 1'b0;
   end
   endgenerate

   // avmm signals shared accross all interfaces
   assign reconfig_clk[0] = debug_clk;
   assign reconfig_reset[0] = debug_reset;
   assign reconfig_writedata[7:0] = debug_writedata[7:0];
   assign reconfig_address[8:0] = debug_address[8:0];
   assign reconfig_write[0] = debug_write;
   assign reconfig_read[0] = debug_read;
   assign debug_readdata[7:0] = reconfig_readdata[7:0];
   assign debug_waitrequest = reconfig_waitrequest[0];

   assign avmm_busy0 = avmm_busy[0];
   assign hip_cal_done = hip_cal_done_w[0];
   //---
   assign mcgb_cal_busy = 1'b0;
   assign pll_cal_busy = ~pld_cal_done[0];

   generate
      if (avmm_interfaces==2) begin
         assign reconfig_clk[1] = reconfig_clk1;
         assign reconfig_reset[1] = reconfig_reset1;
         assign reconfig_writedata[15:8] = reconfig_writedata1[7:0];
         assign reconfig_address[17:9] = reconfig_address1[18:10];
         assign reconfig_write[1] = reconfig_write1;
         assign reconfig_read[1] = reconfig_read1;
         assign reconfig_readdata1[7:0]=reconfig_readdata[15:8];
         assign reconfig_waitrequest1 = reconfig_waitrequest[1];
         assign avmm_busy1 = avmm_busy[1];
         //assign mcgb_cal_busy = ~pld_cal_done[1];
         assign mcgb_hip_cal_done = hip_cal_done_w[1];
       end else begin
         assign reconfig_readdata1 = 8'b0;
         assign reconfig_waitrequest1 = 1'b0;
         assign avmm_busy1 = 1'b0;
         assign mcgb_hip_cal_done = 1'b0;
       end
   endgenerate
   //-----------------------------------   

   //***************************************************************************
   //************* Embedded JTAG, AVMM and Embedded Streamer Expansion *********
   alt_xcvr_atx_pll_rcfg_opt_logic_5xrbkaa #(
       .dbg_user_identifier                            (dbg_user_identifier                        ),
       .dbg_embedded_debug_enable                      (dbg_embedded_debug_enable                  ),
       .dbg_capability_reg_enable                      (dbg_capability_reg_enable                  ),
       .dbg_stat_soft_logic_enable                     (dbg_stat_soft_logic_enable                 ),
       .dbg_ctrl_soft_logic_enable                     (dbg_ctrl_soft_logic_enable                 ),
       .en_master_cgb                                  (enable_mcgb                                ),
       .INTERFACES                                     (1                                          ),
       .ADDR_BITS                                      (RCFG_ADDR_BITS                             ),
       .ADME_SLAVE_MAP                                 ("altera_xcvr_atx_pll_a10"                  ),
       .ADME_ASSGN_MAP                                 (lcl_adme_assgn_map                         ),
       .RECONFIG_SHARED                                (enable_pll_reconfig && rcfg_shared         ),
       .JTAG_ENABLED                                   (enable_pll_reconfig && rcfg_jtag_enable    ),
       .RCFG_EMB_STRM_ENABLED                          (enable_pll_reconfig && rcfg_emb_strm_enable),
       .RCFG_PROFILE_CNT                               (rcfg_profile_cnt                           )
     ) alt_xcvr_atx_pll_optional_rcfg_logic (
     // User reconfig interface ports
     .reconfig_clk                                   (reconfig_clk0        ),
     .reconfig_reset                                 (reconfig_reset0      ),
     .reconfig_write                                 (reconfig_write0      ),
     .reconfig_read                                  (reconfig_read0       ),
     .reconfig_address                               (reconfig_address0    ),
     .reconfig_writedata                             (reconfig_writedata0  ),
     .reconfig_readdata                              (reconfig_readdata0   ),
     .reconfig_waitrequest                           (reconfig_waitrequest0),
  
     // AVMM ports to transceiver                    
     .avmm_clk                                       (debug_clk            ),
     .avmm_reset                                     (debug_reset          ),
     .avmm_write                                     (debug_write          ),
     .avmm_read                                      (debug_read           ),
     .avmm_address                                   (debug_address        ),
     .avmm_writedata                                 (debug_writedata      ),
     .avmm_readdata                                  (debug_readdata       ),
     .avmm_waitrequest                               (debug_waitrequest    ),
  
     // input signals from the core
     .in_pll_powerdown                               (pll_powerdown_input  ),
     .in_pll_locked                                  (pll_locked           ),
     .in_pll_cal_busy                                (pll_cal_busy         ),
     .in_avmm_busy                                   (avmm_busy0           ),

     // output signals to the ip
     .out_pll_powerdown                              (pll_powerdown_int    )
   );

   //***************** End Embedded JTAG and AVMM Expansion ********************
   //***************************************************************************


    //-----------------------------------
    // PLL STARTS
    a10_xcvr_atx_pll
    #(
       .enable_debug_info(enable_debug_info),

       .atx_pll_regulator_bypass  (atx_pll_regulator_bypass),
       .atx_pll_pfd_delay_compensation (atx_pll_pfd_delay_compensation),
       .atx_pll_xcpvco_xchgpmplf_cp_current_boost (atx_pll_xcpvco_xchgpmplf_cp_current_boost),
       .atx_pll_pfd_pulse_width (atx_pll_pfd_pulse_width),

       .atx_pll_l_counter_enable(atx_pll_l_counter_enable),
       .atx_pll_fb_select(atx_pll_fb_select),
       .atx_pll_bonding_mode(atx_pll_bonding_mode),
       .atx_pll_prot_mode(atx_pll_prot_mode),
       .atx_pll_silicon_rev(atx_pll_silicon_rev),
       .atx_pll_bw_sel(atx_pll_bw_sel),
       .atx_pll_dsm_mode(atx_pll_dsm_mode),
       .atx_pll_reference_clock_frequency(atx_pll_reference_clock_frequency),
       .atx_pll_output_clock_frequency(atx_pll_output_clock_frequency),
       .atx_pll_m_counter(atx_pll_m_counter),
       .atx_pll_ref_clk_div(atx_pll_ref_clk_div),
       .atx_pll_l_counter(atx_pll_l_counter),
       .atx_pll_dsm_fractional_division(atx_pll_dsm_fractional_division_bin), // String to bin conversion
       .atx_pll_tank_band(atx_pll_tank_band),
       .atx_pll_tank_sel(atx_pll_tank_sel),
       .atx_pll_hclk_divide(atx_pll_hclk_divide),
       .atx_pll_cgb_div(atx_pll_cgb_div),
       .atx_pll_pma_width(atx_pll_pma_width),

       .atx_pll_primary_use                (atx_pll_primary_use               ),
       .atx_pll_lc_mode                    (atx_pll_lc_mode                   ),
       .atx_pll_lc_atb                     (atx_pll_lc_atb                    ),
       .atx_pll_cp_compensation_enable     (atx_pll_cp_compensation_enable    ),
       .atx_pll_cp_current_setting         (atx_pll_cp_current_setting        ),
       .atx_pll_cp_testmode                (atx_pll_cp_testmode               ),
       .atx_pll_cp_lf_3rd_pole_freq        (atx_pll_cp_lf_3rd_pole_freq       ),
       .atx_pll_cp_lf_order                (atx_pll_cp_lf_order               ),
       .atx_pll_lf_resistance              (atx_pll_lf_resistance             ),
       .atx_pll_lf_ripplecap               (atx_pll_lf_ripplecap              ),
       .atx_pll_d2a_voltage                (atx_pll_d2a_voltage               ),
       .atx_pll_dsm_out_sel                (atx_pll_dsm_out_sel               ),
       .atx_pll_dsm_ecn_bypass             (atx_pll_dsm_ecn_bypass            ),
       .atx_pll_dsm_ecn_test_en            (atx_pll_dsm_ecn_test_en           ),
       .atx_pll_dsm_fractional_value_ready (atx_pll_dsm_fractional_value_ready),
       .atx_pll_vco_bypass_enable          (atx_pll_vco_bypass_enable         ),
       .atx_pll_cascadeclk_test            (atx_pll_cascadeclk_test           ),
       .atx_pll_tank_voltage_coarse        (atx_pll_tank_voltage_coarse       ),
       .atx_pll_tank_voltage_fine          (atx_pll_tank_voltage_fine         ),
       .atx_pll_output_regulator_supply    (atx_pll_output_regulator_supply   ),
       .atx_pll_overrange_voltage          (atx_pll_overrange_voltage         ),
       .atx_pll_underrange_voltage         (atx_pll_underrange_voltage        ),
       .atx_pll_is_cascaded_pll            (atx_pll_is_cascaded_pll           ),
       .atx_pll_is_otn                     (atx_pll_is_otn                    ),
       .atx_pll_is_sdi                     (atx_pll_is_sdi                    ),
       .atx_pll_side                       (atx_pll_side                      ),

	   .atx_pll_lf_cbig_size               (atx_pll_lf_cbig_size              ),
	   .atx_pll_enable_hclk                (atx_pll_enable_hclk               ),
	   .atx_pll_calibration_mode           (atx_pll_calibration_mode          ),
       .atx_pll_datarate                   (atx_pll_datarate                  ),
       .atx_pll_device_variant             (atx_pll_device_variant            ),
	   .atx_pll_initial_settings           (atx_pll_initial_settings          ),
	   .atx_pll_l_counter_scratch          (atx_pll_l_counter_scratch         ),
	   .atx_pll_n_counter_scratch          (atx_pll_n_counter_scratch         ),
	   .atx_pll_powerdown_mode             (atx_pll_powerdown_mode            ),
	   .atx_pll_sup_mode                   (atx_pll_sup_mode                  ),
	   .atx_pll_vco_freq                   (atx_pll_vco_freq                  ),
       .atx_pll_fpll_refclk_selection      (atx_pll_fpll_refclk_selection     ), 
       .lc_to_fpll_l_counter               (atx_pll_lc_to_fpll_l_counter),
       .lc_to_fpll_l_counter_scratch       (atx_pll_lc_to_fpll_l_counter_scratch),

       .hssi_pma_lc_refclk_select_mux_powerdown_mode(hssi_pma_lc_refclk_select_mux_powerdown_mode),
       .hssi_pma_lc_refclk_select_mux_refclk_select(hssi_pma_lc_refclk_select_mux_refclk_select),
       .hssi_pma_lc_refclk_select_mux_silicon_rev(hssi_pma_lc_refclk_select_mux_silicon_rev),

       .hssi_pma_lc_refclk_select_mux_inclk0_logical_to_physical_mapping (hssi_pma_lc_refclk_select_mux_inclk0_logical_to_physical_mapping),
       .hssi_pma_lc_refclk_select_mux_inclk1_logical_to_physical_mapping (hssi_pma_lc_refclk_select_mux_inclk1_logical_to_physical_mapping),
       .hssi_pma_lc_refclk_select_mux_inclk2_logical_to_physical_mapping (hssi_pma_lc_refclk_select_mux_inclk2_logical_to_physical_mapping),
       .hssi_pma_lc_refclk_select_mux_inclk3_logical_to_physical_mapping (hssi_pma_lc_refclk_select_mux_inclk3_logical_to_physical_mapping),
       .hssi_pma_lc_refclk_select_mux_inclk4_logical_to_physical_mapping (hssi_pma_lc_refclk_select_mux_inclk4_logical_to_physical_mapping),

       .hssi_refclk_divider_silicon_rev(hssi_refclk_divider_silicon_rev),

       .enable_mcgb(enable_mcgb),
       .enable_mcgb_debug_ports_parameters(enable_mcgb_debug_ports_parameters),
       .hssi_pma_cgb_master_silicon_rev                        (hssi_pma_cgb_master_silicon_rev),
       .hssi_pma_cgb_master_prot_mode                          (hssi_pma_cgb_master_prot_mode),
       .hssi_pma_cgb_master_cgb_enable_iqtxrxclk               (hssi_pma_cgb_master_cgb_enable_iqtxrxclk),
       .hssi_pma_cgb_master_x1_div_m_sel                       (hssi_pma_cgb_master_x1_div_m_sel),
       .hssi_pma_cgb_master_ser_mode                           (hssi_pma_cgb_master_ser_mode),
       .hssi_pma_cgb_master_datarate                           (hssi_pma_cgb_master_datarate),

       .hssi_pma_cgb_master_cgb_power_down                     (hssi_pma_cgb_master_cgb_power_down                    ),
       .hssi_pma_cgb_master_observe_cgb_clocks                 (hssi_pma_cgb_master_observe_cgb_clocks                ),
       .hssi_pma_cgb_master_op_mode                            (hssi_pma_cgb_master_op_mode                           ),
       .hssi_pma_cgb_master_tx_ucontrol_reset_pcie             (hssi_pma_cgb_master_tx_ucontrol_reset_pcie            ),
       .hssi_pma_cgb_master_vccdreg_output                     (hssi_pma_cgb_master_vccdreg_output                    ),
       .hssi_pma_cgb_master_input_select                       (hssi_pma_cgb_master_input_select                      ),
       .hssi_pma_cgb_master_input_select_gen3                  (hssi_pma_cgb_master_input_select_gen3                 ),

       .hssi_pma_cgb_master_bonding_reset_enable               (hssi_pma_cgb_master_bonding_reset_enable              ),
       .hssi_pma_cgb_master_optimal                            (hssi_pma_cgb_master_optimal                           ), 
	   .hssi_pma_cgb_master_pcie_gen3_bitwidth                 (hssi_pma_cgb_master_pcie_gen3_bitwidth                ),
	   .hssi_pma_cgb_master_powerdown_mode                     (hssi_pma_cgb_master_powerdown_mode                    ),
	   .hssi_pma_cgb_master_sup_mode                           (hssi_pma_cgb_master_sup_mode                          ),
	   .hssi_pma_cgb_master_initial_settings                   (hssi_pma_cgb_master_initial_settings                  )
    )
    a10_xcvr_atx_pll_inst (
       .pll_powerdown(~pll_powerdown_int),                        
       .pll_refclk0(pll_refclk0),          
       .pll_refclk1(pll_refclk1),          
       .pll_refclk2(pll_refclk2),          
       .pll_refclk3(pll_refclk3),          
       .pll_refclk4(pll_refclk4),          
     
       .mcgb_aux_clk0(mcgb_aux_clk0),   
       .mcgb_aux_clk1(mcgb_aux_clk1),
       .mcgb_aux_clk2(mcgb_aux_clk2),

       .mcgb_pcie_sw(pcie_sw),

       .pll_serial_clk_8g(tx_serial_clk),                   
       .pll_serial_clk_16g(tx_serial_clk_gt),
       .pll_locked(pll_locked), 
       .pll_pcie_clk(pll_pcie_clk), 
       .pll_cascade_clk(pll_cascade_clk),                     
       .lc_to_fpll_refclk(atx_to_fpll_cascade_clk),

       .mcgb_rst(~mcgb_rst_input), 
       .tx_bonding_clocks(tx_bonding_clocks),               
       .mcgb_serial_clk(mcgb_serial_clk),                      
       .mcgb_pcie_sw_done(pcie_sw_done), 

       .pll_avmm_clk(pll_avmm_clk),
       .pll_avmm_rstn(pll_avmm_rstn),
       .pll_avmm_writedata(pll_avmm_writedata),
       .pll_avmm_address(pll_avmm_address),
       .pll_avmm_write(pll_avmm_write),
       .pll_avmm_read(pll_avmm_read),
       .pll_avmmreaddata_lc(pll_avmmreaddata_lc),
       .pll_avmmreaddata_refclk(pll_avmmreaddata_refclk),
       .pll_blockselect_lc(pll_blockselect_lc),
       .pll_blockselect_refclk(pll_blockselect_refclk),
       .pll_avmmreaddata_mcgb(pll_avmmreaddata_mcgb),
       .pll_blockselect_mcgb(pll_blockselect_mcgb),
 
       .clklow(clklow),
       .fref(fref), 
       .overrange(overrange),
       .underrange(underrange)                          
    );
    // PLL ENDS 
    //-----------------------------------

    //-----------------------------------
    // Pulling in the rule for calibration attributes from PCS channel RBC
    localparam  arbiter_ctrl      = (calibration_en == "enable") ? "uc"                : "pld";
    localparam  cal_done          = (calibration_en == "enable") ? "cal_done_deassert" : "cal_done_assert";
    localparam  hip_cal_en_fnl    = (calibration_en == "enable") ? hip_cal_en          : "disable";
    localparam  avmm_busy_en      = rcfg_separate_avmm_busy ? "enable" : "disable";

    // AVMM  STARTS 
    twentynm_xcvr_avmm
    #(
       .avmm_interfaces(avmm_interfaces),
       .calibration_en(calibration_en),   
       .avmm_busy_en (avmm_busy_en),
       .arbiter_ctrl(arbiter_ctrl),   
       .cal_done(cal_done),      
       .rcfg_enable(enable_pll_reconfig),              
       .enable_avmm(1),              
       .hip_cal_en(hip_cal_en_fnl)
    )
    a10_xcvr_avmm_inst (
       .avmm_clk(       {reconfig_clk           } ),
       .avmm_reset(     {reconfig_reset         } ),
       .avmm_writedata( {reconfig_writedata     } ),
       .avmm_address(   {reconfig_address       } ),
       .avmm_write(     {reconfig_write         } ),
       .avmm_read(      {reconfig_read          } ),
       .avmm_readdata(  {reconfig_readdata      } ),
       .avmm_waitrequest({reconfig_waitrequest  } ),
       .avmm_busy(      {avmm_busy              } ),
       .pld_cal_done(   {pld_cal_done           } ),
       .hip_cal_done(   {hip_cal_done_w         } ),

       .chnl_pll_avmm_clk(pll_avmm_clk),
       .chnl_pll_avmm_rstn(pll_avmm_rstn),
       .chnl_pll_avmm_writedata(pll_avmm_writedata),
       .chnl_pll_avmm_address(pll_avmm_address),
       .chnl_pll_avmm_write(pll_avmm_write),
       .chnl_pll_avmm_read(pll_avmm_read),

       .pll_avmmreaddata_lc_pll(pll_avmmreaddata_lc),                           
       .pll_avmmreaddata_lc_refclk_select(pll_avmmreaddata_refclk), 
       .pll_avmmreaddata_cgb_master(pll_avmmreaddata_mcgb),                                        

       .pll_blockselect_lc_pll(pll_blockselect_lc),            
       .pll_blockselect_lc_refclk_select(pll_blockselect_refclk),  
       .pll_blockselect_cgb_master(pll_blockselect_mcgb),

       //-----------------------------------
       // IRRELEVANT PORTS
       .pma_avmmreaddata_tx_ser                   ( {avmm_interfaces{8'b0}} ),
       .pma_avmmreaddata_tx_cgb                   ( {avmm_interfaces{8'b0}} ),
       .pma_avmmreaddata_tx_buf                   ( {avmm_interfaces{8'b0}} ),
       .pma_avmmreaddata_rx_deser                 ( {avmm_interfaces{8'b0}} ),
       .pma_avmmreaddata_rx_buf                   ( {avmm_interfaces{8'b0}} ),
       .pma_avmmreaddata_rx_sd                    ( {avmm_interfaces{8'b0}} ),
       .pma_avmmreaddata_rx_odi                   ( {avmm_interfaces{8'b0}} ),
       .pma_avmmreaddata_rx_dfe                   ( {avmm_interfaces{8'b0}} ),
       .pma_avmmreaddata_cdr_pll                  ( {avmm_interfaces{8'b0}} ),
       .pma_avmmreaddata_cdr_refclk_select        ( {avmm_interfaces{8'b0}} ),
       .pma_avmmreaddata_pma_adapt                ( {avmm_interfaces{8'b0}} ),
       .pma_blockselect_tx_ser                    ( {avmm_interfaces{1'b0}} ),
       .pma_blockselect_tx_cgb                    ( {avmm_interfaces{1'b0}} ),
       .pma_blockselect_tx_buf                    ( {avmm_interfaces{1'b0}} ),
       .pma_blockselect_rx_deser                  ( {avmm_interfaces{1'b0}} ),
       .pma_blockselect_rx_buf                    ( {avmm_interfaces{1'b0}} ),
       .pma_blockselect_rx_sd                     ( {avmm_interfaces{1'b0}} ),
       .pma_blockselect_rx_odi                    ( {avmm_interfaces{1'b0}} ),
       .pma_blockselect_rx_dfe                    ( {avmm_interfaces{1'b0}} ),
       .pma_blockselect_cdr_pll                   ( {avmm_interfaces{1'b0}} ),
       .pma_blockselect_cdr_refclk_select         ( {avmm_interfaces{1'b0}} ),
       .pma_blockselect_pma_adapt                 ( {avmm_interfaces{1'b0}} ),
       .pcs_avmmreaddata_8g_rx_pcs                ( {avmm_interfaces{8'b0}} ),
       .pcs_avmmreaddata_pipe_gen1_2              ( {avmm_interfaces{8'b0}} ),
       .pcs_avmmreaddata_8g_tx_pcs                ( {avmm_interfaces{8'b0}} ),
       .pcs_avmmreaddata_10g_rx_pcs               ( {avmm_interfaces{8'b0}} ),
       .pcs_avmmreaddata_10g_tx_pcs               ( {avmm_interfaces{8'b0}} ),
       .pcs_avmmreaddata_gen3_rx_pcs              ( {avmm_interfaces{8'b0}} ),
       .pcs_avmmreaddata_pipe_gen3                ( {avmm_interfaces{8'b0}} ),
       .pcs_avmmreaddata_gen3_tx_pcs              ( {avmm_interfaces{8'b0}} ),
       .pcs_avmmreaddata_krfec_rx_pcs             ( {avmm_interfaces{8'b0}} ),
       .pcs_avmmreaddata_krfec_tx_pcs             ( {avmm_interfaces{8'b0}} ),
       .pcs_avmmreaddata_fifo_rx_pcs              ( {avmm_interfaces{8'b0}} ),
       .pcs_avmmreaddata_fifo_tx_pcs              ( {avmm_interfaces{8'b0}} ),
       .pcs_avmmreaddata_rx_pcs_pld_if            ( {avmm_interfaces{8'b0}} ),
       .pcs_avmmreaddata_com_pcs_pld_if           ( {avmm_interfaces{8'b0}} ),
       .pcs_avmmreaddata_tx_pcs_pld_if            ( {avmm_interfaces{8'b0}} ),
       .pcs_avmmreaddata_rx_pcs_pma_if            ( {avmm_interfaces{8'b0}} ),
       .pcs_avmmreaddata_com_pcs_pma_if           ( {avmm_interfaces{8'b0}} ),
       .pcs_avmmreaddata_tx_pcs_pma_if            ( {avmm_interfaces{8'b0}} ),
       .pcs_blockselect_8g_rx_pcs                 ( {avmm_interfaces{1'b0}} ),
       .pcs_blockselect_pipe_gen1_2               ( {avmm_interfaces{1'b0}} ),
       .pcs_blockselect_8g_tx_pcs                 ( {avmm_interfaces{1'b0}} ),
       .pcs_blockselect_10g_rx_pcs                ( {avmm_interfaces{1'b0}} ),
       .pcs_blockselect_10g_tx_pcs                ( {avmm_interfaces{1'b0}} ),
       .pcs_blockselect_gen3_rx_pcs               ( {avmm_interfaces{1'b0}} ),
       .pcs_blockselect_pipe_gen3                 ( {avmm_interfaces{1'b0}} ),
       .pcs_blockselect_gen3_tx_pcs               ( {avmm_interfaces{1'b0}} ),
       .pcs_blockselect_krfec_rx_pcs              ( {avmm_interfaces{1'b0}} ),
       .pcs_blockselect_krfec_tx_pcs              ( {avmm_interfaces{1'b0}} ),
       .pcs_blockselect_fifo_rx_pcs               ( {avmm_interfaces{1'b0}} ),
       .pcs_blockselect_fifo_tx_pcs               ( {avmm_interfaces{1'b0}} ),
       .pcs_blockselect_rx_pcs_pld_if             ( {avmm_interfaces{1'b0}} ),
       .pcs_blockselect_com_pcs_pld_if            ( {avmm_interfaces{1'b0}} ),
       .pcs_blockselect_tx_pcs_pld_if             ( {avmm_interfaces{1'b0}} ),
       .pcs_blockselect_rx_pcs_pma_if             ( {avmm_interfaces{1'b0}} ),
       .pcs_blockselect_com_pcs_pma_if            ( {avmm_interfaces{1'b0}} ),
       .pcs_blockselect_tx_pcs_pma_if             ( {avmm_interfaces{1'b0}} ),
       .pll_avmmreaddata_cmu_fpll                 ( {avmm_interfaces{8'b0}} ),
       .pll_avmmreaddata_cmu_fpll_refclk_select   ( {avmm_interfaces{8'b0}} ),
       .pll_blockselect_cmu_fpll                  ( {avmm_interfaces{1'b0}} ),
       .pll_blockselect_cmu_fpll_refclk_select    ( {avmm_interfaces{1'b0}} )
    );
    // AVMM  ENDS
    //-----------------------------------       
endmodule


