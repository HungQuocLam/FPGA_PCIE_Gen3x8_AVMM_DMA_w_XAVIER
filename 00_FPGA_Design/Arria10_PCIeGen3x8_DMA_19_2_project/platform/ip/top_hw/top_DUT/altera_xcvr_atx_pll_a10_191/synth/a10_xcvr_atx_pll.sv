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
// filename: a10_xcvr_atx_pll.sv
//
// Description : instantiates lc-pll atoms
//
// Limitation  : Intended for NightFury
//
// Copyright (c) Altera Corporation 1997-2012
// All rights reserved
//-------------------------------------------------------------------
//
// NOTEs
// - comments marked with \OPEN means there is an issue that needs to be resolved but cannot be done due to lack of information.
// - comments marked with \TODO means there is an issue that needs to be resolved and there is enough information already for the issue to be resolved.
//
//-------------------------------------------------------------------


// \OPEN should we remove timescale?
`timescale 1 ns / 1 ns

module a10_xcvr_atx_pll 
#(
    // \OPEN previous atx atom had hclk_buffer_enable [CM: will find out]

    parameter enable_debug_info = "true",             // \RANGE false|true      \NOTE this is simulation-only parameter, for debug purpose only                                                
    parameter atx_pll_regulator_bypass = "reg_enable",
    parameter atx_pll_pfd_delay_compensation = "normal_delay",
    parameter atx_pll_xcpvco_xchgpmplf_cp_current_boost = "normal_setting",
    parameter atx_pll_pfd_pulse_width = "pulse_width_setting0",

    parameter atx_pll_l_counter_enable = "true",      // \RANGE true (false)
    parameter atx_pll_fb_select = "direct_fb",        // \RANGE "direct_fb" "iqtxrxclk_fb"
    parameter atx_pll_bonding_mode = "cpri_bonding",  // \RANGE (cpri_bonding) pll_bonding \NOTE CPRI is for external feedback mode without feedback compensation bonding and PLL is for external feedback with feedback compensation bonding
    parameter atx_pll_prot_mode = "basic_tx",         // \RANGE  "unused" (basic_tx) "basic_kr_tx" "pcie_gen1_tx" "pcie_gen2_tx" "pcie_gen3_tx" "pcie_gen4_tx" "cei_tx" "qpi_tx" "cpri_tx" "fc_tx" "srio_tx" "gpon_tx" "sdi_tx" "sata_tx" "xaui_tx" "obsai_tx" "gige_tx" "higig_tx" "sonet_tx" "sfp_tx" "xfp_tx" "sfi_tx"
    parameter atx_pll_silicon_rev = "20nm5es",        // \RANGE (20nm5es) "20nm5es2" "20nm4" "20nm3" "20nm4qor" "20nm2" "20nm1"
    parameter atx_pll_bw_sel = "low",                 // \RANGE (low) medium high
    parameter atx_pll_dsm_mode = "dsm_mode_integer",  // \RANGE (dsm_mode_integer) dsm_mode_phase
    parameter atx_pll_reference_clock_frequency = "0 ps",
    parameter atx_pll_output_clock_frequency = "0 ps",
    parameter atx_pll_m_counter = 1,                  // \RANGE (1) 2 3 4 5 6 8 9 10 12 15 16 18 20 24 25 30 32 36 40 48 50 60 64 80 100
    parameter atx_pll_ref_clk_div = 1,                // \RANGE (1) 2 4 8
    parameter atx_pll_l_counter = 1,                  // \RANGE (1) 2 4 8 16
    parameter atx_pll_dsm_fractional_division = 32'b1,  // (32'b1) bitvec
    parameter atx_pll_tank_band = "lc_band0",         // \RANGE (lc_band0) lc_band1 lc_band2 lc_band3 lc_band4 lc_band5 lc_band6 lc_band7
    parameter atx_pll_tank_sel = "lctank0",           // \RANGE (lctank0) lctank1 lctank2
    parameter atx_pll_hclk_divide = 1,                // \RANGE (1) 40 50
    parameter atx_pll_cgb_div = 1,                    // \RANGE (1) 2 4 8
    parameter atx_pll_pma_width = 8,                  // \RANGE (8) 10 16 20 32 40 64

    parameter atx_pll_primary_use                = "hssi_x1",
    parameter atx_pll_lc_mode                    = "lccmu_normal",         // \RANGE (lccmu_pd) lccmu_normal lccmu_reset
    parameter atx_pll_lc_atb                     = "atb_selectdisable",    // \RANGE (atb_selectdisable) atb_select0 atb_select1 atb_select2 atb_select3 atb_select4 atb_select5 atb_select6 atb_select7 atb_select8 atb_select9 atb_select10 atb_select11 atb_select12 atb_select13 atb_select14 atb_select15 atb_select16 atb_select17 atb_select18 atb_select19 atb_select20 atb_select21 atb_select22 atb_select23 atb_select24 atb_select25 atb_select26 atb_select27 atb_select28 atb_select29 atb_select30
    parameter atx_pll_cp_compensation_enable     = "true",                 // \RANGE false (true)
    parameter atx_pll_cp_current_setting         = "cp_current_setting0",  // \RANGE (cp_current_setting0) cp_current_setting1 cp_current_setting2 cp_current_setting3 cp_current_setting4 cp_current_setting5 cp_current_setting6 cp_current_setting7 cp_current_setting8 cp_current_setting9 cp_current_setting10 cp_current_setting11
    parameter atx_pll_cp_testmode                = "cp_normal",            // \RANGE (cp_normal) cp_test_up cp_test_dn cp_tristate
    parameter atx_pll_cp_lf_3rd_pole_freq        = "lf_3rd_pole_setting0", // \RANGE (lf_3rd_pole_setting0) lf_3rd_pole_setting1 lf_3rd_pole_setting2 lf_3rd_pole_setting3
    parameter atx_pll_cp_lf_order                = "lf_2nd_order",         // \RANGE (lf_2nd_order) lf_3rd_order lf_4th_order
    parameter atx_pll_lf_resistance              = "lf_setting0",          // \RANGE (lf_setting0) lf_setting1 lf_setting2 lf_setting3
    parameter atx_pll_lf_ripplecap               = "lf_ripple_cap_0",      // \RANGE lf_no_ripple (lf_ripple_cap_0) lf_ripplecap_1
    parameter atx_pll_d2a_voltage                = "d2a_disable",          // \RANGE d2a_setting_0 d2a_setting_1 d2a_setting_2 d2a_setting_3 d2a_setting_4 d2a_setting_5 d2a_setting_6 d2a_setting_7 (d2a_disable)
    parameter atx_pll_dsm_out_sel                = "pll_dsm_disable",      // \RANGE (pll_dsm_disable) pll_dsm_1st_order pll_dsm_2nd_order pll_dsm_3rd_order
    parameter atx_pll_dsm_ecn_bypass             = "false",                // \RANGE (false) true
    parameter atx_pll_dsm_ecn_test_en            = "false",                // \RANGE (false) true
    parameter atx_pll_dsm_fractional_value_ready = "pll_k_ready",          // \RANGE pll_k_not_ready (pll_k_ready)
    parameter atx_pll_vco_bypass_enable          = "false",                // \RANGE (false) true
    parameter atx_pll_cascadeclk_test            = "cascadetest_off",      // \RANGE (cascadetest_off) cascadetest_on
    parameter atx_pll_tank_voltage_coarse        = "vreg_setting_coarse1", // \RANGE vreg_setting_coarse0 (vreg_setting_coarse1) vreg_setting_coarse2 vreg_setting_coarse3
    parameter atx_pll_tank_voltage_fine          = "vreg_setting3",        // \RANGE vreg_setting0 vreg_setting1 vreg_setting2 (vreg_setting3) vreg_setting4 vreg_setting5 vreg_setting6 vreg_setting7
    parameter atx_pll_output_regulator_supply    = "vreg1v_setting1",      // \RANGE vreg1v_setting0 (vreg1v_setting1) vreg1v_setting2 vreg1v_setting3
    parameter atx_pll_overrange_voltage          = "over_setting3",        // \RANGE over_setting0 over_setting1 over_setting2 (over_setting3) over_setting4 over_setting5 over_setting6 over_setting7
    parameter atx_pll_underrange_voltage         = "under_setting3",       // \RANGE under_setting0 under_setting1 under_setting2 (under_setting3) under_setting4 under_setting5 under_setting6 under_setting7
    parameter atx_pll_is_cascaded_pll            = "false",                // \RANGE (false) true
    parameter atx_pll_is_otn                     = "false",                // \RANGE (false) true
    parameter atx_pll_is_sdi                     = "false",                // \RANGE (false) true
    parameter atx_pll_side                       = "side_unknown",         // \RANGE (side_unknown) left right

	parameter	atx_pll_lf_cbig_size             = "lf_cbig_setting0" ,		// \RANGE (lf_cbig_setting0) , lf_cbig_setting1 , lf_cbig_setting2 , lf_cbig_setting3 , lf_cbig_setting4 
	parameter	atx_pll_iqclk_mux_sel            = "power_down" ,		    // \RANGE iqtxrxclk0 , iqtxrxclk1 , iqtxrxclk2 , iqtxrxclk3 , iqtxrxclk4 , iqtxrxclk5 , (power_down)
	parameter	atx_pll_enable_hclk              = "hclk_disabled" ,		// \RANGE (hclk_disabled), hclk_enable 
	parameter	atx_pll_calibration_mode         = "cal_off" ,		        // \RANGE (cal_off), uc_rst_pll , uc_rst_lf , uc_not_rst 
	parameter	atx_pll_datarate                 = "0 bps" ,		        // \RANGE  
	parameter	atx_pll_device_variant           = "device1" ,		        // \RANGE (device1), device2 , device3 , device4 , device5 
	parameter	atx_pll_initial_settings         = "false" ,		        // \RANGE (false), true 
	parameter	[4:0] atx_pll_l_counter_scratch  = 5'b00001 ,		        // \RANGE (5) 
	parameter	[2:0] atx_pll_n_counter_scratch  = 3'b001 ,		            // \RANGE (3) 
	parameter	atx_pll_powerdown_mode           = "powerup" ,		        // \RANGE (powerup) , powerdown 
	parameter	atx_pll_sup_mode                 = "user_mode" ,		    // \RANGE (user_mode) , engineering_mode 
	parameter	atx_pll_vco_freq                 = "0 hz",		            // \RANGE  
	parameter	atx_pll_fpll_refclk_selection    = "select_div_by_2",       // \RANGE (select_div_by_2), select_vco_output
    parameter   lc_to_fpll_l_counter             = "lcounter_setting0",     // \RANGE (lcounter_setting0) .. lcounter_setting31
    parameter   lc_to_fpll_l_counter_scratch     = 5'b00000,     // \RANGE (5)

   	parameter hssi_pma_lc_refclk_select_mux_powerdown_mode = "powerup",   // \RANGE (powerup) powerdown     
   	parameter hssi_pma_lc_refclk_select_mux_refclk_select = "ref_iqclk0", // \RANGE (ref_iqclk0) ref_iqclk1 ref_iqclk2 ref_iqclk3 ref_iqclk4 ref_iqclk5 ref_iqclk6 ref_iqclk7 ref_iqclk8 ref_iqclk9 ref_iqclk10 ref_iqclk11 iqtxrxclk0 iqtxrxclk1 iqtxrxclk2 iqtxrxclk3 iqtxrxclk4 iqtxrxclk5 coreclk fixed_clk lvpecl adj_pll_clk power_down     
    parameter hssi_pma_lc_refclk_select_mux_silicon_rev = "20nm5es",          // \RANGE (20nm5es) "20nm5es2" "20nm4" "20nm3" "20nm4qor" "20nm2" "20nm1"

    parameter hssi_pma_lc_refclk_select_mux_inclk0_logical_to_physical_mapping = "ref_iqclk0",           // \RANGE (ref_iqclk0) ref_iqclk1 ref_iqclk2 ref_iqclk3 ref_iqclk4 ref_iqclk5 ref_iqclk6 ref_iqclk7 ref_iqclk8 ref_iqclk9 ref_iqclk10 ref_iqclk11 iqtxrxclk0 iqtxrxclk1 iqtxrxclk2 iqtxrxclk3 iqtxrxclk4 iqtxrxclk5 coreclk fixed_clk lvpecl adj_pll_clk power_down
    parameter hssi_pma_lc_refclk_select_mux_inclk1_logical_to_physical_mapping = "ref_iqclk1",           // \RANGE (ref_iqclk0) ref_iqclk1 ref_iqclk2 ref_iqclk3 ref_iqclk4 ref_iqclk5 ref_iqclk6 ref_iqclk7 ref_iqclk8 ref_iqclk9 ref_iqclk10 ref_iqclk11 iqtxrxclk0 iqtxrxclk1 iqtxrxclk2 iqtxrxclk3 iqtxrxclk4 iqtxrxclk5 coreclk fixed_clk lvpecl adj_pll_clk power_down
    parameter hssi_pma_lc_refclk_select_mux_inclk2_logical_to_physical_mapping = "ref_iqclk2",           // \RANGE (ref_iqclk0) ref_iqclk1 ref_iqclk2 ref_iqclk3 ref_iqclk4 ref_iqclk5 ref_iqclk6 ref_iqclk7 ref_iqclk8 ref_iqclk9 ref_iqclk10 ref_iqclk11 iqtxrxclk0 iqtxrxclk1 iqtxrxclk2 iqtxrxclk3 iqtxrxclk4 iqtxrxclk5 coreclk fixed_clk lvpecl adj_pll_clk power_down
    parameter hssi_pma_lc_refclk_select_mux_inclk3_logical_to_physical_mapping = "ref_iqclk3",           // \RANGE (ref_iqclk0) ref_iqclk1 ref_iqclk2 ref_iqclk3 ref_iqclk4 ref_iqclk5 ref_iqclk6 ref_iqclk7 ref_iqclk8 ref_iqclk9 ref_iqclk10 ref_iqclk11 iqtxrxclk0 iqtxrxclk1 iqtxrxclk2 iqtxrxclk3 iqtxrxclk4 iqtxrxclk5 coreclk fixed_clk lvpecl adj_pll_clk power_down
    parameter hssi_pma_lc_refclk_select_mux_inclk4_logical_to_physical_mapping = "ref_iqclk4",           // \RANGE (ref_iqclk0) ref_iqclk1 ref_iqclk2 ref_iqclk3 ref_iqclk4 ref_iqclk5 ref_iqclk6 ref_iqclk7 ref_iqclk8 ref_iqclk9 ref_iqclk10 ref_iqclk11 iqtxrxclk0 iqtxrxclk1 iqtxrxclk2 iqtxrxclk3 iqtxrxclk4 iqtxrxclk5 coreclk fixed_clk lvpecl adj_pll_clk power_down

    parameter hssi_refclk_divider_silicon_rev = "20nm5es",        // \RANGE (20nm5es) "20nm5es2" "20nm4" "20nm3" "20nm4qor" "20nm2" "20nm1"
    parameter enable_mcgb = 0,                                             // \RANGE (0) 1
    parameter enable_mcgb_debug_ports_parameters = 0,                      // \RANGE (0) 1
    parameter avmm_interfaces = ((enable_mcgb==1) && (enable_mcgb_debug_ports_parameters==1)) ? 2 : 1,
    
    parameter hssi_pma_cgb_master_silicon_rev = "20nm5es",                      // \RANGE (20nm5es) "20nm5es2" "20nm4" "20nm3" "20nm4qor" "20nm2" "20nm1"
    parameter hssi_pma_cgb_master_prot_mode = "basic_tx",                       // \RANGE  "unused" (basic_tx) "basic_kr_tx" "pcie_gen1_tx" "pcie_gen2_tx" "pcie_gen3_tx" "pcie_gen4_tx" "cei_tx" "qpi_tx" "cpri_tx" "fc_tx" "srio_tx" "gpon_tx" "sdi_tx" "sata_tx" "xaui_tx" "obsai_tx" "gige_tx" "higig_tx" "sonet_tx" "sfp_tx" "xfp_tx" "sfi_tx"
    parameter hssi_pma_cgb_master_cgb_enable_iqtxrxclk = "disable_iqtxrxclk",   // \OPEN in atom default is enable in _hw.tcl default is disable // \RANGE disable_iqtxrxclk (enable_iqtxrxclk) 
    parameter hssi_pma_cgb_master_x1_div_m_sel = "divbypass",                   // \RANGE (divbypass) divby2 divby4 divby8
    parameter hssi_pma_cgb_master_ser_mode = "eight_bit",                       // \RANGE (eight_bit) ten_bit sixteen_bit twenty_bit thirty_two_bit forty_bit sixty_four_bit
    parameter hssi_pma_cgb_master_datarate = "0 Mbps",

    parameter hssi_pma_cgb_master_cgb_power_down                     = "normal_cgb",                  // \RANGE normal_cgb (power_down_cgb)                           
    parameter hssi_pma_cgb_master_bonding_reset_enable               = "allow_bonding_reset",         // \RANGE disallow_bonding_reset (allow_bonding_reset) 
    parameter hssi_pma_cgb_master_observe_cgb_clocks                 = "observe_nothing",             // \RANGE (observe_nothing) observe_x1mux_out   
    parameter hssi_pma_cgb_master_optimal                            = "true",                        // \RANGE (true) false   
    parameter hssi_pma_cgb_master_op_mode                            = "enabled",                     // \RANGE (enabled) pwr_down             
    parameter hssi_pma_cgb_master_tx_ucontrol_reset_pcie             = "pcscorehip_controls_mcgb",    // \RANGE (pcscorehip_controls_mcgb) cgb_reset tx_pcie_gen1 tx_pcie_gen2 tx_pcie_gen3 tx_pcie_gen4  
    parameter hssi_pma_cgb_master_vccdreg_output                     = "vccdreg_nominal",             // \RANGE (vccdreg_nominal) vccdreg_pos_setting0 vccdreg_pos_setting1 vccdreg_pos_setting2 vccdreg_pos_setting3 vccdreg_pos_setting4 vccdreg_pos_setting5 vccdreg_pos_setting6 vccdreg_pos_setting7 vccdreg_pos_setting8 vccdreg_pos_setting9 vccdreg_pos_setting10 vccdreg_pos_setting11 vccdreg_pos_setting12 vccdreg_pos_setting13 vccdreg_pos_setting14 vccdreg_pos_setting15 reserved1 reserved2 vccdreg_neg_setting0 vccdreg_neg_setting1 vccdreg_neg_setting2 vccdreg_neg_setting3 reserved3 reserved4 reserved5 reserved6 reserved7 reserved8 reserved9 reserved10 reserved11   
    parameter hssi_pma_cgb_master_input_select                       = "lcpll_top",                   // \RANGE lcpll_bot lcpll_top fpll_bot fpll_top (unused)      
    parameter hssi_pma_cgb_master_input_select_gen3                  = "unused" ,                     // \RANGE lcpll_bot lcpll_top fpll_bot fpll_top (unused) 
	parameter hssi_pma_cgb_master_pcie_gen3_bitwidth                 = "pciegen3_wide" ,		      // \RANGE (pciegen3_wide) pciegen3_narrow parameter	powerdown_mode = "powerup" ,		//Valid values: powerup , powerdown 
	parameter hssi_pma_cgb_master_powerdown_mode                     = "powerup" ,		              // \RANGE (powerup) powerdown 
	parameter hssi_pma_cgb_master_sup_mode                           = "user_mode" ,		          // \RANGE (user_mode) engineering_mode 
	parameter hssi_pma_cgb_master_initial_settings                   = "false" 		                  // \RANGE (false) true 
) (
    input pll_powerdown,                              // \OPEN verify connection to atoms(lc and cgb)   
    input pll_refclk0,                                // \OPEN verify connection to atom(mux) (currently LSB of ref_iqclk(rest is all-0s))
    input pll_refclk1,                                // \OPEN verify connection to atom(mux) (currently LSB of ref_iqclk(rest is all-0s))
    input pll_refclk2,                                // \OPEN verify connection to atom(mux) (currently LSB of ref_iqclk(rest is all-0s))
    input pll_refclk3,                                // \OPEN verify connection to atom(mux) (currently LSB of ref_iqclk(rest is all-0s))
    input pll_refclk4,                                // \OPEN verify connection to atom(mux) (currently LSB of ref_iqclk(rest is all-0s))
    input mcgb_aux_clk0,                               // \OPEN verify connection to atom(cgb) ()                                                              
    input mcgb_aux_clk1,                               // \OPEN verify connection to atom(cgb) ()                                                              
    input mcgb_aux_clk2,                               // \OPEN verify connection to atom(cgb) ()                                                              

    input [1:0] mcgb_pcie_sw,

    output pll_serial_clk_8g,                   
    output pll_serial_clk_16g,
    output pll_locked, 
    output pll_pcie_clk, 
    output pll_cascade_clk, 
    output lc_to_fpll_refclk,

    input  mcgb_rst,
    output [5:0] tx_bonding_clocks,                     // \OPEN should hardcoded width come from a definition?
    output mcgb_serial_clk,                            
    output [1:0] mcgb_pcie_sw_done,  

    // \NOTE reconfig for lc-pll and refclk_select atoms
    input  [avmm_interfaces-1:0] pll_avmm_clk,
    input  [avmm_interfaces-1:0] pll_avmm_rstn,
    input  [8*avmm_interfaces-1:0] pll_avmm_writedata,
    input  [9*avmm_interfaces-1:0] pll_avmm_address,
    input  [avmm_interfaces-1:0] pll_avmm_write,
    input  [avmm_interfaces-1:0] pll_avmm_read,
    output [8*avmm_interfaces-1:0] pll_avmmreaddata_lc,            // \OPEN [8:0] is bus size defined somewhere
    output [avmm_interfaces-1:0] pll_blockselect_lc,                       
    output [8*avmm_interfaces-1:0] pll_avmmreaddata_refclk,            // \OPEN [8:0] is bus size defined somewhere
    output [avmm_interfaces-1:0] pll_blockselect_refclk,                       
    output [8*avmm_interfaces-1:0] pll_avmmreaddata_mcgb,            // \OPEN [8:0] is bus size defined somewhere
    output [avmm_interfaces-1:0] pll_blockselect_mcgb,                       


    // \NOTE Debug related not in hw.tcl
    output clklow,
    output fref,
    output overrange,
    output underrange
    /// \TODO include anyother ports for debugging?  
);
    wire feedback_path_for_fb_comp_bonding_to_lc;
    wire feedback_path_for_fb_comp_bonding_from_cgb;

    generate
       if (enable_mcgb == 1 && hssi_pma_cgb_master_cgb_enable_iqtxrxclk == "enable_iqtxrxclk") begin
          assign feedback_path_for_fb_comp_bonding_to_lc = feedback_path_for_fb_comp_bonding_from_cgb;
       end
       else begin
          assign feedback_path_for_fb_comp_bonding_to_lc = 0;
       end
       endgenerate

    wire         avmm_clk_refclk,       avmm_clk_lc,       avmm_clk_mcgb;
    wire         avmm_rstn_refclk,      avmm_rstn_lc,      avmm_rstn_mcgb;
    wire   [7:0] avmm_writedata_refclk, avmm_writedata_lc, avmm_writedata_mcgb;
    wire   [8:0] avmm_address_refclk,   avmm_address_lc,   avmm_address_mcgb;
    wire         avmm_write_refclk,     avmm_write_lc,     avmm_write_mcgb;
    wire         avmm_read_refclk,      avmm_read_lc,      avmm_read_mcgb;
    wire   [7:0] avmmreaddata_refclk,   avmmreaddata_lc,   avmmreaddata_mcgb;
    wire         blockselect_refclk,    blockselect_lc,    blockselect_mcgb;

   assign pll_avmmreaddata_mcgb[7:0] = { 8 {1'b0} };                           // \NOTE only [15:8] is used, hence [7:0] is tied-off to '0'
   assign pll_blockselect_mcgb[0:0] = {1'b0};                                  // \NOTE only [1:1] is used, hence [0:0] is tied-off to '0'

   generate
      if (avmm_interfaces==2) begin
         assign pll_avmmreaddata_lc[avmm_interfaces*8-1:8] = { 8 {1'b0} };             // \NOTE only [7:0] is used, hence [15:8] is tied-off to '0'
         assign pll_avmmreaddata_refclk[avmm_interfaces*8-1:8] = { 8 {1'b0} };   // \NOTE only [7:0] is used, hence [15:8] is tied-off to '0'

         assign pll_blockselect_lc[avmm_interfaces-1:1] = {1'b0};                      // \NOTE only [0:0] is used, hence [1:1] is tied-off to '0'
         assign pll_blockselect_refclk[avmm_interfaces-1:1] = {1'b0};            // \NOTE only [0:0] is used, hence [1:1] is tied-off to '0'

         assign avmm_clk_mcgb              = pll_avmm_clk[1];
         assign avmm_rstn_mcgb             = pll_avmm_rstn[1];
         assign avmm_writedata_mcgb        = pll_avmm_writedata[15:8];
         assign avmm_address_mcgb          = pll_avmm_address[17:9];
         assign avmm_write_mcgb            = pll_avmm_write[1];
         assign avmm_read_mcgb             = pll_avmm_read[1];
         assign pll_avmmreaddata_mcgb[15:8] = avmmreaddata_mcgb;
         assign pll_blockselect_mcgb[1]    = blockselect_mcgb;
      end
   endgenerate

   assign avmm_clk_refclk              = pll_avmm_clk[0];
   assign avmm_rstn_refclk             = pll_avmm_rstn[0];
   assign avmm_writedata_refclk        = pll_avmm_writedata[7:0];
   assign avmm_address_refclk          = pll_avmm_address[8:0];
   assign avmm_write_refclk            = pll_avmm_write[0];
   assign avmm_read_refclk             = pll_avmm_read[0];
   assign pll_avmmreaddata_refclk[7:0] = avmmreaddata_refclk;
   assign pll_blockselect_refclk[0]    = blockselect_refclk;

   assign avmm_clk_lc              = pll_avmm_clk[0];
   assign avmm_rstn_lc             = pll_avmm_rstn[0];
   assign avmm_writedata_lc        = pll_avmm_writedata[7:0];
   assign avmm_address_lc          = pll_avmm_address[8:0];
   assign avmm_write_lc            = pll_avmm_write[0];
   assign avmm_read_lc             = pll_avmm_read[0];
   assign pll_avmmreaddata_lc[7:0] = avmmreaddata_lc;
   assign pll_blockselect_lc[0]    = blockselect_lc;

    wire refclk_mux_out;

    // \OPEN find a better way for the following parameters
    localparam SIZE_CGB_BONDING_CLK = 6;
    localparam SIZE_REFIQCLK = 12;
    localparam REFCLK_CNT = 5;

    assign mcgb_serial_clk = tx_bonding_clocks[SIZE_CGB_BONDING_CLK-1];


    //-----------------------------------
    // MUX STARTS
    twentynm_hssi_pma_lc_refclk_select_mux
    #(
       //-----------------------------------
       //-----------------------------------
       .enable_debug_info(enable_debug_info),                        // \OPEN verify if still exists
       .powerdown_mode(hssi_pma_lc_refclk_select_mux_powerdown_mode),
	   .refclk_select(hssi_pma_lc_refclk_select_mux_refclk_select),
       .silicon_rev(hssi_pma_lc_refclk_select_mux_silicon_rev),
       //-----------------------------------
       //-----------------------------------
       //.xmux_refclk_src                   // \NOTE: Second mux, handled by fitter
       //.xpm_iqref_mux_iqclk_sel           // \NOTE: First mux, handled by fitter
       //.xpm_iqref_mux_scratch0_src        // \NOTE: Handled by fitter
       //.xpm_iqref_mux_scratch1_src        // \NOTE: Handled by fitter
       //.xpm_iqref_mux_scratch2_src        // \NOTE: Handled by fitter
       //.xpm_iqref_mux_scratch3_src        // \NOTE: Handled by fitter
       //.xpm_iqref_mux_scratch4_src        // \NOTE: Handled by fitter

       .inclk0_logical_to_physical_mapping (hssi_pma_lc_refclk_select_mux_inclk0_logical_to_physical_mapping),
       .inclk1_logical_to_physical_mapping (hssi_pma_lc_refclk_select_mux_inclk1_logical_to_physical_mapping),
       .inclk2_logical_to_physical_mapping (hssi_pma_lc_refclk_select_mux_inclk2_logical_to_physical_mapping),
       .inclk3_logical_to_physical_mapping (hssi_pma_lc_refclk_select_mux_inclk3_logical_to_physical_mapping),
       .inclk4_logical_to_physical_mapping (hssi_pma_lc_refclk_select_mux_inclk4_logical_to_physical_mapping)
       //-----------------------------------
       //-----------------------------------
    )
    twentynm_hssi_pma_lc_refclk_select_mux_inst (

       .ref_iqclk({{(SIZE_REFIQCLK-REFCLK_CNT){1'b0}}, {pll_refclk4, pll_refclk3, pll_refclk2, pll_refclk1, pll_refclk0}}), /// \OPEN verify this connection?     
       .refclk(refclk_mux_out),

       //-----------------------------------                          // \OPEN what to do with the following input ports [CM: ?talk to Enoch]
       .core_refclk(1'b0),
       .cr_pdb(1'b1),
       .iqtxrxclk(6'b0),                                              // \SIZE: [5:0]
       .lvpecl_in(1'b0),
       //-----------------------------------

       //-----------------------------------
       .avmmaddress(avmm_address_refclk),
       .avmmclk(avmm_clk_refclk),
       .avmmread(avmm_read_refclk),
       .avmmrstn(avmm_rstn_refclk),
       .avmmwrite(avmm_write_refclk),
       .avmmwritedata(avmm_writedata_refclk),
       .avmmreaddata(avmmreaddata_refclk),
       .blockselect(blockselect_refclk)
       //-----------------------------------
    );
    // MUX ENDS
    //-----------------------------------


    //-----------------------------------
    // LC    STARTS
    twentynm_atx_pll
    #(
       //-----------------------------------
       //-----------------------------------
       .enable_debug_info(enable_debug_info),                          // \OPEN verify if still exists
       .fb_select(atx_pll_fb_select),
       .bonding(atx_pll_bonding_mode),
       .prot_mode(atx_pll_prot_mode),
       .silicon_rev(atx_pll_silicon_rev),
       .bw_sel(atx_pll_bw_sel),
       .output_clock_frequency(atx_pll_output_clock_frequency),
       .reference_clock_frequency(atx_pll_reference_clock_frequency),
       .m_counter(atx_pll_m_counter),
       .ref_clk_div(atx_pll_ref_clk_div),
       .l_counter(atx_pll_l_counter),
       .dsm_fractional_division(atx_pll_dsm_fractional_division),      // \OPEN is this assignment correct [CM: ]
       .cgb_div(atx_pll_cgb_div),                                      // \OPEN is not this supposed to be in cgb_master only [CM: ]
       .pma_width(atx_pll_pma_width),
       .hclk_divide(atx_pll_hclk_divide),
       .dsm_mode(atx_pll_dsm_mode),
       .l_counter_enable(atx_pll_l_counter_enable),
       .tank_band(atx_pll_tank_band),
       .tank_sel(atx_pll_tank_sel),
       .regulator_bypass  (atx_pll_regulator_bypass),
       .pfd_delay_compensation (atx_pll_pfd_delay_compensation),
       .xcpvco_xchgpmplf_cp_current_boost (atx_pll_xcpvco_xchgpmplf_cp_current_boost),
       .pfd_pulse_width (atx_pll_pfd_pulse_width),
       //-----------------------------------
       //-----------------------------------
       .primary_use                (atx_pll_primary_use               ),
       .lc_mode                    (atx_pll_lc_mode                   ),
       .lc_atb                     (atx_pll_lc_atb                    ),
       .cp_compensation_enable     (atx_pll_cp_compensation_enable    ),
       .cp_current_setting         (atx_pll_cp_current_setting        ),
       .cp_testmode                (atx_pll_cp_testmode               ),
       .cp_lf_3rd_pole_freq        (atx_pll_cp_lf_3rd_pole_freq       ),
       .cp_lf_order                (atx_pll_cp_lf_order               ),
       .lf_resistance              (atx_pll_lf_resistance             ),
       .lf_ripplecap               (atx_pll_lf_ripplecap              ),
       .d2a_voltage                (atx_pll_d2a_voltage               ),
       .dsm_out_sel                (atx_pll_dsm_out_sel               ),
       .dsm_ecn_bypass             (atx_pll_dsm_ecn_bypass            ),
       .dsm_ecn_test_en            (atx_pll_dsm_ecn_test_en           ),
       .dsm_fractional_value_ready (atx_pll_dsm_fractional_value_ready),
       // iqclk_mux_sel: \NOTE should be handled by fitter, but required to set fb-comp sims to pass 
       // iqclk_mux_sel: \RANGE iqtxrxclk0 iqtxrxclk1 iqtxrxclk2 iqtxrxclk3 iqtxrxclk4 iqtxrxclk5 (power_down)
       .iqclk_mux_sel              ("iqtxrxclk0"                      ),
       .vco_bypass_enable          (atx_pll_vco_bypass_enable         ),
       .cascadeclk_test            (atx_pll_cascadeclk_test           ),
       .tank_voltage_coarse        (atx_pll_tank_voltage_coarse       ),
       .tank_voltage_fine          (atx_pll_tank_voltage_fine         ),
       .output_regulator_supply    (atx_pll_output_regulator_supply   ),
       .overrange_voltage          (atx_pll_overrange_voltage         ),
       .underrange_voltage         (atx_pll_underrange_voltage        ),
       .is_cascaded_pll            (atx_pll_is_cascaded_pll           ),
       .is_otn                     (atx_pll_is_otn                    ),
       .is_sdi                     (atx_pll_is_sdi                    ),
       .side                       (atx_pll_side                      ),
	   .lf_cbig_size               (atx_pll_lf_cbig_size              ),
	   .enable_hclk                (atx_pll_enable_hclk               ),
	   .calibration_mode           (atx_pll_calibration_mode          ),
       .datarate                   (atx_pll_datarate                  ),
       .device_variant             (atx_pll_device_variant            ),
	   .initial_settings           (atx_pll_initial_settings          ),
	   .l_counter_scratch          (atx_pll_l_counter_scratch         ),
	   .n_counter_scratch          (atx_pll_n_counter_scratch         ),
	   .powerdown_mode             (atx_pll_powerdown_mode            ),
	   .sup_mode                   (atx_pll_sup_mode                  ),
	   .vco_freq                   (atx_pll_vco_freq                  ),
	   .fpll_refclk_selection      (atx_pll_fpll_refclk_selection     ),
	   .lc_to_fpll_l_counter       (lc_to_fpll_l_counter              )

       //-----------------------------------
       //-----------------------------------
       // \OPEN .sel_buf8g(ENABLE_BUF8G), does not exist anymore [CM: ]
       // \OPEN .sel_buf14g(ENABLE_BUF14G), does not exist anymore
       // \OPEN .lcpll_hclk_driver_enable(HCLK_ENABLE_ATX), does not exist anymore
       // \OPEN .lc_cmu_pdb("true"), does not exist anymore
       //-----------------------------------
       //-----------------------------------
    )
    twentynm_atx_pll_inst (

       .clk0_16g(pll_serial_clk_16g),
       .clk0_8g(pll_serial_clk_8g),

       .clk180_16g( /*unused*/ ),
       .clk180_8g( /*unused*/ ),

       .lf_rst_n(1'b1),
       .rst_n(pll_powerdown),
       .refclk(refclk_mux_out),
       .lock(pll_locked),

       .iqtxrxclk({5'b0, feedback_path_for_fb_comp_bonding_to_lc}),

       .hclk_out(pll_pcie_clk),
       .iqtxrxclk_out(pll_cascade_clk),
       .lc_to_fpll_refclk (lc_to_fpll_refclk),

       //-----------------------------------
       .clklow_buf(clklow),
       .fref_buf(fref),
       .overrange(overrange),
       .underrange(underrange),
       //-----------------------------------

       //-----------------------------------
       .avmmaddress(avmm_address_lc),
       .avmmclk(avmm_clk_lc),
       .avmmread(avmm_read_lc),
       .avmmrstn(avmm_rstn_lc),
       .avmmwrite(avmm_write_lc),
       .avmmwritedata(avmm_writedata_lc),
       .avmmreaddata(avmmreaddata_lc),
       .blockselect(blockselect_lc)
       //-----------------------------------
    );
    // LC    ENDS
    //-----------------------------------


generate
if (enable_mcgb == 1) begin
    //-----------------------------------
    // CGB STARTS    
    twentynm_hssi_pma_cgb_master
    #(
       //-----------------------------------
       //-----------------------------------
       .enable_debug_info(enable_debug_info),                           // \OPEN verify if still exists
       .silicon_rev(hssi_pma_cgb_master_silicon_rev),
       .datarate(hssi_pma_cgb_master_datarate),
       .x1_div_m_sel(hssi_pma_cgb_master_x1_div_m_sel),
       .prot_mode(hssi_pma_cgb_master_prot_mode),
       .ser_mode(hssi_pma_cgb_master_ser_mode),
       .cgb_enable_iqtxrxclk(hssi_pma_cgb_master_cgb_enable_iqtxrxclk), // \OPEN 1) needs to be reviewed 2) in atom default is enable in _hw.tcl default is disable
       //-----------------------------------
       //-----------------------------------
       .cgb_power_down                     (hssi_pma_cgb_master_cgb_power_down                    ),
       .observe_cgb_clocks                 (hssi_pma_cgb_master_observe_cgb_clocks                ),
       //.op_mode                            (hssi_pma_cgb_master_op_mode                           ),

       //.tx_ucontrol_reset_pcie             (hssi_pma_cgb_master_tx_ucontrol_reset_pcie            ),
       .vccdreg_output                     (hssi_pma_cgb_master_vccdreg_output                    ),
       .input_select                       (hssi_pma_cgb_master_input_select                      ),
       .input_select_gen3                  (hssi_pma_cgb_master_input_select_gen3                 ),
       //-----------------------------------
       //-----------------------------------
       .bonding_reset_enable               (hssi_pma_cgb_master_bonding_reset_enable         ),  // \NOTE applies to slave cgb // \RANGE disallow_bonding_reset (allow_bonding_reset)
       .optimal                            (hssi_pma_cgb_master_optimal), 
	   .pcie_gen3_bitwidth                 (hssi_pma_cgb_master_pcie_gen3_bitwidth),
	   .powerdown_mode                     (hssi_pma_cgb_master_powerdown_mode),
	   .sup_mode                           (hssi_pma_cgb_master_sup_mode),
	   .initial_settings                   (hssi_pma_cgb_master_initial_settings)
       //.scratch0_x1_clock_src() // \NOTE set by fitter        // \RANGE (unused) lcpll_bot lcpll_top fpll_bot fpll_top
       //.scratch1_x1_clock_src() // \NOTE set by fitter        // \RANGE (unused) lcpll_bot lcpll_top fpll_bot fpll_top
       //.scratch2_x1_clock_src() // \NOTE set by fitter        // \RANGE (unused) lcpll_bot lcpll_top fpll_bot fpll_top
       //.scratch3_x1_clock_src() // \NOTE set by fitter        // \RANGE (unused) lcpll_bot lcpll_top fpll_bot fpll_top
       //.x1_clock_source_sel()   // \NOTE set by fitter        // \RANGE lcpll_bot lcpll_top fpll_bot (fpll_top) lcpll_bot_g1_g2 lcpll_top_g1_g2 fpll_bot_g1_g2 fpll_top_g1_g2 fpll_bot_g2_lcpll_bot_g3 fpll_bot_g2_lcpll_top_g3 fpll_top_g2_lcpll_bot_g3 fpll_top_g2_lcpll_top_g3 
       //-----------------------------------
       //----------------------------------- 
    )
    twentynm_hssi_pma_cgb_master_inst (

       .cgb_rstb(mcgb_rst),                             // \OPEN active high or low?

       .clk_fpll_t(mcgb_aux_clk0),
       .clk_lc_t  (pll_serial_clk_8g),

       .clk_fpll_b (mcgb_aux_clk2),
       .clk_lc_b   (mcgb_aux_clk1),

       .clkb_fpll_b( /*unused*/ ),
       .clkb_fpll_t( /*unused*/ ),
       .clkb_lc_b  ( /*unused*/ ),
       .clkb_lc_t  ( /*unused*/ ),
       //-----------------------------------

       .cpulse_out_bus(tx_bonding_clocks),               // \OPEN is bus ok? 

       .tx_iqtxrxclk_out(feedback_path_for_fb_comp_bonding_from_cgb),

       .pcie_sw_done(mcgb_pcie_sw_done),
       .pcie_sw(mcgb_pcie_sw),

       //-----------------------------------                           
       .tx_bonding_rstb(1'b1),                        // \NOTE carried over from slave cgb
       //-----------------------------------  

       //-----------------------------------          
       .avmmaddress(avmm_address_mcgb),
       .avmmclk(avmm_clk_mcgb),
       .avmmread(avmm_read_mcgb),
       .avmmrstn(avmm_rstn_mcgb),
       .avmmwrite(avmm_write_mcgb),
       .avmmwritedata(avmm_writedata_mcgb),
       .avmmreaddata(avmmreaddata_mcgb),
       .blockselect(blockselect_mcgb)
       //-----------------------------------           
    );
    // CGB ENDS
    //-----------------------------------   
end else begin
    assign mcgb_pcie_sw_done = 2'b0;
    assign tx_bonding_clocks = 6'b0;
end
endgenerate

endmodule
