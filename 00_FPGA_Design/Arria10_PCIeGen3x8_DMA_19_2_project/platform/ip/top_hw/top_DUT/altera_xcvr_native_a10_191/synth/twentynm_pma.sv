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


//
//              ALTERA CORPORATION
//
//
//


`timescale 1 ps/1 ps
// altera message_off 10036


module twentynm_pma_rev_20nm1
	#(
	//PARAM_LIST_START
		parameter xcvr_native_mode = "mode_duplex",  // mode_duplex, mode_rx_only, mode_tx_only
		
		// parameters for twentynm_hssi_pma_adaptation
		parameter pma_adapt_adapt_mode = "dfe_vga", // ctle|dfe_vga|ctle_vga|ctle_vga_dfe|manual
		parameter pma_adapt_adp_1s_ctle_bypass = "radp_1s_ctle_bypass_0", // radp_1s_ctle_bypass_0|radp_1s_ctle_bypass_1
		parameter pma_adapt_adp_4s_ctle_bypass = "radp_4s_ctle_bypass_0", // radp_4s_ctle_bypass_0|radp_4s_ctle_bypass_1
		parameter pma_adapt_adp_ctle_adapt_cycle_window = "radp_ctle_adapt_cycle_window_6", // radp_ctle_adapt_cycle_window_0|radp_ctle_adapt_cycle_window_1|radp_ctle_adapt_cycle_window_2|radp_ctle_adapt_cycle_window_3|radp_ctle_adapt_cycle_window_4|radp_ctle_adapt_cycle_window_5|radp_ctle_adapt_cycle_window_6|radp_ctle_adapt_cycle_window_7
		parameter pma_adapt_adp_ctle_en = "radp_ctle_disable", // radp_ctle_disable|radp_ctle_enable
		parameter pma_adapt_adp_dfe_fltap_bypass = "radp_dfe_fltap_bypass_0", // radp_dfe_fltap_bypass_0|radp_dfe_fltap_bypass_1
		parameter pma_adapt_adp_dfe_fltap_en = "radp_dfe_fltap_disable", // radp_dfe_fltap_disable|radp_dfe_fltap_enable
		parameter pma_adapt_adp_dfe_fxtap_bypass = "radp_dfe_fxtap_bypass_0", // radp_dfe_fxtap_bypass_0|radp_dfe_fxtap_bypass_1
		parameter pma_adapt_adp_dfe_fxtap_en = "radp_dfe_fxtap_disable", // radp_dfe_fxtap_disable|radp_dfe_fxtap_enable
		parameter pma_adapt_adp_dfe_fxtap_hold_en = "radp_dfe_fxtap_not_held", // radp_dfe_fxtap_not_held|radp_dfe_fxtap_hold
		parameter pma_adapt_adp_dfe_mode = "radp_dfe_mode_0", // radp_dfe_mode_0|radp_dfe_mode_1|radp_dfe_mode_2|radp_dfe_mode_3|radp_dfe_mode_4|radp_dfe_mode_5|radp_dfe_mode_6|radp_dfe_mode_7
		parameter pma_adapt_adp_mode = "radp_mode_0", // radp_mode_0|radp_mode_1|radp_mode_2|radp_mode_3|radp_mode_4|radp_mode_5|radp_mode_6|radp_mode_7|radp_mode_8|radp_mode_9|radp_mode_10|radp_mode_11|radp_mode_12|radp_mode_13|radp_mode_14|radp_mode_15
		parameter pma_adapt_adp_onetime_dfe = "radp_onetime_dfe_0", // radp_onetime_dfe_0|radp_onetime_dfe_1
		parameter pma_adapt_adp_vga_bypass = "radp_vga_bypass_0", // radp_vga_bypass_0|radp_vga_bypass_1
		parameter pma_adapt_adp_vga_en = "radp_vga_disable", // radp_vga_disable|radp_vga_enable
		parameter pma_adapt_adp_vref_bypass = "radp_vref_bypass_0", // radp_vref_bypass_0|radp_vref_bypass_1
		parameter pma_adapt_adp_vref_en = "radp_vref_disable", // radp_vref_disable|radp_vref_enable
		parameter pma_adapt_datarate = "0 bps", // 
		parameter pma_adapt_odi_dfe_spec_en = "rodi_dfe_spec_en_0", // rodi_dfe_spec_en_0|rodi_dfe_spec_en_1
		parameter pma_adapt_prot_mode = "basic_rx", // basic_rx|pcie_gen1_rx|pcie_gen2_rx|pcie_gen3_rx|pcie_gen4_rx|qpi_rx|unused|gpon_rx|sata_rx
		parameter pma_adapt_sup_mode = "user_mode", // user_mode|engineering_mode
		
		// parameters for twentynm_hssi_pma_cdr_refclk_select_mux
		parameter pma_cdr_refclk_inclk0_logical_to_physical_mapping = "ref_iqclk0", // ref_iqclk0|ref_iqclk1|ref_iqclk2|ref_iqclk3|ref_iqclk4|ref_iqclk5|ref_iqclk6|ref_iqclk7|ref_iqclk8|ref_iqclk9|ref_iqclk10|ref_iqclk11|iqtxrxclk0|iqtxrxclk1|iqtxrxclk2|iqtxrxclk3|iqtxrxclk4|iqtxrxclk5|coreclk|fixed_clk|lvpecl|adj_pll_clk|power_down
		parameter pma_cdr_refclk_inclk1_logical_to_physical_mapping = "ref_iqclk0", // ref_iqclk0|ref_iqclk1|ref_iqclk2|ref_iqclk3|ref_iqclk4|ref_iqclk5|ref_iqclk6|ref_iqclk7|ref_iqclk8|ref_iqclk9|ref_iqclk10|ref_iqclk11|iqtxrxclk0|iqtxrxclk1|iqtxrxclk2|iqtxrxclk3|iqtxrxclk4|iqtxrxclk5|coreclk|fixed_clk|lvpecl|adj_pll_clk|power_down
		parameter pma_cdr_refclk_inclk2_logical_to_physical_mapping = "ref_iqclk0", // ref_iqclk0|ref_iqclk1|ref_iqclk2|ref_iqclk3|ref_iqclk4|ref_iqclk5|ref_iqclk6|ref_iqclk7|ref_iqclk8|ref_iqclk9|ref_iqclk10|ref_iqclk11|iqtxrxclk0|iqtxrxclk1|iqtxrxclk2|iqtxrxclk3|iqtxrxclk4|iqtxrxclk5|coreclk|fixed_clk|lvpecl|adj_pll_clk|power_down
		parameter pma_cdr_refclk_inclk3_logical_to_physical_mapping = "ref_iqclk0", // ref_iqclk0|ref_iqclk1|ref_iqclk2|ref_iqclk3|ref_iqclk4|ref_iqclk5|ref_iqclk6|ref_iqclk7|ref_iqclk8|ref_iqclk9|ref_iqclk10|ref_iqclk11|iqtxrxclk0|iqtxrxclk1|iqtxrxclk2|iqtxrxclk3|iqtxrxclk4|iqtxrxclk5|coreclk|fixed_clk|lvpecl|adj_pll_clk|power_down
		parameter pma_cdr_refclk_inclk4_logical_to_physical_mapping = "ref_iqclk0", // ref_iqclk0|ref_iqclk1|ref_iqclk2|ref_iqclk3|ref_iqclk4|ref_iqclk5|ref_iqclk6|ref_iqclk7|ref_iqclk8|ref_iqclk9|ref_iqclk10|ref_iqclk11|iqtxrxclk0|iqtxrxclk1|iqtxrxclk2|iqtxrxclk3|iqtxrxclk4|iqtxrxclk5|coreclk|fixed_clk|lvpecl|adj_pll_clk|power_down
		parameter pma_cdr_refclk_powerdown_mode = "powerdown", // powerup|powerdown
		parameter pma_cdr_refclk_refclk_select = "ref_iqclk0", // ref_iqclk0|ref_iqclk1|ref_iqclk2|ref_iqclk3|ref_iqclk4|ref_iqclk5|ref_iqclk6|ref_iqclk7|ref_iqclk8|ref_iqclk9|ref_iqclk10|ref_iqclk11|iqtxrxclk0|iqtxrxclk1|iqtxrxclk2|iqtxrxclk3|iqtxrxclk4|iqtxrxclk5|coreclk|fixed_clk|lvpecl|adj_pll_clk|power_down
		
		// parameters for twentynm_hssi_pma_channel_pll
		parameter cdr_pll_atb_select_control = "atb_off", // atb_off|atb_select_tp_1|atb_select_tp_2|atb_select_tp_3|atb_select_tp_4|atb_select_tp_5|atb_select_tp_6|atb_select_tp_7|atb_select_tp_8|atb_select_tp_9|atb_select_tp_10|atb_select_tp_11|atb_select_tp_12|atb_select_tp_13|atb_select_tp_14|atb_select_tp_15|atb_select_tp_16|atb_select_tp_17|atb_select_tp_18|atb_select_tp_19|atb_select_tp_20|atb_select_tp_21|atb_select_tp_22|atb_select_tp_23|atb_select_tp_24|atb_select_tp_25|atb_select_tp_26|atb_select_tp_27|atb_select_tp_28|atb_select_tp_29|atb_select_tp_30|atb_select_tp_31|atb_select_tp_32|atb_select_tp_33|atb_select_tp_34|atb_select_tp_35|atb_select_tp_36|atb_select_tp_37|atb_select_tp_38|atb_select_tp_39|atb_select_tp_40|atb_select_tp_41|atb_select_tp_42|atb_select_tp_43|atb_select_tp_44|atb_select_tp_45|atb_select_tp_46|atb_select_tp_47|atb_select_tp_48|atb_select_tp_49|atb_select_tp_50|atb_select_tp_51|atb_select_tp_52|atb_select_tp_53|atb_select_tp_54|atb_select_tp_55|atb_select_tp_56|atb_select_tp_57|atb_select_tp_58|atb_select_tp_59|atb_select_tp_60|atb_select_tp_61|atb_select_tp_62|atb_select_tp_63
		parameter cdr_pll_auto_reset_on = "auto_reset_on", // auto_reset_on|auto_reset_off
		parameter cdr_pll_bbpd_data_pattern_filter_select = "bbpd_data_pat_off", // bbpd_data_pat_off|bbpd_data_pat_1|bbpd_data_pat_2|bbpd_data_pat_3
		parameter cdr_pll_bw_sel = "low", // low|medium|high
		parameter cdr_pll_cal_vco_count_length = "sel_8b_count", // sel_8b_count|sel_12b_count
		parameter cdr_pll_cdr_odi_select = "sel_cdr", // sel_cdr|sel_odi
		parameter cdr_pll_cdr_phaselock_mode = "no_ignore_lock", // no_ignore_lock|ignore_lock
		parameter cdr_pll_cdr_powerdown_mode = "power_down", // power_down|power_up
		parameter cdr_pll_cgb_div = 1, // 1|2|4|8
		parameter cdr_pll_chgpmp_current_dn_pd = "cp_current_pd_dn_setting0", // cp_current_pd_dn_setting0|cp_current_pd_dn_setting1|cp_current_pd_dn_setting2|cp_current_pd_dn_setting3|cp_current_pd_dn_setting4
		parameter cdr_pll_chgpmp_current_dn_trim = "cp_current_trimming_dn_setting0", // cp_current_trimming_dn_setting0|cp_current_trimming_dn_setting1|cp_current_trimming_dn_setting2|cp_current_trimming_dn_setting3|cp_current_trimming_dn_setting4|cp_current_trimming_dn_setting5|cp_current_trimming_dn_setting6|cp_current_trimming_dn_setting7|cp_current_trimming_dn_setting8|cp_current_trimming_dn_setting9|cp_current_trimming_dn_setting10|cp_current_trimming_dn_setting11|cp_current_trimming_dn_setting12|cp_current_trimming_dn_setting13|cp_current_trimming_dn_setting14|cp_current_trimming_dn_setting15
		parameter cdr_pll_chgpmp_current_pd = "cp_current_pd_setting0", // cp_current_pd_setting0|cp_current_pd_setting1|cp_current_pd_setting2|cp_current_pd_setting3|cp_current_pd_setting4
		parameter cdr_pll_chgpmp_current_pfd = "cp_current_pfd_setting0", // cp_current_pfd_setting0|cp_current_pfd_setting1|cp_current_pfd_setting2|cp_current_pfd_setting3|cp_current_pfd_setting4
		parameter cdr_pll_chgpmp_current_up_pd = "cp_current_pd_up_setting0", // cp_current_pd_up_setting0|cp_current_pd_up_setting1|cp_current_pd_up_setting2|cp_current_pd_up_setting3|cp_current_pd_up_setting4
		parameter cdr_pll_chgpmp_current_up_trim = "cp_current_trimming_up_setting0", // cp_current_trimming_up_setting0|cp_current_trimming_up_setting1|cp_current_trimming_up_setting2|cp_current_trimming_up_setting3|cp_current_trimming_up_setting4|cp_current_trimming_up_setting5|cp_current_trimming_up_setting6|cp_current_trimming_up_setting7|cp_current_trimming_up_setting8|cp_current_trimming_up_setting9|cp_current_trimming_up_setting10|cp_current_trimming_up_setting11|cp_current_trimming_up_setting12|cp_current_trimming_up_setting13|cp_current_trimming_up_setting14|cp_current_trimming_up_setting15
		parameter cdr_pll_chgpmp_dn_pd_trim_double = "normal_dn_trim_current", // normal_dn_trim_current|double_dn_trim_current
		parameter cdr_pll_chgpmp_replicate = "false", // false|true
		parameter cdr_pll_chgpmp_testmode = "cp_test_disable", // cp_test_disable|cp_test_up|cp_test_dn|cp_tristate
		parameter cdr_pll_chgpmp_up_pd_trim_double = "normal_up_trim_current", // normal_up_trim_current|double_up_trim_current
		parameter cdr_pll_clklow_mux_select = "clklow_mux_cdr_fbclk", // clklow_mux_cdr_fbclk|clklow_mux_fpll_test1|clklow_mux_reserved_1|clklow_mux_rx_deser_pclk_test|clklow_mux_reserved_2|clklow_mux_reserved_3|clklow_mux_reserved_4|clklow_mux_dfe_test
		parameter cdr_pll_datarate = "0 bps", // 
		parameter cdr_pll_diag_loopback_enable = "false", // true|false
		parameter cdr_pll_disable_up_dn = "true", // true|false
		parameter cdr_pll_fb_select = "direct_fb", // iqtxrxclk_fb|direct_fb
		parameter cdr_pll_fref_clklow_div = 1, // 1|2|4|8
		parameter cdr_pll_fref_mux_select = "fref_mux_cdr_refclk", // fref_mux_cdr_refclk|fref_mux_fpll_test0|fref_mux_reserved_1|fref_mux_tx_ser_pclk_test|fref_mux_reserved_2|fref_mux_reserved_3|fref_mux_reserved_4|fref_mux_reserved_5
		parameter cdr_pll_gpon_lck2ref_control = "gpon_lck2ref_off", // gpon_lck2ref_off|gpon_lck2ref_on
		parameter cdr_pll_initial_settings = "false", // false|true
		parameter cdr_pll_iqclk_mux_sel = "power_down", // iqtxrxclk0|iqtxrxclk1|iqtxrxclk2|iqtxrxclk3|iqtxrxclk4|iqtxrxclk5|power_down
		parameter cdr_pll_is_cascaded_pll = "false", // true|false
		parameter cdr_pll_lck2ref_delay_control = "lck2ref_delay_off", // lck2ref_delay_off|lck2ref_delay_1|lck2ref_delay_2|lck2ref_delay_3|lck2ref_delay_4|lck2ref_delay_5|lck2ref_delay_6|lck2ref_delay_7
		parameter cdr_pll_lf_resistor_pd = "lf_pd_setting0", // lf_pd_setting0|lf_pd_setting1|lf_pd_setting2|lf_pd_setting3
		parameter cdr_pll_lf_resistor_pfd = "lf_pfd_setting0", // lf_pfd_setting0|lf_pfd_setting1|lf_pfd_setting2|lf_pfd_setting3
		parameter cdr_pll_lf_ripple_cap = "lf_no_ripple", // lf_no_ripple|lf_ripple_cap1
		parameter cdr_pll_loop_filter_bias_select = "lpflt_bias_off", // lpflt_bias_off|lpflt_bias_1|lpflt_bias_2|lpflt_bias_3|lpflt_bias_4|lpflt_bias_5|lpflt_bias_6|lpflt_bias_7
		parameter cdr_pll_loopback_mode = "loopback_disabled", // loopback_disabled|loopback_recovered_data|rx_refclk|rx_refclk_cdr_loopback|unused2|loopback_received_data|unused1
		parameter cdr_pll_lpd_counter = 5'b1,
		parameter cdr_pll_lpfd_counter = 5'b1,
		parameter cdr_pll_ltd_ltr_micro_controller_select = "ltd_ltr_pcs", // ltd_ltr_pcs|ltr_ucontroller|ltd_ucontroller
		parameter cdr_pll_m_counter = 16, // 0..255
		parameter cdr_pll_n_counter = 1, // 1|2|4|8
		parameter cdr_pll_n_counter_scratch = 6'b1,
		parameter cdr_pll_output_clock_frequency = "0 hz", // 
		parameter cdr_pll_pcie_gen = "non_pcie", // pcie_gen1_100mhzref|pcie_gen2_100mhzref|pcie_gen3_100mhzref|pcie_gen1_125mhzref|pcie_gen2_125mhzref|pcie_gen3_125mhzref|non_pcie
		parameter cdr_pll_pd_fastlock_mode = "false", // false|true
		parameter cdr_pll_pd_l_counter = 1, // 0|1|2|4|8|16
		parameter cdr_pll_pfd_l_counter = 1, // 0|1|2|4|8|16|100
		parameter cdr_pll_pma_width = 8, // 8|10|16|20|32|40|64
		parameter cdr_pll_primary_use = "cmu", // cmu|cdr
		parameter cdr_pll_prot_mode = "unused", // basic_rx|pcie_gen1_rx|pcie_gen2_rx|pcie_gen3_rx|pcie_gen4_rx|qpi_rx|unused|gpon_rx|sata_rx
		parameter cdr_pll_reference_clock_frequency = "0 hz", // 
		parameter cdr_pll_reverse_serial_loopback = "no_loopback", // no_loopback|loopback_data_no_posttap|loopback_data_with_posttap|loopback_data_0_1
		parameter cdr_pll_set_cdr_input_freq_range = 8'b0,
		parameter cdr_pll_set_cdr_v2i_enable = "true", // true|false
		parameter cdr_pll_set_cdr_vco_reset = "false", // true|false
		parameter cdr_pll_set_cdr_vco_speed = 5'b1,
		parameter cdr_pll_set_cdr_vco_speed_fix = 8'b0,
		parameter cdr_pll_set_cdr_vco_speed_pciegen3 = "cdr_vco_max_speedbin_pciegen3", // cdr_vco_min_speedbin_pciegen3|cdr_vco_max_speedbin_pciegen3
		parameter cdr_pll_sup_mode = "user_mode", // user_mode|engineering_mode
		parameter cdr_pll_tx_pll_prot_mode = "txpll_unused", // txpll_unused|txpll_enable_pcie|txpll_enable
		parameter cdr_pll_txpll_hclk_driver_enable = "false", // true|false
		parameter cdr_pll_uc_ro_cal = "uc_ro_cal_off", // uc_ro_cal_off|uc_ro_cal_on
		parameter cdr_pll_vco_freq = "0 hz", // 
		parameter cdr_pll_vco_overrange_voltage = "vco_overrange_off", // vco_overrange_off|vco_overrange_ref_1|vco_overrange_ref_2|vco_overrange_ref_3
		parameter cdr_pll_vco_underrange_voltage = "vco_underange_off", // vco_underange_off|vco_underange_ref_1|vco_underange_ref_2|vco_underange_ref_3
		
		// parameters for twentynm_hssi_pma_rx_buf
		parameter pma_rx_buf_bypass_eqz_stages_234 = "bypass_off", // bypass_off|byypass_stages_234
		parameter pma_rx_buf_datarate = "0 bps", // 
		parameter pma_rx_buf_diag_lp_en = "dlp_off", // dlp_off|dlp_on
		parameter pma_rx_buf_loopback_modes = "lpbk_disable", // lpbk_disable|pre_cdr|post_cdr
		parameter pma_rx_buf_pm_tx_rx_cvp_mode = "cvp_off", // cvp_off|cvp_on
		parameter pma_rx_buf_pm_tx_rx_pcie_gen = "non_pcie", // pcie_gen1_100mhzref|pcie_gen2_100mhzref|pcie_gen3_100mhzref|pcie_gen1_125mhzref|pcie_gen2_125mhzref|pcie_gen3_125mhzref|non_pcie
		parameter pma_rx_buf_pm_tx_rx_pcie_gen_bitwidth = "pcie_gen3_32b", // pcie_gen3_32b|pcie_gen3_16b
		parameter pma_rx_buf_prot_mode = "basic_rx", // basic_rx|pcie_gen1_rx|pcie_gen2_rx|pcie_gen3_rx|pcie_gen4_rx|qpi_rx|unused|gpon_rx|sata_rx
		parameter pma_rx_buf_qpi_enable = "non_qpi_mode", // non_qpi_mode|qpi_mode
		parameter pma_rx_buf_refclk_en = "enable", // disable|enable
		parameter pma_rx_buf_rx_refclk_divider = "bypass_divider", // bypass_divider|divide_by_2
		parameter pma_rx_buf_sup_mode = "user_mode", // user_mode|engineering_mode
		parameter pma_rx_buf_xrx_path_datarate = "0 bps", // 
		parameter pma_rx_buf_xrx_path_datawidth = 8'b0,
		parameter pma_rx_buf_xrx_path_pma_rx_divclk_hz = 32'b0,
		parameter pma_rx_buf_xrx_path_prot_mode = "unused", // basic_rx|pcie_gen1_rx|pcie_gen2_rx|pcie_gen3_rx|pcie_gen4_rx|qpi_rx|unused|gpon_rx|sata_rx
		parameter pma_rx_buf_xrx_path_sup_mode = "user_mode", // user_mode|engineering_mode
		parameter pma_rx_buf_xrx_path_uc_cal_enable = "rx_cal_off", // rx_cal_off|rx_cal_on
		
		// parameters for twentynm_hssi_pma_rx_deser
		parameter pma_rx_deser_bitslip_bypass = "bs_bypass_no", // bs_bypass_no|bs_bypass_yes
		parameter pma_rx_deser_clkdiv_source = "vco_bypass_normal", // vco_bypass_normal|clklow_to_clkdivrx|fref_to_clkdivrx
		parameter pma_rx_deser_clkdivrx_user_mode = "clkdivrx_user_disabled", // clkdivrx_user_disabled|clkdivrx_user_clkdiv|clkdivrx_user_clkdiv_div2|clkdivrx_user_div40|clkdivrx_user_div33|clkdivrx_user_div66
		parameter pma_rx_deser_datarate = "0 bps", // 
		parameter pma_rx_deser_deser_factor = 8, // 8|10|16|20|32|40|64
		parameter pma_rx_deser_force_clkdiv_for_testing = "normal_clkdiv", // normal_clkdiv|forced_0|forced_1
		parameter pma_rx_deser_pcie_gen = "non_pcie", // pcie_gen1_100mhzref|pcie_gen2_100mhzref|pcie_gen3_100mhzref|pcie_gen1_125mhzref|pcie_gen2_125mhzref|pcie_gen3_125mhzref|non_pcie
		parameter pma_rx_deser_pcie_gen_bitwidth = "pcie_gen3_32b", // pcie_gen3_32b|pcie_gen3_16b
		parameter pma_rx_deser_prot_mode = "basic_rx", // basic_rx|pcie_gen1_rx|pcie_gen2_rx|pcie_gen3_rx|pcie_gen4_rx|qpi_rx|unused|gpon_rx|sata_rx
		parameter pma_rx_deser_rst_n_adapt_odi = "no_rst_adapt_odi", // yes_rst_adapt_odi|no_rst_adapt_odi
		parameter pma_rx_deser_sdclk_enable = "false", // false|true
		parameter pma_rx_deser_sup_mode = "user_mode", // user_mode|engineering_mode
		
		// parameters for twentynm_hssi_pma_rx_dfe
		parameter pma_rx_dfe_datarate = "0 bps", // 
		parameter pma_rx_dfe_dft_en = "dft_disable", // dft_disable|dft_enalbe
		parameter pma_rx_dfe_pdb = "dfe_enable", // dfe_powerdown|dfe_reset|dfe_enable
		parameter pma_rx_dfe_pdb_fixedtap = "fixtap_dfe_powerdown", // fixtap_dfe_powerdown|fixtap_dfe_enable
		parameter pma_rx_dfe_pdb_floattap = "floattap_dfe_powerdown", // floattap_dfe_powerdown|floattap_dfe_enable
		parameter pma_rx_dfe_pdb_fxtap4t7 = "fxtap4t7_powerdown", // fxtap4t7_powerdown|fxtap4t7_enable
		parameter pma_rx_dfe_prot_mode = "basic_rx", // basic_rx|pcie_gen1_rx|pcie_gen2_rx|pcie_gen3_rx|pcie_gen4_rx|qpi_rx|unused|gpon_rx|sata_rx
		parameter pma_rx_dfe_sup_mode = "user_mode", // user_mode|engineering_mode
		
		// parameters for twentynm_hssi_pma_rx_odi
		parameter pma_rx_odi_datarate = "0 bps", // 
		parameter pma_rx_odi_prot_mode = "basic_rx", // basic_rx|pcie_gen1_rx|pcie_gen2_rx|pcie_gen3_rx|pcie_gen4_rx|qpi_rx|unused|gpon_rx|sata_rx
		parameter pma_rx_odi_step_ctrl_sel = "feedback_mode", // dprio_mode|feedback_mode|jm_mode
		parameter pma_rx_odi_sup_mode = "user_mode", // user_mode|engineering_mode
		
		// parameters for twentynm_hssi_pma_rx_sd
		parameter pma_rx_sd_prot_mode = "basic_rx", // basic_rx|pcie_gen1_rx|pcie_gen2_rx|pcie_gen3_rx|pcie_gen4_rx|qpi_rx|unused|gpon_rx|sata_rx
		parameter pma_rx_sd_sd_output_off = 1, // 0..28
		parameter pma_rx_sd_sd_output_on = 1, // 0..15
		parameter pma_rx_sd_sd_pdb = "sd_off", // sd_on|sd_off
		parameter pma_rx_sd_sup_mode = "user_mode", // user_mode|engineering_mode
		
		// parameters for twentynm_hssi_pma_tx_buf
		parameter pma_tx_buf_datarate = "0 bps", // 
		parameter pma_tx_buf_mcgb_location_for_pcie = 4'b0,
		parameter pma_tx_buf_prot_mode = "basic_tx", // unused|basic_tx|pcie_gen1_tx|pcie_gen2_tx|pcie_gen3_tx|pcie_gen4_tx|qpi_tx|gpon_tx|sata_tx
		parameter pma_tx_buf_rx_det = "mode_0", // mode_0|mode_1|mode_2|mode_3|mode_4|mode_5|mode_6|mode_7|mode_8|mode_9|mode_10|mode_11|mode_12|mode_13|mode_14|mode_15
		parameter pma_tx_buf_rx_det_output_sel = "rx_det_pcie_out", // rx_det_pcie_out|rx_det_qpi_out
		parameter pma_tx_buf_rx_det_pdb = "rx_det_off", // rx_det_off|rx_det_on
		parameter pma_tx_buf_sup_mode = "user_mode", // user_mode|engineering_mode
		parameter pma_tx_buf_user_fir_coeff_ctrl_sel = "ram_ctl", // ram_ctl|dynamic_ctl
		parameter pma_tx_buf_xtx_path_clock_divider_ratio = 4'b0,
		parameter pma_tx_buf_xtx_path_datarate = "0 bps", // 
		parameter pma_tx_buf_xtx_path_datawidth = 8'b0,
		parameter pma_tx_buf_xtx_path_pma_tx_divclk_hz = 32'b0,
		parameter pma_tx_buf_xtx_path_prot_mode = "basic_tx", // unused|basic_tx|pcie_gen1_tx|pcie_gen2_tx|pcie_gen3_tx|pcie_gen4_tx|qpi_tx|gpon_tx|sata_tx
		parameter pma_tx_buf_xtx_path_sup_mode = "user_mode", // user_mode|engineering_mode
		parameter pma_tx_buf_xtx_path_tx_pll_clk_hz = "0 hz", // 
		
		// parameters for twentynm_hssi_pma_tx_cgb
		parameter pma_cgb_bitslip_enable = "enable_bitslip", // disable_bitslip|enable_bitslip
		parameter pma_cgb_bonding_reset_enable = "allow_bonding_reset", // disallow_bonding_reset|allow_bonding_reset
		parameter pma_cgb_datarate = "0 bps", // 
		parameter pma_cgb_input_select_gen3 = "unused", // lcpll_bot|lcpll_top|fpll_bot|fpll_top|cdr_txpll_b|cdr_txpll_t|same_ch_txpll|lcpll_hs|hfclk_xn_up|hfclk_x6_dn|hfclk_xn_dn|hfclk_x6_up|unused
		parameter pma_cgb_input_select_x1 = "unused", // lcpll_bot|lcpll_top|fpll_bot|fpll_top|cdr_txpll_b|cdr_txpll_t|same_ch_txpll|lcpll_hs|hfclk_xn_up|hfclk_x6_dn|hfclk_xn_dn|hfclk_x6_up|unused
		parameter pma_cgb_input_select_xn = "unused", // sel_xn_up|sel_xn_dn|sel_x6_up|sel_x6_dn|sel_cgb_loc|unused
		parameter pma_cgb_pcie_gen3_bitwidth = "pciegen3_wide", // pciegen3_wide|pciegen3_narrow
		parameter pma_cgb_prot_mode = "basic_tx", // unused|basic_tx|pcie_gen1_tx|pcie_gen2_tx|pcie_gen3_tx|pcie_gen4_tx|qpi_tx|gpon_tx|sata_tx
		parameter pma_cgb_scratch0_x1_clock_src = "unused", // lcpll_bot|lcpll_top|fpll_bot|fpll_top|cdr_txpll_b|cdr_txpll_t|same_ch_txpll|lcpll_hs|hfclk_xn_up|hfclk_x6_dn|hfclk_xn_dn|hfclk_x6_up|unused
		parameter pma_cgb_scratch1_x1_clock_src = "unused", // lcpll_bot|lcpll_top|fpll_bot|fpll_top|cdr_txpll_b|cdr_txpll_t|same_ch_txpll|lcpll_hs|hfclk_xn_up|hfclk_x6_dn|hfclk_xn_dn|hfclk_x6_up|unused
		parameter pma_cgb_scratch2_x1_clock_src = "unused", // lcpll_bot|lcpll_top|fpll_bot|fpll_top|cdr_txpll_b|cdr_txpll_t|same_ch_txpll|lcpll_hs|hfclk_xn_up|hfclk_x6_dn|hfclk_xn_dn|hfclk_x6_up|unused
		parameter pma_cgb_scratch3_x1_clock_src = "unused", // lcpll_bot|lcpll_top|fpll_bot|fpll_top|cdr_txpll_b|cdr_txpll_t|same_ch_txpll|lcpll_hs|hfclk_xn_up|hfclk_x6_dn|hfclk_xn_dn|hfclk_x6_up|unused
		parameter pma_cgb_select_done_master_or_slave = "choose_slave_pcie_sw_done", // choose_master_pcie_sw_done|choose_slave_pcie_sw_done
		parameter pma_cgb_ser_mode = "eight_bit", // eight_bit|ten_bit|sixteen_bit|twenty_bit|thirty_two_bit|forty_bit|sixty_four_bit
		parameter pma_cgb_sup_mode = "user_mode", // user_mode|engineering_mode
		parameter pma_cgb_tx_ucontrol_en = "disable", // disable|enable
		parameter pma_cgb_x1_div_m_sel = "divbypass", // divbypass|divby2|divby4|divby8
		
		// parameters for twentynm_hssi_pma_tx_ser
		parameter pma_tx_ser_prot_mode = "basic_tx", // unused|basic_tx|pcie_gen1_tx|pcie_gen2_tx|pcie_gen3_tx|pcie_gen4_tx|qpi_tx|gpon_tx|sata_tx
		parameter pma_tx_ser_ser_clk_divtx_user_sel = "divtx_user_33", // divtx_user_2|divtx_user_40|divtx_user_33|divtx_user_66|divtx_user_1|divtx_user_off
		parameter pma_tx_ser_sup_mode = "user_mode" // user_mode|engineering_mode
	//PARAM_LIST_END
	)
	(
	//PORT_LIST_START
		input wire		in_adapt_start,
		input wire	[8:0]	in_avmmaddress,
		input wire		in_avmmclk,
		input wire		in_avmmread,
		input wire		in_avmmrstn,
		input wire		in_avmmwrite,
		input wire	[7:0]	in_avmmwritedata,
		input wire		in_clk_cdr_b,
		input wire		in_clk_cdr_t,
		input wire		in_clk_fpll_b,
		input wire		in_clk_fpll_t,
		input wire		in_clk_lc_b,
		input wire		in_clk_lc_hs,
		input wire		in_clk_lc_t,
		input wire		in_clkb_cdr_b,
		input wire		in_clkb_cdr_t,
		input wire		in_clkb_fpll_b,
		input wire		in_clkb_fpll_t,
		input wire		in_clkb_lc_b,
		input wire		in_clkb_lc_hs,
		input wire		in_clkb_lc_t,
		input wire		in_core_refclk_in,
		input wire	[5:0]	in_cpulse_x6_dn_bus,
		input wire	[5:0]	in_cpulse_x6_up_bus,
		input wire	[5:0]	in_cpulse_xn_dn_bus,
		input wire	[5:0]	in_cpulse_xn_up_bus,
		input wire		in_early_eios,
		input wire	[5:0]	in_eye_monitor,
		input wire	[1:0]	in_fpll_ppm_clk_in,
		input wire	[17:0]	in_i_coeff,
		input wire	[2:0]	in_i_rxpreset,
		input wire	[5:0]	in_iqtxrxclk,
		input wire		in_ltd_b,
		input wire		in_ltr,
		input wire	[1:0]	in_pcie_sw,
		input wire	[1:0]	in_pcie_sw_done_master_in,
		input wire		in_pma_atpg_los_en_n_in,
		input wire	[4:0]	in_pma_reserved_out,
		input wire		in_ppm_lock,
		input wire	[11:0]	in_ref_iqclk,
		input wire		in_rs_lpbk_b,
		input wire	[5:0]	in_rx50_buf_in,
		input wire		in_rx_bitslip,
		input wire		in_rx_n,
		input wire		in_rx_p,
		input wire		in_rx_pma_rstb,
		input wire		in_rx_qpi_pulldn,
		input wire		in_scan_mode_n,
		input wire		in_scan_shift_n,
		input wire	[8:0]	in_tx50_buf_in,
		input wire		in_tx_bitslip,
		input wire		in_tx_bonding_rstb,
		input wire	[63:0]	in_tx_data,
		input wire		in_tx_det_rx,
		input wire		in_tx_elec_idle,
		input wire		in_tx_pma_rstb,
		input wire		in_tx_qpi_pulldn,
		input wire		in_tx_qpi_pullup,
		output wire	[7:0]	out_avmmreaddata_cdr_pll,
		output wire	[7:0]	out_avmmreaddata_pma_adapt,
		output wire	[7:0]	out_avmmreaddata_pma_cdr_refclk,
		output wire	[7:0]	out_avmmreaddata_pma_cgb,
		output wire	[7:0]	out_avmmreaddata_pma_rx_buf,
		output wire	[7:0]	out_avmmreaddata_pma_rx_deser,
		output wire	[7:0]	out_avmmreaddata_pma_rx_dfe,
		output wire	[7:0]	out_avmmreaddata_pma_rx_odi,
		output wire	[7:0]	out_avmmreaddata_pma_rx_sd,
		output wire	[7:0]	out_avmmreaddata_pma_tx_buf,
		output wire	[7:0]	out_avmmreaddata_pma_tx_ser,
		output wire		out_blockselect_cdr_pll,
		output wire		out_blockselect_pma_adapt,
		output wire		out_blockselect_pma_cdr_refclk,
		output wire		out_blockselect_pma_cgb,
		output wire		out_blockselect_pma_rx_buf,
		output wire		out_blockselect_pma_rx_deser,
		output wire		out_blockselect_pma_rx_dfe,
		output wire		out_blockselect_pma_rx_odi,
		output wire		out_blockselect_pma_rx_sd,
		output wire		out_blockselect_pma_tx_buf,
		output wire		out_blockselect_pma_tx_ser,
		output wire		out_clk0_pfd,
		output wire		out_clk180_pfd,
		output wire		out_clk_divrx_iqtxrx,
		output wire		out_clk_divtx_iqtxrx,
		output wire		out_clkdiv_rx,
		output wire		out_clkdiv_rx_user,
		output wire		out_clkdiv_tx,
		output wire		out_clkdiv_tx_user,
		output wire		out_clklow,
		output wire		out_fref,
		output wire		out_iqtxrxclk_out0,
		output wire		out_iqtxrxclk_out1,
		output wire		out_jtaglpxn,
		output wire		out_jtaglpxp,
		output wire	[1:0]	out_pcie_sw_done,
		output wire	[1:0]	out_pcie_sw_master,
		output wire		out_pfdmode_lock,
		output wire		out_rx_detect_valid,
		output wire		out_rx_found,
		output wire	[63:0]	out_rxdata,
		output wire		out_rxpll_lock,
		output wire		out_sd,
		output wire		out_tx_n,
		output wire		out_tx_p
	//PORT_LIST_END
	);
	//wire declarations
	
	// wires for module twentynm_hssi_pma_rx_dfe
	wire	[7:0]	w_pma_rx_dfe_avmmreaddata;
	wire		w_pma_rx_dfe_blockselect;
	wire		w_pma_rx_dfe_clk0_bbpd;
	wire		w_pma_rx_dfe_clk180_bbpd;
	wire		w_pma_rx_dfe_clk270_bbpd;
	wire		w_pma_rx_dfe_clk90_bbpd;
	wire		w_pma_rx_dfe_deven;
	wire		w_pma_rx_dfe_devenb;
	wire	[7:0]	w_pma_rx_dfe_dfe_oc_tstmx;
	wire		w_pma_rx_dfe_dodd;
	wire		w_pma_rx_dfe_doddb;
	wire		w_pma_rx_dfe_edge270;
	wire		w_pma_rx_dfe_edge270b;
	wire		w_pma_rx_dfe_edge90;
	wire		w_pma_rx_dfe_edge90b;
	wire		w_pma_rx_dfe_err_ev;
	wire		w_pma_rx_dfe_err_evb;
	wire		w_pma_rx_dfe_err_od;
	wire		w_pma_rx_dfe_err_odb;
	wire		w_pma_rx_dfe_spec_vrefh;
	wire		w_pma_rx_dfe_spec_vrefl;
	
	// wires for module twentynm_hssi_pma_tx_ser
	wire	[7:0]	w_pma_tx_ser_avmmreaddata;
	wire		w_pma_tx_ser_blockselect;
	wire		w_pma_tx_ser_ckdrvn;
	wire		w_pma_tx_ser_ckdrvp;
	wire		w_pma_tx_ser_clk_divtx;
	wire		w_pma_tx_ser_clk_divtx_user;
	wire		w_pma_tx_ser_oe;
	wire		w_pma_tx_ser_oeb;
	wire		w_pma_tx_ser_oo;
	wire		w_pma_tx_ser_oob;
	
	// wires for module twentynm_hssi_pma_tx_buf
	wire	[2:0]	w_pma_tx_buf_atbsel;
	wire	[7:0]	w_pma_tx_buf_avmmreaddata;
	wire		w_pma_tx_buf_blockselect;
	wire		w_pma_tx_buf_ckn;
	wire		w_pma_tx_buf_ckp;
	wire		w_pma_tx_buf_dcd_out1;
	wire		w_pma_tx_buf_dcd_out2;
	wire		w_pma_tx_buf_dcd_out_ready;
	wire	[1:0]	w_pma_tx_buf_detect_on;
	wire		w_pma_tx_buf_lbvon;
	wire		w_pma_tx_buf_lbvop;
	wire		w_pma_tx_buf_rx_detect_valid;
	wire		w_pma_tx_buf_rx_found;
	wire		w_pma_tx_buf_rx_found_pcie_spl_test;
	wire		w_pma_tx_buf_sel_vreg;
	wire		w_pma_tx_buf_spl_clk_test;
	wire	[7:0]	w_pma_tx_buf_tx_dftout;
	wire		w_pma_tx_buf_vlptxn;
	wire		w_pma_tx_buf_vlptxp;
	wire		w_pma_tx_buf_von;
	wire		w_pma_tx_buf_vop;
	
	// wires for module twentynm_hssi_pma_tx_cgb
	wire	[7:0]	w_pma_cgb_avmmreaddata;
	wire		w_pma_cgb_bitslipstate;
	wire		w_pma_cgb_blockselect;
	wire	[5:0]	w_pma_cgb_cpulse_out_bus;
	wire		w_pma_cgb_div2;
	wire		w_pma_cgb_div4;
	wire		w_pma_cgb_div5;
	wire		w_pma_cgb_hifreqclkn;
	wire		w_pma_cgb_hifreqclkp;
	wire	[1:0]	w_pma_cgb_pcie_sw_done;
	wire	[1:0]	w_pma_cgb_pcie_sw_master;
	wire		w_pma_cgb_rstb;
	
	// wires for module twentynm_hssi_pma_rx_sd
	wire	[7:0]	w_pma_rx_sd_avmmreaddata;
	wire		w_pma_rx_sd_blockselect;
	wire		w_pma_rx_sd_sd;
	
	// wires for module twentynm_hssi_pma_rx_deser
	wire		w_pma_rx_deser_adapt_clk;
	wire	[7:0]	w_pma_rx_deser_avmmreaddata;
	wire		w_pma_rx_deser_blockselect;
	wire		w_pma_rx_deser_clkdiv;
	wire		w_pma_rx_deser_clkdiv_user;
	wire		w_pma_rx_deser_clkdivrx_rx;
	wire	[63:0]	w_pma_rx_deser_data;
	wire	[63:0]	w_pma_rx_deser_dout;
	wire	[63:0]	w_pma_rx_deser_error_deser;
	wire	[63:0]	w_pma_rx_deser_odi_dout;
	wire	[1:0]	w_pma_rx_deser_pcie_sw_ret;
	wire	[7:0]	w_pma_rx_deser_tstmx_deser;
	
	// wires for module twentynm_hssi_pma_cdr_refclk_select_mux
	wire	[7:0]	w_pma_cdr_refclk_avmmreaddata;
	wire		w_pma_cdr_refclk_blockselect;
	wire		w_pma_cdr_refclk_refclk;
	wire		w_pma_cdr_refclk_rx_det_clk;
	
	// wires for module twentynm_hssi_pma_adaptation
	wire	[7:0]	w_pma_adapt_avmmreaddata;
	wire		w_pma_adapt_blockselect;
	wire	[27:0]	w_pma_adapt_ctle_acgain_4s;
	wire	[14:0]	w_pma_adapt_ctle_eqz_1s_sel;
	wire	[6:0]	w_pma_adapt_ctle_lfeq_fb_sel;
	wire		w_pma_adapt_dfe_adapt_en;
	wire		w_pma_adapt_dfe_adp_clk;
	wire	[5:0]	w_pma_adapt_dfe_fltap1;
	wire		w_pma_adapt_dfe_fltap1_sgn;
	wire	[5:0]	w_pma_adapt_dfe_fltap2;
	wire		w_pma_adapt_dfe_fltap2_sgn;
	wire	[5:0]	w_pma_adapt_dfe_fltap3;
	wire		w_pma_adapt_dfe_fltap3_sgn;
	wire	[5:0]	w_pma_adapt_dfe_fltap4;
	wire		w_pma_adapt_dfe_fltap4_sgn;
	wire		w_pma_adapt_dfe_fltap_bypdeser;
	wire	[5:0]	w_pma_adapt_dfe_fltap_position;
	wire	[6:0]	w_pma_adapt_dfe_fxtap1;
	wire	[6:0]	w_pma_adapt_dfe_fxtap2;
	wire		w_pma_adapt_dfe_fxtap2_sgn;
	wire	[6:0]	w_pma_adapt_dfe_fxtap3;
	wire		w_pma_adapt_dfe_fxtap3_sgn;
	wire	[5:0]	w_pma_adapt_dfe_fxtap4;
	wire		w_pma_adapt_dfe_fxtap4_sgn;
	wire	[5:0]	w_pma_adapt_dfe_fxtap5;
	wire		w_pma_adapt_dfe_fxtap5_sgn;
	wire	[4:0]	w_pma_adapt_dfe_fxtap6;
	wire		w_pma_adapt_dfe_fxtap6_sgn;
	wire	[4:0]	w_pma_adapt_dfe_fxtap7;
	wire		w_pma_adapt_dfe_fxtap7_sgn;
	wire		w_pma_adapt_dfe_spec_disable;
	wire		w_pma_adapt_dfe_spec_sign_sel;
	wire		w_pma_adapt_dfe_vref_sign_sel;
	wire	[4:0]	w_pma_adapt_odi_vref;
	wire	[6:0]	w_pma_adapt_vga_sel;
	wire	[4:0]	w_pma_adapt_vref_sel;
	
	// wires for module twentynm_hssi_pma_rx_odi
	wire	[7:0]	w_pma_rx_odi_avmmreaddata;
	wire		w_pma_rx_odi_blockselect;
	wire		w_pma_rx_odi_clk0_eye;
	wire		w_pma_rx_odi_clk0_eye_lb;
	wire		w_pma_rx_odi_clk180_eye;
	wire		w_pma_rx_odi_clk180_eye_lb;
	wire		w_pma_rx_odi_de_eye;
	wire		w_pma_rx_odi_deb_eye;
	wire		w_pma_rx_odi_do_eye;
	wire		w_pma_rx_odi_dob_eye;
	wire		w_pma_rx_odi_odi_en;
	wire	[1:0]	w_pma_rx_odi_odi_oc_tstmx;
	
	// wires for module twentynm_hssi_pma_channel_pll
	wire	[7:0]	w_cdr_pll_avmmreaddata;
	wire		w_cdr_pll_blockselect;
	wire		w_cdr_pll_cdr_cnt_done;
	wire	[11:0]	w_cdr_pll_cdr_refclk_cal_out;
	wire	[11:0]	w_cdr_pll_cdr_vco_cal_out;
	wire		w_cdr_pll_clk0_des;
	wire		w_cdr_pll_clk0_odi;
	wire		w_cdr_pll_clk0_pd;
	wire		w_cdr_pll_clk0_pfd;
	wire		w_cdr_pll_clk180_des;
	wire		w_cdr_pll_clk180_odi;
	wire		w_cdr_pll_clk180_pd;
	wire		w_cdr_pll_clk180_pfd;
	wire		w_cdr_pll_clk270_odi;
	wire		w_cdr_pll_clk270_pd;
	wire		w_cdr_pll_clk90_odi;
	wire		w_cdr_pll_clk90_pd;
	wire		w_cdr_pll_clklow;
	wire		w_cdr_pll_deven_des;
	wire		w_cdr_pll_devenb_des;
	wire		w_cdr_pll_dodd_des;
	wire		w_cdr_pll_doddb_des;
	wire		w_cdr_pll_error_even_des;
	wire		w_cdr_pll_error_evenb_des;
	wire		w_cdr_pll_error_odd_des;
	wire		w_cdr_pll_error_oddb_des;
	wire		w_cdr_pll_fref;
	wire		w_cdr_pll_overrange;
	wire		w_cdr_pll_pfdmode_lock;
	wire		w_cdr_pll_rlpbkdn;
	wire		w_cdr_pll_rlpbkdp;
	wire		w_cdr_pll_rlpbkn;
	wire		w_cdr_pll_rlpbkp;
	wire		w_cdr_pll_rxpll_lock;
	wire		w_cdr_pll_tx_rlpbk;
	wire		w_cdr_pll_underrange;
	
	// wires for module twentynm_hssi_pma_rx_buf
	wire	[7:0]	w_pma_rx_buf_avmmreaddata;
	wire		w_pma_rx_buf_blockselect;
	wire		w_pma_rx_buf_inn;
	wire		w_pma_rx_buf_inp;
	wire		w_pma_rx_buf_outn;
	wire		w_pma_rx_buf_outp;
	wire		w_pma_rx_buf_pull_dn;
	wire		w_pma_rx_buf_rdlpbkn;
	wire		w_pma_rx_buf_rdlpbkp;
	
	
	generate
		
		//module instantiations
		
		// instantiating twentynm_hssi_pma_adaptation
		if ((xcvr_native_mode == "mode_rx_only") || (xcvr_native_mode == "mode_duplex")) begin:gen_twentynm_hssi_pma_adaptation
			twentynm_hssi_pma_adaptation #(
				.adapt_mode(pma_adapt_adapt_mode),
				.adp_1s_ctle_bypass(pma_adapt_adp_1s_ctle_bypass),
				.adp_4s_ctle_bypass(pma_adapt_adp_4s_ctle_bypass),
				.adp_ctle_adapt_cycle_window(pma_adapt_adp_ctle_adapt_cycle_window),
				.adp_ctle_en(pma_adapt_adp_ctle_en),
				.adp_dfe_fltap_bypass(pma_adapt_adp_dfe_fltap_bypass),
				.adp_dfe_fltap_en(pma_adapt_adp_dfe_fltap_en),
				.adp_dfe_fxtap_bypass(pma_adapt_adp_dfe_fxtap_bypass),
				.adp_dfe_fxtap_en(pma_adapt_adp_dfe_fxtap_en),
				.adp_dfe_fxtap_hold_en(pma_adapt_adp_dfe_fxtap_hold_en),
				.adp_dfe_mode(pma_adapt_adp_dfe_mode),
				.adp_mode(pma_adapt_adp_mode),
				.adp_onetime_dfe(pma_adapt_adp_onetime_dfe),
				.adp_vga_bypass(pma_adapt_adp_vga_bypass),
				.adp_vga_en(pma_adapt_adp_vga_en),
				.adp_vref_bypass(pma_adapt_adp_vref_bypass),
				.adp_vref_en(pma_adapt_adp_vref_en),
				.datarate(pma_adapt_datarate),
				.initial_settings("true"),       //PARAM_HIDE
				.odi_dfe_spec_en(pma_adapt_odi_dfe_spec_en),
				.optimal("false"),       //PARAM_HIDE
				.prot_mode(pma_adapt_prot_mode),
				.silicon_rev( "20nm1" ),       //PARAM_HIDE
				.sup_mode(pma_adapt_sup_mode)
			) inst_twentynm_hssi_pma_adaptation (
				// OUTPUTS
				.avmmreaddata(w_pma_adapt_avmmreaddata),
				.blockselect(w_pma_adapt_blockselect),
				.ctle_acgain_4s(w_pma_adapt_ctle_acgain_4s),
				.ctle_eqz_1s_sel(w_pma_adapt_ctle_eqz_1s_sel),
				.ctle_lfeq_fb_sel(w_pma_adapt_ctle_lfeq_fb_sel),
				.dfe_adapt_en(w_pma_adapt_dfe_adapt_en),
				.dfe_adp_clk(w_pma_adapt_dfe_adp_clk),
				.dfe_fltap1(w_pma_adapt_dfe_fltap1),
				.dfe_fltap1_sgn(w_pma_adapt_dfe_fltap1_sgn),
				.dfe_fltap2(w_pma_adapt_dfe_fltap2),
				.dfe_fltap2_sgn(w_pma_adapt_dfe_fltap2_sgn),
				.dfe_fltap3(w_pma_adapt_dfe_fltap3),
				.dfe_fltap3_sgn(w_pma_adapt_dfe_fltap3_sgn),
				.dfe_fltap4(w_pma_adapt_dfe_fltap4),
				.dfe_fltap4_sgn(w_pma_adapt_dfe_fltap4_sgn),
				.dfe_fltap_bypdeser(w_pma_adapt_dfe_fltap_bypdeser),
				.dfe_fltap_position(w_pma_adapt_dfe_fltap_position),
				.dfe_fxtap1(w_pma_adapt_dfe_fxtap1),
				.dfe_fxtap2(w_pma_adapt_dfe_fxtap2),
				.dfe_fxtap2_sgn(w_pma_adapt_dfe_fxtap2_sgn),
				.dfe_fxtap3(w_pma_adapt_dfe_fxtap3),
				.dfe_fxtap3_sgn(w_pma_adapt_dfe_fxtap3_sgn),
				.dfe_fxtap4(w_pma_adapt_dfe_fxtap4),
				.dfe_fxtap4_sgn(w_pma_adapt_dfe_fxtap4_sgn),
				.dfe_fxtap5(w_pma_adapt_dfe_fxtap5),
				.dfe_fxtap5_sgn(w_pma_adapt_dfe_fxtap5_sgn),
				.dfe_fxtap6(w_pma_adapt_dfe_fxtap6),
				.dfe_fxtap6_sgn(w_pma_adapt_dfe_fxtap6_sgn),
				.dfe_fxtap7(w_pma_adapt_dfe_fxtap7),
				.dfe_fxtap7_sgn(w_pma_adapt_dfe_fxtap7_sgn),
				.dfe_spec_disable(w_pma_adapt_dfe_spec_disable),
				.dfe_spec_sign_sel(w_pma_adapt_dfe_spec_sign_sel),
				.dfe_vref_sign_sel(w_pma_adapt_dfe_vref_sign_sel),
				.odi_vref(w_pma_adapt_odi_vref),
				.vga_sel(w_pma_adapt_vga_sel),
				.vref_sel(w_pma_adapt_vref_sel),
				// INPUTS
				.adapt_reset(in_pma_reserved_out[4]),
				.adapt_start(in_adapt_start),
				.avmmaddress({in_avmmaddress[8], in_avmmaddress[7], in_avmmaddress[6], in_avmmaddress[5], in_avmmaddress[4], in_avmmaddress[3], in_avmmaddress[2], in_avmmaddress[1], in_avmmaddress[0]}),
				.avmmclk(in_avmmclk),
				.avmmread(in_avmmread),
				.avmmrstn(in_avmmrstn),
				.avmmwrite(in_avmmwrite),
				.avmmwritedata({in_avmmwritedata[7], in_avmmwritedata[6], in_avmmwritedata[5], in_avmmwritedata[4], in_avmmwritedata[3], in_avmmwritedata[2], in_avmmwritedata[1], in_avmmwritedata[0]}),
				.deser_clk(w_pma_rx_deser_adapt_clk),
				.deser_data({w_pma_rx_deser_data[63], w_pma_rx_deser_data[62], w_pma_rx_deser_data[61], w_pma_rx_deser_data[60], w_pma_rx_deser_data[59], w_pma_rx_deser_data[58], w_pma_rx_deser_data[57], w_pma_rx_deser_data[56], w_pma_rx_deser_data[55], w_pma_rx_deser_data[54], w_pma_rx_deser_data[53], w_pma_rx_deser_data[52], w_pma_rx_deser_data[51], w_pma_rx_deser_data[50], w_pma_rx_deser_data[49], w_pma_rx_deser_data[48], w_pma_rx_deser_data[47], w_pma_rx_deser_data[46], w_pma_rx_deser_data[45], w_pma_rx_deser_data[44], w_pma_rx_deser_data[43], w_pma_rx_deser_data[42], w_pma_rx_deser_data[41], w_pma_rx_deser_data[40], w_pma_rx_deser_data[39], w_pma_rx_deser_data[38], w_pma_rx_deser_data[37], w_pma_rx_deser_data[36], w_pma_rx_deser_data[35], w_pma_rx_deser_data[34], w_pma_rx_deser_data[33], w_pma_rx_deser_data[32], w_pma_rx_deser_data[31], w_pma_rx_deser_data[30], w_pma_rx_deser_data[29], w_pma_rx_deser_data[28], w_pma_rx_deser_data[27], w_pma_rx_deser_data[26], w_pma_rx_deser_data[25], w_pma_rx_deser_data[24], w_pma_rx_deser_data[23], w_pma_rx_deser_data[22], w_pma_rx_deser_data[21], w_pma_rx_deser_data[20], w_pma_rx_deser_data[19], w_pma_rx_deser_data[18], w_pma_rx_deser_data[17], w_pma_rx_deser_data[16], w_pma_rx_deser_data[15], w_pma_rx_deser_data[14], w_pma_rx_deser_data[13], w_pma_rx_deser_data[12], w_pma_rx_deser_data[11], w_pma_rx_deser_data[10], w_pma_rx_deser_data[9], w_pma_rx_deser_data[8], w_pma_rx_deser_data[7], w_pma_rx_deser_data[6], w_pma_rx_deser_data[5], w_pma_rx_deser_data[4], w_pma_rx_deser_data[3], w_pma_rx_deser_data[2], w_pma_rx_deser_data[1], w_pma_rx_deser_data[0]}),
				.deser_error({w_pma_rx_deser_error_deser[63], w_pma_rx_deser_error_deser[62], w_pma_rx_deser_error_deser[61], w_pma_rx_deser_error_deser[60], w_pma_rx_deser_error_deser[59], w_pma_rx_deser_error_deser[58], w_pma_rx_deser_error_deser[57], w_pma_rx_deser_error_deser[56], w_pma_rx_deser_error_deser[55], w_pma_rx_deser_error_deser[54], w_pma_rx_deser_error_deser[53], w_pma_rx_deser_error_deser[52], w_pma_rx_deser_error_deser[51], w_pma_rx_deser_error_deser[50], w_pma_rx_deser_error_deser[49], w_pma_rx_deser_error_deser[48], w_pma_rx_deser_error_deser[47], w_pma_rx_deser_error_deser[46], w_pma_rx_deser_error_deser[45], w_pma_rx_deser_error_deser[44], w_pma_rx_deser_error_deser[43], w_pma_rx_deser_error_deser[42], w_pma_rx_deser_error_deser[41], w_pma_rx_deser_error_deser[40], w_pma_rx_deser_error_deser[39], w_pma_rx_deser_error_deser[38], w_pma_rx_deser_error_deser[37], w_pma_rx_deser_error_deser[36], w_pma_rx_deser_error_deser[35], w_pma_rx_deser_error_deser[34], w_pma_rx_deser_error_deser[33], w_pma_rx_deser_error_deser[32], w_pma_rx_deser_error_deser[31], w_pma_rx_deser_error_deser[30], w_pma_rx_deser_error_deser[29], w_pma_rx_deser_error_deser[28], w_pma_rx_deser_error_deser[27], w_pma_rx_deser_error_deser[26], w_pma_rx_deser_error_deser[25], w_pma_rx_deser_error_deser[24], w_pma_rx_deser_error_deser[23], w_pma_rx_deser_error_deser[22], w_pma_rx_deser_error_deser[21], w_pma_rx_deser_error_deser[20], w_pma_rx_deser_error_deser[19], w_pma_rx_deser_error_deser[18], w_pma_rx_deser_error_deser[17], w_pma_rx_deser_error_deser[16], w_pma_rx_deser_error_deser[15], w_pma_rx_deser_error_deser[14], w_pma_rx_deser_error_deser[13], w_pma_rx_deser_error_deser[12], w_pma_rx_deser_error_deser[11], w_pma_rx_deser_error_deser[10], w_pma_rx_deser_error_deser[9], w_pma_rx_deser_error_deser[8], w_pma_rx_deser_error_deser[7], w_pma_rx_deser_error_deser[6], w_pma_rx_deser_error_deser[5], w_pma_rx_deser_error_deser[4], w_pma_rx_deser_error_deser[3], w_pma_rx_deser_error_deser[2], w_pma_rx_deser_error_deser[1], w_pma_rx_deser_error_deser[0]}),
				.deser_odi({w_pma_rx_deser_odi_dout[63], w_pma_rx_deser_odi_dout[62], w_pma_rx_deser_odi_dout[61], w_pma_rx_deser_odi_dout[60], w_pma_rx_deser_odi_dout[59], w_pma_rx_deser_odi_dout[58], w_pma_rx_deser_odi_dout[57], w_pma_rx_deser_odi_dout[56], w_pma_rx_deser_odi_dout[55], w_pma_rx_deser_odi_dout[54], w_pma_rx_deser_odi_dout[53], w_pma_rx_deser_odi_dout[52], w_pma_rx_deser_odi_dout[51], w_pma_rx_deser_odi_dout[50], w_pma_rx_deser_odi_dout[49], w_pma_rx_deser_odi_dout[48], w_pma_rx_deser_odi_dout[47], w_pma_rx_deser_odi_dout[46], w_pma_rx_deser_odi_dout[45], w_pma_rx_deser_odi_dout[44], w_pma_rx_deser_odi_dout[43], w_pma_rx_deser_odi_dout[42], w_pma_rx_deser_odi_dout[41], w_pma_rx_deser_odi_dout[40], w_pma_rx_deser_odi_dout[39], w_pma_rx_deser_odi_dout[38], w_pma_rx_deser_odi_dout[37], w_pma_rx_deser_odi_dout[36], w_pma_rx_deser_odi_dout[35], w_pma_rx_deser_odi_dout[34], w_pma_rx_deser_odi_dout[33], w_pma_rx_deser_odi_dout[32], w_pma_rx_deser_odi_dout[31], w_pma_rx_deser_odi_dout[30], w_pma_rx_deser_odi_dout[29], w_pma_rx_deser_odi_dout[28], w_pma_rx_deser_odi_dout[27], w_pma_rx_deser_odi_dout[26], w_pma_rx_deser_odi_dout[25], w_pma_rx_deser_odi_dout[24], w_pma_rx_deser_odi_dout[23], w_pma_rx_deser_odi_dout[22], w_pma_rx_deser_odi_dout[21], w_pma_rx_deser_odi_dout[20], w_pma_rx_deser_odi_dout[19], w_pma_rx_deser_odi_dout[18], w_pma_rx_deser_odi_dout[17], w_pma_rx_deser_odi_dout[16], w_pma_rx_deser_odi_dout[15], w_pma_rx_deser_odi_dout[14], w_pma_rx_deser_odi_dout[13], w_pma_rx_deser_odi_dout[12], w_pma_rx_deser_odi_dout[11], w_pma_rx_deser_odi_dout[10], w_pma_rx_deser_odi_dout[9], w_pma_rx_deser_odi_dout[8], w_pma_rx_deser_odi_dout[7], w_pma_rx_deser_odi_dout[6], w_pma_rx_deser_odi_dout[5], w_pma_rx_deser_odi_dout[4], w_pma_rx_deser_odi_dout[3], w_pma_rx_deser_odi_dout[2], w_pma_rx_deser_odi_dout[1], w_pma_rx_deser_odi_dout[0]}),
				.deser_odi_clk(1'b0),
				.global_pipe_se(in_pma_atpg_los_en_n_in),
				.i_rxpreset({in_i_rxpreset[2], in_i_rxpreset[1], in_i_rxpreset[0]}),
				.rx_pllfreqlock(w_cdr_pll_rxpll_lock),
				.scan_clk(in_core_refclk_in),
				.scan_in({in_pma_reserved_out[3], in_pma_reserved_out[2], in_pma_reserved_out[1], in_pma_reserved_out[0], in_eye_monitor[5], in_eye_monitor[4], in_eye_monitor[3], in_eye_monitor[2], in_eye_monitor[1], in_eye_monitor[0]}),
				.test_mode(in_scan_mode_n),
				.test_se(in_scan_shift_n),
				
				// UNUSED
				.radp_ctle_hold_en(),
				.radp_ctle_patt_en(),
				.radp_ctle_preset_sel(),
				.radp_enable_max_lfeq_scale(),
				.radp_lfeq_hold_en(),
				.radp_vga_polarity(),
				.scan_out(),
				.status_bus()
			);
		end // if generate
		else begin
				assign w_pma_adapt_avmmreaddata[7:0] = 8'b0;
				assign w_pma_adapt_blockselect = 1'b0;
				assign w_pma_adapt_ctle_acgain_4s[27:0] = 28'b0;
				assign w_pma_adapt_ctle_eqz_1s_sel[14:0] = 15'b0;
				assign w_pma_adapt_ctle_lfeq_fb_sel[6:0] = 7'b0;
				assign w_pma_adapt_dfe_adapt_en = 1'b0;
				assign w_pma_adapt_dfe_adp_clk = 1'b0;
				assign w_pma_adapt_dfe_fltap1[5:0] = 6'b0;
				assign w_pma_adapt_dfe_fltap1_sgn = 1'b0;
				assign w_pma_adapt_dfe_fltap2[5:0] = 6'b0;
				assign w_pma_adapt_dfe_fltap2_sgn = 1'b0;
				assign w_pma_adapt_dfe_fltap3[5:0] = 6'b0;
				assign w_pma_adapt_dfe_fltap3_sgn = 1'b0;
				assign w_pma_adapt_dfe_fltap4[5:0] = 6'b0;
				assign w_pma_adapt_dfe_fltap4_sgn = 1'b0;
				assign w_pma_adapt_dfe_fltap_bypdeser = 1'b0;
				assign w_pma_adapt_dfe_fltap_position[5:0] = 6'b0;
				assign w_pma_adapt_dfe_fxtap1[6:0] = 7'b0;
				assign w_pma_adapt_dfe_fxtap2[6:0] = 7'b0;
				assign w_pma_adapt_dfe_fxtap2_sgn = 1'b0;
				assign w_pma_adapt_dfe_fxtap3[6:0] = 7'b0;
				assign w_pma_adapt_dfe_fxtap3_sgn = 1'b0;
				assign w_pma_adapt_dfe_fxtap4[5:0] = 6'b0;
				assign w_pma_adapt_dfe_fxtap4_sgn = 1'b0;
				assign w_pma_adapt_dfe_fxtap5[5:0] = 6'b0;
				assign w_pma_adapt_dfe_fxtap5_sgn = 1'b0;
				assign w_pma_adapt_dfe_fxtap6[4:0] = 5'b0;
				assign w_pma_adapt_dfe_fxtap6_sgn = 1'b0;
				assign w_pma_adapt_dfe_fxtap7[4:0] = 5'b0;
				assign w_pma_adapt_dfe_fxtap7_sgn = 1'b0;
				assign w_pma_adapt_dfe_spec_disable = 1'b0;
				assign w_pma_adapt_dfe_spec_sign_sel = 1'b0;
				assign w_pma_adapt_dfe_vref_sign_sel = 1'b0;
				assign w_pma_adapt_odi_vref[4:0] = 5'b0;
				assign w_pma_adapt_vga_sel[6:0] = 7'b0;
				assign w_pma_adapt_vref_sel[4:0] = 5'b0;
		end // if not generate
		
		// instantiating twentynm_hssi_pma_cdr_refclk_select_mux
		if ((xcvr_native_mode == "mode_rx_only") || (xcvr_native_mode == "mode_duplex")) begin:gen_twentynm_hssi_pma_cdr_refclk_select_mux
			twentynm_hssi_pma_cdr_refclk_select_mux #(
				.inclk0_logical_to_physical_mapping(pma_cdr_refclk_inclk0_logical_to_physical_mapping),
				.inclk1_logical_to_physical_mapping(pma_cdr_refclk_inclk1_logical_to_physical_mapping),
				.inclk2_logical_to_physical_mapping(pma_cdr_refclk_inclk2_logical_to_physical_mapping),
				.inclk3_logical_to_physical_mapping(pma_cdr_refclk_inclk3_logical_to_physical_mapping),
				.inclk4_logical_to_physical_mapping(pma_cdr_refclk_inclk4_logical_to_physical_mapping),
				.powerdown_mode(pma_cdr_refclk_powerdown_mode),
				.refclk_select(pma_cdr_refclk_refclk_select),
				.silicon_rev( "20nm1" )       //PARAM_HIDE
			) inst_twentynm_hssi_pma_cdr_refclk_select_mux (
				// OUTPUTS
				.avmmreaddata(w_pma_cdr_refclk_avmmreaddata),
				.blockselect(w_pma_cdr_refclk_blockselect),
				.refclk(w_pma_cdr_refclk_refclk),
				.rx_det_clk(w_pma_cdr_refclk_rx_det_clk),
				// INPUTS
				.avmmaddress({in_avmmaddress[8], in_avmmaddress[7], in_avmmaddress[6], in_avmmaddress[5], in_avmmaddress[4], in_avmmaddress[3], in_avmmaddress[2], in_avmmaddress[1], in_avmmaddress[0]}),
				.avmmclk(in_avmmclk),
				.avmmread(in_avmmread),
				.avmmrstn(in_avmmrstn),
				.avmmwrite(in_avmmwrite),
				.avmmwritedata({in_avmmwritedata[7], in_avmmwritedata[6], in_avmmwritedata[5], in_avmmwritedata[4], in_avmmwritedata[3], in_avmmwritedata[2], in_avmmwritedata[1], in_avmmwritedata[0]}),
				.core_refclk(in_core_refclk_in),
				.iqtxrxclk({in_iqtxrxclk[5], in_iqtxrxclk[4], in_iqtxrxclk[3], in_iqtxrxclk[2], in_iqtxrxclk[1], in_iqtxrxclk[0]}),
				.ref_iqclk({in_ref_iqclk[11], in_ref_iqclk[10], in_ref_iqclk[9], in_ref_iqclk[8], in_ref_iqclk[7], in_ref_iqclk[6], in_ref_iqclk[5], in_ref_iqclk[4], in_ref_iqclk[3], in_ref_iqclk[2], in_ref_iqclk[1], in_ref_iqclk[0]})
			);
		end // if generate
		else begin
				assign w_pma_cdr_refclk_avmmreaddata[7:0] = 8'b0;
				assign w_pma_cdr_refclk_blockselect = 1'b0;
				assign w_pma_cdr_refclk_refclk = 1'b0;
				assign w_pma_cdr_refclk_rx_det_clk = 1'b0;
		end // if not generate
		
		// instantiating twentynm_hssi_pma_channel_pll
		if ((xcvr_native_mode == "mode_rx_only") || (xcvr_native_mode == "mode_duplex")) begin:gen_twentynm_hssi_pma_channel_pll
			twentynm_hssi_pma_channel_pll #(
				.atb_select_control(cdr_pll_atb_select_control),
				.auto_reset_on(cdr_pll_auto_reset_on),
				.bbpd_data_pattern_filter_select(cdr_pll_bbpd_data_pattern_filter_select),
				.bw_sel(cdr_pll_bw_sel),
				.cal_vco_count_length(cdr_pll_cal_vco_count_length),
				.cdr_odi_select(cdr_pll_cdr_odi_select),
				.cdr_phaselock_mode(cdr_pll_cdr_phaselock_mode),
				.cdr_powerdown_mode(cdr_pll_cdr_powerdown_mode),
				.cgb_div(cdr_pll_cgb_div),
				.chgpmp_current_dn_pd(cdr_pll_chgpmp_current_dn_pd),
				.chgpmp_current_dn_trim(cdr_pll_chgpmp_current_dn_trim),
				.chgpmp_current_pd(cdr_pll_chgpmp_current_pd),
				.chgpmp_current_pfd(cdr_pll_chgpmp_current_pfd),
				.chgpmp_current_up_pd(cdr_pll_chgpmp_current_up_pd),
				.chgpmp_current_up_trim(cdr_pll_chgpmp_current_up_trim),
				.chgpmp_dn_pd_trim_double(cdr_pll_chgpmp_dn_pd_trim_double),
				.chgpmp_replicate(cdr_pll_chgpmp_replicate),
				.chgpmp_testmode(cdr_pll_chgpmp_testmode),
				.chgpmp_up_pd_trim_double(cdr_pll_chgpmp_up_pd_trim_double),
				.clklow_mux_select(cdr_pll_clklow_mux_select),
				.datarate(cdr_pll_datarate),
				.diag_loopback_enable(cdr_pll_diag_loopback_enable),
				.disable_up_dn(cdr_pll_disable_up_dn),
				.fb_select(cdr_pll_fb_select),
				.fref_clklow_div(cdr_pll_fref_clklow_div),
				.fref_mux_select(cdr_pll_fref_mux_select),
				.gpon_lck2ref_control(cdr_pll_gpon_lck2ref_control),
				.initial_settings(cdr_pll_initial_settings),
				.iqclk_mux_sel(cdr_pll_iqclk_mux_sel),
				.is_cascaded_pll(cdr_pll_is_cascaded_pll),
				.lck2ref_delay_control(cdr_pll_lck2ref_delay_control),
				.lf_resistor_pd(cdr_pll_lf_resistor_pd),
				.lf_resistor_pfd(cdr_pll_lf_resistor_pfd),
				.lf_ripple_cap(cdr_pll_lf_ripple_cap),
				.loop_filter_bias_select(cdr_pll_loop_filter_bias_select),
				.loopback_mode(cdr_pll_loopback_mode),
				.lpd_counter(cdr_pll_lpd_counter),
				.lpfd_counter(cdr_pll_lpfd_counter),
				.ltd_ltr_micro_controller_select(cdr_pll_ltd_ltr_micro_controller_select),
				.m_counter(cdr_pll_m_counter),
				.n_counter(cdr_pll_n_counter),
				.n_counter_scratch(cdr_pll_n_counter_scratch),
				.optimal("false"),       //PARAM_HIDE
				.output_clock_frequency(cdr_pll_output_clock_frequency),
				.pcie_gen(cdr_pll_pcie_gen),
				.pd_fastlock_mode(cdr_pll_pd_fastlock_mode),
				.pd_l_counter(cdr_pll_pd_l_counter),
				.pfd_l_counter(cdr_pll_pfd_l_counter),
				.pma_width(cdr_pll_pma_width),
				.primary_use(cdr_pll_primary_use),
				.prot_mode(cdr_pll_prot_mode),
				.reference_clock_frequency(cdr_pll_reference_clock_frequency),
				.reverse_serial_loopback(cdr_pll_reverse_serial_loopback),
				.set_cdr_input_freq_range(cdr_pll_set_cdr_input_freq_range),
				.set_cdr_v2i_enable(cdr_pll_set_cdr_v2i_enable),
				.set_cdr_vco_reset(cdr_pll_set_cdr_vco_reset),
				.set_cdr_vco_speed(cdr_pll_set_cdr_vco_speed),
				.set_cdr_vco_speed_fix(cdr_pll_set_cdr_vco_speed_fix),
				.set_cdr_vco_speed_pciegen3(cdr_pll_set_cdr_vco_speed_pciegen3),
				.silicon_rev( "20nm1" ),       //PARAM_HIDE
				.sup_mode(cdr_pll_sup_mode),
				.tx_pll_prot_mode(cdr_pll_tx_pll_prot_mode),
				.txpll_hclk_driver_enable(cdr_pll_txpll_hclk_driver_enable),
				.uc_ro_cal(cdr_pll_uc_ro_cal),
				.vco_freq(cdr_pll_vco_freq),
				.vco_overrange_voltage(cdr_pll_vco_overrange_voltage),
				.vco_underrange_voltage(cdr_pll_vco_underrange_voltage)
			) inst_twentynm_hssi_pma_channel_pll (
				// OUTPUTS
				.avmmreaddata(w_cdr_pll_avmmreaddata),
				.blockselect(w_cdr_pll_blockselect),
				.cdr_cnt_done(w_cdr_pll_cdr_cnt_done),
				.cdr_refclk_cal_out(w_cdr_pll_cdr_refclk_cal_out),
				.cdr_vco_cal_out(w_cdr_pll_cdr_vco_cal_out),
				.clk0_des(w_cdr_pll_clk0_des),
				.clk0_odi(w_cdr_pll_clk0_odi),
				.clk0_pd(w_cdr_pll_clk0_pd),
				.clk0_pfd(w_cdr_pll_clk0_pfd),
				.clk180_des(w_cdr_pll_clk180_des),
				.clk180_odi(w_cdr_pll_clk180_odi),
				.clk180_pd(w_cdr_pll_clk180_pd),
				.clk180_pfd(w_cdr_pll_clk180_pfd),
				.clk270_odi(w_cdr_pll_clk270_odi),
				.clk270_pd(w_cdr_pll_clk270_pd),
				.clk90_odi(w_cdr_pll_clk90_odi),
				.clk90_pd(w_cdr_pll_clk90_pd),
				.clklow(w_cdr_pll_clklow),
				.deven_des(w_cdr_pll_deven_des),
				.devenb_des(w_cdr_pll_devenb_des),
				.dodd_des(w_cdr_pll_dodd_des),
				.doddb_des(w_cdr_pll_doddb_des),
				.error_even_des(w_cdr_pll_error_even_des),
				.error_evenb_des(w_cdr_pll_error_evenb_des),
				.error_odd_des(w_cdr_pll_error_odd_des),
				.error_oddb_des(w_cdr_pll_error_oddb_des),
				.fref(w_cdr_pll_fref),
				.overrange(w_cdr_pll_overrange),
				.pfdmode_lock(w_cdr_pll_pfdmode_lock),
				.rlpbkdn(w_cdr_pll_rlpbkdn),
				.rlpbkdp(w_cdr_pll_rlpbkdp),
				.rlpbkn(w_cdr_pll_rlpbkn),
				.rlpbkp(w_cdr_pll_rlpbkp),
				.rxpll_lock(w_cdr_pll_rxpll_lock),
				.tx_rlpbk(w_cdr_pll_tx_rlpbk),
				.underrange(w_cdr_pll_underrange),
				// INPUTS
				.adapt_en(w_pma_adapt_dfe_adapt_en),
				.avmmaddress({in_avmmaddress[8], in_avmmaddress[7], in_avmmaddress[6], in_avmmaddress[5], in_avmmaddress[4], in_avmmaddress[3], in_avmmaddress[2], in_avmmaddress[1], in_avmmaddress[0]}),
				.avmmclk(in_avmmclk),
				.avmmread(in_avmmread),
				.avmmrstn(in_avmmrstn),
				.avmmwrite(in_avmmwrite),
				.avmmwritedata({in_avmmwritedata[7], in_avmmwritedata[6], in_avmmwritedata[5], in_avmmwritedata[4], in_avmmwritedata[3], in_avmmwritedata[2], in_avmmwritedata[1], in_avmmwritedata[0]}),
				.clk0_bbpd(w_pma_rx_dfe_clk0_bbpd),
				.clk180_bbpd(w_pma_rx_dfe_clk180_bbpd),
				.clk270_bbpd(w_pma_rx_dfe_clk270_bbpd),
				.clk90_bbpd(w_pma_rx_dfe_clk90_bbpd),
				.deven(w_pma_rx_dfe_deven),
				.devenb(w_pma_rx_dfe_devenb),
				.dfe_test(1'b0),
				.dodd(w_pma_rx_dfe_dodd),
				.doddb(w_pma_rx_dfe_doddb),
				.e270(w_pma_rx_dfe_edge270),
				.e270b(w_pma_rx_dfe_edge270b),
				.e90(w_pma_rx_dfe_edge90),
				.e90b(w_pma_rx_dfe_edge90b),
				.early_eios(in_early_eios),
				.error_even(w_pma_rx_dfe_err_ev),
				.error_evenb(w_pma_rx_dfe_err_evb),
				.error_odd(w_pma_rx_dfe_err_od),
				.error_oddb(w_pma_rx_dfe_err_odb),
				.fpll_test0(in_fpll_ppm_clk_in[0]),
				.fpll_test1(in_fpll_ppm_clk_in[1]),
				.iqtxrxclk({in_iqtxrxclk[5], in_iqtxrxclk[4], in_iqtxrxclk[3], in_iqtxrxclk[2], in_iqtxrxclk[1], in_iqtxrxclk[0]}),
				.ltd_b(in_ltd_b),
				.ltr(in_ltr),
				.odi_clk(w_pma_rx_odi_clk0_eye_lb),
				.odi_clkb(w_pma_rx_odi_clk180_eye_lb),
				.pcie_sw_ret({w_pma_rx_deser_pcie_sw_ret[1], w_pma_rx_deser_pcie_sw_ret[0]}),
				.ppm_lock(in_ppm_lock),
				.refclk(w_pma_cdr_refclk_refclk),
				.rst_n(in_rx_pma_rstb),
				.rx_deser_pclk_test(w_pma_rx_deser_clkdivrx_rx),
				.rx_lpbkn(w_pma_rx_buf_rdlpbkn),
				.rx_lpbkp(w_pma_rx_buf_rdlpbkp),
				.rxp(in_rx_p),
				.sd(w_pma_rx_sd_sd),
				.tx_ser_pclk_test(w_pma_tx_ser_clk_divtx),
				
				// UNUSED
				.atbsel(),
				.cdr_lpbkdp(),
				.cdr_lpbkp(),
				.clk270_des(),
				.clk90_des(),
				.lock2ref(),
				.rx_signal_ok(),
				.von_lp(),
				.vop_lp()
			);
		end // if generate
		else begin
				assign w_cdr_pll_avmmreaddata[7:0] = 8'b0;
				assign w_cdr_pll_blockselect = 1'b0;
				assign w_cdr_pll_cdr_cnt_done = 1'b0;
				assign w_cdr_pll_cdr_refclk_cal_out[11:0] = 12'b0;
				assign w_cdr_pll_cdr_vco_cal_out[11:0] = 12'b0;
				assign w_cdr_pll_clk0_des = 1'b0;
				assign w_cdr_pll_clk0_odi = 1'b0;
				assign w_cdr_pll_clk0_pd = 1'b0;
				assign w_cdr_pll_clk0_pfd = 1'b0;
				assign w_cdr_pll_clk180_des = 1'b0;
				assign w_cdr_pll_clk180_odi = 1'b0;
				assign w_cdr_pll_clk180_pd = 1'b0;
				assign w_cdr_pll_clk180_pfd = 1'b0;
				assign w_cdr_pll_clk270_odi = 1'b0;
				assign w_cdr_pll_clk270_pd = 1'b0;
				assign w_cdr_pll_clk90_odi = 1'b0;
				assign w_cdr_pll_clk90_pd = 1'b0;
				assign w_cdr_pll_clklow = 1'b0;
				assign w_cdr_pll_deven_des = 1'b0;
				assign w_cdr_pll_devenb_des = 1'b0;
				assign w_cdr_pll_dodd_des = 1'b0;
				assign w_cdr_pll_doddb_des = 1'b0;
				assign w_cdr_pll_error_even_des = 1'b0;
				assign w_cdr_pll_error_evenb_des = 1'b0;
				assign w_cdr_pll_error_odd_des = 1'b0;
				assign w_cdr_pll_error_oddb_des = 1'b0;
				assign w_cdr_pll_fref = 1'b0;
				assign w_cdr_pll_overrange = 1'b0;
				assign w_cdr_pll_pfdmode_lock = 1'b0;
				assign w_cdr_pll_rlpbkdn = 1'b0;
				assign w_cdr_pll_rlpbkdp = 1'b0;
				assign w_cdr_pll_rlpbkn = 1'b0;
				assign w_cdr_pll_rlpbkp = 1'b0;
				assign w_cdr_pll_rxpll_lock = 1'b0;
				assign w_cdr_pll_tx_rlpbk = 1'b0;
				assign w_cdr_pll_underrange = 1'b0;
		end // if not generate
		
		// instantiating twentynm_hssi_pma_rx_buf
		if ((xcvr_native_mode == "mode_rx_only") || (xcvr_native_mode == "mode_duplex")) begin:gen_twentynm_hssi_pma_rx_buf
			twentynm_hssi_pma_rx_buf #(
				.bypass_eqz_stages_234(pma_rx_buf_bypass_eqz_stages_234),
				.datarate(pma_rx_buf_datarate),
				.diag_lp_en(pma_rx_buf_diag_lp_en),
				.initial_settings("true"),       //PARAM_HIDE
				.loopback_modes(pma_rx_buf_loopback_modes),
				.optimal("false"),       //PARAM_HIDE
				.pdb_rx("normal_rx_on"),       //PARAM_HIDE
				.pm_tx_rx_cvp_mode(pma_rx_buf_pm_tx_rx_cvp_mode),
				.pm_tx_rx_pcie_gen(pma_rx_buf_pm_tx_rx_pcie_gen),
				.pm_tx_rx_pcie_gen_bitwidth(pma_rx_buf_pm_tx_rx_pcie_gen_bitwidth),
				.prot_mode(pma_rx_buf_prot_mode),
				.qpi_enable(pma_rx_buf_qpi_enable),
				.refclk_en(pma_rx_buf_refclk_en),
				.rx_refclk_divider(pma_rx_buf_rx_refclk_divider),
				.silicon_rev( "20nm1" ),       //PARAM_HIDE
				.sup_mode(pma_rx_buf_sup_mode),
				.xrx_path_datarate(pma_rx_buf_xrx_path_datarate),
				.xrx_path_datawidth(pma_rx_buf_xrx_path_datawidth),
				.xrx_path_initial_settings("true"),       //PARAM_HIDE
				.xrx_path_optimal("false"),       //PARAM_HIDE
				.xrx_path_pma_rx_divclk_hz(pma_rx_buf_xrx_path_pma_rx_divclk_hz),
				.xrx_path_prot_mode(pma_rx_buf_xrx_path_prot_mode),
				.xrx_path_sup_mode(pma_rx_buf_xrx_path_sup_mode),
				.xrx_path_uc_cal_enable(pma_rx_buf_xrx_path_uc_cal_enable)
			) inst_twentynm_hssi_pma_rx_buf (
				// OUTPUTS
				.avmmreaddata(w_pma_rx_buf_avmmreaddata),
				.blockselect(w_pma_rx_buf_blockselect),
				.inn(w_pma_rx_buf_inn),
				.inp(w_pma_rx_buf_inp),
				.outn(w_pma_rx_buf_outn),
				.outp(w_pma_rx_buf_outp),
				.pull_dn(w_pma_rx_buf_pull_dn),
				.rdlpbkn(w_pma_rx_buf_rdlpbkn),
				.rdlpbkp(w_pma_rx_buf_rdlpbkp),
				// INPUTS
				.avmmaddress({in_avmmaddress[8], in_avmmaddress[7], in_avmmaddress[6], in_avmmaddress[5], in_avmmaddress[4], in_avmmaddress[3], in_avmmaddress[2], in_avmmaddress[1], in_avmmaddress[0]}),
				.avmmclk(in_avmmclk),
				.avmmread(in_avmmread),
				.avmmrstn(in_avmmrstn),
				.avmmwrite(in_avmmwrite),
				.avmmwritedata({in_avmmwritedata[7], in_avmmwritedata[6], in_avmmwritedata[5], in_avmmwritedata[4], in_avmmwritedata[3], in_avmmwritedata[2], in_avmmwritedata[1], in_avmmwritedata[0]}),
				.clk_divrx(w_pma_rx_deser_clkdivrx_rx),
				.lpbkn(w_pma_tx_buf_lbvon),
				.lpbkp(w_pma_tx_buf_lbvop),
				.rx_qpi_pulldn(in_rx_qpi_pulldn),
				.rx_rstn(in_rx_pma_rstb),
				.rx_sel_b50({in_rx50_buf_in[5], in_rx50_buf_in[4], in_rx50_buf_in[3], in_rx50_buf_in[2], in_rx50_buf_in[1], in_rx50_buf_in[0]}),
				.rxn(in_rx_n),
				.rxp(in_rx_p),
				.s_lpbk_b(in_rs_lpbk_b),
				.vcz({w_pma_adapt_ctle_acgain_4s[27], w_pma_adapt_ctle_acgain_4s[26], w_pma_adapt_ctle_acgain_4s[25], w_pma_adapt_ctle_acgain_4s[24], w_pma_adapt_ctle_acgain_4s[23], w_pma_adapt_ctle_acgain_4s[22], w_pma_adapt_ctle_acgain_4s[21], w_pma_adapt_ctle_acgain_4s[20], w_pma_adapt_ctle_acgain_4s[19], w_pma_adapt_ctle_acgain_4s[18], w_pma_adapt_ctle_acgain_4s[17], w_pma_adapt_ctle_acgain_4s[16], w_pma_adapt_ctle_acgain_4s[15], w_pma_adapt_ctle_acgain_4s[14], w_pma_adapt_ctle_acgain_4s[13], w_pma_adapt_ctle_acgain_4s[12], w_pma_adapt_ctle_acgain_4s[11], w_pma_adapt_ctle_acgain_4s[10], w_pma_adapt_ctle_acgain_4s[9], w_pma_adapt_ctle_acgain_4s[8], w_pma_adapt_ctle_acgain_4s[7], w_pma_adapt_ctle_acgain_4s[6], w_pma_adapt_ctle_acgain_4s[5], w_pma_adapt_ctle_acgain_4s[4], w_pma_adapt_ctle_acgain_4s[3], w_pma_adapt_ctle_acgain_4s[2], w_pma_adapt_ctle_acgain_4s[1], w_pma_adapt_ctle_acgain_4s[0]}),
				.vds_eqz_s1_set({w_pma_adapt_ctle_eqz_1s_sel[14], w_pma_adapt_ctle_eqz_1s_sel[13], w_pma_adapt_ctle_eqz_1s_sel[12], w_pma_adapt_ctle_eqz_1s_sel[11], w_pma_adapt_ctle_eqz_1s_sel[10], w_pma_adapt_ctle_eqz_1s_sel[9], w_pma_adapt_ctle_eqz_1s_sel[8], w_pma_adapt_ctle_eqz_1s_sel[7], w_pma_adapt_ctle_eqz_1s_sel[6], w_pma_adapt_ctle_eqz_1s_sel[5], w_pma_adapt_ctle_eqz_1s_sel[4], w_pma_adapt_ctle_eqz_1s_sel[3], w_pma_adapt_ctle_eqz_1s_sel[2], w_pma_adapt_ctle_eqz_1s_sel[1], w_pma_adapt_ctle_eqz_1s_sel[0]}),
				.vds_lfeqz_czero({1'b0, 1'b0}),
				.vds_lfeqz_fb_set({w_pma_adapt_ctle_lfeq_fb_sel[6], w_pma_adapt_ctle_lfeq_fb_sel[5], w_pma_adapt_ctle_lfeq_fb_sel[4], w_pma_adapt_ctle_lfeq_fb_sel[3], w_pma_adapt_ctle_lfeq_fb_sel[2], w_pma_adapt_ctle_lfeq_fb_sel[1], w_pma_adapt_ctle_lfeq_fb_sel[0]}),
				.vds_vga_set({w_pma_adapt_vga_sel[6], w_pma_adapt_vga_sel[5], w_pma_adapt_vga_sel[4], w_pma_adapt_vga_sel[3], w_pma_adapt_vga_sel[2], w_pma_adapt_vga_sel[1], w_pma_adapt_vga_sel[0]}),
				
				// UNUSED
				.rx_refclk(),
				.vga_cm_bidir_in(),
				.vga_cm_bidir_out()
			);
		end // if generate
		else begin
				assign w_pma_rx_buf_avmmreaddata[7:0] = 8'b0;
				assign w_pma_rx_buf_blockselect = 1'b0;
				assign w_pma_rx_buf_inn = 1'b0;
				assign w_pma_rx_buf_inp = 1'b0;
				assign w_pma_rx_buf_outn = 1'b0;
				assign w_pma_rx_buf_outp = 1'b0;
				assign w_pma_rx_buf_pull_dn = 1'b0;
				assign w_pma_rx_buf_rdlpbkn = 1'b0;
				assign w_pma_rx_buf_rdlpbkp = 1'b0;
		end // if not generate
		
		// instantiating twentynm_hssi_pma_rx_deser
		if ((xcvr_native_mode == "mode_rx_only") || (xcvr_native_mode == "mode_duplex")) begin:gen_twentynm_hssi_pma_rx_deser
			twentynm_hssi_pma_rx_deser #(
				.bitslip_bypass(pma_rx_deser_bitslip_bypass),
				.clkdiv_source(pma_rx_deser_clkdiv_source),
				.clkdivrx_user_mode(pma_rx_deser_clkdivrx_user_mode),
				.datarate(pma_rx_deser_datarate),
				.deser_factor(pma_rx_deser_deser_factor),
				.deser_powerdown("deser_power_up"),       //PARAM_HIDE
				.force_clkdiv_for_testing(pma_rx_deser_force_clkdiv_for_testing),
				.optimal("false"),       //PARAM_HIDE
				.pcie_gen(pma_rx_deser_pcie_gen),
				.pcie_gen_bitwidth(pma_rx_deser_pcie_gen_bitwidth),
				.prot_mode(pma_rx_deser_prot_mode),
				.rst_n_adapt_odi(pma_rx_deser_rst_n_adapt_odi),
				.sdclk_enable(pma_rx_deser_sdclk_enable),
				.silicon_rev( "20nm1" ),       //PARAM_HIDE
				.sup_mode(pma_rx_deser_sup_mode),
				.tdr_mode("select_bbpd_data")       //PARAM_HIDE
			) inst_twentynm_hssi_pma_rx_deser (
				// OUTPUTS
				.adapt_clk(w_pma_rx_deser_adapt_clk),
				.avmmreaddata(w_pma_rx_deser_avmmreaddata),
				.blockselect(w_pma_rx_deser_blockselect),
				.clkdiv(w_pma_rx_deser_clkdiv),
				.clkdiv_user(w_pma_rx_deser_clkdiv_user),
				.clkdivrx_rx(w_pma_rx_deser_clkdivrx_rx),
				.data(w_pma_rx_deser_data),
				.dout(w_pma_rx_deser_dout),
				.error_deser(w_pma_rx_deser_error_deser),
				.odi_dout(w_pma_rx_deser_odi_dout),
				.pcie_sw_ret(w_pma_rx_deser_pcie_sw_ret),
				.tstmx_deser(w_pma_rx_deser_tstmx_deser),
				// INPUTS
				.adapt_en(w_pma_adapt_odi_vref[0]),
				.avmmaddress({in_avmmaddress[8], in_avmmaddress[7], in_avmmaddress[6], in_avmmaddress[5], in_avmmaddress[4], in_avmmaddress[3], in_avmmaddress[2], in_avmmaddress[1], in_avmmaddress[0]}),
				.avmmclk(in_avmmclk),
				.avmmread(in_avmmread),
				.avmmrstn(in_avmmrstn),
				.avmmwrite(in_avmmwrite),
				.avmmwritedata({in_avmmwritedata[7], in_avmmwritedata[6], in_avmmwritedata[5], in_avmmwritedata[4], in_avmmwritedata[3], in_avmmwritedata[2], in_avmmwritedata[1], in_avmmwritedata[0]}),
				.bitslip(in_rx_bitslip),
				.clk0(w_cdr_pll_clk0_des),
				.clk0_odi(w_pma_rx_odi_clk0_eye),
				.clk180(w_cdr_pll_clk180_des),
				.clk180_odi(w_pma_rx_odi_clk180_eye),
				.clklow(w_cdr_pll_clklow),
				.deven(w_cdr_pll_deven_des),
				.deven_odi(w_pma_rx_odi_de_eye),
				.devenb(w_cdr_pll_devenb_des),
				.devenb_odi(w_pma_rx_odi_deb_eye),
				.dodd(w_cdr_pll_dodd_des),
				.dodd_odi(w_pma_rx_odi_do_eye),
				.doddb(w_cdr_pll_doddb_des),
				.doddb_odi(w_pma_rx_odi_dob_eye),
				.error_even(w_cdr_pll_error_even_des),
				.error_evenb(w_cdr_pll_error_evenb_des),
				.error_odd(w_cdr_pll_error_odd_des),
				.error_oddb(w_cdr_pll_error_oddb_des),
				.fref(w_cdr_pll_fref),
				.odi_en(w_pma_rx_odi_odi_en),
				.pcie_sw({in_pcie_sw[1], in_pcie_sw[0]}),
				.pfdmode_lock(w_cdr_pll_pfdmode_lock),
				.rst_n(in_rx_pma_rstb),
				
				// UNUSED
				.clk270(),
				.clk90(),
				.odi_clkout(),
				.tdr_en()
			);
		end // if generate
		else begin
				assign w_pma_rx_deser_adapt_clk = 1'b0;
				assign w_pma_rx_deser_avmmreaddata[7:0] = 8'b0;
				assign w_pma_rx_deser_blockselect = 1'b0;
				assign w_pma_rx_deser_clkdiv = 1'b0;
				assign w_pma_rx_deser_clkdiv_user = 1'b0;
				assign w_pma_rx_deser_clkdivrx_rx = 1'b0;
				assign w_pma_rx_deser_data[63:0] = 64'b0;
				assign w_pma_rx_deser_dout[63:0] = 64'b0;
				assign w_pma_rx_deser_error_deser[63:0] = 64'b0;
				assign w_pma_rx_deser_odi_dout[63:0] = 64'b0;
				assign w_pma_rx_deser_pcie_sw_ret[1:0] = 2'b0;
				assign w_pma_rx_deser_tstmx_deser[7:0] = 8'b0;
		end // if not generate
		
		// instantiating twentynm_hssi_pma_rx_dfe
		if ((xcvr_native_mode == "mode_rx_only") || (xcvr_native_mode == "mode_duplex")) begin:gen_twentynm_hssi_pma_rx_dfe
			twentynm_hssi_pma_rx_dfe #(
				.datarate(pma_rx_dfe_datarate),
				.dft_en(pma_rx_dfe_dft_en),
				.initial_settings("true"),       //PARAM_HIDE
				.optimal("false"),       //PARAM_HIDE
				.pdb(pma_rx_dfe_pdb),
				.pdb_fixedtap(pma_rx_dfe_pdb_fixedtap),
				.pdb_floattap(pma_rx_dfe_pdb_floattap),
				.pdb_fxtap4t7(pma_rx_dfe_pdb_fxtap4t7),
				.prot_mode(pma_rx_dfe_prot_mode),
				.silicon_rev( "20nm1" ),       //PARAM_HIDE
				.sup_mode(pma_rx_dfe_sup_mode)
			) inst_twentynm_hssi_pma_rx_dfe (
				// OUTPUTS
				.avmmreaddata(w_pma_rx_dfe_avmmreaddata),
				.blockselect(w_pma_rx_dfe_blockselect),
				.clk0_bbpd(w_pma_rx_dfe_clk0_bbpd),
				.clk180_bbpd(w_pma_rx_dfe_clk180_bbpd),
				.clk270_bbpd(w_pma_rx_dfe_clk270_bbpd),
				.clk90_bbpd(w_pma_rx_dfe_clk90_bbpd),
				.deven(w_pma_rx_dfe_deven),
				.devenb(w_pma_rx_dfe_devenb),
				.dfe_oc_tstmx(w_pma_rx_dfe_dfe_oc_tstmx),
				.dodd(w_pma_rx_dfe_dodd),
				.doddb(w_pma_rx_dfe_doddb),
				.edge270(w_pma_rx_dfe_edge270),
				.edge270b(w_pma_rx_dfe_edge270b),
				.edge90(w_pma_rx_dfe_edge90),
				.edge90b(w_pma_rx_dfe_edge90b),
				.err_ev(w_pma_rx_dfe_err_ev),
				.err_evb(w_pma_rx_dfe_err_evb),
				.err_od(w_pma_rx_dfe_err_od),
				.err_odb(w_pma_rx_dfe_err_odb),
				.spec_vrefh(w_pma_rx_dfe_spec_vrefh),
				.spec_vrefl(w_pma_rx_dfe_spec_vrefl),
				// INPUTS
				.adapt_en(w_pma_adapt_dfe_adapt_en),
				.adp_clk(w_pma_adapt_dfe_adp_clk),
				.avmmaddress({in_avmmaddress[8], in_avmmaddress[7], in_avmmaddress[6], in_avmmaddress[5], in_avmmaddress[4], in_avmmaddress[3], in_avmmaddress[2], in_avmmaddress[1], in_avmmaddress[0]}),
				.avmmclk(in_avmmclk),
				.avmmread(in_avmmread),
				.avmmrstn(in_avmmrstn),
				.avmmwrite(in_avmmwrite),
				.avmmwritedata({in_avmmwritedata[7], in_avmmwritedata[6], in_avmmwritedata[5], in_avmmwritedata[4], in_avmmwritedata[3], in_avmmwritedata[2], in_avmmwritedata[1], in_avmmwritedata[0]}),
				.clk0(w_cdr_pll_clk0_pd),
				.clk180(w_cdr_pll_clk180_pd),
				.clk270(w_cdr_pll_clk270_pd),
				.clk90(w_cdr_pll_clk90_pd),
				.dfe_fltap1_coeff({w_pma_adapt_dfe_fltap1[5], w_pma_adapt_dfe_fltap1[4], w_pma_adapt_dfe_fltap1[3], w_pma_adapt_dfe_fltap1[2], w_pma_adapt_dfe_fltap1[1], w_pma_adapt_dfe_fltap1[0]}),
				.dfe_fltap1_sgn(w_pma_adapt_dfe_fltap1_sgn),
				.dfe_fltap2_coeff({w_pma_adapt_dfe_fltap2[5], w_pma_adapt_dfe_fltap2[4], w_pma_adapt_dfe_fltap2[3], w_pma_adapt_dfe_fltap2[2], w_pma_adapt_dfe_fltap2[1], w_pma_adapt_dfe_fltap2[0]}),
				.dfe_fltap2_sgn(w_pma_adapt_dfe_fltap2_sgn),
				.dfe_fltap3_coeff({w_pma_adapt_dfe_fltap3[5], w_pma_adapt_dfe_fltap3[4], w_pma_adapt_dfe_fltap3[3], w_pma_adapt_dfe_fltap3[2], w_pma_adapt_dfe_fltap3[1], w_pma_adapt_dfe_fltap3[0]}),
				.dfe_fltap3_sgn(w_pma_adapt_dfe_fltap3_sgn),
				.dfe_fltap4_coeff({w_pma_adapt_dfe_fltap4[5], w_pma_adapt_dfe_fltap4[4], w_pma_adapt_dfe_fltap4[3], w_pma_adapt_dfe_fltap4[2], w_pma_adapt_dfe_fltap4[1], w_pma_adapt_dfe_fltap4[0]}),
				.dfe_fltap4_sgn(w_pma_adapt_dfe_fltap4_sgn),
				.dfe_fltap_bypdeser(w_pma_adapt_dfe_fltap_bypdeser),
				.dfe_fltap_position({w_pma_adapt_dfe_fltap_position[5], w_pma_adapt_dfe_fltap_position[4], w_pma_adapt_dfe_fltap_position[3], w_pma_adapt_dfe_fltap_position[2], w_pma_adapt_dfe_fltap_position[1], w_pma_adapt_dfe_fltap_position[0]}),
				.dfe_fxtap1_coeff({w_pma_adapt_dfe_fxtap1[6], w_pma_adapt_dfe_fxtap1[5], w_pma_adapt_dfe_fxtap1[4], w_pma_adapt_dfe_fxtap1[3], w_pma_adapt_dfe_fxtap1[2], w_pma_adapt_dfe_fxtap1[1], w_pma_adapt_dfe_fxtap1[0]}),
				.dfe_fxtap2_coeff({w_pma_adapt_dfe_fxtap2[6], w_pma_adapt_dfe_fxtap2[5], w_pma_adapt_dfe_fxtap2[4], w_pma_adapt_dfe_fxtap2[3], w_pma_adapt_dfe_fxtap2[2], w_pma_adapt_dfe_fxtap2[1], w_pma_adapt_dfe_fxtap2[0]}),
				.dfe_fxtap2_sgn(w_pma_adapt_dfe_fxtap2_sgn),
				.dfe_fxtap3_coeff({w_pma_adapt_dfe_fxtap3[6], w_pma_adapt_dfe_fxtap3[5], w_pma_adapt_dfe_fxtap3[4], w_pma_adapt_dfe_fxtap3[3], w_pma_adapt_dfe_fxtap3[2], w_pma_adapt_dfe_fxtap3[1], w_pma_adapt_dfe_fxtap3[0]}),
				.dfe_fxtap3_sgn(w_pma_adapt_dfe_fxtap3_sgn),
				.dfe_fxtap4_coeff({w_pma_adapt_dfe_fxtap4[5], w_pma_adapt_dfe_fxtap4[4], w_pma_adapt_dfe_fxtap4[3], w_pma_adapt_dfe_fxtap4[2], w_pma_adapt_dfe_fxtap4[1], w_pma_adapt_dfe_fxtap4[0]}),
				.dfe_fxtap4_sgn(w_pma_adapt_dfe_fxtap4_sgn),
				.dfe_fxtap5_coeff({w_pma_adapt_dfe_fxtap5[5], w_pma_adapt_dfe_fxtap5[4], w_pma_adapt_dfe_fxtap5[3], w_pma_adapt_dfe_fxtap5[2], w_pma_adapt_dfe_fxtap5[1], w_pma_adapt_dfe_fxtap5[0]}),
				.dfe_fxtap5_sgn(w_pma_adapt_dfe_fxtap5_sgn),
				.dfe_fxtap6_coeff({w_pma_adapt_dfe_fxtap6[4], w_pma_adapt_dfe_fxtap6[3], w_pma_adapt_dfe_fxtap6[2], w_pma_adapt_dfe_fxtap6[1], w_pma_adapt_dfe_fxtap6[0]}),
				.dfe_fxtap6_sgn(w_pma_adapt_dfe_fxtap6_sgn),
				.dfe_fxtap7_coeff({w_pma_adapt_dfe_fxtap7[4], w_pma_adapt_dfe_fxtap7[3], w_pma_adapt_dfe_fxtap7[2], w_pma_adapt_dfe_fxtap7[1], w_pma_adapt_dfe_fxtap7[0]}),
				.dfe_fxtap7_sgn(w_pma_adapt_dfe_fxtap7_sgn),
				.dfe_rstn(in_rx_pma_rstb),
				.dfe_spec_disable(w_pma_adapt_dfe_spec_disable),
				.dfe_spec_sgn_sel(w_pma_adapt_dfe_spec_sign_sel),
				.dfe_vref_sgn_sel(w_pma_adapt_dfe_vref_sign_sel),
				.rxn(w_pma_rx_buf_outn),
				.rxp(w_pma_rx_buf_outp),
				.vga_vcm(1'b0),
				.vref_level_coeff({w_pma_adapt_vref_sel[4], w_pma_adapt_vref_sel[3], w_pma_adapt_vref_sel[2], w_pma_adapt_vref_sel[1], w_pma_adapt_vref_sel[0]})
			);
		end // if generate
		else begin
				assign w_pma_rx_dfe_avmmreaddata[7:0] = 8'b0;
				assign w_pma_rx_dfe_blockselect = 1'b0;
				assign w_pma_rx_dfe_clk0_bbpd = 1'b0;
				assign w_pma_rx_dfe_clk180_bbpd = 1'b0;
				assign w_pma_rx_dfe_clk270_bbpd = 1'b0;
				assign w_pma_rx_dfe_clk90_bbpd = 1'b0;
				assign w_pma_rx_dfe_deven = 1'b0;
				assign w_pma_rx_dfe_devenb = 1'b0;
				assign w_pma_rx_dfe_dfe_oc_tstmx[7:0] = 8'b0;
				assign w_pma_rx_dfe_dodd = 1'b0;
				assign w_pma_rx_dfe_doddb = 1'b0;
				assign w_pma_rx_dfe_edge270 = 1'b0;
				assign w_pma_rx_dfe_edge270b = 1'b0;
				assign w_pma_rx_dfe_edge90 = 1'b0;
				assign w_pma_rx_dfe_edge90b = 1'b0;
				assign w_pma_rx_dfe_err_ev = 1'b0;
				assign w_pma_rx_dfe_err_evb = 1'b0;
				assign w_pma_rx_dfe_err_od = 1'b0;
				assign w_pma_rx_dfe_err_odb = 1'b0;
				assign w_pma_rx_dfe_spec_vrefh = 1'b0;
				assign w_pma_rx_dfe_spec_vrefl = 1'b0;
		end // if not generate
		
		// instantiating twentynm_hssi_pma_rx_odi
		if ((xcvr_native_mode == "mode_rx_only") || (xcvr_native_mode == "mode_duplex")) begin:gen_twentynm_hssi_pma_rx_odi
			twentynm_hssi_pma_rx_odi #(
				.datarate(pma_rx_odi_datarate),
				.initial_settings("true"),       //PARAM_HIDE
				.optimal("false"),       //PARAM_HIDE
				.prot_mode(pma_rx_odi_prot_mode),
				.silicon_rev( "20nm1" ),       //PARAM_HIDE
				.step_ctrl_sel(pma_rx_odi_step_ctrl_sel),
				.sup_mode(pma_rx_odi_sup_mode)
			) inst_twentynm_hssi_pma_rx_odi (
				// OUTPUTS
				.avmmreaddata(w_pma_rx_odi_avmmreaddata),
				.blockselect(w_pma_rx_odi_blockselect),
				.clk0_eye(w_pma_rx_odi_clk0_eye),
				.clk0_eye_lb(w_pma_rx_odi_clk0_eye_lb),
				.clk180_eye(w_pma_rx_odi_clk180_eye),
				.clk180_eye_lb(w_pma_rx_odi_clk180_eye_lb),
				.de_eye(w_pma_rx_odi_de_eye),
				.deb_eye(w_pma_rx_odi_deb_eye),
				.do_eye(w_pma_rx_odi_do_eye),
				.dob_eye(w_pma_rx_odi_dob_eye),
				.odi_en(w_pma_rx_odi_odi_en),
				.odi_oc_tstmx(w_pma_rx_odi_odi_oc_tstmx),
				// INPUTS
				.avmmaddress({in_avmmaddress[8], in_avmmaddress[7], in_avmmaddress[6], in_avmmaddress[5], in_avmmaddress[4], in_avmmaddress[3], in_avmmaddress[2], in_avmmaddress[1], in_avmmaddress[0]}),
				.avmmclk(in_avmmclk),
				.avmmread(in_avmmread),
				.avmmrstn(in_avmmrstn),
				.avmmwrite(in_avmmwrite),
				.avmmwritedata({in_avmmwritedata[7], in_avmmwritedata[6], in_avmmwritedata[5], in_avmmwritedata[4], in_avmmwritedata[3], in_avmmwritedata[2], in_avmmwritedata[1], in_avmmwritedata[0]}),
				.clk0(w_cdr_pll_clk0_odi),
				.clk180(w_cdr_pll_clk180_odi),
				.clk270(w_cdr_pll_clk270_odi),
				.clk90(w_cdr_pll_clk90_odi),
				.odi_dft_clr(in_eye_monitor[3]),
				.odi_latch_clk(in_eye_monitor[1]),
				.odi_shift_clk(in_eye_monitor[0]),
				.odi_shift_in(in_eye_monitor[2]),
				.rx_n(w_pma_rx_buf_inn),
				.rx_p(w_pma_rx_buf_inp),
				.rxn_sum(w_pma_rx_buf_outn),
				.rxp_sum(w_pma_rx_buf_outp),
				.spec_vrefh(w_pma_rx_dfe_spec_vrefh),
				.spec_vrefl(w_pma_rx_dfe_spec_vrefl),
				.vcm_vref(1'b0),
				.vertical_fb({w_pma_adapt_odi_vref[4], w_pma_adapt_odi_vref[3], w_pma_adapt_odi_vref[2], w_pma_adapt_odi_vref[1], 1'b0}),
				
				// UNUSED
				.atb0(),
				.atb1(),
				.it50u(),
				.it50u2(),
				.it50u4(),
				.odi_atb_sel(),
				.tdr_en(),
				.vref_sel_out()
			);
		end // if generate
		else begin
				assign w_pma_rx_odi_avmmreaddata[7:0] = 8'b0;
				assign w_pma_rx_odi_blockselect = 1'b0;
				assign w_pma_rx_odi_clk0_eye = 1'b0;
				assign w_pma_rx_odi_clk0_eye_lb = 1'b0;
				assign w_pma_rx_odi_clk180_eye = 1'b0;
				assign w_pma_rx_odi_clk180_eye_lb = 1'b0;
				assign w_pma_rx_odi_de_eye = 1'b0;
				assign w_pma_rx_odi_deb_eye = 1'b0;
				assign w_pma_rx_odi_do_eye = 1'b0;
				assign w_pma_rx_odi_dob_eye = 1'b0;
				assign w_pma_rx_odi_odi_en = 1'b0;
				assign w_pma_rx_odi_odi_oc_tstmx[1:0] = 2'b0;
		end // if not generate
		
		// instantiating twentynm_hssi_pma_rx_sd
		if ((xcvr_native_mode == "mode_rx_only") || (xcvr_native_mode == "mode_duplex")) begin:gen_twentynm_hssi_pma_rx_sd
			twentynm_hssi_pma_rx_sd #(
				.optimal("false"),       //PARAM_HIDE
				.prot_mode(pma_rx_sd_prot_mode),
				.sd_output_off(pma_rx_sd_sd_output_off),
				.sd_output_on(pma_rx_sd_sd_output_on),
				.sd_pdb(pma_rx_sd_sd_pdb),
				.silicon_rev( "20nm1" ),       //PARAM_HIDE
				.sup_mode(pma_rx_sd_sup_mode)
			) inst_twentynm_hssi_pma_rx_sd (
				// OUTPUTS
				.avmmreaddata(w_pma_rx_sd_avmmreaddata),
				.blockselect(w_pma_rx_sd_blockselect),
				.sd(w_pma_rx_sd_sd),
				// INPUTS
				.avmmaddress({in_avmmaddress[8], in_avmmaddress[7], in_avmmaddress[6], in_avmmaddress[5], in_avmmaddress[4], in_avmmaddress[3], in_avmmaddress[2], in_avmmaddress[1], in_avmmaddress[0]}),
				.avmmclk(in_avmmclk),
				.avmmread(in_avmmread),
				.avmmrstn(in_avmmrstn),
				.avmmwrite(in_avmmwrite),
				.avmmwritedata({in_avmmwritedata[7], in_avmmwritedata[6], in_avmmwritedata[5], in_avmmwritedata[4], in_avmmwritedata[3], in_avmmwritedata[2], in_avmmwritedata[1], in_avmmwritedata[0]}),
				.clk(w_pma_rx_deser_clkdivrx_rx),
				.qpi(w_pma_rx_buf_pull_dn),
				.rstn_sd(in_rx_pma_rstb),
				.s_lpbk_b(in_rs_lpbk_b),
				.vin(w_pma_rx_buf_inn),
				.vip(w_pma_rx_buf_inp)
			);
		end // if generate
		else begin
				assign w_pma_rx_sd_avmmreaddata[7:0] = 8'b0;
				assign w_pma_rx_sd_blockselect = 1'b0;
				assign w_pma_rx_sd_sd = 1'b0;
		end // if not generate
		
		// instantiating twentynm_hssi_pma_tx_buf
		if ((xcvr_native_mode == "mode_tx_only") || (xcvr_native_mode == "mode_duplex")) begin:gen_twentynm_hssi_pma_tx_buf
			twentynm_hssi_pma_tx_buf #(
				.datarate(pma_tx_buf_datarate),
				.dft_sel("dft_disabled"),       //PARAM_HIDE
				.initial_settings("true"),       //PARAM_HIDE
				.jtag_drv_sel("drv1"),       //PARAM_HIDE
				.jtag_lp("lp_off"),       //PARAM_HIDE
				.lst("atb_disabled"),       //PARAM_HIDE
				.mcgb_location_for_pcie(pma_tx_buf_mcgb_location_for_pcie),
				.optimal("false"),       //PARAM_HIDE
				.prot_mode(pma_tx_buf_prot_mode),
				.rx_det(pma_tx_buf_rx_det),
				.rx_det_output_sel(pma_tx_buf_rx_det_output_sel),
				.rx_det_pdb(pma_tx_buf_rx_det_pdb),
				.ser_powerdown("normal_ser_on"),       //PARAM_HIDE
				.silicon_rev( "20nm1" ),       //PARAM_HIDE
				.sup_mode(pma_tx_buf_sup_mode),
				.tx_powerdown("normal_tx_on"),       //PARAM_HIDE
				.user_fir_coeff_ctrl_sel(pma_tx_buf_user_fir_coeff_ctrl_sel),
				.xtx_path_clock_divider_ratio(pma_tx_buf_xtx_path_clock_divider_ratio),
				.xtx_path_datarate(pma_tx_buf_xtx_path_datarate),
				.xtx_path_datawidth(pma_tx_buf_xtx_path_datawidth),
				.xtx_path_initial_settings("true"),       //PARAM_HIDE
				.xtx_path_optimal("false"),       //PARAM_HIDE
				.xtx_path_pma_tx_divclk_hz(pma_tx_buf_xtx_path_pma_tx_divclk_hz),
				.xtx_path_prot_mode(pma_tx_buf_xtx_path_prot_mode),
				.xtx_path_sup_mode(pma_tx_buf_xtx_path_sup_mode),
				.xtx_path_tx_pll_clk_hz(pma_tx_buf_xtx_path_tx_pll_clk_hz)
			) inst_twentynm_hssi_pma_tx_buf (
				// OUTPUTS
				.atbsel(w_pma_tx_buf_atbsel),
				.avmmreaddata(w_pma_tx_buf_avmmreaddata),
				.blockselect(w_pma_tx_buf_blockselect),
				.ckn(w_pma_tx_buf_ckn),
				.ckp(w_pma_tx_buf_ckp),
				.dcd_out1(w_pma_tx_buf_dcd_out1),
				.dcd_out2(w_pma_tx_buf_dcd_out2),
				.dcd_out_ready(w_pma_tx_buf_dcd_out_ready),
				.detect_on(w_pma_tx_buf_detect_on),
				.lbvon(w_pma_tx_buf_lbvon),
				.lbvop(w_pma_tx_buf_lbvop),
				.rx_detect_valid(w_pma_tx_buf_rx_detect_valid),
				.rx_found(w_pma_tx_buf_rx_found),
				.rx_found_pcie_spl_test(w_pma_tx_buf_rx_found_pcie_spl_test),
				.sel_vreg(w_pma_tx_buf_sel_vreg),
				.spl_clk_test(w_pma_tx_buf_spl_clk_test),
				.tx_dftout(w_pma_tx_buf_tx_dftout),
				.vlptxn(w_pma_tx_buf_vlptxn),
				.vlptxp(w_pma_tx_buf_vlptxp),
				.von(w_pma_tx_buf_von),
				.vop(w_pma_tx_buf_vop),
				// INPUTS
				.avmmaddress({in_avmmaddress[8], in_avmmaddress[7], in_avmmaddress[6], in_avmmaddress[5], in_avmmaddress[4], in_avmmaddress[3], in_avmmaddress[2], in_avmmaddress[1], in_avmmaddress[0]}),
				.avmmclk(in_avmmclk),
				.avmmread(in_avmmread),
				.avmmrstn(in_avmmrstn),
				.avmmwrite(in_avmmwrite),
				.avmmwritedata({in_avmmwritedata[7], in_avmmwritedata[6], in_avmmwritedata[5], in_avmmwritedata[4], in_avmmwritedata[3], in_avmmwritedata[2], in_avmmwritedata[1], in_avmmwritedata[0]}),
				.bsmode(1'b0),
				.bsoeb(1'b0),
				.bstxn_in(1'b0),
				.bstxp_in(1'b0),
				.clk0_tx(w_pma_cgb_hifreqclkp),
				.clk180_tx(w_pma_cgb_hifreqclkn),
				.clk_dcd(w_pma_cgb_cpulse_out_bus[0]),
				.clksn(w_pma_tx_ser_ckdrvp),
				.clksp(w_pma_tx_ser_ckdrvn),
				.i_coeff({in_i_coeff[17], in_i_coeff[16], in_i_coeff[15], in_i_coeff[14], in_i_coeff[13], in_i_coeff[12], in_i_coeff[11], in_i_coeff[10], in_i_coeff[9], in_i_coeff[8], in_i_coeff[7], in_i_coeff[6], in_i_coeff[5], in_i_coeff[4], in_i_coeff[3], in_i_coeff[2], in_i_coeff[1], in_i_coeff[0]}),
				.oe(w_pma_tx_ser_oe),
				.oeb(w_pma_tx_ser_oeb),
				.oo(w_pma_tx_ser_oo),
				.oob(w_pma_tx_ser_oob),
				.pcie_sw_master(w_pma_cgb_pcie_sw_master[1]),
				.rx_det_clk(w_pma_cdr_refclk_rx_det_clk),
				.rx_n_bidir_in(in_rx_n),
				.rx_p_bidir_in(in_rx_p),
				.s_lpbk_b(in_rs_lpbk_b),
				.tx50({in_tx50_buf_in[8], in_tx50_buf_in[7], in_tx50_buf_in[6], in_tx50_buf_in[5], in_tx50_buf_in[4], in_tx50_buf_in[3], in_tx50_buf_in[2], in_tx50_buf_in[1], in_tx50_buf_in[0]}),
				.tx_det_rx(in_tx_det_rx),
				.tx_elec_idle(in_tx_elec_idle),
				.tx_qpi_pulldn(in_tx_qpi_pulldn),
				.tx_qpi_pullup(in_tx_qpi_pullup),
				.tx_rlpbk(w_cdr_pll_tx_rlpbk),
				.vrlpbkn(w_cdr_pll_rlpbkn),
				.vrlpbkn_1t(w_cdr_pll_rlpbkdn),
				.vrlpbkp(w_cdr_pll_rlpbkp),
				.vrlpbkp_1t(w_cdr_pll_rlpbkdp),
				
				// UNUSED
				.cr_rdynamic_sw()
			);
		end // if generate
		else begin
				assign w_pma_tx_buf_atbsel[2:0] = 3'b0;
				assign w_pma_tx_buf_avmmreaddata[7:0] = 8'b0;
				assign w_pma_tx_buf_blockselect = 1'b0;
				assign w_pma_tx_buf_ckn = 1'b0;
				assign w_pma_tx_buf_ckp = 1'b0;
				assign w_pma_tx_buf_dcd_out1 = 1'b0;
				assign w_pma_tx_buf_dcd_out2 = 1'b0;
				assign w_pma_tx_buf_dcd_out_ready = 1'b0;
				assign w_pma_tx_buf_detect_on[1:0] = 2'b0;
				assign w_pma_tx_buf_lbvon = 1'b0;
				assign w_pma_tx_buf_lbvop = 1'b0;
				assign w_pma_tx_buf_rx_detect_valid = 1'b0;
				assign w_pma_tx_buf_rx_found = 1'b0;
				assign w_pma_tx_buf_rx_found_pcie_spl_test = 1'b0;
				assign w_pma_tx_buf_sel_vreg = 1'b0;
				assign w_pma_tx_buf_spl_clk_test = 1'b0;
				assign w_pma_tx_buf_tx_dftout[7:0] = 8'b0;
				assign w_pma_tx_buf_vlptxn = 1'b0;
				assign w_pma_tx_buf_vlptxp = 1'b0;
				assign w_pma_tx_buf_von = 1'b0;
				assign w_pma_tx_buf_vop = 1'b0;
		end // if not generate
		
		// instantiating twentynm_hssi_pma_tx_cgb
		if ((xcvr_native_mode == "mode_tx_only") || (xcvr_native_mode == "mode_duplex")) begin:gen_twentynm_hssi_pma_tx_cgb
			twentynm_hssi_pma_tx_cgb #(
				.bitslip_enable(pma_cgb_bitslip_enable),
				.bonding_reset_enable(pma_cgb_bonding_reset_enable),
				.cgb_power_down("normal_cgb"),       //PARAM_HIDE
				.datarate(pma_cgb_datarate),
				.initial_settings("true"),       //PARAM_HIDE
				.input_select_gen3(pma_cgb_input_select_gen3),
				.input_select_x1(pma_cgb_input_select_x1),
				.input_select_xn(pma_cgb_input_select_xn),
				.pcie_gen3_bitwidth(pma_cgb_pcie_gen3_bitwidth),
				.prot_mode(pma_cgb_prot_mode),
				.scratch0_x1_clock_src(pma_cgb_scratch0_x1_clock_src),
				.scratch1_x1_clock_src(pma_cgb_scratch1_x1_clock_src),
				.scratch2_x1_clock_src(pma_cgb_scratch2_x1_clock_src),
				.scratch3_x1_clock_src(pma_cgb_scratch3_x1_clock_src),
				.select_done_master_or_slave(pma_cgb_select_done_master_or_slave),
				.ser_mode(pma_cgb_ser_mode),
				.ser_powerdown("normal_poweron_ser"),       //PARAM_HIDE
				.silicon_rev( "20nm1" ),       //PARAM_HIDE
				.sup_mode(pma_cgb_sup_mode),
				.tx_ucontrol_en(pma_cgb_tx_ucontrol_en),
				.x1_div_m_sel(pma_cgb_x1_div_m_sel)
			) inst_twentynm_hssi_pma_tx_cgb (
				// OUTPUTS
				.avmmreaddata(w_pma_cgb_avmmreaddata),
				.bitslipstate(w_pma_cgb_bitslipstate),
				.blockselect(w_pma_cgb_blockselect),
				.cpulse_out_bus(w_pma_cgb_cpulse_out_bus),
				.div2(w_pma_cgb_div2),
				.div4(w_pma_cgb_div4),
				.div5(w_pma_cgb_div5),
				.hifreqclkn(w_pma_cgb_hifreqclkn),
				.hifreqclkp(w_pma_cgb_hifreqclkp),
				.pcie_sw_done(w_pma_cgb_pcie_sw_done),
				.pcie_sw_master(w_pma_cgb_pcie_sw_master),
				.rstb(w_pma_cgb_rstb),
				// INPUTS
				.avmmaddress({in_avmmaddress[8], in_avmmaddress[7], in_avmmaddress[6], in_avmmaddress[5], in_avmmaddress[4], in_avmmaddress[3], in_avmmaddress[2], in_avmmaddress[1], in_avmmaddress[0]}),
				.avmmclk(in_avmmclk),
				.avmmread(in_avmmread),
				.avmmrstn(in_avmmrstn),
				.avmmwrite(in_avmmwrite),
				.avmmwritedata({in_avmmwritedata[7], in_avmmwritedata[6], in_avmmwritedata[5], in_avmmwritedata[4], in_avmmwritedata[3], in_avmmwritedata[2], in_avmmwritedata[1], in_avmmwritedata[0]}),
				.ckdccn(w_pma_tx_buf_ckn),
				.ckdccp(w_pma_tx_buf_ckp),
				.clk_cdr_b(in_clk_cdr_b),
				.clk_cdr_direct(w_cdr_pll_clk0_pfd),
				.clk_cdr_t(in_clk_cdr_t),
				.clk_fpll_b(in_clk_fpll_b),
				.clk_fpll_t(in_clk_fpll_t),
				.clk_lc_b(in_clk_lc_b),
				.clk_lc_hs(in_clk_lc_hs),
				.clk_lc_t(in_clk_lc_t),
				.clkb_cdr_b(in_clkb_cdr_b),
				.clkb_cdr_direct(w_cdr_pll_clk180_pfd),
				.clkb_cdr_t(in_clkb_cdr_t),
				.clkb_fpll_b(in_clkb_fpll_b),
				.clkb_fpll_t(in_clkb_fpll_t),
				.clkb_lc_b(in_clkb_lc_b),
				.clkb_lc_hs(in_clkb_lc_hs),
				.clkb_lc_t(in_clkb_lc_t),
				.cpulse_x6_dn_bus({in_cpulse_x6_dn_bus[5], in_cpulse_x6_dn_bus[4], in_cpulse_x6_dn_bus[3], in_cpulse_x6_dn_bus[2], in_cpulse_x6_dn_bus[1], in_cpulse_x6_dn_bus[0]}),
				.cpulse_x6_up_bus({in_cpulse_x6_up_bus[5], in_cpulse_x6_up_bus[4], in_cpulse_x6_up_bus[3], in_cpulse_x6_up_bus[2], in_cpulse_x6_up_bus[1], in_cpulse_x6_up_bus[0]}),
				.cpulse_xn_dn_bus({in_cpulse_xn_dn_bus[5], in_cpulse_xn_dn_bus[4], in_cpulse_xn_dn_bus[3], in_cpulse_xn_dn_bus[2], in_cpulse_xn_dn_bus[1], in_cpulse_xn_dn_bus[0]}),
				.cpulse_xn_up_bus({in_cpulse_xn_up_bus[5], in_cpulse_xn_up_bus[4], in_cpulse_xn_up_bus[3], in_cpulse_xn_up_bus[2], in_cpulse_xn_up_bus[1], in_cpulse_xn_up_bus[0]}),
				.pcie_sw({in_pcie_sw[1], in_pcie_sw[0]}),
				.pcie_sw_done_master({in_pcie_sw_done_master_in[1], in_pcie_sw_done_master_in[0]}),
				.tx_bitslip(in_tx_bitslip),
				.tx_bonding_rstb(in_tx_bonding_rstb),
				.tx_pma_rstb(in_tx_pma_rstb)
			);
		end // if generate
		else begin
				assign w_pma_cgb_avmmreaddata[7:0] = 8'b0;
				assign w_pma_cgb_bitslipstate = 1'b0;
				assign w_pma_cgb_blockselect = 1'b0;
				assign w_pma_cgb_cpulse_out_bus[5:0] = 6'b0;
				assign w_pma_cgb_div2 = 1'b0;
				assign w_pma_cgb_div4 = 1'b0;
				assign w_pma_cgb_div5 = 1'b0;
				assign w_pma_cgb_hifreqclkn = 1'b0;
				assign w_pma_cgb_hifreqclkp = 1'b0;
				assign w_pma_cgb_pcie_sw_done[1:0] = 2'b0;
				assign w_pma_cgb_pcie_sw_master[1:0] = 2'b0;
				assign w_pma_cgb_rstb = 1'b0;
		end // if not generate
		
		// instantiating twentynm_hssi_pma_tx_ser
		if ((xcvr_native_mode == "mode_tx_only") || (xcvr_native_mode == "mode_duplex")) begin:gen_twentynm_hssi_pma_tx_ser
			twentynm_hssi_pma_tx_ser #(
				.control_clk_divtx("no_dft_control_clkdivtx"),       //PARAM_HIDE
				.initial_settings("true"),       //PARAM_HIDE
				.prot_mode(pma_tx_ser_prot_mode),
				.ser_clk_divtx_user_sel(pma_tx_ser_ser_clk_divtx_user_sel),
				.ser_powerdown("normal_poweron_ser"),       //PARAM_HIDE
				.silicon_rev( "20nm1" ),       //PARAM_HIDE
				.sup_mode(pma_tx_ser_sup_mode)
			) inst_twentynm_hssi_pma_tx_ser (
				// OUTPUTS
				.avmmreaddata(w_pma_tx_ser_avmmreaddata),
				.blockselect(w_pma_tx_ser_blockselect),
				.ckdrvn(w_pma_tx_ser_ckdrvn),
				.ckdrvp(w_pma_tx_ser_ckdrvp),
				.clk_divtx(w_pma_tx_ser_clk_divtx),
				.clk_divtx_user(w_pma_tx_ser_clk_divtx_user),
				.oe(w_pma_tx_ser_oe),
				.oeb(w_pma_tx_ser_oeb),
				.oo(w_pma_tx_ser_oo),
				.oob(w_pma_tx_ser_oob),
				// INPUTS
				.avmmaddress({in_avmmaddress[8], in_avmmaddress[7], in_avmmaddress[6], in_avmmaddress[5], in_avmmaddress[4], in_avmmaddress[3], in_avmmaddress[2], in_avmmaddress[1], in_avmmaddress[0]}),
				.avmmclk(in_avmmclk),
				.avmmread(in_avmmread),
				.avmmrstn(in_avmmrstn),
				.avmmwrite(in_avmmwrite),
				.avmmwritedata({in_avmmwritedata[7], in_avmmwritedata[6], in_avmmwritedata[5], in_avmmwritedata[4], in_avmmwritedata[3], in_avmmwritedata[2], in_avmmwritedata[1], in_avmmwritedata[0]}),
				.bitslipstate(w_pma_cgb_bitslipstate),
				.cpulse(w_pma_cgb_cpulse_out_bus[1]),
				.data({in_tx_data[63], in_tx_data[62], in_tx_data[61], in_tx_data[60], in_tx_data[59], in_tx_data[58], in_tx_data[57], in_tx_data[56], in_tx_data[55], in_tx_data[54], in_tx_data[53], in_tx_data[52], in_tx_data[51], in_tx_data[50], in_tx_data[49], in_tx_data[48], in_tx_data[47], in_tx_data[46], in_tx_data[45], in_tx_data[44], in_tx_data[43], in_tx_data[42], in_tx_data[41], in_tx_data[40], in_tx_data[39], in_tx_data[38], in_tx_data[37], in_tx_data[36], in_tx_data[35], in_tx_data[34], in_tx_data[33], in_tx_data[32], in_tx_data[31], in_tx_data[30], in_tx_data[29], in_tx_data[28], in_tx_data[27], in_tx_data[26], in_tx_data[25], in_tx_data[24], in_tx_data[23], in_tx_data[22], in_tx_data[21], in_tx_data[20], in_tx_data[19], in_tx_data[18], in_tx_data[17], in_tx_data[16], in_tx_data[15], in_tx_data[14], in_tx_data[13], in_tx_data[12], in_tx_data[11], in_tx_data[10], in_tx_data[9], in_tx_data[8], in_tx_data[7], in_tx_data[6], in_tx_data[5], in_tx_data[4], in_tx_data[3], in_tx_data[2], in_tx_data[1], in_tx_data[0]}),
				.hfclkn(w_pma_cgb_cpulse_out_bus[4]),
				.hfclkp(w_pma_cgb_cpulse_out_bus[5]),
				.lfclk(w_pma_cgb_cpulse_out_bus[3]),
				.lfclk2(w_pma_cgb_cpulse_out_bus[2]),
				.paraclk(w_pma_cgb_cpulse_out_bus[0]),
				.rser_div2(w_pma_cgb_div2),
				.rser_div4(w_pma_cgb_div4),
				.rser_div5(w_pma_cgb_div5),
				.rst_n(w_pma_cgb_rstb)
			);
		end // if generate
		else begin
				assign w_pma_tx_ser_avmmreaddata[7:0] = 8'b0;
				assign w_pma_tx_ser_blockselect = 1'b0;
				assign w_pma_tx_ser_ckdrvn = 1'b0;
				assign w_pma_tx_ser_ckdrvp = 1'b0;
				assign w_pma_tx_ser_clk_divtx = 1'b0;
				assign w_pma_tx_ser_clk_divtx_user = 1'b0;
				assign w_pma_tx_ser_oe = 1'b0;
				assign w_pma_tx_ser_oeb = 1'b0;
				assign w_pma_tx_ser_oo = 1'b0;
				assign w_pma_tx_ser_oob = 1'b0;
		end // if not generate
		
		//output assignments
		assign out_avmmreaddata_cdr_pll = {w_cdr_pll_avmmreaddata[7], w_cdr_pll_avmmreaddata[6], w_cdr_pll_avmmreaddata[5], w_cdr_pll_avmmreaddata[4], w_cdr_pll_avmmreaddata[3], w_cdr_pll_avmmreaddata[2], w_cdr_pll_avmmreaddata[1], w_cdr_pll_avmmreaddata[0]};
		assign out_avmmreaddata_pma_adapt = {w_pma_adapt_avmmreaddata[7], w_pma_adapt_avmmreaddata[6], w_pma_adapt_avmmreaddata[5], w_pma_adapt_avmmreaddata[4], w_pma_adapt_avmmreaddata[3], w_pma_adapt_avmmreaddata[2], w_pma_adapt_avmmreaddata[1], w_pma_adapt_avmmreaddata[0]};
		assign out_avmmreaddata_pma_cdr_refclk = {w_pma_cdr_refclk_avmmreaddata[7], w_pma_cdr_refclk_avmmreaddata[6], w_pma_cdr_refclk_avmmreaddata[5], w_pma_cdr_refclk_avmmreaddata[4], w_pma_cdr_refclk_avmmreaddata[3], w_pma_cdr_refclk_avmmreaddata[2], w_pma_cdr_refclk_avmmreaddata[1], w_pma_cdr_refclk_avmmreaddata[0]};
		assign out_avmmreaddata_pma_cgb = {w_pma_cgb_avmmreaddata[7], w_pma_cgb_avmmreaddata[6], w_pma_cgb_avmmreaddata[5], w_pma_cgb_avmmreaddata[4], w_pma_cgb_avmmreaddata[3], w_pma_cgb_avmmreaddata[2], w_pma_cgb_avmmreaddata[1], w_pma_cgb_avmmreaddata[0]};
		assign out_avmmreaddata_pma_rx_buf = {w_pma_rx_buf_avmmreaddata[7], w_pma_rx_buf_avmmreaddata[6], w_pma_rx_buf_avmmreaddata[5], w_pma_rx_buf_avmmreaddata[4], w_pma_rx_buf_avmmreaddata[3], w_pma_rx_buf_avmmreaddata[2], w_pma_rx_buf_avmmreaddata[1], w_pma_rx_buf_avmmreaddata[0]};
		assign out_avmmreaddata_pma_rx_deser = {w_pma_rx_deser_avmmreaddata[7], w_pma_rx_deser_avmmreaddata[6], w_pma_rx_deser_avmmreaddata[5], w_pma_rx_deser_avmmreaddata[4], w_pma_rx_deser_avmmreaddata[3], w_pma_rx_deser_avmmreaddata[2], w_pma_rx_deser_avmmreaddata[1], w_pma_rx_deser_avmmreaddata[0]};
		assign out_avmmreaddata_pma_rx_dfe = {w_pma_rx_dfe_avmmreaddata[7], w_pma_rx_dfe_avmmreaddata[6], w_pma_rx_dfe_avmmreaddata[5], w_pma_rx_dfe_avmmreaddata[4], w_pma_rx_dfe_avmmreaddata[3], w_pma_rx_dfe_avmmreaddata[2], w_pma_rx_dfe_avmmreaddata[1], w_pma_rx_dfe_avmmreaddata[0]};
		assign out_avmmreaddata_pma_rx_odi = {w_pma_rx_odi_avmmreaddata[7], w_pma_rx_odi_avmmreaddata[6], w_pma_rx_odi_avmmreaddata[5], w_pma_rx_odi_avmmreaddata[4], w_pma_rx_odi_avmmreaddata[3], w_pma_rx_odi_avmmreaddata[2], w_pma_rx_odi_avmmreaddata[1], w_pma_rx_odi_avmmreaddata[0]};
		assign out_avmmreaddata_pma_rx_sd = {w_pma_rx_sd_avmmreaddata[7], w_pma_rx_sd_avmmreaddata[6], w_pma_rx_sd_avmmreaddata[5], w_pma_rx_sd_avmmreaddata[4], w_pma_rx_sd_avmmreaddata[3], w_pma_rx_sd_avmmreaddata[2], w_pma_rx_sd_avmmreaddata[1], w_pma_rx_sd_avmmreaddata[0]};
		assign out_avmmreaddata_pma_tx_buf = {w_pma_tx_buf_avmmreaddata[7], w_pma_tx_buf_avmmreaddata[6], w_pma_tx_buf_avmmreaddata[5], w_pma_tx_buf_avmmreaddata[4], w_pma_tx_buf_avmmreaddata[3], w_pma_tx_buf_avmmreaddata[2], w_pma_tx_buf_avmmreaddata[1], w_pma_tx_buf_avmmreaddata[0]};
		assign out_avmmreaddata_pma_tx_ser = {w_pma_tx_ser_avmmreaddata[7], w_pma_tx_ser_avmmreaddata[6], w_pma_tx_ser_avmmreaddata[5], w_pma_tx_ser_avmmreaddata[4], w_pma_tx_ser_avmmreaddata[3], w_pma_tx_ser_avmmreaddata[2], w_pma_tx_ser_avmmreaddata[1], w_pma_tx_ser_avmmreaddata[0]};
		assign out_blockselect_cdr_pll = w_cdr_pll_blockselect;
		assign out_blockselect_pma_adapt = w_pma_adapt_blockselect;
		assign out_blockselect_pma_cdr_refclk = w_pma_cdr_refclk_blockselect;
		assign out_blockselect_pma_cgb = w_pma_cgb_blockselect;
		assign out_blockselect_pma_rx_buf = w_pma_rx_buf_blockselect;
		assign out_blockselect_pma_rx_deser = w_pma_rx_deser_blockselect;
		assign out_blockselect_pma_rx_dfe = w_pma_rx_dfe_blockselect;
		assign out_blockselect_pma_rx_odi = w_pma_rx_odi_blockselect;
		assign out_blockselect_pma_rx_sd = w_pma_rx_sd_blockselect;
		assign out_blockselect_pma_tx_buf = w_pma_tx_buf_blockselect;
		assign out_blockselect_pma_tx_ser = w_pma_tx_ser_blockselect;
		assign out_clk0_pfd = w_cdr_pll_clk0_pfd;
		assign out_clk180_pfd = w_cdr_pll_clk180_pfd;
		assign out_clk_divrx_iqtxrx = w_pma_rx_deser_clkdiv;
		assign out_clk_divtx_iqtxrx = w_pma_tx_ser_clk_divtx;
		assign out_clkdiv_rx = w_pma_rx_deser_clkdiv;
		assign out_clkdiv_rx_user = w_pma_rx_deser_clkdiv_user;
		assign out_clkdiv_tx = w_pma_tx_ser_clk_divtx;
		assign out_clkdiv_tx_user = w_pma_tx_ser_clk_divtx_user;
		assign out_clklow = w_cdr_pll_clklow;
		assign out_fref = w_cdr_pll_fref;
		assign out_iqtxrxclk_out0 = w_pma_tx_ser_clk_divtx;
		assign out_iqtxrxclk_out1 = w_pma_tx_ser_clk_divtx;
		assign out_jtaglpxn = w_pma_tx_buf_vlptxn;
		assign out_jtaglpxp = w_pma_tx_buf_vlptxp;
		assign out_pcie_sw_done = {w_pma_cgb_pcie_sw_done[1], w_pma_cgb_pcie_sw_done[0]};
		assign out_pcie_sw_master = {w_pma_cgb_pcie_sw_master[1], w_pma_cgb_pcie_sw_master[0]};
		assign out_pfdmode_lock = w_cdr_pll_pfdmode_lock;
		assign out_rx_detect_valid = w_pma_tx_buf_rx_detect_valid;
		assign out_rx_found = w_pma_tx_buf_rx_found;
		assign out_rxdata = {w_pma_rx_deser_dout[63], w_pma_rx_deser_dout[62], w_pma_rx_deser_dout[61], w_pma_rx_deser_dout[60], w_pma_rx_deser_dout[59], w_pma_rx_deser_dout[58], w_pma_rx_deser_dout[57], w_pma_rx_deser_dout[56], w_pma_rx_deser_dout[55], w_pma_rx_deser_dout[54], w_pma_rx_deser_dout[53], w_pma_rx_deser_dout[52], w_pma_rx_deser_dout[51], w_pma_rx_deser_dout[50], w_pma_rx_deser_dout[49], w_pma_rx_deser_dout[48], w_pma_rx_deser_dout[47], w_pma_rx_deser_dout[46], w_pma_rx_deser_dout[45], w_pma_rx_deser_dout[44], w_pma_rx_deser_dout[43], w_pma_rx_deser_dout[42], w_pma_rx_deser_dout[41], w_pma_rx_deser_dout[40], w_pma_rx_deser_dout[39], w_pma_rx_deser_dout[38], w_pma_rx_deser_dout[37], w_pma_rx_deser_dout[36], w_pma_rx_deser_dout[35], w_pma_rx_deser_dout[34], w_pma_rx_deser_dout[33], w_pma_rx_deser_dout[32], w_pma_rx_deser_dout[31], w_pma_rx_deser_dout[30], w_pma_rx_deser_dout[29], w_pma_rx_deser_dout[28], w_pma_rx_deser_dout[27], w_pma_rx_deser_dout[26], w_pma_rx_deser_dout[25], w_pma_rx_deser_dout[24], w_pma_rx_deser_dout[23], w_pma_rx_deser_dout[22], w_pma_rx_deser_dout[21], w_pma_rx_deser_dout[20], w_pma_rx_deser_dout[19], w_pma_rx_deser_dout[18], w_pma_rx_deser_dout[17], w_pma_rx_deser_dout[16], w_pma_rx_deser_dout[15], w_pma_rx_deser_dout[14], w_pma_rx_deser_dout[13], w_pma_rx_deser_dout[12], w_pma_rx_deser_dout[11], w_pma_rx_deser_dout[10], w_pma_rx_deser_dout[9], w_pma_rx_deser_dout[8], w_pma_rx_deser_dout[7], w_pma_rx_deser_dout[6], w_pma_rx_deser_dout[5], w_pma_rx_deser_dout[4], w_pma_rx_deser_dout[3], w_pma_rx_deser_dout[2], w_pma_rx_deser_dout[1], w_pma_rx_deser_dout[0]};
		assign out_rxpll_lock = w_cdr_pll_rxpll_lock;
		assign out_sd = w_pma_rx_sd_sd;
		assign out_tx_n = w_pma_tx_buf_von;
		assign out_tx_p = w_pma_tx_buf_vop;
	endgenerate
endmodule
module twentynm_pma_rev_20nm2
	#(
	//PARAM_LIST_START
		parameter xcvr_native_mode = "mode_duplex",  // mode_duplex, mode_rx_only, mode_tx_only
		
		// parameters for twentynm_hssi_pma_adaptation
		parameter pma_adapt_adapt_mode = "dfe_vga", // ctle|dfe_vga|ctle_vga|ctle_vga_dfe|manual
		parameter pma_adapt_adp_1s_ctle_bypass = "radp_1s_ctle_bypass_0", // radp_1s_ctle_bypass_0|radp_1s_ctle_bypass_1
		parameter pma_adapt_adp_4s_ctle_bypass = "radp_4s_ctle_bypass_0", // radp_4s_ctle_bypass_0|radp_4s_ctle_bypass_1
		parameter pma_adapt_adp_ctle_adapt_cycle_window = "radp_ctle_adapt_cycle_window_6", // radp_ctle_adapt_cycle_window_0|radp_ctle_adapt_cycle_window_1|radp_ctle_adapt_cycle_window_2|radp_ctle_adapt_cycle_window_3|radp_ctle_adapt_cycle_window_4|radp_ctle_adapt_cycle_window_5|radp_ctle_adapt_cycle_window_6|radp_ctle_adapt_cycle_window_7
		parameter pma_adapt_adp_ctle_en = "radp_ctle_disable", // radp_ctle_disable|radp_ctle_enable
		parameter pma_adapt_adp_dfe_fltap_bypass = "radp_dfe_fltap_bypass_0", // radp_dfe_fltap_bypass_0|radp_dfe_fltap_bypass_1
		parameter pma_adapt_adp_dfe_fltap_en = "radp_dfe_fltap_disable", // radp_dfe_fltap_disable|radp_dfe_fltap_enable
		parameter pma_adapt_adp_dfe_fxtap_bypass = "radp_dfe_fxtap_bypass_0", // radp_dfe_fxtap_bypass_0|radp_dfe_fxtap_bypass_1
		parameter pma_adapt_adp_dfe_fxtap_en = "radp_dfe_fxtap_disable", // radp_dfe_fxtap_disable|radp_dfe_fxtap_enable
		parameter pma_adapt_adp_dfe_fxtap_hold_en = "radp_dfe_fxtap_not_held", // radp_dfe_fxtap_not_held|radp_dfe_fxtap_hold
		parameter pma_adapt_adp_dfe_mode = "radp_dfe_mode_0", // radp_dfe_mode_0|radp_dfe_mode_1|radp_dfe_mode_2|radp_dfe_mode_3|radp_dfe_mode_4|radp_dfe_mode_5|radp_dfe_mode_6|radp_dfe_mode_7
		parameter pma_adapt_adp_mode = "radp_mode_0", // radp_mode_0|radp_mode_1|radp_mode_2|radp_mode_3|radp_mode_4|radp_mode_5|radp_mode_6|radp_mode_7|radp_mode_8|radp_mode_9|radp_mode_10|radp_mode_11|radp_mode_12|radp_mode_13|radp_mode_14|radp_mode_15
		parameter pma_adapt_adp_onetime_dfe = "radp_onetime_dfe_0", // radp_onetime_dfe_0|radp_onetime_dfe_1
		parameter pma_adapt_adp_vga_bypass = "radp_vga_bypass_0", // radp_vga_bypass_0|radp_vga_bypass_1
		parameter pma_adapt_adp_vga_en = "radp_vga_disable", // radp_vga_disable|radp_vga_enable
		parameter pma_adapt_adp_vref_bypass = "radp_vref_bypass_0", // radp_vref_bypass_0|radp_vref_bypass_1
		parameter pma_adapt_adp_vref_en = "radp_vref_disable", // radp_vref_disable|radp_vref_enable
		parameter pma_adapt_datarate = "0 bps", // 
		parameter pma_adapt_odi_dfe_spec_en = "rodi_dfe_spec_en_0", // rodi_dfe_spec_en_0|rodi_dfe_spec_en_1
		parameter pma_adapt_prot_mode = "basic_rx", // basic_rx|pcie_gen1_rx|pcie_gen2_rx|pcie_gen3_rx|pcie_gen4_rx|qpi_rx|unused|gpon_rx|sata_rx
		parameter pma_adapt_sup_mode = "user_mode", // user_mode|engineering_mode
		
		// parameters for twentynm_hssi_pma_cdr_refclk_select_mux
		parameter pma_cdr_refclk_inclk0_logical_to_physical_mapping = "ref_iqclk0", // ref_iqclk0|ref_iqclk1|ref_iqclk2|ref_iqclk3|ref_iqclk4|ref_iqclk5|ref_iqclk6|ref_iqclk7|ref_iqclk8|ref_iqclk9|ref_iqclk10|ref_iqclk11|iqtxrxclk0|iqtxrxclk1|iqtxrxclk2|iqtxrxclk3|iqtxrxclk4|iqtxrxclk5|coreclk|fixed_clk|lvpecl|adj_pll_clk|power_down
		parameter pma_cdr_refclk_inclk1_logical_to_physical_mapping = "ref_iqclk0", // ref_iqclk0|ref_iqclk1|ref_iqclk2|ref_iqclk3|ref_iqclk4|ref_iqclk5|ref_iqclk6|ref_iqclk7|ref_iqclk8|ref_iqclk9|ref_iqclk10|ref_iqclk11|iqtxrxclk0|iqtxrxclk1|iqtxrxclk2|iqtxrxclk3|iqtxrxclk4|iqtxrxclk5|coreclk|fixed_clk|lvpecl|adj_pll_clk|power_down
		parameter pma_cdr_refclk_inclk2_logical_to_physical_mapping = "ref_iqclk0", // ref_iqclk0|ref_iqclk1|ref_iqclk2|ref_iqclk3|ref_iqclk4|ref_iqclk5|ref_iqclk6|ref_iqclk7|ref_iqclk8|ref_iqclk9|ref_iqclk10|ref_iqclk11|iqtxrxclk0|iqtxrxclk1|iqtxrxclk2|iqtxrxclk3|iqtxrxclk4|iqtxrxclk5|coreclk|fixed_clk|lvpecl|adj_pll_clk|power_down
		parameter pma_cdr_refclk_inclk3_logical_to_physical_mapping = "ref_iqclk0", // ref_iqclk0|ref_iqclk1|ref_iqclk2|ref_iqclk3|ref_iqclk4|ref_iqclk5|ref_iqclk6|ref_iqclk7|ref_iqclk8|ref_iqclk9|ref_iqclk10|ref_iqclk11|iqtxrxclk0|iqtxrxclk1|iqtxrxclk2|iqtxrxclk3|iqtxrxclk4|iqtxrxclk5|coreclk|fixed_clk|lvpecl|adj_pll_clk|power_down
		parameter pma_cdr_refclk_inclk4_logical_to_physical_mapping = "ref_iqclk0", // ref_iqclk0|ref_iqclk1|ref_iqclk2|ref_iqclk3|ref_iqclk4|ref_iqclk5|ref_iqclk6|ref_iqclk7|ref_iqclk8|ref_iqclk9|ref_iqclk10|ref_iqclk11|iqtxrxclk0|iqtxrxclk1|iqtxrxclk2|iqtxrxclk3|iqtxrxclk4|iqtxrxclk5|coreclk|fixed_clk|lvpecl|adj_pll_clk|power_down
		parameter pma_cdr_refclk_powerdown_mode = "powerdown", // powerup|powerdown
		parameter pma_cdr_refclk_refclk_select = "ref_iqclk0", // ref_iqclk0|ref_iqclk1|ref_iqclk2|ref_iqclk3|ref_iqclk4|ref_iqclk5|ref_iqclk6|ref_iqclk7|ref_iqclk8|ref_iqclk9|ref_iqclk10|ref_iqclk11|iqtxrxclk0|iqtxrxclk1|iqtxrxclk2|iqtxrxclk3|iqtxrxclk4|iqtxrxclk5|coreclk|fixed_clk|lvpecl|adj_pll_clk|power_down
		
		// parameters for twentynm_hssi_pma_channel_pll
		parameter cdr_pll_atb_select_control = "atb_off", // atb_off|atb_select_tp_1|atb_select_tp_2|atb_select_tp_3|atb_select_tp_4|atb_select_tp_5|atb_select_tp_6|atb_select_tp_7|atb_select_tp_8|atb_select_tp_9|atb_select_tp_10|atb_select_tp_11|atb_select_tp_12|atb_select_tp_13|atb_select_tp_14|atb_select_tp_15|atb_select_tp_16|atb_select_tp_17|atb_select_tp_18|atb_select_tp_19|atb_select_tp_20|atb_select_tp_21|atb_select_tp_22|atb_select_tp_23|atb_select_tp_24|atb_select_tp_25|atb_select_tp_26|atb_select_tp_27|atb_select_tp_28|atb_select_tp_29|atb_select_tp_30|atb_select_tp_31|atb_select_tp_32|atb_select_tp_33|atb_select_tp_34|atb_select_tp_35|atb_select_tp_36|atb_select_tp_37|atb_select_tp_38|atb_select_tp_39|atb_select_tp_40|atb_select_tp_41|atb_select_tp_42|atb_select_tp_43|atb_select_tp_44|atb_select_tp_45|atb_select_tp_46|atb_select_tp_47|atb_select_tp_48|atb_select_tp_49|atb_select_tp_50|atb_select_tp_51|atb_select_tp_52|atb_select_tp_53|atb_select_tp_54|atb_select_tp_55|atb_select_tp_56|atb_select_tp_57|atb_select_tp_58|atb_select_tp_59|atb_select_tp_60|atb_select_tp_61|atb_select_tp_62|atb_select_tp_63
		parameter cdr_pll_auto_reset_on = "auto_reset_on", // auto_reset_on|auto_reset_off
		parameter cdr_pll_bbpd_data_pattern_filter_select = "bbpd_data_pat_off", // bbpd_data_pat_off|bbpd_data_pat_1|bbpd_data_pat_2|bbpd_data_pat_3
		parameter cdr_pll_bw_sel = "low", // low|medium|high
		parameter cdr_pll_cal_vco_count_length = "sel_8b_count", // sel_8b_count|sel_12b_count
		parameter cdr_pll_cdr_odi_select = "sel_cdr", // sel_cdr|sel_odi
		parameter cdr_pll_cdr_phaselock_mode = "no_ignore_lock", // no_ignore_lock|ignore_lock
		parameter cdr_pll_cdr_powerdown_mode = "power_down", // power_down|power_up
		parameter cdr_pll_cgb_div = 1, // 1|2|4|8
		parameter cdr_pll_chgpmp_current_dn_pd = "cp_current_pd_dn_setting0", // cp_current_pd_dn_setting0|cp_current_pd_dn_setting1|cp_current_pd_dn_setting2|cp_current_pd_dn_setting3|cp_current_pd_dn_setting4
		parameter cdr_pll_chgpmp_current_dn_trim = "cp_current_trimming_dn_setting0", // cp_current_trimming_dn_setting0|cp_current_trimming_dn_setting1|cp_current_trimming_dn_setting2|cp_current_trimming_dn_setting3|cp_current_trimming_dn_setting4|cp_current_trimming_dn_setting5|cp_current_trimming_dn_setting6|cp_current_trimming_dn_setting7|cp_current_trimming_dn_setting8|cp_current_trimming_dn_setting9|cp_current_trimming_dn_setting10|cp_current_trimming_dn_setting11|cp_current_trimming_dn_setting12|cp_current_trimming_dn_setting13|cp_current_trimming_dn_setting14|cp_current_trimming_dn_setting15
		parameter cdr_pll_chgpmp_current_pd = "cp_current_pd_setting0", // cp_current_pd_setting0|cp_current_pd_setting1|cp_current_pd_setting2|cp_current_pd_setting3|cp_current_pd_setting4
		parameter cdr_pll_chgpmp_current_pfd = "cp_current_pfd_setting0", // cp_current_pfd_setting0|cp_current_pfd_setting1|cp_current_pfd_setting2|cp_current_pfd_setting3|cp_current_pfd_setting4
		parameter cdr_pll_chgpmp_current_up_pd = "cp_current_pd_up_setting0", // cp_current_pd_up_setting0|cp_current_pd_up_setting1|cp_current_pd_up_setting2|cp_current_pd_up_setting3|cp_current_pd_up_setting4
		parameter cdr_pll_chgpmp_current_up_trim = "cp_current_trimming_up_setting0", // cp_current_trimming_up_setting0|cp_current_trimming_up_setting1|cp_current_trimming_up_setting2|cp_current_trimming_up_setting3|cp_current_trimming_up_setting4|cp_current_trimming_up_setting5|cp_current_trimming_up_setting6|cp_current_trimming_up_setting7|cp_current_trimming_up_setting8|cp_current_trimming_up_setting9|cp_current_trimming_up_setting10|cp_current_trimming_up_setting11|cp_current_trimming_up_setting12|cp_current_trimming_up_setting13|cp_current_trimming_up_setting14|cp_current_trimming_up_setting15
		parameter cdr_pll_chgpmp_dn_pd_trim_double = "normal_dn_trim_current", // normal_dn_trim_current|double_dn_trim_current
		parameter cdr_pll_chgpmp_replicate = "false", // false|true
		parameter cdr_pll_chgpmp_testmode = "cp_test_disable", // cp_test_disable|cp_test_up|cp_test_dn|cp_tristate
		parameter cdr_pll_chgpmp_up_pd_trim_double = "normal_up_trim_current", // normal_up_trim_current|double_up_trim_current
		parameter cdr_pll_clklow_mux_select = "clklow_mux_cdr_fbclk", // clklow_mux_cdr_fbclk|clklow_mux_fpll_test1|clklow_mux_reserved_1|clklow_mux_rx_deser_pclk_test|clklow_mux_reserved_2|clklow_mux_reserved_3|clklow_mux_reserved_4|clklow_mux_dfe_test
		parameter cdr_pll_datarate = "0 bps", // 
		parameter cdr_pll_diag_loopback_enable = "false", // true|false
		parameter cdr_pll_disable_up_dn = "true", // true|false
		parameter cdr_pll_fb_select = "direct_fb", // iqtxrxclk_fb|direct_fb
		parameter cdr_pll_fref_clklow_div = 1, // 1|2|4|8
		parameter cdr_pll_fref_mux_select = "fref_mux_cdr_refclk", // fref_mux_cdr_refclk|fref_mux_fpll_test0|fref_mux_reserved_1|fref_mux_tx_ser_pclk_test|fref_mux_reserved_2|fref_mux_reserved_3|fref_mux_reserved_4|fref_mux_reserved_5
		parameter cdr_pll_gpon_lck2ref_control = "gpon_lck2ref_off", // gpon_lck2ref_off|gpon_lck2ref_on
		parameter cdr_pll_initial_settings = "false", // false|true
		parameter cdr_pll_iqclk_mux_sel = "power_down", // iqtxrxclk0|iqtxrxclk1|iqtxrxclk2|iqtxrxclk3|iqtxrxclk4|iqtxrxclk5|power_down
		parameter cdr_pll_is_cascaded_pll = "false", // true|false
		parameter cdr_pll_lck2ref_delay_control = "lck2ref_delay_off", // lck2ref_delay_off|lck2ref_delay_1|lck2ref_delay_2|lck2ref_delay_3|lck2ref_delay_4|lck2ref_delay_5|lck2ref_delay_6|lck2ref_delay_7
		parameter cdr_pll_lf_resistor_pd = "lf_pd_setting0", // lf_pd_setting0|lf_pd_setting1|lf_pd_setting2|lf_pd_setting3
		parameter cdr_pll_lf_resistor_pfd = "lf_pfd_setting0", // lf_pfd_setting0|lf_pfd_setting1|lf_pfd_setting2|lf_pfd_setting3
		parameter cdr_pll_lf_ripple_cap = "lf_no_ripple", // lf_no_ripple|lf_ripple_cap1
		parameter cdr_pll_loop_filter_bias_select = "lpflt_bias_off", // lpflt_bias_off|lpflt_bias_1|lpflt_bias_2|lpflt_bias_3|lpflt_bias_4|lpflt_bias_5|lpflt_bias_6|lpflt_bias_7
		parameter cdr_pll_loopback_mode = "loopback_disabled", // loopback_disabled|loopback_recovered_data|rx_refclk|rx_refclk_cdr_loopback|unused2|loopback_received_data|unused1
		parameter cdr_pll_lpd_counter = 5'b1,
		parameter cdr_pll_lpfd_counter = 5'b1,
		parameter cdr_pll_ltd_ltr_micro_controller_select = "ltd_ltr_pcs", // ltd_ltr_pcs|ltr_ucontroller|ltd_ucontroller
		parameter cdr_pll_m_counter = 16, // 0..255
		parameter cdr_pll_n_counter = 1, // 1|2|4|8
		parameter cdr_pll_n_counter_scratch = 6'b1,
		parameter cdr_pll_output_clock_frequency = "0 hz", // 
		parameter cdr_pll_pcie_gen = "non_pcie", // pcie_gen1_100mhzref|pcie_gen2_100mhzref|pcie_gen3_100mhzref|pcie_gen1_125mhzref|pcie_gen2_125mhzref|pcie_gen3_125mhzref|non_pcie
		parameter cdr_pll_pd_fastlock_mode = "false", // false|true
		parameter cdr_pll_pd_l_counter = 1, // 0|1|2|4|8|16
		parameter cdr_pll_pfd_l_counter = 1, // 0|1|2|4|8|16|100
		parameter cdr_pll_pma_width = 8, // 8|10|16|20|32|40|64
		parameter cdr_pll_primary_use = "cmu", // cmu|cdr
		parameter cdr_pll_prot_mode = "unused", // basic_rx|pcie_gen1_rx|pcie_gen2_rx|pcie_gen3_rx|pcie_gen4_rx|qpi_rx|unused|gpon_rx|sata_rx
		parameter cdr_pll_reference_clock_frequency = "0 hz", // 
		parameter cdr_pll_reverse_serial_loopback = "no_loopback", // no_loopback|loopback_data_no_posttap|loopback_data_with_posttap|loopback_data_0_1
		parameter cdr_pll_set_cdr_input_freq_range = 8'b0,
		parameter cdr_pll_set_cdr_v2i_enable = "true", // true|false
		parameter cdr_pll_set_cdr_vco_reset = "false", // true|false
		parameter cdr_pll_set_cdr_vco_speed = 5'b1,
		parameter cdr_pll_set_cdr_vco_speed_fix = 8'b0,
		parameter cdr_pll_set_cdr_vco_speed_pciegen3 = "cdr_vco_max_speedbin_pciegen3", // cdr_vco_min_speedbin_pciegen3|cdr_vco_max_speedbin_pciegen3
		parameter cdr_pll_sup_mode = "user_mode", // user_mode|engineering_mode
		parameter cdr_pll_tx_pll_prot_mode = "txpll_unused", // txpll_unused|txpll_enable_pcie|txpll_enable
		parameter cdr_pll_txpll_hclk_driver_enable = "false", // true|false
		parameter cdr_pll_uc_ro_cal = "uc_ro_cal_off", // uc_ro_cal_off|uc_ro_cal_on
		parameter cdr_pll_vco_freq = "0 hz", // 
		parameter cdr_pll_vco_overrange_voltage = "vco_overrange_off", // vco_overrange_off|vco_overrange_ref_1|vco_overrange_ref_2|vco_overrange_ref_3
		parameter cdr_pll_vco_underrange_voltage = "vco_underange_off", // vco_underange_off|vco_underange_ref_1|vco_underange_ref_2|vco_underange_ref_3
		
		// parameters for twentynm_hssi_pma_rx_buf
		parameter pma_rx_buf_bypass_eqz_stages_234 = "bypass_off", // bypass_off|byypass_stages_234
		parameter pma_rx_buf_datarate = "0 bps", // 
		parameter pma_rx_buf_diag_lp_en = "dlp_off", // dlp_off|dlp_on
		parameter pma_rx_buf_loopback_modes = "lpbk_disable", // lpbk_disable|pre_cdr|post_cdr
		parameter pma_rx_buf_pm_tx_rx_cvp_mode = "cvp_off", // cvp_off|cvp_on
		parameter pma_rx_buf_pm_tx_rx_pcie_gen = "non_pcie", // pcie_gen1_100mhzref|pcie_gen2_100mhzref|pcie_gen3_100mhzref|pcie_gen1_125mhzref|pcie_gen2_125mhzref|pcie_gen3_125mhzref|non_pcie
		parameter pma_rx_buf_pm_tx_rx_pcie_gen_bitwidth = "pcie_gen3_32b", // pcie_gen3_32b|pcie_gen3_16b
		parameter pma_rx_buf_prot_mode = "basic_rx", // basic_rx|pcie_gen1_rx|pcie_gen2_rx|pcie_gen3_rx|pcie_gen4_rx|qpi_rx|unused|gpon_rx|sata_rx
		parameter pma_rx_buf_qpi_enable = "non_qpi_mode", // non_qpi_mode|qpi_mode
		parameter pma_rx_buf_refclk_en = "enable", // disable|enable
		parameter pma_rx_buf_rx_refclk_divider = "bypass_divider", // bypass_divider|divide_by_2
		parameter pma_rx_buf_sup_mode = "user_mode", // user_mode|engineering_mode
		parameter pma_rx_buf_xrx_path_datarate = "0 bps", // 
		parameter pma_rx_buf_xrx_path_datawidth = 8'b0,
		parameter pma_rx_buf_xrx_path_pma_rx_divclk_hz = 32'b0,
		parameter pma_rx_buf_xrx_path_prot_mode = "unused", // basic_rx|pcie_gen1_rx|pcie_gen2_rx|pcie_gen3_rx|pcie_gen4_rx|qpi_rx|unused|gpon_rx|sata_rx
		parameter pma_rx_buf_xrx_path_sup_mode = "user_mode", // user_mode|engineering_mode
		parameter pma_rx_buf_xrx_path_uc_cal_enable = "rx_cal_off", // rx_cal_off|rx_cal_on
		
		// parameters for twentynm_hssi_pma_rx_deser
		parameter pma_rx_deser_bitslip_bypass = "bs_bypass_no", // bs_bypass_no|bs_bypass_yes
		parameter pma_rx_deser_clkdiv_source = "vco_bypass_normal", // vco_bypass_normal|clklow_to_clkdivrx|fref_to_clkdivrx
		parameter pma_rx_deser_clkdivrx_user_mode = "clkdivrx_user_disabled", // clkdivrx_user_disabled|clkdivrx_user_clkdiv|clkdivrx_user_clkdiv_div2|clkdivrx_user_div40|clkdivrx_user_div33|clkdivrx_user_div66
		parameter pma_rx_deser_datarate = "0 bps", // 
		parameter pma_rx_deser_deser_factor = 8, // 8|10|16|20|32|40|64
		parameter pma_rx_deser_force_clkdiv_for_testing = "normal_clkdiv", // normal_clkdiv|forced_0|forced_1
		parameter pma_rx_deser_pcie_gen = "non_pcie", // pcie_gen1_100mhzref|pcie_gen2_100mhzref|pcie_gen3_100mhzref|pcie_gen1_125mhzref|pcie_gen2_125mhzref|pcie_gen3_125mhzref|non_pcie
		parameter pma_rx_deser_pcie_gen_bitwidth = "pcie_gen3_32b", // pcie_gen3_32b|pcie_gen3_16b
		parameter pma_rx_deser_prot_mode = "basic_rx", // basic_rx|pcie_gen1_rx|pcie_gen2_rx|pcie_gen3_rx|pcie_gen4_rx|qpi_rx|unused|gpon_rx|sata_rx
		parameter pma_rx_deser_rst_n_adapt_odi = "no_rst_adapt_odi", // yes_rst_adapt_odi|no_rst_adapt_odi
		parameter pma_rx_deser_sdclk_enable = "false", // false|true
		parameter pma_rx_deser_sup_mode = "user_mode", // user_mode|engineering_mode
		
		// parameters for twentynm_hssi_pma_rx_dfe
		parameter pma_rx_dfe_datarate = "0 bps", // 
		parameter pma_rx_dfe_dft_en = "dft_disable", // dft_disable|dft_enalbe
		parameter pma_rx_dfe_pdb = "dfe_enable", // dfe_powerdown|dfe_reset|dfe_enable
		parameter pma_rx_dfe_pdb_fixedtap = "fixtap_dfe_powerdown", // fixtap_dfe_powerdown|fixtap_dfe_enable
		parameter pma_rx_dfe_pdb_floattap = "floattap_dfe_powerdown", // floattap_dfe_powerdown|floattap_dfe_enable
		parameter pma_rx_dfe_pdb_fxtap4t7 = "fxtap4t7_powerdown", // fxtap4t7_powerdown|fxtap4t7_enable
		parameter pma_rx_dfe_prot_mode = "basic_rx", // basic_rx|pcie_gen1_rx|pcie_gen2_rx|pcie_gen3_rx|pcie_gen4_rx|qpi_rx|unused|gpon_rx|sata_rx
		parameter pma_rx_dfe_sup_mode = "user_mode", // user_mode|engineering_mode
		
		// parameters for twentynm_hssi_pma_rx_odi
		parameter pma_rx_odi_datarate = "0 bps", // 
		parameter pma_rx_odi_prot_mode = "basic_rx", // basic_rx|pcie_gen1_rx|pcie_gen2_rx|pcie_gen3_rx|pcie_gen4_rx|qpi_rx|unused|gpon_rx|sata_rx
		parameter pma_rx_odi_step_ctrl_sel = "feedback_mode", // dprio_mode|feedback_mode|jm_mode
		parameter pma_rx_odi_sup_mode = "user_mode", // user_mode|engineering_mode
		
		// parameters for twentynm_hssi_pma_rx_sd
		parameter pma_rx_sd_prot_mode = "basic_rx", // basic_rx|pcie_gen1_rx|pcie_gen2_rx|pcie_gen3_rx|pcie_gen4_rx|qpi_rx|unused|gpon_rx|sata_rx
		parameter pma_rx_sd_sd_output_off = 1, // 0..28
		parameter pma_rx_sd_sd_output_on = 1, // 0..15
		parameter pma_rx_sd_sd_pdb = "sd_off", // sd_on|sd_off
		parameter pma_rx_sd_sup_mode = "user_mode", // user_mode|engineering_mode
		
		// parameters for twentynm_hssi_pma_tx_buf
		parameter pma_tx_buf_datarate = "0 bps", // 
		parameter pma_tx_buf_mcgb_location_for_pcie = 4'b0,
		parameter pma_tx_buf_prot_mode = "basic_tx", // unused|basic_tx|pcie_gen1_tx|pcie_gen2_tx|pcie_gen3_tx|pcie_gen4_tx|qpi_tx|gpon_tx|sata_tx
		parameter pma_tx_buf_rx_det = "mode_0", // mode_0|mode_1|mode_2|mode_3|mode_4|mode_5|mode_6|mode_7|mode_8|mode_9|mode_10|mode_11|mode_12|mode_13|mode_14|mode_15
		parameter pma_tx_buf_rx_det_output_sel = "rx_det_pcie_out", // rx_det_pcie_out|rx_det_qpi_out
		parameter pma_tx_buf_rx_det_pdb = "rx_det_off", // rx_det_off|rx_det_on
		parameter pma_tx_buf_sup_mode = "user_mode", // user_mode|engineering_mode
		parameter pma_tx_buf_user_fir_coeff_ctrl_sel = "ram_ctl", // ram_ctl|dynamic_ctl
		parameter pma_tx_buf_xtx_path_clock_divider_ratio = 4'b0,
		parameter pma_tx_buf_xtx_path_datarate = "0 bps", // 
		parameter pma_tx_buf_xtx_path_datawidth = 8'b0,
		parameter pma_tx_buf_xtx_path_pma_tx_divclk_hz = 32'b0,
		parameter pma_tx_buf_xtx_path_prot_mode = "basic_tx", // unused|basic_tx|pcie_gen1_tx|pcie_gen2_tx|pcie_gen3_tx|pcie_gen4_tx|qpi_tx|gpon_tx|sata_tx
		parameter pma_tx_buf_xtx_path_sup_mode = "user_mode", // user_mode|engineering_mode
		parameter pma_tx_buf_xtx_path_tx_pll_clk_hz = "0 hz", // 
		
		// parameters for twentynm_hssi_pma_tx_cgb
		parameter pma_cgb_bitslip_enable = "enable_bitslip", // disable_bitslip|enable_bitslip
		parameter pma_cgb_bonding_reset_enable = "allow_bonding_reset", // disallow_bonding_reset|allow_bonding_reset
		parameter pma_cgb_datarate = "0 bps", // 
		parameter pma_cgb_input_select_gen3 = "unused", // lcpll_bot|lcpll_top|fpll_bot|fpll_top|cdr_txpll_b|cdr_txpll_t|same_ch_txpll|lcpll_hs|hfclk_xn_up|hfclk_x6_dn|hfclk_xn_dn|hfclk_x6_up|unused
		parameter pma_cgb_input_select_x1 = "unused", // lcpll_bot|lcpll_top|fpll_bot|fpll_top|cdr_txpll_b|cdr_txpll_t|same_ch_txpll|lcpll_hs|hfclk_xn_up|hfclk_x6_dn|hfclk_xn_dn|hfclk_x6_up|unused
		parameter pma_cgb_input_select_xn = "unused", // sel_xn_up|sel_xn_dn|sel_x6_up|sel_x6_dn|sel_cgb_loc|unused
		parameter pma_cgb_pcie_gen3_bitwidth = "pciegen3_wide", // pciegen3_wide|pciegen3_narrow
		parameter pma_cgb_prot_mode = "basic_tx", // unused|basic_tx|pcie_gen1_tx|pcie_gen2_tx|pcie_gen3_tx|pcie_gen4_tx|qpi_tx|gpon_tx|sata_tx
		parameter pma_cgb_scratch0_x1_clock_src = "unused", // lcpll_bot|lcpll_top|fpll_bot|fpll_top|cdr_txpll_b|cdr_txpll_t|same_ch_txpll|lcpll_hs|hfclk_xn_up|hfclk_x6_dn|hfclk_xn_dn|hfclk_x6_up|unused
		parameter pma_cgb_scratch1_x1_clock_src = "unused", // lcpll_bot|lcpll_top|fpll_bot|fpll_top|cdr_txpll_b|cdr_txpll_t|same_ch_txpll|lcpll_hs|hfclk_xn_up|hfclk_x6_dn|hfclk_xn_dn|hfclk_x6_up|unused
		parameter pma_cgb_scratch2_x1_clock_src = "unused", // lcpll_bot|lcpll_top|fpll_bot|fpll_top|cdr_txpll_b|cdr_txpll_t|same_ch_txpll|lcpll_hs|hfclk_xn_up|hfclk_x6_dn|hfclk_xn_dn|hfclk_x6_up|unused
		parameter pma_cgb_scratch3_x1_clock_src = "unused", // lcpll_bot|lcpll_top|fpll_bot|fpll_top|cdr_txpll_b|cdr_txpll_t|same_ch_txpll|lcpll_hs|hfclk_xn_up|hfclk_x6_dn|hfclk_xn_dn|hfclk_x6_up|unused
		parameter pma_cgb_select_done_master_or_slave = "choose_slave_pcie_sw_done", // choose_master_pcie_sw_done|choose_slave_pcie_sw_done
		parameter pma_cgb_ser_mode = "eight_bit", // eight_bit|ten_bit|sixteen_bit|twenty_bit|thirty_two_bit|forty_bit|sixty_four_bit
		parameter pma_cgb_sup_mode = "user_mode", // user_mode|engineering_mode
		parameter pma_cgb_tx_ucontrol_en = "disable", // disable|enable
		parameter pma_cgb_x1_div_m_sel = "divbypass", // divbypass|divby2|divby4|divby8
		
		// parameters for twentynm_hssi_pma_tx_ser
		parameter pma_tx_ser_prot_mode = "basic_tx", // unused|basic_tx|pcie_gen1_tx|pcie_gen2_tx|pcie_gen3_tx|pcie_gen4_tx|qpi_tx|gpon_tx|sata_tx
		parameter pma_tx_ser_ser_clk_divtx_user_sel = "divtx_user_33", // divtx_user_2|divtx_user_40|divtx_user_33|divtx_user_66|divtx_user_1|divtx_user_off
		parameter pma_tx_ser_sup_mode = "user_mode" // user_mode|engineering_mode
	//PARAM_LIST_END
	)
	(
	//PORT_LIST_START
		input wire		in_adapt_start,
		input wire	[8:0]	in_avmmaddress,
		input wire		in_avmmclk,
		input wire		in_avmmread,
		input wire		in_avmmrstn,
		input wire		in_avmmwrite,
		input wire	[7:0]	in_avmmwritedata,
		input wire		in_clk_cdr_b,
		input wire		in_clk_cdr_t,
		input wire		in_clk_fpll_b,
		input wire		in_clk_fpll_t,
		input wire		in_clk_lc_b,
		input wire		in_clk_lc_hs,
		input wire		in_clk_lc_t,
		input wire		in_clkb_cdr_b,
		input wire		in_clkb_cdr_t,
		input wire		in_clkb_fpll_b,
		input wire		in_clkb_fpll_t,
		input wire		in_clkb_lc_b,
		input wire		in_clkb_lc_hs,
		input wire		in_clkb_lc_t,
		input wire		in_core_refclk_in,
		input wire	[5:0]	in_cpulse_x6_dn_bus,
		input wire	[5:0]	in_cpulse_x6_up_bus,
		input wire	[5:0]	in_cpulse_xn_dn_bus,
		input wire	[5:0]	in_cpulse_xn_up_bus,
		input wire		in_early_eios,
		input wire	[5:0]	in_eye_monitor,
		input wire	[1:0]	in_fpll_ppm_clk_in,
		input wire	[17:0]	in_i_coeff,
		input wire	[2:0]	in_i_rxpreset,
		input wire	[5:0]	in_iqtxrxclk,
		input wire		in_ltd_b,
		input wire		in_ltr,
		input wire	[1:0]	in_pcie_sw,
		input wire	[1:0]	in_pcie_sw_done_master_in,
		input wire		in_pma_atpg_los_en_n_in,
		input wire	[4:0]	in_pma_reserved_out,
		input wire		in_ppm_lock,
		input wire	[11:0]	in_ref_iqclk,
		input wire		in_rs_lpbk_b,
		input wire	[5:0]	in_rx50_buf_in,
		input wire		in_rx_bitslip,
		input wire		in_rx_n,
		input wire		in_rx_p,
		input wire		in_rx_pma_rstb,
		input wire		in_rx_qpi_pulldn,
		input wire		in_scan_mode_n,
		input wire		in_scan_shift_n,
		input wire	[8:0]	in_tx50_buf_in,
		input wire		in_tx_bitslip,
		input wire		in_tx_bonding_rstb,
		input wire	[63:0]	in_tx_data,
		input wire		in_tx_det_rx,
		input wire		in_tx_elec_idle,
		input wire		in_tx_pma_rstb,
		input wire		in_tx_qpi_pulldn,
		input wire		in_tx_qpi_pullup,
		output wire	[7:0]	out_avmmreaddata_cdr_pll,
		output wire	[7:0]	out_avmmreaddata_pma_adapt,
		output wire	[7:0]	out_avmmreaddata_pma_cdr_refclk,
		output wire	[7:0]	out_avmmreaddata_pma_cgb,
		output wire	[7:0]	out_avmmreaddata_pma_rx_buf,
		output wire	[7:0]	out_avmmreaddata_pma_rx_deser,
		output wire	[7:0]	out_avmmreaddata_pma_rx_dfe,
		output wire	[7:0]	out_avmmreaddata_pma_rx_odi,
		output wire	[7:0]	out_avmmreaddata_pma_rx_sd,
		output wire	[7:0]	out_avmmreaddata_pma_tx_buf,
		output wire	[7:0]	out_avmmreaddata_pma_tx_ser,
		output wire		out_blockselect_cdr_pll,
		output wire		out_blockselect_pma_adapt,
		output wire		out_blockselect_pma_cdr_refclk,
		output wire		out_blockselect_pma_cgb,
		output wire		out_blockselect_pma_rx_buf,
		output wire		out_blockselect_pma_rx_deser,
		output wire		out_blockselect_pma_rx_dfe,
		output wire		out_blockselect_pma_rx_odi,
		output wire		out_blockselect_pma_rx_sd,
		output wire		out_blockselect_pma_tx_buf,
		output wire		out_blockselect_pma_tx_ser,
		output wire		out_clk0_pfd,
		output wire		out_clk180_pfd,
		output wire		out_clk_divrx_iqtxrx,
		output wire		out_clk_divtx_iqtxrx,
		output wire		out_clkdiv_rx,
		output wire		out_clkdiv_rx_user,
		output wire		out_clkdiv_tx,
		output wire		out_clkdiv_tx_user,
		output wire		out_clklow,
		output wire		out_fref,
		output wire		out_iqtxrxclk_out0,
		output wire		out_iqtxrxclk_out1,
		output wire		out_jtaglpxn,
		output wire		out_jtaglpxp,
		output wire	[1:0]	out_pcie_sw_done,
		output wire	[1:0]	out_pcie_sw_master,
		output wire		out_pfdmode_lock,
		output wire		out_rx_detect_valid,
		output wire		out_rx_found,
		output wire	[63:0]	out_rxdata,
		output wire		out_rxpll_lock,
		output wire		out_sd,
		output wire		out_tx_n,
		output wire		out_tx_p
	//PORT_LIST_END
	);
	//wire declarations
	
	// wires for module twentynm_hssi_pma_rx_dfe
	wire	[7:0]	w_pma_rx_dfe_avmmreaddata;
	wire		w_pma_rx_dfe_blockselect;
	wire		w_pma_rx_dfe_clk0_bbpd;
	wire		w_pma_rx_dfe_clk180_bbpd;
	wire		w_pma_rx_dfe_clk270_bbpd;
	wire		w_pma_rx_dfe_clk90_bbpd;
	wire		w_pma_rx_dfe_deven;
	wire		w_pma_rx_dfe_devenb;
	wire	[7:0]	w_pma_rx_dfe_dfe_oc_tstmx;
	wire		w_pma_rx_dfe_dodd;
	wire		w_pma_rx_dfe_doddb;
	wire		w_pma_rx_dfe_edge270;
	wire		w_pma_rx_dfe_edge270b;
	wire		w_pma_rx_dfe_edge90;
	wire		w_pma_rx_dfe_edge90b;
	wire		w_pma_rx_dfe_err_ev;
	wire		w_pma_rx_dfe_err_evb;
	wire		w_pma_rx_dfe_err_od;
	wire		w_pma_rx_dfe_err_odb;
	wire		w_pma_rx_dfe_spec_vrefh;
	wire		w_pma_rx_dfe_spec_vrefl;
	
	// wires for module twentynm_hssi_pma_tx_ser
	wire	[7:0]	w_pma_tx_ser_avmmreaddata;
	wire		w_pma_tx_ser_blockselect;
	wire		w_pma_tx_ser_ckdrvn;
	wire		w_pma_tx_ser_ckdrvp;
	wire		w_pma_tx_ser_clk_divtx;
	wire		w_pma_tx_ser_clk_divtx_user;
	wire		w_pma_tx_ser_oe;
	wire		w_pma_tx_ser_oeb;
	wire		w_pma_tx_ser_oo;
	wire		w_pma_tx_ser_oob;
	
	// wires for module twentynm_hssi_pma_tx_buf
	wire	[2:0]	w_pma_tx_buf_atbsel;
	wire	[7:0]	w_pma_tx_buf_avmmreaddata;
	wire		w_pma_tx_buf_blockselect;
	wire		w_pma_tx_buf_ckn;
	wire		w_pma_tx_buf_ckp;
	wire		w_pma_tx_buf_dcd_out1;
	wire		w_pma_tx_buf_dcd_out2;
	wire		w_pma_tx_buf_dcd_out_ready;
	wire	[1:0]	w_pma_tx_buf_detect_on;
	wire		w_pma_tx_buf_lbvon;
	wire		w_pma_tx_buf_lbvop;
	wire		w_pma_tx_buf_rx_detect_valid;
	wire		w_pma_tx_buf_rx_found;
	wire		w_pma_tx_buf_rx_found_pcie_spl_test;
	wire		w_pma_tx_buf_sel_vreg;
	wire		w_pma_tx_buf_spl_clk_test;
	wire	[7:0]	w_pma_tx_buf_tx_dftout;
	wire		w_pma_tx_buf_vlptxn;
	wire		w_pma_tx_buf_vlptxp;
	wire		w_pma_tx_buf_von;
	wire		w_pma_tx_buf_vop;
	
	// wires for module twentynm_hssi_pma_tx_cgb
	wire	[7:0]	w_pma_cgb_avmmreaddata;
	wire		w_pma_cgb_bitslipstate;
	wire		w_pma_cgb_blockselect;
	wire	[5:0]	w_pma_cgb_cpulse_out_bus;
	wire		w_pma_cgb_div2;
	wire		w_pma_cgb_div4;
	wire		w_pma_cgb_div5;
	wire		w_pma_cgb_hifreqclkn;
	wire		w_pma_cgb_hifreqclkp;
	wire	[1:0]	w_pma_cgb_pcie_sw_done;
	wire	[1:0]	w_pma_cgb_pcie_sw_master;
	wire		w_pma_cgb_rstb;
	
	// wires for module twentynm_hssi_pma_rx_sd
	wire	[7:0]	w_pma_rx_sd_avmmreaddata;
	wire		w_pma_rx_sd_blockselect;
	wire		w_pma_rx_sd_sd;
	
	// wires for module twentynm_hssi_pma_rx_deser
	wire		w_pma_rx_deser_adapt_clk;
	wire	[7:0]	w_pma_rx_deser_avmmreaddata;
	wire		w_pma_rx_deser_blockselect;
	wire		w_pma_rx_deser_clkdiv;
	wire		w_pma_rx_deser_clkdiv_user;
	wire		w_pma_rx_deser_clkdivrx_rx;
	wire	[63:0]	w_pma_rx_deser_data;
	wire	[63:0]	w_pma_rx_deser_dout;
	wire	[63:0]	w_pma_rx_deser_error_deser;
	wire	[63:0]	w_pma_rx_deser_odi_dout;
	wire	[1:0]	w_pma_rx_deser_pcie_sw_ret;
	wire	[7:0]	w_pma_rx_deser_tstmx_deser;
	
	// wires for module twentynm_hssi_pma_cdr_refclk_select_mux
	wire	[7:0]	w_pma_cdr_refclk_avmmreaddata;
	wire		w_pma_cdr_refclk_blockselect;
	wire		w_pma_cdr_refclk_refclk;
	wire		w_pma_cdr_refclk_rx_det_clk;
	
	// wires for module twentynm_hssi_pma_adaptation
	wire	[7:0]	w_pma_adapt_avmmreaddata;
	wire		w_pma_adapt_blockselect;
	wire	[27:0]	w_pma_adapt_ctle_acgain_4s;
	wire	[14:0]	w_pma_adapt_ctle_eqz_1s_sel;
	wire	[6:0]	w_pma_adapt_ctle_lfeq_fb_sel;
	wire		w_pma_adapt_dfe_adapt_en;
	wire		w_pma_adapt_dfe_adp_clk;
	wire	[5:0]	w_pma_adapt_dfe_fltap1;
	wire		w_pma_adapt_dfe_fltap1_sgn;
	wire	[5:0]	w_pma_adapt_dfe_fltap2;
	wire		w_pma_adapt_dfe_fltap2_sgn;
	wire	[5:0]	w_pma_adapt_dfe_fltap3;
	wire		w_pma_adapt_dfe_fltap3_sgn;
	wire	[5:0]	w_pma_adapt_dfe_fltap4;
	wire		w_pma_adapt_dfe_fltap4_sgn;
	wire		w_pma_adapt_dfe_fltap_bypdeser;
	wire	[5:0]	w_pma_adapt_dfe_fltap_position;
	wire	[6:0]	w_pma_adapt_dfe_fxtap1;
	wire	[6:0]	w_pma_adapt_dfe_fxtap2;
	wire		w_pma_adapt_dfe_fxtap2_sgn;
	wire	[6:0]	w_pma_adapt_dfe_fxtap3;
	wire		w_pma_adapt_dfe_fxtap3_sgn;
	wire	[5:0]	w_pma_adapt_dfe_fxtap4;
	wire		w_pma_adapt_dfe_fxtap4_sgn;
	wire	[5:0]	w_pma_adapt_dfe_fxtap5;
	wire		w_pma_adapt_dfe_fxtap5_sgn;
	wire	[4:0]	w_pma_adapt_dfe_fxtap6;
	wire		w_pma_adapt_dfe_fxtap6_sgn;
	wire	[4:0]	w_pma_adapt_dfe_fxtap7;
	wire		w_pma_adapt_dfe_fxtap7_sgn;
	wire		w_pma_adapt_dfe_spec_disable;
	wire		w_pma_adapt_dfe_spec_sign_sel;
	wire		w_pma_adapt_dfe_vref_sign_sel;
	wire	[4:0]	w_pma_adapt_odi_vref;
	wire	[6:0]	w_pma_adapt_vga_sel;
	wire	[4:0]	w_pma_adapt_vref_sel;
	
	// wires for module twentynm_hssi_pma_rx_odi
	wire	[7:0]	w_pma_rx_odi_avmmreaddata;
	wire		w_pma_rx_odi_blockselect;
	wire		w_pma_rx_odi_clk0_eye;
	wire		w_pma_rx_odi_clk0_eye_lb;
	wire		w_pma_rx_odi_clk180_eye;
	wire		w_pma_rx_odi_clk180_eye_lb;
	wire		w_pma_rx_odi_de_eye;
	wire		w_pma_rx_odi_deb_eye;
	wire		w_pma_rx_odi_do_eye;
	wire		w_pma_rx_odi_dob_eye;
	wire		w_pma_rx_odi_odi_en;
	wire	[1:0]	w_pma_rx_odi_odi_oc_tstmx;
	
	// wires for module twentynm_hssi_pma_channel_pll
	wire	[7:0]	w_cdr_pll_avmmreaddata;
	wire		w_cdr_pll_blockselect;
	wire		w_cdr_pll_cdr_cnt_done;
	wire	[11:0]	w_cdr_pll_cdr_refclk_cal_out;
	wire	[11:0]	w_cdr_pll_cdr_vco_cal_out;
	wire		w_cdr_pll_clk0_des;
	wire		w_cdr_pll_clk0_odi;
	wire		w_cdr_pll_clk0_pd;
	wire		w_cdr_pll_clk0_pfd;
	wire		w_cdr_pll_clk180_des;
	wire		w_cdr_pll_clk180_odi;
	wire		w_cdr_pll_clk180_pd;
	wire		w_cdr_pll_clk180_pfd;
	wire		w_cdr_pll_clk270_odi;
	wire		w_cdr_pll_clk270_pd;
	wire		w_cdr_pll_clk90_odi;
	wire		w_cdr_pll_clk90_pd;
	wire		w_cdr_pll_clklow;
	wire		w_cdr_pll_deven_des;
	wire		w_cdr_pll_devenb_des;
	wire		w_cdr_pll_dodd_des;
	wire		w_cdr_pll_doddb_des;
	wire		w_cdr_pll_error_even_des;
	wire		w_cdr_pll_error_evenb_des;
	wire		w_cdr_pll_error_odd_des;
	wire		w_cdr_pll_error_oddb_des;
	wire		w_cdr_pll_fref;
	wire		w_cdr_pll_overrange;
	wire		w_cdr_pll_pfdmode_lock;
	wire		w_cdr_pll_rlpbkdn;
	wire		w_cdr_pll_rlpbkdp;
	wire		w_cdr_pll_rlpbkn;
	wire		w_cdr_pll_rlpbkp;
	wire		w_cdr_pll_rxpll_lock;
	wire		w_cdr_pll_tx_rlpbk;
	wire		w_cdr_pll_underrange;
	
	// wires for module twentynm_hssi_pma_rx_buf
	wire	[7:0]	w_pma_rx_buf_avmmreaddata;
	wire		w_pma_rx_buf_blockselect;
	wire		w_pma_rx_buf_inn;
	wire		w_pma_rx_buf_inp;
	wire		w_pma_rx_buf_outn;
	wire		w_pma_rx_buf_outp;
	wire		w_pma_rx_buf_pull_dn;
	wire		w_pma_rx_buf_rdlpbkn;
	wire		w_pma_rx_buf_rdlpbkp;
	
	
	generate
		
		//module instantiations
		
		// instantiating twentynm_hssi_pma_adaptation
		if ((xcvr_native_mode == "mode_rx_only") || (xcvr_native_mode == "mode_duplex")) begin:gen_twentynm_hssi_pma_adaptation
			twentynm_hssi_pma_adaptation #(
				.adapt_mode(pma_adapt_adapt_mode),
				.adp_1s_ctle_bypass(pma_adapt_adp_1s_ctle_bypass),
				.adp_4s_ctle_bypass(pma_adapt_adp_4s_ctle_bypass),
				.adp_ctle_adapt_cycle_window(pma_adapt_adp_ctle_adapt_cycle_window),
				.adp_ctle_en(pma_adapt_adp_ctle_en),
				.adp_dfe_fltap_bypass(pma_adapt_adp_dfe_fltap_bypass),
				.adp_dfe_fltap_en(pma_adapt_adp_dfe_fltap_en),
				.adp_dfe_fxtap_bypass(pma_adapt_adp_dfe_fxtap_bypass),
				.adp_dfe_fxtap_en(pma_adapt_adp_dfe_fxtap_en),
				.adp_dfe_fxtap_hold_en(pma_adapt_adp_dfe_fxtap_hold_en),
				.adp_dfe_mode(pma_adapt_adp_dfe_mode),
				.adp_mode(pma_adapt_adp_mode),
				.adp_onetime_dfe(pma_adapt_adp_onetime_dfe),
				.adp_vga_bypass(pma_adapt_adp_vga_bypass),
				.adp_vga_en(pma_adapt_adp_vga_en),
				.adp_vref_bypass(pma_adapt_adp_vref_bypass),
				.adp_vref_en(pma_adapt_adp_vref_en),
				.datarate(pma_adapt_datarate),
				.initial_settings("true"),       //PARAM_HIDE
				.odi_dfe_spec_en(pma_adapt_odi_dfe_spec_en),
				.optimal("false"),       //PARAM_HIDE
				.prot_mode(pma_adapt_prot_mode),
				.silicon_rev( "20nm2" ),       //PARAM_HIDE
				.sup_mode(pma_adapt_sup_mode)
			) inst_twentynm_hssi_pma_adaptation (
				// OUTPUTS
				.avmmreaddata(w_pma_adapt_avmmreaddata),
				.blockselect(w_pma_adapt_blockselect),
				.ctle_acgain_4s(w_pma_adapt_ctle_acgain_4s),
				.ctle_eqz_1s_sel(w_pma_adapt_ctle_eqz_1s_sel),
				.ctle_lfeq_fb_sel(w_pma_adapt_ctle_lfeq_fb_sel),
				.dfe_adapt_en(w_pma_adapt_dfe_adapt_en),
				.dfe_adp_clk(w_pma_adapt_dfe_adp_clk),
				.dfe_fltap1(w_pma_adapt_dfe_fltap1),
				.dfe_fltap1_sgn(w_pma_adapt_dfe_fltap1_sgn),
				.dfe_fltap2(w_pma_adapt_dfe_fltap2),
				.dfe_fltap2_sgn(w_pma_adapt_dfe_fltap2_sgn),
				.dfe_fltap3(w_pma_adapt_dfe_fltap3),
				.dfe_fltap3_sgn(w_pma_adapt_dfe_fltap3_sgn),
				.dfe_fltap4(w_pma_adapt_dfe_fltap4),
				.dfe_fltap4_sgn(w_pma_adapt_dfe_fltap4_sgn),
				.dfe_fltap_bypdeser(w_pma_adapt_dfe_fltap_bypdeser),
				.dfe_fltap_position(w_pma_adapt_dfe_fltap_position),
				.dfe_fxtap1(w_pma_adapt_dfe_fxtap1),
				.dfe_fxtap2(w_pma_adapt_dfe_fxtap2),
				.dfe_fxtap2_sgn(w_pma_adapt_dfe_fxtap2_sgn),
				.dfe_fxtap3(w_pma_adapt_dfe_fxtap3),
				.dfe_fxtap3_sgn(w_pma_adapt_dfe_fxtap3_sgn),
				.dfe_fxtap4(w_pma_adapt_dfe_fxtap4),
				.dfe_fxtap4_sgn(w_pma_adapt_dfe_fxtap4_sgn),
				.dfe_fxtap5(w_pma_adapt_dfe_fxtap5),
				.dfe_fxtap5_sgn(w_pma_adapt_dfe_fxtap5_sgn),
				.dfe_fxtap6(w_pma_adapt_dfe_fxtap6),
				.dfe_fxtap6_sgn(w_pma_adapt_dfe_fxtap6_sgn),
				.dfe_fxtap7(w_pma_adapt_dfe_fxtap7),
				.dfe_fxtap7_sgn(w_pma_adapt_dfe_fxtap7_sgn),
				.dfe_spec_disable(w_pma_adapt_dfe_spec_disable),
				.dfe_spec_sign_sel(w_pma_adapt_dfe_spec_sign_sel),
				.dfe_vref_sign_sel(w_pma_adapt_dfe_vref_sign_sel),
				.odi_vref(w_pma_adapt_odi_vref),
				.vga_sel(w_pma_adapt_vga_sel),
				.vref_sel(w_pma_adapt_vref_sel),
				// INPUTS
				.adapt_reset(in_pma_reserved_out[4]),
				.adapt_start(in_adapt_start),
				.avmmaddress({in_avmmaddress[8], in_avmmaddress[7], in_avmmaddress[6], in_avmmaddress[5], in_avmmaddress[4], in_avmmaddress[3], in_avmmaddress[2], in_avmmaddress[1], in_avmmaddress[0]}),
				.avmmclk(in_avmmclk),
				.avmmread(in_avmmread),
				.avmmrstn(in_avmmrstn),
				.avmmwrite(in_avmmwrite),
				.avmmwritedata({in_avmmwritedata[7], in_avmmwritedata[6], in_avmmwritedata[5], in_avmmwritedata[4], in_avmmwritedata[3], in_avmmwritedata[2], in_avmmwritedata[1], in_avmmwritedata[0]}),
				.deser_clk(w_pma_rx_deser_adapt_clk),
				.deser_data({w_pma_rx_deser_data[63], w_pma_rx_deser_data[62], w_pma_rx_deser_data[61], w_pma_rx_deser_data[60], w_pma_rx_deser_data[59], w_pma_rx_deser_data[58], w_pma_rx_deser_data[57], w_pma_rx_deser_data[56], w_pma_rx_deser_data[55], w_pma_rx_deser_data[54], w_pma_rx_deser_data[53], w_pma_rx_deser_data[52], w_pma_rx_deser_data[51], w_pma_rx_deser_data[50], w_pma_rx_deser_data[49], w_pma_rx_deser_data[48], w_pma_rx_deser_data[47], w_pma_rx_deser_data[46], w_pma_rx_deser_data[45], w_pma_rx_deser_data[44], w_pma_rx_deser_data[43], w_pma_rx_deser_data[42], w_pma_rx_deser_data[41], w_pma_rx_deser_data[40], w_pma_rx_deser_data[39], w_pma_rx_deser_data[38], w_pma_rx_deser_data[37], w_pma_rx_deser_data[36], w_pma_rx_deser_data[35], w_pma_rx_deser_data[34], w_pma_rx_deser_data[33], w_pma_rx_deser_data[32], w_pma_rx_deser_data[31], w_pma_rx_deser_data[30], w_pma_rx_deser_data[29], w_pma_rx_deser_data[28], w_pma_rx_deser_data[27], w_pma_rx_deser_data[26], w_pma_rx_deser_data[25], w_pma_rx_deser_data[24], w_pma_rx_deser_data[23], w_pma_rx_deser_data[22], w_pma_rx_deser_data[21], w_pma_rx_deser_data[20], w_pma_rx_deser_data[19], w_pma_rx_deser_data[18], w_pma_rx_deser_data[17], w_pma_rx_deser_data[16], w_pma_rx_deser_data[15], w_pma_rx_deser_data[14], w_pma_rx_deser_data[13], w_pma_rx_deser_data[12], w_pma_rx_deser_data[11], w_pma_rx_deser_data[10], w_pma_rx_deser_data[9], w_pma_rx_deser_data[8], w_pma_rx_deser_data[7], w_pma_rx_deser_data[6], w_pma_rx_deser_data[5], w_pma_rx_deser_data[4], w_pma_rx_deser_data[3], w_pma_rx_deser_data[2], w_pma_rx_deser_data[1], w_pma_rx_deser_data[0]}),
				.deser_error({w_pma_rx_deser_error_deser[63], w_pma_rx_deser_error_deser[62], w_pma_rx_deser_error_deser[61], w_pma_rx_deser_error_deser[60], w_pma_rx_deser_error_deser[59], w_pma_rx_deser_error_deser[58], w_pma_rx_deser_error_deser[57], w_pma_rx_deser_error_deser[56], w_pma_rx_deser_error_deser[55], w_pma_rx_deser_error_deser[54], w_pma_rx_deser_error_deser[53], w_pma_rx_deser_error_deser[52], w_pma_rx_deser_error_deser[51], w_pma_rx_deser_error_deser[50], w_pma_rx_deser_error_deser[49], w_pma_rx_deser_error_deser[48], w_pma_rx_deser_error_deser[47], w_pma_rx_deser_error_deser[46], w_pma_rx_deser_error_deser[45], w_pma_rx_deser_error_deser[44], w_pma_rx_deser_error_deser[43], w_pma_rx_deser_error_deser[42], w_pma_rx_deser_error_deser[41], w_pma_rx_deser_error_deser[40], w_pma_rx_deser_error_deser[39], w_pma_rx_deser_error_deser[38], w_pma_rx_deser_error_deser[37], w_pma_rx_deser_error_deser[36], w_pma_rx_deser_error_deser[35], w_pma_rx_deser_error_deser[34], w_pma_rx_deser_error_deser[33], w_pma_rx_deser_error_deser[32], w_pma_rx_deser_error_deser[31], w_pma_rx_deser_error_deser[30], w_pma_rx_deser_error_deser[29], w_pma_rx_deser_error_deser[28], w_pma_rx_deser_error_deser[27], w_pma_rx_deser_error_deser[26], w_pma_rx_deser_error_deser[25], w_pma_rx_deser_error_deser[24], w_pma_rx_deser_error_deser[23], w_pma_rx_deser_error_deser[22], w_pma_rx_deser_error_deser[21], w_pma_rx_deser_error_deser[20], w_pma_rx_deser_error_deser[19], w_pma_rx_deser_error_deser[18], w_pma_rx_deser_error_deser[17], w_pma_rx_deser_error_deser[16], w_pma_rx_deser_error_deser[15], w_pma_rx_deser_error_deser[14], w_pma_rx_deser_error_deser[13], w_pma_rx_deser_error_deser[12], w_pma_rx_deser_error_deser[11], w_pma_rx_deser_error_deser[10], w_pma_rx_deser_error_deser[9], w_pma_rx_deser_error_deser[8], w_pma_rx_deser_error_deser[7], w_pma_rx_deser_error_deser[6], w_pma_rx_deser_error_deser[5], w_pma_rx_deser_error_deser[4], w_pma_rx_deser_error_deser[3], w_pma_rx_deser_error_deser[2], w_pma_rx_deser_error_deser[1], w_pma_rx_deser_error_deser[0]}),
				.deser_odi({w_pma_rx_deser_odi_dout[63], w_pma_rx_deser_odi_dout[62], w_pma_rx_deser_odi_dout[61], w_pma_rx_deser_odi_dout[60], w_pma_rx_deser_odi_dout[59], w_pma_rx_deser_odi_dout[58], w_pma_rx_deser_odi_dout[57], w_pma_rx_deser_odi_dout[56], w_pma_rx_deser_odi_dout[55], w_pma_rx_deser_odi_dout[54], w_pma_rx_deser_odi_dout[53], w_pma_rx_deser_odi_dout[52], w_pma_rx_deser_odi_dout[51], w_pma_rx_deser_odi_dout[50], w_pma_rx_deser_odi_dout[49], w_pma_rx_deser_odi_dout[48], w_pma_rx_deser_odi_dout[47], w_pma_rx_deser_odi_dout[46], w_pma_rx_deser_odi_dout[45], w_pma_rx_deser_odi_dout[44], w_pma_rx_deser_odi_dout[43], w_pma_rx_deser_odi_dout[42], w_pma_rx_deser_odi_dout[41], w_pma_rx_deser_odi_dout[40], w_pma_rx_deser_odi_dout[39], w_pma_rx_deser_odi_dout[38], w_pma_rx_deser_odi_dout[37], w_pma_rx_deser_odi_dout[36], w_pma_rx_deser_odi_dout[35], w_pma_rx_deser_odi_dout[34], w_pma_rx_deser_odi_dout[33], w_pma_rx_deser_odi_dout[32], w_pma_rx_deser_odi_dout[31], w_pma_rx_deser_odi_dout[30], w_pma_rx_deser_odi_dout[29], w_pma_rx_deser_odi_dout[28], w_pma_rx_deser_odi_dout[27], w_pma_rx_deser_odi_dout[26], w_pma_rx_deser_odi_dout[25], w_pma_rx_deser_odi_dout[24], w_pma_rx_deser_odi_dout[23], w_pma_rx_deser_odi_dout[22], w_pma_rx_deser_odi_dout[21], w_pma_rx_deser_odi_dout[20], w_pma_rx_deser_odi_dout[19], w_pma_rx_deser_odi_dout[18], w_pma_rx_deser_odi_dout[17], w_pma_rx_deser_odi_dout[16], w_pma_rx_deser_odi_dout[15], w_pma_rx_deser_odi_dout[14], w_pma_rx_deser_odi_dout[13], w_pma_rx_deser_odi_dout[12], w_pma_rx_deser_odi_dout[11], w_pma_rx_deser_odi_dout[10], w_pma_rx_deser_odi_dout[9], w_pma_rx_deser_odi_dout[8], w_pma_rx_deser_odi_dout[7], w_pma_rx_deser_odi_dout[6], w_pma_rx_deser_odi_dout[5], w_pma_rx_deser_odi_dout[4], w_pma_rx_deser_odi_dout[3], w_pma_rx_deser_odi_dout[2], w_pma_rx_deser_odi_dout[1], w_pma_rx_deser_odi_dout[0]}),
				.deser_odi_clk(1'b0),
				.global_pipe_se(in_pma_atpg_los_en_n_in),
				.i_rxpreset({in_i_rxpreset[2], in_i_rxpreset[1], in_i_rxpreset[0]}),
				.rx_pllfreqlock(w_cdr_pll_rxpll_lock),
				.scan_clk(in_core_refclk_in),
				.scan_in({in_pma_reserved_out[3], in_pma_reserved_out[2], in_pma_reserved_out[1], in_pma_reserved_out[0], in_eye_monitor[5], in_eye_monitor[4], in_eye_monitor[3], in_eye_monitor[2], in_eye_monitor[1], in_eye_monitor[0]}),
				.test_mode(in_scan_mode_n),
				.test_se(in_scan_shift_n),
				
				// UNUSED
				.radp_ctle_hold_en(),
				.radp_ctle_patt_en(),
				.radp_ctle_preset_sel(),
				.radp_enable_max_lfeq_scale(),
				.radp_lfeq_hold_en(),
				.radp_vga_polarity(),
				.scan_out(),
				.status_bus()
			);
		end // if generate
		else begin
				assign w_pma_adapt_avmmreaddata[7:0] = 8'b0;
				assign w_pma_adapt_blockselect = 1'b0;
				assign w_pma_adapt_ctle_acgain_4s[27:0] = 28'b0;
				assign w_pma_adapt_ctle_eqz_1s_sel[14:0] = 15'b0;
				assign w_pma_adapt_ctle_lfeq_fb_sel[6:0] = 7'b0;
				assign w_pma_adapt_dfe_adapt_en = 1'b0;
				assign w_pma_adapt_dfe_adp_clk = 1'b0;
				assign w_pma_adapt_dfe_fltap1[5:0] = 6'b0;
				assign w_pma_adapt_dfe_fltap1_sgn = 1'b0;
				assign w_pma_adapt_dfe_fltap2[5:0] = 6'b0;
				assign w_pma_adapt_dfe_fltap2_sgn = 1'b0;
				assign w_pma_adapt_dfe_fltap3[5:0] = 6'b0;
				assign w_pma_adapt_dfe_fltap3_sgn = 1'b0;
				assign w_pma_adapt_dfe_fltap4[5:0] = 6'b0;
				assign w_pma_adapt_dfe_fltap4_sgn = 1'b0;
				assign w_pma_adapt_dfe_fltap_bypdeser = 1'b0;
				assign w_pma_adapt_dfe_fltap_position[5:0] = 6'b0;
				assign w_pma_adapt_dfe_fxtap1[6:0] = 7'b0;
				assign w_pma_adapt_dfe_fxtap2[6:0] = 7'b0;
				assign w_pma_adapt_dfe_fxtap2_sgn = 1'b0;
				assign w_pma_adapt_dfe_fxtap3[6:0] = 7'b0;
				assign w_pma_adapt_dfe_fxtap3_sgn = 1'b0;
				assign w_pma_adapt_dfe_fxtap4[5:0] = 6'b0;
				assign w_pma_adapt_dfe_fxtap4_sgn = 1'b0;
				assign w_pma_adapt_dfe_fxtap5[5:0] = 6'b0;
				assign w_pma_adapt_dfe_fxtap5_sgn = 1'b0;
				assign w_pma_adapt_dfe_fxtap6[4:0] = 5'b0;
				assign w_pma_adapt_dfe_fxtap6_sgn = 1'b0;
				assign w_pma_adapt_dfe_fxtap7[4:0] = 5'b0;
				assign w_pma_adapt_dfe_fxtap7_sgn = 1'b0;
				assign w_pma_adapt_dfe_spec_disable = 1'b0;
				assign w_pma_adapt_dfe_spec_sign_sel = 1'b0;
				assign w_pma_adapt_dfe_vref_sign_sel = 1'b0;
				assign w_pma_adapt_odi_vref[4:0] = 5'b0;
				assign w_pma_adapt_vga_sel[6:0] = 7'b0;
				assign w_pma_adapt_vref_sel[4:0] = 5'b0;
		end // if not generate
		
		// instantiating twentynm_hssi_pma_cdr_refclk_select_mux
		if ((xcvr_native_mode == "mode_rx_only") || (xcvr_native_mode == "mode_duplex")) begin:gen_twentynm_hssi_pma_cdr_refclk_select_mux
			twentynm_hssi_pma_cdr_refclk_select_mux #(
				.inclk0_logical_to_physical_mapping(pma_cdr_refclk_inclk0_logical_to_physical_mapping),
				.inclk1_logical_to_physical_mapping(pma_cdr_refclk_inclk1_logical_to_physical_mapping),
				.inclk2_logical_to_physical_mapping(pma_cdr_refclk_inclk2_logical_to_physical_mapping),
				.inclk3_logical_to_physical_mapping(pma_cdr_refclk_inclk3_logical_to_physical_mapping),
				.inclk4_logical_to_physical_mapping(pma_cdr_refclk_inclk4_logical_to_physical_mapping),
				.powerdown_mode(pma_cdr_refclk_powerdown_mode),
				.refclk_select(pma_cdr_refclk_refclk_select),
				.silicon_rev( "20nm2" )       //PARAM_HIDE
			) inst_twentynm_hssi_pma_cdr_refclk_select_mux (
				// OUTPUTS
				.avmmreaddata(w_pma_cdr_refclk_avmmreaddata),
				.blockselect(w_pma_cdr_refclk_blockselect),
				.refclk(w_pma_cdr_refclk_refclk),
				.rx_det_clk(w_pma_cdr_refclk_rx_det_clk),
				// INPUTS
				.avmmaddress({in_avmmaddress[8], in_avmmaddress[7], in_avmmaddress[6], in_avmmaddress[5], in_avmmaddress[4], in_avmmaddress[3], in_avmmaddress[2], in_avmmaddress[1], in_avmmaddress[0]}),
				.avmmclk(in_avmmclk),
				.avmmread(in_avmmread),
				.avmmrstn(in_avmmrstn),
				.avmmwrite(in_avmmwrite),
				.avmmwritedata({in_avmmwritedata[7], in_avmmwritedata[6], in_avmmwritedata[5], in_avmmwritedata[4], in_avmmwritedata[3], in_avmmwritedata[2], in_avmmwritedata[1], in_avmmwritedata[0]}),
				.core_refclk(in_core_refclk_in),
				.iqtxrxclk({in_iqtxrxclk[5], in_iqtxrxclk[4], in_iqtxrxclk[3], in_iqtxrxclk[2], in_iqtxrxclk[1], in_iqtxrxclk[0]}),
				.ref_iqclk({in_ref_iqclk[11], in_ref_iqclk[10], in_ref_iqclk[9], in_ref_iqclk[8], in_ref_iqclk[7], in_ref_iqclk[6], in_ref_iqclk[5], in_ref_iqclk[4], in_ref_iqclk[3], in_ref_iqclk[2], in_ref_iqclk[1], in_ref_iqclk[0]})
			);
		end // if generate
		else begin
				assign w_pma_cdr_refclk_avmmreaddata[7:0] = 8'b0;
				assign w_pma_cdr_refclk_blockselect = 1'b0;
				assign w_pma_cdr_refclk_refclk = 1'b0;
				assign w_pma_cdr_refclk_rx_det_clk = 1'b0;
		end // if not generate
		
		// instantiating twentynm_hssi_pma_channel_pll
		if ((xcvr_native_mode == "mode_rx_only") || (xcvr_native_mode == "mode_duplex")) begin:gen_twentynm_hssi_pma_channel_pll
			twentynm_hssi_pma_channel_pll #(
				.atb_select_control(cdr_pll_atb_select_control),
				.auto_reset_on(cdr_pll_auto_reset_on),
				.bbpd_data_pattern_filter_select(cdr_pll_bbpd_data_pattern_filter_select),
				.bw_sel(cdr_pll_bw_sel),
				.cal_vco_count_length(cdr_pll_cal_vco_count_length),
				.cdr_odi_select(cdr_pll_cdr_odi_select),
				.cdr_phaselock_mode(cdr_pll_cdr_phaselock_mode),
				.cdr_powerdown_mode(cdr_pll_cdr_powerdown_mode),
				.cgb_div(cdr_pll_cgb_div),
				.chgpmp_current_dn_pd(cdr_pll_chgpmp_current_dn_pd),
				.chgpmp_current_dn_trim(cdr_pll_chgpmp_current_dn_trim),
				.chgpmp_current_pd(cdr_pll_chgpmp_current_pd),
				.chgpmp_current_pfd(cdr_pll_chgpmp_current_pfd),
				.chgpmp_current_up_pd(cdr_pll_chgpmp_current_up_pd),
				.chgpmp_current_up_trim(cdr_pll_chgpmp_current_up_trim),
				.chgpmp_dn_pd_trim_double(cdr_pll_chgpmp_dn_pd_trim_double),
				.chgpmp_replicate(cdr_pll_chgpmp_replicate),
				.chgpmp_testmode(cdr_pll_chgpmp_testmode),
				.chgpmp_up_pd_trim_double(cdr_pll_chgpmp_up_pd_trim_double),
				.clklow_mux_select(cdr_pll_clklow_mux_select),
				.datarate(cdr_pll_datarate),
				.diag_loopback_enable(cdr_pll_diag_loopback_enable),
				.disable_up_dn(cdr_pll_disable_up_dn),
				.fb_select(cdr_pll_fb_select),
				.fref_clklow_div(cdr_pll_fref_clklow_div),
				.fref_mux_select(cdr_pll_fref_mux_select),
				.gpon_lck2ref_control(cdr_pll_gpon_lck2ref_control),
				.initial_settings(cdr_pll_initial_settings),
				.iqclk_mux_sel(cdr_pll_iqclk_mux_sel),
				.is_cascaded_pll(cdr_pll_is_cascaded_pll),
				.lck2ref_delay_control(cdr_pll_lck2ref_delay_control),
				.lf_resistor_pd(cdr_pll_lf_resistor_pd),
				.lf_resistor_pfd(cdr_pll_lf_resistor_pfd),
				.lf_ripple_cap(cdr_pll_lf_ripple_cap),
				.loop_filter_bias_select(cdr_pll_loop_filter_bias_select),
				.loopback_mode(cdr_pll_loopback_mode),
				.lpd_counter(cdr_pll_lpd_counter),
				.lpfd_counter(cdr_pll_lpfd_counter),
				.ltd_ltr_micro_controller_select(cdr_pll_ltd_ltr_micro_controller_select),
				.m_counter(cdr_pll_m_counter),
				.n_counter(cdr_pll_n_counter),
				.n_counter_scratch(cdr_pll_n_counter_scratch),
				.optimal("false"),       //PARAM_HIDE
				.output_clock_frequency(cdr_pll_output_clock_frequency),
				.pcie_gen(cdr_pll_pcie_gen),
				.pd_fastlock_mode(cdr_pll_pd_fastlock_mode),
				.pd_l_counter(cdr_pll_pd_l_counter),
				.pfd_l_counter(cdr_pll_pfd_l_counter),
				.pma_width(cdr_pll_pma_width),
				.primary_use(cdr_pll_primary_use),
				.prot_mode(cdr_pll_prot_mode),
				.reference_clock_frequency(cdr_pll_reference_clock_frequency),
				.reverse_serial_loopback(cdr_pll_reverse_serial_loopback),
				.set_cdr_input_freq_range(cdr_pll_set_cdr_input_freq_range),
				.set_cdr_v2i_enable(cdr_pll_set_cdr_v2i_enable),
				.set_cdr_vco_reset(cdr_pll_set_cdr_vco_reset),
				.set_cdr_vco_speed(cdr_pll_set_cdr_vco_speed),
				.set_cdr_vco_speed_fix(cdr_pll_set_cdr_vco_speed_fix),
				.set_cdr_vco_speed_pciegen3(cdr_pll_set_cdr_vco_speed_pciegen3),
				.silicon_rev( "20nm2" ),       //PARAM_HIDE
				.sup_mode(cdr_pll_sup_mode),
				.tx_pll_prot_mode(cdr_pll_tx_pll_prot_mode),
				.txpll_hclk_driver_enable(cdr_pll_txpll_hclk_driver_enable),
				.uc_ro_cal(cdr_pll_uc_ro_cal),
				.vco_freq(cdr_pll_vco_freq),
				.vco_overrange_voltage(cdr_pll_vco_overrange_voltage),
				.vco_underrange_voltage(cdr_pll_vco_underrange_voltage)
			) inst_twentynm_hssi_pma_channel_pll (
				// OUTPUTS
				.avmmreaddata(w_cdr_pll_avmmreaddata),
				.blockselect(w_cdr_pll_blockselect),
				.cdr_cnt_done(w_cdr_pll_cdr_cnt_done),
				.cdr_refclk_cal_out(w_cdr_pll_cdr_refclk_cal_out),
				.cdr_vco_cal_out(w_cdr_pll_cdr_vco_cal_out),
				.clk0_des(w_cdr_pll_clk0_des),
				.clk0_odi(w_cdr_pll_clk0_odi),
				.clk0_pd(w_cdr_pll_clk0_pd),
				.clk0_pfd(w_cdr_pll_clk0_pfd),
				.clk180_des(w_cdr_pll_clk180_des),
				.clk180_odi(w_cdr_pll_clk180_odi),
				.clk180_pd(w_cdr_pll_clk180_pd),
				.clk180_pfd(w_cdr_pll_clk180_pfd),
				.clk270_odi(w_cdr_pll_clk270_odi),
				.clk270_pd(w_cdr_pll_clk270_pd),
				.clk90_odi(w_cdr_pll_clk90_odi),
				.clk90_pd(w_cdr_pll_clk90_pd),
				.clklow(w_cdr_pll_clklow),
				.deven_des(w_cdr_pll_deven_des),
				.devenb_des(w_cdr_pll_devenb_des),
				.dodd_des(w_cdr_pll_dodd_des),
				.doddb_des(w_cdr_pll_doddb_des),
				.error_even_des(w_cdr_pll_error_even_des),
				.error_evenb_des(w_cdr_pll_error_evenb_des),
				.error_odd_des(w_cdr_pll_error_odd_des),
				.error_oddb_des(w_cdr_pll_error_oddb_des),
				.fref(w_cdr_pll_fref),
				.overrange(w_cdr_pll_overrange),
				.pfdmode_lock(w_cdr_pll_pfdmode_lock),
				.rlpbkdn(w_cdr_pll_rlpbkdn),
				.rlpbkdp(w_cdr_pll_rlpbkdp),
				.rlpbkn(w_cdr_pll_rlpbkn),
				.rlpbkp(w_cdr_pll_rlpbkp),
				.rxpll_lock(w_cdr_pll_rxpll_lock),
				.tx_rlpbk(w_cdr_pll_tx_rlpbk),
				.underrange(w_cdr_pll_underrange),
				// INPUTS
				.adapt_en(w_pma_adapt_dfe_adapt_en),
				.avmmaddress({in_avmmaddress[8], in_avmmaddress[7], in_avmmaddress[6], in_avmmaddress[5], in_avmmaddress[4], in_avmmaddress[3], in_avmmaddress[2], in_avmmaddress[1], in_avmmaddress[0]}),
				.avmmclk(in_avmmclk),
				.avmmread(in_avmmread),
				.avmmrstn(in_avmmrstn),
				.avmmwrite(in_avmmwrite),
				.avmmwritedata({in_avmmwritedata[7], in_avmmwritedata[6], in_avmmwritedata[5], in_avmmwritedata[4], in_avmmwritedata[3], in_avmmwritedata[2], in_avmmwritedata[1], in_avmmwritedata[0]}),
				.clk0_bbpd(w_pma_rx_dfe_clk0_bbpd),
				.clk180_bbpd(w_pma_rx_dfe_clk180_bbpd),
				.clk270_bbpd(w_pma_rx_dfe_clk270_bbpd),
				.clk90_bbpd(w_pma_rx_dfe_clk90_bbpd),
				.deven(w_pma_rx_dfe_deven),
				.devenb(w_pma_rx_dfe_devenb),
				.dfe_test(1'b0),
				.dodd(w_pma_rx_dfe_dodd),
				.doddb(w_pma_rx_dfe_doddb),
				.e270(w_pma_rx_dfe_edge270),
				.e270b(w_pma_rx_dfe_edge270b),
				.e90(w_pma_rx_dfe_edge90),
				.e90b(w_pma_rx_dfe_edge90b),
				.early_eios(in_early_eios),
				.error_even(w_pma_rx_dfe_err_ev),
				.error_evenb(w_pma_rx_dfe_err_evb),
				.error_odd(w_pma_rx_dfe_err_od),
				.error_oddb(w_pma_rx_dfe_err_odb),
				.fpll_test0(in_fpll_ppm_clk_in[0]),
				.fpll_test1(in_fpll_ppm_clk_in[1]),
				.iqtxrxclk({in_iqtxrxclk[5], in_iqtxrxclk[4], in_iqtxrxclk[3], in_iqtxrxclk[2], in_iqtxrxclk[1], in_iqtxrxclk[0]}),
				.ltd_b(in_ltd_b),
				.ltr(in_ltr),
				.odi_clk(w_pma_rx_odi_clk0_eye_lb),
				.odi_clkb(w_pma_rx_odi_clk180_eye_lb),
				.pcie_sw_ret({w_pma_rx_deser_pcie_sw_ret[1], w_pma_rx_deser_pcie_sw_ret[0]}),
				.ppm_lock(in_ppm_lock),
				.refclk(w_pma_cdr_refclk_refclk),
				.rst_n(in_rx_pma_rstb),
				.rx_deser_pclk_test(w_pma_rx_deser_clkdivrx_rx),
				.rx_lpbkn(w_pma_rx_buf_rdlpbkn),
				.rx_lpbkp(w_pma_rx_buf_rdlpbkp),
				.rxp(in_rx_p),
				.sd(w_pma_rx_sd_sd),
				.tx_ser_pclk_test(w_pma_tx_ser_clk_divtx),
				
				// UNUSED
				.atbsel(),
				.cdr_lpbkdp(),
				.cdr_lpbkp(),
				.clk270_des(),
				.clk90_des(),
				.lock2ref(),
				.rx_signal_ok(),
				.von_lp(),
				.vop_lp()
			);
		end // if generate
		else begin
				assign w_cdr_pll_avmmreaddata[7:0] = 8'b0;
				assign w_cdr_pll_blockselect = 1'b0;
				assign w_cdr_pll_cdr_cnt_done = 1'b0;
				assign w_cdr_pll_cdr_refclk_cal_out[11:0] = 12'b0;
				assign w_cdr_pll_cdr_vco_cal_out[11:0] = 12'b0;
				assign w_cdr_pll_clk0_des = 1'b0;
				assign w_cdr_pll_clk0_odi = 1'b0;
				assign w_cdr_pll_clk0_pd = 1'b0;
				assign w_cdr_pll_clk0_pfd = 1'b0;
				assign w_cdr_pll_clk180_des = 1'b0;
				assign w_cdr_pll_clk180_odi = 1'b0;
				assign w_cdr_pll_clk180_pd = 1'b0;
				assign w_cdr_pll_clk180_pfd = 1'b0;
				assign w_cdr_pll_clk270_odi = 1'b0;
				assign w_cdr_pll_clk270_pd = 1'b0;
				assign w_cdr_pll_clk90_odi = 1'b0;
				assign w_cdr_pll_clk90_pd = 1'b0;
				assign w_cdr_pll_clklow = 1'b0;
				assign w_cdr_pll_deven_des = 1'b0;
				assign w_cdr_pll_devenb_des = 1'b0;
				assign w_cdr_pll_dodd_des = 1'b0;
				assign w_cdr_pll_doddb_des = 1'b0;
				assign w_cdr_pll_error_even_des = 1'b0;
				assign w_cdr_pll_error_evenb_des = 1'b0;
				assign w_cdr_pll_error_odd_des = 1'b0;
				assign w_cdr_pll_error_oddb_des = 1'b0;
				assign w_cdr_pll_fref = 1'b0;
				assign w_cdr_pll_overrange = 1'b0;
				assign w_cdr_pll_pfdmode_lock = 1'b0;
				assign w_cdr_pll_rlpbkdn = 1'b0;
				assign w_cdr_pll_rlpbkdp = 1'b0;
				assign w_cdr_pll_rlpbkn = 1'b0;
				assign w_cdr_pll_rlpbkp = 1'b0;
				assign w_cdr_pll_rxpll_lock = 1'b0;
				assign w_cdr_pll_tx_rlpbk = 1'b0;
				assign w_cdr_pll_underrange = 1'b0;
		end // if not generate
		
		// instantiating twentynm_hssi_pma_rx_buf
		if ((xcvr_native_mode == "mode_rx_only") || (xcvr_native_mode == "mode_duplex")) begin:gen_twentynm_hssi_pma_rx_buf
			twentynm_hssi_pma_rx_buf #(
				.bypass_eqz_stages_234(pma_rx_buf_bypass_eqz_stages_234),
				.datarate(pma_rx_buf_datarate),
				.diag_lp_en(pma_rx_buf_diag_lp_en),
				.initial_settings("true"),       //PARAM_HIDE
				.loopback_modes(pma_rx_buf_loopback_modes),
				.optimal("false"),       //PARAM_HIDE
				.pdb_rx("normal_rx_on"),       //PARAM_HIDE
				.pm_tx_rx_cvp_mode(pma_rx_buf_pm_tx_rx_cvp_mode),
				.pm_tx_rx_pcie_gen(pma_rx_buf_pm_tx_rx_pcie_gen),
				.pm_tx_rx_pcie_gen_bitwidth(pma_rx_buf_pm_tx_rx_pcie_gen_bitwidth),
				.prot_mode(pma_rx_buf_prot_mode),
				.qpi_enable(pma_rx_buf_qpi_enable),
				.refclk_en(pma_rx_buf_refclk_en),
				.rx_refclk_divider(pma_rx_buf_rx_refclk_divider),
				.silicon_rev( "20nm2" ),       //PARAM_HIDE
				.sup_mode(pma_rx_buf_sup_mode),
				.xrx_path_datarate(pma_rx_buf_xrx_path_datarate),
				.xrx_path_datawidth(pma_rx_buf_xrx_path_datawidth),
				.xrx_path_initial_settings("true"),       //PARAM_HIDE
				.xrx_path_optimal("false"),       //PARAM_HIDE
				.xrx_path_pma_rx_divclk_hz(pma_rx_buf_xrx_path_pma_rx_divclk_hz),
				.xrx_path_prot_mode(pma_rx_buf_xrx_path_prot_mode),
				.xrx_path_sup_mode(pma_rx_buf_xrx_path_sup_mode),
				.xrx_path_uc_cal_enable(pma_rx_buf_xrx_path_uc_cal_enable)
			) inst_twentynm_hssi_pma_rx_buf (
				// OUTPUTS
				.avmmreaddata(w_pma_rx_buf_avmmreaddata),
				.blockselect(w_pma_rx_buf_blockselect),
				.inn(w_pma_rx_buf_inn),
				.inp(w_pma_rx_buf_inp),
				.outn(w_pma_rx_buf_outn),
				.outp(w_pma_rx_buf_outp),
				.pull_dn(w_pma_rx_buf_pull_dn),
				.rdlpbkn(w_pma_rx_buf_rdlpbkn),
				.rdlpbkp(w_pma_rx_buf_rdlpbkp),
				// INPUTS
				.avmmaddress({in_avmmaddress[8], in_avmmaddress[7], in_avmmaddress[6], in_avmmaddress[5], in_avmmaddress[4], in_avmmaddress[3], in_avmmaddress[2], in_avmmaddress[1], in_avmmaddress[0]}),
				.avmmclk(in_avmmclk),
				.avmmread(in_avmmread),
				.avmmrstn(in_avmmrstn),
				.avmmwrite(in_avmmwrite),
				.avmmwritedata({in_avmmwritedata[7], in_avmmwritedata[6], in_avmmwritedata[5], in_avmmwritedata[4], in_avmmwritedata[3], in_avmmwritedata[2], in_avmmwritedata[1], in_avmmwritedata[0]}),
				.clk_divrx(w_pma_rx_deser_clkdivrx_rx),
				.lpbkn(w_pma_tx_buf_lbvon),
				.lpbkp(w_pma_tx_buf_lbvop),
				.rx_qpi_pulldn(in_rx_qpi_pulldn),
				.rx_rstn(in_rx_pma_rstb),
				.rx_sel_b50({in_rx50_buf_in[5], in_rx50_buf_in[4], in_rx50_buf_in[3], in_rx50_buf_in[2], in_rx50_buf_in[1], in_rx50_buf_in[0]}),
				.rxn(in_rx_n),
				.rxp(in_rx_p),
				.s_lpbk_b(in_rs_lpbk_b),
				.vcz({w_pma_adapt_ctle_acgain_4s[27], w_pma_adapt_ctle_acgain_4s[26], w_pma_adapt_ctle_acgain_4s[25], w_pma_adapt_ctle_acgain_4s[24], w_pma_adapt_ctle_acgain_4s[23], w_pma_adapt_ctle_acgain_4s[22], w_pma_adapt_ctle_acgain_4s[21], w_pma_adapt_ctle_acgain_4s[20], w_pma_adapt_ctle_acgain_4s[19], w_pma_adapt_ctle_acgain_4s[18], w_pma_adapt_ctle_acgain_4s[17], w_pma_adapt_ctle_acgain_4s[16], w_pma_adapt_ctle_acgain_4s[15], w_pma_adapt_ctle_acgain_4s[14], w_pma_adapt_ctle_acgain_4s[13], w_pma_adapt_ctle_acgain_4s[12], w_pma_adapt_ctle_acgain_4s[11], w_pma_adapt_ctle_acgain_4s[10], w_pma_adapt_ctle_acgain_4s[9], w_pma_adapt_ctle_acgain_4s[8], w_pma_adapt_ctle_acgain_4s[7], w_pma_adapt_ctle_acgain_4s[6], w_pma_adapt_ctle_acgain_4s[5], w_pma_adapt_ctle_acgain_4s[4], w_pma_adapt_ctle_acgain_4s[3], w_pma_adapt_ctle_acgain_4s[2], w_pma_adapt_ctle_acgain_4s[1], w_pma_adapt_ctle_acgain_4s[0]}),
				.vds_eqz_s1_set({w_pma_adapt_ctle_eqz_1s_sel[14], w_pma_adapt_ctle_eqz_1s_sel[13], w_pma_adapt_ctle_eqz_1s_sel[12], w_pma_adapt_ctle_eqz_1s_sel[11], w_pma_adapt_ctle_eqz_1s_sel[10], w_pma_adapt_ctle_eqz_1s_sel[9], w_pma_adapt_ctle_eqz_1s_sel[8], w_pma_adapt_ctle_eqz_1s_sel[7], w_pma_adapt_ctle_eqz_1s_sel[6], w_pma_adapt_ctle_eqz_1s_sel[5], w_pma_adapt_ctle_eqz_1s_sel[4], w_pma_adapt_ctle_eqz_1s_sel[3], w_pma_adapt_ctle_eqz_1s_sel[2], w_pma_adapt_ctle_eqz_1s_sel[1], w_pma_adapt_ctle_eqz_1s_sel[0]}),
				.vds_lfeqz_czero({1'b0, 1'b0}),
				.vds_lfeqz_fb_set({w_pma_adapt_ctle_lfeq_fb_sel[6], w_pma_adapt_ctle_lfeq_fb_sel[5], w_pma_adapt_ctle_lfeq_fb_sel[4], w_pma_adapt_ctle_lfeq_fb_sel[3], w_pma_adapt_ctle_lfeq_fb_sel[2], w_pma_adapt_ctle_lfeq_fb_sel[1], w_pma_adapt_ctle_lfeq_fb_sel[0]}),
				.vds_vga_set({w_pma_adapt_vga_sel[6], w_pma_adapt_vga_sel[5], w_pma_adapt_vga_sel[4], w_pma_adapt_vga_sel[3], w_pma_adapt_vga_sel[2], w_pma_adapt_vga_sel[1], w_pma_adapt_vga_sel[0]}),
				
				// UNUSED
				.rx_refclk(),
				.vga_cm_bidir_in(),
				.vga_cm_bidir_out()
			);
		end // if generate
		else begin
				assign w_pma_rx_buf_avmmreaddata[7:0] = 8'b0;
				assign w_pma_rx_buf_blockselect = 1'b0;
				assign w_pma_rx_buf_inn = 1'b0;
				assign w_pma_rx_buf_inp = 1'b0;
				assign w_pma_rx_buf_outn = 1'b0;
				assign w_pma_rx_buf_outp = 1'b0;
				assign w_pma_rx_buf_pull_dn = 1'b0;
				assign w_pma_rx_buf_rdlpbkn = 1'b0;
				assign w_pma_rx_buf_rdlpbkp = 1'b0;
		end // if not generate
		
		// instantiating twentynm_hssi_pma_rx_deser
		if ((xcvr_native_mode == "mode_rx_only") || (xcvr_native_mode == "mode_duplex")) begin:gen_twentynm_hssi_pma_rx_deser
			twentynm_hssi_pma_rx_deser #(
				.bitslip_bypass(pma_rx_deser_bitslip_bypass),
				.clkdiv_source(pma_rx_deser_clkdiv_source),
				.clkdivrx_user_mode(pma_rx_deser_clkdivrx_user_mode),
				.datarate(pma_rx_deser_datarate),
				.deser_factor(pma_rx_deser_deser_factor),
				.deser_powerdown("deser_power_up"),       //PARAM_HIDE
				.force_clkdiv_for_testing(pma_rx_deser_force_clkdiv_for_testing),
				.optimal("false"),       //PARAM_HIDE
				.pcie_gen(pma_rx_deser_pcie_gen),
				.pcie_gen_bitwidth(pma_rx_deser_pcie_gen_bitwidth),
				.prot_mode(pma_rx_deser_prot_mode),
				.rst_n_adapt_odi(pma_rx_deser_rst_n_adapt_odi),
				.sdclk_enable(pma_rx_deser_sdclk_enable),
				.silicon_rev( "20nm2" ),       //PARAM_HIDE
				.sup_mode(pma_rx_deser_sup_mode),
				.tdr_mode("select_bbpd_data")       //PARAM_HIDE
			) inst_twentynm_hssi_pma_rx_deser (
				// OUTPUTS
				.adapt_clk(w_pma_rx_deser_adapt_clk),
				.avmmreaddata(w_pma_rx_deser_avmmreaddata),
				.blockselect(w_pma_rx_deser_blockselect),
				.clkdiv(w_pma_rx_deser_clkdiv),
				.clkdiv_user(w_pma_rx_deser_clkdiv_user),
				.clkdivrx_rx(w_pma_rx_deser_clkdivrx_rx),
				.data(w_pma_rx_deser_data),
				.dout(w_pma_rx_deser_dout),
				.error_deser(w_pma_rx_deser_error_deser),
				.odi_dout(w_pma_rx_deser_odi_dout),
				.pcie_sw_ret(w_pma_rx_deser_pcie_sw_ret),
				.tstmx_deser(w_pma_rx_deser_tstmx_deser),
				// INPUTS
				.adapt_en(w_pma_adapt_odi_vref[0]),
				.avmmaddress({in_avmmaddress[8], in_avmmaddress[7], in_avmmaddress[6], in_avmmaddress[5], in_avmmaddress[4], in_avmmaddress[3], in_avmmaddress[2], in_avmmaddress[1], in_avmmaddress[0]}),
				.avmmclk(in_avmmclk),
				.avmmread(in_avmmread),
				.avmmrstn(in_avmmrstn),
				.avmmwrite(in_avmmwrite),
				.avmmwritedata({in_avmmwritedata[7], in_avmmwritedata[6], in_avmmwritedata[5], in_avmmwritedata[4], in_avmmwritedata[3], in_avmmwritedata[2], in_avmmwritedata[1], in_avmmwritedata[0]}),
				.bitslip(in_rx_bitslip),
				.clk0(w_cdr_pll_clk0_des),
				.clk0_odi(w_pma_rx_odi_clk0_eye),
				.clk180(w_cdr_pll_clk180_des),
				.clk180_odi(w_pma_rx_odi_clk180_eye),
				.clklow(w_cdr_pll_clklow),
				.deven(w_cdr_pll_deven_des),
				.deven_odi(w_pma_rx_odi_de_eye),
				.devenb(w_cdr_pll_devenb_des),
				.devenb_odi(w_pma_rx_odi_deb_eye),
				.dodd(w_cdr_pll_dodd_des),
				.dodd_odi(w_pma_rx_odi_do_eye),
				.doddb(w_cdr_pll_doddb_des),
				.doddb_odi(w_pma_rx_odi_dob_eye),
				.error_even(w_cdr_pll_error_even_des),
				.error_evenb(w_cdr_pll_error_evenb_des),
				.error_odd(w_cdr_pll_error_odd_des),
				.error_oddb(w_cdr_pll_error_oddb_des),
				.fref(w_cdr_pll_fref),
				.odi_en(w_pma_rx_odi_odi_en),
				.pcie_sw({in_pcie_sw[1], in_pcie_sw[0]}),
				.pfdmode_lock(w_cdr_pll_pfdmode_lock),
				.rst_n(in_rx_pma_rstb),
				
				// UNUSED
				.clk270(),
				.clk90(),
				.odi_clkout(),
				.tdr_en()
			);
		end // if generate
		else begin
				assign w_pma_rx_deser_adapt_clk = 1'b0;
				assign w_pma_rx_deser_avmmreaddata[7:0] = 8'b0;
				assign w_pma_rx_deser_blockselect = 1'b0;
				assign w_pma_rx_deser_clkdiv = 1'b0;
				assign w_pma_rx_deser_clkdiv_user = 1'b0;
				assign w_pma_rx_deser_clkdivrx_rx = 1'b0;
				assign w_pma_rx_deser_data[63:0] = 64'b0;
				assign w_pma_rx_deser_dout[63:0] = 64'b0;
				assign w_pma_rx_deser_error_deser[63:0] = 64'b0;
				assign w_pma_rx_deser_odi_dout[63:0] = 64'b0;
				assign w_pma_rx_deser_pcie_sw_ret[1:0] = 2'b0;
				assign w_pma_rx_deser_tstmx_deser[7:0] = 8'b0;
		end // if not generate
		
		// instantiating twentynm_hssi_pma_rx_dfe
		if ((xcvr_native_mode == "mode_rx_only") || (xcvr_native_mode == "mode_duplex")) begin:gen_twentynm_hssi_pma_rx_dfe
			twentynm_hssi_pma_rx_dfe #(
				.datarate(pma_rx_dfe_datarate),
				.dft_en(pma_rx_dfe_dft_en),
				.initial_settings("true"),       //PARAM_HIDE
				.optimal("false"),       //PARAM_HIDE
				.pdb(pma_rx_dfe_pdb),
				.pdb_fixedtap(pma_rx_dfe_pdb_fixedtap),
				.pdb_floattap(pma_rx_dfe_pdb_floattap),
				.pdb_fxtap4t7(pma_rx_dfe_pdb_fxtap4t7),
				.prot_mode(pma_rx_dfe_prot_mode),
				.silicon_rev( "20nm2" ),       //PARAM_HIDE
				.sup_mode(pma_rx_dfe_sup_mode)
			) inst_twentynm_hssi_pma_rx_dfe (
				// OUTPUTS
				.avmmreaddata(w_pma_rx_dfe_avmmreaddata),
				.blockselect(w_pma_rx_dfe_blockselect),
				.clk0_bbpd(w_pma_rx_dfe_clk0_bbpd),
				.clk180_bbpd(w_pma_rx_dfe_clk180_bbpd),
				.clk270_bbpd(w_pma_rx_dfe_clk270_bbpd),
				.clk90_bbpd(w_pma_rx_dfe_clk90_bbpd),
				.deven(w_pma_rx_dfe_deven),
				.devenb(w_pma_rx_dfe_devenb),
				.dfe_oc_tstmx(w_pma_rx_dfe_dfe_oc_tstmx),
				.dodd(w_pma_rx_dfe_dodd),
				.doddb(w_pma_rx_dfe_doddb),
				.edge270(w_pma_rx_dfe_edge270),
				.edge270b(w_pma_rx_dfe_edge270b),
				.edge90(w_pma_rx_dfe_edge90),
				.edge90b(w_pma_rx_dfe_edge90b),
				.err_ev(w_pma_rx_dfe_err_ev),
				.err_evb(w_pma_rx_dfe_err_evb),
				.err_od(w_pma_rx_dfe_err_od),
				.err_odb(w_pma_rx_dfe_err_odb),
				.spec_vrefh(w_pma_rx_dfe_spec_vrefh),
				.spec_vrefl(w_pma_rx_dfe_spec_vrefl),
				// INPUTS
				.adapt_en(w_pma_adapt_dfe_adapt_en),
				.adp_clk(w_pma_adapt_dfe_adp_clk),
				.avmmaddress({in_avmmaddress[8], in_avmmaddress[7], in_avmmaddress[6], in_avmmaddress[5], in_avmmaddress[4], in_avmmaddress[3], in_avmmaddress[2], in_avmmaddress[1], in_avmmaddress[0]}),
				.avmmclk(in_avmmclk),
				.avmmread(in_avmmread),
				.avmmrstn(in_avmmrstn),
				.avmmwrite(in_avmmwrite),
				.avmmwritedata({in_avmmwritedata[7], in_avmmwritedata[6], in_avmmwritedata[5], in_avmmwritedata[4], in_avmmwritedata[3], in_avmmwritedata[2], in_avmmwritedata[1], in_avmmwritedata[0]}),
				.clk0(w_cdr_pll_clk0_pd),
				.clk180(w_cdr_pll_clk180_pd),
				.clk270(w_cdr_pll_clk270_pd),
				.clk90(w_cdr_pll_clk90_pd),
				.dfe_fltap1_coeff({w_pma_adapt_dfe_fltap1[5], w_pma_adapt_dfe_fltap1[4], w_pma_adapt_dfe_fltap1[3], w_pma_adapt_dfe_fltap1[2], w_pma_adapt_dfe_fltap1[1], w_pma_adapt_dfe_fltap1[0]}),
				.dfe_fltap1_sgn(w_pma_adapt_dfe_fltap1_sgn),
				.dfe_fltap2_coeff({w_pma_adapt_dfe_fltap2[5], w_pma_adapt_dfe_fltap2[4], w_pma_adapt_dfe_fltap2[3], w_pma_adapt_dfe_fltap2[2], w_pma_adapt_dfe_fltap2[1], w_pma_adapt_dfe_fltap2[0]}),
				.dfe_fltap2_sgn(w_pma_adapt_dfe_fltap2_sgn),
				.dfe_fltap3_coeff({w_pma_adapt_dfe_fltap3[5], w_pma_adapt_dfe_fltap3[4], w_pma_adapt_dfe_fltap3[3], w_pma_adapt_dfe_fltap3[2], w_pma_adapt_dfe_fltap3[1], w_pma_adapt_dfe_fltap3[0]}),
				.dfe_fltap3_sgn(w_pma_adapt_dfe_fltap3_sgn),
				.dfe_fltap4_coeff({w_pma_adapt_dfe_fltap4[5], w_pma_adapt_dfe_fltap4[4], w_pma_adapt_dfe_fltap4[3], w_pma_adapt_dfe_fltap4[2], w_pma_adapt_dfe_fltap4[1], w_pma_adapt_dfe_fltap4[0]}),
				.dfe_fltap4_sgn(w_pma_adapt_dfe_fltap4_sgn),
				.dfe_fltap_bypdeser(w_pma_adapt_dfe_fltap_bypdeser),
				.dfe_fltap_position({w_pma_adapt_dfe_fltap_position[5], w_pma_adapt_dfe_fltap_position[4], w_pma_adapt_dfe_fltap_position[3], w_pma_adapt_dfe_fltap_position[2], w_pma_adapt_dfe_fltap_position[1], w_pma_adapt_dfe_fltap_position[0]}),
				.dfe_fxtap1_coeff({w_pma_adapt_dfe_fxtap1[6], w_pma_adapt_dfe_fxtap1[5], w_pma_adapt_dfe_fxtap1[4], w_pma_adapt_dfe_fxtap1[3], w_pma_adapt_dfe_fxtap1[2], w_pma_adapt_dfe_fxtap1[1], w_pma_adapt_dfe_fxtap1[0]}),
				.dfe_fxtap2_coeff({w_pma_adapt_dfe_fxtap2[6], w_pma_adapt_dfe_fxtap2[5], w_pma_adapt_dfe_fxtap2[4], w_pma_adapt_dfe_fxtap2[3], w_pma_adapt_dfe_fxtap2[2], w_pma_adapt_dfe_fxtap2[1], w_pma_adapt_dfe_fxtap2[0]}),
				.dfe_fxtap2_sgn(w_pma_adapt_dfe_fxtap2_sgn),
				.dfe_fxtap3_coeff({w_pma_adapt_dfe_fxtap3[6], w_pma_adapt_dfe_fxtap3[5], w_pma_adapt_dfe_fxtap3[4], w_pma_adapt_dfe_fxtap3[3], w_pma_adapt_dfe_fxtap3[2], w_pma_adapt_dfe_fxtap3[1], w_pma_adapt_dfe_fxtap3[0]}),
				.dfe_fxtap3_sgn(w_pma_adapt_dfe_fxtap3_sgn),
				.dfe_fxtap4_coeff({w_pma_adapt_dfe_fxtap4[5], w_pma_adapt_dfe_fxtap4[4], w_pma_adapt_dfe_fxtap4[3], w_pma_adapt_dfe_fxtap4[2], w_pma_adapt_dfe_fxtap4[1], w_pma_adapt_dfe_fxtap4[0]}),
				.dfe_fxtap4_sgn(w_pma_adapt_dfe_fxtap4_sgn),
				.dfe_fxtap5_coeff({w_pma_adapt_dfe_fxtap5[5], w_pma_adapt_dfe_fxtap5[4], w_pma_adapt_dfe_fxtap5[3], w_pma_adapt_dfe_fxtap5[2], w_pma_adapt_dfe_fxtap5[1], w_pma_adapt_dfe_fxtap5[0]}),
				.dfe_fxtap5_sgn(w_pma_adapt_dfe_fxtap5_sgn),
				.dfe_fxtap6_coeff({w_pma_adapt_dfe_fxtap6[4], w_pma_adapt_dfe_fxtap6[3], w_pma_adapt_dfe_fxtap6[2], w_pma_adapt_dfe_fxtap6[1], w_pma_adapt_dfe_fxtap6[0]}),
				.dfe_fxtap6_sgn(w_pma_adapt_dfe_fxtap6_sgn),
				.dfe_fxtap7_coeff({w_pma_adapt_dfe_fxtap7[4], w_pma_adapt_dfe_fxtap7[3], w_pma_adapt_dfe_fxtap7[2], w_pma_adapt_dfe_fxtap7[1], w_pma_adapt_dfe_fxtap7[0]}),
				.dfe_fxtap7_sgn(w_pma_adapt_dfe_fxtap7_sgn),
				.dfe_rstn(in_rx_pma_rstb),
				.dfe_spec_disable(w_pma_adapt_dfe_spec_disable),
				.dfe_spec_sgn_sel(w_pma_adapt_dfe_spec_sign_sel),
				.dfe_vref_sgn_sel(w_pma_adapt_dfe_vref_sign_sel),
				.rxn(w_pma_rx_buf_outn),
				.rxp(w_pma_rx_buf_outp),
				.vga_vcm(1'b0),
				.vref_level_coeff({w_pma_adapt_vref_sel[4], w_pma_adapt_vref_sel[3], w_pma_adapt_vref_sel[2], w_pma_adapt_vref_sel[1], w_pma_adapt_vref_sel[0]})
			);
		end // if generate
		else begin
				assign w_pma_rx_dfe_avmmreaddata[7:0] = 8'b0;
				assign w_pma_rx_dfe_blockselect = 1'b0;
				assign w_pma_rx_dfe_clk0_bbpd = 1'b0;
				assign w_pma_rx_dfe_clk180_bbpd = 1'b0;
				assign w_pma_rx_dfe_clk270_bbpd = 1'b0;
				assign w_pma_rx_dfe_clk90_bbpd = 1'b0;
				assign w_pma_rx_dfe_deven = 1'b0;
				assign w_pma_rx_dfe_devenb = 1'b0;
				assign w_pma_rx_dfe_dfe_oc_tstmx[7:0] = 8'b0;
				assign w_pma_rx_dfe_dodd = 1'b0;
				assign w_pma_rx_dfe_doddb = 1'b0;
				assign w_pma_rx_dfe_edge270 = 1'b0;
				assign w_pma_rx_dfe_edge270b = 1'b0;
				assign w_pma_rx_dfe_edge90 = 1'b0;
				assign w_pma_rx_dfe_edge90b = 1'b0;
				assign w_pma_rx_dfe_err_ev = 1'b0;
				assign w_pma_rx_dfe_err_evb = 1'b0;
				assign w_pma_rx_dfe_err_od = 1'b0;
				assign w_pma_rx_dfe_err_odb = 1'b0;
				assign w_pma_rx_dfe_spec_vrefh = 1'b0;
				assign w_pma_rx_dfe_spec_vrefl = 1'b0;
		end // if not generate
		
		// instantiating twentynm_hssi_pma_rx_odi
		if ((xcvr_native_mode == "mode_rx_only") || (xcvr_native_mode == "mode_duplex")) begin:gen_twentynm_hssi_pma_rx_odi
			twentynm_hssi_pma_rx_odi #(
				.datarate(pma_rx_odi_datarate),
				.initial_settings("true"),       //PARAM_HIDE
				.optimal("false"),       //PARAM_HIDE
				.prot_mode(pma_rx_odi_prot_mode),
				.silicon_rev( "20nm2" ),       //PARAM_HIDE
				.step_ctrl_sel(pma_rx_odi_step_ctrl_sel),
				.sup_mode(pma_rx_odi_sup_mode)
			) inst_twentynm_hssi_pma_rx_odi (
				// OUTPUTS
				.avmmreaddata(w_pma_rx_odi_avmmreaddata),
				.blockselect(w_pma_rx_odi_blockselect),
				.clk0_eye(w_pma_rx_odi_clk0_eye),
				.clk0_eye_lb(w_pma_rx_odi_clk0_eye_lb),
				.clk180_eye(w_pma_rx_odi_clk180_eye),
				.clk180_eye_lb(w_pma_rx_odi_clk180_eye_lb),
				.de_eye(w_pma_rx_odi_de_eye),
				.deb_eye(w_pma_rx_odi_deb_eye),
				.do_eye(w_pma_rx_odi_do_eye),
				.dob_eye(w_pma_rx_odi_dob_eye),
				.odi_en(w_pma_rx_odi_odi_en),
				.odi_oc_tstmx(w_pma_rx_odi_odi_oc_tstmx),
				// INPUTS
				.avmmaddress({in_avmmaddress[8], in_avmmaddress[7], in_avmmaddress[6], in_avmmaddress[5], in_avmmaddress[4], in_avmmaddress[3], in_avmmaddress[2], in_avmmaddress[1], in_avmmaddress[0]}),
				.avmmclk(in_avmmclk),
				.avmmread(in_avmmread),
				.avmmrstn(in_avmmrstn),
				.avmmwrite(in_avmmwrite),
				.avmmwritedata({in_avmmwritedata[7], in_avmmwritedata[6], in_avmmwritedata[5], in_avmmwritedata[4], in_avmmwritedata[3], in_avmmwritedata[2], in_avmmwritedata[1], in_avmmwritedata[0]}),
				.clk0(w_cdr_pll_clk0_odi),
				.clk180(w_cdr_pll_clk180_odi),
				.clk270(w_cdr_pll_clk270_odi),
				.clk90(w_cdr_pll_clk90_odi),
				.odi_dft_clr(in_eye_monitor[3]),
				.odi_latch_clk(in_eye_monitor[1]),
				.odi_shift_clk(in_eye_monitor[0]),
				.odi_shift_in(in_eye_monitor[2]),
				.rx_n(w_pma_rx_buf_inn),
				.rx_p(w_pma_rx_buf_inp),
				.rxn_sum(w_pma_rx_buf_outn),
				.rxp_sum(w_pma_rx_buf_outp),
				.spec_vrefh(w_pma_rx_dfe_spec_vrefh),
				.spec_vrefl(w_pma_rx_dfe_spec_vrefl),
				.vcm_vref(1'b0),
				.vertical_fb({w_pma_adapt_odi_vref[4], w_pma_adapt_odi_vref[3], w_pma_adapt_odi_vref[2], w_pma_adapt_odi_vref[1], 1'b0}),
				
				// UNUSED
				.atb0(),
				.atb1(),
				.it50u(),
				.it50u2(),
				.it50u4(),
				.odi_atb_sel(),
				.tdr_en(),
				.vref_sel_out()
			);
		end // if generate
		else begin
				assign w_pma_rx_odi_avmmreaddata[7:0] = 8'b0;
				assign w_pma_rx_odi_blockselect = 1'b0;
				assign w_pma_rx_odi_clk0_eye = 1'b0;
				assign w_pma_rx_odi_clk0_eye_lb = 1'b0;
				assign w_pma_rx_odi_clk180_eye = 1'b0;
				assign w_pma_rx_odi_clk180_eye_lb = 1'b0;
				assign w_pma_rx_odi_de_eye = 1'b0;
				assign w_pma_rx_odi_deb_eye = 1'b0;
				assign w_pma_rx_odi_do_eye = 1'b0;
				assign w_pma_rx_odi_dob_eye = 1'b0;
				assign w_pma_rx_odi_odi_en = 1'b0;
				assign w_pma_rx_odi_odi_oc_tstmx[1:0] = 2'b0;
		end // if not generate
		
		// instantiating twentynm_hssi_pma_rx_sd
		if ((xcvr_native_mode == "mode_rx_only") || (xcvr_native_mode == "mode_duplex")) begin:gen_twentynm_hssi_pma_rx_sd
			twentynm_hssi_pma_rx_sd #(
				.optimal("false"),       //PARAM_HIDE
				.prot_mode(pma_rx_sd_prot_mode),
				.sd_output_off(pma_rx_sd_sd_output_off),
				.sd_output_on(pma_rx_sd_sd_output_on),
				.sd_pdb(pma_rx_sd_sd_pdb),
				.silicon_rev( "20nm2" ),       //PARAM_HIDE
				.sup_mode(pma_rx_sd_sup_mode)
			) inst_twentynm_hssi_pma_rx_sd (
				// OUTPUTS
				.avmmreaddata(w_pma_rx_sd_avmmreaddata),
				.blockselect(w_pma_rx_sd_blockselect),
				.sd(w_pma_rx_sd_sd),
				// INPUTS
				.avmmaddress({in_avmmaddress[8], in_avmmaddress[7], in_avmmaddress[6], in_avmmaddress[5], in_avmmaddress[4], in_avmmaddress[3], in_avmmaddress[2], in_avmmaddress[1], in_avmmaddress[0]}),
				.avmmclk(in_avmmclk),
				.avmmread(in_avmmread),
				.avmmrstn(in_avmmrstn),
				.avmmwrite(in_avmmwrite),
				.avmmwritedata({in_avmmwritedata[7], in_avmmwritedata[6], in_avmmwritedata[5], in_avmmwritedata[4], in_avmmwritedata[3], in_avmmwritedata[2], in_avmmwritedata[1], in_avmmwritedata[0]}),
				.clk(w_pma_rx_deser_clkdivrx_rx),
				.qpi(w_pma_rx_buf_pull_dn),
				.rstn_sd(in_rx_pma_rstb),
				.s_lpbk_b(in_rs_lpbk_b),
				.vin(w_pma_rx_buf_inn),
				.vip(w_pma_rx_buf_inp)
			);
		end // if generate
		else begin
				assign w_pma_rx_sd_avmmreaddata[7:0] = 8'b0;
				assign w_pma_rx_sd_blockselect = 1'b0;
				assign w_pma_rx_sd_sd = 1'b0;
		end // if not generate
		
		// instantiating twentynm_hssi_pma_tx_buf
		if ((xcvr_native_mode == "mode_tx_only") || (xcvr_native_mode == "mode_duplex")) begin:gen_twentynm_hssi_pma_tx_buf
			twentynm_hssi_pma_tx_buf #(
				.datarate(pma_tx_buf_datarate),
				.dft_sel("dft_disabled"),       //PARAM_HIDE
				.initial_settings("true"),       //PARAM_HIDE
				.jtag_drv_sel("drv1"),       //PARAM_HIDE
				.jtag_lp("lp_off"),       //PARAM_HIDE
				.lst("atb_disabled"),       //PARAM_HIDE
				.mcgb_location_for_pcie(pma_tx_buf_mcgb_location_for_pcie),
				.optimal("false"),       //PARAM_HIDE
				.prot_mode(pma_tx_buf_prot_mode),
				.rx_det(pma_tx_buf_rx_det),
				.rx_det_output_sel(pma_tx_buf_rx_det_output_sel),
				.rx_det_pdb(pma_tx_buf_rx_det_pdb),
				.ser_powerdown("normal_ser_on"),       //PARAM_HIDE
				.silicon_rev( "20nm2" ),       //PARAM_HIDE
				.sup_mode(pma_tx_buf_sup_mode),
				.tx_powerdown("normal_tx_on"),       //PARAM_HIDE
				.user_fir_coeff_ctrl_sel(pma_tx_buf_user_fir_coeff_ctrl_sel),
				.xtx_path_clock_divider_ratio(pma_tx_buf_xtx_path_clock_divider_ratio),
				.xtx_path_datarate(pma_tx_buf_xtx_path_datarate),
				.xtx_path_datawidth(pma_tx_buf_xtx_path_datawidth),
				.xtx_path_initial_settings("true"),       //PARAM_HIDE
				.xtx_path_optimal("false"),       //PARAM_HIDE
				.xtx_path_pma_tx_divclk_hz(pma_tx_buf_xtx_path_pma_tx_divclk_hz),
				.xtx_path_prot_mode(pma_tx_buf_xtx_path_prot_mode),
				.xtx_path_sup_mode(pma_tx_buf_xtx_path_sup_mode),
				.xtx_path_tx_pll_clk_hz(pma_tx_buf_xtx_path_tx_pll_clk_hz)
			) inst_twentynm_hssi_pma_tx_buf (
				// OUTPUTS
				.atbsel(w_pma_tx_buf_atbsel),
				.avmmreaddata(w_pma_tx_buf_avmmreaddata),
				.blockselect(w_pma_tx_buf_blockselect),
				.ckn(w_pma_tx_buf_ckn),
				.ckp(w_pma_tx_buf_ckp),
				.dcd_out1(w_pma_tx_buf_dcd_out1),
				.dcd_out2(w_pma_tx_buf_dcd_out2),
				.dcd_out_ready(w_pma_tx_buf_dcd_out_ready),
				.detect_on(w_pma_tx_buf_detect_on),
				.lbvon(w_pma_tx_buf_lbvon),
				.lbvop(w_pma_tx_buf_lbvop),
				.rx_detect_valid(w_pma_tx_buf_rx_detect_valid),
				.rx_found(w_pma_tx_buf_rx_found),
				.rx_found_pcie_spl_test(w_pma_tx_buf_rx_found_pcie_spl_test),
				.sel_vreg(w_pma_tx_buf_sel_vreg),
				.spl_clk_test(w_pma_tx_buf_spl_clk_test),
				.tx_dftout(w_pma_tx_buf_tx_dftout),
				.vlptxn(w_pma_tx_buf_vlptxn),
				.vlptxp(w_pma_tx_buf_vlptxp),
				.von(w_pma_tx_buf_von),
				.vop(w_pma_tx_buf_vop),
				// INPUTS
				.avmmaddress({in_avmmaddress[8], in_avmmaddress[7], in_avmmaddress[6], in_avmmaddress[5], in_avmmaddress[4], in_avmmaddress[3], in_avmmaddress[2], in_avmmaddress[1], in_avmmaddress[0]}),
				.avmmclk(in_avmmclk),
				.avmmread(in_avmmread),
				.avmmrstn(in_avmmrstn),
				.avmmwrite(in_avmmwrite),
				.avmmwritedata({in_avmmwritedata[7], in_avmmwritedata[6], in_avmmwritedata[5], in_avmmwritedata[4], in_avmmwritedata[3], in_avmmwritedata[2], in_avmmwritedata[1], in_avmmwritedata[0]}),
				.bsmode(1'b0),
				.bsoeb(1'b0),
				.bstxn_in(1'b0),
				.bstxp_in(1'b0),
				.clk0_tx(w_pma_cgb_hifreqclkp),
				.clk180_tx(w_pma_cgb_hifreqclkn),
				.clk_dcd(w_pma_cgb_cpulse_out_bus[0]),
				.clksn(w_pma_tx_ser_ckdrvp),
				.clksp(w_pma_tx_ser_ckdrvn),
				.i_coeff({in_i_coeff[17], in_i_coeff[16], in_i_coeff[15], in_i_coeff[14], in_i_coeff[13], in_i_coeff[12], in_i_coeff[11], in_i_coeff[10], in_i_coeff[9], in_i_coeff[8], in_i_coeff[7], in_i_coeff[6], in_i_coeff[5], in_i_coeff[4], in_i_coeff[3], in_i_coeff[2], in_i_coeff[1], in_i_coeff[0]}),
				.oe(w_pma_tx_ser_oe),
				.oeb(w_pma_tx_ser_oeb),
				.oo(w_pma_tx_ser_oo),
				.oob(w_pma_tx_ser_oob),
				.pcie_sw_master(w_pma_cgb_pcie_sw_master[1]),
				.rx_det_clk(w_pma_cdr_refclk_rx_det_clk),
				.rx_n_bidir_in(in_rx_n),
				.rx_p_bidir_in(in_rx_p),
				.s_lpbk_b(in_rs_lpbk_b),
				.tx50({in_tx50_buf_in[8], in_tx50_buf_in[7], in_tx50_buf_in[6], in_tx50_buf_in[5], in_tx50_buf_in[4], in_tx50_buf_in[3], in_tx50_buf_in[2], in_tx50_buf_in[1], in_tx50_buf_in[0]}),
				.tx_det_rx(in_tx_det_rx),
				.tx_elec_idle(in_tx_elec_idle),
				.tx_qpi_pulldn(in_tx_qpi_pulldn),
				.tx_qpi_pullup(in_tx_qpi_pullup),
				.tx_rlpbk(w_cdr_pll_tx_rlpbk),
				.vrlpbkn(w_cdr_pll_rlpbkn),
				.vrlpbkn_1t(w_cdr_pll_rlpbkdn),
				.vrlpbkp(w_cdr_pll_rlpbkp),
				.vrlpbkp_1t(w_cdr_pll_rlpbkdp),
				
				// UNUSED
				.cr_rdynamic_sw()
			);
		end // if generate
		else begin
				assign w_pma_tx_buf_atbsel[2:0] = 3'b0;
				assign w_pma_tx_buf_avmmreaddata[7:0] = 8'b0;
				assign w_pma_tx_buf_blockselect = 1'b0;
				assign w_pma_tx_buf_ckn = 1'b0;
				assign w_pma_tx_buf_ckp = 1'b0;
				assign w_pma_tx_buf_dcd_out1 = 1'b0;
				assign w_pma_tx_buf_dcd_out2 = 1'b0;
				assign w_pma_tx_buf_dcd_out_ready = 1'b0;
				assign w_pma_tx_buf_detect_on[1:0] = 2'b0;
				assign w_pma_tx_buf_lbvon = 1'b0;
				assign w_pma_tx_buf_lbvop = 1'b0;
				assign w_pma_tx_buf_rx_detect_valid = 1'b0;
				assign w_pma_tx_buf_rx_found = 1'b0;
				assign w_pma_tx_buf_rx_found_pcie_spl_test = 1'b0;
				assign w_pma_tx_buf_sel_vreg = 1'b0;
				assign w_pma_tx_buf_spl_clk_test = 1'b0;
				assign w_pma_tx_buf_tx_dftout[7:0] = 8'b0;
				assign w_pma_tx_buf_vlptxn = 1'b0;
				assign w_pma_tx_buf_vlptxp = 1'b0;
				assign w_pma_tx_buf_von = 1'b0;
				assign w_pma_tx_buf_vop = 1'b0;
		end // if not generate
		
		// instantiating twentynm_hssi_pma_tx_cgb
		if ((xcvr_native_mode == "mode_tx_only") || (xcvr_native_mode == "mode_duplex")) begin:gen_twentynm_hssi_pma_tx_cgb
			twentynm_hssi_pma_tx_cgb #(
				.bitslip_enable(pma_cgb_bitslip_enable),
				.bonding_reset_enable(pma_cgb_bonding_reset_enable),
				.cgb_power_down("normal_cgb"),       //PARAM_HIDE
				.datarate(pma_cgb_datarate),
				.initial_settings("true"),       //PARAM_HIDE
				.input_select_gen3(pma_cgb_input_select_gen3),
				.input_select_x1(pma_cgb_input_select_x1),
				.input_select_xn(pma_cgb_input_select_xn),
				.pcie_gen3_bitwidth(pma_cgb_pcie_gen3_bitwidth),
				.prot_mode(pma_cgb_prot_mode),
				.scratch0_x1_clock_src(pma_cgb_scratch0_x1_clock_src),
				.scratch1_x1_clock_src(pma_cgb_scratch1_x1_clock_src),
				.scratch2_x1_clock_src(pma_cgb_scratch2_x1_clock_src),
				.scratch3_x1_clock_src(pma_cgb_scratch3_x1_clock_src),
				.select_done_master_or_slave(pma_cgb_select_done_master_or_slave),
				.ser_mode(pma_cgb_ser_mode),
				.ser_powerdown("normal_poweron_ser"),       //PARAM_HIDE
				.silicon_rev( "20nm2" ),       //PARAM_HIDE
				.sup_mode(pma_cgb_sup_mode),
				.tx_ucontrol_en(pma_cgb_tx_ucontrol_en),
				.x1_div_m_sel(pma_cgb_x1_div_m_sel)
			) inst_twentynm_hssi_pma_tx_cgb (
				// OUTPUTS
				.avmmreaddata(w_pma_cgb_avmmreaddata),
				.bitslipstate(w_pma_cgb_bitslipstate),
				.blockselect(w_pma_cgb_blockselect),
				.cpulse_out_bus(w_pma_cgb_cpulse_out_bus),
				.div2(w_pma_cgb_div2),
				.div4(w_pma_cgb_div4),
				.div5(w_pma_cgb_div5),
				.hifreqclkn(w_pma_cgb_hifreqclkn),
				.hifreqclkp(w_pma_cgb_hifreqclkp),
				.pcie_sw_done(w_pma_cgb_pcie_sw_done),
				.pcie_sw_master(w_pma_cgb_pcie_sw_master),
				.rstb(w_pma_cgb_rstb),
				// INPUTS
				.avmmaddress({in_avmmaddress[8], in_avmmaddress[7], in_avmmaddress[6], in_avmmaddress[5], in_avmmaddress[4], in_avmmaddress[3], in_avmmaddress[2], in_avmmaddress[1], in_avmmaddress[0]}),
				.avmmclk(in_avmmclk),
				.avmmread(in_avmmread),
				.avmmrstn(in_avmmrstn),
				.avmmwrite(in_avmmwrite),
				.avmmwritedata({in_avmmwritedata[7], in_avmmwritedata[6], in_avmmwritedata[5], in_avmmwritedata[4], in_avmmwritedata[3], in_avmmwritedata[2], in_avmmwritedata[1], in_avmmwritedata[0]}),
				.ckdccn(w_pma_tx_buf_ckn),
				.ckdccp(w_pma_tx_buf_ckp),
				.clk_cdr_b(in_clk_cdr_b),
				.clk_cdr_direct(w_cdr_pll_clk0_pfd),
				.clk_cdr_t(in_clk_cdr_t),
				.clk_fpll_b(in_clk_fpll_b),
				.clk_fpll_t(in_clk_fpll_t),
				.clk_lc_b(in_clk_lc_b),
				.clk_lc_hs(in_clk_lc_hs),
				.clk_lc_t(in_clk_lc_t),
				.clkb_cdr_b(in_clkb_cdr_b),
				.clkb_cdr_direct(w_cdr_pll_clk180_pfd),
				.clkb_cdr_t(in_clkb_cdr_t),
				.clkb_fpll_b(in_clkb_fpll_b),
				.clkb_fpll_t(in_clkb_fpll_t),
				.clkb_lc_b(in_clkb_lc_b),
				.clkb_lc_hs(in_clkb_lc_hs),
				.clkb_lc_t(in_clkb_lc_t),
				.cpulse_x6_dn_bus({in_cpulse_x6_dn_bus[5], in_cpulse_x6_dn_bus[4], in_cpulse_x6_dn_bus[3], in_cpulse_x6_dn_bus[2], in_cpulse_x6_dn_bus[1], in_cpulse_x6_dn_bus[0]}),
				.cpulse_x6_up_bus({in_cpulse_x6_up_bus[5], in_cpulse_x6_up_bus[4], in_cpulse_x6_up_bus[3], in_cpulse_x6_up_bus[2], in_cpulse_x6_up_bus[1], in_cpulse_x6_up_bus[0]}),
				.cpulse_xn_dn_bus({in_cpulse_xn_dn_bus[5], in_cpulse_xn_dn_bus[4], in_cpulse_xn_dn_bus[3], in_cpulse_xn_dn_bus[2], in_cpulse_xn_dn_bus[1], in_cpulse_xn_dn_bus[0]}),
				.cpulse_xn_up_bus({in_cpulse_xn_up_bus[5], in_cpulse_xn_up_bus[4], in_cpulse_xn_up_bus[3], in_cpulse_xn_up_bus[2], in_cpulse_xn_up_bus[1], in_cpulse_xn_up_bus[0]}),
				.pcie_sw({in_pcie_sw[1], in_pcie_sw[0]}),
				.pcie_sw_done_master({in_pcie_sw_done_master_in[1], in_pcie_sw_done_master_in[0]}),
				.tx_bitslip(in_tx_bitslip),
				.tx_bonding_rstb(in_tx_bonding_rstb),
				.tx_pma_rstb(in_tx_pma_rstb)
			);
		end // if generate
		else begin
				assign w_pma_cgb_avmmreaddata[7:0] = 8'b0;
				assign w_pma_cgb_bitslipstate = 1'b0;
				assign w_pma_cgb_blockselect = 1'b0;
				assign w_pma_cgb_cpulse_out_bus[5:0] = 6'b0;
				assign w_pma_cgb_div2 = 1'b0;
				assign w_pma_cgb_div4 = 1'b0;
				assign w_pma_cgb_div5 = 1'b0;
				assign w_pma_cgb_hifreqclkn = 1'b0;
				assign w_pma_cgb_hifreqclkp = 1'b0;
				assign w_pma_cgb_pcie_sw_done[1:0] = 2'b0;
				assign w_pma_cgb_pcie_sw_master[1:0] = 2'b0;
				assign w_pma_cgb_rstb = 1'b0;
		end // if not generate
		
		// instantiating twentynm_hssi_pma_tx_ser
		if ((xcvr_native_mode == "mode_tx_only") || (xcvr_native_mode == "mode_duplex")) begin:gen_twentynm_hssi_pma_tx_ser
			twentynm_hssi_pma_tx_ser #(
				.control_clk_divtx("no_dft_control_clkdivtx"),       //PARAM_HIDE
				.initial_settings("true"),       //PARAM_HIDE
				.prot_mode(pma_tx_ser_prot_mode),
				.ser_clk_divtx_user_sel(pma_tx_ser_ser_clk_divtx_user_sel),
				.ser_powerdown("normal_poweron_ser"),       //PARAM_HIDE
				.silicon_rev( "20nm2" ),       //PARAM_HIDE
				.sup_mode(pma_tx_ser_sup_mode)
			) inst_twentynm_hssi_pma_tx_ser (
				// OUTPUTS
				.avmmreaddata(w_pma_tx_ser_avmmreaddata),
				.blockselect(w_pma_tx_ser_blockselect),
				.ckdrvn(w_pma_tx_ser_ckdrvn),
				.ckdrvp(w_pma_tx_ser_ckdrvp),
				.clk_divtx(w_pma_tx_ser_clk_divtx),
				.clk_divtx_user(w_pma_tx_ser_clk_divtx_user),
				.oe(w_pma_tx_ser_oe),
				.oeb(w_pma_tx_ser_oeb),
				.oo(w_pma_tx_ser_oo),
				.oob(w_pma_tx_ser_oob),
				// INPUTS
				.avmmaddress({in_avmmaddress[8], in_avmmaddress[7], in_avmmaddress[6], in_avmmaddress[5], in_avmmaddress[4], in_avmmaddress[3], in_avmmaddress[2], in_avmmaddress[1], in_avmmaddress[0]}),
				.avmmclk(in_avmmclk),
				.avmmread(in_avmmread),
				.avmmrstn(in_avmmrstn),
				.avmmwrite(in_avmmwrite),
				.avmmwritedata({in_avmmwritedata[7], in_avmmwritedata[6], in_avmmwritedata[5], in_avmmwritedata[4], in_avmmwritedata[3], in_avmmwritedata[2], in_avmmwritedata[1], in_avmmwritedata[0]}),
				.bitslipstate(w_pma_cgb_bitslipstate),
				.cpulse(w_pma_cgb_cpulse_out_bus[1]),
				.data({in_tx_data[63], in_tx_data[62], in_tx_data[61], in_tx_data[60], in_tx_data[59], in_tx_data[58], in_tx_data[57], in_tx_data[56], in_tx_data[55], in_tx_data[54], in_tx_data[53], in_tx_data[52], in_tx_data[51], in_tx_data[50], in_tx_data[49], in_tx_data[48], in_tx_data[47], in_tx_data[46], in_tx_data[45], in_tx_data[44], in_tx_data[43], in_tx_data[42], in_tx_data[41], in_tx_data[40], in_tx_data[39], in_tx_data[38], in_tx_data[37], in_tx_data[36], in_tx_data[35], in_tx_data[34], in_tx_data[33], in_tx_data[32], in_tx_data[31], in_tx_data[30], in_tx_data[29], in_tx_data[28], in_tx_data[27], in_tx_data[26], in_tx_data[25], in_tx_data[24], in_tx_data[23], in_tx_data[22], in_tx_data[21], in_tx_data[20], in_tx_data[19], in_tx_data[18], in_tx_data[17], in_tx_data[16], in_tx_data[15], in_tx_data[14], in_tx_data[13], in_tx_data[12], in_tx_data[11], in_tx_data[10], in_tx_data[9], in_tx_data[8], in_tx_data[7], in_tx_data[6], in_tx_data[5], in_tx_data[4], in_tx_data[3], in_tx_data[2], in_tx_data[1], in_tx_data[0]}),
				.hfclkn(w_pma_cgb_cpulse_out_bus[4]),
				.hfclkp(w_pma_cgb_cpulse_out_bus[5]),
				.lfclk(w_pma_cgb_cpulse_out_bus[3]),
				.lfclk2(w_pma_cgb_cpulse_out_bus[2]),
				.paraclk(w_pma_cgb_cpulse_out_bus[0]),
				.rser_div2(w_pma_cgb_div2),
				.rser_div4(w_pma_cgb_div4),
				.rser_div5(w_pma_cgb_div5),
				.rst_n(w_pma_cgb_rstb)
			);
		end // if generate
		else begin
				assign w_pma_tx_ser_avmmreaddata[7:0] = 8'b0;
				assign w_pma_tx_ser_blockselect = 1'b0;
				assign w_pma_tx_ser_ckdrvn = 1'b0;
				assign w_pma_tx_ser_ckdrvp = 1'b0;
				assign w_pma_tx_ser_clk_divtx = 1'b0;
				assign w_pma_tx_ser_clk_divtx_user = 1'b0;
				assign w_pma_tx_ser_oe = 1'b0;
				assign w_pma_tx_ser_oeb = 1'b0;
				assign w_pma_tx_ser_oo = 1'b0;
				assign w_pma_tx_ser_oob = 1'b0;
		end // if not generate
		
		//output assignments
		assign out_avmmreaddata_cdr_pll = {w_cdr_pll_avmmreaddata[7], w_cdr_pll_avmmreaddata[6], w_cdr_pll_avmmreaddata[5], w_cdr_pll_avmmreaddata[4], w_cdr_pll_avmmreaddata[3], w_cdr_pll_avmmreaddata[2], w_cdr_pll_avmmreaddata[1], w_cdr_pll_avmmreaddata[0]};
		assign out_avmmreaddata_pma_adapt = {w_pma_adapt_avmmreaddata[7], w_pma_adapt_avmmreaddata[6], w_pma_adapt_avmmreaddata[5], w_pma_adapt_avmmreaddata[4], w_pma_adapt_avmmreaddata[3], w_pma_adapt_avmmreaddata[2], w_pma_adapt_avmmreaddata[1], w_pma_adapt_avmmreaddata[0]};
		assign out_avmmreaddata_pma_cdr_refclk = {w_pma_cdr_refclk_avmmreaddata[7], w_pma_cdr_refclk_avmmreaddata[6], w_pma_cdr_refclk_avmmreaddata[5], w_pma_cdr_refclk_avmmreaddata[4], w_pma_cdr_refclk_avmmreaddata[3], w_pma_cdr_refclk_avmmreaddata[2], w_pma_cdr_refclk_avmmreaddata[1], w_pma_cdr_refclk_avmmreaddata[0]};
		assign out_avmmreaddata_pma_cgb = {w_pma_cgb_avmmreaddata[7], w_pma_cgb_avmmreaddata[6], w_pma_cgb_avmmreaddata[5], w_pma_cgb_avmmreaddata[4], w_pma_cgb_avmmreaddata[3], w_pma_cgb_avmmreaddata[2], w_pma_cgb_avmmreaddata[1], w_pma_cgb_avmmreaddata[0]};
		assign out_avmmreaddata_pma_rx_buf = {w_pma_rx_buf_avmmreaddata[7], w_pma_rx_buf_avmmreaddata[6], w_pma_rx_buf_avmmreaddata[5], w_pma_rx_buf_avmmreaddata[4], w_pma_rx_buf_avmmreaddata[3], w_pma_rx_buf_avmmreaddata[2], w_pma_rx_buf_avmmreaddata[1], w_pma_rx_buf_avmmreaddata[0]};
		assign out_avmmreaddata_pma_rx_deser = {w_pma_rx_deser_avmmreaddata[7], w_pma_rx_deser_avmmreaddata[6], w_pma_rx_deser_avmmreaddata[5], w_pma_rx_deser_avmmreaddata[4], w_pma_rx_deser_avmmreaddata[3], w_pma_rx_deser_avmmreaddata[2], w_pma_rx_deser_avmmreaddata[1], w_pma_rx_deser_avmmreaddata[0]};
		assign out_avmmreaddata_pma_rx_dfe = {w_pma_rx_dfe_avmmreaddata[7], w_pma_rx_dfe_avmmreaddata[6], w_pma_rx_dfe_avmmreaddata[5], w_pma_rx_dfe_avmmreaddata[4], w_pma_rx_dfe_avmmreaddata[3], w_pma_rx_dfe_avmmreaddata[2], w_pma_rx_dfe_avmmreaddata[1], w_pma_rx_dfe_avmmreaddata[0]};
		assign out_avmmreaddata_pma_rx_odi = {w_pma_rx_odi_avmmreaddata[7], w_pma_rx_odi_avmmreaddata[6], w_pma_rx_odi_avmmreaddata[5], w_pma_rx_odi_avmmreaddata[4], w_pma_rx_odi_avmmreaddata[3], w_pma_rx_odi_avmmreaddata[2], w_pma_rx_odi_avmmreaddata[1], w_pma_rx_odi_avmmreaddata[0]};
		assign out_avmmreaddata_pma_rx_sd = {w_pma_rx_sd_avmmreaddata[7], w_pma_rx_sd_avmmreaddata[6], w_pma_rx_sd_avmmreaddata[5], w_pma_rx_sd_avmmreaddata[4], w_pma_rx_sd_avmmreaddata[3], w_pma_rx_sd_avmmreaddata[2], w_pma_rx_sd_avmmreaddata[1], w_pma_rx_sd_avmmreaddata[0]};
		assign out_avmmreaddata_pma_tx_buf = {w_pma_tx_buf_avmmreaddata[7], w_pma_tx_buf_avmmreaddata[6], w_pma_tx_buf_avmmreaddata[5], w_pma_tx_buf_avmmreaddata[4], w_pma_tx_buf_avmmreaddata[3], w_pma_tx_buf_avmmreaddata[2], w_pma_tx_buf_avmmreaddata[1], w_pma_tx_buf_avmmreaddata[0]};
		assign out_avmmreaddata_pma_tx_ser = {w_pma_tx_ser_avmmreaddata[7], w_pma_tx_ser_avmmreaddata[6], w_pma_tx_ser_avmmreaddata[5], w_pma_tx_ser_avmmreaddata[4], w_pma_tx_ser_avmmreaddata[3], w_pma_tx_ser_avmmreaddata[2], w_pma_tx_ser_avmmreaddata[1], w_pma_tx_ser_avmmreaddata[0]};
		assign out_blockselect_cdr_pll = w_cdr_pll_blockselect;
		assign out_blockselect_pma_adapt = w_pma_adapt_blockselect;
		assign out_blockselect_pma_cdr_refclk = w_pma_cdr_refclk_blockselect;
		assign out_blockselect_pma_cgb = w_pma_cgb_blockselect;
		assign out_blockselect_pma_rx_buf = w_pma_rx_buf_blockselect;
		assign out_blockselect_pma_rx_deser = w_pma_rx_deser_blockselect;
		assign out_blockselect_pma_rx_dfe = w_pma_rx_dfe_blockselect;
		assign out_blockselect_pma_rx_odi = w_pma_rx_odi_blockselect;
		assign out_blockselect_pma_rx_sd = w_pma_rx_sd_blockselect;
		assign out_blockselect_pma_tx_buf = w_pma_tx_buf_blockselect;
		assign out_blockselect_pma_tx_ser = w_pma_tx_ser_blockselect;
		assign out_clk0_pfd = w_cdr_pll_clk0_pfd;
		assign out_clk180_pfd = w_cdr_pll_clk180_pfd;
		assign out_clk_divrx_iqtxrx = w_pma_rx_deser_clkdiv;
		assign out_clk_divtx_iqtxrx = w_pma_tx_ser_clk_divtx;
		assign out_clkdiv_rx = w_pma_rx_deser_clkdiv;
		assign out_clkdiv_rx_user = w_pma_rx_deser_clkdiv_user;
		assign out_clkdiv_tx = w_pma_tx_ser_clk_divtx;
		assign out_clkdiv_tx_user = w_pma_tx_ser_clk_divtx_user;
		assign out_clklow = w_cdr_pll_clklow;
		assign out_fref = w_cdr_pll_fref;
		assign out_iqtxrxclk_out0 = w_pma_tx_ser_clk_divtx;
		assign out_iqtxrxclk_out1 = w_pma_tx_ser_clk_divtx;
		assign out_jtaglpxn = w_pma_tx_buf_vlptxn;
		assign out_jtaglpxp = w_pma_tx_buf_vlptxp;
		assign out_pcie_sw_done = {w_pma_cgb_pcie_sw_done[1], w_pma_cgb_pcie_sw_done[0]};
		assign out_pcie_sw_master = {w_pma_cgb_pcie_sw_master[1], w_pma_cgb_pcie_sw_master[0]};
		assign out_pfdmode_lock = w_cdr_pll_pfdmode_lock;
		assign out_rx_detect_valid = w_pma_tx_buf_rx_detect_valid;
		assign out_rx_found = w_pma_tx_buf_rx_found;
		assign out_rxdata = {w_pma_rx_deser_dout[63], w_pma_rx_deser_dout[62], w_pma_rx_deser_dout[61], w_pma_rx_deser_dout[60], w_pma_rx_deser_dout[59], w_pma_rx_deser_dout[58], w_pma_rx_deser_dout[57], w_pma_rx_deser_dout[56], w_pma_rx_deser_dout[55], w_pma_rx_deser_dout[54], w_pma_rx_deser_dout[53], w_pma_rx_deser_dout[52], w_pma_rx_deser_dout[51], w_pma_rx_deser_dout[50], w_pma_rx_deser_dout[49], w_pma_rx_deser_dout[48], w_pma_rx_deser_dout[47], w_pma_rx_deser_dout[46], w_pma_rx_deser_dout[45], w_pma_rx_deser_dout[44], w_pma_rx_deser_dout[43], w_pma_rx_deser_dout[42], w_pma_rx_deser_dout[41], w_pma_rx_deser_dout[40], w_pma_rx_deser_dout[39], w_pma_rx_deser_dout[38], w_pma_rx_deser_dout[37], w_pma_rx_deser_dout[36], w_pma_rx_deser_dout[35], w_pma_rx_deser_dout[34], w_pma_rx_deser_dout[33], w_pma_rx_deser_dout[32], w_pma_rx_deser_dout[31], w_pma_rx_deser_dout[30], w_pma_rx_deser_dout[29], w_pma_rx_deser_dout[28], w_pma_rx_deser_dout[27], w_pma_rx_deser_dout[26], w_pma_rx_deser_dout[25], w_pma_rx_deser_dout[24], w_pma_rx_deser_dout[23], w_pma_rx_deser_dout[22], w_pma_rx_deser_dout[21], w_pma_rx_deser_dout[20], w_pma_rx_deser_dout[19], w_pma_rx_deser_dout[18], w_pma_rx_deser_dout[17], w_pma_rx_deser_dout[16], w_pma_rx_deser_dout[15], w_pma_rx_deser_dout[14], w_pma_rx_deser_dout[13], w_pma_rx_deser_dout[12], w_pma_rx_deser_dout[11], w_pma_rx_deser_dout[10], w_pma_rx_deser_dout[9], w_pma_rx_deser_dout[8], w_pma_rx_deser_dout[7], w_pma_rx_deser_dout[6], w_pma_rx_deser_dout[5], w_pma_rx_deser_dout[4], w_pma_rx_deser_dout[3], w_pma_rx_deser_dout[2], w_pma_rx_deser_dout[1], w_pma_rx_deser_dout[0]};
		assign out_rxpll_lock = w_cdr_pll_rxpll_lock;
		assign out_sd = w_pma_rx_sd_sd;
		assign out_tx_n = w_pma_tx_buf_von;
		assign out_tx_p = w_pma_tx_buf_vop;
	endgenerate
endmodule
module twentynm_pma_rev_20nm3
	#(
	//PARAM_LIST_START
		parameter xcvr_native_mode = "mode_duplex",  // mode_duplex, mode_rx_only, mode_tx_only
		
		// parameters for twentynm_hssi_pma_adaptation
		parameter pma_adapt_adapt_mode = "dfe_vga", // ctle|dfe_vga|ctle_vga|ctle_vga_dfe|manual
		parameter pma_adapt_adp_1s_ctle_bypass = "radp_1s_ctle_bypass_0", // radp_1s_ctle_bypass_0|radp_1s_ctle_bypass_1
		parameter pma_adapt_adp_4s_ctle_bypass = "radp_4s_ctle_bypass_0", // radp_4s_ctle_bypass_0|radp_4s_ctle_bypass_1
		parameter pma_adapt_adp_ctle_adapt_cycle_window = "radp_ctle_adapt_cycle_window_6", // radp_ctle_adapt_cycle_window_0|radp_ctle_adapt_cycle_window_1|radp_ctle_adapt_cycle_window_2|radp_ctle_adapt_cycle_window_3|radp_ctle_adapt_cycle_window_4|radp_ctle_adapt_cycle_window_5|radp_ctle_adapt_cycle_window_6|radp_ctle_adapt_cycle_window_7
		parameter pma_adapt_adp_ctle_en = "radp_ctle_disable", // radp_ctle_disable|radp_ctle_enable
		parameter pma_adapt_adp_dfe_fltap_bypass = "radp_dfe_fltap_bypass_0", // radp_dfe_fltap_bypass_0|radp_dfe_fltap_bypass_1
		parameter pma_adapt_adp_dfe_fltap_en = "radp_dfe_fltap_disable", // radp_dfe_fltap_disable|radp_dfe_fltap_enable
		parameter pma_adapt_adp_dfe_fxtap_bypass = "radp_dfe_fxtap_bypass_0", // radp_dfe_fxtap_bypass_0|radp_dfe_fxtap_bypass_1
		parameter pma_adapt_adp_dfe_fxtap_en = "radp_dfe_fxtap_disable", // radp_dfe_fxtap_disable|radp_dfe_fxtap_enable
		parameter pma_adapt_adp_dfe_fxtap_hold_en = "radp_dfe_fxtap_not_held", // radp_dfe_fxtap_not_held|radp_dfe_fxtap_hold
		parameter pma_adapt_adp_dfe_mode = "radp_dfe_mode_0", // radp_dfe_mode_0|radp_dfe_mode_1|radp_dfe_mode_2|radp_dfe_mode_3|radp_dfe_mode_4|radp_dfe_mode_5|radp_dfe_mode_6|radp_dfe_mode_7
		parameter pma_adapt_adp_mode = "radp_mode_0", // radp_mode_0|radp_mode_1|radp_mode_2|radp_mode_3|radp_mode_4|radp_mode_5|radp_mode_6|radp_mode_7|radp_mode_8|radp_mode_9|radp_mode_10|radp_mode_11|radp_mode_12|radp_mode_13|radp_mode_14|radp_mode_15
		parameter pma_adapt_adp_onetime_dfe = "radp_onetime_dfe_0", // radp_onetime_dfe_0|radp_onetime_dfe_1
		parameter pma_adapt_adp_vga_bypass = "radp_vga_bypass_0", // radp_vga_bypass_0|radp_vga_bypass_1
		parameter pma_adapt_adp_vga_en = "radp_vga_disable", // radp_vga_disable|radp_vga_enable
		parameter pma_adapt_adp_vref_bypass = "radp_vref_bypass_0", // radp_vref_bypass_0|radp_vref_bypass_1
		parameter pma_adapt_adp_vref_en = "radp_vref_disable", // radp_vref_disable|radp_vref_enable
		parameter pma_adapt_datarate = "0 bps", // 
		parameter pma_adapt_odi_dfe_spec_en = "rodi_dfe_spec_en_0", // rodi_dfe_spec_en_0|rodi_dfe_spec_en_1
		parameter pma_adapt_prot_mode = "basic_rx", // basic_rx|pcie_gen1_rx|pcie_gen2_rx|pcie_gen3_rx|pcie_gen4_rx|qpi_rx|unused|gpon_rx|sata_rx
		parameter pma_adapt_sup_mode = "user_mode", // user_mode|engineering_mode
		
		// parameters for twentynm_hssi_pma_cdr_refclk_select_mux
		parameter pma_cdr_refclk_inclk0_logical_to_physical_mapping = "ref_iqclk0", // ref_iqclk0|ref_iqclk1|ref_iqclk2|ref_iqclk3|ref_iqclk4|ref_iqclk5|ref_iqclk6|ref_iqclk7|ref_iqclk8|ref_iqclk9|ref_iqclk10|ref_iqclk11|iqtxrxclk0|iqtxrxclk1|iqtxrxclk2|iqtxrxclk3|iqtxrxclk4|iqtxrxclk5|coreclk|fixed_clk|lvpecl|adj_pll_clk|power_down
		parameter pma_cdr_refclk_inclk1_logical_to_physical_mapping = "ref_iqclk0", // ref_iqclk0|ref_iqclk1|ref_iqclk2|ref_iqclk3|ref_iqclk4|ref_iqclk5|ref_iqclk6|ref_iqclk7|ref_iqclk8|ref_iqclk9|ref_iqclk10|ref_iqclk11|iqtxrxclk0|iqtxrxclk1|iqtxrxclk2|iqtxrxclk3|iqtxrxclk4|iqtxrxclk5|coreclk|fixed_clk|lvpecl|adj_pll_clk|power_down
		parameter pma_cdr_refclk_inclk2_logical_to_physical_mapping = "ref_iqclk0", // ref_iqclk0|ref_iqclk1|ref_iqclk2|ref_iqclk3|ref_iqclk4|ref_iqclk5|ref_iqclk6|ref_iqclk7|ref_iqclk8|ref_iqclk9|ref_iqclk10|ref_iqclk11|iqtxrxclk0|iqtxrxclk1|iqtxrxclk2|iqtxrxclk3|iqtxrxclk4|iqtxrxclk5|coreclk|fixed_clk|lvpecl|adj_pll_clk|power_down
		parameter pma_cdr_refclk_inclk3_logical_to_physical_mapping = "ref_iqclk0", // ref_iqclk0|ref_iqclk1|ref_iqclk2|ref_iqclk3|ref_iqclk4|ref_iqclk5|ref_iqclk6|ref_iqclk7|ref_iqclk8|ref_iqclk9|ref_iqclk10|ref_iqclk11|iqtxrxclk0|iqtxrxclk1|iqtxrxclk2|iqtxrxclk3|iqtxrxclk4|iqtxrxclk5|coreclk|fixed_clk|lvpecl|adj_pll_clk|power_down
		parameter pma_cdr_refclk_inclk4_logical_to_physical_mapping = "ref_iqclk0", // ref_iqclk0|ref_iqclk1|ref_iqclk2|ref_iqclk3|ref_iqclk4|ref_iqclk5|ref_iqclk6|ref_iqclk7|ref_iqclk8|ref_iqclk9|ref_iqclk10|ref_iqclk11|iqtxrxclk0|iqtxrxclk1|iqtxrxclk2|iqtxrxclk3|iqtxrxclk4|iqtxrxclk5|coreclk|fixed_clk|lvpecl|adj_pll_clk|power_down
		parameter pma_cdr_refclk_powerdown_mode = "powerdown", // powerup|powerdown
		parameter pma_cdr_refclk_refclk_select = "ref_iqclk0", // ref_iqclk0|ref_iqclk1|ref_iqclk2|ref_iqclk3|ref_iqclk4|ref_iqclk5|ref_iqclk6|ref_iqclk7|ref_iqclk8|ref_iqclk9|ref_iqclk10|ref_iqclk11|iqtxrxclk0|iqtxrxclk1|iqtxrxclk2|iqtxrxclk3|iqtxrxclk4|iqtxrxclk5|coreclk|fixed_clk|lvpecl|adj_pll_clk|power_down
		
		// parameters for twentynm_hssi_pma_channel_pll
		parameter cdr_pll_atb_select_control = "atb_off", // atb_off|atb_select_tp_1|atb_select_tp_2|atb_select_tp_3|atb_select_tp_4|atb_select_tp_5|atb_select_tp_6|atb_select_tp_7|atb_select_tp_8|atb_select_tp_9|atb_select_tp_10|atb_select_tp_11|atb_select_tp_12|atb_select_tp_13|atb_select_tp_14|atb_select_tp_15|atb_select_tp_16|atb_select_tp_17|atb_select_tp_18|atb_select_tp_19|atb_select_tp_20|atb_select_tp_21|atb_select_tp_22|atb_select_tp_23|atb_select_tp_24|atb_select_tp_25|atb_select_tp_26|atb_select_tp_27|atb_select_tp_28|atb_select_tp_29|atb_select_tp_30|atb_select_tp_31|atb_select_tp_32|atb_select_tp_33|atb_select_tp_34|atb_select_tp_35|atb_select_tp_36|atb_select_tp_37|atb_select_tp_38|atb_select_tp_39|atb_select_tp_40|atb_select_tp_41|atb_select_tp_42|atb_select_tp_43|atb_select_tp_44|atb_select_tp_45|atb_select_tp_46|atb_select_tp_47|atb_select_tp_48|atb_select_tp_49|atb_select_tp_50|atb_select_tp_51|atb_select_tp_52|atb_select_tp_53|atb_select_tp_54|atb_select_tp_55|atb_select_tp_56|atb_select_tp_57|atb_select_tp_58|atb_select_tp_59|atb_select_tp_60|atb_select_tp_61|atb_select_tp_62|atb_select_tp_63
		parameter cdr_pll_auto_reset_on = "auto_reset_on", // auto_reset_on|auto_reset_off
		parameter cdr_pll_bbpd_data_pattern_filter_select = "bbpd_data_pat_off", // bbpd_data_pat_off|bbpd_data_pat_1|bbpd_data_pat_2|bbpd_data_pat_3
		parameter cdr_pll_bw_sel = "low", // low|medium|high
		parameter cdr_pll_cal_vco_count_length = "sel_8b_count", // sel_8b_count|sel_12b_count
		parameter cdr_pll_cdr_odi_select = "sel_cdr", // sel_cdr|sel_odi
		parameter cdr_pll_cdr_phaselock_mode = "no_ignore_lock", // no_ignore_lock|ignore_lock
		parameter cdr_pll_cdr_powerdown_mode = "power_down", // power_down|power_up
		parameter cdr_pll_cgb_div = 1, // 1|2|4|8
		parameter cdr_pll_chgpmp_current_dn_pd = "cp_current_pd_dn_setting0", // cp_current_pd_dn_setting0|cp_current_pd_dn_setting1|cp_current_pd_dn_setting2|cp_current_pd_dn_setting3|cp_current_pd_dn_setting4
		parameter cdr_pll_chgpmp_current_dn_trim = "cp_current_trimming_dn_setting0", // cp_current_trimming_dn_setting0|cp_current_trimming_dn_setting1|cp_current_trimming_dn_setting2|cp_current_trimming_dn_setting3|cp_current_trimming_dn_setting4|cp_current_trimming_dn_setting5|cp_current_trimming_dn_setting6|cp_current_trimming_dn_setting7|cp_current_trimming_dn_setting8|cp_current_trimming_dn_setting9|cp_current_trimming_dn_setting10|cp_current_trimming_dn_setting11|cp_current_trimming_dn_setting12|cp_current_trimming_dn_setting13|cp_current_trimming_dn_setting14|cp_current_trimming_dn_setting15
		parameter cdr_pll_chgpmp_current_pd = "cp_current_pd_setting0", // cp_current_pd_setting0|cp_current_pd_setting1|cp_current_pd_setting2|cp_current_pd_setting3|cp_current_pd_setting4
		parameter cdr_pll_chgpmp_current_pfd = "cp_current_pfd_setting0", // cp_current_pfd_setting0|cp_current_pfd_setting1|cp_current_pfd_setting2|cp_current_pfd_setting3|cp_current_pfd_setting4
		parameter cdr_pll_chgpmp_current_up_pd = "cp_current_pd_up_setting0", // cp_current_pd_up_setting0|cp_current_pd_up_setting1|cp_current_pd_up_setting2|cp_current_pd_up_setting3|cp_current_pd_up_setting4
		parameter cdr_pll_chgpmp_current_up_trim = "cp_current_trimming_up_setting0", // cp_current_trimming_up_setting0|cp_current_trimming_up_setting1|cp_current_trimming_up_setting2|cp_current_trimming_up_setting3|cp_current_trimming_up_setting4|cp_current_trimming_up_setting5|cp_current_trimming_up_setting6|cp_current_trimming_up_setting7|cp_current_trimming_up_setting8|cp_current_trimming_up_setting9|cp_current_trimming_up_setting10|cp_current_trimming_up_setting11|cp_current_trimming_up_setting12|cp_current_trimming_up_setting13|cp_current_trimming_up_setting14|cp_current_trimming_up_setting15
		parameter cdr_pll_chgpmp_dn_pd_trim_double = "normal_dn_trim_current", // normal_dn_trim_current|double_dn_trim_current
		parameter cdr_pll_chgpmp_replicate = "false", // false|true
		parameter cdr_pll_chgpmp_testmode = "cp_test_disable", // cp_test_disable|cp_test_up|cp_test_dn|cp_tristate
		parameter cdr_pll_chgpmp_up_pd_trim_double = "normal_up_trim_current", // normal_up_trim_current|double_up_trim_current
		parameter cdr_pll_clklow_mux_select = "clklow_mux_cdr_fbclk", // clklow_mux_cdr_fbclk|clklow_mux_fpll_test1|clklow_mux_reserved_1|clklow_mux_rx_deser_pclk_test|clklow_mux_reserved_2|clklow_mux_reserved_3|clklow_mux_reserved_4|clklow_mux_dfe_test
		parameter cdr_pll_datarate = "0 bps", // 
		parameter cdr_pll_diag_loopback_enable = "false", // true|false
		parameter cdr_pll_disable_up_dn = "true", // true|false
		parameter cdr_pll_fb_select = "direct_fb", // iqtxrxclk_fb|direct_fb
		parameter cdr_pll_fref_clklow_div = 1, // 1|2|4|8
		parameter cdr_pll_fref_mux_select = "fref_mux_cdr_refclk", // fref_mux_cdr_refclk|fref_mux_fpll_test0|fref_mux_reserved_1|fref_mux_tx_ser_pclk_test|fref_mux_reserved_2|fref_mux_reserved_3|fref_mux_reserved_4|fref_mux_reserved_5
		parameter cdr_pll_gpon_lck2ref_control = "gpon_lck2ref_off", // gpon_lck2ref_off|gpon_lck2ref_on
		parameter cdr_pll_initial_settings = "false", // false|true
		parameter cdr_pll_iqclk_mux_sel = "power_down", // iqtxrxclk0|iqtxrxclk1|iqtxrxclk2|iqtxrxclk3|iqtxrxclk4|iqtxrxclk5|power_down
		parameter cdr_pll_is_cascaded_pll = "false", // true|false
		parameter cdr_pll_lck2ref_delay_control = "lck2ref_delay_off", // lck2ref_delay_off|lck2ref_delay_1|lck2ref_delay_2|lck2ref_delay_3|lck2ref_delay_4|lck2ref_delay_5|lck2ref_delay_6|lck2ref_delay_7
		parameter cdr_pll_lf_resistor_pd = "lf_pd_setting0", // lf_pd_setting0|lf_pd_setting1|lf_pd_setting2|lf_pd_setting3
		parameter cdr_pll_lf_resistor_pfd = "lf_pfd_setting0", // lf_pfd_setting0|lf_pfd_setting1|lf_pfd_setting2|lf_pfd_setting3
		parameter cdr_pll_lf_ripple_cap = "lf_no_ripple", // lf_no_ripple|lf_ripple_cap1
		parameter cdr_pll_loop_filter_bias_select = "lpflt_bias_off", // lpflt_bias_off|lpflt_bias_1|lpflt_bias_2|lpflt_bias_3|lpflt_bias_4|lpflt_bias_5|lpflt_bias_6|lpflt_bias_7
		parameter cdr_pll_loopback_mode = "loopback_disabled", // loopback_disabled|loopback_recovered_data|rx_refclk|rx_refclk_cdr_loopback|unused2|loopback_received_data|unused1
		parameter cdr_pll_lpd_counter = 5'b1,
		parameter cdr_pll_lpfd_counter = 5'b1,
		parameter cdr_pll_ltd_ltr_micro_controller_select = "ltd_ltr_pcs", // ltd_ltr_pcs|ltr_ucontroller|ltd_ucontroller
		parameter cdr_pll_m_counter = 16, // 0..255
		parameter cdr_pll_n_counter = 1, // 1|2|4|8
		parameter cdr_pll_n_counter_scratch = 6'b1,
		parameter cdr_pll_output_clock_frequency = "0 hz", // 
		parameter cdr_pll_pcie_gen = "non_pcie", // pcie_gen1_100mhzref|pcie_gen2_100mhzref|pcie_gen3_100mhzref|pcie_gen1_125mhzref|pcie_gen2_125mhzref|pcie_gen3_125mhzref|non_pcie
		parameter cdr_pll_pd_fastlock_mode = "false", // false|true
		parameter cdr_pll_pd_l_counter = 1, // 0|1|2|4|8|16
		parameter cdr_pll_pfd_l_counter = 1, // 0|1|2|4|8|16|100
		parameter cdr_pll_pma_width = 8, // 8|10|16|20|32|40|64
		parameter cdr_pll_primary_use = "cmu", // cmu|cdr
		parameter cdr_pll_prot_mode = "unused", // basic_rx|pcie_gen1_rx|pcie_gen2_rx|pcie_gen3_rx|pcie_gen4_rx|qpi_rx|unused|gpon_rx|sata_rx
		parameter cdr_pll_reference_clock_frequency = "0 hz", // 
		parameter cdr_pll_reverse_serial_loopback = "no_loopback", // no_loopback|loopback_data_no_posttap|loopback_data_with_posttap|loopback_data_0_1
		parameter cdr_pll_set_cdr_input_freq_range = 8'b0,
		parameter cdr_pll_set_cdr_v2i_enable = "true", // true|false
		parameter cdr_pll_set_cdr_vco_reset = "false", // true|false
		parameter cdr_pll_set_cdr_vco_speed = 5'b1,
		parameter cdr_pll_set_cdr_vco_speed_fix = 8'b0,
		parameter cdr_pll_set_cdr_vco_speed_pciegen3 = "cdr_vco_max_speedbin_pciegen3", // cdr_vco_min_speedbin_pciegen3|cdr_vco_max_speedbin_pciegen3
		parameter cdr_pll_sup_mode = "user_mode", // user_mode|engineering_mode
		parameter cdr_pll_tx_pll_prot_mode = "txpll_unused", // txpll_unused|txpll_enable_pcie|txpll_enable
		parameter cdr_pll_txpll_hclk_driver_enable = "false", // true|false
		parameter cdr_pll_uc_ro_cal = "uc_ro_cal_off", // uc_ro_cal_off|uc_ro_cal_on
		parameter cdr_pll_vco_freq = "0 hz", // 
		parameter cdr_pll_vco_overrange_voltage = "vco_overrange_off", // vco_overrange_off|vco_overrange_ref_1|vco_overrange_ref_2|vco_overrange_ref_3
		parameter cdr_pll_vco_underrange_voltage = "vco_underange_off", // vco_underange_off|vco_underange_ref_1|vco_underange_ref_2|vco_underange_ref_3
		
		// parameters for twentynm_hssi_pma_rx_buf
		parameter pma_rx_buf_bypass_eqz_stages_234 = "bypass_off", // bypass_off|byypass_stages_234
		parameter pma_rx_buf_datarate = "0 bps", // 
		parameter pma_rx_buf_diag_lp_en = "dlp_off", // dlp_off|dlp_on
		parameter pma_rx_buf_loopback_modes = "lpbk_disable", // lpbk_disable|pre_cdr|post_cdr
		parameter pma_rx_buf_pm_tx_rx_cvp_mode = "cvp_off", // cvp_off|cvp_on
		parameter pma_rx_buf_pm_tx_rx_pcie_gen = "non_pcie", // pcie_gen1_100mhzref|pcie_gen2_100mhzref|pcie_gen3_100mhzref|pcie_gen1_125mhzref|pcie_gen2_125mhzref|pcie_gen3_125mhzref|non_pcie
		parameter pma_rx_buf_pm_tx_rx_pcie_gen_bitwidth = "pcie_gen3_32b", // pcie_gen3_32b|pcie_gen3_16b
		parameter pma_rx_buf_prot_mode = "basic_rx", // basic_rx|pcie_gen1_rx|pcie_gen2_rx|pcie_gen3_rx|pcie_gen4_rx|qpi_rx|unused|gpon_rx|sata_rx
		parameter pma_rx_buf_qpi_enable = "non_qpi_mode", // non_qpi_mode|qpi_mode
		parameter pma_rx_buf_refclk_en = "enable", // disable|enable
		parameter pma_rx_buf_rx_refclk_divider = "bypass_divider", // bypass_divider|divide_by_2
		parameter pma_rx_buf_sup_mode = "user_mode", // user_mode|engineering_mode
		parameter pma_rx_buf_xrx_path_datarate = "0 bps", // 
		parameter pma_rx_buf_xrx_path_datawidth = 8'b0,
		parameter pma_rx_buf_xrx_path_pma_rx_divclk_hz = 32'b0,
		parameter pma_rx_buf_xrx_path_prot_mode = "unused", // basic_rx|pcie_gen1_rx|pcie_gen2_rx|pcie_gen3_rx|pcie_gen4_rx|qpi_rx|unused|gpon_rx|sata_rx
		parameter pma_rx_buf_xrx_path_sup_mode = "user_mode", // user_mode|engineering_mode
		parameter pma_rx_buf_xrx_path_uc_cal_enable = "rx_cal_off", // rx_cal_off|rx_cal_on
		
		// parameters for twentynm_hssi_pma_rx_deser
		parameter pma_rx_deser_bitslip_bypass = "bs_bypass_no", // bs_bypass_no|bs_bypass_yes
		parameter pma_rx_deser_clkdiv_source = "vco_bypass_normal", // vco_bypass_normal|clklow_to_clkdivrx|fref_to_clkdivrx
		parameter pma_rx_deser_clkdivrx_user_mode = "clkdivrx_user_disabled", // clkdivrx_user_disabled|clkdivrx_user_clkdiv|clkdivrx_user_clkdiv_div2|clkdivrx_user_div40|clkdivrx_user_div33|clkdivrx_user_div66
		parameter pma_rx_deser_datarate = "0 bps", // 
		parameter pma_rx_deser_deser_factor = 8, // 8|10|16|20|32|40|64
		parameter pma_rx_deser_force_clkdiv_for_testing = "normal_clkdiv", // normal_clkdiv|forced_0|forced_1
		parameter pma_rx_deser_pcie_gen = "non_pcie", // pcie_gen1_100mhzref|pcie_gen2_100mhzref|pcie_gen3_100mhzref|pcie_gen1_125mhzref|pcie_gen2_125mhzref|pcie_gen3_125mhzref|non_pcie
		parameter pma_rx_deser_pcie_gen_bitwidth = "pcie_gen3_32b", // pcie_gen3_32b|pcie_gen3_16b
		parameter pma_rx_deser_prot_mode = "basic_rx", // basic_rx|pcie_gen1_rx|pcie_gen2_rx|pcie_gen3_rx|pcie_gen4_rx|qpi_rx|unused|gpon_rx|sata_rx
		parameter pma_rx_deser_rst_n_adapt_odi = "no_rst_adapt_odi", // yes_rst_adapt_odi|no_rst_adapt_odi
		parameter pma_rx_deser_sdclk_enable = "false", // false|true
		parameter pma_rx_deser_sup_mode = "user_mode", // user_mode|engineering_mode
		
		// parameters for twentynm_hssi_pma_rx_dfe
		parameter pma_rx_dfe_datarate = "0 bps", // 
		parameter pma_rx_dfe_dft_en = "dft_disable", // dft_disable|dft_enalbe
		parameter pma_rx_dfe_pdb = "dfe_enable", // dfe_powerdown|dfe_reset|dfe_enable
		parameter pma_rx_dfe_pdb_fixedtap = "fixtap_dfe_powerdown", // fixtap_dfe_powerdown|fixtap_dfe_enable
		parameter pma_rx_dfe_pdb_floattap = "floattap_dfe_powerdown", // floattap_dfe_powerdown|floattap_dfe_enable
		parameter pma_rx_dfe_pdb_fxtap4t7 = "fxtap4t7_powerdown", // fxtap4t7_powerdown|fxtap4t7_enable
		parameter pma_rx_dfe_prot_mode = "basic_rx", // basic_rx|pcie_gen1_rx|pcie_gen2_rx|pcie_gen3_rx|pcie_gen4_rx|qpi_rx|unused|gpon_rx|sata_rx
		parameter pma_rx_dfe_sup_mode = "user_mode", // user_mode|engineering_mode
		
		// parameters for twentynm_hssi_pma_rx_odi
		parameter pma_rx_odi_datarate = "0 bps", // 
		parameter pma_rx_odi_prot_mode = "basic_rx", // basic_rx|pcie_gen1_rx|pcie_gen2_rx|pcie_gen3_rx|pcie_gen4_rx|qpi_rx|unused|gpon_rx|sata_rx
		parameter pma_rx_odi_step_ctrl_sel = "feedback_mode", // dprio_mode|feedback_mode|jm_mode
		parameter pma_rx_odi_sup_mode = "user_mode", // user_mode|engineering_mode
		
		// parameters for twentynm_hssi_pma_rx_sd
		parameter pma_rx_sd_prot_mode = "basic_rx", // basic_rx|pcie_gen1_rx|pcie_gen2_rx|pcie_gen3_rx|pcie_gen4_rx|qpi_rx|unused|gpon_rx|sata_rx
		parameter pma_rx_sd_sd_output_off = 1, // 0..28
		parameter pma_rx_sd_sd_output_on = 1, // 0..15
		parameter pma_rx_sd_sd_pdb = "sd_off", // sd_on|sd_off
		parameter pma_rx_sd_sup_mode = "user_mode", // user_mode|engineering_mode
		
		// parameters for twentynm_hssi_pma_tx_buf
		parameter pma_tx_buf_datarate = "0 bps", // 
		parameter pma_tx_buf_mcgb_location_for_pcie = 4'b0,
		parameter pma_tx_buf_prot_mode = "basic_tx", // unused|basic_tx|pcie_gen1_tx|pcie_gen2_tx|pcie_gen3_tx|pcie_gen4_tx|qpi_tx|gpon_tx|sata_tx
		parameter pma_tx_buf_rx_det = "mode_0", // mode_0|mode_1|mode_2|mode_3|mode_4|mode_5|mode_6|mode_7|mode_8|mode_9|mode_10|mode_11|mode_12|mode_13|mode_14|mode_15
		parameter pma_tx_buf_rx_det_output_sel = "rx_det_pcie_out", // rx_det_pcie_out|rx_det_qpi_out
		parameter pma_tx_buf_rx_det_pdb = "rx_det_off", // rx_det_off|rx_det_on
		parameter pma_tx_buf_sup_mode = "user_mode", // user_mode|engineering_mode
		parameter pma_tx_buf_user_fir_coeff_ctrl_sel = "ram_ctl", // ram_ctl|dynamic_ctl
		parameter pma_tx_buf_xtx_path_clock_divider_ratio = 4'b0,
		parameter pma_tx_buf_xtx_path_datarate = "0 bps", // 
		parameter pma_tx_buf_xtx_path_datawidth = 8'b0,
		parameter pma_tx_buf_xtx_path_pma_tx_divclk_hz = 32'b0,
		parameter pma_tx_buf_xtx_path_prot_mode = "basic_tx", // unused|basic_tx|pcie_gen1_tx|pcie_gen2_tx|pcie_gen3_tx|pcie_gen4_tx|qpi_tx|gpon_tx|sata_tx
		parameter pma_tx_buf_xtx_path_sup_mode = "user_mode", // user_mode|engineering_mode
		parameter pma_tx_buf_xtx_path_tx_pll_clk_hz = "0 hz", // 
		
		// parameters for twentynm_hssi_pma_tx_cgb
		parameter pma_cgb_bitslip_enable = "enable_bitslip", // disable_bitslip|enable_bitslip
		parameter pma_cgb_bonding_reset_enable = "allow_bonding_reset", // disallow_bonding_reset|allow_bonding_reset
		parameter pma_cgb_datarate = "0 bps", // 
		parameter pma_cgb_input_select_gen3 = "unused", // lcpll_bot|lcpll_top|fpll_bot|fpll_top|cdr_txpll_b|cdr_txpll_t|same_ch_txpll|lcpll_hs|hfclk_xn_up|hfclk_x6_dn|hfclk_xn_dn|hfclk_x6_up|unused
		parameter pma_cgb_input_select_x1 = "unused", // lcpll_bot|lcpll_top|fpll_bot|fpll_top|cdr_txpll_b|cdr_txpll_t|same_ch_txpll|lcpll_hs|hfclk_xn_up|hfclk_x6_dn|hfclk_xn_dn|hfclk_x6_up|unused
		parameter pma_cgb_input_select_xn = "unused", // sel_xn_up|sel_xn_dn|sel_x6_up|sel_x6_dn|sel_cgb_loc|unused
		parameter pma_cgb_pcie_gen3_bitwidth = "pciegen3_wide", // pciegen3_wide|pciegen3_narrow
		parameter pma_cgb_prot_mode = "basic_tx", // unused|basic_tx|pcie_gen1_tx|pcie_gen2_tx|pcie_gen3_tx|pcie_gen4_tx|qpi_tx|gpon_tx|sata_tx
		parameter pma_cgb_scratch0_x1_clock_src = "unused", // lcpll_bot|lcpll_top|fpll_bot|fpll_top|cdr_txpll_b|cdr_txpll_t|same_ch_txpll|lcpll_hs|hfclk_xn_up|hfclk_x6_dn|hfclk_xn_dn|hfclk_x6_up|unused
		parameter pma_cgb_scratch1_x1_clock_src = "unused", // lcpll_bot|lcpll_top|fpll_bot|fpll_top|cdr_txpll_b|cdr_txpll_t|same_ch_txpll|lcpll_hs|hfclk_xn_up|hfclk_x6_dn|hfclk_xn_dn|hfclk_x6_up|unused
		parameter pma_cgb_scratch2_x1_clock_src = "unused", // lcpll_bot|lcpll_top|fpll_bot|fpll_top|cdr_txpll_b|cdr_txpll_t|same_ch_txpll|lcpll_hs|hfclk_xn_up|hfclk_x6_dn|hfclk_xn_dn|hfclk_x6_up|unused
		parameter pma_cgb_scratch3_x1_clock_src = "unused", // lcpll_bot|lcpll_top|fpll_bot|fpll_top|cdr_txpll_b|cdr_txpll_t|same_ch_txpll|lcpll_hs|hfclk_xn_up|hfclk_x6_dn|hfclk_xn_dn|hfclk_x6_up|unused
		parameter pma_cgb_select_done_master_or_slave = "choose_slave_pcie_sw_done", // choose_master_pcie_sw_done|choose_slave_pcie_sw_done
		parameter pma_cgb_ser_mode = "eight_bit", // eight_bit|ten_bit|sixteen_bit|twenty_bit|thirty_two_bit|forty_bit|sixty_four_bit
		parameter pma_cgb_sup_mode = "user_mode", // user_mode|engineering_mode
		parameter pma_cgb_tx_ucontrol_en = "disable", // disable|enable
		parameter pma_cgb_x1_div_m_sel = "divbypass", // divbypass|divby2|divby4|divby8
		
		// parameters for twentynm_hssi_pma_tx_ser
		parameter pma_tx_ser_prot_mode = "basic_tx", // unused|basic_tx|pcie_gen1_tx|pcie_gen2_tx|pcie_gen3_tx|pcie_gen4_tx|qpi_tx|gpon_tx|sata_tx
		parameter pma_tx_ser_ser_clk_divtx_user_sel = "divtx_user_33", // divtx_user_2|divtx_user_40|divtx_user_33|divtx_user_66|divtx_user_1|divtx_user_off
		parameter pma_tx_ser_sup_mode = "user_mode" // user_mode|engineering_mode
	//PARAM_LIST_END
	)
	(
	//PORT_LIST_START
		input wire		in_adapt_start,
		input wire	[8:0]	in_avmmaddress,
		input wire		in_avmmclk,
		input wire		in_avmmread,
		input wire		in_avmmrstn,
		input wire		in_avmmwrite,
		input wire	[7:0]	in_avmmwritedata,
		input wire		in_clk_cdr_b,
		input wire		in_clk_cdr_t,
		input wire		in_clk_fpll_b,
		input wire		in_clk_fpll_t,
		input wire		in_clk_lc_b,
		input wire		in_clk_lc_hs,
		input wire		in_clk_lc_t,
		input wire		in_clkb_cdr_b,
		input wire		in_clkb_cdr_t,
		input wire		in_clkb_fpll_b,
		input wire		in_clkb_fpll_t,
		input wire		in_clkb_lc_b,
		input wire		in_clkb_lc_hs,
		input wire		in_clkb_lc_t,
		input wire		in_core_refclk_in,
		input wire	[5:0]	in_cpulse_x6_dn_bus,
		input wire	[5:0]	in_cpulse_x6_up_bus,
		input wire	[5:0]	in_cpulse_xn_dn_bus,
		input wire	[5:0]	in_cpulse_xn_up_bus,
		input wire		in_early_eios,
		input wire	[5:0]	in_eye_monitor,
		input wire	[1:0]	in_fpll_ppm_clk_in,
		input wire	[17:0]	in_i_coeff,
		input wire	[2:0]	in_i_rxpreset,
		input wire	[5:0]	in_iqtxrxclk,
		input wire		in_ltd_b,
		input wire		in_ltr,
		input wire	[1:0]	in_pcie_sw,
		input wire	[1:0]	in_pcie_sw_done_master_in,
		input wire		in_pma_atpg_los_en_n_in,
		input wire	[4:0]	in_pma_reserved_out,
		input wire		in_ppm_lock,
		input wire	[11:0]	in_ref_iqclk,
		input wire		in_rs_lpbk_b,
		input wire	[5:0]	in_rx50_buf_in,
		input wire		in_rx_bitslip,
		input wire		in_rx_n,
		input wire		in_rx_p,
		input wire		in_rx_pma_rstb,
		input wire		in_rx_qpi_pulldn,
		input wire		in_scan_mode_n,
		input wire		in_scan_shift_n,
		input wire	[8:0]	in_tx50_buf_in,
		input wire		in_tx_bitslip,
		input wire		in_tx_bonding_rstb,
		input wire	[63:0]	in_tx_data,
		input wire		in_tx_det_rx,
		input wire		in_tx_elec_idle,
		input wire		in_tx_pma_rstb,
		input wire		in_tx_qpi_pulldn,
		input wire		in_tx_qpi_pullup,
		output wire	[7:0]	out_avmmreaddata_cdr_pll,
		output wire	[7:0]	out_avmmreaddata_pma_adapt,
		output wire	[7:0]	out_avmmreaddata_pma_cdr_refclk,
		output wire	[7:0]	out_avmmreaddata_pma_cgb,
		output wire	[7:0]	out_avmmreaddata_pma_rx_buf,
		output wire	[7:0]	out_avmmreaddata_pma_rx_deser,
		output wire	[7:0]	out_avmmreaddata_pma_rx_dfe,
		output wire	[7:0]	out_avmmreaddata_pma_rx_odi,
		output wire	[7:0]	out_avmmreaddata_pma_rx_sd,
		output wire	[7:0]	out_avmmreaddata_pma_tx_buf,
		output wire	[7:0]	out_avmmreaddata_pma_tx_ser,
		output wire		out_blockselect_cdr_pll,
		output wire		out_blockselect_pma_adapt,
		output wire		out_blockselect_pma_cdr_refclk,
		output wire		out_blockselect_pma_cgb,
		output wire		out_blockselect_pma_rx_buf,
		output wire		out_blockselect_pma_rx_deser,
		output wire		out_blockselect_pma_rx_dfe,
		output wire		out_blockselect_pma_rx_odi,
		output wire		out_blockselect_pma_rx_sd,
		output wire		out_blockselect_pma_tx_buf,
		output wire		out_blockselect_pma_tx_ser,
		output wire		out_clk0_pfd,
		output wire		out_clk180_pfd,
		output wire		out_clk_divrx_iqtxrx,
		output wire		out_clk_divtx_iqtxrx,
		output wire		out_clkdiv_rx,
		output wire		out_clkdiv_rx_user,
		output wire		out_clkdiv_tx,
		output wire		out_clkdiv_tx_user,
		output wire		out_clklow,
		output wire		out_fref,
		output wire		out_iqtxrxclk_out0,
		output wire		out_iqtxrxclk_out1,
		output wire		out_jtaglpxn,
		output wire		out_jtaglpxp,
		output wire	[1:0]	out_pcie_sw_done,
		output wire	[1:0]	out_pcie_sw_master,
		output wire		out_pfdmode_lock,
		output wire		out_rx_detect_valid,
		output wire		out_rx_found,
		output wire	[63:0]	out_rxdata,
		output wire		out_rxpll_lock,
		output wire		out_sd,
		output wire		out_tx_n,
		output wire		out_tx_p
	//PORT_LIST_END
	);
	//wire declarations
	
	// wires for module twentynm_hssi_pma_rx_dfe
	wire	[7:0]	w_pma_rx_dfe_avmmreaddata;
	wire		w_pma_rx_dfe_blockselect;
	wire		w_pma_rx_dfe_clk0_bbpd;
	wire		w_pma_rx_dfe_clk180_bbpd;
	wire		w_pma_rx_dfe_clk270_bbpd;
	wire		w_pma_rx_dfe_clk90_bbpd;
	wire		w_pma_rx_dfe_deven;
	wire		w_pma_rx_dfe_devenb;
	wire	[7:0]	w_pma_rx_dfe_dfe_oc_tstmx;
	wire		w_pma_rx_dfe_dodd;
	wire		w_pma_rx_dfe_doddb;
	wire		w_pma_rx_dfe_edge270;
	wire		w_pma_rx_dfe_edge270b;
	wire		w_pma_rx_dfe_edge90;
	wire		w_pma_rx_dfe_edge90b;
	wire		w_pma_rx_dfe_err_ev;
	wire		w_pma_rx_dfe_err_evb;
	wire		w_pma_rx_dfe_err_od;
	wire		w_pma_rx_dfe_err_odb;
	wire		w_pma_rx_dfe_spec_vrefh;
	wire		w_pma_rx_dfe_spec_vrefl;
	
	// wires for module twentynm_hssi_pma_tx_ser
	wire	[7:0]	w_pma_tx_ser_avmmreaddata;
	wire		w_pma_tx_ser_blockselect;
	wire		w_pma_tx_ser_ckdrvn;
	wire		w_pma_tx_ser_ckdrvp;
	wire		w_pma_tx_ser_clk_divtx;
	wire		w_pma_tx_ser_clk_divtx_user;
	wire		w_pma_tx_ser_oe;
	wire		w_pma_tx_ser_oeb;
	wire		w_pma_tx_ser_oo;
	wire		w_pma_tx_ser_oob;
	
	// wires for module twentynm_hssi_pma_tx_buf
	wire	[2:0]	w_pma_tx_buf_atbsel;
	wire	[7:0]	w_pma_tx_buf_avmmreaddata;
	wire		w_pma_tx_buf_blockselect;
	wire		w_pma_tx_buf_ckn;
	wire		w_pma_tx_buf_ckp;
	wire		w_pma_tx_buf_dcd_out1;
	wire		w_pma_tx_buf_dcd_out2;
	wire		w_pma_tx_buf_dcd_out_ready;
	wire	[1:0]	w_pma_tx_buf_detect_on;
	wire		w_pma_tx_buf_lbvon;
	wire		w_pma_tx_buf_lbvop;
	wire		w_pma_tx_buf_rx_detect_valid;
	wire		w_pma_tx_buf_rx_found;
	wire		w_pma_tx_buf_rx_found_pcie_spl_test;
	wire		w_pma_tx_buf_sel_vreg;
	wire		w_pma_tx_buf_spl_clk_test;
	wire	[7:0]	w_pma_tx_buf_tx_dftout;
	wire		w_pma_tx_buf_vlptxn;
	wire		w_pma_tx_buf_vlptxp;
	wire		w_pma_tx_buf_von;
	wire		w_pma_tx_buf_vop;
	
	// wires for module twentynm_hssi_pma_tx_cgb
	wire	[7:0]	w_pma_cgb_avmmreaddata;
	wire		w_pma_cgb_bitslipstate;
	wire		w_pma_cgb_blockselect;
	wire	[5:0]	w_pma_cgb_cpulse_out_bus;
	wire		w_pma_cgb_div2;
	wire		w_pma_cgb_div4;
	wire		w_pma_cgb_div5;
	wire		w_pma_cgb_hifreqclkn;
	wire		w_pma_cgb_hifreqclkp;
	wire	[1:0]	w_pma_cgb_pcie_sw_done;
	wire	[1:0]	w_pma_cgb_pcie_sw_master;
	wire		w_pma_cgb_rstb;
	
	// wires for module twentynm_hssi_pma_rx_sd
	wire	[7:0]	w_pma_rx_sd_avmmreaddata;
	wire		w_pma_rx_sd_blockselect;
	wire		w_pma_rx_sd_sd;
	
	// wires for module twentynm_hssi_pma_rx_deser
	wire		w_pma_rx_deser_adapt_clk;
	wire	[7:0]	w_pma_rx_deser_avmmreaddata;
	wire		w_pma_rx_deser_blockselect;
	wire		w_pma_rx_deser_clkdiv;
	wire		w_pma_rx_deser_clkdiv_user;
	wire		w_pma_rx_deser_clkdivrx_rx;
	wire	[63:0]	w_pma_rx_deser_data;
	wire	[63:0]	w_pma_rx_deser_dout;
	wire	[63:0]	w_pma_rx_deser_error_deser;
	wire	[63:0]	w_pma_rx_deser_odi_dout;
	wire	[1:0]	w_pma_rx_deser_pcie_sw_ret;
	wire	[7:0]	w_pma_rx_deser_tstmx_deser;
	
	// wires for module twentynm_hssi_pma_cdr_refclk_select_mux
	wire	[7:0]	w_pma_cdr_refclk_avmmreaddata;
	wire		w_pma_cdr_refclk_blockselect;
	wire		w_pma_cdr_refclk_refclk;
	wire		w_pma_cdr_refclk_rx_det_clk;
	
	// wires for module twentynm_hssi_pma_adaptation
	wire	[7:0]	w_pma_adapt_avmmreaddata;
	wire		w_pma_adapt_blockselect;
	wire	[27:0]	w_pma_adapt_ctle_acgain_4s;
	wire	[14:0]	w_pma_adapt_ctle_eqz_1s_sel;
	wire	[6:0]	w_pma_adapt_ctle_lfeq_fb_sel;
	wire		w_pma_adapt_dfe_adapt_en;
	wire		w_pma_adapt_dfe_adp_clk;
	wire	[5:0]	w_pma_adapt_dfe_fltap1;
	wire		w_pma_adapt_dfe_fltap1_sgn;
	wire	[5:0]	w_pma_adapt_dfe_fltap2;
	wire		w_pma_adapt_dfe_fltap2_sgn;
	wire	[5:0]	w_pma_adapt_dfe_fltap3;
	wire		w_pma_adapt_dfe_fltap3_sgn;
	wire	[5:0]	w_pma_adapt_dfe_fltap4;
	wire		w_pma_adapt_dfe_fltap4_sgn;
	wire		w_pma_adapt_dfe_fltap_bypdeser;
	wire	[5:0]	w_pma_adapt_dfe_fltap_position;
	wire	[6:0]	w_pma_adapt_dfe_fxtap1;
	wire	[6:0]	w_pma_adapt_dfe_fxtap2;
	wire		w_pma_adapt_dfe_fxtap2_sgn;
	wire	[6:0]	w_pma_adapt_dfe_fxtap3;
	wire		w_pma_adapt_dfe_fxtap3_sgn;
	wire	[5:0]	w_pma_adapt_dfe_fxtap4;
	wire		w_pma_adapt_dfe_fxtap4_sgn;
	wire	[5:0]	w_pma_adapt_dfe_fxtap5;
	wire		w_pma_adapt_dfe_fxtap5_sgn;
	wire	[4:0]	w_pma_adapt_dfe_fxtap6;
	wire		w_pma_adapt_dfe_fxtap6_sgn;
	wire	[4:0]	w_pma_adapt_dfe_fxtap7;
	wire		w_pma_adapt_dfe_fxtap7_sgn;
	wire		w_pma_adapt_dfe_spec_disable;
	wire		w_pma_adapt_dfe_spec_sign_sel;
	wire		w_pma_adapt_dfe_vref_sign_sel;
	wire	[4:0]	w_pma_adapt_odi_vref;
	wire	[6:0]	w_pma_adapt_vga_sel;
	wire	[4:0]	w_pma_adapt_vref_sel;
	
	// wires for module twentynm_hssi_pma_rx_odi
	wire	[7:0]	w_pma_rx_odi_avmmreaddata;
	wire		w_pma_rx_odi_blockselect;
	wire		w_pma_rx_odi_clk0_eye;
	wire		w_pma_rx_odi_clk0_eye_lb;
	wire		w_pma_rx_odi_clk180_eye;
	wire		w_pma_rx_odi_clk180_eye_lb;
	wire		w_pma_rx_odi_de_eye;
	wire		w_pma_rx_odi_deb_eye;
	wire		w_pma_rx_odi_do_eye;
	wire		w_pma_rx_odi_dob_eye;
	wire		w_pma_rx_odi_odi_en;
	wire	[1:0]	w_pma_rx_odi_odi_oc_tstmx;
	
	// wires for module twentynm_hssi_pma_channel_pll
	wire	[7:0]	w_cdr_pll_avmmreaddata;
	wire		w_cdr_pll_blockselect;
	wire		w_cdr_pll_cdr_cnt_done;
	wire	[11:0]	w_cdr_pll_cdr_refclk_cal_out;
	wire	[11:0]	w_cdr_pll_cdr_vco_cal_out;
	wire		w_cdr_pll_clk0_des;
	wire		w_cdr_pll_clk0_odi;
	wire		w_cdr_pll_clk0_pd;
	wire		w_cdr_pll_clk0_pfd;
	wire		w_cdr_pll_clk180_des;
	wire		w_cdr_pll_clk180_odi;
	wire		w_cdr_pll_clk180_pd;
	wire		w_cdr_pll_clk180_pfd;
	wire		w_cdr_pll_clk270_odi;
	wire		w_cdr_pll_clk270_pd;
	wire		w_cdr_pll_clk90_odi;
	wire		w_cdr_pll_clk90_pd;
	wire		w_cdr_pll_clklow;
	wire		w_cdr_pll_deven_des;
	wire		w_cdr_pll_devenb_des;
	wire		w_cdr_pll_dodd_des;
	wire		w_cdr_pll_doddb_des;
	wire		w_cdr_pll_error_even_des;
	wire		w_cdr_pll_error_evenb_des;
	wire		w_cdr_pll_error_odd_des;
	wire		w_cdr_pll_error_oddb_des;
	wire		w_cdr_pll_fref;
	wire		w_cdr_pll_overrange;
	wire		w_cdr_pll_pfdmode_lock;
	wire		w_cdr_pll_rlpbkdn;
	wire		w_cdr_pll_rlpbkdp;
	wire		w_cdr_pll_rlpbkn;
	wire		w_cdr_pll_rlpbkp;
	wire		w_cdr_pll_rxpll_lock;
	wire		w_cdr_pll_tx_rlpbk;
	wire		w_cdr_pll_underrange;
	
	// wires for module twentynm_hssi_pma_rx_buf
	wire	[7:0]	w_pma_rx_buf_avmmreaddata;
	wire		w_pma_rx_buf_blockselect;
	wire		w_pma_rx_buf_inn;
	wire		w_pma_rx_buf_inp;
	wire		w_pma_rx_buf_outn;
	wire		w_pma_rx_buf_outp;
	wire		w_pma_rx_buf_pull_dn;
	wire		w_pma_rx_buf_rdlpbkn;
	wire		w_pma_rx_buf_rdlpbkp;
	
	
	generate
		
		//module instantiations
		
		// instantiating twentynm_hssi_pma_adaptation
		if ((xcvr_native_mode == "mode_rx_only") || (xcvr_native_mode == "mode_duplex")) begin:gen_twentynm_hssi_pma_adaptation
			twentynm_hssi_pma_adaptation #(
				.adapt_mode(pma_adapt_adapt_mode),
				.adp_1s_ctle_bypass(pma_adapt_adp_1s_ctle_bypass),
				.adp_4s_ctle_bypass(pma_adapt_adp_4s_ctle_bypass),
				.adp_ctle_adapt_cycle_window(pma_adapt_adp_ctle_adapt_cycle_window),
				.adp_ctle_en(pma_adapt_adp_ctle_en),
				.adp_dfe_fltap_bypass(pma_adapt_adp_dfe_fltap_bypass),
				.adp_dfe_fltap_en(pma_adapt_adp_dfe_fltap_en),
				.adp_dfe_fxtap_bypass(pma_adapt_adp_dfe_fxtap_bypass),
				.adp_dfe_fxtap_en(pma_adapt_adp_dfe_fxtap_en),
				.adp_dfe_fxtap_hold_en(pma_adapt_adp_dfe_fxtap_hold_en),
				.adp_dfe_mode(pma_adapt_adp_dfe_mode),
				.adp_mode(pma_adapt_adp_mode),
				.adp_onetime_dfe(pma_adapt_adp_onetime_dfe),
				.adp_vga_bypass(pma_adapt_adp_vga_bypass),
				.adp_vga_en(pma_adapt_adp_vga_en),
				.adp_vref_bypass(pma_adapt_adp_vref_bypass),
				.adp_vref_en(pma_adapt_adp_vref_en),
				.datarate(pma_adapt_datarate),
				.initial_settings("true"),       //PARAM_HIDE
				.odi_dfe_spec_en(pma_adapt_odi_dfe_spec_en),
				.optimal("false"),       //PARAM_HIDE
				.prot_mode(pma_adapt_prot_mode),
				.silicon_rev( "20nm3" ),       //PARAM_HIDE
				.sup_mode(pma_adapt_sup_mode)
			) inst_twentynm_hssi_pma_adaptation (
				// OUTPUTS
				.avmmreaddata(w_pma_adapt_avmmreaddata),
				.blockselect(w_pma_adapt_blockselect),
				.ctle_acgain_4s(w_pma_adapt_ctle_acgain_4s),
				.ctle_eqz_1s_sel(w_pma_adapt_ctle_eqz_1s_sel),
				.ctle_lfeq_fb_sel(w_pma_adapt_ctle_lfeq_fb_sel),
				.dfe_adapt_en(w_pma_adapt_dfe_adapt_en),
				.dfe_adp_clk(w_pma_adapt_dfe_adp_clk),
				.dfe_fltap1(w_pma_adapt_dfe_fltap1),
				.dfe_fltap1_sgn(w_pma_adapt_dfe_fltap1_sgn),
				.dfe_fltap2(w_pma_adapt_dfe_fltap2),
				.dfe_fltap2_sgn(w_pma_adapt_dfe_fltap2_sgn),
				.dfe_fltap3(w_pma_adapt_dfe_fltap3),
				.dfe_fltap3_sgn(w_pma_adapt_dfe_fltap3_sgn),
				.dfe_fltap4(w_pma_adapt_dfe_fltap4),
				.dfe_fltap4_sgn(w_pma_adapt_dfe_fltap4_sgn),
				.dfe_fltap_bypdeser(w_pma_adapt_dfe_fltap_bypdeser),
				.dfe_fltap_position(w_pma_adapt_dfe_fltap_position),
				.dfe_fxtap1(w_pma_adapt_dfe_fxtap1),
				.dfe_fxtap2(w_pma_adapt_dfe_fxtap2),
				.dfe_fxtap2_sgn(w_pma_adapt_dfe_fxtap2_sgn),
				.dfe_fxtap3(w_pma_adapt_dfe_fxtap3),
				.dfe_fxtap3_sgn(w_pma_adapt_dfe_fxtap3_sgn),
				.dfe_fxtap4(w_pma_adapt_dfe_fxtap4),
				.dfe_fxtap4_sgn(w_pma_adapt_dfe_fxtap4_sgn),
				.dfe_fxtap5(w_pma_adapt_dfe_fxtap5),
				.dfe_fxtap5_sgn(w_pma_adapt_dfe_fxtap5_sgn),
				.dfe_fxtap6(w_pma_adapt_dfe_fxtap6),
				.dfe_fxtap6_sgn(w_pma_adapt_dfe_fxtap6_sgn),
				.dfe_fxtap7(w_pma_adapt_dfe_fxtap7),
				.dfe_fxtap7_sgn(w_pma_adapt_dfe_fxtap7_sgn),
				.dfe_spec_disable(w_pma_adapt_dfe_spec_disable),
				.dfe_spec_sign_sel(w_pma_adapt_dfe_spec_sign_sel),
				.dfe_vref_sign_sel(w_pma_adapt_dfe_vref_sign_sel),
				.odi_vref(w_pma_adapt_odi_vref),
				.vga_sel(w_pma_adapt_vga_sel),
				.vref_sel(w_pma_adapt_vref_sel),
				// INPUTS
				.adapt_reset(in_pma_reserved_out[4]),
				.adapt_start(in_adapt_start),
				.avmmaddress({in_avmmaddress[8], in_avmmaddress[7], in_avmmaddress[6], in_avmmaddress[5], in_avmmaddress[4], in_avmmaddress[3], in_avmmaddress[2], in_avmmaddress[1], in_avmmaddress[0]}),
				.avmmclk(in_avmmclk),
				.avmmread(in_avmmread),
				.avmmrstn(in_avmmrstn),
				.avmmwrite(in_avmmwrite),
				.avmmwritedata({in_avmmwritedata[7], in_avmmwritedata[6], in_avmmwritedata[5], in_avmmwritedata[4], in_avmmwritedata[3], in_avmmwritedata[2], in_avmmwritedata[1], in_avmmwritedata[0]}),
				.deser_clk(w_pma_rx_deser_adapt_clk),
				.deser_data({w_pma_rx_deser_data[63], w_pma_rx_deser_data[62], w_pma_rx_deser_data[61], w_pma_rx_deser_data[60], w_pma_rx_deser_data[59], w_pma_rx_deser_data[58], w_pma_rx_deser_data[57], w_pma_rx_deser_data[56], w_pma_rx_deser_data[55], w_pma_rx_deser_data[54], w_pma_rx_deser_data[53], w_pma_rx_deser_data[52], w_pma_rx_deser_data[51], w_pma_rx_deser_data[50], w_pma_rx_deser_data[49], w_pma_rx_deser_data[48], w_pma_rx_deser_data[47], w_pma_rx_deser_data[46], w_pma_rx_deser_data[45], w_pma_rx_deser_data[44], w_pma_rx_deser_data[43], w_pma_rx_deser_data[42], w_pma_rx_deser_data[41], w_pma_rx_deser_data[40], w_pma_rx_deser_data[39], w_pma_rx_deser_data[38], w_pma_rx_deser_data[37], w_pma_rx_deser_data[36], w_pma_rx_deser_data[35], w_pma_rx_deser_data[34], w_pma_rx_deser_data[33], w_pma_rx_deser_data[32], w_pma_rx_deser_data[31], w_pma_rx_deser_data[30], w_pma_rx_deser_data[29], w_pma_rx_deser_data[28], w_pma_rx_deser_data[27], w_pma_rx_deser_data[26], w_pma_rx_deser_data[25], w_pma_rx_deser_data[24], w_pma_rx_deser_data[23], w_pma_rx_deser_data[22], w_pma_rx_deser_data[21], w_pma_rx_deser_data[20], w_pma_rx_deser_data[19], w_pma_rx_deser_data[18], w_pma_rx_deser_data[17], w_pma_rx_deser_data[16], w_pma_rx_deser_data[15], w_pma_rx_deser_data[14], w_pma_rx_deser_data[13], w_pma_rx_deser_data[12], w_pma_rx_deser_data[11], w_pma_rx_deser_data[10], w_pma_rx_deser_data[9], w_pma_rx_deser_data[8], w_pma_rx_deser_data[7], w_pma_rx_deser_data[6], w_pma_rx_deser_data[5], w_pma_rx_deser_data[4], w_pma_rx_deser_data[3], w_pma_rx_deser_data[2], w_pma_rx_deser_data[1], w_pma_rx_deser_data[0]}),
				.deser_error({w_pma_rx_deser_error_deser[63], w_pma_rx_deser_error_deser[62], w_pma_rx_deser_error_deser[61], w_pma_rx_deser_error_deser[60], w_pma_rx_deser_error_deser[59], w_pma_rx_deser_error_deser[58], w_pma_rx_deser_error_deser[57], w_pma_rx_deser_error_deser[56], w_pma_rx_deser_error_deser[55], w_pma_rx_deser_error_deser[54], w_pma_rx_deser_error_deser[53], w_pma_rx_deser_error_deser[52], w_pma_rx_deser_error_deser[51], w_pma_rx_deser_error_deser[50], w_pma_rx_deser_error_deser[49], w_pma_rx_deser_error_deser[48], w_pma_rx_deser_error_deser[47], w_pma_rx_deser_error_deser[46], w_pma_rx_deser_error_deser[45], w_pma_rx_deser_error_deser[44], w_pma_rx_deser_error_deser[43], w_pma_rx_deser_error_deser[42], w_pma_rx_deser_error_deser[41], w_pma_rx_deser_error_deser[40], w_pma_rx_deser_error_deser[39], w_pma_rx_deser_error_deser[38], w_pma_rx_deser_error_deser[37], w_pma_rx_deser_error_deser[36], w_pma_rx_deser_error_deser[35], w_pma_rx_deser_error_deser[34], w_pma_rx_deser_error_deser[33], w_pma_rx_deser_error_deser[32], w_pma_rx_deser_error_deser[31], w_pma_rx_deser_error_deser[30], w_pma_rx_deser_error_deser[29], w_pma_rx_deser_error_deser[28], w_pma_rx_deser_error_deser[27], w_pma_rx_deser_error_deser[26], w_pma_rx_deser_error_deser[25], w_pma_rx_deser_error_deser[24], w_pma_rx_deser_error_deser[23], w_pma_rx_deser_error_deser[22], w_pma_rx_deser_error_deser[21], w_pma_rx_deser_error_deser[20], w_pma_rx_deser_error_deser[19], w_pma_rx_deser_error_deser[18], w_pma_rx_deser_error_deser[17], w_pma_rx_deser_error_deser[16], w_pma_rx_deser_error_deser[15], w_pma_rx_deser_error_deser[14], w_pma_rx_deser_error_deser[13], w_pma_rx_deser_error_deser[12], w_pma_rx_deser_error_deser[11], w_pma_rx_deser_error_deser[10], w_pma_rx_deser_error_deser[9], w_pma_rx_deser_error_deser[8], w_pma_rx_deser_error_deser[7], w_pma_rx_deser_error_deser[6], w_pma_rx_deser_error_deser[5], w_pma_rx_deser_error_deser[4], w_pma_rx_deser_error_deser[3], w_pma_rx_deser_error_deser[2], w_pma_rx_deser_error_deser[1], w_pma_rx_deser_error_deser[0]}),
				.deser_odi({w_pma_rx_deser_odi_dout[63], w_pma_rx_deser_odi_dout[62], w_pma_rx_deser_odi_dout[61], w_pma_rx_deser_odi_dout[60], w_pma_rx_deser_odi_dout[59], w_pma_rx_deser_odi_dout[58], w_pma_rx_deser_odi_dout[57], w_pma_rx_deser_odi_dout[56], w_pma_rx_deser_odi_dout[55], w_pma_rx_deser_odi_dout[54], w_pma_rx_deser_odi_dout[53], w_pma_rx_deser_odi_dout[52], w_pma_rx_deser_odi_dout[51], w_pma_rx_deser_odi_dout[50], w_pma_rx_deser_odi_dout[49], w_pma_rx_deser_odi_dout[48], w_pma_rx_deser_odi_dout[47], w_pma_rx_deser_odi_dout[46], w_pma_rx_deser_odi_dout[45], w_pma_rx_deser_odi_dout[44], w_pma_rx_deser_odi_dout[43], w_pma_rx_deser_odi_dout[42], w_pma_rx_deser_odi_dout[41], w_pma_rx_deser_odi_dout[40], w_pma_rx_deser_odi_dout[39], w_pma_rx_deser_odi_dout[38], w_pma_rx_deser_odi_dout[37], w_pma_rx_deser_odi_dout[36], w_pma_rx_deser_odi_dout[35], w_pma_rx_deser_odi_dout[34], w_pma_rx_deser_odi_dout[33], w_pma_rx_deser_odi_dout[32], w_pma_rx_deser_odi_dout[31], w_pma_rx_deser_odi_dout[30], w_pma_rx_deser_odi_dout[29], w_pma_rx_deser_odi_dout[28], w_pma_rx_deser_odi_dout[27], w_pma_rx_deser_odi_dout[26], w_pma_rx_deser_odi_dout[25], w_pma_rx_deser_odi_dout[24], w_pma_rx_deser_odi_dout[23], w_pma_rx_deser_odi_dout[22], w_pma_rx_deser_odi_dout[21], w_pma_rx_deser_odi_dout[20], w_pma_rx_deser_odi_dout[19], w_pma_rx_deser_odi_dout[18], w_pma_rx_deser_odi_dout[17], w_pma_rx_deser_odi_dout[16], w_pma_rx_deser_odi_dout[15], w_pma_rx_deser_odi_dout[14], w_pma_rx_deser_odi_dout[13], w_pma_rx_deser_odi_dout[12], w_pma_rx_deser_odi_dout[11], w_pma_rx_deser_odi_dout[10], w_pma_rx_deser_odi_dout[9], w_pma_rx_deser_odi_dout[8], w_pma_rx_deser_odi_dout[7], w_pma_rx_deser_odi_dout[6], w_pma_rx_deser_odi_dout[5], w_pma_rx_deser_odi_dout[4], w_pma_rx_deser_odi_dout[3], w_pma_rx_deser_odi_dout[2], w_pma_rx_deser_odi_dout[1], w_pma_rx_deser_odi_dout[0]}),
				.deser_odi_clk(1'b0),
				.global_pipe_se(in_pma_atpg_los_en_n_in),
				.i_rxpreset({in_i_rxpreset[2], in_i_rxpreset[1], in_i_rxpreset[0]}),
				.rx_pllfreqlock(w_cdr_pll_rxpll_lock),
				.scan_clk(in_core_refclk_in),
				.scan_in({in_pma_reserved_out[3], in_pma_reserved_out[2], in_pma_reserved_out[1], in_pma_reserved_out[0], in_eye_monitor[5], in_eye_monitor[4], in_eye_monitor[3], in_eye_monitor[2], in_eye_monitor[1], in_eye_monitor[0]}),
				.test_mode(in_scan_mode_n),
				.test_se(in_scan_shift_n),
				
				// UNUSED
				.radp_ctle_hold_en(),
				.radp_ctle_patt_en(),
				.radp_ctle_preset_sel(),
				.radp_enable_max_lfeq_scale(),
				.radp_lfeq_hold_en(),
				.radp_vga_polarity(),
				.scan_out(),
				.status_bus()
			);
		end // if generate
		else begin
				assign w_pma_adapt_avmmreaddata[7:0] = 8'b0;
				assign w_pma_adapt_blockselect = 1'b0;
				assign w_pma_adapt_ctle_acgain_4s[27:0] = 28'b0;
				assign w_pma_adapt_ctle_eqz_1s_sel[14:0] = 15'b0;
				assign w_pma_adapt_ctle_lfeq_fb_sel[6:0] = 7'b0;
				assign w_pma_adapt_dfe_adapt_en = 1'b0;
				assign w_pma_adapt_dfe_adp_clk = 1'b0;
				assign w_pma_adapt_dfe_fltap1[5:0] = 6'b0;
				assign w_pma_adapt_dfe_fltap1_sgn = 1'b0;
				assign w_pma_adapt_dfe_fltap2[5:0] = 6'b0;
				assign w_pma_adapt_dfe_fltap2_sgn = 1'b0;
				assign w_pma_adapt_dfe_fltap3[5:0] = 6'b0;
				assign w_pma_adapt_dfe_fltap3_sgn = 1'b0;
				assign w_pma_adapt_dfe_fltap4[5:0] = 6'b0;
				assign w_pma_adapt_dfe_fltap4_sgn = 1'b0;
				assign w_pma_adapt_dfe_fltap_bypdeser = 1'b0;
				assign w_pma_adapt_dfe_fltap_position[5:0] = 6'b0;
				assign w_pma_adapt_dfe_fxtap1[6:0] = 7'b0;
				assign w_pma_adapt_dfe_fxtap2[6:0] = 7'b0;
				assign w_pma_adapt_dfe_fxtap2_sgn = 1'b0;
				assign w_pma_adapt_dfe_fxtap3[6:0] = 7'b0;
				assign w_pma_adapt_dfe_fxtap3_sgn = 1'b0;
				assign w_pma_adapt_dfe_fxtap4[5:0] = 6'b0;
				assign w_pma_adapt_dfe_fxtap4_sgn = 1'b0;
				assign w_pma_adapt_dfe_fxtap5[5:0] = 6'b0;
				assign w_pma_adapt_dfe_fxtap5_sgn = 1'b0;
				assign w_pma_adapt_dfe_fxtap6[4:0] = 5'b0;
				assign w_pma_adapt_dfe_fxtap6_sgn = 1'b0;
				assign w_pma_adapt_dfe_fxtap7[4:0] = 5'b0;
				assign w_pma_adapt_dfe_fxtap7_sgn = 1'b0;
				assign w_pma_adapt_dfe_spec_disable = 1'b0;
				assign w_pma_adapt_dfe_spec_sign_sel = 1'b0;
				assign w_pma_adapt_dfe_vref_sign_sel = 1'b0;
				assign w_pma_adapt_odi_vref[4:0] = 5'b0;
				assign w_pma_adapt_vga_sel[6:0] = 7'b0;
				assign w_pma_adapt_vref_sel[4:0] = 5'b0;
		end // if not generate
		
		// instantiating twentynm_hssi_pma_cdr_refclk_select_mux
		if ((xcvr_native_mode == "mode_rx_only") || (xcvr_native_mode == "mode_duplex")) begin:gen_twentynm_hssi_pma_cdr_refclk_select_mux
			twentynm_hssi_pma_cdr_refclk_select_mux #(
				.inclk0_logical_to_physical_mapping(pma_cdr_refclk_inclk0_logical_to_physical_mapping),
				.inclk1_logical_to_physical_mapping(pma_cdr_refclk_inclk1_logical_to_physical_mapping),
				.inclk2_logical_to_physical_mapping(pma_cdr_refclk_inclk2_logical_to_physical_mapping),
				.inclk3_logical_to_physical_mapping(pma_cdr_refclk_inclk3_logical_to_physical_mapping),
				.inclk4_logical_to_physical_mapping(pma_cdr_refclk_inclk4_logical_to_physical_mapping),
				.powerdown_mode(pma_cdr_refclk_powerdown_mode),
				.refclk_select(pma_cdr_refclk_refclk_select),
				.silicon_rev( "20nm3" )       //PARAM_HIDE
			) inst_twentynm_hssi_pma_cdr_refclk_select_mux (
				// OUTPUTS
				.avmmreaddata(w_pma_cdr_refclk_avmmreaddata),
				.blockselect(w_pma_cdr_refclk_blockselect),
				.refclk(w_pma_cdr_refclk_refclk),
				.rx_det_clk(w_pma_cdr_refclk_rx_det_clk),
				// INPUTS
				.avmmaddress({in_avmmaddress[8], in_avmmaddress[7], in_avmmaddress[6], in_avmmaddress[5], in_avmmaddress[4], in_avmmaddress[3], in_avmmaddress[2], in_avmmaddress[1], in_avmmaddress[0]}),
				.avmmclk(in_avmmclk),
				.avmmread(in_avmmread),
				.avmmrstn(in_avmmrstn),
				.avmmwrite(in_avmmwrite),
				.avmmwritedata({in_avmmwritedata[7], in_avmmwritedata[6], in_avmmwritedata[5], in_avmmwritedata[4], in_avmmwritedata[3], in_avmmwritedata[2], in_avmmwritedata[1], in_avmmwritedata[0]}),
				.core_refclk(in_core_refclk_in),
				.iqtxrxclk({in_iqtxrxclk[5], in_iqtxrxclk[4], in_iqtxrxclk[3], in_iqtxrxclk[2], in_iqtxrxclk[1], in_iqtxrxclk[0]}),
				.ref_iqclk({in_ref_iqclk[11], in_ref_iqclk[10], in_ref_iqclk[9], in_ref_iqclk[8], in_ref_iqclk[7], in_ref_iqclk[6], in_ref_iqclk[5], in_ref_iqclk[4], in_ref_iqclk[3], in_ref_iqclk[2], in_ref_iqclk[1], in_ref_iqclk[0]})
			);
		end // if generate
		else begin
				assign w_pma_cdr_refclk_avmmreaddata[7:0] = 8'b0;
				assign w_pma_cdr_refclk_blockselect = 1'b0;
				assign w_pma_cdr_refclk_refclk = 1'b0;
				assign w_pma_cdr_refclk_rx_det_clk = 1'b0;
		end // if not generate
		
		// instantiating twentynm_hssi_pma_channel_pll
		if ((xcvr_native_mode == "mode_rx_only") || (xcvr_native_mode == "mode_duplex")) begin:gen_twentynm_hssi_pma_channel_pll
			twentynm_hssi_pma_channel_pll #(
				.atb_select_control(cdr_pll_atb_select_control),
				.auto_reset_on(cdr_pll_auto_reset_on),
				.bbpd_data_pattern_filter_select(cdr_pll_bbpd_data_pattern_filter_select),
				.bw_sel(cdr_pll_bw_sel),
				.cal_vco_count_length(cdr_pll_cal_vco_count_length),
				.cdr_odi_select(cdr_pll_cdr_odi_select),
				.cdr_phaselock_mode(cdr_pll_cdr_phaselock_mode),
				.cdr_powerdown_mode(cdr_pll_cdr_powerdown_mode),
				.cgb_div(cdr_pll_cgb_div),
				.chgpmp_current_dn_pd(cdr_pll_chgpmp_current_dn_pd),
				.chgpmp_current_dn_trim(cdr_pll_chgpmp_current_dn_trim),
				.chgpmp_current_pd(cdr_pll_chgpmp_current_pd),
				.chgpmp_current_pfd(cdr_pll_chgpmp_current_pfd),
				.chgpmp_current_up_pd(cdr_pll_chgpmp_current_up_pd),
				.chgpmp_current_up_trim(cdr_pll_chgpmp_current_up_trim),
				.chgpmp_dn_pd_trim_double(cdr_pll_chgpmp_dn_pd_trim_double),
				.chgpmp_replicate(cdr_pll_chgpmp_replicate),
				.chgpmp_testmode(cdr_pll_chgpmp_testmode),
				.chgpmp_up_pd_trim_double(cdr_pll_chgpmp_up_pd_trim_double),
				.clklow_mux_select(cdr_pll_clklow_mux_select),
				.datarate(cdr_pll_datarate),
				.diag_loopback_enable(cdr_pll_diag_loopback_enable),
				.disable_up_dn(cdr_pll_disable_up_dn),
				.fb_select(cdr_pll_fb_select),
				.fref_clklow_div(cdr_pll_fref_clklow_div),
				.fref_mux_select(cdr_pll_fref_mux_select),
				.gpon_lck2ref_control(cdr_pll_gpon_lck2ref_control),
				.initial_settings(cdr_pll_initial_settings),
				.iqclk_mux_sel(cdr_pll_iqclk_mux_sel),
				.is_cascaded_pll(cdr_pll_is_cascaded_pll),
				.lck2ref_delay_control(cdr_pll_lck2ref_delay_control),
				.lf_resistor_pd(cdr_pll_lf_resistor_pd),
				.lf_resistor_pfd(cdr_pll_lf_resistor_pfd),
				.lf_ripple_cap(cdr_pll_lf_ripple_cap),
				.loop_filter_bias_select(cdr_pll_loop_filter_bias_select),
				.loopback_mode(cdr_pll_loopback_mode),
				.lpd_counter(cdr_pll_lpd_counter),
				.lpfd_counter(cdr_pll_lpfd_counter),
				.ltd_ltr_micro_controller_select(cdr_pll_ltd_ltr_micro_controller_select),
				.m_counter(cdr_pll_m_counter),
				.n_counter(cdr_pll_n_counter),
				.n_counter_scratch(cdr_pll_n_counter_scratch),
				.optimal("false"),       //PARAM_HIDE
				.output_clock_frequency(cdr_pll_output_clock_frequency),
				.pcie_gen(cdr_pll_pcie_gen),
				.pd_fastlock_mode(cdr_pll_pd_fastlock_mode),
				.pd_l_counter(cdr_pll_pd_l_counter),
				.pfd_l_counter(cdr_pll_pfd_l_counter),
				.pma_width(cdr_pll_pma_width),
				.primary_use(cdr_pll_primary_use),
				.prot_mode(cdr_pll_prot_mode),
				.reference_clock_frequency(cdr_pll_reference_clock_frequency),
				.reverse_serial_loopback(cdr_pll_reverse_serial_loopback),
				.set_cdr_input_freq_range(cdr_pll_set_cdr_input_freq_range),
				.set_cdr_v2i_enable(cdr_pll_set_cdr_v2i_enable),
				.set_cdr_vco_reset(cdr_pll_set_cdr_vco_reset),
				.set_cdr_vco_speed(cdr_pll_set_cdr_vco_speed),
				.set_cdr_vco_speed_fix(cdr_pll_set_cdr_vco_speed_fix),
				.set_cdr_vco_speed_pciegen3(cdr_pll_set_cdr_vco_speed_pciegen3),
				.silicon_rev( "20nm3" ),       //PARAM_HIDE
				.sup_mode(cdr_pll_sup_mode),
				.tx_pll_prot_mode(cdr_pll_tx_pll_prot_mode),
				.txpll_hclk_driver_enable(cdr_pll_txpll_hclk_driver_enable),
				.uc_ro_cal(cdr_pll_uc_ro_cal),
				.vco_freq(cdr_pll_vco_freq),
				.vco_overrange_voltage(cdr_pll_vco_overrange_voltage),
				.vco_underrange_voltage(cdr_pll_vco_underrange_voltage)
			) inst_twentynm_hssi_pma_channel_pll (
				// OUTPUTS
				.avmmreaddata(w_cdr_pll_avmmreaddata),
				.blockselect(w_cdr_pll_blockselect),
				.cdr_cnt_done(w_cdr_pll_cdr_cnt_done),
				.cdr_refclk_cal_out(w_cdr_pll_cdr_refclk_cal_out),
				.cdr_vco_cal_out(w_cdr_pll_cdr_vco_cal_out),
				.clk0_des(w_cdr_pll_clk0_des),
				.clk0_odi(w_cdr_pll_clk0_odi),
				.clk0_pd(w_cdr_pll_clk0_pd),
				.clk0_pfd(w_cdr_pll_clk0_pfd),
				.clk180_des(w_cdr_pll_clk180_des),
				.clk180_odi(w_cdr_pll_clk180_odi),
				.clk180_pd(w_cdr_pll_clk180_pd),
				.clk180_pfd(w_cdr_pll_clk180_pfd),
				.clk270_odi(w_cdr_pll_clk270_odi),
				.clk270_pd(w_cdr_pll_clk270_pd),
				.clk90_odi(w_cdr_pll_clk90_odi),
				.clk90_pd(w_cdr_pll_clk90_pd),
				.clklow(w_cdr_pll_clklow),
				.deven_des(w_cdr_pll_deven_des),
				.devenb_des(w_cdr_pll_devenb_des),
				.dodd_des(w_cdr_pll_dodd_des),
				.doddb_des(w_cdr_pll_doddb_des),
				.error_even_des(w_cdr_pll_error_even_des),
				.error_evenb_des(w_cdr_pll_error_evenb_des),
				.error_odd_des(w_cdr_pll_error_odd_des),
				.error_oddb_des(w_cdr_pll_error_oddb_des),
				.fref(w_cdr_pll_fref),
				.overrange(w_cdr_pll_overrange),
				.pfdmode_lock(w_cdr_pll_pfdmode_lock),
				.rlpbkdn(w_cdr_pll_rlpbkdn),
				.rlpbkdp(w_cdr_pll_rlpbkdp),
				.rlpbkn(w_cdr_pll_rlpbkn),
				.rlpbkp(w_cdr_pll_rlpbkp),
				.rxpll_lock(w_cdr_pll_rxpll_lock),
				.tx_rlpbk(w_cdr_pll_tx_rlpbk),
				.underrange(w_cdr_pll_underrange),
				// INPUTS
				.adapt_en(w_pma_adapt_dfe_adapt_en),
				.avmmaddress({in_avmmaddress[8], in_avmmaddress[7], in_avmmaddress[6], in_avmmaddress[5], in_avmmaddress[4], in_avmmaddress[3], in_avmmaddress[2], in_avmmaddress[1], in_avmmaddress[0]}),
				.avmmclk(in_avmmclk),
				.avmmread(in_avmmread),
				.avmmrstn(in_avmmrstn),
				.avmmwrite(in_avmmwrite),
				.avmmwritedata({in_avmmwritedata[7], in_avmmwritedata[6], in_avmmwritedata[5], in_avmmwritedata[4], in_avmmwritedata[3], in_avmmwritedata[2], in_avmmwritedata[1], in_avmmwritedata[0]}),
				.clk0_bbpd(w_pma_rx_dfe_clk0_bbpd),
				.clk180_bbpd(w_pma_rx_dfe_clk180_bbpd),
				.clk270_bbpd(w_pma_rx_dfe_clk270_bbpd),
				.clk90_bbpd(w_pma_rx_dfe_clk90_bbpd),
				.deven(w_pma_rx_dfe_deven),
				.devenb(w_pma_rx_dfe_devenb),
				.dfe_test(1'b0),
				.dodd(w_pma_rx_dfe_dodd),
				.doddb(w_pma_rx_dfe_doddb),
				.e270(w_pma_rx_dfe_edge270),
				.e270b(w_pma_rx_dfe_edge270b),
				.e90(w_pma_rx_dfe_edge90),
				.e90b(w_pma_rx_dfe_edge90b),
				.early_eios(in_early_eios),
				.error_even(w_pma_rx_dfe_err_ev),
				.error_evenb(w_pma_rx_dfe_err_evb),
				.error_odd(w_pma_rx_dfe_err_od),
				.error_oddb(w_pma_rx_dfe_err_odb),
				.fpll_test0(in_fpll_ppm_clk_in[0]),
				.fpll_test1(in_fpll_ppm_clk_in[1]),
				.iqtxrxclk({in_iqtxrxclk[5], in_iqtxrxclk[4], in_iqtxrxclk[3], in_iqtxrxclk[2], in_iqtxrxclk[1], in_iqtxrxclk[0]}),
				.ltd_b(in_ltd_b),
				.ltr(in_ltr),
				.odi_clk(w_pma_rx_odi_clk0_eye_lb),
				.odi_clkb(w_pma_rx_odi_clk180_eye_lb),
				.pcie_sw_ret({w_pma_rx_deser_pcie_sw_ret[1], w_pma_rx_deser_pcie_sw_ret[0]}),
				.ppm_lock(in_ppm_lock),
				.refclk(w_pma_cdr_refclk_refclk),
				.rst_n(in_rx_pma_rstb),
				.rx_deser_pclk_test(w_pma_rx_deser_clkdivrx_rx),
				.rx_lpbkn(w_pma_rx_buf_rdlpbkn),
				.rx_lpbkp(w_pma_rx_buf_rdlpbkp),
				.rxp(in_rx_p),
				.sd(w_pma_rx_sd_sd),
				.tx_ser_pclk_test(w_pma_tx_ser_clk_divtx),
				
				// UNUSED
				.atbsel(),
				.cdr_lpbkdp(),
				.cdr_lpbkp(),
				.clk270_des(),
				.clk90_des(),
				.lock2ref(),
				.rx_signal_ok(),
				.von_lp(),
				.vop_lp()
			);
		end // if generate
		else begin
				assign w_cdr_pll_avmmreaddata[7:0] = 8'b0;
				assign w_cdr_pll_blockselect = 1'b0;
				assign w_cdr_pll_cdr_cnt_done = 1'b0;
				assign w_cdr_pll_cdr_refclk_cal_out[11:0] = 12'b0;
				assign w_cdr_pll_cdr_vco_cal_out[11:0] = 12'b0;
				assign w_cdr_pll_clk0_des = 1'b0;
				assign w_cdr_pll_clk0_odi = 1'b0;
				assign w_cdr_pll_clk0_pd = 1'b0;
				assign w_cdr_pll_clk0_pfd = 1'b0;
				assign w_cdr_pll_clk180_des = 1'b0;
				assign w_cdr_pll_clk180_odi = 1'b0;
				assign w_cdr_pll_clk180_pd = 1'b0;
				assign w_cdr_pll_clk180_pfd = 1'b0;
				assign w_cdr_pll_clk270_odi = 1'b0;
				assign w_cdr_pll_clk270_pd = 1'b0;
				assign w_cdr_pll_clk90_odi = 1'b0;
				assign w_cdr_pll_clk90_pd = 1'b0;
				assign w_cdr_pll_clklow = 1'b0;
				assign w_cdr_pll_deven_des = 1'b0;
				assign w_cdr_pll_devenb_des = 1'b0;
				assign w_cdr_pll_dodd_des = 1'b0;
				assign w_cdr_pll_doddb_des = 1'b0;
				assign w_cdr_pll_error_even_des = 1'b0;
				assign w_cdr_pll_error_evenb_des = 1'b0;
				assign w_cdr_pll_error_odd_des = 1'b0;
				assign w_cdr_pll_error_oddb_des = 1'b0;
				assign w_cdr_pll_fref = 1'b0;
				assign w_cdr_pll_overrange = 1'b0;
				assign w_cdr_pll_pfdmode_lock = 1'b0;
				assign w_cdr_pll_rlpbkdn = 1'b0;
				assign w_cdr_pll_rlpbkdp = 1'b0;
				assign w_cdr_pll_rlpbkn = 1'b0;
				assign w_cdr_pll_rlpbkp = 1'b0;
				assign w_cdr_pll_rxpll_lock = 1'b0;
				assign w_cdr_pll_tx_rlpbk = 1'b0;
				assign w_cdr_pll_underrange = 1'b0;
		end // if not generate
		
		// instantiating twentynm_hssi_pma_rx_buf
		if ((xcvr_native_mode == "mode_rx_only") || (xcvr_native_mode == "mode_duplex")) begin:gen_twentynm_hssi_pma_rx_buf
			twentynm_hssi_pma_rx_buf #(
				.bypass_eqz_stages_234(pma_rx_buf_bypass_eqz_stages_234),
				.datarate(pma_rx_buf_datarate),
				.diag_lp_en(pma_rx_buf_diag_lp_en),
				.initial_settings("true"),       //PARAM_HIDE
				.loopback_modes(pma_rx_buf_loopback_modes),
				.optimal("false"),       //PARAM_HIDE
				.pdb_rx("normal_rx_on"),       //PARAM_HIDE
				.pm_tx_rx_cvp_mode(pma_rx_buf_pm_tx_rx_cvp_mode),
				.pm_tx_rx_pcie_gen(pma_rx_buf_pm_tx_rx_pcie_gen),
				.pm_tx_rx_pcie_gen_bitwidth(pma_rx_buf_pm_tx_rx_pcie_gen_bitwidth),
				.prot_mode(pma_rx_buf_prot_mode),
				.qpi_enable(pma_rx_buf_qpi_enable),
				.refclk_en(pma_rx_buf_refclk_en),
				.rx_refclk_divider(pma_rx_buf_rx_refclk_divider),
				.silicon_rev( "20nm3" ),       //PARAM_HIDE
				.sup_mode(pma_rx_buf_sup_mode),
				.xrx_path_datarate(pma_rx_buf_xrx_path_datarate),
				.xrx_path_datawidth(pma_rx_buf_xrx_path_datawidth),
				.xrx_path_initial_settings("true"),       //PARAM_HIDE
				.xrx_path_optimal("false"),       //PARAM_HIDE
				.xrx_path_pma_rx_divclk_hz(pma_rx_buf_xrx_path_pma_rx_divclk_hz),
				.xrx_path_prot_mode(pma_rx_buf_xrx_path_prot_mode),
				.xrx_path_sup_mode(pma_rx_buf_xrx_path_sup_mode),
				.xrx_path_uc_cal_enable(pma_rx_buf_xrx_path_uc_cal_enable)
			) inst_twentynm_hssi_pma_rx_buf (
				// OUTPUTS
				.avmmreaddata(w_pma_rx_buf_avmmreaddata),
				.blockselect(w_pma_rx_buf_blockselect),
				.inn(w_pma_rx_buf_inn),
				.inp(w_pma_rx_buf_inp),
				.outn(w_pma_rx_buf_outn),
				.outp(w_pma_rx_buf_outp),
				.pull_dn(w_pma_rx_buf_pull_dn),
				.rdlpbkn(w_pma_rx_buf_rdlpbkn),
				.rdlpbkp(w_pma_rx_buf_rdlpbkp),
				// INPUTS
				.avmmaddress({in_avmmaddress[8], in_avmmaddress[7], in_avmmaddress[6], in_avmmaddress[5], in_avmmaddress[4], in_avmmaddress[3], in_avmmaddress[2], in_avmmaddress[1], in_avmmaddress[0]}),
				.avmmclk(in_avmmclk),
				.avmmread(in_avmmread),
				.avmmrstn(in_avmmrstn),
				.avmmwrite(in_avmmwrite),
				.avmmwritedata({in_avmmwritedata[7], in_avmmwritedata[6], in_avmmwritedata[5], in_avmmwritedata[4], in_avmmwritedata[3], in_avmmwritedata[2], in_avmmwritedata[1], in_avmmwritedata[0]}),
				.clk_divrx(w_pma_rx_deser_clkdivrx_rx),
				.lpbkn(w_pma_tx_buf_lbvon),
				.lpbkp(w_pma_tx_buf_lbvop),
				.rx_qpi_pulldn(in_rx_qpi_pulldn),
				.rx_rstn(in_rx_pma_rstb),
				.rx_sel_b50({in_rx50_buf_in[5], in_rx50_buf_in[4], in_rx50_buf_in[3], in_rx50_buf_in[2], in_rx50_buf_in[1], in_rx50_buf_in[0]}),
				.rxn(in_rx_n),
				.rxp(in_rx_p),
				.s_lpbk_b(in_rs_lpbk_b),
				.vcz({w_pma_adapt_ctle_acgain_4s[27], w_pma_adapt_ctle_acgain_4s[26], w_pma_adapt_ctle_acgain_4s[25], w_pma_adapt_ctle_acgain_4s[24], w_pma_adapt_ctle_acgain_4s[23], w_pma_adapt_ctle_acgain_4s[22], w_pma_adapt_ctle_acgain_4s[21], w_pma_adapt_ctle_acgain_4s[20], w_pma_adapt_ctle_acgain_4s[19], w_pma_adapt_ctle_acgain_4s[18], w_pma_adapt_ctle_acgain_4s[17], w_pma_adapt_ctle_acgain_4s[16], w_pma_adapt_ctle_acgain_4s[15], w_pma_adapt_ctle_acgain_4s[14], w_pma_adapt_ctle_acgain_4s[13], w_pma_adapt_ctle_acgain_4s[12], w_pma_adapt_ctle_acgain_4s[11], w_pma_adapt_ctle_acgain_4s[10], w_pma_adapt_ctle_acgain_4s[9], w_pma_adapt_ctle_acgain_4s[8], w_pma_adapt_ctle_acgain_4s[7], w_pma_adapt_ctle_acgain_4s[6], w_pma_adapt_ctle_acgain_4s[5], w_pma_adapt_ctle_acgain_4s[4], w_pma_adapt_ctle_acgain_4s[3], w_pma_adapt_ctle_acgain_4s[2], w_pma_adapt_ctle_acgain_4s[1], w_pma_adapt_ctle_acgain_4s[0]}),
				.vds_eqz_s1_set({w_pma_adapt_ctle_eqz_1s_sel[14], w_pma_adapt_ctle_eqz_1s_sel[13], w_pma_adapt_ctle_eqz_1s_sel[12], w_pma_adapt_ctle_eqz_1s_sel[11], w_pma_adapt_ctle_eqz_1s_sel[10], w_pma_adapt_ctle_eqz_1s_sel[9], w_pma_adapt_ctle_eqz_1s_sel[8], w_pma_adapt_ctle_eqz_1s_sel[7], w_pma_adapt_ctle_eqz_1s_sel[6], w_pma_adapt_ctle_eqz_1s_sel[5], w_pma_adapt_ctle_eqz_1s_sel[4], w_pma_adapt_ctle_eqz_1s_sel[3], w_pma_adapt_ctle_eqz_1s_sel[2], w_pma_adapt_ctle_eqz_1s_sel[1], w_pma_adapt_ctle_eqz_1s_sel[0]}),
				.vds_lfeqz_czero({1'b0, 1'b0}),
				.vds_lfeqz_fb_set({w_pma_adapt_ctle_lfeq_fb_sel[6], w_pma_adapt_ctle_lfeq_fb_sel[5], w_pma_adapt_ctle_lfeq_fb_sel[4], w_pma_adapt_ctle_lfeq_fb_sel[3], w_pma_adapt_ctle_lfeq_fb_sel[2], w_pma_adapt_ctle_lfeq_fb_sel[1], w_pma_adapt_ctle_lfeq_fb_sel[0]}),
				.vds_vga_set({w_pma_adapt_vga_sel[6], w_pma_adapt_vga_sel[5], w_pma_adapt_vga_sel[4], w_pma_adapt_vga_sel[3], w_pma_adapt_vga_sel[2], w_pma_adapt_vga_sel[1], w_pma_adapt_vga_sel[0]}),
				
				// UNUSED
				.rx_refclk(),
				.vga_cm_bidir_in(),
				.vga_cm_bidir_out()
			);
		end // if generate
		else begin
				assign w_pma_rx_buf_avmmreaddata[7:0] = 8'b0;
				assign w_pma_rx_buf_blockselect = 1'b0;
				assign w_pma_rx_buf_inn = 1'b0;
				assign w_pma_rx_buf_inp = 1'b0;
				assign w_pma_rx_buf_outn = 1'b0;
				assign w_pma_rx_buf_outp = 1'b0;
				assign w_pma_rx_buf_pull_dn = 1'b0;
				assign w_pma_rx_buf_rdlpbkn = 1'b0;
				assign w_pma_rx_buf_rdlpbkp = 1'b0;
		end // if not generate
		
		// instantiating twentynm_hssi_pma_rx_deser
		if ((xcvr_native_mode == "mode_rx_only") || (xcvr_native_mode == "mode_duplex")) begin:gen_twentynm_hssi_pma_rx_deser
			twentynm_hssi_pma_rx_deser #(
				.bitslip_bypass(pma_rx_deser_bitslip_bypass),
				.clkdiv_source(pma_rx_deser_clkdiv_source),
				.clkdivrx_user_mode(pma_rx_deser_clkdivrx_user_mode),
				.datarate(pma_rx_deser_datarate),
				.deser_factor(pma_rx_deser_deser_factor),
				.deser_powerdown("deser_power_up"),       //PARAM_HIDE
				.force_clkdiv_for_testing(pma_rx_deser_force_clkdiv_for_testing),
				.optimal("false"),       //PARAM_HIDE
				.pcie_gen(pma_rx_deser_pcie_gen),
				.pcie_gen_bitwidth(pma_rx_deser_pcie_gen_bitwidth),
				.prot_mode(pma_rx_deser_prot_mode),
				.rst_n_adapt_odi(pma_rx_deser_rst_n_adapt_odi),
				.sdclk_enable(pma_rx_deser_sdclk_enable),
				.silicon_rev( "20nm3" ),       //PARAM_HIDE
				.sup_mode(pma_rx_deser_sup_mode),
				.tdr_mode("select_bbpd_data")       //PARAM_HIDE
			) inst_twentynm_hssi_pma_rx_deser (
				// OUTPUTS
				.adapt_clk(w_pma_rx_deser_adapt_clk),
				.avmmreaddata(w_pma_rx_deser_avmmreaddata),
				.blockselect(w_pma_rx_deser_blockselect),
				.clkdiv(w_pma_rx_deser_clkdiv),
				.clkdiv_user(w_pma_rx_deser_clkdiv_user),
				.clkdivrx_rx(w_pma_rx_deser_clkdivrx_rx),
				.data(w_pma_rx_deser_data),
				.dout(w_pma_rx_deser_dout),
				.error_deser(w_pma_rx_deser_error_deser),
				.odi_dout(w_pma_rx_deser_odi_dout),
				.pcie_sw_ret(w_pma_rx_deser_pcie_sw_ret),
				.tstmx_deser(w_pma_rx_deser_tstmx_deser),
				// INPUTS
				.adapt_en(w_pma_adapt_odi_vref[0]),
				.avmmaddress({in_avmmaddress[8], in_avmmaddress[7], in_avmmaddress[6], in_avmmaddress[5], in_avmmaddress[4], in_avmmaddress[3], in_avmmaddress[2], in_avmmaddress[1], in_avmmaddress[0]}),
				.avmmclk(in_avmmclk),
				.avmmread(in_avmmread),
				.avmmrstn(in_avmmrstn),
				.avmmwrite(in_avmmwrite),
				.avmmwritedata({in_avmmwritedata[7], in_avmmwritedata[6], in_avmmwritedata[5], in_avmmwritedata[4], in_avmmwritedata[3], in_avmmwritedata[2], in_avmmwritedata[1], in_avmmwritedata[0]}),
				.bitslip(in_rx_bitslip),
				.clk0(w_cdr_pll_clk0_des),
				.clk0_odi(w_pma_rx_odi_clk0_eye),
				.clk180(w_cdr_pll_clk180_des),
				.clk180_odi(w_pma_rx_odi_clk180_eye),
				.clklow(w_cdr_pll_clklow),
				.deven(w_cdr_pll_deven_des),
				.deven_odi(w_pma_rx_odi_de_eye),
				.devenb(w_cdr_pll_devenb_des),
				.devenb_odi(w_pma_rx_odi_deb_eye),
				.dodd(w_cdr_pll_dodd_des),
				.dodd_odi(w_pma_rx_odi_do_eye),
				.doddb(w_cdr_pll_doddb_des),
				.doddb_odi(w_pma_rx_odi_dob_eye),
				.error_even(w_cdr_pll_error_even_des),
				.error_evenb(w_cdr_pll_error_evenb_des),
				.error_odd(w_cdr_pll_error_odd_des),
				.error_oddb(w_cdr_pll_error_oddb_des),
				.fref(w_cdr_pll_fref),
				.odi_en(w_pma_rx_odi_odi_en),
				.pcie_sw({in_pcie_sw[1], in_pcie_sw[0]}),
				.pfdmode_lock(w_cdr_pll_pfdmode_lock),
				.rst_n(in_rx_pma_rstb),
				
				// UNUSED
				.clk270(),
				.clk90(),
				.odi_clkout(),
				.tdr_en()
			);
		end // if generate
		else begin
				assign w_pma_rx_deser_adapt_clk = 1'b0;
				assign w_pma_rx_deser_avmmreaddata[7:0] = 8'b0;
				assign w_pma_rx_deser_blockselect = 1'b0;
				assign w_pma_rx_deser_clkdiv = 1'b0;
				assign w_pma_rx_deser_clkdiv_user = 1'b0;
				assign w_pma_rx_deser_clkdivrx_rx = 1'b0;
				assign w_pma_rx_deser_data[63:0] = 64'b0;
				assign w_pma_rx_deser_dout[63:0] = 64'b0;
				assign w_pma_rx_deser_error_deser[63:0] = 64'b0;
				assign w_pma_rx_deser_odi_dout[63:0] = 64'b0;
				assign w_pma_rx_deser_pcie_sw_ret[1:0] = 2'b0;
				assign w_pma_rx_deser_tstmx_deser[7:0] = 8'b0;
		end // if not generate
		
		// instantiating twentynm_hssi_pma_rx_dfe
		if ((xcvr_native_mode == "mode_rx_only") || (xcvr_native_mode == "mode_duplex")) begin:gen_twentynm_hssi_pma_rx_dfe
			twentynm_hssi_pma_rx_dfe #(
				.datarate(pma_rx_dfe_datarate),
				.dft_en(pma_rx_dfe_dft_en),
				.initial_settings("true"),       //PARAM_HIDE
				.optimal("false"),       //PARAM_HIDE
				.pdb(pma_rx_dfe_pdb),
				.pdb_fixedtap(pma_rx_dfe_pdb_fixedtap),
				.pdb_floattap(pma_rx_dfe_pdb_floattap),
				.pdb_fxtap4t7(pma_rx_dfe_pdb_fxtap4t7),
				.prot_mode(pma_rx_dfe_prot_mode),
				.silicon_rev( "20nm3" ),       //PARAM_HIDE
				.sup_mode(pma_rx_dfe_sup_mode)
			) inst_twentynm_hssi_pma_rx_dfe (
				// OUTPUTS
				.avmmreaddata(w_pma_rx_dfe_avmmreaddata),
				.blockselect(w_pma_rx_dfe_blockselect),
				.clk0_bbpd(w_pma_rx_dfe_clk0_bbpd),
				.clk180_bbpd(w_pma_rx_dfe_clk180_bbpd),
				.clk270_bbpd(w_pma_rx_dfe_clk270_bbpd),
				.clk90_bbpd(w_pma_rx_dfe_clk90_bbpd),
				.deven(w_pma_rx_dfe_deven),
				.devenb(w_pma_rx_dfe_devenb),
				.dfe_oc_tstmx(w_pma_rx_dfe_dfe_oc_tstmx),
				.dodd(w_pma_rx_dfe_dodd),
				.doddb(w_pma_rx_dfe_doddb),
				.edge270(w_pma_rx_dfe_edge270),
				.edge270b(w_pma_rx_dfe_edge270b),
				.edge90(w_pma_rx_dfe_edge90),
				.edge90b(w_pma_rx_dfe_edge90b),
				.err_ev(w_pma_rx_dfe_err_ev),
				.err_evb(w_pma_rx_dfe_err_evb),
				.err_od(w_pma_rx_dfe_err_od),
				.err_odb(w_pma_rx_dfe_err_odb),
				.spec_vrefh(w_pma_rx_dfe_spec_vrefh),
				.spec_vrefl(w_pma_rx_dfe_spec_vrefl),
				// INPUTS
				.adapt_en(w_pma_adapt_dfe_adapt_en),
				.adp_clk(w_pma_adapt_dfe_adp_clk),
				.avmmaddress({in_avmmaddress[8], in_avmmaddress[7], in_avmmaddress[6], in_avmmaddress[5], in_avmmaddress[4], in_avmmaddress[3], in_avmmaddress[2], in_avmmaddress[1], in_avmmaddress[0]}),
				.avmmclk(in_avmmclk),
				.avmmread(in_avmmread),
				.avmmrstn(in_avmmrstn),
				.avmmwrite(in_avmmwrite),
				.avmmwritedata({in_avmmwritedata[7], in_avmmwritedata[6], in_avmmwritedata[5], in_avmmwritedata[4], in_avmmwritedata[3], in_avmmwritedata[2], in_avmmwritedata[1], in_avmmwritedata[0]}),
				.clk0(w_cdr_pll_clk0_pd),
				.clk180(w_cdr_pll_clk180_pd),
				.clk270(w_cdr_pll_clk270_pd),
				.clk90(w_cdr_pll_clk90_pd),
				.dfe_fltap1_coeff({w_pma_adapt_dfe_fltap1[5], w_pma_adapt_dfe_fltap1[4], w_pma_adapt_dfe_fltap1[3], w_pma_adapt_dfe_fltap1[2], w_pma_adapt_dfe_fltap1[1], w_pma_adapt_dfe_fltap1[0]}),
				.dfe_fltap1_sgn(w_pma_adapt_dfe_fltap1_sgn),
				.dfe_fltap2_coeff({w_pma_adapt_dfe_fltap2[5], w_pma_adapt_dfe_fltap2[4], w_pma_adapt_dfe_fltap2[3], w_pma_adapt_dfe_fltap2[2], w_pma_adapt_dfe_fltap2[1], w_pma_adapt_dfe_fltap2[0]}),
				.dfe_fltap2_sgn(w_pma_adapt_dfe_fltap2_sgn),
				.dfe_fltap3_coeff({w_pma_adapt_dfe_fltap3[5], w_pma_adapt_dfe_fltap3[4], w_pma_adapt_dfe_fltap3[3], w_pma_adapt_dfe_fltap3[2], w_pma_adapt_dfe_fltap3[1], w_pma_adapt_dfe_fltap3[0]}),
				.dfe_fltap3_sgn(w_pma_adapt_dfe_fltap3_sgn),
				.dfe_fltap4_coeff({w_pma_adapt_dfe_fltap4[5], w_pma_adapt_dfe_fltap4[4], w_pma_adapt_dfe_fltap4[3], w_pma_adapt_dfe_fltap4[2], w_pma_adapt_dfe_fltap4[1], w_pma_adapt_dfe_fltap4[0]}),
				.dfe_fltap4_sgn(w_pma_adapt_dfe_fltap4_sgn),
				.dfe_fltap_bypdeser(w_pma_adapt_dfe_fltap_bypdeser),
				.dfe_fltap_position({w_pma_adapt_dfe_fltap_position[5], w_pma_adapt_dfe_fltap_position[4], w_pma_adapt_dfe_fltap_position[3], w_pma_adapt_dfe_fltap_position[2], w_pma_adapt_dfe_fltap_position[1], w_pma_adapt_dfe_fltap_position[0]}),
				.dfe_fxtap1_coeff({w_pma_adapt_dfe_fxtap1[6], w_pma_adapt_dfe_fxtap1[5], w_pma_adapt_dfe_fxtap1[4], w_pma_adapt_dfe_fxtap1[3], w_pma_adapt_dfe_fxtap1[2], w_pma_adapt_dfe_fxtap1[1], w_pma_adapt_dfe_fxtap1[0]}),
				.dfe_fxtap2_coeff({w_pma_adapt_dfe_fxtap2[6], w_pma_adapt_dfe_fxtap2[5], w_pma_adapt_dfe_fxtap2[4], w_pma_adapt_dfe_fxtap2[3], w_pma_adapt_dfe_fxtap2[2], w_pma_adapt_dfe_fxtap2[1], w_pma_adapt_dfe_fxtap2[0]}),
				.dfe_fxtap2_sgn(w_pma_adapt_dfe_fxtap2_sgn),
				.dfe_fxtap3_coeff({w_pma_adapt_dfe_fxtap3[6], w_pma_adapt_dfe_fxtap3[5], w_pma_adapt_dfe_fxtap3[4], w_pma_adapt_dfe_fxtap3[3], w_pma_adapt_dfe_fxtap3[2], w_pma_adapt_dfe_fxtap3[1], w_pma_adapt_dfe_fxtap3[0]}),
				.dfe_fxtap3_sgn(w_pma_adapt_dfe_fxtap3_sgn),
				.dfe_fxtap4_coeff({w_pma_adapt_dfe_fxtap4[5], w_pma_adapt_dfe_fxtap4[4], w_pma_adapt_dfe_fxtap4[3], w_pma_adapt_dfe_fxtap4[2], w_pma_adapt_dfe_fxtap4[1], w_pma_adapt_dfe_fxtap4[0]}),
				.dfe_fxtap4_sgn(w_pma_adapt_dfe_fxtap4_sgn),
				.dfe_fxtap5_coeff({w_pma_adapt_dfe_fxtap5[5], w_pma_adapt_dfe_fxtap5[4], w_pma_adapt_dfe_fxtap5[3], w_pma_adapt_dfe_fxtap5[2], w_pma_adapt_dfe_fxtap5[1], w_pma_adapt_dfe_fxtap5[0]}),
				.dfe_fxtap5_sgn(w_pma_adapt_dfe_fxtap5_sgn),
				.dfe_fxtap6_coeff({w_pma_adapt_dfe_fxtap6[4], w_pma_adapt_dfe_fxtap6[3], w_pma_adapt_dfe_fxtap6[2], w_pma_adapt_dfe_fxtap6[1], w_pma_adapt_dfe_fxtap6[0]}),
				.dfe_fxtap6_sgn(w_pma_adapt_dfe_fxtap6_sgn),
				.dfe_fxtap7_coeff({w_pma_adapt_dfe_fxtap7[4], w_pma_adapt_dfe_fxtap7[3], w_pma_adapt_dfe_fxtap7[2], w_pma_adapt_dfe_fxtap7[1], w_pma_adapt_dfe_fxtap7[0]}),
				.dfe_fxtap7_sgn(w_pma_adapt_dfe_fxtap7_sgn),
				.dfe_rstn(in_rx_pma_rstb),
				.dfe_spec_disable(w_pma_adapt_dfe_spec_disable),
				.dfe_spec_sgn_sel(w_pma_adapt_dfe_spec_sign_sel),
				.dfe_vref_sgn_sel(w_pma_adapt_dfe_vref_sign_sel),
				.rxn(w_pma_rx_buf_outn),
				.rxp(w_pma_rx_buf_outp),
				.vga_vcm(1'b0),
				.vref_level_coeff({w_pma_adapt_vref_sel[4], w_pma_adapt_vref_sel[3], w_pma_adapt_vref_sel[2], w_pma_adapt_vref_sel[1], w_pma_adapt_vref_sel[0]})
			);
		end // if generate
		else begin
				assign w_pma_rx_dfe_avmmreaddata[7:0] = 8'b0;
				assign w_pma_rx_dfe_blockselect = 1'b0;
				assign w_pma_rx_dfe_clk0_bbpd = 1'b0;
				assign w_pma_rx_dfe_clk180_bbpd = 1'b0;
				assign w_pma_rx_dfe_clk270_bbpd = 1'b0;
				assign w_pma_rx_dfe_clk90_bbpd = 1'b0;
				assign w_pma_rx_dfe_deven = 1'b0;
				assign w_pma_rx_dfe_devenb = 1'b0;
				assign w_pma_rx_dfe_dfe_oc_tstmx[7:0] = 8'b0;
				assign w_pma_rx_dfe_dodd = 1'b0;
				assign w_pma_rx_dfe_doddb = 1'b0;
				assign w_pma_rx_dfe_edge270 = 1'b0;
				assign w_pma_rx_dfe_edge270b = 1'b0;
				assign w_pma_rx_dfe_edge90 = 1'b0;
				assign w_pma_rx_dfe_edge90b = 1'b0;
				assign w_pma_rx_dfe_err_ev = 1'b0;
				assign w_pma_rx_dfe_err_evb = 1'b0;
				assign w_pma_rx_dfe_err_od = 1'b0;
				assign w_pma_rx_dfe_err_odb = 1'b0;
				assign w_pma_rx_dfe_spec_vrefh = 1'b0;
				assign w_pma_rx_dfe_spec_vrefl = 1'b0;
		end // if not generate
		
		// instantiating twentynm_hssi_pma_rx_odi
		if ((xcvr_native_mode == "mode_rx_only") || (xcvr_native_mode == "mode_duplex")) begin:gen_twentynm_hssi_pma_rx_odi
			twentynm_hssi_pma_rx_odi #(
				.datarate(pma_rx_odi_datarate),
				.initial_settings("true"),       //PARAM_HIDE
				.optimal("false"),       //PARAM_HIDE
				.prot_mode(pma_rx_odi_prot_mode),
				.silicon_rev( "20nm3" ),       //PARAM_HIDE
				.step_ctrl_sel(pma_rx_odi_step_ctrl_sel),
				.sup_mode(pma_rx_odi_sup_mode)
			) inst_twentynm_hssi_pma_rx_odi (
				// OUTPUTS
				.avmmreaddata(w_pma_rx_odi_avmmreaddata),
				.blockselect(w_pma_rx_odi_blockselect),
				.clk0_eye(w_pma_rx_odi_clk0_eye),
				.clk0_eye_lb(w_pma_rx_odi_clk0_eye_lb),
				.clk180_eye(w_pma_rx_odi_clk180_eye),
				.clk180_eye_lb(w_pma_rx_odi_clk180_eye_lb),
				.de_eye(w_pma_rx_odi_de_eye),
				.deb_eye(w_pma_rx_odi_deb_eye),
				.do_eye(w_pma_rx_odi_do_eye),
				.dob_eye(w_pma_rx_odi_dob_eye),
				.odi_en(w_pma_rx_odi_odi_en),
				.odi_oc_tstmx(w_pma_rx_odi_odi_oc_tstmx),
				// INPUTS
				.avmmaddress({in_avmmaddress[8], in_avmmaddress[7], in_avmmaddress[6], in_avmmaddress[5], in_avmmaddress[4], in_avmmaddress[3], in_avmmaddress[2], in_avmmaddress[1], in_avmmaddress[0]}),
				.avmmclk(in_avmmclk),
				.avmmread(in_avmmread),
				.avmmrstn(in_avmmrstn),
				.avmmwrite(in_avmmwrite),
				.avmmwritedata({in_avmmwritedata[7], in_avmmwritedata[6], in_avmmwritedata[5], in_avmmwritedata[4], in_avmmwritedata[3], in_avmmwritedata[2], in_avmmwritedata[1], in_avmmwritedata[0]}),
				.clk0(w_cdr_pll_clk0_odi),
				.clk180(w_cdr_pll_clk180_odi),
				.clk270(w_cdr_pll_clk270_odi),
				.clk90(w_cdr_pll_clk90_odi),
				.odi_dft_clr(in_eye_monitor[3]),
				.odi_latch_clk(in_eye_monitor[1]),
				.odi_shift_clk(in_eye_monitor[0]),
				.odi_shift_in(in_eye_monitor[2]),
				.rx_n(w_pma_rx_buf_inn),
				.rx_p(w_pma_rx_buf_inp),
				.rxn_sum(w_pma_rx_buf_outn),
				.rxp_sum(w_pma_rx_buf_outp),
				.spec_vrefh(w_pma_rx_dfe_spec_vrefh),
				.spec_vrefl(w_pma_rx_dfe_spec_vrefl),
				.vcm_vref(1'b0),
				.vertical_fb({w_pma_adapt_odi_vref[4], w_pma_adapt_odi_vref[3], w_pma_adapt_odi_vref[2], w_pma_adapt_odi_vref[1], 1'b0}),
				
				// UNUSED
				.atb0(),
				.atb1(),
				.it50u(),
				.it50u2(),
				.it50u4(),
				.odi_atb_sel(),
				.tdr_en(),
				.vref_sel_out()
			);
		end // if generate
		else begin
				assign w_pma_rx_odi_avmmreaddata[7:0] = 8'b0;
				assign w_pma_rx_odi_blockselect = 1'b0;
				assign w_pma_rx_odi_clk0_eye = 1'b0;
				assign w_pma_rx_odi_clk0_eye_lb = 1'b0;
				assign w_pma_rx_odi_clk180_eye = 1'b0;
				assign w_pma_rx_odi_clk180_eye_lb = 1'b0;
				assign w_pma_rx_odi_de_eye = 1'b0;
				assign w_pma_rx_odi_deb_eye = 1'b0;
				assign w_pma_rx_odi_do_eye = 1'b0;
				assign w_pma_rx_odi_dob_eye = 1'b0;
				assign w_pma_rx_odi_odi_en = 1'b0;
				assign w_pma_rx_odi_odi_oc_tstmx[1:0] = 2'b0;
		end // if not generate
		
		// instantiating twentynm_hssi_pma_rx_sd
		if ((xcvr_native_mode == "mode_rx_only") || (xcvr_native_mode == "mode_duplex")) begin:gen_twentynm_hssi_pma_rx_sd
			twentynm_hssi_pma_rx_sd #(
				.optimal("false"),       //PARAM_HIDE
				.prot_mode(pma_rx_sd_prot_mode),
				.sd_output_off(pma_rx_sd_sd_output_off),
				.sd_output_on(pma_rx_sd_sd_output_on),
				.sd_pdb(pma_rx_sd_sd_pdb),
				.silicon_rev( "20nm3" ),       //PARAM_HIDE
				.sup_mode(pma_rx_sd_sup_mode)
			) inst_twentynm_hssi_pma_rx_sd (
				// OUTPUTS
				.avmmreaddata(w_pma_rx_sd_avmmreaddata),
				.blockselect(w_pma_rx_sd_blockselect),
				.sd(w_pma_rx_sd_sd),
				// INPUTS
				.avmmaddress({in_avmmaddress[8], in_avmmaddress[7], in_avmmaddress[6], in_avmmaddress[5], in_avmmaddress[4], in_avmmaddress[3], in_avmmaddress[2], in_avmmaddress[1], in_avmmaddress[0]}),
				.avmmclk(in_avmmclk),
				.avmmread(in_avmmread),
				.avmmrstn(in_avmmrstn),
				.avmmwrite(in_avmmwrite),
				.avmmwritedata({in_avmmwritedata[7], in_avmmwritedata[6], in_avmmwritedata[5], in_avmmwritedata[4], in_avmmwritedata[3], in_avmmwritedata[2], in_avmmwritedata[1], in_avmmwritedata[0]}),
				.clk(w_pma_rx_deser_clkdivrx_rx),
				.qpi(w_pma_rx_buf_pull_dn),
				.rstn_sd(in_rx_pma_rstb),
				.s_lpbk_b(in_rs_lpbk_b),
				.vin(w_pma_rx_buf_inn),
				.vip(w_pma_rx_buf_inp)
			);
		end // if generate
		else begin
				assign w_pma_rx_sd_avmmreaddata[7:0] = 8'b0;
				assign w_pma_rx_sd_blockselect = 1'b0;
				assign w_pma_rx_sd_sd = 1'b0;
		end // if not generate
		
		// instantiating twentynm_hssi_pma_tx_buf
		if ((xcvr_native_mode == "mode_tx_only") || (xcvr_native_mode == "mode_duplex")) begin:gen_twentynm_hssi_pma_tx_buf
			twentynm_hssi_pma_tx_buf #(
				.datarate(pma_tx_buf_datarate),
				.dft_sel("dft_disabled"),       //PARAM_HIDE
				.initial_settings("true"),       //PARAM_HIDE
				.jtag_drv_sel("drv1"),       //PARAM_HIDE
				.jtag_lp("lp_off"),       //PARAM_HIDE
				.lst("atb_disabled"),       //PARAM_HIDE
				.mcgb_location_for_pcie(pma_tx_buf_mcgb_location_for_pcie),
				.optimal("false"),       //PARAM_HIDE
				.prot_mode(pma_tx_buf_prot_mode),
				.rx_det(pma_tx_buf_rx_det),
				.rx_det_output_sel(pma_tx_buf_rx_det_output_sel),
				.rx_det_pdb(pma_tx_buf_rx_det_pdb),
				.ser_powerdown("normal_ser_on"),       //PARAM_HIDE
				.silicon_rev( "20nm3" ),       //PARAM_HIDE
				.sup_mode(pma_tx_buf_sup_mode),
				.tx_powerdown("normal_tx_on"),       //PARAM_HIDE
				.user_fir_coeff_ctrl_sel(pma_tx_buf_user_fir_coeff_ctrl_sel),
				.xtx_path_clock_divider_ratio(pma_tx_buf_xtx_path_clock_divider_ratio),
				.xtx_path_datarate(pma_tx_buf_xtx_path_datarate),
				.xtx_path_datawidth(pma_tx_buf_xtx_path_datawidth),
				.xtx_path_initial_settings("true"),       //PARAM_HIDE
				.xtx_path_optimal("false"),       //PARAM_HIDE
				.xtx_path_pma_tx_divclk_hz(pma_tx_buf_xtx_path_pma_tx_divclk_hz),
				.xtx_path_prot_mode(pma_tx_buf_xtx_path_prot_mode),
				.xtx_path_sup_mode(pma_tx_buf_xtx_path_sup_mode),
				.xtx_path_tx_pll_clk_hz(pma_tx_buf_xtx_path_tx_pll_clk_hz)
			) inst_twentynm_hssi_pma_tx_buf (
				// OUTPUTS
				.atbsel(w_pma_tx_buf_atbsel),
				.avmmreaddata(w_pma_tx_buf_avmmreaddata),
				.blockselect(w_pma_tx_buf_blockselect),
				.ckn(w_pma_tx_buf_ckn),
				.ckp(w_pma_tx_buf_ckp),
				.dcd_out1(w_pma_tx_buf_dcd_out1),
				.dcd_out2(w_pma_tx_buf_dcd_out2),
				.dcd_out_ready(w_pma_tx_buf_dcd_out_ready),
				.detect_on(w_pma_tx_buf_detect_on),
				.lbvon(w_pma_tx_buf_lbvon),
				.lbvop(w_pma_tx_buf_lbvop),
				.rx_detect_valid(w_pma_tx_buf_rx_detect_valid),
				.rx_found(w_pma_tx_buf_rx_found),
				.rx_found_pcie_spl_test(w_pma_tx_buf_rx_found_pcie_spl_test),
				.sel_vreg(w_pma_tx_buf_sel_vreg),
				.spl_clk_test(w_pma_tx_buf_spl_clk_test),
				.tx_dftout(w_pma_tx_buf_tx_dftout),
				.vlptxn(w_pma_tx_buf_vlptxn),
				.vlptxp(w_pma_tx_buf_vlptxp),
				.von(w_pma_tx_buf_von),
				.vop(w_pma_tx_buf_vop),
				// INPUTS
				.avmmaddress({in_avmmaddress[8], in_avmmaddress[7], in_avmmaddress[6], in_avmmaddress[5], in_avmmaddress[4], in_avmmaddress[3], in_avmmaddress[2], in_avmmaddress[1], in_avmmaddress[0]}),
				.avmmclk(in_avmmclk),
				.avmmread(in_avmmread),
				.avmmrstn(in_avmmrstn),
				.avmmwrite(in_avmmwrite),
				.avmmwritedata({in_avmmwritedata[7], in_avmmwritedata[6], in_avmmwritedata[5], in_avmmwritedata[4], in_avmmwritedata[3], in_avmmwritedata[2], in_avmmwritedata[1], in_avmmwritedata[0]}),
				.bsmode(1'b0),
				.bsoeb(1'b0),
				.bstxn_in(1'b0),
				.bstxp_in(1'b0),
				.clk0_tx(w_pma_cgb_hifreqclkp),
				.clk180_tx(w_pma_cgb_hifreqclkn),
				.clk_dcd(w_pma_cgb_cpulse_out_bus[0]),
				.clksn(w_pma_tx_ser_ckdrvp),
				.clksp(w_pma_tx_ser_ckdrvn),
				.i_coeff({in_i_coeff[17], in_i_coeff[16], in_i_coeff[15], in_i_coeff[14], in_i_coeff[13], in_i_coeff[12], in_i_coeff[11], in_i_coeff[10], in_i_coeff[9], in_i_coeff[8], in_i_coeff[7], in_i_coeff[6], in_i_coeff[5], in_i_coeff[4], in_i_coeff[3], in_i_coeff[2], in_i_coeff[1], in_i_coeff[0]}),
				.oe(w_pma_tx_ser_oe),
				.oeb(w_pma_tx_ser_oeb),
				.oo(w_pma_tx_ser_oo),
				.oob(w_pma_tx_ser_oob),
				.pcie_sw_master(w_pma_cgb_pcie_sw_master[1]),
				.rx_det_clk(w_pma_cdr_refclk_rx_det_clk),
				.rx_n_bidir_in(in_rx_n),
				.rx_p_bidir_in(in_rx_p),
				.s_lpbk_b(in_rs_lpbk_b),
				.tx50({in_tx50_buf_in[8], in_tx50_buf_in[7], in_tx50_buf_in[6], in_tx50_buf_in[5], in_tx50_buf_in[4], in_tx50_buf_in[3], in_tx50_buf_in[2], in_tx50_buf_in[1], in_tx50_buf_in[0]}),
				.tx_det_rx(in_tx_det_rx),
				.tx_elec_idle(in_tx_elec_idle),
				.tx_qpi_pulldn(in_tx_qpi_pulldn),
				.tx_qpi_pullup(in_tx_qpi_pullup),
				.tx_rlpbk(w_cdr_pll_tx_rlpbk),
				.vrlpbkn(w_cdr_pll_rlpbkn),
				.vrlpbkn_1t(w_cdr_pll_rlpbkdn),
				.vrlpbkp(w_cdr_pll_rlpbkp),
				.vrlpbkp_1t(w_cdr_pll_rlpbkdp),
				
				// UNUSED
				.cr_rdynamic_sw()
			);
		end // if generate
		else begin
				assign w_pma_tx_buf_atbsel[2:0] = 3'b0;
				assign w_pma_tx_buf_avmmreaddata[7:0] = 8'b0;
				assign w_pma_tx_buf_blockselect = 1'b0;
				assign w_pma_tx_buf_ckn = 1'b0;
				assign w_pma_tx_buf_ckp = 1'b0;
				assign w_pma_tx_buf_dcd_out1 = 1'b0;
				assign w_pma_tx_buf_dcd_out2 = 1'b0;
				assign w_pma_tx_buf_dcd_out_ready = 1'b0;
				assign w_pma_tx_buf_detect_on[1:0] = 2'b0;
				assign w_pma_tx_buf_lbvon = 1'b0;
				assign w_pma_tx_buf_lbvop = 1'b0;
				assign w_pma_tx_buf_rx_detect_valid = 1'b0;
				assign w_pma_tx_buf_rx_found = 1'b0;
				assign w_pma_tx_buf_rx_found_pcie_spl_test = 1'b0;
				assign w_pma_tx_buf_sel_vreg = 1'b0;
				assign w_pma_tx_buf_spl_clk_test = 1'b0;
				assign w_pma_tx_buf_tx_dftout[7:0] = 8'b0;
				assign w_pma_tx_buf_vlptxn = 1'b0;
				assign w_pma_tx_buf_vlptxp = 1'b0;
				assign w_pma_tx_buf_von = 1'b0;
				assign w_pma_tx_buf_vop = 1'b0;
		end // if not generate
		
		// instantiating twentynm_hssi_pma_tx_cgb
		if ((xcvr_native_mode == "mode_tx_only") || (xcvr_native_mode == "mode_duplex")) begin:gen_twentynm_hssi_pma_tx_cgb
			twentynm_hssi_pma_tx_cgb #(
				.bitslip_enable(pma_cgb_bitslip_enable),
				.bonding_reset_enable(pma_cgb_bonding_reset_enable),
				.cgb_power_down("normal_cgb"),       //PARAM_HIDE
				.datarate(pma_cgb_datarate),
				.initial_settings("true"),       //PARAM_HIDE
				.input_select_gen3(pma_cgb_input_select_gen3),
				.input_select_x1(pma_cgb_input_select_x1),
				.input_select_xn(pma_cgb_input_select_xn),
				.pcie_gen3_bitwidth(pma_cgb_pcie_gen3_bitwidth),
				.prot_mode(pma_cgb_prot_mode),
				.scratch0_x1_clock_src(pma_cgb_scratch0_x1_clock_src),
				.scratch1_x1_clock_src(pma_cgb_scratch1_x1_clock_src),
				.scratch2_x1_clock_src(pma_cgb_scratch2_x1_clock_src),
				.scratch3_x1_clock_src(pma_cgb_scratch3_x1_clock_src),
				.select_done_master_or_slave(pma_cgb_select_done_master_or_slave),
				.ser_mode(pma_cgb_ser_mode),
				.ser_powerdown("normal_poweron_ser"),       //PARAM_HIDE
				.silicon_rev( "20nm3" ),       //PARAM_HIDE
				.sup_mode(pma_cgb_sup_mode),
				.tx_ucontrol_en(pma_cgb_tx_ucontrol_en),
				.x1_div_m_sel(pma_cgb_x1_div_m_sel)
			) inst_twentynm_hssi_pma_tx_cgb (
				// OUTPUTS
				.avmmreaddata(w_pma_cgb_avmmreaddata),
				.bitslipstate(w_pma_cgb_bitslipstate),
				.blockselect(w_pma_cgb_blockselect),
				.cpulse_out_bus(w_pma_cgb_cpulse_out_bus),
				.div2(w_pma_cgb_div2),
				.div4(w_pma_cgb_div4),
				.div5(w_pma_cgb_div5),
				.hifreqclkn(w_pma_cgb_hifreqclkn),
				.hifreqclkp(w_pma_cgb_hifreqclkp),
				.pcie_sw_done(w_pma_cgb_pcie_sw_done),
				.pcie_sw_master(w_pma_cgb_pcie_sw_master),
				.rstb(w_pma_cgb_rstb),
				// INPUTS
				.avmmaddress({in_avmmaddress[8], in_avmmaddress[7], in_avmmaddress[6], in_avmmaddress[5], in_avmmaddress[4], in_avmmaddress[3], in_avmmaddress[2], in_avmmaddress[1], in_avmmaddress[0]}),
				.avmmclk(in_avmmclk),
				.avmmread(in_avmmread),
				.avmmrstn(in_avmmrstn),
				.avmmwrite(in_avmmwrite),
				.avmmwritedata({in_avmmwritedata[7], in_avmmwritedata[6], in_avmmwritedata[5], in_avmmwritedata[4], in_avmmwritedata[3], in_avmmwritedata[2], in_avmmwritedata[1], in_avmmwritedata[0]}),
				.ckdccn(w_pma_tx_buf_ckn),
				.ckdccp(w_pma_tx_buf_ckp),
				.clk_cdr_b(in_clk_cdr_b),
				.clk_cdr_direct(w_cdr_pll_clk0_pfd),
				.clk_cdr_t(in_clk_cdr_t),
				.clk_fpll_b(in_clk_fpll_b),
				.clk_fpll_t(in_clk_fpll_t),
				.clk_lc_b(in_clk_lc_b),
				.clk_lc_hs(in_clk_lc_hs),
				.clk_lc_t(in_clk_lc_t),
				.clkb_cdr_b(in_clkb_cdr_b),
				.clkb_cdr_direct(w_cdr_pll_clk180_pfd),
				.clkb_cdr_t(in_clkb_cdr_t),
				.clkb_fpll_b(in_clkb_fpll_b),
				.clkb_fpll_t(in_clkb_fpll_t),
				.clkb_lc_b(in_clkb_lc_b),
				.clkb_lc_hs(in_clkb_lc_hs),
				.clkb_lc_t(in_clkb_lc_t),
				.cpulse_x6_dn_bus({in_cpulse_x6_dn_bus[5], in_cpulse_x6_dn_bus[4], in_cpulse_x6_dn_bus[3], in_cpulse_x6_dn_bus[2], in_cpulse_x6_dn_bus[1], in_cpulse_x6_dn_bus[0]}),
				.cpulse_x6_up_bus({in_cpulse_x6_up_bus[5], in_cpulse_x6_up_bus[4], in_cpulse_x6_up_bus[3], in_cpulse_x6_up_bus[2], in_cpulse_x6_up_bus[1], in_cpulse_x6_up_bus[0]}),
				.cpulse_xn_dn_bus({in_cpulse_xn_dn_bus[5], in_cpulse_xn_dn_bus[4], in_cpulse_xn_dn_bus[3], in_cpulse_xn_dn_bus[2], in_cpulse_xn_dn_bus[1], in_cpulse_xn_dn_bus[0]}),
				.cpulse_xn_up_bus({in_cpulse_xn_up_bus[5], in_cpulse_xn_up_bus[4], in_cpulse_xn_up_bus[3], in_cpulse_xn_up_bus[2], in_cpulse_xn_up_bus[1], in_cpulse_xn_up_bus[0]}),
				.pcie_sw({in_pcie_sw[1], in_pcie_sw[0]}),
				.pcie_sw_done_master({in_pcie_sw_done_master_in[1], in_pcie_sw_done_master_in[0]}),
				.tx_bitslip(in_tx_bitslip),
				.tx_bonding_rstb(in_tx_bonding_rstb),
				.tx_pma_rstb(in_tx_pma_rstb)
			);
		end // if generate
		else begin
				assign w_pma_cgb_avmmreaddata[7:0] = 8'b0;
				assign w_pma_cgb_bitslipstate = 1'b0;
				assign w_pma_cgb_blockselect = 1'b0;
				assign w_pma_cgb_cpulse_out_bus[5:0] = 6'b0;
				assign w_pma_cgb_div2 = 1'b0;
				assign w_pma_cgb_div4 = 1'b0;
				assign w_pma_cgb_div5 = 1'b0;
				assign w_pma_cgb_hifreqclkn = 1'b0;
				assign w_pma_cgb_hifreqclkp = 1'b0;
				assign w_pma_cgb_pcie_sw_done[1:0] = 2'b0;
				assign w_pma_cgb_pcie_sw_master[1:0] = 2'b0;
				assign w_pma_cgb_rstb = 1'b0;
		end // if not generate
		
		// instantiating twentynm_hssi_pma_tx_ser
		if ((xcvr_native_mode == "mode_tx_only") || (xcvr_native_mode == "mode_duplex")) begin:gen_twentynm_hssi_pma_tx_ser
			twentynm_hssi_pma_tx_ser #(
				.control_clk_divtx("no_dft_control_clkdivtx"),       //PARAM_HIDE
				.initial_settings("true"),       //PARAM_HIDE
				.prot_mode(pma_tx_ser_prot_mode),
				.ser_clk_divtx_user_sel(pma_tx_ser_ser_clk_divtx_user_sel),
				.ser_powerdown("normal_poweron_ser"),       //PARAM_HIDE
				.silicon_rev( "20nm3" ),       //PARAM_HIDE
				.sup_mode(pma_tx_ser_sup_mode)
			) inst_twentynm_hssi_pma_tx_ser (
				// OUTPUTS
				.avmmreaddata(w_pma_tx_ser_avmmreaddata),
				.blockselect(w_pma_tx_ser_blockselect),
				.ckdrvn(w_pma_tx_ser_ckdrvn),
				.ckdrvp(w_pma_tx_ser_ckdrvp),
				.clk_divtx(w_pma_tx_ser_clk_divtx),
				.clk_divtx_user(w_pma_tx_ser_clk_divtx_user),
				.oe(w_pma_tx_ser_oe),
				.oeb(w_pma_tx_ser_oeb),
				.oo(w_pma_tx_ser_oo),
				.oob(w_pma_tx_ser_oob),
				// INPUTS
				.avmmaddress({in_avmmaddress[8], in_avmmaddress[7], in_avmmaddress[6], in_avmmaddress[5], in_avmmaddress[4], in_avmmaddress[3], in_avmmaddress[2], in_avmmaddress[1], in_avmmaddress[0]}),
				.avmmclk(in_avmmclk),
				.avmmread(in_avmmread),
				.avmmrstn(in_avmmrstn),
				.avmmwrite(in_avmmwrite),
				.avmmwritedata({in_avmmwritedata[7], in_avmmwritedata[6], in_avmmwritedata[5], in_avmmwritedata[4], in_avmmwritedata[3], in_avmmwritedata[2], in_avmmwritedata[1], in_avmmwritedata[0]}),
				.bitslipstate(w_pma_cgb_bitslipstate),
				.cpulse(w_pma_cgb_cpulse_out_bus[1]),
				.data({in_tx_data[63], in_tx_data[62], in_tx_data[61], in_tx_data[60], in_tx_data[59], in_tx_data[58], in_tx_data[57], in_tx_data[56], in_tx_data[55], in_tx_data[54], in_tx_data[53], in_tx_data[52], in_tx_data[51], in_tx_data[50], in_tx_data[49], in_tx_data[48], in_tx_data[47], in_tx_data[46], in_tx_data[45], in_tx_data[44], in_tx_data[43], in_tx_data[42], in_tx_data[41], in_tx_data[40], in_tx_data[39], in_tx_data[38], in_tx_data[37], in_tx_data[36], in_tx_data[35], in_tx_data[34], in_tx_data[33], in_tx_data[32], in_tx_data[31], in_tx_data[30], in_tx_data[29], in_tx_data[28], in_tx_data[27], in_tx_data[26], in_tx_data[25], in_tx_data[24], in_tx_data[23], in_tx_data[22], in_tx_data[21], in_tx_data[20], in_tx_data[19], in_tx_data[18], in_tx_data[17], in_tx_data[16], in_tx_data[15], in_tx_data[14], in_tx_data[13], in_tx_data[12], in_tx_data[11], in_tx_data[10], in_tx_data[9], in_tx_data[8], in_tx_data[7], in_tx_data[6], in_tx_data[5], in_tx_data[4], in_tx_data[3], in_tx_data[2], in_tx_data[1], in_tx_data[0]}),
				.hfclkn(w_pma_cgb_cpulse_out_bus[4]),
				.hfclkp(w_pma_cgb_cpulse_out_bus[5]),
				.lfclk(w_pma_cgb_cpulse_out_bus[3]),
				.lfclk2(w_pma_cgb_cpulse_out_bus[2]),
				.paraclk(w_pma_cgb_cpulse_out_bus[0]),
				.rser_div2(w_pma_cgb_div2),
				.rser_div4(w_pma_cgb_div4),
				.rser_div5(w_pma_cgb_div5),
				.rst_n(w_pma_cgb_rstb)
			);
		end // if generate
		else begin
				assign w_pma_tx_ser_avmmreaddata[7:0] = 8'b0;
				assign w_pma_tx_ser_blockselect = 1'b0;
				assign w_pma_tx_ser_ckdrvn = 1'b0;
				assign w_pma_tx_ser_ckdrvp = 1'b0;
				assign w_pma_tx_ser_clk_divtx = 1'b0;
				assign w_pma_tx_ser_clk_divtx_user = 1'b0;
				assign w_pma_tx_ser_oe = 1'b0;
				assign w_pma_tx_ser_oeb = 1'b0;
				assign w_pma_tx_ser_oo = 1'b0;
				assign w_pma_tx_ser_oob = 1'b0;
		end // if not generate
		
		//output assignments
		assign out_avmmreaddata_cdr_pll = {w_cdr_pll_avmmreaddata[7], w_cdr_pll_avmmreaddata[6], w_cdr_pll_avmmreaddata[5], w_cdr_pll_avmmreaddata[4], w_cdr_pll_avmmreaddata[3], w_cdr_pll_avmmreaddata[2], w_cdr_pll_avmmreaddata[1], w_cdr_pll_avmmreaddata[0]};
		assign out_avmmreaddata_pma_adapt = {w_pma_adapt_avmmreaddata[7], w_pma_adapt_avmmreaddata[6], w_pma_adapt_avmmreaddata[5], w_pma_adapt_avmmreaddata[4], w_pma_adapt_avmmreaddata[3], w_pma_adapt_avmmreaddata[2], w_pma_adapt_avmmreaddata[1], w_pma_adapt_avmmreaddata[0]};
		assign out_avmmreaddata_pma_cdr_refclk = {w_pma_cdr_refclk_avmmreaddata[7], w_pma_cdr_refclk_avmmreaddata[6], w_pma_cdr_refclk_avmmreaddata[5], w_pma_cdr_refclk_avmmreaddata[4], w_pma_cdr_refclk_avmmreaddata[3], w_pma_cdr_refclk_avmmreaddata[2], w_pma_cdr_refclk_avmmreaddata[1], w_pma_cdr_refclk_avmmreaddata[0]};
		assign out_avmmreaddata_pma_cgb = {w_pma_cgb_avmmreaddata[7], w_pma_cgb_avmmreaddata[6], w_pma_cgb_avmmreaddata[5], w_pma_cgb_avmmreaddata[4], w_pma_cgb_avmmreaddata[3], w_pma_cgb_avmmreaddata[2], w_pma_cgb_avmmreaddata[1], w_pma_cgb_avmmreaddata[0]};
		assign out_avmmreaddata_pma_rx_buf = {w_pma_rx_buf_avmmreaddata[7], w_pma_rx_buf_avmmreaddata[6], w_pma_rx_buf_avmmreaddata[5], w_pma_rx_buf_avmmreaddata[4], w_pma_rx_buf_avmmreaddata[3], w_pma_rx_buf_avmmreaddata[2], w_pma_rx_buf_avmmreaddata[1], w_pma_rx_buf_avmmreaddata[0]};
		assign out_avmmreaddata_pma_rx_deser = {w_pma_rx_deser_avmmreaddata[7], w_pma_rx_deser_avmmreaddata[6], w_pma_rx_deser_avmmreaddata[5], w_pma_rx_deser_avmmreaddata[4], w_pma_rx_deser_avmmreaddata[3], w_pma_rx_deser_avmmreaddata[2], w_pma_rx_deser_avmmreaddata[1], w_pma_rx_deser_avmmreaddata[0]};
		assign out_avmmreaddata_pma_rx_dfe = {w_pma_rx_dfe_avmmreaddata[7], w_pma_rx_dfe_avmmreaddata[6], w_pma_rx_dfe_avmmreaddata[5], w_pma_rx_dfe_avmmreaddata[4], w_pma_rx_dfe_avmmreaddata[3], w_pma_rx_dfe_avmmreaddata[2], w_pma_rx_dfe_avmmreaddata[1], w_pma_rx_dfe_avmmreaddata[0]};
		assign out_avmmreaddata_pma_rx_odi = {w_pma_rx_odi_avmmreaddata[7], w_pma_rx_odi_avmmreaddata[6], w_pma_rx_odi_avmmreaddata[5], w_pma_rx_odi_avmmreaddata[4], w_pma_rx_odi_avmmreaddata[3], w_pma_rx_odi_avmmreaddata[2], w_pma_rx_odi_avmmreaddata[1], w_pma_rx_odi_avmmreaddata[0]};
		assign out_avmmreaddata_pma_rx_sd = {w_pma_rx_sd_avmmreaddata[7], w_pma_rx_sd_avmmreaddata[6], w_pma_rx_sd_avmmreaddata[5], w_pma_rx_sd_avmmreaddata[4], w_pma_rx_sd_avmmreaddata[3], w_pma_rx_sd_avmmreaddata[2], w_pma_rx_sd_avmmreaddata[1], w_pma_rx_sd_avmmreaddata[0]};
		assign out_avmmreaddata_pma_tx_buf = {w_pma_tx_buf_avmmreaddata[7], w_pma_tx_buf_avmmreaddata[6], w_pma_tx_buf_avmmreaddata[5], w_pma_tx_buf_avmmreaddata[4], w_pma_tx_buf_avmmreaddata[3], w_pma_tx_buf_avmmreaddata[2], w_pma_tx_buf_avmmreaddata[1], w_pma_tx_buf_avmmreaddata[0]};
		assign out_avmmreaddata_pma_tx_ser = {w_pma_tx_ser_avmmreaddata[7], w_pma_tx_ser_avmmreaddata[6], w_pma_tx_ser_avmmreaddata[5], w_pma_tx_ser_avmmreaddata[4], w_pma_tx_ser_avmmreaddata[3], w_pma_tx_ser_avmmreaddata[2], w_pma_tx_ser_avmmreaddata[1], w_pma_tx_ser_avmmreaddata[0]};
		assign out_blockselect_cdr_pll = w_cdr_pll_blockselect;
		assign out_blockselect_pma_adapt = w_pma_adapt_blockselect;
		assign out_blockselect_pma_cdr_refclk = w_pma_cdr_refclk_blockselect;
		assign out_blockselect_pma_cgb = w_pma_cgb_blockselect;
		assign out_blockselect_pma_rx_buf = w_pma_rx_buf_blockselect;
		assign out_blockselect_pma_rx_deser = w_pma_rx_deser_blockselect;
		assign out_blockselect_pma_rx_dfe = w_pma_rx_dfe_blockselect;
		assign out_blockselect_pma_rx_odi = w_pma_rx_odi_blockselect;
		assign out_blockselect_pma_rx_sd = w_pma_rx_sd_blockselect;
		assign out_blockselect_pma_tx_buf = w_pma_tx_buf_blockselect;
		assign out_blockselect_pma_tx_ser = w_pma_tx_ser_blockselect;
		assign out_clk0_pfd = w_cdr_pll_clk0_pfd;
		assign out_clk180_pfd = w_cdr_pll_clk180_pfd;
		assign out_clk_divrx_iqtxrx = w_pma_rx_deser_clkdiv;
		assign out_clk_divtx_iqtxrx = w_pma_tx_ser_clk_divtx;
		assign out_clkdiv_rx = w_pma_rx_deser_clkdiv;
		assign out_clkdiv_rx_user = w_pma_rx_deser_clkdiv_user;
		assign out_clkdiv_tx = w_pma_tx_ser_clk_divtx;
		assign out_clkdiv_tx_user = w_pma_tx_ser_clk_divtx_user;
		assign out_clklow = w_cdr_pll_clklow;
		assign out_fref = w_cdr_pll_fref;
		assign out_iqtxrxclk_out0 = w_pma_tx_ser_clk_divtx;
		assign out_iqtxrxclk_out1 = w_pma_tx_ser_clk_divtx;
		assign out_jtaglpxn = w_pma_tx_buf_vlptxn;
		assign out_jtaglpxp = w_pma_tx_buf_vlptxp;
		assign out_pcie_sw_done = {w_pma_cgb_pcie_sw_done[1], w_pma_cgb_pcie_sw_done[0]};
		assign out_pcie_sw_master = {w_pma_cgb_pcie_sw_master[1], w_pma_cgb_pcie_sw_master[0]};
		assign out_pfdmode_lock = w_cdr_pll_pfdmode_lock;
		assign out_rx_detect_valid = w_pma_tx_buf_rx_detect_valid;
		assign out_rx_found = w_pma_tx_buf_rx_found;
		assign out_rxdata = {w_pma_rx_deser_dout[63], w_pma_rx_deser_dout[62], w_pma_rx_deser_dout[61], w_pma_rx_deser_dout[60], w_pma_rx_deser_dout[59], w_pma_rx_deser_dout[58], w_pma_rx_deser_dout[57], w_pma_rx_deser_dout[56], w_pma_rx_deser_dout[55], w_pma_rx_deser_dout[54], w_pma_rx_deser_dout[53], w_pma_rx_deser_dout[52], w_pma_rx_deser_dout[51], w_pma_rx_deser_dout[50], w_pma_rx_deser_dout[49], w_pma_rx_deser_dout[48], w_pma_rx_deser_dout[47], w_pma_rx_deser_dout[46], w_pma_rx_deser_dout[45], w_pma_rx_deser_dout[44], w_pma_rx_deser_dout[43], w_pma_rx_deser_dout[42], w_pma_rx_deser_dout[41], w_pma_rx_deser_dout[40], w_pma_rx_deser_dout[39], w_pma_rx_deser_dout[38], w_pma_rx_deser_dout[37], w_pma_rx_deser_dout[36], w_pma_rx_deser_dout[35], w_pma_rx_deser_dout[34], w_pma_rx_deser_dout[33], w_pma_rx_deser_dout[32], w_pma_rx_deser_dout[31], w_pma_rx_deser_dout[30], w_pma_rx_deser_dout[29], w_pma_rx_deser_dout[28], w_pma_rx_deser_dout[27], w_pma_rx_deser_dout[26], w_pma_rx_deser_dout[25], w_pma_rx_deser_dout[24], w_pma_rx_deser_dout[23], w_pma_rx_deser_dout[22], w_pma_rx_deser_dout[21], w_pma_rx_deser_dout[20], w_pma_rx_deser_dout[19], w_pma_rx_deser_dout[18], w_pma_rx_deser_dout[17], w_pma_rx_deser_dout[16], w_pma_rx_deser_dout[15], w_pma_rx_deser_dout[14], w_pma_rx_deser_dout[13], w_pma_rx_deser_dout[12], w_pma_rx_deser_dout[11], w_pma_rx_deser_dout[10], w_pma_rx_deser_dout[9], w_pma_rx_deser_dout[8], w_pma_rx_deser_dout[7], w_pma_rx_deser_dout[6], w_pma_rx_deser_dout[5], w_pma_rx_deser_dout[4], w_pma_rx_deser_dout[3], w_pma_rx_deser_dout[2], w_pma_rx_deser_dout[1], w_pma_rx_deser_dout[0]};
		assign out_rxpll_lock = w_cdr_pll_rxpll_lock;
		assign out_sd = w_pma_rx_sd_sd;
		assign out_tx_n = w_pma_tx_buf_von;
		assign out_tx_p = w_pma_tx_buf_vop;
	endgenerate
endmodule
module twentynm_pma_rev_20nm4
	#(
	//PARAM_LIST_START
		parameter xcvr_native_mode = "mode_duplex",  // mode_duplex, mode_rx_only, mode_tx_only
		
		// parameters for twentynm_hssi_pma_adaptation
		parameter pma_adapt_adapt_mode = "dfe_vga", // ctle|dfe_vga|ctle_vga|ctle_vga_dfe|manual
		parameter pma_adapt_adp_1s_ctle_bypass = "radp_1s_ctle_bypass_0", // radp_1s_ctle_bypass_0|radp_1s_ctle_bypass_1
		parameter pma_adapt_adp_4s_ctle_bypass = "radp_4s_ctle_bypass_0", // radp_4s_ctle_bypass_0|radp_4s_ctle_bypass_1
		parameter pma_adapt_adp_ctle_adapt_cycle_window = "radp_ctle_adapt_cycle_window_6", // radp_ctle_adapt_cycle_window_0|radp_ctle_adapt_cycle_window_1|radp_ctle_adapt_cycle_window_2|radp_ctle_adapt_cycle_window_3|radp_ctle_adapt_cycle_window_4|radp_ctle_adapt_cycle_window_5|radp_ctle_adapt_cycle_window_6|radp_ctle_adapt_cycle_window_7
		parameter pma_adapt_adp_ctle_en = "radp_ctle_disable", // radp_ctle_disable|radp_ctle_enable
		parameter pma_adapt_adp_dfe_fltap_bypass = "radp_dfe_fltap_bypass_0", // radp_dfe_fltap_bypass_0|radp_dfe_fltap_bypass_1
		parameter pma_adapt_adp_dfe_fltap_en = "radp_dfe_fltap_disable", // radp_dfe_fltap_disable|radp_dfe_fltap_enable
		parameter pma_adapt_adp_dfe_fxtap_bypass = "radp_dfe_fxtap_bypass_0", // radp_dfe_fxtap_bypass_0|radp_dfe_fxtap_bypass_1
		parameter pma_adapt_adp_dfe_fxtap_en = "radp_dfe_fxtap_disable", // radp_dfe_fxtap_disable|radp_dfe_fxtap_enable
		parameter pma_adapt_adp_dfe_fxtap_hold_en = "radp_dfe_fxtap_not_held", // radp_dfe_fxtap_not_held|radp_dfe_fxtap_hold
		parameter pma_adapt_adp_dfe_mode = "radp_dfe_mode_0", // radp_dfe_mode_0|radp_dfe_mode_1|radp_dfe_mode_2|radp_dfe_mode_3|radp_dfe_mode_4|radp_dfe_mode_5|radp_dfe_mode_6|radp_dfe_mode_7
		parameter pma_adapt_adp_mode = "radp_mode_0", // radp_mode_0|radp_mode_1|radp_mode_2|radp_mode_3|radp_mode_4|radp_mode_5|radp_mode_6|radp_mode_7|radp_mode_8|radp_mode_9|radp_mode_10|radp_mode_11|radp_mode_12|radp_mode_13|radp_mode_14|radp_mode_15
		parameter pma_adapt_adp_onetime_dfe = "radp_onetime_dfe_0", // radp_onetime_dfe_0|radp_onetime_dfe_1
		parameter pma_adapt_adp_vga_bypass = "radp_vga_bypass_0", // radp_vga_bypass_0|radp_vga_bypass_1
		parameter pma_adapt_adp_vga_en = "radp_vga_disable", // radp_vga_disable|radp_vga_enable
		parameter pma_adapt_adp_vref_bypass = "radp_vref_bypass_0", // radp_vref_bypass_0|radp_vref_bypass_1
		parameter pma_adapt_adp_vref_en = "radp_vref_disable", // radp_vref_disable|radp_vref_enable
		parameter pma_adapt_datarate = "0 bps", // 
		parameter pma_adapt_odi_dfe_spec_en = "rodi_dfe_spec_en_0", // rodi_dfe_spec_en_0|rodi_dfe_spec_en_1
		parameter pma_adapt_prot_mode = "basic_rx", // basic_rx|pcie_gen1_rx|pcie_gen2_rx|pcie_gen3_rx|pcie_gen4_rx|qpi_rx|unused|gpon_rx|sata_rx
		parameter pma_adapt_sup_mode = "user_mode", // user_mode|engineering_mode
		
		// parameters for twentynm_hssi_pma_cdr_refclk_select_mux
		parameter pma_cdr_refclk_inclk0_logical_to_physical_mapping = "ref_iqclk0", // ref_iqclk0|ref_iqclk1|ref_iqclk2|ref_iqclk3|ref_iqclk4|ref_iqclk5|ref_iqclk6|ref_iqclk7|ref_iqclk8|ref_iqclk9|ref_iqclk10|ref_iqclk11|iqtxrxclk0|iqtxrxclk1|iqtxrxclk2|iqtxrxclk3|iqtxrxclk4|iqtxrxclk5|coreclk|fixed_clk|lvpecl|adj_pll_clk|power_down
		parameter pma_cdr_refclk_inclk1_logical_to_physical_mapping = "ref_iqclk0", // ref_iqclk0|ref_iqclk1|ref_iqclk2|ref_iqclk3|ref_iqclk4|ref_iqclk5|ref_iqclk6|ref_iqclk7|ref_iqclk8|ref_iqclk9|ref_iqclk10|ref_iqclk11|iqtxrxclk0|iqtxrxclk1|iqtxrxclk2|iqtxrxclk3|iqtxrxclk4|iqtxrxclk5|coreclk|fixed_clk|lvpecl|adj_pll_clk|power_down
		parameter pma_cdr_refclk_inclk2_logical_to_physical_mapping = "ref_iqclk0", // ref_iqclk0|ref_iqclk1|ref_iqclk2|ref_iqclk3|ref_iqclk4|ref_iqclk5|ref_iqclk6|ref_iqclk7|ref_iqclk8|ref_iqclk9|ref_iqclk10|ref_iqclk11|iqtxrxclk0|iqtxrxclk1|iqtxrxclk2|iqtxrxclk3|iqtxrxclk4|iqtxrxclk5|coreclk|fixed_clk|lvpecl|adj_pll_clk|power_down
		parameter pma_cdr_refclk_inclk3_logical_to_physical_mapping = "ref_iqclk0", // ref_iqclk0|ref_iqclk1|ref_iqclk2|ref_iqclk3|ref_iqclk4|ref_iqclk5|ref_iqclk6|ref_iqclk7|ref_iqclk8|ref_iqclk9|ref_iqclk10|ref_iqclk11|iqtxrxclk0|iqtxrxclk1|iqtxrxclk2|iqtxrxclk3|iqtxrxclk4|iqtxrxclk5|coreclk|fixed_clk|lvpecl|adj_pll_clk|power_down
		parameter pma_cdr_refclk_inclk4_logical_to_physical_mapping = "ref_iqclk0", // ref_iqclk0|ref_iqclk1|ref_iqclk2|ref_iqclk3|ref_iqclk4|ref_iqclk5|ref_iqclk6|ref_iqclk7|ref_iqclk8|ref_iqclk9|ref_iqclk10|ref_iqclk11|iqtxrxclk0|iqtxrxclk1|iqtxrxclk2|iqtxrxclk3|iqtxrxclk4|iqtxrxclk5|coreclk|fixed_clk|lvpecl|adj_pll_clk|power_down
		parameter pma_cdr_refclk_powerdown_mode = "powerdown", // powerup|powerdown
		parameter pma_cdr_refclk_refclk_select = "ref_iqclk0", // ref_iqclk0|ref_iqclk1|ref_iqclk2|ref_iqclk3|ref_iqclk4|ref_iqclk5|ref_iqclk6|ref_iqclk7|ref_iqclk8|ref_iqclk9|ref_iqclk10|ref_iqclk11|iqtxrxclk0|iqtxrxclk1|iqtxrxclk2|iqtxrxclk3|iqtxrxclk4|iqtxrxclk5|coreclk|fixed_clk|lvpecl|adj_pll_clk|power_down
		
		// parameters for twentynm_hssi_pma_channel_pll
		parameter cdr_pll_atb_select_control = "atb_off", // atb_off|atb_select_tp_1|atb_select_tp_2|atb_select_tp_3|atb_select_tp_4|atb_select_tp_5|atb_select_tp_6|atb_select_tp_7|atb_select_tp_8|atb_select_tp_9|atb_select_tp_10|atb_select_tp_11|atb_select_tp_12|atb_select_tp_13|atb_select_tp_14|atb_select_tp_15|atb_select_tp_16|atb_select_tp_17|atb_select_tp_18|atb_select_tp_19|atb_select_tp_20|atb_select_tp_21|atb_select_tp_22|atb_select_tp_23|atb_select_tp_24|atb_select_tp_25|atb_select_tp_26|atb_select_tp_27|atb_select_tp_28|atb_select_tp_29|atb_select_tp_30|atb_select_tp_31|atb_select_tp_32|atb_select_tp_33|atb_select_tp_34|atb_select_tp_35|atb_select_tp_36|atb_select_tp_37|atb_select_tp_38|atb_select_tp_39|atb_select_tp_40|atb_select_tp_41|atb_select_tp_42|atb_select_tp_43|atb_select_tp_44|atb_select_tp_45|atb_select_tp_46|atb_select_tp_47|atb_select_tp_48|atb_select_tp_49|atb_select_tp_50|atb_select_tp_51|atb_select_tp_52|atb_select_tp_53|atb_select_tp_54|atb_select_tp_55|atb_select_tp_56|atb_select_tp_57|atb_select_tp_58|atb_select_tp_59|atb_select_tp_60|atb_select_tp_61|atb_select_tp_62|atb_select_tp_63
		parameter cdr_pll_auto_reset_on = "auto_reset_on", // auto_reset_on|auto_reset_off
		parameter cdr_pll_bbpd_data_pattern_filter_select = "bbpd_data_pat_off", // bbpd_data_pat_off|bbpd_data_pat_1|bbpd_data_pat_2|bbpd_data_pat_3
		parameter cdr_pll_bw_sel = "low", // low|medium|high
		parameter cdr_pll_cal_vco_count_length = "sel_8b_count", // sel_8b_count|sel_12b_count
		parameter cdr_pll_cdr_odi_select = "sel_cdr", // sel_cdr|sel_odi
		parameter cdr_pll_cdr_phaselock_mode = "no_ignore_lock", // no_ignore_lock|ignore_lock
		parameter cdr_pll_cdr_powerdown_mode = "power_down", // power_down|power_up
		parameter cdr_pll_cgb_div = 1, // 1|2|4|8
		parameter cdr_pll_chgpmp_current_dn_pd = "cp_current_pd_dn_setting0", // cp_current_pd_dn_setting0|cp_current_pd_dn_setting1|cp_current_pd_dn_setting2|cp_current_pd_dn_setting3|cp_current_pd_dn_setting4
		parameter cdr_pll_chgpmp_current_dn_trim = "cp_current_trimming_dn_setting0", // cp_current_trimming_dn_setting0|cp_current_trimming_dn_setting1|cp_current_trimming_dn_setting2|cp_current_trimming_dn_setting3|cp_current_trimming_dn_setting4|cp_current_trimming_dn_setting5|cp_current_trimming_dn_setting6|cp_current_trimming_dn_setting7|cp_current_trimming_dn_setting8|cp_current_trimming_dn_setting9|cp_current_trimming_dn_setting10|cp_current_trimming_dn_setting11|cp_current_trimming_dn_setting12|cp_current_trimming_dn_setting13|cp_current_trimming_dn_setting14|cp_current_trimming_dn_setting15
		parameter cdr_pll_chgpmp_current_pd = "cp_current_pd_setting0", // cp_current_pd_setting0|cp_current_pd_setting1|cp_current_pd_setting2|cp_current_pd_setting3|cp_current_pd_setting4
		parameter cdr_pll_chgpmp_current_pfd = "cp_current_pfd_setting0", // cp_current_pfd_setting0|cp_current_pfd_setting1|cp_current_pfd_setting2|cp_current_pfd_setting3|cp_current_pfd_setting4
		parameter cdr_pll_chgpmp_current_up_pd = "cp_current_pd_up_setting0", // cp_current_pd_up_setting0|cp_current_pd_up_setting1|cp_current_pd_up_setting2|cp_current_pd_up_setting3|cp_current_pd_up_setting4
		parameter cdr_pll_chgpmp_current_up_trim = "cp_current_trimming_up_setting0", // cp_current_trimming_up_setting0|cp_current_trimming_up_setting1|cp_current_trimming_up_setting2|cp_current_trimming_up_setting3|cp_current_trimming_up_setting4|cp_current_trimming_up_setting5|cp_current_trimming_up_setting6|cp_current_trimming_up_setting7|cp_current_trimming_up_setting8|cp_current_trimming_up_setting9|cp_current_trimming_up_setting10|cp_current_trimming_up_setting11|cp_current_trimming_up_setting12|cp_current_trimming_up_setting13|cp_current_trimming_up_setting14|cp_current_trimming_up_setting15
		parameter cdr_pll_chgpmp_dn_pd_trim_double = "normal_dn_trim_current", // normal_dn_trim_current|double_dn_trim_current
		parameter cdr_pll_chgpmp_replicate = "false", // false|true
		parameter cdr_pll_chgpmp_testmode = "cp_test_disable", // cp_test_disable|cp_test_up|cp_test_dn|cp_tristate
		parameter cdr_pll_chgpmp_up_pd_trim_double = "normal_up_trim_current", // normal_up_trim_current|double_up_trim_current
		parameter cdr_pll_clklow_mux_select = "clklow_mux_cdr_fbclk", // clklow_mux_cdr_fbclk|clklow_mux_fpll_test1|clklow_mux_reserved_1|clklow_mux_rx_deser_pclk_test|clklow_mux_reserved_2|clklow_mux_reserved_3|clklow_mux_reserved_4|clklow_mux_dfe_test
		parameter cdr_pll_datarate = "0 bps", // 
		parameter cdr_pll_diag_loopback_enable = "false", // true|false
		parameter cdr_pll_disable_up_dn = "true", // true|false
		parameter cdr_pll_fb_select = "direct_fb", // iqtxrxclk_fb|direct_fb
		parameter cdr_pll_fref_clklow_div = 1, // 1|2|4|8
		parameter cdr_pll_fref_mux_select = "fref_mux_cdr_refclk", // fref_mux_cdr_refclk|fref_mux_fpll_test0|fref_mux_reserved_1|fref_mux_tx_ser_pclk_test|fref_mux_reserved_2|fref_mux_reserved_3|fref_mux_reserved_4|fref_mux_reserved_5
		parameter cdr_pll_gpon_lck2ref_control = "gpon_lck2ref_off", // gpon_lck2ref_off|gpon_lck2ref_on
		parameter cdr_pll_initial_settings = "false", // false|true
		parameter cdr_pll_iqclk_mux_sel = "power_down", // iqtxrxclk0|iqtxrxclk1|iqtxrxclk2|iqtxrxclk3|iqtxrxclk4|iqtxrxclk5|power_down
		parameter cdr_pll_is_cascaded_pll = "false", // true|false
		parameter cdr_pll_lck2ref_delay_control = "lck2ref_delay_off", // lck2ref_delay_off|lck2ref_delay_1|lck2ref_delay_2|lck2ref_delay_3|lck2ref_delay_4|lck2ref_delay_5|lck2ref_delay_6|lck2ref_delay_7
		parameter cdr_pll_lf_resistor_pd = "lf_pd_setting0", // lf_pd_setting0|lf_pd_setting1|lf_pd_setting2|lf_pd_setting3
		parameter cdr_pll_lf_resistor_pfd = "lf_pfd_setting0", // lf_pfd_setting0|lf_pfd_setting1|lf_pfd_setting2|lf_pfd_setting3
		parameter cdr_pll_lf_ripple_cap = "lf_no_ripple", // lf_no_ripple|lf_ripple_cap1
		parameter cdr_pll_loop_filter_bias_select = "lpflt_bias_off", // lpflt_bias_off|lpflt_bias_1|lpflt_bias_2|lpflt_bias_3|lpflt_bias_4|lpflt_bias_5|lpflt_bias_6|lpflt_bias_7
		parameter cdr_pll_loopback_mode = "loopback_disabled", // loopback_disabled|loopback_recovered_data|rx_refclk|rx_refclk_cdr_loopback|unused2|loopback_received_data|unused1
		parameter cdr_pll_lpd_counter = 5'b1,
		parameter cdr_pll_lpfd_counter = 5'b1,
		parameter cdr_pll_ltd_ltr_micro_controller_select = "ltd_ltr_pcs", // ltd_ltr_pcs|ltr_ucontroller|ltd_ucontroller
		parameter cdr_pll_m_counter = 16, // 0..255
		parameter cdr_pll_n_counter = 1, // 1|2|4|8
		parameter cdr_pll_n_counter_scratch = 6'b1,
		parameter cdr_pll_output_clock_frequency = "0 hz", // 
		parameter cdr_pll_pcie_gen = "non_pcie", // pcie_gen1_100mhzref|pcie_gen2_100mhzref|pcie_gen3_100mhzref|pcie_gen1_125mhzref|pcie_gen2_125mhzref|pcie_gen3_125mhzref|non_pcie
		parameter cdr_pll_pd_fastlock_mode = "false", // false|true
		parameter cdr_pll_pd_l_counter = 1, // 0|1|2|4|8|16
		parameter cdr_pll_pfd_l_counter = 1, // 0|1|2|4|8|16|100
		parameter cdr_pll_pma_width = 8, // 8|10|16|20|32|40|64
		parameter cdr_pll_primary_use = "cmu", // cmu|cdr
		parameter cdr_pll_prot_mode = "unused", // basic_rx|pcie_gen1_rx|pcie_gen2_rx|pcie_gen3_rx|pcie_gen4_rx|qpi_rx|unused|gpon_rx|sata_rx
		parameter cdr_pll_reference_clock_frequency = "0 hz", // 
		parameter cdr_pll_reverse_serial_loopback = "no_loopback", // no_loopback|loopback_data_no_posttap|loopback_data_with_posttap|loopback_data_0_1
		parameter cdr_pll_set_cdr_input_freq_range = 8'b0,
		parameter cdr_pll_set_cdr_v2i_enable = "true", // true|false
		parameter cdr_pll_set_cdr_vco_reset = "false", // true|false
		parameter cdr_pll_set_cdr_vco_speed = 5'b1,
		parameter cdr_pll_set_cdr_vco_speed_fix = 8'b0,
		parameter cdr_pll_set_cdr_vco_speed_pciegen3 = "cdr_vco_max_speedbin_pciegen3", // cdr_vco_min_speedbin_pciegen3|cdr_vco_max_speedbin_pciegen3
		parameter cdr_pll_sup_mode = "user_mode", // user_mode|engineering_mode
		parameter cdr_pll_tx_pll_prot_mode = "txpll_unused", // txpll_unused|txpll_enable_pcie|txpll_enable
		parameter cdr_pll_txpll_hclk_driver_enable = "false", // true|false
		parameter cdr_pll_uc_ro_cal = "uc_ro_cal_off", // uc_ro_cal_off|uc_ro_cal_on
		parameter cdr_pll_vco_freq = "0 hz", // 
		parameter cdr_pll_vco_overrange_voltage = "vco_overrange_off", // vco_overrange_off|vco_overrange_ref_1|vco_overrange_ref_2|vco_overrange_ref_3
		parameter cdr_pll_vco_underrange_voltage = "vco_underange_off", // vco_underange_off|vco_underange_ref_1|vco_underange_ref_2|vco_underange_ref_3
		
		// parameters for twentynm_hssi_pma_rx_buf
		parameter pma_rx_buf_bypass_eqz_stages_234 = "bypass_off", // bypass_off|byypass_stages_234
		parameter pma_rx_buf_datarate = "0 bps", // 
		parameter pma_rx_buf_diag_lp_en = "dlp_off", // dlp_off|dlp_on
		parameter pma_rx_buf_loopback_modes = "lpbk_disable", // lpbk_disable|pre_cdr|post_cdr
		parameter pma_rx_buf_pm_tx_rx_cvp_mode = "cvp_off", // cvp_off|cvp_on
		parameter pma_rx_buf_pm_tx_rx_pcie_gen = "non_pcie", // pcie_gen1_100mhzref|pcie_gen2_100mhzref|pcie_gen3_100mhzref|pcie_gen1_125mhzref|pcie_gen2_125mhzref|pcie_gen3_125mhzref|non_pcie
		parameter pma_rx_buf_pm_tx_rx_pcie_gen_bitwidth = "pcie_gen3_32b", // pcie_gen3_32b|pcie_gen3_16b
		parameter pma_rx_buf_prot_mode = "basic_rx", // basic_rx|pcie_gen1_rx|pcie_gen2_rx|pcie_gen3_rx|pcie_gen4_rx|qpi_rx|unused|gpon_rx|sata_rx
		parameter pma_rx_buf_qpi_enable = "non_qpi_mode", // non_qpi_mode|qpi_mode
		parameter pma_rx_buf_refclk_en = "enable", // disable|enable
		parameter pma_rx_buf_rx_refclk_divider = "bypass_divider", // bypass_divider|divide_by_2
		parameter pma_rx_buf_sup_mode = "user_mode", // user_mode|engineering_mode
		parameter pma_rx_buf_xrx_path_datarate = "0 bps", // 
		parameter pma_rx_buf_xrx_path_datawidth = 8'b0,
		parameter pma_rx_buf_xrx_path_pma_rx_divclk_hz = 32'b0,
		parameter pma_rx_buf_xrx_path_prot_mode = "unused", // basic_rx|pcie_gen1_rx|pcie_gen2_rx|pcie_gen3_rx|pcie_gen4_rx|qpi_rx|unused|gpon_rx|sata_rx
		parameter pma_rx_buf_xrx_path_sup_mode = "user_mode", // user_mode|engineering_mode
		parameter pma_rx_buf_xrx_path_uc_cal_enable = "rx_cal_off", // rx_cal_off|rx_cal_on
		
		// parameters for twentynm_hssi_pma_rx_deser
		parameter pma_rx_deser_bitslip_bypass = "bs_bypass_no", // bs_bypass_no|bs_bypass_yes
		parameter pma_rx_deser_clkdiv_source = "vco_bypass_normal", // vco_bypass_normal|clklow_to_clkdivrx|fref_to_clkdivrx
		parameter pma_rx_deser_clkdivrx_user_mode = "clkdivrx_user_disabled", // clkdivrx_user_disabled|clkdivrx_user_clkdiv|clkdivrx_user_clkdiv_div2|clkdivrx_user_div40|clkdivrx_user_div33|clkdivrx_user_div66
		parameter pma_rx_deser_datarate = "0 bps", // 
		parameter pma_rx_deser_deser_factor = 8, // 8|10|16|20|32|40|64
		parameter pma_rx_deser_force_clkdiv_for_testing = "normal_clkdiv", // normal_clkdiv|forced_0|forced_1
		parameter pma_rx_deser_pcie_gen = "non_pcie", // pcie_gen1_100mhzref|pcie_gen2_100mhzref|pcie_gen3_100mhzref|pcie_gen1_125mhzref|pcie_gen2_125mhzref|pcie_gen3_125mhzref|non_pcie
		parameter pma_rx_deser_pcie_gen_bitwidth = "pcie_gen3_32b", // pcie_gen3_32b|pcie_gen3_16b
		parameter pma_rx_deser_prot_mode = "basic_rx", // basic_rx|pcie_gen1_rx|pcie_gen2_rx|pcie_gen3_rx|pcie_gen4_rx|qpi_rx|unused|gpon_rx|sata_rx
		parameter pma_rx_deser_rst_n_adapt_odi = "no_rst_adapt_odi", // yes_rst_adapt_odi|no_rst_adapt_odi
		parameter pma_rx_deser_sdclk_enable = "false", // false|true
		parameter pma_rx_deser_sup_mode = "user_mode", // user_mode|engineering_mode
		
		// parameters for twentynm_hssi_pma_rx_dfe
		parameter pma_rx_dfe_datarate = "0 bps", // 
		parameter pma_rx_dfe_dft_en = "dft_disable", // dft_disable|dft_enalbe
		parameter pma_rx_dfe_pdb = "dfe_enable", // dfe_powerdown|dfe_reset|dfe_enable
		parameter pma_rx_dfe_pdb_fixedtap = "fixtap_dfe_powerdown", // fixtap_dfe_powerdown|fixtap_dfe_enable
		parameter pma_rx_dfe_pdb_floattap = "floattap_dfe_powerdown", // floattap_dfe_powerdown|floattap_dfe_enable
		parameter pma_rx_dfe_pdb_fxtap4t7 = "fxtap4t7_powerdown", // fxtap4t7_powerdown|fxtap4t7_enable
		parameter pma_rx_dfe_prot_mode = "basic_rx", // basic_rx|pcie_gen1_rx|pcie_gen2_rx|pcie_gen3_rx|pcie_gen4_rx|qpi_rx|unused|gpon_rx|sata_rx
		parameter pma_rx_dfe_sup_mode = "user_mode", // user_mode|engineering_mode
		
		// parameters for twentynm_hssi_pma_rx_odi
		parameter pma_rx_odi_datarate = "0 bps", // 
		parameter pma_rx_odi_prot_mode = "basic_rx", // basic_rx|pcie_gen1_rx|pcie_gen2_rx|pcie_gen3_rx|pcie_gen4_rx|qpi_rx|unused|gpon_rx|sata_rx
		parameter pma_rx_odi_step_ctrl_sel = "feedback_mode", // dprio_mode|feedback_mode|jm_mode
		parameter pma_rx_odi_sup_mode = "user_mode", // user_mode|engineering_mode
		
		// parameters for twentynm_hssi_pma_rx_sd
		parameter pma_rx_sd_prot_mode = "basic_rx", // basic_rx|pcie_gen1_rx|pcie_gen2_rx|pcie_gen3_rx|pcie_gen4_rx|qpi_rx|unused|gpon_rx|sata_rx
		parameter pma_rx_sd_sd_output_off = 1, // 0..28
		parameter pma_rx_sd_sd_output_on = 1, // 0..15
		parameter pma_rx_sd_sd_pdb = "sd_off", // sd_on|sd_off
		parameter pma_rx_sd_sup_mode = "user_mode", // user_mode|engineering_mode
		
		// parameters for twentynm_hssi_pma_tx_buf
		parameter pma_tx_buf_datarate = "0 bps", // 
		parameter pma_tx_buf_mcgb_location_for_pcie = 4'b0,
		parameter pma_tx_buf_prot_mode = "basic_tx", // unused|basic_tx|pcie_gen1_tx|pcie_gen2_tx|pcie_gen3_tx|pcie_gen4_tx|qpi_tx|gpon_tx|sata_tx
		parameter pma_tx_buf_rx_det = "mode_0", // mode_0|mode_1|mode_2|mode_3|mode_4|mode_5|mode_6|mode_7|mode_8|mode_9|mode_10|mode_11|mode_12|mode_13|mode_14|mode_15
		parameter pma_tx_buf_rx_det_output_sel = "rx_det_pcie_out", // rx_det_pcie_out|rx_det_qpi_out
		parameter pma_tx_buf_rx_det_pdb = "rx_det_off", // rx_det_off|rx_det_on
		parameter pma_tx_buf_sup_mode = "user_mode", // user_mode|engineering_mode
		parameter pma_tx_buf_user_fir_coeff_ctrl_sel = "ram_ctl", // ram_ctl|dynamic_ctl
		parameter pma_tx_buf_xtx_path_clock_divider_ratio = 4'b0,
		parameter pma_tx_buf_xtx_path_datarate = "0 bps", // 
		parameter pma_tx_buf_xtx_path_datawidth = 8'b0,
		parameter pma_tx_buf_xtx_path_pma_tx_divclk_hz = 32'b0,
		parameter pma_tx_buf_xtx_path_prot_mode = "basic_tx", // unused|basic_tx|pcie_gen1_tx|pcie_gen2_tx|pcie_gen3_tx|pcie_gen4_tx|qpi_tx|gpon_tx|sata_tx
		parameter pma_tx_buf_xtx_path_sup_mode = "user_mode", // user_mode|engineering_mode
		parameter pma_tx_buf_xtx_path_tx_pll_clk_hz = "0 hz", // 
		
		// parameters for twentynm_hssi_pma_tx_cgb
		parameter pma_cgb_bitslip_enable = "enable_bitslip", // disable_bitslip|enable_bitslip
		parameter pma_cgb_bonding_reset_enable = "allow_bonding_reset", // disallow_bonding_reset|allow_bonding_reset
		parameter pma_cgb_datarate = "0 bps", // 
		parameter pma_cgb_input_select_gen3 = "unused", // lcpll_bot|lcpll_top|fpll_bot|fpll_top|cdr_txpll_b|cdr_txpll_t|same_ch_txpll|lcpll_hs|hfclk_xn_up|hfclk_x6_dn|hfclk_xn_dn|hfclk_x6_up|unused
		parameter pma_cgb_input_select_x1 = "unused", // lcpll_bot|lcpll_top|fpll_bot|fpll_top|cdr_txpll_b|cdr_txpll_t|same_ch_txpll|lcpll_hs|hfclk_xn_up|hfclk_x6_dn|hfclk_xn_dn|hfclk_x6_up|unused
		parameter pma_cgb_input_select_xn = "unused", // sel_xn_up|sel_xn_dn|sel_x6_up|sel_x6_dn|sel_cgb_loc|unused
		parameter pma_cgb_pcie_gen3_bitwidth = "pciegen3_wide", // pciegen3_wide|pciegen3_narrow
		parameter pma_cgb_prot_mode = "basic_tx", // unused|basic_tx|pcie_gen1_tx|pcie_gen2_tx|pcie_gen3_tx|pcie_gen4_tx|qpi_tx|gpon_tx|sata_tx
		parameter pma_cgb_scratch0_x1_clock_src = "unused", // lcpll_bot|lcpll_top|fpll_bot|fpll_top|cdr_txpll_b|cdr_txpll_t|same_ch_txpll|lcpll_hs|hfclk_xn_up|hfclk_x6_dn|hfclk_xn_dn|hfclk_x6_up|unused
		parameter pma_cgb_scratch1_x1_clock_src = "unused", // lcpll_bot|lcpll_top|fpll_bot|fpll_top|cdr_txpll_b|cdr_txpll_t|same_ch_txpll|lcpll_hs|hfclk_xn_up|hfclk_x6_dn|hfclk_xn_dn|hfclk_x6_up|unused
		parameter pma_cgb_scratch2_x1_clock_src = "unused", // lcpll_bot|lcpll_top|fpll_bot|fpll_top|cdr_txpll_b|cdr_txpll_t|same_ch_txpll|lcpll_hs|hfclk_xn_up|hfclk_x6_dn|hfclk_xn_dn|hfclk_x6_up|unused
		parameter pma_cgb_scratch3_x1_clock_src = "unused", // lcpll_bot|lcpll_top|fpll_bot|fpll_top|cdr_txpll_b|cdr_txpll_t|same_ch_txpll|lcpll_hs|hfclk_xn_up|hfclk_x6_dn|hfclk_xn_dn|hfclk_x6_up|unused
		parameter pma_cgb_select_done_master_or_slave = "choose_slave_pcie_sw_done", // choose_master_pcie_sw_done|choose_slave_pcie_sw_done
		parameter pma_cgb_ser_mode = "eight_bit", // eight_bit|ten_bit|sixteen_bit|twenty_bit|thirty_two_bit|forty_bit|sixty_four_bit
		parameter pma_cgb_sup_mode = "user_mode", // user_mode|engineering_mode
		parameter pma_cgb_tx_ucontrol_en = "disable", // disable|enable
		parameter pma_cgb_x1_div_m_sel = "divbypass", // divbypass|divby2|divby4|divby8
		
		// parameters for twentynm_hssi_pma_tx_ser
		parameter pma_tx_ser_prot_mode = "basic_tx", // unused|basic_tx|pcie_gen1_tx|pcie_gen2_tx|pcie_gen3_tx|pcie_gen4_tx|qpi_tx|gpon_tx|sata_tx
		parameter pma_tx_ser_ser_clk_divtx_user_sel = "divtx_user_33", // divtx_user_2|divtx_user_40|divtx_user_33|divtx_user_66|divtx_user_1|divtx_user_off
		parameter pma_tx_ser_sup_mode = "user_mode" // user_mode|engineering_mode
	//PARAM_LIST_END
	)
	(
	//PORT_LIST_START
		input wire		in_adapt_start,
		input wire	[8:0]	in_avmmaddress,
		input wire		in_avmmclk,
		input wire		in_avmmread,
		input wire		in_avmmrstn,
		input wire		in_avmmwrite,
		input wire	[7:0]	in_avmmwritedata,
		input wire		in_clk_cdr_b,
		input wire		in_clk_cdr_t,
		input wire		in_clk_fpll_b,
		input wire		in_clk_fpll_t,
		input wire		in_clk_lc_b,
		input wire		in_clk_lc_hs,
		input wire		in_clk_lc_t,
		input wire		in_clkb_cdr_b,
		input wire		in_clkb_cdr_t,
		input wire		in_clkb_fpll_b,
		input wire		in_clkb_fpll_t,
		input wire		in_clkb_lc_b,
		input wire		in_clkb_lc_hs,
		input wire		in_clkb_lc_t,
		input wire		in_core_refclk_in,
		input wire	[5:0]	in_cpulse_x6_dn_bus,
		input wire	[5:0]	in_cpulse_x6_up_bus,
		input wire	[5:0]	in_cpulse_xn_dn_bus,
		input wire	[5:0]	in_cpulse_xn_up_bus,
		input wire		in_early_eios,
		input wire	[5:0]	in_eye_monitor,
		input wire	[1:0]	in_fpll_ppm_clk_in,
		input wire	[17:0]	in_i_coeff,
		input wire	[2:0]	in_i_rxpreset,
		input wire	[5:0]	in_iqtxrxclk,
		input wire		in_ltd_b,
		input wire		in_ltr,
		input wire	[1:0]	in_pcie_sw,
		input wire	[1:0]	in_pcie_sw_done_master_in,
		input wire		in_pma_atpg_los_en_n_in,
		input wire	[4:0]	in_pma_reserved_out,
		input wire		in_ppm_lock,
		input wire	[11:0]	in_ref_iqclk,
		input wire		in_rs_lpbk_b,
		input wire	[5:0]	in_rx50_buf_in,
		input wire		in_rx_bitslip,
		input wire		in_rx_n,
		input wire		in_rx_p,
		input wire		in_rx_pma_rstb,
		input wire		in_rx_qpi_pulldn,
		input wire		in_scan_mode_n,
		input wire		in_scan_shift_n,
		input wire	[8:0]	in_tx50_buf_in,
		input wire		in_tx_bitslip,
		input wire		in_tx_bonding_rstb,
		input wire	[63:0]	in_tx_data,
		input wire		in_tx_det_rx,
		input wire		in_tx_elec_idle,
		input wire		in_tx_pma_rstb,
		input wire		in_tx_qpi_pulldn,
		input wire		in_tx_qpi_pullup,
		output wire	[7:0]	out_avmmreaddata_cdr_pll,
		output wire	[7:0]	out_avmmreaddata_pma_adapt,
		output wire	[7:0]	out_avmmreaddata_pma_cdr_refclk,
		output wire	[7:0]	out_avmmreaddata_pma_cgb,
		output wire	[7:0]	out_avmmreaddata_pma_rx_buf,
		output wire	[7:0]	out_avmmreaddata_pma_rx_deser,
		output wire	[7:0]	out_avmmreaddata_pma_rx_dfe,
		output wire	[7:0]	out_avmmreaddata_pma_rx_odi,
		output wire	[7:0]	out_avmmreaddata_pma_rx_sd,
		output wire	[7:0]	out_avmmreaddata_pma_tx_buf,
		output wire	[7:0]	out_avmmreaddata_pma_tx_ser,
		output wire		out_blockselect_cdr_pll,
		output wire		out_blockselect_pma_adapt,
		output wire		out_blockselect_pma_cdr_refclk,
		output wire		out_blockselect_pma_cgb,
		output wire		out_blockselect_pma_rx_buf,
		output wire		out_blockselect_pma_rx_deser,
		output wire		out_blockselect_pma_rx_dfe,
		output wire		out_blockselect_pma_rx_odi,
		output wire		out_blockselect_pma_rx_sd,
		output wire		out_blockselect_pma_tx_buf,
		output wire		out_blockselect_pma_tx_ser,
		output wire		out_clk0_pfd,
		output wire		out_clk180_pfd,
		output wire		out_clk_divrx_iqtxrx,
		output wire		out_clk_divtx_iqtxrx,
		output wire		out_clkdiv_rx,
		output wire		out_clkdiv_rx_user,
		output wire		out_clkdiv_tx,
		output wire		out_clkdiv_tx_user,
		output wire		out_clklow,
		output wire		out_fref,
		output wire		out_iqtxrxclk_out0,
		output wire		out_iqtxrxclk_out1,
		output wire		out_jtaglpxn,
		output wire		out_jtaglpxp,
		output wire	[1:0]	out_pcie_sw_done,
		output wire	[1:0]	out_pcie_sw_master,
		output wire		out_pfdmode_lock,
		output wire		out_rx_detect_valid,
		output wire		out_rx_found,
		output wire	[63:0]	out_rxdata,
		output wire		out_rxpll_lock,
		output wire		out_sd,
		output wire		out_tx_n,
		output wire		out_tx_p
	//PORT_LIST_END
	);
	//wire declarations
	
	// wires for module twentynm_hssi_pma_rx_dfe
	wire	[7:0]	w_pma_rx_dfe_avmmreaddata;
	wire		w_pma_rx_dfe_blockselect;
	wire		w_pma_rx_dfe_clk0_bbpd;
	wire		w_pma_rx_dfe_clk180_bbpd;
	wire		w_pma_rx_dfe_clk270_bbpd;
	wire		w_pma_rx_dfe_clk90_bbpd;
	wire		w_pma_rx_dfe_deven;
	wire		w_pma_rx_dfe_devenb;
	wire	[7:0]	w_pma_rx_dfe_dfe_oc_tstmx;
	wire		w_pma_rx_dfe_dodd;
	wire		w_pma_rx_dfe_doddb;
	wire		w_pma_rx_dfe_edge270;
	wire		w_pma_rx_dfe_edge270b;
	wire		w_pma_rx_dfe_edge90;
	wire		w_pma_rx_dfe_edge90b;
	wire		w_pma_rx_dfe_err_ev;
	wire		w_pma_rx_dfe_err_evb;
	wire		w_pma_rx_dfe_err_od;
	wire		w_pma_rx_dfe_err_odb;
	wire		w_pma_rx_dfe_spec_vrefh;
	wire		w_pma_rx_dfe_spec_vrefl;
	
	// wires for module twentynm_hssi_pma_tx_ser
	wire	[7:0]	w_pma_tx_ser_avmmreaddata;
	wire		w_pma_tx_ser_blockselect;
	wire		w_pma_tx_ser_ckdrvn;
	wire		w_pma_tx_ser_ckdrvp;
	wire		w_pma_tx_ser_clk_divtx;
	wire		w_pma_tx_ser_clk_divtx_user;
	wire		w_pma_tx_ser_oe;
	wire		w_pma_tx_ser_oeb;
	wire		w_pma_tx_ser_oo;
	wire		w_pma_tx_ser_oob;
	
	// wires for module twentynm_hssi_pma_tx_buf
	wire	[2:0]	w_pma_tx_buf_atbsel;
	wire	[7:0]	w_pma_tx_buf_avmmreaddata;
	wire		w_pma_tx_buf_blockselect;
	wire		w_pma_tx_buf_ckn;
	wire		w_pma_tx_buf_ckp;
	wire		w_pma_tx_buf_dcd_out1;
	wire		w_pma_tx_buf_dcd_out2;
	wire		w_pma_tx_buf_dcd_out_ready;
	wire	[1:0]	w_pma_tx_buf_detect_on;
	wire		w_pma_tx_buf_lbvon;
	wire		w_pma_tx_buf_lbvop;
	wire		w_pma_tx_buf_rx_detect_valid;
	wire		w_pma_tx_buf_rx_found;
	wire		w_pma_tx_buf_rx_found_pcie_spl_test;
	wire		w_pma_tx_buf_sel_vreg;
	wire		w_pma_tx_buf_spl_clk_test;
	wire	[7:0]	w_pma_tx_buf_tx_dftout;
	wire		w_pma_tx_buf_vlptxn;
	wire		w_pma_tx_buf_vlptxp;
	wire		w_pma_tx_buf_von;
	wire		w_pma_tx_buf_vop;
	
	// wires for module twentynm_hssi_pma_tx_cgb
	wire	[7:0]	w_pma_cgb_avmmreaddata;
	wire		w_pma_cgb_bitslipstate;
	wire		w_pma_cgb_blockselect;
	wire	[5:0]	w_pma_cgb_cpulse_out_bus;
	wire		w_pma_cgb_div2;
	wire		w_pma_cgb_div4;
	wire		w_pma_cgb_div5;
	wire		w_pma_cgb_hifreqclkn;
	wire		w_pma_cgb_hifreqclkp;
	wire	[1:0]	w_pma_cgb_pcie_sw_done;
	wire	[1:0]	w_pma_cgb_pcie_sw_master;
	wire		w_pma_cgb_rstb;
	
	// wires for module twentynm_hssi_pma_rx_sd
	wire	[7:0]	w_pma_rx_sd_avmmreaddata;
	wire		w_pma_rx_sd_blockselect;
	wire		w_pma_rx_sd_sd;
	
	// wires for module twentynm_hssi_pma_rx_deser
	wire		w_pma_rx_deser_adapt_clk;
	wire	[7:0]	w_pma_rx_deser_avmmreaddata;
	wire		w_pma_rx_deser_blockselect;
	wire		w_pma_rx_deser_clkdiv;
	wire		w_pma_rx_deser_clkdiv_user;
	wire		w_pma_rx_deser_clkdivrx_rx;
	wire	[63:0]	w_pma_rx_deser_data;
	wire	[63:0]	w_pma_rx_deser_dout;
	wire	[63:0]	w_pma_rx_deser_error_deser;
	wire	[63:0]	w_pma_rx_deser_odi_dout;
	wire	[1:0]	w_pma_rx_deser_pcie_sw_ret;
	wire	[7:0]	w_pma_rx_deser_tstmx_deser;
	
	// wires for module twentynm_hssi_pma_cdr_refclk_select_mux
	wire	[7:0]	w_pma_cdr_refclk_avmmreaddata;
	wire		w_pma_cdr_refclk_blockselect;
	wire		w_pma_cdr_refclk_refclk;
	wire		w_pma_cdr_refclk_rx_det_clk;
	
	// wires for module twentynm_hssi_pma_adaptation
	wire	[7:0]	w_pma_adapt_avmmreaddata;
	wire		w_pma_adapt_blockselect;
	wire	[27:0]	w_pma_adapt_ctle_acgain_4s;
	wire	[14:0]	w_pma_adapt_ctle_eqz_1s_sel;
	wire	[6:0]	w_pma_adapt_ctle_lfeq_fb_sel;
	wire		w_pma_adapt_dfe_adapt_en;
	wire		w_pma_adapt_dfe_adp_clk;
	wire	[5:0]	w_pma_adapt_dfe_fltap1;
	wire		w_pma_adapt_dfe_fltap1_sgn;
	wire	[5:0]	w_pma_adapt_dfe_fltap2;
	wire		w_pma_adapt_dfe_fltap2_sgn;
	wire	[5:0]	w_pma_adapt_dfe_fltap3;
	wire		w_pma_adapt_dfe_fltap3_sgn;
	wire	[5:0]	w_pma_adapt_dfe_fltap4;
	wire		w_pma_adapt_dfe_fltap4_sgn;
	wire		w_pma_adapt_dfe_fltap_bypdeser;
	wire	[5:0]	w_pma_adapt_dfe_fltap_position;
	wire	[6:0]	w_pma_adapt_dfe_fxtap1;
	wire	[6:0]	w_pma_adapt_dfe_fxtap2;
	wire		w_pma_adapt_dfe_fxtap2_sgn;
	wire	[6:0]	w_pma_adapt_dfe_fxtap3;
	wire		w_pma_adapt_dfe_fxtap3_sgn;
	wire	[5:0]	w_pma_adapt_dfe_fxtap4;
	wire		w_pma_adapt_dfe_fxtap4_sgn;
	wire	[5:0]	w_pma_adapt_dfe_fxtap5;
	wire		w_pma_adapt_dfe_fxtap5_sgn;
	wire	[4:0]	w_pma_adapt_dfe_fxtap6;
	wire		w_pma_adapt_dfe_fxtap6_sgn;
	wire	[4:0]	w_pma_adapt_dfe_fxtap7;
	wire		w_pma_adapt_dfe_fxtap7_sgn;
	wire		w_pma_adapt_dfe_spec_disable;
	wire		w_pma_adapt_dfe_spec_sign_sel;
	wire		w_pma_adapt_dfe_vref_sign_sel;
	wire	[4:0]	w_pma_adapt_odi_vref;
	wire	[6:0]	w_pma_adapt_vga_sel;
	wire	[4:0]	w_pma_adapt_vref_sel;
	
	// wires for module twentynm_hssi_pma_rx_odi
	wire	[7:0]	w_pma_rx_odi_avmmreaddata;
	wire		w_pma_rx_odi_blockselect;
	wire		w_pma_rx_odi_clk0_eye;
	wire		w_pma_rx_odi_clk0_eye_lb;
	wire		w_pma_rx_odi_clk180_eye;
	wire		w_pma_rx_odi_clk180_eye_lb;
	wire		w_pma_rx_odi_de_eye;
	wire		w_pma_rx_odi_deb_eye;
	wire		w_pma_rx_odi_do_eye;
	wire		w_pma_rx_odi_dob_eye;
	wire		w_pma_rx_odi_odi_en;
	wire	[1:0]	w_pma_rx_odi_odi_oc_tstmx;
	
	// wires for module twentynm_hssi_pma_channel_pll
	wire	[7:0]	w_cdr_pll_avmmreaddata;
	wire		w_cdr_pll_blockselect;
	wire		w_cdr_pll_cdr_cnt_done;
	wire	[11:0]	w_cdr_pll_cdr_refclk_cal_out;
	wire	[11:0]	w_cdr_pll_cdr_vco_cal_out;
	wire		w_cdr_pll_clk0_des;
	wire		w_cdr_pll_clk0_odi;
	wire		w_cdr_pll_clk0_pd;
	wire		w_cdr_pll_clk0_pfd;
	wire		w_cdr_pll_clk180_des;
	wire		w_cdr_pll_clk180_odi;
	wire		w_cdr_pll_clk180_pd;
	wire		w_cdr_pll_clk180_pfd;
	wire		w_cdr_pll_clk270_odi;
	wire		w_cdr_pll_clk270_pd;
	wire		w_cdr_pll_clk90_odi;
	wire		w_cdr_pll_clk90_pd;
	wire		w_cdr_pll_clklow;
	wire		w_cdr_pll_deven_des;
	wire		w_cdr_pll_devenb_des;
	wire		w_cdr_pll_dodd_des;
	wire		w_cdr_pll_doddb_des;
	wire		w_cdr_pll_error_even_des;
	wire		w_cdr_pll_error_evenb_des;
	wire		w_cdr_pll_error_odd_des;
	wire		w_cdr_pll_error_oddb_des;
	wire		w_cdr_pll_fref;
	wire		w_cdr_pll_overrange;
	wire		w_cdr_pll_pfdmode_lock;
	wire		w_cdr_pll_rlpbkdn;
	wire		w_cdr_pll_rlpbkdp;
	wire		w_cdr_pll_rlpbkn;
	wire		w_cdr_pll_rlpbkp;
	wire		w_cdr_pll_rxpll_lock;
	wire		w_cdr_pll_tx_rlpbk;
	wire		w_cdr_pll_underrange;
	
	// wires for module twentynm_hssi_pma_rx_buf
	wire	[7:0]	w_pma_rx_buf_avmmreaddata;
	wire		w_pma_rx_buf_blockselect;
	wire		w_pma_rx_buf_inn;
	wire		w_pma_rx_buf_inp;
	wire		w_pma_rx_buf_outn;
	wire		w_pma_rx_buf_outp;
	wire		w_pma_rx_buf_pull_dn;
	wire		w_pma_rx_buf_rdlpbkn;
	wire		w_pma_rx_buf_rdlpbkp;
	
	
	generate
		
		//module instantiations
		
		// instantiating twentynm_hssi_pma_adaptation
		if ((xcvr_native_mode == "mode_rx_only") || (xcvr_native_mode == "mode_duplex")) begin:gen_twentynm_hssi_pma_adaptation
			twentynm_hssi_pma_adaptation #(
				.adapt_mode(pma_adapt_adapt_mode),
				.adp_1s_ctle_bypass(pma_adapt_adp_1s_ctle_bypass),
				.adp_4s_ctle_bypass(pma_adapt_adp_4s_ctle_bypass),
				.adp_ctle_adapt_cycle_window(pma_adapt_adp_ctle_adapt_cycle_window),
				.adp_ctle_en(pma_adapt_adp_ctle_en),
				.adp_dfe_fltap_bypass(pma_adapt_adp_dfe_fltap_bypass),
				.adp_dfe_fltap_en(pma_adapt_adp_dfe_fltap_en),
				.adp_dfe_fxtap_bypass(pma_adapt_adp_dfe_fxtap_bypass),
				.adp_dfe_fxtap_en(pma_adapt_adp_dfe_fxtap_en),
				.adp_dfe_fxtap_hold_en(pma_adapt_adp_dfe_fxtap_hold_en),
				.adp_dfe_mode(pma_adapt_adp_dfe_mode),
				.adp_mode(pma_adapt_adp_mode),
				.adp_onetime_dfe(pma_adapt_adp_onetime_dfe),
				.adp_vga_bypass(pma_adapt_adp_vga_bypass),
				.adp_vga_en(pma_adapt_adp_vga_en),
				.adp_vref_bypass(pma_adapt_adp_vref_bypass),
				.adp_vref_en(pma_adapt_adp_vref_en),
				.datarate(pma_adapt_datarate),
				.initial_settings("true"),       //PARAM_HIDE
				.odi_dfe_spec_en(pma_adapt_odi_dfe_spec_en),
				.optimal("false"),       //PARAM_HIDE
				.prot_mode(pma_adapt_prot_mode),
				.silicon_rev( "20nm4" ),       //PARAM_HIDE
				.sup_mode(pma_adapt_sup_mode)
			) inst_twentynm_hssi_pma_adaptation (
				// OUTPUTS
				.avmmreaddata(w_pma_adapt_avmmreaddata),
				.blockselect(w_pma_adapt_blockselect),
				.ctle_acgain_4s(w_pma_adapt_ctle_acgain_4s),
				.ctle_eqz_1s_sel(w_pma_adapt_ctle_eqz_1s_sel),
				.ctle_lfeq_fb_sel(w_pma_adapt_ctle_lfeq_fb_sel),
				.dfe_adapt_en(w_pma_adapt_dfe_adapt_en),
				.dfe_adp_clk(w_pma_adapt_dfe_adp_clk),
				.dfe_fltap1(w_pma_adapt_dfe_fltap1),
				.dfe_fltap1_sgn(w_pma_adapt_dfe_fltap1_sgn),
				.dfe_fltap2(w_pma_adapt_dfe_fltap2),
				.dfe_fltap2_sgn(w_pma_adapt_dfe_fltap2_sgn),
				.dfe_fltap3(w_pma_adapt_dfe_fltap3),
				.dfe_fltap3_sgn(w_pma_adapt_dfe_fltap3_sgn),
				.dfe_fltap4(w_pma_adapt_dfe_fltap4),
				.dfe_fltap4_sgn(w_pma_adapt_dfe_fltap4_sgn),
				.dfe_fltap_bypdeser(w_pma_adapt_dfe_fltap_bypdeser),
				.dfe_fltap_position(w_pma_adapt_dfe_fltap_position),
				.dfe_fxtap1(w_pma_adapt_dfe_fxtap1),
				.dfe_fxtap2(w_pma_adapt_dfe_fxtap2),
				.dfe_fxtap2_sgn(w_pma_adapt_dfe_fxtap2_sgn),
				.dfe_fxtap3(w_pma_adapt_dfe_fxtap3),
				.dfe_fxtap3_sgn(w_pma_adapt_dfe_fxtap3_sgn),
				.dfe_fxtap4(w_pma_adapt_dfe_fxtap4),
				.dfe_fxtap4_sgn(w_pma_adapt_dfe_fxtap4_sgn),
				.dfe_fxtap5(w_pma_adapt_dfe_fxtap5),
				.dfe_fxtap5_sgn(w_pma_adapt_dfe_fxtap5_sgn),
				.dfe_fxtap6(w_pma_adapt_dfe_fxtap6),
				.dfe_fxtap6_sgn(w_pma_adapt_dfe_fxtap6_sgn),
				.dfe_fxtap7(w_pma_adapt_dfe_fxtap7),
				.dfe_fxtap7_sgn(w_pma_adapt_dfe_fxtap7_sgn),
				.dfe_spec_disable(w_pma_adapt_dfe_spec_disable),
				.dfe_spec_sign_sel(w_pma_adapt_dfe_spec_sign_sel),
				.dfe_vref_sign_sel(w_pma_adapt_dfe_vref_sign_sel),
				.odi_vref(w_pma_adapt_odi_vref),
				.vga_sel(w_pma_adapt_vga_sel),
				.vref_sel(w_pma_adapt_vref_sel),
				// INPUTS
				.adapt_reset(in_pma_reserved_out[4]),
				.adapt_start(in_adapt_start),
				.avmmaddress({in_avmmaddress[8], in_avmmaddress[7], in_avmmaddress[6], in_avmmaddress[5], in_avmmaddress[4], in_avmmaddress[3], in_avmmaddress[2], in_avmmaddress[1], in_avmmaddress[0]}),
				.avmmclk(in_avmmclk),
				.avmmread(in_avmmread),
				.avmmrstn(in_avmmrstn),
				.avmmwrite(in_avmmwrite),
				.avmmwritedata({in_avmmwritedata[7], in_avmmwritedata[6], in_avmmwritedata[5], in_avmmwritedata[4], in_avmmwritedata[3], in_avmmwritedata[2], in_avmmwritedata[1], in_avmmwritedata[0]}),
				.deser_clk(w_pma_rx_deser_adapt_clk),
				.deser_data({w_pma_rx_deser_data[63], w_pma_rx_deser_data[62], w_pma_rx_deser_data[61], w_pma_rx_deser_data[60], w_pma_rx_deser_data[59], w_pma_rx_deser_data[58], w_pma_rx_deser_data[57], w_pma_rx_deser_data[56], w_pma_rx_deser_data[55], w_pma_rx_deser_data[54], w_pma_rx_deser_data[53], w_pma_rx_deser_data[52], w_pma_rx_deser_data[51], w_pma_rx_deser_data[50], w_pma_rx_deser_data[49], w_pma_rx_deser_data[48], w_pma_rx_deser_data[47], w_pma_rx_deser_data[46], w_pma_rx_deser_data[45], w_pma_rx_deser_data[44], w_pma_rx_deser_data[43], w_pma_rx_deser_data[42], w_pma_rx_deser_data[41], w_pma_rx_deser_data[40], w_pma_rx_deser_data[39], w_pma_rx_deser_data[38], w_pma_rx_deser_data[37], w_pma_rx_deser_data[36], w_pma_rx_deser_data[35], w_pma_rx_deser_data[34], w_pma_rx_deser_data[33], w_pma_rx_deser_data[32], w_pma_rx_deser_data[31], w_pma_rx_deser_data[30], w_pma_rx_deser_data[29], w_pma_rx_deser_data[28], w_pma_rx_deser_data[27], w_pma_rx_deser_data[26], w_pma_rx_deser_data[25], w_pma_rx_deser_data[24], w_pma_rx_deser_data[23], w_pma_rx_deser_data[22], w_pma_rx_deser_data[21], w_pma_rx_deser_data[20], w_pma_rx_deser_data[19], w_pma_rx_deser_data[18], w_pma_rx_deser_data[17], w_pma_rx_deser_data[16], w_pma_rx_deser_data[15], w_pma_rx_deser_data[14], w_pma_rx_deser_data[13], w_pma_rx_deser_data[12], w_pma_rx_deser_data[11], w_pma_rx_deser_data[10], w_pma_rx_deser_data[9], w_pma_rx_deser_data[8], w_pma_rx_deser_data[7], w_pma_rx_deser_data[6], w_pma_rx_deser_data[5], w_pma_rx_deser_data[4], w_pma_rx_deser_data[3], w_pma_rx_deser_data[2], w_pma_rx_deser_data[1], w_pma_rx_deser_data[0]}),
				.deser_error({w_pma_rx_deser_error_deser[63], w_pma_rx_deser_error_deser[62], w_pma_rx_deser_error_deser[61], w_pma_rx_deser_error_deser[60], w_pma_rx_deser_error_deser[59], w_pma_rx_deser_error_deser[58], w_pma_rx_deser_error_deser[57], w_pma_rx_deser_error_deser[56], w_pma_rx_deser_error_deser[55], w_pma_rx_deser_error_deser[54], w_pma_rx_deser_error_deser[53], w_pma_rx_deser_error_deser[52], w_pma_rx_deser_error_deser[51], w_pma_rx_deser_error_deser[50], w_pma_rx_deser_error_deser[49], w_pma_rx_deser_error_deser[48], w_pma_rx_deser_error_deser[47], w_pma_rx_deser_error_deser[46], w_pma_rx_deser_error_deser[45], w_pma_rx_deser_error_deser[44], w_pma_rx_deser_error_deser[43], w_pma_rx_deser_error_deser[42], w_pma_rx_deser_error_deser[41], w_pma_rx_deser_error_deser[40], w_pma_rx_deser_error_deser[39], w_pma_rx_deser_error_deser[38], w_pma_rx_deser_error_deser[37], w_pma_rx_deser_error_deser[36], w_pma_rx_deser_error_deser[35], w_pma_rx_deser_error_deser[34], w_pma_rx_deser_error_deser[33], w_pma_rx_deser_error_deser[32], w_pma_rx_deser_error_deser[31], w_pma_rx_deser_error_deser[30], w_pma_rx_deser_error_deser[29], w_pma_rx_deser_error_deser[28], w_pma_rx_deser_error_deser[27], w_pma_rx_deser_error_deser[26], w_pma_rx_deser_error_deser[25], w_pma_rx_deser_error_deser[24], w_pma_rx_deser_error_deser[23], w_pma_rx_deser_error_deser[22], w_pma_rx_deser_error_deser[21], w_pma_rx_deser_error_deser[20], w_pma_rx_deser_error_deser[19], w_pma_rx_deser_error_deser[18], w_pma_rx_deser_error_deser[17], w_pma_rx_deser_error_deser[16], w_pma_rx_deser_error_deser[15], w_pma_rx_deser_error_deser[14], w_pma_rx_deser_error_deser[13], w_pma_rx_deser_error_deser[12], w_pma_rx_deser_error_deser[11], w_pma_rx_deser_error_deser[10], w_pma_rx_deser_error_deser[9], w_pma_rx_deser_error_deser[8], w_pma_rx_deser_error_deser[7], w_pma_rx_deser_error_deser[6], w_pma_rx_deser_error_deser[5], w_pma_rx_deser_error_deser[4], w_pma_rx_deser_error_deser[3], w_pma_rx_deser_error_deser[2], w_pma_rx_deser_error_deser[1], w_pma_rx_deser_error_deser[0]}),
				.deser_odi({w_pma_rx_deser_odi_dout[63], w_pma_rx_deser_odi_dout[62], w_pma_rx_deser_odi_dout[61], w_pma_rx_deser_odi_dout[60], w_pma_rx_deser_odi_dout[59], w_pma_rx_deser_odi_dout[58], w_pma_rx_deser_odi_dout[57], w_pma_rx_deser_odi_dout[56], w_pma_rx_deser_odi_dout[55], w_pma_rx_deser_odi_dout[54], w_pma_rx_deser_odi_dout[53], w_pma_rx_deser_odi_dout[52], w_pma_rx_deser_odi_dout[51], w_pma_rx_deser_odi_dout[50], w_pma_rx_deser_odi_dout[49], w_pma_rx_deser_odi_dout[48], w_pma_rx_deser_odi_dout[47], w_pma_rx_deser_odi_dout[46], w_pma_rx_deser_odi_dout[45], w_pma_rx_deser_odi_dout[44], w_pma_rx_deser_odi_dout[43], w_pma_rx_deser_odi_dout[42], w_pma_rx_deser_odi_dout[41], w_pma_rx_deser_odi_dout[40], w_pma_rx_deser_odi_dout[39], w_pma_rx_deser_odi_dout[38], w_pma_rx_deser_odi_dout[37], w_pma_rx_deser_odi_dout[36], w_pma_rx_deser_odi_dout[35], w_pma_rx_deser_odi_dout[34], w_pma_rx_deser_odi_dout[33], w_pma_rx_deser_odi_dout[32], w_pma_rx_deser_odi_dout[31], w_pma_rx_deser_odi_dout[30], w_pma_rx_deser_odi_dout[29], w_pma_rx_deser_odi_dout[28], w_pma_rx_deser_odi_dout[27], w_pma_rx_deser_odi_dout[26], w_pma_rx_deser_odi_dout[25], w_pma_rx_deser_odi_dout[24], w_pma_rx_deser_odi_dout[23], w_pma_rx_deser_odi_dout[22], w_pma_rx_deser_odi_dout[21], w_pma_rx_deser_odi_dout[20], w_pma_rx_deser_odi_dout[19], w_pma_rx_deser_odi_dout[18], w_pma_rx_deser_odi_dout[17], w_pma_rx_deser_odi_dout[16], w_pma_rx_deser_odi_dout[15], w_pma_rx_deser_odi_dout[14], w_pma_rx_deser_odi_dout[13], w_pma_rx_deser_odi_dout[12], w_pma_rx_deser_odi_dout[11], w_pma_rx_deser_odi_dout[10], w_pma_rx_deser_odi_dout[9], w_pma_rx_deser_odi_dout[8], w_pma_rx_deser_odi_dout[7], w_pma_rx_deser_odi_dout[6], w_pma_rx_deser_odi_dout[5], w_pma_rx_deser_odi_dout[4], w_pma_rx_deser_odi_dout[3], w_pma_rx_deser_odi_dout[2], w_pma_rx_deser_odi_dout[1], w_pma_rx_deser_odi_dout[0]}),
				.deser_odi_clk(1'b0),
				.global_pipe_se(in_pma_atpg_los_en_n_in),
				.i_rxpreset({in_i_rxpreset[2], in_i_rxpreset[1], in_i_rxpreset[0]}),
				.rx_pllfreqlock(w_cdr_pll_rxpll_lock),
				.scan_clk(in_core_refclk_in),
				.scan_in({in_pma_reserved_out[3], in_pma_reserved_out[2], in_pma_reserved_out[1], in_pma_reserved_out[0], in_eye_monitor[5], in_eye_monitor[4], in_eye_monitor[3], in_eye_monitor[2], in_eye_monitor[1], in_eye_monitor[0]}),
				.test_mode(in_scan_mode_n),
				.test_se(in_scan_shift_n),
				
				// UNUSED
				.radp_ctle_hold_en(),
				.radp_ctle_patt_en(),
				.radp_ctle_preset_sel(),
				.radp_enable_max_lfeq_scale(),
				.radp_lfeq_hold_en(),
				.radp_vga_polarity(),
				.scan_out(),
				.status_bus()
			);
		end // if generate
		else begin
				assign w_pma_adapt_avmmreaddata[7:0] = 8'b0;
				assign w_pma_adapt_blockselect = 1'b0;
				assign w_pma_adapt_ctle_acgain_4s[27:0] = 28'b0;
				assign w_pma_adapt_ctle_eqz_1s_sel[14:0] = 15'b0;
				assign w_pma_adapt_ctle_lfeq_fb_sel[6:0] = 7'b0;
				assign w_pma_adapt_dfe_adapt_en = 1'b0;
				assign w_pma_adapt_dfe_adp_clk = 1'b0;
				assign w_pma_adapt_dfe_fltap1[5:0] = 6'b0;
				assign w_pma_adapt_dfe_fltap1_sgn = 1'b0;
				assign w_pma_adapt_dfe_fltap2[5:0] = 6'b0;
				assign w_pma_adapt_dfe_fltap2_sgn = 1'b0;
				assign w_pma_adapt_dfe_fltap3[5:0] = 6'b0;
				assign w_pma_adapt_dfe_fltap3_sgn = 1'b0;
				assign w_pma_adapt_dfe_fltap4[5:0] = 6'b0;
				assign w_pma_adapt_dfe_fltap4_sgn = 1'b0;
				assign w_pma_adapt_dfe_fltap_bypdeser = 1'b0;
				assign w_pma_adapt_dfe_fltap_position[5:0] = 6'b0;
				assign w_pma_adapt_dfe_fxtap1[6:0] = 7'b0;
				assign w_pma_adapt_dfe_fxtap2[6:0] = 7'b0;
				assign w_pma_adapt_dfe_fxtap2_sgn = 1'b0;
				assign w_pma_adapt_dfe_fxtap3[6:0] = 7'b0;
				assign w_pma_adapt_dfe_fxtap3_sgn = 1'b0;
				assign w_pma_adapt_dfe_fxtap4[5:0] = 6'b0;
				assign w_pma_adapt_dfe_fxtap4_sgn = 1'b0;
				assign w_pma_adapt_dfe_fxtap5[5:0] = 6'b0;
				assign w_pma_adapt_dfe_fxtap5_sgn = 1'b0;
				assign w_pma_adapt_dfe_fxtap6[4:0] = 5'b0;
				assign w_pma_adapt_dfe_fxtap6_sgn = 1'b0;
				assign w_pma_adapt_dfe_fxtap7[4:0] = 5'b0;
				assign w_pma_adapt_dfe_fxtap7_sgn = 1'b0;
				assign w_pma_adapt_dfe_spec_disable = 1'b0;
				assign w_pma_adapt_dfe_spec_sign_sel = 1'b0;
				assign w_pma_adapt_dfe_vref_sign_sel = 1'b0;
				assign w_pma_adapt_odi_vref[4:0] = 5'b0;
				assign w_pma_adapt_vga_sel[6:0] = 7'b0;
				assign w_pma_adapt_vref_sel[4:0] = 5'b0;
		end // if not generate
		
		// instantiating twentynm_hssi_pma_cdr_refclk_select_mux
		if ((xcvr_native_mode == "mode_rx_only") || (xcvr_native_mode == "mode_duplex")) begin:gen_twentynm_hssi_pma_cdr_refclk_select_mux
			twentynm_hssi_pma_cdr_refclk_select_mux #(
				.inclk0_logical_to_physical_mapping(pma_cdr_refclk_inclk0_logical_to_physical_mapping),
				.inclk1_logical_to_physical_mapping(pma_cdr_refclk_inclk1_logical_to_physical_mapping),
				.inclk2_logical_to_physical_mapping(pma_cdr_refclk_inclk2_logical_to_physical_mapping),
				.inclk3_logical_to_physical_mapping(pma_cdr_refclk_inclk3_logical_to_physical_mapping),
				.inclk4_logical_to_physical_mapping(pma_cdr_refclk_inclk4_logical_to_physical_mapping),
				.powerdown_mode(pma_cdr_refclk_powerdown_mode),
				.refclk_select(pma_cdr_refclk_refclk_select),
				.silicon_rev( "20nm4" )       //PARAM_HIDE
			) inst_twentynm_hssi_pma_cdr_refclk_select_mux (
				// OUTPUTS
				.avmmreaddata(w_pma_cdr_refclk_avmmreaddata),
				.blockselect(w_pma_cdr_refclk_blockselect),
				.refclk(w_pma_cdr_refclk_refclk),
				.rx_det_clk(w_pma_cdr_refclk_rx_det_clk),
				// INPUTS
				.avmmaddress({in_avmmaddress[8], in_avmmaddress[7], in_avmmaddress[6], in_avmmaddress[5], in_avmmaddress[4], in_avmmaddress[3], in_avmmaddress[2], in_avmmaddress[1], in_avmmaddress[0]}),
				.avmmclk(in_avmmclk),
				.avmmread(in_avmmread),
				.avmmrstn(in_avmmrstn),
				.avmmwrite(in_avmmwrite),
				.avmmwritedata({in_avmmwritedata[7], in_avmmwritedata[6], in_avmmwritedata[5], in_avmmwritedata[4], in_avmmwritedata[3], in_avmmwritedata[2], in_avmmwritedata[1], in_avmmwritedata[0]}),
				.core_refclk(in_core_refclk_in),
				.iqtxrxclk({in_iqtxrxclk[5], in_iqtxrxclk[4], in_iqtxrxclk[3], in_iqtxrxclk[2], in_iqtxrxclk[1], in_iqtxrxclk[0]}),
				.ref_iqclk({in_ref_iqclk[11], in_ref_iqclk[10], in_ref_iqclk[9], in_ref_iqclk[8], in_ref_iqclk[7], in_ref_iqclk[6], in_ref_iqclk[5], in_ref_iqclk[4], in_ref_iqclk[3], in_ref_iqclk[2], in_ref_iqclk[1], in_ref_iqclk[0]})
			);
		end // if generate
		else begin
				assign w_pma_cdr_refclk_avmmreaddata[7:0] = 8'b0;
				assign w_pma_cdr_refclk_blockselect = 1'b0;
				assign w_pma_cdr_refclk_refclk = 1'b0;
				assign w_pma_cdr_refclk_rx_det_clk = 1'b0;
		end // if not generate
		
		// instantiating twentynm_hssi_pma_channel_pll
		if ((xcvr_native_mode == "mode_rx_only") || (xcvr_native_mode == "mode_duplex")) begin:gen_twentynm_hssi_pma_channel_pll
			twentynm_hssi_pma_channel_pll #(
				.atb_select_control(cdr_pll_atb_select_control),
				.auto_reset_on(cdr_pll_auto_reset_on),
				.bbpd_data_pattern_filter_select(cdr_pll_bbpd_data_pattern_filter_select),
				.bw_sel(cdr_pll_bw_sel),
				.cal_vco_count_length(cdr_pll_cal_vco_count_length),
				.cdr_odi_select(cdr_pll_cdr_odi_select),
				.cdr_phaselock_mode(cdr_pll_cdr_phaselock_mode),
				.cdr_powerdown_mode(cdr_pll_cdr_powerdown_mode),
				.cgb_div(cdr_pll_cgb_div),
				.chgpmp_current_dn_pd(cdr_pll_chgpmp_current_dn_pd),
				.chgpmp_current_dn_trim(cdr_pll_chgpmp_current_dn_trim),
				.chgpmp_current_pd(cdr_pll_chgpmp_current_pd),
				.chgpmp_current_pfd(cdr_pll_chgpmp_current_pfd),
				.chgpmp_current_up_pd(cdr_pll_chgpmp_current_up_pd),
				.chgpmp_current_up_trim(cdr_pll_chgpmp_current_up_trim),
				.chgpmp_dn_pd_trim_double(cdr_pll_chgpmp_dn_pd_trim_double),
				.chgpmp_replicate(cdr_pll_chgpmp_replicate),
				.chgpmp_testmode(cdr_pll_chgpmp_testmode),
				.chgpmp_up_pd_trim_double(cdr_pll_chgpmp_up_pd_trim_double),
				.clklow_mux_select(cdr_pll_clklow_mux_select),
				.datarate(cdr_pll_datarate),
				.diag_loopback_enable(cdr_pll_diag_loopback_enable),
				.disable_up_dn(cdr_pll_disable_up_dn),
				.fb_select(cdr_pll_fb_select),
				.fref_clklow_div(cdr_pll_fref_clklow_div),
				.fref_mux_select(cdr_pll_fref_mux_select),
				.gpon_lck2ref_control(cdr_pll_gpon_lck2ref_control),
				.initial_settings(cdr_pll_initial_settings),
				.iqclk_mux_sel(cdr_pll_iqclk_mux_sel),
				.is_cascaded_pll(cdr_pll_is_cascaded_pll),
				.lck2ref_delay_control(cdr_pll_lck2ref_delay_control),
				.lf_resistor_pd(cdr_pll_lf_resistor_pd),
				.lf_resistor_pfd(cdr_pll_lf_resistor_pfd),
				.lf_ripple_cap(cdr_pll_lf_ripple_cap),
				.loop_filter_bias_select(cdr_pll_loop_filter_bias_select),
				.loopback_mode(cdr_pll_loopback_mode),
				.lpd_counter(cdr_pll_lpd_counter),
				.lpfd_counter(cdr_pll_lpfd_counter),
				.ltd_ltr_micro_controller_select(cdr_pll_ltd_ltr_micro_controller_select),
				.m_counter(cdr_pll_m_counter),
				.n_counter(cdr_pll_n_counter),
				.n_counter_scratch(cdr_pll_n_counter_scratch),
				.optimal("false"),       //PARAM_HIDE
				.output_clock_frequency(cdr_pll_output_clock_frequency),
				.pcie_gen(cdr_pll_pcie_gen),
				.pd_fastlock_mode(cdr_pll_pd_fastlock_mode),
				.pd_l_counter(cdr_pll_pd_l_counter),
				.pfd_l_counter(cdr_pll_pfd_l_counter),
				.pma_width(cdr_pll_pma_width),
				.primary_use(cdr_pll_primary_use),
				.prot_mode(cdr_pll_prot_mode),
				.reference_clock_frequency(cdr_pll_reference_clock_frequency),
				.reverse_serial_loopback(cdr_pll_reverse_serial_loopback),
				.set_cdr_input_freq_range(cdr_pll_set_cdr_input_freq_range),
				.set_cdr_v2i_enable(cdr_pll_set_cdr_v2i_enable),
				.set_cdr_vco_reset(cdr_pll_set_cdr_vco_reset),
				.set_cdr_vco_speed(cdr_pll_set_cdr_vco_speed),
				.set_cdr_vco_speed_fix(cdr_pll_set_cdr_vco_speed_fix),
				.set_cdr_vco_speed_pciegen3(cdr_pll_set_cdr_vco_speed_pciegen3),
				.silicon_rev( "20nm4" ),       //PARAM_HIDE
				.sup_mode(cdr_pll_sup_mode),
				.tx_pll_prot_mode(cdr_pll_tx_pll_prot_mode),
				.txpll_hclk_driver_enable(cdr_pll_txpll_hclk_driver_enable),
				.uc_ro_cal(cdr_pll_uc_ro_cal),
				.vco_freq(cdr_pll_vco_freq),
				.vco_overrange_voltage(cdr_pll_vco_overrange_voltage),
				.vco_underrange_voltage(cdr_pll_vco_underrange_voltage)
			) inst_twentynm_hssi_pma_channel_pll (
				// OUTPUTS
				.avmmreaddata(w_cdr_pll_avmmreaddata),
				.blockselect(w_cdr_pll_blockselect),
				.cdr_cnt_done(w_cdr_pll_cdr_cnt_done),
				.cdr_refclk_cal_out(w_cdr_pll_cdr_refclk_cal_out),
				.cdr_vco_cal_out(w_cdr_pll_cdr_vco_cal_out),
				.clk0_des(w_cdr_pll_clk0_des),
				.clk0_odi(w_cdr_pll_clk0_odi),
				.clk0_pd(w_cdr_pll_clk0_pd),
				.clk0_pfd(w_cdr_pll_clk0_pfd),
				.clk180_des(w_cdr_pll_clk180_des),
				.clk180_odi(w_cdr_pll_clk180_odi),
				.clk180_pd(w_cdr_pll_clk180_pd),
				.clk180_pfd(w_cdr_pll_clk180_pfd),
				.clk270_odi(w_cdr_pll_clk270_odi),
				.clk270_pd(w_cdr_pll_clk270_pd),
				.clk90_odi(w_cdr_pll_clk90_odi),
				.clk90_pd(w_cdr_pll_clk90_pd),
				.clklow(w_cdr_pll_clklow),
				.deven_des(w_cdr_pll_deven_des),
				.devenb_des(w_cdr_pll_devenb_des),
				.dodd_des(w_cdr_pll_dodd_des),
				.doddb_des(w_cdr_pll_doddb_des),
				.error_even_des(w_cdr_pll_error_even_des),
				.error_evenb_des(w_cdr_pll_error_evenb_des),
				.error_odd_des(w_cdr_pll_error_odd_des),
				.error_oddb_des(w_cdr_pll_error_oddb_des),
				.fref(w_cdr_pll_fref),
				.overrange(w_cdr_pll_overrange),
				.pfdmode_lock(w_cdr_pll_pfdmode_lock),
				.rlpbkdn(w_cdr_pll_rlpbkdn),
				.rlpbkdp(w_cdr_pll_rlpbkdp),
				.rlpbkn(w_cdr_pll_rlpbkn),
				.rlpbkp(w_cdr_pll_rlpbkp),
				.rxpll_lock(w_cdr_pll_rxpll_lock),
				.tx_rlpbk(w_cdr_pll_tx_rlpbk),
				.underrange(w_cdr_pll_underrange),
				// INPUTS
				.adapt_en(w_pma_adapt_dfe_adapt_en),
				.avmmaddress({in_avmmaddress[8], in_avmmaddress[7], in_avmmaddress[6], in_avmmaddress[5], in_avmmaddress[4], in_avmmaddress[3], in_avmmaddress[2], in_avmmaddress[1], in_avmmaddress[0]}),
				.avmmclk(in_avmmclk),
				.avmmread(in_avmmread),
				.avmmrstn(in_avmmrstn),
				.avmmwrite(in_avmmwrite),
				.avmmwritedata({in_avmmwritedata[7], in_avmmwritedata[6], in_avmmwritedata[5], in_avmmwritedata[4], in_avmmwritedata[3], in_avmmwritedata[2], in_avmmwritedata[1], in_avmmwritedata[0]}),
				.clk0_bbpd(w_pma_rx_dfe_clk0_bbpd),
				.clk180_bbpd(w_pma_rx_dfe_clk180_bbpd),
				.clk270_bbpd(w_pma_rx_dfe_clk270_bbpd),
				.clk90_bbpd(w_pma_rx_dfe_clk90_bbpd),
				.deven(w_pma_rx_dfe_deven),
				.devenb(w_pma_rx_dfe_devenb),
				.dfe_test(1'b0),
				.dodd(w_pma_rx_dfe_dodd),
				.doddb(w_pma_rx_dfe_doddb),
				.e270(w_pma_rx_dfe_edge270),
				.e270b(w_pma_rx_dfe_edge270b),
				.e90(w_pma_rx_dfe_edge90),
				.e90b(w_pma_rx_dfe_edge90b),
				.early_eios(in_early_eios),
				.error_even(w_pma_rx_dfe_err_ev),
				.error_evenb(w_pma_rx_dfe_err_evb),
				.error_odd(w_pma_rx_dfe_err_od),
				.error_oddb(w_pma_rx_dfe_err_odb),
				.fpll_test0(in_fpll_ppm_clk_in[0]),
				.fpll_test1(in_fpll_ppm_clk_in[1]),
				.iqtxrxclk({in_iqtxrxclk[5], in_iqtxrxclk[4], in_iqtxrxclk[3], in_iqtxrxclk[2], in_iqtxrxclk[1], in_iqtxrxclk[0]}),
				.ltd_b(in_ltd_b),
				.ltr(in_ltr),
				.odi_clk(w_pma_rx_odi_clk0_eye_lb),
				.odi_clkb(w_pma_rx_odi_clk180_eye_lb),
				.pcie_sw_ret({w_pma_rx_deser_pcie_sw_ret[1], w_pma_rx_deser_pcie_sw_ret[0]}),
				.ppm_lock(in_ppm_lock),
				.refclk(w_pma_cdr_refclk_refclk),
				.rst_n(in_rx_pma_rstb),
				.rx_deser_pclk_test(w_pma_rx_deser_clkdivrx_rx),
				.rx_lpbkn(w_pma_rx_buf_rdlpbkn),
				.rx_lpbkp(w_pma_rx_buf_rdlpbkp),
				.rxp(in_rx_p),
				.sd(w_pma_rx_sd_sd),
				.tx_ser_pclk_test(w_pma_tx_ser_clk_divtx),
				
				// UNUSED
				.atbsel(),
				.cdr_lpbkdp(),
				.cdr_lpbkp(),
				.clk270_des(),
				.clk90_des(),
				.lock2ref(),
				.rx_signal_ok(),
				.von_lp(),
				.vop_lp()
			);
		end // if generate
		else begin
				assign w_cdr_pll_avmmreaddata[7:0] = 8'b0;
				assign w_cdr_pll_blockselect = 1'b0;
				assign w_cdr_pll_cdr_cnt_done = 1'b0;
				assign w_cdr_pll_cdr_refclk_cal_out[11:0] = 12'b0;
				assign w_cdr_pll_cdr_vco_cal_out[11:0] = 12'b0;
				assign w_cdr_pll_clk0_des = 1'b0;
				assign w_cdr_pll_clk0_odi = 1'b0;
				assign w_cdr_pll_clk0_pd = 1'b0;
				assign w_cdr_pll_clk0_pfd = 1'b0;
				assign w_cdr_pll_clk180_des = 1'b0;
				assign w_cdr_pll_clk180_odi = 1'b0;
				assign w_cdr_pll_clk180_pd = 1'b0;
				assign w_cdr_pll_clk180_pfd = 1'b0;
				assign w_cdr_pll_clk270_odi = 1'b0;
				assign w_cdr_pll_clk270_pd = 1'b0;
				assign w_cdr_pll_clk90_odi = 1'b0;
				assign w_cdr_pll_clk90_pd = 1'b0;
				assign w_cdr_pll_clklow = 1'b0;
				assign w_cdr_pll_deven_des = 1'b0;
				assign w_cdr_pll_devenb_des = 1'b0;
				assign w_cdr_pll_dodd_des = 1'b0;
				assign w_cdr_pll_doddb_des = 1'b0;
				assign w_cdr_pll_error_even_des = 1'b0;
				assign w_cdr_pll_error_evenb_des = 1'b0;
				assign w_cdr_pll_error_odd_des = 1'b0;
				assign w_cdr_pll_error_oddb_des = 1'b0;
				assign w_cdr_pll_fref = 1'b0;
				assign w_cdr_pll_overrange = 1'b0;
				assign w_cdr_pll_pfdmode_lock = 1'b0;
				assign w_cdr_pll_rlpbkdn = 1'b0;
				assign w_cdr_pll_rlpbkdp = 1'b0;
				assign w_cdr_pll_rlpbkn = 1'b0;
				assign w_cdr_pll_rlpbkp = 1'b0;
				assign w_cdr_pll_rxpll_lock = 1'b0;
				assign w_cdr_pll_tx_rlpbk = 1'b0;
				assign w_cdr_pll_underrange = 1'b0;
		end // if not generate
		
		// instantiating twentynm_hssi_pma_rx_buf
		if ((xcvr_native_mode == "mode_rx_only") || (xcvr_native_mode == "mode_duplex")) begin:gen_twentynm_hssi_pma_rx_buf
			twentynm_hssi_pma_rx_buf #(
				.bypass_eqz_stages_234(pma_rx_buf_bypass_eqz_stages_234),
				.datarate(pma_rx_buf_datarate),
				.diag_lp_en(pma_rx_buf_diag_lp_en),
				.initial_settings("true"),       //PARAM_HIDE
				.loopback_modes(pma_rx_buf_loopback_modes),
				.optimal("false"),       //PARAM_HIDE
				.pdb_rx("normal_rx_on"),       //PARAM_HIDE
				.pm_tx_rx_cvp_mode(pma_rx_buf_pm_tx_rx_cvp_mode),
				.pm_tx_rx_pcie_gen(pma_rx_buf_pm_tx_rx_pcie_gen),
				.pm_tx_rx_pcie_gen_bitwidth(pma_rx_buf_pm_tx_rx_pcie_gen_bitwidth),
				.prot_mode(pma_rx_buf_prot_mode),
				.qpi_enable(pma_rx_buf_qpi_enable),
				.refclk_en(pma_rx_buf_refclk_en),
				.rx_refclk_divider(pma_rx_buf_rx_refclk_divider),
				.silicon_rev( "20nm4" ),       //PARAM_HIDE
				.sup_mode(pma_rx_buf_sup_mode),
				.xrx_path_datarate(pma_rx_buf_xrx_path_datarate),
				.xrx_path_datawidth(pma_rx_buf_xrx_path_datawidth),
				.xrx_path_initial_settings("true"),       //PARAM_HIDE
				.xrx_path_optimal("false"),       //PARAM_HIDE
				.xrx_path_pma_rx_divclk_hz(pma_rx_buf_xrx_path_pma_rx_divclk_hz),
				.xrx_path_prot_mode(pma_rx_buf_xrx_path_prot_mode),
				.xrx_path_sup_mode(pma_rx_buf_xrx_path_sup_mode),
				.xrx_path_uc_cal_enable(pma_rx_buf_xrx_path_uc_cal_enable)
			) inst_twentynm_hssi_pma_rx_buf (
				// OUTPUTS
				.avmmreaddata(w_pma_rx_buf_avmmreaddata),
				.blockselect(w_pma_rx_buf_blockselect),
				.inn(w_pma_rx_buf_inn),
				.inp(w_pma_rx_buf_inp),
				.outn(w_pma_rx_buf_outn),
				.outp(w_pma_rx_buf_outp),
				.pull_dn(w_pma_rx_buf_pull_dn),
				.rdlpbkn(w_pma_rx_buf_rdlpbkn),
				.rdlpbkp(w_pma_rx_buf_rdlpbkp),
				// INPUTS
				.avmmaddress({in_avmmaddress[8], in_avmmaddress[7], in_avmmaddress[6], in_avmmaddress[5], in_avmmaddress[4], in_avmmaddress[3], in_avmmaddress[2], in_avmmaddress[1], in_avmmaddress[0]}),
				.avmmclk(in_avmmclk),
				.avmmread(in_avmmread),
				.avmmrstn(in_avmmrstn),
				.avmmwrite(in_avmmwrite),
				.avmmwritedata({in_avmmwritedata[7], in_avmmwritedata[6], in_avmmwritedata[5], in_avmmwritedata[4], in_avmmwritedata[3], in_avmmwritedata[2], in_avmmwritedata[1], in_avmmwritedata[0]}),
				.clk_divrx(w_pma_rx_deser_clkdivrx_rx),
				.lpbkn(w_pma_tx_buf_lbvon),
				.lpbkp(w_pma_tx_buf_lbvop),
				.rx_qpi_pulldn(in_rx_qpi_pulldn),
				.rx_rstn(in_rx_pma_rstb),
				.rx_sel_b50({in_rx50_buf_in[5], in_rx50_buf_in[4], in_rx50_buf_in[3], in_rx50_buf_in[2], in_rx50_buf_in[1], in_rx50_buf_in[0]}),
				.rxn(in_rx_n),
				.rxp(in_rx_p),
				.s_lpbk_b(in_rs_lpbk_b),
				.vcz({w_pma_adapt_ctle_acgain_4s[27], w_pma_adapt_ctle_acgain_4s[26], w_pma_adapt_ctle_acgain_4s[25], w_pma_adapt_ctle_acgain_4s[24], w_pma_adapt_ctle_acgain_4s[23], w_pma_adapt_ctle_acgain_4s[22], w_pma_adapt_ctle_acgain_4s[21], w_pma_adapt_ctle_acgain_4s[20], w_pma_adapt_ctle_acgain_4s[19], w_pma_adapt_ctle_acgain_4s[18], w_pma_adapt_ctle_acgain_4s[17], w_pma_adapt_ctle_acgain_4s[16], w_pma_adapt_ctle_acgain_4s[15], w_pma_adapt_ctle_acgain_4s[14], w_pma_adapt_ctle_acgain_4s[13], w_pma_adapt_ctle_acgain_4s[12], w_pma_adapt_ctle_acgain_4s[11], w_pma_adapt_ctle_acgain_4s[10], w_pma_adapt_ctle_acgain_4s[9], w_pma_adapt_ctle_acgain_4s[8], w_pma_adapt_ctle_acgain_4s[7], w_pma_adapt_ctle_acgain_4s[6], w_pma_adapt_ctle_acgain_4s[5], w_pma_adapt_ctle_acgain_4s[4], w_pma_adapt_ctle_acgain_4s[3], w_pma_adapt_ctle_acgain_4s[2], w_pma_adapt_ctle_acgain_4s[1], w_pma_adapt_ctle_acgain_4s[0]}),
				.vds_eqz_s1_set({w_pma_adapt_ctle_eqz_1s_sel[14], w_pma_adapt_ctle_eqz_1s_sel[13], w_pma_adapt_ctle_eqz_1s_sel[12], w_pma_adapt_ctle_eqz_1s_sel[11], w_pma_adapt_ctle_eqz_1s_sel[10], w_pma_adapt_ctle_eqz_1s_sel[9], w_pma_adapt_ctle_eqz_1s_sel[8], w_pma_adapt_ctle_eqz_1s_sel[7], w_pma_adapt_ctle_eqz_1s_sel[6], w_pma_adapt_ctle_eqz_1s_sel[5], w_pma_adapt_ctle_eqz_1s_sel[4], w_pma_adapt_ctle_eqz_1s_sel[3], w_pma_adapt_ctle_eqz_1s_sel[2], w_pma_adapt_ctle_eqz_1s_sel[1], w_pma_adapt_ctle_eqz_1s_sel[0]}),
				.vds_lfeqz_czero({1'b0, 1'b0}),
				.vds_lfeqz_fb_set({w_pma_adapt_ctle_lfeq_fb_sel[6], w_pma_adapt_ctle_lfeq_fb_sel[5], w_pma_adapt_ctle_lfeq_fb_sel[4], w_pma_adapt_ctle_lfeq_fb_sel[3], w_pma_adapt_ctle_lfeq_fb_sel[2], w_pma_adapt_ctle_lfeq_fb_sel[1], w_pma_adapt_ctle_lfeq_fb_sel[0]}),
				.vds_vga_set({w_pma_adapt_vga_sel[6], w_pma_adapt_vga_sel[5], w_pma_adapt_vga_sel[4], w_pma_adapt_vga_sel[3], w_pma_adapt_vga_sel[2], w_pma_adapt_vga_sel[1], w_pma_adapt_vga_sel[0]}),
				
				// UNUSED
				.rx_refclk(),
				.vga_cm_bidir_in(),
				.vga_cm_bidir_out()
			);
		end // if generate
		else begin
				assign w_pma_rx_buf_avmmreaddata[7:0] = 8'b0;
				assign w_pma_rx_buf_blockselect = 1'b0;
				assign w_pma_rx_buf_inn = 1'b0;
				assign w_pma_rx_buf_inp = 1'b0;
				assign w_pma_rx_buf_outn = 1'b0;
				assign w_pma_rx_buf_outp = 1'b0;
				assign w_pma_rx_buf_pull_dn = 1'b0;
				assign w_pma_rx_buf_rdlpbkn = 1'b0;
				assign w_pma_rx_buf_rdlpbkp = 1'b0;
		end // if not generate
		
		// instantiating twentynm_hssi_pma_rx_deser
		if ((xcvr_native_mode == "mode_rx_only") || (xcvr_native_mode == "mode_duplex")) begin:gen_twentynm_hssi_pma_rx_deser
			twentynm_hssi_pma_rx_deser #(
				.bitslip_bypass(pma_rx_deser_bitslip_bypass),
				.clkdiv_source(pma_rx_deser_clkdiv_source),
				.clkdivrx_user_mode(pma_rx_deser_clkdivrx_user_mode),
				.datarate(pma_rx_deser_datarate),
				.deser_factor(pma_rx_deser_deser_factor),
				.deser_powerdown("deser_power_up"),       //PARAM_HIDE
				.force_clkdiv_for_testing(pma_rx_deser_force_clkdiv_for_testing),
				.optimal("false"),       //PARAM_HIDE
				.pcie_gen(pma_rx_deser_pcie_gen),
				.pcie_gen_bitwidth(pma_rx_deser_pcie_gen_bitwidth),
				.prot_mode(pma_rx_deser_prot_mode),
				.rst_n_adapt_odi(pma_rx_deser_rst_n_adapt_odi),
				.sdclk_enable(pma_rx_deser_sdclk_enable),
				.silicon_rev( "20nm4" ),       //PARAM_HIDE
				.sup_mode(pma_rx_deser_sup_mode),
				.tdr_mode("select_bbpd_data")       //PARAM_HIDE
			) inst_twentynm_hssi_pma_rx_deser (
				// OUTPUTS
				.adapt_clk(w_pma_rx_deser_adapt_clk),
				.avmmreaddata(w_pma_rx_deser_avmmreaddata),
				.blockselect(w_pma_rx_deser_blockselect),
				.clkdiv(w_pma_rx_deser_clkdiv),
				.clkdiv_user(w_pma_rx_deser_clkdiv_user),
				.clkdivrx_rx(w_pma_rx_deser_clkdivrx_rx),
				.data(w_pma_rx_deser_data),
				.dout(w_pma_rx_deser_dout),
				.error_deser(w_pma_rx_deser_error_deser),
				.odi_dout(w_pma_rx_deser_odi_dout),
				.pcie_sw_ret(w_pma_rx_deser_pcie_sw_ret),
				.tstmx_deser(w_pma_rx_deser_tstmx_deser),
				// INPUTS
				.adapt_en(w_pma_adapt_odi_vref[0]),
				.avmmaddress({in_avmmaddress[8], in_avmmaddress[7], in_avmmaddress[6], in_avmmaddress[5], in_avmmaddress[4], in_avmmaddress[3], in_avmmaddress[2], in_avmmaddress[1], in_avmmaddress[0]}),
				.avmmclk(in_avmmclk),
				.avmmread(in_avmmread),
				.avmmrstn(in_avmmrstn),
				.avmmwrite(in_avmmwrite),
				.avmmwritedata({in_avmmwritedata[7], in_avmmwritedata[6], in_avmmwritedata[5], in_avmmwritedata[4], in_avmmwritedata[3], in_avmmwritedata[2], in_avmmwritedata[1], in_avmmwritedata[0]}),
				.bitslip(in_rx_bitslip),
				.clk0(w_cdr_pll_clk0_des),
				.clk0_odi(w_pma_rx_odi_clk0_eye),
				.clk180(w_cdr_pll_clk180_des),
				.clk180_odi(w_pma_rx_odi_clk180_eye),
				.clklow(w_cdr_pll_clklow),
				.deven(w_cdr_pll_deven_des),
				.deven_odi(w_pma_rx_odi_de_eye),
				.devenb(w_cdr_pll_devenb_des),
				.devenb_odi(w_pma_rx_odi_deb_eye),
				.dodd(w_cdr_pll_dodd_des),
				.dodd_odi(w_pma_rx_odi_do_eye),
				.doddb(w_cdr_pll_doddb_des),
				.doddb_odi(w_pma_rx_odi_dob_eye),
				.error_even(w_cdr_pll_error_even_des),
				.error_evenb(w_cdr_pll_error_evenb_des),
				.error_odd(w_cdr_pll_error_odd_des),
				.error_oddb(w_cdr_pll_error_oddb_des),
				.fref(w_cdr_pll_fref),
				.odi_en(w_pma_rx_odi_odi_en),
				.pcie_sw({in_pcie_sw[1], in_pcie_sw[0]}),
				.pfdmode_lock(w_cdr_pll_pfdmode_lock),
				.rst_n(in_rx_pma_rstb),
				
				// UNUSED
				.clk270(),
				.clk90(),
				.odi_clkout(),
				.tdr_en()
			);
		end // if generate
		else begin
				assign w_pma_rx_deser_adapt_clk = 1'b0;
				assign w_pma_rx_deser_avmmreaddata[7:0] = 8'b0;
				assign w_pma_rx_deser_blockselect = 1'b0;
				assign w_pma_rx_deser_clkdiv = 1'b0;
				assign w_pma_rx_deser_clkdiv_user = 1'b0;
				assign w_pma_rx_deser_clkdivrx_rx = 1'b0;
				assign w_pma_rx_deser_data[63:0] = 64'b0;
				assign w_pma_rx_deser_dout[63:0] = 64'b0;
				assign w_pma_rx_deser_error_deser[63:0] = 64'b0;
				assign w_pma_rx_deser_odi_dout[63:0] = 64'b0;
				assign w_pma_rx_deser_pcie_sw_ret[1:0] = 2'b0;
				assign w_pma_rx_deser_tstmx_deser[7:0] = 8'b0;
		end // if not generate
		
		// instantiating twentynm_hssi_pma_rx_dfe
		if ((xcvr_native_mode == "mode_rx_only") || (xcvr_native_mode == "mode_duplex")) begin:gen_twentynm_hssi_pma_rx_dfe
			twentynm_hssi_pma_rx_dfe #(
				.datarate(pma_rx_dfe_datarate),
				.dft_en(pma_rx_dfe_dft_en),
				.initial_settings("true"),       //PARAM_HIDE
				.optimal("false"),       //PARAM_HIDE
				.pdb(pma_rx_dfe_pdb),
				.pdb_fixedtap(pma_rx_dfe_pdb_fixedtap),
				.pdb_floattap(pma_rx_dfe_pdb_floattap),
				.pdb_fxtap4t7(pma_rx_dfe_pdb_fxtap4t7),
				.prot_mode(pma_rx_dfe_prot_mode),
				.silicon_rev( "20nm4" ),       //PARAM_HIDE
				.sup_mode(pma_rx_dfe_sup_mode)
			) inst_twentynm_hssi_pma_rx_dfe (
				// OUTPUTS
				.avmmreaddata(w_pma_rx_dfe_avmmreaddata),
				.blockselect(w_pma_rx_dfe_blockselect),
				.clk0_bbpd(w_pma_rx_dfe_clk0_bbpd),
				.clk180_bbpd(w_pma_rx_dfe_clk180_bbpd),
				.clk270_bbpd(w_pma_rx_dfe_clk270_bbpd),
				.clk90_bbpd(w_pma_rx_dfe_clk90_bbpd),
				.deven(w_pma_rx_dfe_deven),
				.devenb(w_pma_rx_dfe_devenb),
				.dfe_oc_tstmx(w_pma_rx_dfe_dfe_oc_tstmx),
				.dodd(w_pma_rx_dfe_dodd),
				.doddb(w_pma_rx_dfe_doddb),
				.edge270(w_pma_rx_dfe_edge270),
				.edge270b(w_pma_rx_dfe_edge270b),
				.edge90(w_pma_rx_dfe_edge90),
				.edge90b(w_pma_rx_dfe_edge90b),
				.err_ev(w_pma_rx_dfe_err_ev),
				.err_evb(w_pma_rx_dfe_err_evb),
				.err_od(w_pma_rx_dfe_err_od),
				.err_odb(w_pma_rx_dfe_err_odb),
				.spec_vrefh(w_pma_rx_dfe_spec_vrefh),
				.spec_vrefl(w_pma_rx_dfe_spec_vrefl),
				// INPUTS
				.adapt_en(w_pma_adapt_dfe_adapt_en),
				.adp_clk(w_pma_adapt_dfe_adp_clk),
				.avmmaddress({in_avmmaddress[8], in_avmmaddress[7], in_avmmaddress[6], in_avmmaddress[5], in_avmmaddress[4], in_avmmaddress[3], in_avmmaddress[2], in_avmmaddress[1], in_avmmaddress[0]}),
				.avmmclk(in_avmmclk),
				.avmmread(in_avmmread),
				.avmmrstn(in_avmmrstn),
				.avmmwrite(in_avmmwrite),
				.avmmwritedata({in_avmmwritedata[7], in_avmmwritedata[6], in_avmmwritedata[5], in_avmmwritedata[4], in_avmmwritedata[3], in_avmmwritedata[2], in_avmmwritedata[1], in_avmmwritedata[0]}),
				.clk0(w_cdr_pll_clk0_pd),
				.clk180(w_cdr_pll_clk180_pd),
				.clk270(w_cdr_pll_clk270_pd),
				.clk90(w_cdr_pll_clk90_pd),
				.dfe_fltap1_coeff({w_pma_adapt_dfe_fltap1[5], w_pma_adapt_dfe_fltap1[4], w_pma_adapt_dfe_fltap1[3], w_pma_adapt_dfe_fltap1[2], w_pma_adapt_dfe_fltap1[1], w_pma_adapt_dfe_fltap1[0]}),
				.dfe_fltap1_sgn(w_pma_adapt_dfe_fltap1_sgn),
				.dfe_fltap2_coeff({w_pma_adapt_dfe_fltap2[5], w_pma_adapt_dfe_fltap2[4], w_pma_adapt_dfe_fltap2[3], w_pma_adapt_dfe_fltap2[2], w_pma_adapt_dfe_fltap2[1], w_pma_adapt_dfe_fltap2[0]}),
				.dfe_fltap2_sgn(w_pma_adapt_dfe_fltap2_sgn),
				.dfe_fltap3_coeff({w_pma_adapt_dfe_fltap3[5], w_pma_adapt_dfe_fltap3[4], w_pma_adapt_dfe_fltap3[3], w_pma_adapt_dfe_fltap3[2], w_pma_adapt_dfe_fltap3[1], w_pma_adapt_dfe_fltap3[0]}),
				.dfe_fltap3_sgn(w_pma_adapt_dfe_fltap3_sgn),
				.dfe_fltap4_coeff({w_pma_adapt_dfe_fltap4[5], w_pma_adapt_dfe_fltap4[4], w_pma_adapt_dfe_fltap4[3], w_pma_adapt_dfe_fltap4[2], w_pma_adapt_dfe_fltap4[1], w_pma_adapt_dfe_fltap4[0]}),
				.dfe_fltap4_sgn(w_pma_adapt_dfe_fltap4_sgn),
				.dfe_fltap_bypdeser(w_pma_adapt_dfe_fltap_bypdeser),
				.dfe_fltap_position({w_pma_adapt_dfe_fltap_position[5], w_pma_adapt_dfe_fltap_position[4], w_pma_adapt_dfe_fltap_position[3], w_pma_adapt_dfe_fltap_position[2], w_pma_adapt_dfe_fltap_position[1], w_pma_adapt_dfe_fltap_position[0]}),
				.dfe_fxtap1_coeff({w_pma_adapt_dfe_fxtap1[6], w_pma_adapt_dfe_fxtap1[5], w_pma_adapt_dfe_fxtap1[4], w_pma_adapt_dfe_fxtap1[3], w_pma_adapt_dfe_fxtap1[2], w_pma_adapt_dfe_fxtap1[1], w_pma_adapt_dfe_fxtap1[0]}),
				.dfe_fxtap2_coeff({w_pma_adapt_dfe_fxtap2[6], w_pma_adapt_dfe_fxtap2[5], w_pma_adapt_dfe_fxtap2[4], w_pma_adapt_dfe_fxtap2[3], w_pma_adapt_dfe_fxtap2[2], w_pma_adapt_dfe_fxtap2[1], w_pma_adapt_dfe_fxtap2[0]}),
				.dfe_fxtap2_sgn(w_pma_adapt_dfe_fxtap2_sgn),
				.dfe_fxtap3_coeff({w_pma_adapt_dfe_fxtap3[6], w_pma_adapt_dfe_fxtap3[5], w_pma_adapt_dfe_fxtap3[4], w_pma_adapt_dfe_fxtap3[3], w_pma_adapt_dfe_fxtap3[2], w_pma_adapt_dfe_fxtap3[1], w_pma_adapt_dfe_fxtap3[0]}),
				.dfe_fxtap3_sgn(w_pma_adapt_dfe_fxtap3_sgn),
				.dfe_fxtap4_coeff({w_pma_adapt_dfe_fxtap4[5], w_pma_adapt_dfe_fxtap4[4], w_pma_adapt_dfe_fxtap4[3], w_pma_adapt_dfe_fxtap4[2], w_pma_adapt_dfe_fxtap4[1], w_pma_adapt_dfe_fxtap4[0]}),
				.dfe_fxtap4_sgn(w_pma_adapt_dfe_fxtap4_sgn),
				.dfe_fxtap5_coeff({w_pma_adapt_dfe_fxtap5[5], w_pma_adapt_dfe_fxtap5[4], w_pma_adapt_dfe_fxtap5[3], w_pma_adapt_dfe_fxtap5[2], w_pma_adapt_dfe_fxtap5[1], w_pma_adapt_dfe_fxtap5[0]}),
				.dfe_fxtap5_sgn(w_pma_adapt_dfe_fxtap5_sgn),
				.dfe_fxtap6_coeff({w_pma_adapt_dfe_fxtap6[4], w_pma_adapt_dfe_fxtap6[3], w_pma_adapt_dfe_fxtap6[2], w_pma_adapt_dfe_fxtap6[1], w_pma_adapt_dfe_fxtap6[0]}),
				.dfe_fxtap6_sgn(w_pma_adapt_dfe_fxtap6_sgn),
				.dfe_fxtap7_coeff({w_pma_adapt_dfe_fxtap7[4], w_pma_adapt_dfe_fxtap7[3], w_pma_adapt_dfe_fxtap7[2], w_pma_adapt_dfe_fxtap7[1], w_pma_adapt_dfe_fxtap7[0]}),
				.dfe_fxtap7_sgn(w_pma_adapt_dfe_fxtap7_sgn),
				.dfe_rstn(in_rx_pma_rstb),
				.dfe_spec_disable(w_pma_adapt_dfe_spec_disable),
				.dfe_spec_sgn_sel(w_pma_adapt_dfe_spec_sign_sel),
				.dfe_vref_sgn_sel(w_pma_adapt_dfe_vref_sign_sel),
				.rxn(w_pma_rx_buf_outn),
				.rxp(w_pma_rx_buf_outp),
				.vga_vcm(1'b0),
				.vref_level_coeff({w_pma_adapt_vref_sel[4], w_pma_adapt_vref_sel[3], w_pma_adapt_vref_sel[2], w_pma_adapt_vref_sel[1], w_pma_adapt_vref_sel[0]})
			);
		end // if generate
		else begin
				assign w_pma_rx_dfe_avmmreaddata[7:0] = 8'b0;
				assign w_pma_rx_dfe_blockselect = 1'b0;
				assign w_pma_rx_dfe_clk0_bbpd = 1'b0;
				assign w_pma_rx_dfe_clk180_bbpd = 1'b0;
				assign w_pma_rx_dfe_clk270_bbpd = 1'b0;
				assign w_pma_rx_dfe_clk90_bbpd = 1'b0;
				assign w_pma_rx_dfe_deven = 1'b0;
				assign w_pma_rx_dfe_devenb = 1'b0;
				assign w_pma_rx_dfe_dfe_oc_tstmx[7:0] = 8'b0;
				assign w_pma_rx_dfe_dodd = 1'b0;
				assign w_pma_rx_dfe_doddb = 1'b0;
				assign w_pma_rx_dfe_edge270 = 1'b0;
				assign w_pma_rx_dfe_edge270b = 1'b0;
				assign w_pma_rx_dfe_edge90 = 1'b0;
				assign w_pma_rx_dfe_edge90b = 1'b0;
				assign w_pma_rx_dfe_err_ev = 1'b0;
				assign w_pma_rx_dfe_err_evb = 1'b0;
				assign w_pma_rx_dfe_err_od = 1'b0;
				assign w_pma_rx_dfe_err_odb = 1'b0;
				assign w_pma_rx_dfe_spec_vrefh = 1'b0;
				assign w_pma_rx_dfe_spec_vrefl = 1'b0;
		end // if not generate
		
		// instantiating twentynm_hssi_pma_rx_odi
		if ((xcvr_native_mode == "mode_rx_only") || (xcvr_native_mode == "mode_duplex")) begin:gen_twentynm_hssi_pma_rx_odi
			twentynm_hssi_pma_rx_odi #(
				.datarate(pma_rx_odi_datarate),
				.initial_settings("true"),       //PARAM_HIDE
				.optimal("false"),       //PARAM_HIDE
				.prot_mode(pma_rx_odi_prot_mode),
				.silicon_rev( "20nm4" ),       //PARAM_HIDE
				.step_ctrl_sel(pma_rx_odi_step_ctrl_sel),
				.sup_mode(pma_rx_odi_sup_mode)
			) inst_twentynm_hssi_pma_rx_odi (
				// OUTPUTS
				.avmmreaddata(w_pma_rx_odi_avmmreaddata),
				.blockselect(w_pma_rx_odi_blockselect),
				.clk0_eye(w_pma_rx_odi_clk0_eye),
				.clk0_eye_lb(w_pma_rx_odi_clk0_eye_lb),
				.clk180_eye(w_pma_rx_odi_clk180_eye),
				.clk180_eye_lb(w_pma_rx_odi_clk180_eye_lb),
				.de_eye(w_pma_rx_odi_de_eye),
				.deb_eye(w_pma_rx_odi_deb_eye),
				.do_eye(w_pma_rx_odi_do_eye),
				.dob_eye(w_pma_rx_odi_dob_eye),
				.odi_en(w_pma_rx_odi_odi_en),
				.odi_oc_tstmx(w_pma_rx_odi_odi_oc_tstmx),
				// INPUTS
				.avmmaddress({in_avmmaddress[8], in_avmmaddress[7], in_avmmaddress[6], in_avmmaddress[5], in_avmmaddress[4], in_avmmaddress[3], in_avmmaddress[2], in_avmmaddress[1], in_avmmaddress[0]}),
				.avmmclk(in_avmmclk),
				.avmmread(in_avmmread),
				.avmmrstn(in_avmmrstn),
				.avmmwrite(in_avmmwrite),
				.avmmwritedata({in_avmmwritedata[7], in_avmmwritedata[6], in_avmmwritedata[5], in_avmmwritedata[4], in_avmmwritedata[3], in_avmmwritedata[2], in_avmmwritedata[1], in_avmmwritedata[0]}),
				.clk0(w_cdr_pll_clk0_odi),
				.clk180(w_cdr_pll_clk180_odi),
				.clk270(w_cdr_pll_clk270_odi),
				.clk90(w_cdr_pll_clk90_odi),
				.odi_dft_clr(in_eye_monitor[3]),
				.odi_latch_clk(in_eye_monitor[1]),
				.odi_shift_clk(in_eye_monitor[0]),
				.odi_shift_in(in_eye_monitor[2]),
				.rx_n(w_pma_rx_buf_inn),
				.rx_p(w_pma_rx_buf_inp),
				.rxn_sum(w_pma_rx_buf_outn),
				.rxp_sum(w_pma_rx_buf_outp),
				.spec_vrefh(w_pma_rx_dfe_spec_vrefh),
				.spec_vrefl(w_pma_rx_dfe_spec_vrefl),
				.vcm_vref(1'b0),
				.vertical_fb({w_pma_adapt_odi_vref[4], w_pma_adapt_odi_vref[3], w_pma_adapt_odi_vref[2], w_pma_adapt_odi_vref[1], 1'b0}),
				
				// UNUSED
				.atb0(),
				.atb1(),
				.it50u(),
				.it50u2(),
				.it50u4(),
				.odi_atb_sel(),
				.tdr_en(),
				.vref_sel_out()
			);
		end // if generate
		else begin
				assign w_pma_rx_odi_avmmreaddata[7:0] = 8'b0;
				assign w_pma_rx_odi_blockselect = 1'b0;
				assign w_pma_rx_odi_clk0_eye = 1'b0;
				assign w_pma_rx_odi_clk0_eye_lb = 1'b0;
				assign w_pma_rx_odi_clk180_eye = 1'b0;
				assign w_pma_rx_odi_clk180_eye_lb = 1'b0;
				assign w_pma_rx_odi_de_eye = 1'b0;
				assign w_pma_rx_odi_deb_eye = 1'b0;
				assign w_pma_rx_odi_do_eye = 1'b0;
				assign w_pma_rx_odi_dob_eye = 1'b0;
				assign w_pma_rx_odi_odi_en = 1'b0;
				assign w_pma_rx_odi_odi_oc_tstmx[1:0] = 2'b0;
		end // if not generate
		
		// instantiating twentynm_hssi_pma_rx_sd
		if ((xcvr_native_mode == "mode_rx_only") || (xcvr_native_mode == "mode_duplex")) begin:gen_twentynm_hssi_pma_rx_sd
			twentynm_hssi_pma_rx_sd #(
				.optimal("false"),       //PARAM_HIDE
				.prot_mode(pma_rx_sd_prot_mode),
				.sd_output_off(pma_rx_sd_sd_output_off),
				.sd_output_on(pma_rx_sd_sd_output_on),
				.sd_pdb(pma_rx_sd_sd_pdb),
				.silicon_rev( "20nm4" ),       //PARAM_HIDE
				.sup_mode(pma_rx_sd_sup_mode)
			) inst_twentynm_hssi_pma_rx_sd (
				// OUTPUTS
				.avmmreaddata(w_pma_rx_sd_avmmreaddata),
				.blockselect(w_pma_rx_sd_blockselect),
				.sd(w_pma_rx_sd_sd),
				// INPUTS
				.avmmaddress({in_avmmaddress[8], in_avmmaddress[7], in_avmmaddress[6], in_avmmaddress[5], in_avmmaddress[4], in_avmmaddress[3], in_avmmaddress[2], in_avmmaddress[1], in_avmmaddress[0]}),
				.avmmclk(in_avmmclk),
				.avmmread(in_avmmread),
				.avmmrstn(in_avmmrstn),
				.avmmwrite(in_avmmwrite),
				.avmmwritedata({in_avmmwritedata[7], in_avmmwritedata[6], in_avmmwritedata[5], in_avmmwritedata[4], in_avmmwritedata[3], in_avmmwritedata[2], in_avmmwritedata[1], in_avmmwritedata[0]}),
				.clk(w_pma_rx_deser_clkdivrx_rx),
				.qpi(w_pma_rx_buf_pull_dn),
				.rstn_sd(in_rx_pma_rstb),
				.s_lpbk_b(in_rs_lpbk_b),
				.vin(w_pma_rx_buf_inn),
				.vip(w_pma_rx_buf_inp)
			);
		end // if generate
		else begin
				assign w_pma_rx_sd_avmmreaddata[7:0] = 8'b0;
				assign w_pma_rx_sd_blockselect = 1'b0;
				assign w_pma_rx_sd_sd = 1'b0;
		end // if not generate
		
		// instantiating twentynm_hssi_pma_tx_buf
		if ((xcvr_native_mode == "mode_tx_only") || (xcvr_native_mode == "mode_duplex")) begin:gen_twentynm_hssi_pma_tx_buf
			twentynm_hssi_pma_tx_buf #(
				.datarate(pma_tx_buf_datarate),
				.dft_sel("dft_disabled"),       //PARAM_HIDE
				.initial_settings("true"),       //PARAM_HIDE
				.jtag_drv_sel("drv1"),       //PARAM_HIDE
				.jtag_lp("lp_off"),       //PARAM_HIDE
				.lst("atb_disabled"),       //PARAM_HIDE
				.mcgb_location_for_pcie(pma_tx_buf_mcgb_location_for_pcie),
				.optimal("false"),       //PARAM_HIDE
				.prot_mode(pma_tx_buf_prot_mode),
				.rx_det(pma_tx_buf_rx_det),
				.rx_det_output_sel(pma_tx_buf_rx_det_output_sel),
				.rx_det_pdb(pma_tx_buf_rx_det_pdb),
				.ser_powerdown("normal_ser_on"),       //PARAM_HIDE
				.silicon_rev( "20nm4" ),       //PARAM_HIDE
				.sup_mode(pma_tx_buf_sup_mode),
				.tx_powerdown("normal_tx_on"),       //PARAM_HIDE
				.user_fir_coeff_ctrl_sel(pma_tx_buf_user_fir_coeff_ctrl_sel),
				.xtx_path_clock_divider_ratio(pma_tx_buf_xtx_path_clock_divider_ratio),
				.xtx_path_datarate(pma_tx_buf_xtx_path_datarate),
				.xtx_path_datawidth(pma_tx_buf_xtx_path_datawidth),
				.xtx_path_initial_settings("true"),       //PARAM_HIDE
				.xtx_path_optimal("false"),       //PARAM_HIDE
				.xtx_path_pma_tx_divclk_hz(pma_tx_buf_xtx_path_pma_tx_divclk_hz),
				.xtx_path_prot_mode(pma_tx_buf_xtx_path_prot_mode),
				.xtx_path_sup_mode(pma_tx_buf_xtx_path_sup_mode),
				.xtx_path_tx_pll_clk_hz(pma_tx_buf_xtx_path_tx_pll_clk_hz)
			) inst_twentynm_hssi_pma_tx_buf (
				// OUTPUTS
				.atbsel(w_pma_tx_buf_atbsel),
				.avmmreaddata(w_pma_tx_buf_avmmreaddata),
				.blockselect(w_pma_tx_buf_blockselect),
				.ckn(w_pma_tx_buf_ckn),
				.ckp(w_pma_tx_buf_ckp),
				.dcd_out1(w_pma_tx_buf_dcd_out1),
				.dcd_out2(w_pma_tx_buf_dcd_out2),
				.dcd_out_ready(w_pma_tx_buf_dcd_out_ready),
				.detect_on(w_pma_tx_buf_detect_on),
				.lbvon(w_pma_tx_buf_lbvon),
				.lbvop(w_pma_tx_buf_lbvop),
				.rx_detect_valid(w_pma_tx_buf_rx_detect_valid),
				.rx_found(w_pma_tx_buf_rx_found),
				.rx_found_pcie_spl_test(w_pma_tx_buf_rx_found_pcie_spl_test),
				.sel_vreg(w_pma_tx_buf_sel_vreg),
				.spl_clk_test(w_pma_tx_buf_spl_clk_test),
				.tx_dftout(w_pma_tx_buf_tx_dftout),
				.vlptxn(w_pma_tx_buf_vlptxn),
				.vlptxp(w_pma_tx_buf_vlptxp),
				.von(w_pma_tx_buf_von),
				.vop(w_pma_tx_buf_vop),
				// INPUTS
				.avmmaddress({in_avmmaddress[8], in_avmmaddress[7], in_avmmaddress[6], in_avmmaddress[5], in_avmmaddress[4], in_avmmaddress[3], in_avmmaddress[2], in_avmmaddress[1], in_avmmaddress[0]}),
				.avmmclk(in_avmmclk),
				.avmmread(in_avmmread),
				.avmmrstn(in_avmmrstn),
				.avmmwrite(in_avmmwrite),
				.avmmwritedata({in_avmmwritedata[7], in_avmmwritedata[6], in_avmmwritedata[5], in_avmmwritedata[4], in_avmmwritedata[3], in_avmmwritedata[2], in_avmmwritedata[1], in_avmmwritedata[0]}),
				.bsmode(1'b0),
				.bsoeb(1'b0),
				.bstxn_in(1'b0),
				.bstxp_in(1'b0),
				.clk0_tx(w_pma_cgb_hifreqclkp),
				.clk180_tx(w_pma_cgb_hifreqclkn),
				.clk_dcd(w_pma_cgb_cpulse_out_bus[0]),
				.clksn(w_pma_tx_ser_ckdrvp),
				.clksp(w_pma_tx_ser_ckdrvn),
				.i_coeff({in_i_coeff[17], in_i_coeff[16], in_i_coeff[15], in_i_coeff[14], in_i_coeff[13], in_i_coeff[12], in_i_coeff[11], in_i_coeff[10], in_i_coeff[9], in_i_coeff[8], in_i_coeff[7], in_i_coeff[6], in_i_coeff[5], in_i_coeff[4], in_i_coeff[3], in_i_coeff[2], in_i_coeff[1], in_i_coeff[0]}),
				.oe(w_pma_tx_ser_oe),
				.oeb(w_pma_tx_ser_oeb),
				.oo(w_pma_tx_ser_oo),
				.oob(w_pma_tx_ser_oob),
				.pcie_sw_master(w_pma_cgb_pcie_sw_master[1]),
				.rx_det_clk(w_pma_cdr_refclk_rx_det_clk),
				.rx_n_bidir_in(in_rx_n),
				.rx_p_bidir_in(in_rx_p),
				.s_lpbk_b(in_rs_lpbk_b),
				.tx50({in_tx50_buf_in[8], in_tx50_buf_in[7], in_tx50_buf_in[6], in_tx50_buf_in[5], in_tx50_buf_in[4], in_tx50_buf_in[3], in_tx50_buf_in[2], in_tx50_buf_in[1], in_tx50_buf_in[0]}),
				.tx_det_rx(in_tx_det_rx),
				.tx_elec_idle(in_tx_elec_idle),
				.tx_qpi_pulldn(in_tx_qpi_pulldn),
				.tx_qpi_pullup(in_tx_qpi_pullup),
				.tx_rlpbk(w_cdr_pll_tx_rlpbk),
				.vrlpbkn(w_cdr_pll_rlpbkn),
				.vrlpbkn_1t(w_cdr_pll_rlpbkdn),
				.vrlpbkp(w_cdr_pll_rlpbkp),
				.vrlpbkp_1t(w_cdr_pll_rlpbkdp),
				
				// UNUSED
				.cr_rdynamic_sw()
			);
		end // if generate
		else begin
				assign w_pma_tx_buf_atbsel[2:0] = 3'b0;
				assign w_pma_tx_buf_avmmreaddata[7:0] = 8'b0;
				assign w_pma_tx_buf_blockselect = 1'b0;
				assign w_pma_tx_buf_ckn = 1'b0;
				assign w_pma_tx_buf_ckp = 1'b0;
				assign w_pma_tx_buf_dcd_out1 = 1'b0;
				assign w_pma_tx_buf_dcd_out2 = 1'b0;
				assign w_pma_tx_buf_dcd_out_ready = 1'b0;
				assign w_pma_tx_buf_detect_on[1:0] = 2'b0;
				assign w_pma_tx_buf_lbvon = 1'b0;
				assign w_pma_tx_buf_lbvop = 1'b0;
				assign w_pma_tx_buf_rx_detect_valid = 1'b0;
				assign w_pma_tx_buf_rx_found = 1'b0;
				assign w_pma_tx_buf_rx_found_pcie_spl_test = 1'b0;
				assign w_pma_tx_buf_sel_vreg = 1'b0;
				assign w_pma_tx_buf_spl_clk_test = 1'b0;
				assign w_pma_tx_buf_tx_dftout[7:0] = 8'b0;
				assign w_pma_tx_buf_vlptxn = 1'b0;
				assign w_pma_tx_buf_vlptxp = 1'b0;
				assign w_pma_tx_buf_von = 1'b0;
				assign w_pma_tx_buf_vop = 1'b0;
		end // if not generate
		
		// instantiating twentynm_hssi_pma_tx_cgb
		if ((xcvr_native_mode == "mode_tx_only") || (xcvr_native_mode == "mode_duplex")) begin:gen_twentynm_hssi_pma_tx_cgb
			twentynm_hssi_pma_tx_cgb #(
				.bitslip_enable(pma_cgb_bitslip_enable),
				.bonding_reset_enable(pma_cgb_bonding_reset_enable),
				.cgb_power_down("normal_cgb"),       //PARAM_HIDE
				.datarate(pma_cgb_datarate),
				.initial_settings("true"),       //PARAM_HIDE
				.input_select_gen3(pma_cgb_input_select_gen3),
				.input_select_x1(pma_cgb_input_select_x1),
				.input_select_xn(pma_cgb_input_select_xn),
				.pcie_gen3_bitwidth(pma_cgb_pcie_gen3_bitwidth),
				.prot_mode(pma_cgb_prot_mode),
				.scratch0_x1_clock_src(pma_cgb_scratch0_x1_clock_src),
				.scratch1_x1_clock_src(pma_cgb_scratch1_x1_clock_src),
				.scratch2_x1_clock_src(pma_cgb_scratch2_x1_clock_src),
				.scratch3_x1_clock_src(pma_cgb_scratch3_x1_clock_src),
				.select_done_master_or_slave(pma_cgb_select_done_master_or_slave),
				.ser_mode(pma_cgb_ser_mode),
				.ser_powerdown("normal_poweron_ser"),       //PARAM_HIDE
				.silicon_rev( "20nm4" ),       //PARAM_HIDE
				.sup_mode(pma_cgb_sup_mode),
				.tx_ucontrol_en(pma_cgb_tx_ucontrol_en),
				.x1_div_m_sel(pma_cgb_x1_div_m_sel)
			) inst_twentynm_hssi_pma_tx_cgb (
				// OUTPUTS
				.avmmreaddata(w_pma_cgb_avmmreaddata),
				.bitslipstate(w_pma_cgb_bitslipstate),
				.blockselect(w_pma_cgb_blockselect),
				.cpulse_out_bus(w_pma_cgb_cpulse_out_bus),
				.div2(w_pma_cgb_div2),
				.div4(w_pma_cgb_div4),
				.div5(w_pma_cgb_div5),
				.hifreqclkn(w_pma_cgb_hifreqclkn),
				.hifreqclkp(w_pma_cgb_hifreqclkp),
				.pcie_sw_done(w_pma_cgb_pcie_sw_done),
				.pcie_sw_master(w_pma_cgb_pcie_sw_master),
				.rstb(w_pma_cgb_rstb),
				// INPUTS
				.avmmaddress({in_avmmaddress[8], in_avmmaddress[7], in_avmmaddress[6], in_avmmaddress[5], in_avmmaddress[4], in_avmmaddress[3], in_avmmaddress[2], in_avmmaddress[1], in_avmmaddress[0]}),
				.avmmclk(in_avmmclk),
				.avmmread(in_avmmread),
				.avmmrstn(in_avmmrstn),
				.avmmwrite(in_avmmwrite),
				.avmmwritedata({in_avmmwritedata[7], in_avmmwritedata[6], in_avmmwritedata[5], in_avmmwritedata[4], in_avmmwritedata[3], in_avmmwritedata[2], in_avmmwritedata[1], in_avmmwritedata[0]}),
				.ckdccn(w_pma_tx_buf_ckn),
				.ckdccp(w_pma_tx_buf_ckp),
				.clk_cdr_b(in_clk_cdr_b),
				.clk_cdr_direct(w_cdr_pll_clk0_pfd),
				.clk_cdr_t(in_clk_cdr_t),
				.clk_fpll_b(in_clk_fpll_b),
				.clk_fpll_t(in_clk_fpll_t),
				.clk_lc_b(in_clk_lc_b),
				.clk_lc_hs(in_clk_lc_hs),
				.clk_lc_t(in_clk_lc_t),
				.clkb_cdr_b(in_clkb_cdr_b),
				.clkb_cdr_direct(w_cdr_pll_clk180_pfd),
				.clkb_cdr_t(in_clkb_cdr_t),
				.clkb_fpll_b(in_clkb_fpll_b),
				.clkb_fpll_t(in_clkb_fpll_t),
				.clkb_lc_b(in_clkb_lc_b),
				.clkb_lc_hs(in_clkb_lc_hs),
				.clkb_lc_t(in_clkb_lc_t),
				.cpulse_x6_dn_bus({in_cpulse_x6_dn_bus[5], in_cpulse_x6_dn_bus[4], in_cpulse_x6_dn_bus[3], in_cpulse_x6_dn_bus[2], in_cpulse_x6_dn_bus[1], in_cpulse_x6_dn_bus[0]}),
				.cpulse_x6_up_bus({in_cpulse_x6_up_bus[5], in_cpulse_x6_up_bus[4], in_cpulse_x6_up_bus[3], in_cpulse_x6_up_bus[2], in_cpulse_x6_up_bus[1], in_cpulse_x6_up_bus[0]}),
				.cpulse_xn_dn_bus({in_cpulse_xn_dn_bus[5], in_cpulse_xn_dn_bus[4], in_cpulse_xn_dn_bus[3], in_cpulse_xn_dn_bus[2], in_cpulse_xn_dn_bus[1], in_cpulse_xn_dn_bus[0]}),
				.cpulse_xn_up_bus({in_cpulse_xn_up_bus[5], in_cpulse_xn_up_bus[4], in_cpulse_xn_up_bus[3], in_cpulse_xn_up_bus[2], in_cpulse_xn_up_bus[1], in_cpulse_xn_up_bus[0]}),
				.pcie_sw({in_pcie_sw[1], in_pcie_sw[0]}),
				.pcie_sw_done_master({in_pcie_sw_done_master_in[1], in_pcie_sw_done_master_in[0]}),
				.tx_bitslip(in_tx_bitslip),
				.tx_bonding_rstb(in_tx_bonding_rstb),
				.tx_pma_rstb(in_tx_pma_rstb)
			);
		end // if generate
		else begin
				assign w_pma_cgb_avmmreaddata[7:0] = 8'b0;
				assign w_pma_cgb_bitslipstate = 1'b0;
				assign w_pma_cgb_blockselect = 1'b0;
				assign w_pma_cgb_cpulse_out_bus[5:0] = 6'b0;
				assign w_pma_cgb_div2 = 1'b0;
				assign w_pma_cgb_div4 = 1'b0;
				assign w_pma_cgb_div5 = 1'b0;
				assign w_pma_cgb_hifreqclkn = 1'b0;
				assign w_pma_cgb_hifreqclkp = 1'b0;
				assign w_pma_cgb_pcie_sw_done[1:0] = 2'b0;
				assign w_pma_cgb_pcie_sw_master[1:0] = 2'b0;
				assign w_pma_cgb_rstb = 1'b0;
		end // if not generate
		
		// instantiating twentynm_hssi_pma_tx_ser
		if ((xcvr_native_mode == "mode_tx_only") || (xcvr_native_mode == "mode_duplex")) begin:gen_twentynm_hssi_pma_tx_ser
			twentynm_hssi_pma_tx_ser #(
				.control_clk_divtx("no_dft_control_clkdivtx"),       //PARAM_HIDE
				.initial_settings("true"),       //PARAM_HIDE
				.prot_mode(pma_tx_ser_prot_mode),
				.ser_clk_divtx_user_sel(pma_tx_ser_ser_clk_divtx_user_sel),
				.ser_powerdown("normal_poweron_ser"),       //PARAM_HIDE
				.silicon_rev( "20nm4" ),       //PARAM_HIDE
				.sup_mode(pma_tx_ser_sup_mode)
			) inst_twentynm_hssi_pma_tx_ser (
				// OUTPUTS
				.avmmreaddata(w_pma_tx_ser_avmmreaddata),
				.blockselect(w_pma_tx_ser_blockselect),
				.ckdrvn(w_pma_tx_ser_ckdrvn),
				.ckdrvp(w_pma_tx_ser_ckdrvp),
				.clk_divtx(w_pma_tx_ser_clk_divtx),
				.clk_divtx_user(w_pma_tx_ser_clk_divtx_user),
				.oe(w_pma_tx_ser_oe),
				.oeb(w_pma_tx_ser_oeb),
				.oo(w_pma_tx_ser_oo),
				.oob(w_pma_tx_ser_oob),
				// INPUTS
				.avmmaddress({in_avmmaddress[8], in_avmmaddress[7], in_avmmaddress[6], in_avmmaddress[5], in_avmmaddress[4], in_avmmaddress[3], in_avmmaddress[2], in_avmmaddress[1], in_avmmaddress[0]}),
				.avmmclk(in_avmmclk),
				.avmmread(in_avmmread),
				.avmmrstn(in_avmmrstn),
				.avmmwrite(in_avmmwrite),
				.avmmwritedata({in_avmmwritedata[7], in_avmmwritedata[6], in_avmmwritedata[5], in_avmmwritedata[4], in_avmmwritedata[3], in_avmmwritedata[2], in_avmmwritedata[1], in_avmmwritedata[0]}),
				.bitslipstate(w_pma_cgb_bitslipstate),
				.cpulse(w_pma_cgb_cpulse_out_bus[1]),
				.data({in_tx_data[63], in_tx_data[62], in_tx_data[61], in_tx_data[60], in_tx_data[59], in_tx_data[58], in_tx_data[57], in_tx_data[56], in_tx_data[55], in_tx_data[54], in_tx_data[53], in_tx_data[52], in_tx_data[51], in_tx_data[50], in_tx_data[49], in_tx_data[48], in_tx_data[47], in_tx_data[46], in_tx_data[45], in_tx_data[44], in_tx_data[43], in_tx_data[42], in_tx_data[41], in_tx_data[40], in_tx_data[39], in_tx_data[38], in_tx_data[37], in_tx_data[36], in_tx_data[35], in_tx_data[34], in_tx_data[33], in_tx_data[32], in_tx_data[31], in_tx_data[30], in_tx_data[29], in_tx_data[28], in_tx_data[27], in_tx_data[26], in_tx_data[25], in_tx_data[24], in_tx_data[23], in_tx_data[22], in_tx_data[21], in_tx_data[20], in_tx_data[19], in_tx_data[18], in_tx_data[17], in_tx_data[16], in_tx_data[15], in_tx_data[14], in_tx_data[13], in_tx_data[12], in_tx_data[11], in_tx_data[10], in_tx_data[9], in_tx_data[8], in_tx_data[7], in_tx_data[6], in_tx_data[5], in_tx_data[4], in_tx_data[3], in_tx_data[2], in_tx_data[1], in_tx_data[0]}),
				.hfclkn(w_pma_cgb_cpulse_out_bus[4]),
				.hfclkp(w_pma_cgb_cpulse_out_bus[5]),
				.lfclk(w_pma_cgb_cpulse_out_bus[3]),
				.lfclk2(w_pma_cgb_cpulse_out_bus[2]),
				.paraclk(w_pma_cgb_cpulse_out_bus[0]),
				.rser_div2(w_pma_cgb_div2),
				.rser_div4(w_pma_cgb_div4),
				.rser_div5(w_pma_cgb_div5),
				.rst_n(w_pma_cgb_rstb)
			);
		end // if generate
		else begin
				assign w_pma_tx_ser_avmmreaddata[7:0] = 8'b0;
				assign w_pma_tx_ser_blockselect = 1'b0;
				assign w_pma_tx_ser_ckdrvn = 1'b0;
				assign w_pma_tx_ser_ckdrvp = 1'b0;
				assign w_pma_tx_ser_clk_divtx = 1'b0;
				assign w_pma_tx_ser_clk_divtx_user = 1'b0;
				assign w_pma_tx_ser_oe = 1'b0;
				assign w_pma_tx_ser_oeb = 1'b0;
				assign w_pma_tx_ser_oo = 1'b0;
				assign w_pma_tx_ser_oob = 1'b0;
		end // if not generate
		
		//output assignments
		assign out_avmmreaddata_cdr_pll = {w_cdr_pll_avmmreaddata[7], w_cdr_pll_avmmreaddata[6], w_cdr_pll_avmmreaddata[5], w_cdr_pll_avmmreaddata[4], w_cdr_pll_avmmreaddata[3], w_cdr_pll_avmmreaddata[2], w_cdr_pll_avmmreaddata[1], w_cdr_pll_avmmreaddata[0]};
		assign out_avmmreaddata_pma_adapt = {w_pma_adapt_avmmreaddata[7], w_pma_adapt_avmmreaddata[6], w_pma_adapt_avmmreaddata[5], w_pma_adapt_avmmreaddata[4], w_pma_adapt_avmmreaddata[3], w_pma_adapt_avmmreaddata[2], w_pma_adapt_avmmreaddata[1], w_pma_adapt_avmmreaddata[0]};
		assign out_avmmreaddata_pma_cdr_refclk = {w_pma_cdr_refclk_avmmreaddata[7], w_pma_cdr_refclk_avmmreaddata[6], w_pma_cdr_refclk_avmmreaddata[5], w_pma_cdr_refclk_avmmreaddata[4], w_pma_cdr_refclk_avmmreaddata[3], w_pma_cdr_refclk_avmmreaddata[2], w_pma_cdr_refclk_avmmreaddata[1], w_pma_cdr_refclk_avmmreaddata[0]};
		assign out_avmmreaddata_pma_cgb = {w_pma_cgb_avmmreaddata[7], w_pma_cgb_avmmreaddata[6], w_pma_cgb_avmmreaddata[5], w_pma_cgb_avmmreaddata[4], w_pma_cgb_avmmreaddata[3], w_pma_cgb_avmmreaddata[2], w_pma_cgb_avmmreaddata[1], w_pma_cgb_avmmreaddata[0]};
		assign out_avmmreaddata_pma_rx_buf = {w_pma_rx_buf_avmmreaddata[7], w_pma_rx_buf_avmmreaddata[6], w_pma_rx_buf_avmmreaddata[5], w_pma_rx_buf_avmmreaddata[4], w_pma_rx_buf_avmmreaddata[3], w_pma_rx_buf_avmmreaddata[2], w_pma_rx_buf_avmmreaddata[1], w_pma_rx_buf_avmmreaddata[0]};
		assign out_avmmreaddata_pma_rx_deser = {w_pma_rx_deser_avmmreaddata[7], w_pma_rx_deser_avmmreaddata[6], w_pma_rx_deser_avmmreaddata[5], w_pma_rx_deser_avmmreaddata[4], w_pma_rx_deser_avmmreaddata[3], w_pma_rx_deser_avmmreaddata[2], w_pma_rx_deser_avmmreaddata[1], w_pma_rx_deser_avmmreaddata[0]};
		assign out_avmmreaddata_pma_rx_dfe = {w_pma_rx_dfe_avmmreaddata[7], w_pma_rx_dfe_avmmreaddata[6], w_pma_rx_dfe_avmmreaddata[5], w_pma_rx_dfe_avmmreaddata[4], w_pma_rx_dfe_avmmreaddata[3], w_pma_rx_dfe_avmmreaddata[2], w_pma_rx_dfe_avmmreaddata[1], w_pma_rx_dfe_avmmreaddata[0]};
		assign out_avmmreaddata_pma_rx_odi = {w_pma_rx_odi_avmmreaddata[7], w_pma_rx_odi_avmmreaddata[6], w_pma_rx_odi_avmmreaddata[5], w_pma_rx_odi_avmmreaddata[4], w_pma_rx_odi_avmmreaddata[3], w_pma_rx_odi_avmmreaddata[2], w_pma_rx_odi_avmmreaddata[1], w_pma_rx_odi_avmmreaddata[0]};
		assign out_avmmreaddata_pma_rx_sd = {w_pma_rx_sd_avmmreaddata[7], w_pma_rx_sd_avmmreaddata[6], w_pma_rx_sd_avmmreaddata[5], w_pma_rx_sd_avmmreaddata[4], w_pma_rx_sd_avmmreaddata[3], w_pma_rx_sd_avmmreaddata[2], w_pma_rx_sd_avmmreaddata[1], w_pma_rx_sd_avmmreaddata[0]};
		assign out_avmmreaddata_pma_tx_buf = {w_pma_tx_buf_avmmreaddata[7], w_pma_tx_buf_avmmreaddata[6], w_pma_tx_buf_avmmreaddata[5], w_pma_tx_buf_avmmreaddata[4], w_pma_tx_buf_avmmreaddata[3], w_pma_tx_buf_avmmreaddata[2], w_pma_tx_buf_avmmreaddata[1], w_pma_tx_buf_avmmreaddata[0]};
		assign out_avmmreaddata_pma_tx_ser = {w_pma_tx_ser_avmmreaddata[7], w_pma_tx_ser_avmmreaddata[6], w_pma_tx_ser_avmmreaddata[5], w_pma_tx_ser_avmmreaddata[4], w_pma_tx_ser_avmmreaddata[3], w_pma_tx_ser_avmmreaddata[2], w_pma_tx_ser_avmmreaddata[1], w_pma_tx_ser_avmmreaddata[0]};
		assign out_blockselect_cdr_pll = w_cdr_pll_blockselect;
		assign out_blockselect_pma_adapt = w_pma_adapt_blockselect;
		assign out_blockselect_pma_cdr_refclk = w_pma_cdr_refclk_blockselect;
		assign out_blockselect_pma_cgb = w_pma_cgb_blockselect;
		assign out_blockselect_pma_rx_buf = w_pma_rx_buf_blockselect;
		assign out_blockselect_pma_rx_deser = w_pma_rx_deser_blockselect;
		assign out_blockselect_pma_rx_dfe = w_pma_rx_dfe_blockselect;
		assign out_blockselect_pma_rx_odi = w_pma_rx_odi_blockselect;
		assign out_blockselect_pma_rx_sd = w_pma_rx_sd_blockselect;
		assign out_blockselect_pma_tx_buf = w_pma_tx_buf_blockselect;
		assign out_blockselect_pma_tx_ser = w_pma_tx_ser_blockselect;
		assign out_clk0_pfd = w_cdr_pll_clk0_pfd;
		assign out_clk180_pfd = w_cdr_pll_clk180_pfd;
		assign out_clk_divrx_iqtxrx = w_pma_rx_deser_clkdiv;
		assign out_clk_divtx_iqtxrx = w_pma_tx_ser_clk_divtx;
		assign out_clkdiv_rx = w_pma_rx_deser_clkdiv;
		assign out_clkdiv_rx_user = w_pma_rx_deser_clkdiv_user;
		assign out_clkdiv_tx = w_pma_tx_ser_clk_divtx;
		assign out_clkdiv_tx_user = w_pma_tx_ser_clk_divtx_user;
		assign out_clklow = w_cdr_pll_clklow;
		assign out_fref = w_cdr_pll_fref;
		assign out_iqtxrxclk_out0 = w_pma_tx_ser_clk_divtx;
		assign out_iqtxrxclk_out1 = w_pma_tx_ser_clk_divtx;
		assign out_jtaglpxn = w_pma_tx_buf_vlptxn;
		assign out_jtaglpxp = w_pma_tx_buf_vlptxp;
		assign out_pcie_sw_done = {w_pma_cgb_pcie_sw_done[1], w_pma_cgb_pcie_sw_done[0]};
		assign out_pcie_sw_master = {w_pma_cgb_pcie_sw_master[1], w_pma_cgb_pcie_sw_master[0]};
		assign out_pfdmode_lock = w_cdr_pll_pfdmode_lock;
		assign out_rx_detect_valid = w_pma_tx_buf_rx_detect_valid;
		assign out_rx_found = w_pma_tx_buf_rx_found;
		assign out_rxdata = {w_pma_rx_deser_dout[63], w_pma_rx_deser_dout[62], w_pma_rx_deser_dout[61], w_pma_rx_deser_dout[60], w_pma_rx_deser_dout[59], w_pma_rx_deser_dout[58], w_pma_rx_deser_dout[57], w_pma_rx_deser_dout[56], w_pma_rx_deser_dout[55], w_pma_rx_deser_dout[54], w_pma_rx_deser_dout[53], w_pma_rx_deser_dout[52], w_pma_rx_deser_dout[51], w_pma_rx_deser_dout[50], w_pma_rx_deser_dout[49], w_pma_rx_deser_dout[48], w_pma_rx_deser_dout[47], w_pma_rx_deser_dout[46], w_pma_rx_deser_dout[45], w_pma_rx_deser_dout[44], w_pma_rx_deser_dout[43], w_pma_rx_deser_dout[42], w_pma_rx_deser_dout[41], w_pma_rx_deser_dout[40], w_pma_rx_deser_dout[39], w_pma_rx_deser_dout[38], w_pma_rx_deser_dout[37], w_pma_rx_deser_dout[36], w_pma_rx_deser_dout[35], w_pma_rx_deser_dout[34], w_pma_rx_deser_dout[33], w_pma_rx_deser_dout[32], w_pma_rx_deser_dout[31], w_pma_rx_deser_dout[30], w_pma_rx_deser_dout[29], w_pma_rx_deser_dout[28], w_pma_rx_deser_dout[27], w_pma_rx_deser_dout[26], w_pma_rx_deser_dout[25], w_pma_rx_deser_dout[24], w_pma_rx_deser_dout[23], w_pma_rx_deser_dout[22], w_pma_rx_deser_dout[21], w_pma_rx_deser_dout[20], w_pma_rx_deser_dout[19], w_pma_rx_deser_dout[18], w_pma_rx_deser_dout[17], w_pma_rx_deser_dout[16], w_pma_rx_deser_dout[15], w_pma_rx_deser_dout[14], w_pma_rx_deser_dout[13], w_pma_rx_deser_dout[12], w_pma_rx_deser_dout[11], w_pma_rx_deser_dout[10], w_pma_rx_deser_dout[9], w_pma_rx_deser_dout[8], w_pma_rx_deser_dout[7], w_pma_rx_deser_dout[6], w_pma_rx_deser_dout[5], w_pma_rx_deser_dout[4], w_pma_rx_deser_dout[3], w_pma_rx_deser_dout[2], w_pma_rx_deser_dout[1], w_pma_rx_deser_dout[0]};
		assign out_rxpll_lock = w_cdr_pll_rxpll_lock;
		assign out_sd = w_pma_rx_sd_sd;
		assign out_tx_n = w_pma_tx_buf_von;
		assign out_tx_p = w_pma_tx_buf_vop;
	endgenerate
endmodule
module twentynm_pma_rev_20nm5
	#(
	//PARAM_LIST_START
		parameter xcvr_native_mode = "mode_duplex",  // mode_duplex, mode_rx_only, mode_tx_only
		
		// parameters for twentynm_hssi_pma_adaptation
		parameter pma_adapt_adapt_mode = "dfe_vga", // ctle|dfe_vga|ctle_vga|ctle_vga_dfe|manual
		parameter pma_adapt_adp_1s_ctle_bypass = "radp_1s_ctle_bypass_0", // radp_1s_ctle_bypass_0|radp_1s_ctle_bypass_1
		parameter pma_adapt_adp_4s_ctle_bypass = "radp_4s_ctle_bypass_0", // radp_4s_ctle_bypass_0|radp_4s_ctle_bypass_1
		parameter pma_adapt_adp_ctle_adapt_cycle_window = "radp_ctle_adapt_cycle_window_6", // radp_ctle_adapt_cycle_window_0|radp_ctle_adapt_cycle_window_1|radp_ctle_adapt_cycle_window_2|radp_ctle_adapt_cycle_window_3|radp_ctle_adapt_cycle_window_4|radp_ctle_adapt_cycle_window_5|radp_ctle_adapt_cycle_window_6|radp_ctle_adapt_cycle_window_7
		parameter pma_adapt_adp_ctle_en = "radp_ctle_disable", // radp_ctle_disable|radp_ctle_enable
		parameter pma_adapt_adp_dfe_fltap_bypass = "radp_dfe_fltap_bypass_0", // radp_dfe_fltap_bypass_0|radp_dfe_fltap_bypass_1
		parameter pma_adapt_adp_dfe_fltap_en = "radp_dfe_fltap_disable", // radp_dfe_fltap_disable|radp_dfe_fltap_enable
		parameter pma_adapt_adp_dfe_fxtap_bypass = "radp_dfe_fxtap_bypass_0", // radp_dfe_fxtap_bypass_0|radp_dfe_fxtap_bypass_1
		parameter pma_adapt_adp_dfe_fxtap_en = "radp_dfe_fxtap_disable", // radp_dfe_fxtap_disable|radp_dfe_fxtap_enable
		parameter pma_adapt_adp_dfe_fxtap_hold_en = "radp_dfe_fxtap_not_held", // radp_dfe_fxtap_not_held|radp_dfe_fxtap_hold
		parameter pma_adapt_adp_dfe_mode = "radp_dfe_mode_0", // radp_dfe_mode_0|radp_dfe_mode_1|radp_dfe_mode_2|radp_dfe_mode_3|radp_dfe_mode_4|radp_dfe_mode_5|radp_dfe_mode_6|radp_dfe_mode_7
		parameter pma_adapt_adp_mode = "radp_mode_0", // radp_mode_0|radp_mode_1|radp_mode_2|radp_mode_3|radp_mode_4|radp_mode_5|radp_mode_6|radp_mode_7|radp_mode_8|radp_mode_9|radp_mode_10|radp_mode_11|radp_mode_12|radp_mode_13|radp_mode_14|radp_mode_15
		parameter pma_adapt_adp_onetime_dfe = "radp_onetime_dfe_0", // radp_onetime_dfe_0|radp_onetime_dfe_1
		parameter pma_adapt_adp_vga_bypass = "radp_vga_bypass_0", // radp_vga_bypass_0|radp_vga_bypass_1
		parameter pma_adapt_adp_vga_en = "radp_vga_disable", // radp_vga_disable|radp_vga_enable
		parameter pma_adapt_adp_vref_bypass = "radp_vref_bypass_0", // radp_vref_bypass_0|radp_vref_bypass_1
		parameter pma_adapt_adp_vref_en = "radp_vref_disable", // radp_vref_disable|radp_vref_enable
		parameter pma_adapt_datarate = "0 bps", // 
		parameter pma_adapt_odi_dfe_spec_en = "rodi_dfe_spec_en_0", // rodi_dfe_spec_en_0|rodi_dfe_spec_en_1
		parameter pma_adapt_prot_mode = "basic_rx", // basic_rx|pcie_gen1_rx|pcie_gen2_rx|pcie_gen3_rx|pcie_gen4_rx|qpi_rx|unused|gpon_rx|sata_rx
		parameter pma_adapt_sup_mode = "user_mode", // user_mode|engineering_mode
		
		// parameters for twentynm_hssi_pma_cdr_refclk_select_mux
		parameter pma_cdr_refclk_inclk0_logical_to_physical_mapping = "ref_iqclk0", // ref_iqclk0|ref_iqclk1|ref_iqclk2|ref_iqclk3|ref_iqclk4|ref_iqclk5|ref_iqclk6|ref_iqclk7|ref_iqclk8|ref_iqclk9|ref_iqclk10|ref_iqclk11|iqtxrxclk0|iqtxrxclk1|iqtxrxclk2|iqtxrxclk3|iqtxrxclk4|iqtxrxclk5|coreclk|fixed_clk|lvpecl|adj_pll_clk|power_down
		parameter pma_cdr_refclk_inclk1_logical_to_physical_mapping = "ref_iqclk0", // ref_iqclk0|ref_iqclk1|ref_iqclk2|ref_iqclk3|ref_iqclk4|ref_iqclk5|ref_iqclk6|ref_iqclk7|ref_iqclk8|ref_iqclk9|ref_iqclk10|ref_iqclk11|iqtxrxclk0|iqtxrxclk1|iqtxrxclk2|iqtxrxclk3|iqtxrxclk4|iqtxrxclk5|coreclk|fixed_clk|lvpecl|adj_pll_clk|power_down
		parameter pma_cdr_refclk_inclk2_logical_to_physical_mapping = "ref_iqclk0", // ref_iqclk0|ref_iqclk1|ref_iqclk2|ref_iqclk3|ref_iqclk4|ref_iqclk5|ref_iqclk6|ref_iqclk7|ref_iqclk8|ref_iqclk9|ref_iqclk10|ref_iqclk11|iqtxrxclk0|iqtxrxclk1|iqtxrxclk2|iqtxrxclk3|iqtxrxclk4|iqtxrxclk5|coreclk|fixed_clk|lvpecl|adj_pll_clk|power_down
		parameter pma_cdr_refclk_inclk3_logical_to_physical_mapping = "ref_iqclk0", // ref_iqclk0|ref_iqclk1|ref_iqclk2|ref_iqclk3|ref_iqclk4|ref_iqclk5|ref_iqclk6|ref_iqclk7|ref_iqclk8|ref_iqclk9|ref_iqclk10|ref_iqclk11|iqtxrxclk0|iqtxrxclk1|iqtxrxclk2|iqtxrxclk3|iqtxrxclk4|iqtxrxclk5|coreclk|fixed_clk|lvpecl|adj_pll_clk|power_down
		parameter pma_cdr_refclk_inclk4_logical_to_physical_mapping = "ref_iqclk0", // ref_iqclk0|ref_iqclk1|ref_iqclk2|ref_iqclk3|ref_iqclk4|ref_iqclk5|ref_iqclk6|ref_iqclk7|ref_iqclk8|ref_iqclk9|ref_iqclk10|ref_iqclk11|iqtxrxclk0|iqtxrxclk1|iqtxrxclk2|iqtxrxclk3|iqtxrxclk4|iqtxrxclk5|coreclk|fixed_clk|lvpecl|adj_pll_clk|power_down
		parameter pma_cdr_refclk_powerdown_mode = "powerdown", // powerup|powerdown
		parameter pma_cdr_refclk_refclk_select = "ref_iqclk0", // ref_iqclk0|ref_iqclk1|ref_iqclk2|ref_iqclk3|ref_iqclk4|ref_iqclk5|ref_iqclk6|ref_iqclk7|ref_iqclk8|ref_iqclk9|ref_iqclk10|ref_iqclk11|iqtxrxclk0|iqtxrxclk1|iqtxrxclk2|iqtxrxclk3|iqtxrxclk4|iqtxrxclk5|coreclk|fixed_clk|lvpecl|adj_pll_clk|power_down
		
		// parameters for twentynm_hssi_pma_channel_pll
		parameter cdr_pll_atb_select_control = "atb_off", // atb_off|atb_select_tp_1|atb_select_tp_2|atb_select_tp_3|atb_select_tp_4|atb_select_tp_5|atb_select_tp_6|atb_select_tp_7|atb_select_tp_8|atb_select_tp_9|atb_select_tp_10|atb_select_tp_11|atb_select_tp_12|atb_select_tp_13|atb_select_tp_14|atb_select_tp_15|atb_select_tp_16|atb_select_tp_17|atb_select_tp_18|atb_select_tp_19|atb_select_tp_20|atb_select_tp_21|atb_select_tp_22|atb_select_tp_23|atb_select_tp_24|atb_select_tp_25|atb_select_tp_26|atb_select_tp_27|atb_select_tp_28|atb_select_tp_29|atb_select_tp_30|atb_select_tp_31|atb_select_tp_32|atb_select_tp_33|atb_select_tp_34|atb_select_tp_35|atb_select_tp_36|atb_select_tp_37|atb_select_tp_38|atb_select_tp_39|atb_select_tp_40|atb_select_tp_41|atb_select_tp_42|atb_select_tp_43|atb_select_tp_44|atb_select_tp_45|atb_select_tp_46|atb_select_tp_47|atb_select_tp_48|atb_select_tp_49|atb_select_tp_50|atb_select_tp_51|atb_select_tp_52|atb_select_tp_53|atb_select_tp_54|atb_select_tp_55|atb_select_tp_56|atb_select_tp_57|atb_select_tp_58|atb_select_tp_59|atb_select_tp_60|atb_select_tp_61|atb_select_tp_62|atb_select_tp_63
		parameter cdr_pll_auto_reset_on = "auto_reset_on", // auto_reset_on|auto_reset_off
		parameter cdr_pll_bbpd_data_pattern_filter_select = "bbpd_data_pat_off", // bbpd_data_pat_off|bbpd_data_pat_1|bbpd_data_pat_2|bbpd_data_pat_3
		parameter cdr_pll_bw_sel = "low", // low|medium|high
		parameter cdr_pll_cal_vco_count_length = "sel_8b_count", // sel_8b_count|sel_12b_count
		parameter cdr_pll_cdr_odi_select = "sel_cdr", // sel_cdr|sel_odi
		parameter cdr_pll_cdr_phaselock_mode = "no_ignore_lock", // no_ignore_lock|ignore_lock
		parameter cdr_pll_cdr_powerdown_mode = "power_down", // power_down|power_up
		parameter cdr_pll_cgb_div = 1, // 1|2|4|8
		parameter cdr_pll_chgpmp_current_dn_pd = "cp_current_pd_dn_setting0", // cp_current_pd_dn_setting0|cp_current_pd_dn_setting1|cp_current_pd_dn_setting2|cp_current_pd_dn_setting3|cp_current_pd_dn_setting4
		parameter cdr_pll_chgpmp_current_dn_trim = "cp_current_trimming_dn_setting0", // cp_current_trimming_dn_setting0|cp_current_trimming_dn_setting1|cp_current_trimming_dn_setting2|cp_current_trimming_dn_setting3|cp_current_trimming_dn_setting4|cp_current_trimming_dn_setting5|cp_current_trimming_dn_setting6|cp_current_trimming_dn_setting7|cp_current_trimming_dn_setting8|cp_current_trimming_dn_setting9|cp_current_trimming_dn_setting10|cp_current_trimming_dn_setting11|cp_current_trimming_dn_setting12|cp_current_trimming_dn_setting13|cp_current_trimming_dn_setting14|cp_current_trimming_dn_setting15
		parameter cdr_pll_chgpmp_current_pd = "cp_current_pd_setting0", // cp_current_pd_setting0|cp_current_pd_setting1|cp_current_pd_setting2|cp_current_pd_setting3|cp_current_pd_setting4
		parameter cdr_pll_chgpmp_current_pfd = "cp_current_pfd_setting0", // cp_current_pfd_setting0|cp_current_pfd_setting1|cp_current_pfd_setting2|cp_current_pfd_setting3|cp_current_pfd_setting4
		parameter cdr_pll_chgpmp_current_up_pd = "cp_current_pd_up_setting0", // cp_current_pd_up_setting0|cp_current_pd_up_setting1|cp_current_pd_up_setting2|cp_current_pd_up_setting3|cp_current_pd_up_setting4
		parameter cdr_pll_chgpmp_current_up_trim = "cp_current_trimming_up_setting0", // cp_current_trimming_up_setting0|cp_current_trimming_up_setting1|cp_current_trimming_up_setting2|cp_current_trimming_up_setting3|cp_current_trimming_up_setting4|cp_current_trimming_up_setting5|cp_current_trimming_up_setting6|cp_current_trimming_up_setting7|cp_current_trimming_up_setting8|cp_current_trimming_up_setting9|cp_current_trimming_up_setting10|cp_current_trimming_up_setting11|cp_current_trimming_up_setting12|cp_current_trimming_up_setting13|cp_current_trimming_up_setting14|cp_current_trimming_up_setting15
		parameter cdr_pll_chgpmp_dn_pd_trim_double = "normal_dn_trim_current", // normal_dn_trim_current|double_dn_trim_current
		parameter cdr_pll_chgpmp_replicate = "false", // false|true
		parameter cdr_pll_chgpmp_testmode = "cp_test_disable", // cp_test_disable|cp_test_up|cp_test_dn|cp_tristate
		parameter cdr_pll_chgpmp_up_pd_trim_double = "normal_up_trim_current", // normal_up_trim_current|double_up_trim_current
		parameter cdr_pll_clklow_mux_select = "clklow_mux_cdr_fbclk", // clklow_mux_cdr_fbclk|clklow_mux_fpll_test1|clklow_mux_reserved_1|clklow_mux_rx_deser_pclk_test|clklow_mux_reserved_2|clklow_mux_reserved_3|clklow_mux_reserved_4|clklow_mux_dfe_test
		parameter cdr_pll_datarate = "0 bps", // 
		parameter cdr_pll_diag_loopback_enable = "false", // true|false
		parameter cdr_pll_disable_up_dn = "true", // true|false
		parameter cdr_pll_fb_select = "direct_fb", // iqtxrxclk_fb|direct_fb
		parameter cdr_pll_fref_clklow_div = 1, // 1|2|4|8
		parameter cdr_pll_fref_mux_select = "fref_mux_cdr_refclk", // fref_mux_cdr_refclk|fref_mux_fpll_test0|fref_mux_reserved_1|fref_mux_tx_ser_pclk_test|fref_mux_reserved_2|fref_mux_reserved_3|fref_mux_reserved_4|fref_mux_reserved_5
		parameter cdr_pll_gpon_lck2ref_control = "gpon_lck2ref_off", // gpon_lck2ref_off|gpon_lck2ref_on
		parameter cdr_pll_initial_settings = "false", // false|true
		parameter cdr_pll_iqclk_mux_sel = "power_down", // iqtxrxclk0|iqtxrxclk1|iqtxrxclk2|iqtxrxclk3|iqtxrxclk4|iqtxrxclk5|power_down
		parameter cdr_pll_is_cascaded_pll = "false", // true|false
		parameter cdr_pll_lck2ref_delay_control = "lck2ref_delay_off", // lck2ref_delay_off|lck2ref_delay_1|lck2ref_delay_2|lck2ref_delay_3|lck2ref_delay_4|lck2ref_delay_5|lck2ref_delay_6|lck2ref_delay_7
		parameter cdr_pll_lf_resistor_pd = "lf_pd_setting0", // lf_pd_setting0|lf_pd_setting1|lf_pd_setting2|lf_pd_setting3
		parameter cdr_pll_lf_resistor_pfd = "lf_pfd_setting0", // lf_pfd_setting0|lf_pfd_setting1|lf_pfd_setting2|lf_pfd_setting3
		parameter cdr_pll_lf_ripple_cap = "lf_no_ripple", // lf_no_ripple|lf_ripple_cap1
		parameter cdr_pll_loop_filter_bias_select = "lpflt_bias_off", // lpflt_bias_off|lpflt_bias_1|lpflt_bias_2|lpflt_bias_3|lpflt_bias_4|lpflt_bias_5|lpflt_bias_6|lpflt_bias_7
		parameter cdr_pll_loopback_mode = "loopback_disabled", // loopback_disabled|loopback_recovered_data|rx_refclk|rx_refclk_cdr_loopback|unused2|loopback_received_data|unused1
		parameter cdr_pll_lpd_counter = 5'b1,
		parameter cdr_pll_lpfd_counter = 5'b1,
		parameter cdr_pll_ltd_ltr_micro_controller_select = "ltd_ltr_pcs", // ltd_ltr_pcs|ltr_ucontroller|ltd_ucontroller
		parameter cdr_pll_m_counter = 16, // 0..255
		parameter cdr_pll_n_counter = 1, // 1|2|4|8
		parameter cdr_pll_n_counter_scratch = 6'b1,
		parameter cdr_pll_output_clock_frequency = "0 hz", // 
		parameter cdr_pll_pcie_gen = "non_pcie", // pcie_gen1_100mhzref|pcie_gen2_100mhzref|pcie_gen3_100mhzref|pcie_gen1_125mhzref|pcie_gen2_125mhzref|pcie_gen3_125mhzref|non_pcie
		parameter cdr_pll_pd_fastlock_mode = "false", // false|true
		parameter cdr_pll_pd_l_counter = 1, // 0|1|2|4|8|16
		parameter cdr_pll_pfd_l_counter = 1, // 0|1|2|4|8|16|100
		parameter cdr_pll_pma_width = 8, // 8|10|16|20|32|40|64
		parameter cdr_pll_primary_use = "cmu", // cmu|cdr
		parameter cdr_pll_prot_mode = "unused", // basic_rx|pcie_gen1_rx|pcie_gen2_rx|pcie_gen3_rx|pcie_gen4_rx|qpi_rx|unused|gpon_rx|sata_rx
		parameter cdr_pll_reference_clock_frequency = "0 hz", // 
		parameter cdr_pll_reverse_serial_loopback = "no_loopback", // no_loopback|loopback_data_no_posttap|loopback_data_with_posttap|loopback_data_0_1
		parameter cdr_pll_set_cdr_input_freq_range = 8'b0,
		parameter cdr_pll_set_cdr_v2i_enable = "true", // true|false
		parameter cdr_pll_set_cdr_vco_reset = "false", // true|false
		parameter cdr_pll_set_cdr_vco_speed = 5'b1,
		parameter cdr_pll_set_cdr_vco_speed_fix = 8'b0,
		parameter cdr_pll_set_cdr_vco_speed_pciegen3 = "cdr_vco_max_speedbin_pciegen3", // cdr_vco_min_speedbin_pciegen3|cdr_vco_max_speedbin_pciegen3
		parameter cdr_pll_sup_mode = "user_mode", // user_mode|engineering_mode
		parameter cdr_pll_tx_pll_prot_mode = "txpll_unused", // txpll_unused|txpll_enable_pcie|txpll_enable
		parameter cdr_pll_txpll_hclk_driver_enable = "false", // true|false
		parameter cdr_pll_uc_ro_cal = "uc_ro_cal_off", // uc_ro_cal_off|uc_ro_cal_on
		parameter cdr_pll_vco_freq = "0 hz", // 
		parameter cdr_pll_vco_overrange_voltage = "vco_overrange_off", // vco_overrange_off|vco_overrange_ref_1|vco_overrange_ref_2|vco_overrange_ref_3
		parameter cdr_pll_vco_underrange_voltage = "vco_underange_off", // vco_underange_off|vco_underange_ref_1|vco_underange_ref_2|vco_underange_ref_3
		
		// parameters for twentynm_hssi_pma_rx_buf
		parameter pma_rx_buf_bypass_eqz_stages_234 = "bypass_off", // bypass_off|byypass_stages_234
		parameter pma_rx_buf_datarate = "0 bps", // 
		parameter pma_rx_buf_diag_lp_en = "dlp_off", // dlp_off|dlp_on
		parameter pma_rx_buf_loopback_modes = "lpbk_disable", // lpbk_disable|pre_cdr|post_cdr
		parameter pma_rx_buf_pm_tx_rx_cvp_mode = "cvp_off", // cvp_off|cvp_on
		parameter pma_rx_buf_pm_tx_rx_pcie_gen = "non_pcie", // pcie_gen1_100mhzref|pcie_gen2_100mhzref|pcie_gen3_100mhzref|pcie_gen1_125mhzref|pcie_gen2_125mhzref|pcie_gen3_125mhzref|non_pcie
		parameter pma_rx_buf_pm_tx_rx_pcie_gen_bitwidth = "pcie_gen3_32b", // pcie_gen3_32b|pcie_gen3_16b
		parameter pma_rx_buf_prot_mode = "basic_rx", // basic_rx|pcie_gen1_rx|pcie_gen2_rx|pcie_gen3_rx|pcie_gen4_rx|qpi_rx|unused|gpon_rx|sata_rx
		parameter pma_rx_buf_qpi_enable = "non_qpi_mode", // non_qpi_mode|qpi_mode
		parameter pma_rx_buf_refclk_en = "enable", // disable|enable
		parameter pma_rx_buf_rx_refclk_divider = "bypass_divider", // bypass_divider|divide_by_2
		parameter pma_rx_buf_sup_mode = "user_mode", // user_mode|engineering_mode
		parameter pma_rx_buf_xrx_path_datarate = "0 bps", // 
		parameter pma_rx_buf_xrx_path_datawidth = 8'b0,
		parameter pma_rx_buf_xrx_path_pma_rx_divclk_hz = 32'b0,
		parameter pma_rx_buf_xrx_path_prot_mode = "unused", // basic_rx|pcie_gen1_rx|pcie_gen2_rx|pcie_gen3_rx|pcie_gen4_rx|qpi_rx|unused|gpon_rx|sata_rx
		parameter pma_rx_buf_xrx_path_sup_mode = "user_mode", // user_mode|engineering_mode
		parameter pma_rx_buf_xrx_path_uc_cal_enable = "rx_cal_off", // rx_cal_off|rx_cal_on
		
		// parameters for twentynm_hssi_pma_rx_deser
		parameter pma_rx_deser_bitslip_bypass = "bs_bypass_no", // bs_bypass_no|bs_bypass_yes
		parameter pma_rx_deser_clkdiv_source = "vco_bypass_normal", // vco_bypass_normal|clklow_to_clkdivrx|fref_to_clkdivrx
		parameter pma_rx_deser_clkdivrx_user_mode = "clkdivrx_user_disabled", // clkdivrx_user_disabled|clkdivrx_user_clkdiv|clkdivrx_user_clkdiv_div2|clkdivrx_user_div40|clkdivrx_user_div33|clkdivrx_user_div66
		parameter pma_rx_deser_datarate = "0 bps", // 
		parameter pma_rx_deser_deser_factor = 8, // 8|10|16|20|32|40|64
		parameter pma_rx_deser_force_clkdiv_for_testing = "normal_clkdiv", // normal_clkdiv|forced_0|forced_1
		parameter pma_rx_deser_pcie_gen = "non_pcie", // pcie_gen1_100mhzref|pcie_gen2_100mhzref|pcie_gen3_100mhzref|pcie_gen1_125mhzref|pcie_gen2_125mhzref|pcie_gen3_125mhzref|non_pcie
		parameter pma_rx_deser_pcie_gen_bitwidth = "pcie_gen3_32b", // pcie_gen3_32b|pcie_gen3_16b
		parameter pma_rx_deser_prot_mode = "basic_rx", // basic_rx|pcie_gen1_rx|pcie_gen2_rx|pcie_gen3_rx|pcie_gen4_rx|qpi_rx|unused|gpon_rx|sata_rx
		parameter pma_rx_deser_rst_n_adapt_odi = "no_rst_adapt_odi", // yes_rst_adapt_odi|no_rst_adapt_odi
		parameter pma_rx_deser_sdclk_enable = "false", // false|true
		parameter pma_rx_deser_sup_mode = "user_mode", // user_mode|engineering_mode
		
		// parameters for twentynm_hssi_pma_rx_dfe
		parameter pma_rx_dfe_datarate = "0 bps", // 
		parameter pma_rx_dfe_dft_en = "dft_disable", // dft_disable|dft_enalbe
		parameter pma_rx_dfe_pdb = "dfe_enable", // dfe_powerdown|dfe_reset|dfe_enable
		parameter pma_rx_dfe_pdb_fixedtap = "fixtap_dfe_powerdown", // fixtap_dfe_powerdown|fixtap_dfe_enable
		parameter pma_rx_dfe_pdb_floattap = "floattap_dfe_powerdown", // floattap_dfe_powerdown|floattap_dfe_enable
		parameter pma_rx_dfe_pdb_fxtap4t7 = "fxtap4t7_powerdown", // fxtap4t7_powerdown|fxtap4t7_enable
		parameter pma_rx_dfe_prot_mode = "basic_rx", // basic_rx|pcie_gen1_rx|pcie_gen2_rx|pcie_gen3_rx|pcie_gen4_rx|qpi_rx|unused|gpon_rx|sata_rx
		parameter pma_rx_dfe_sup_mode = "user_mode", // user_mode|engineering_mode
		
		// parameters for twentynm_hssi_pma_rx_odi
		parameter pma_rx_odi_datarate = "0 bps", // 
		parameter pma_rx_odi_prot_mode = "basic_rx", // basic_rx|pcie_gen1_rx|pcie_gen2_rx|pcie_gen3_rx|pcie_gen4_rx|qpi_rx|unused|gpon_rx|sata_rx
		parameter pma_rx_odi_step_ctrl_sel = "feedback_mode", // dprio_mode|feedback_mode|jm_mode
		parameter pma_rx_odi_sup_mode = "user_mode", // user_mode|engineering_mode
		
		// parameters for twentynm_hssi_pma_rx_sd
		parameter pma_rx_sd_prot_mode = "basic_rx", // basic_rx|pcie_gen1_rx|pcie_gen2_rx|pcie_gen3_rx|pcie_gen4_rx|qpi_rx|unused|gpon_rx|sata_rx
		parameter pma_rx_sd_sd_output_off = 1, // 0..28
		parameter pma_rx_sd_sd_output_on = 1, // 0..15
		parameter pma_rx_sd_sd_pdb = "sd_off", // sd_on|sd_off
		parameter pma_rx_sd_sup_mode = "user_mode", // user_mode|engineering_mode
		
		// parameters for twentynm_hssi_pma_tx_buf
		parameter pma_tx_buf_datarate = "0 bps", // 
		parameter pma_tx_buf_mcgb_location_for_pcie = 4'b0,
		parameter pma_tx_buf_prot_mode = "basic_tx", // unused|basic_tx|pcie_gen1_tx|pcie_gen2_tx|pcie_gen3_tx|pcie_gen4_tx|qpi_tx|gpon_tx|sata_tx
		parameter pma_tx_buf_rx_det = "mode_0", // mode_0|mode_1|mode_2|mode_3|mode_4|mode_5|mode_6|mode_7|mode_8|mode_9|mode_10|mode_11|mode_12|mode_13|mode_14|mode_15
		parameter pma_tx_buf_rx_det_output_sel = "rx_det_pcie_out", // rx_det_pcie_out|rx_det_qpi_out
		parameter pma_tx_buf_rx_det_pdb = "rx_det_off", // rx_det_off|rx_det_on
		parameter pma_tx_buf_sup_mode = "user_mode", // user_mode|engineering_mode
		parameter pma_tx_buf_user_fir_coeff_ctrl_sel = "ram_ctl", // ram_ctl|dynamic_ctl
		parameter pma_tx_buf_xtx_path_clock_divider_ratio = 4'b0,
		parameter pma_tx_buf_xtx_path_datarate = "0 bps", // 
		parameter pma_tx_buf_xtx_path_datawidth = 8'b0,
		parameter pma_tx_buf_xtx_path_pma_tx_divclk_hz = 32'b0,
		parameter pma_tx_buf_xtx_path_prot_mode = "basic_tx", // unused|basic_tx|pcie_gen1_tx|pcie_gen2_tx|pcie_gen3_tx|pcie_gen4_tx|qpi_tx|gpon_tx|sata_tx
		parameter pma_tx_buf_xtx_path_sup_mode = "user_mode", // user_mode|engineering_mode
		parameter pma_tx_buf_xtx_path_tx_pll_clk_hz = "0 hz", // 
		
		// parameters for twentynm_hssi_pma_tx_cgb
		parameter pma_cgb_bitslip_enable = "enable_bitslip", // disable_bitslip|enable_bitslip
		parameter pma_cgb_bonding_reset_enable = "allow_bonding_reset", // disallow_bonding_reset|allow_bonding_reset
		parameter pma_cgb_datarate = "0 bps", // 
		parameter pma_cgb_input_select_gen3 = "unused", // lcpll_bot|lcpll_top|fpll_bot|fpll_top|cdr_txpll_b|cdr_txpll_t|same_ch_txpll|lcpll_hs|hfclk_xn_up|hfclk_x6_dn|hfclk_xn_dn|hfclk_x6_up|unused
		parameter pma_cgb_input_select_x1 = "unused", // lcpll_bot|lcpll_top|fpll_bot|fpll_top|cdr_txpll_b|cdr_txpll_t|same_ch_txpll|lcpll_hs|hfclk_xn_up|hfclk_x6_dn|hfclk_xn_dn|hfclk_x6_up|unused
		parameter pma_cgb_input_select_xn = "unused", // sel_xn_up|sel_xn_dn|sel_x6_up|sel_x6_dn|sel_cgb_loc|unused
		parameter pma_cgb_pcie_gen3_bitwidth = "pciegen3_wide", // pciegen3_wide|pciegen3_narrow
		parameter pma_cgb_prot_mode = "basic_tx", // unused|basic_tx|pcie_gen1_tx|pcie_gen2_tx|pcie_gen3_tx|pcie_gen4_tx|qpi_tx|gpon_tx|sata_tx
		parameter pma_cgb_scratch0_x1_clock_src = "unused", // lcpll_bot|lcpll_top|fpll_bot|fpll_top|cdr_txpll_b|cdr_txpll_t|same_ch_txpll|lcpll_hs|hfclk_xn_up|hfclk_x6_dn|hfclk_xn_dn|hfclk_x6_up|unused
		parameter pma_cgb_scratch1_x1_clock_src = "unused", // lcpll_bot|lcpll_top|fpll_bot|fpll_top|cdr_txpll_b|cdr_txpll_t|same_ch_txpll|lcpll_hs|hfclk_xn_up|hfclk_x6_dn|hfclk_xn_dn|hfclk_x6_up|unused
		parameter pma_cgb_scratch2_x1_clock_src = "unused", // lcpll_bot|lcpll_top|fpll_bot|fpll_top|cdr_txpll_b|cdr_txpll_t|same_ch_txpll|lcpll_hs|hfclk_xn_up|hfclk_x6_dn|hfclk_xn_dn|hfclk_x6_up|unused
		parameter pma_cgb_scratch3_x1_clock_src = "unused", // lcpll_bot|lcpll_top|fpll_bot|fpll_top|cdr_txpll_b|cdr_txpll_t|same_ch_txpll|lcpll_hs|hfclk_xn_up|hfclk_x6_dn|hfclk_xn_dn|hfclk_x6_up|unused
		parameter pma_cgb_select_done_master_or_slave = "choose_slave_pcie_sw_done", // choose_master_pcie_sw_done|choose_slave_pcie_sw_done
		parameter pma_cgb_ser_mode = "eight_bit", // eight_bit|ten_bit|sixteen_bit|twenty_bit|thirty_two_bit|forty_bit|sixty_four_bit
		parameter pma_cgb_sup_mode = "user_mode", // user_mode|engineering_mode
		parameter pma_cgb_tx_ucontrol_en = "disable", // disable|enable
		parameter pma_cgb_x1_div_m_sel = "divbypass", // divbypass|divby2|divby4|divby8
		
		// parameters for twentynm_hssi_pma_tx_ser
		parameter pma_tx_ser_prot_mode = "basic_tx", // unused|basic_tx|pcie_gen1_tx|pcie_gen2_tx|pcie_gen3_tx|pcie_gen4_tx|qpi_tx|gpon_tx|sata_tx
		parameter pma_tx_ser_ser_clk_divtx_user_sel = "divtx_user_33", // divtx_user_2|divtx_user_40|divtx_user_33|divtx_user_66|divtx_user_1|divtx_user_off
		parameter pma_tx_ser_sup_mode = "user_mode" // user_mode|engineering_mode
	//PARAM_LIST_END
	)
	(
	//PORT_LIST_START
		input wire		in_adapt_start,
		input wire	[8:0]	in_avmmaddress,
		input wire		in_avmmclk,
		input wire		in_avmmread,
		input wire		in_avmmrstn,
		input wire		in_avmmwrite,
		input wire	[7:0]	in_avmmwritedata,
		input wire		in_clk_cdr_b,
		input wire		in_clk_cdr_t,
		input wire		in_clk_fpll_b,
		input wire		in_clk_fpll_t,
		input wire		in_clk_lc_b,
		input wire		in_clk_lc_hs,
		input wire		in_clk_lc_t,
		input wire		in_clkb_cdr_b,
		input wire		in_clkb_cdr_t,
		input wire		in_clkb_fpll_b,
		input wire		in_clkb_fpll_t,
		input wire		in_clkb_lc_b,
		input wire		in_clkb_lc_hs,
		input wire		in_clkb_lc_t,
		input wire		in_core_refclk_in,
		input wire	[5:0]	in_cpulse_x6_dn_bus,
		input wire	[5:0]	in_cpulse_x6_up_bus,
		input wire	[5:0]	in_cpulse_xn_dn_bus,
		input wire	[5:0]	in_cpulse_xn_up_bus,
		input wire		in_early_eios,
		input wire	[5:0]	in_eye_monitor,
		input wire	[1:0]	in_fpll_ppm_clk_in,
		input wire	[17:0]	in_i_coeff,
		input wire	[2:0]	in_i_rxpreset,
		input wire	[5:0]	in_iqtxrxclk,
		input wire		in_ltd_b,
		input wire		in_ltr,
		input wire	[1:0]	in_pcie_sw,
		input wire	[1:0]	in_pcie_sw_done_master_in,
		input wire		in_pma_atpg_los_en_n_in,
		input wire	[4:0]	in_pma_reserved_out,
		input wire		in_ppm_lock,
		input wire	[11:0]	in_ref_iqclk,
		input wire		in_rs_lpbk_b,
		input wire	[5:0]	in_rx50_buf_in,
		input wire		in_rx_bitslip,
		input wire		in_rx_n,
		input wire		in_rx_p,
		input wire		in_rx_pma_rstb,
		input wire		in_rx_qpi_pulldn,
		input wire		in_scan_mode_n,
		input wire		in_scan_shift_n,
		input wire	[8:0]	in_tx50_buf_in,
		input wire		in_tx_bitslip,
		input wire		in_tx_bonding_rstb,
		input wire	[63:0]	in_tx_data,
		input wire		in_tx_det_rx,
		input wire		in_tx_elec_idle,
		input wire		in_tx_pma_rstb,
		input wire		in_tx_qpi_pulldn,
		input wire		in_tx_qpi_pullup,
		output wire	[7:0]	out_avmmreaddata_cdr_pll,
		output wire	[7:0]	out_avmmreaddata_pma_adapt,
		output wire	[7:0]	out_avmmreaddata_pma_cdr_refclk,
		output wire	[7:0]	out_avmmreaddata_pma_cgb,
		output wire	[7:0]	out_avmmreaddata_pma_rx_buf,
		output wire	[7:0]	out_avmmreaddata_pma_rx_deser,
		output wire	[7:0]	out_avmmreaddata_pma_rx_dfe,
		output wire	[7:0]	out_avmmreaddata_pma_rx_odi,
		output wire	[7:0]	out_avmmreaddata_pma_rx_sd,
		output wire	[7:0]	out_avmmreaddata_pma_tx_buf,
		output wire	[7:0]	out_avmmreaddata_pma_tx_ser,
		output wire		out_blockselect_cdr_pll,
		output wire		out_blockselect_pma_adapt,
		output wire		out_blockselect_pma_cdr_refclk,
		output wire		out_blockselect_pma_cgb,
		output wire		out_blockselect_pma_rx_buf,
		output wire		out_blockselect_pma_rx_deser,
		output wire		out_blockselect_pma_rx_dfe,
		output wire		out_blockselect_pma_rx_odi,
		output wire		out_blockselect_pma_rx_sd,
		output wire		out_blockselect_pma_tx_buf,
		output wire		out_blockselect_pma_tx_ser,
		output wire		out_clk0_pfd,
		output wire		out_clk180_pfd,
		output wire		out_clk_divrx_iqtxrx,
		output wire		out_clk_divtx_iqtxrx,
		output wire		out_clkdiv_rx,
		output wire		out_clkdiv_rx_user,
		output wire		out_clkdiv_tx,
		output wire		out_clkdiv_tx_user,
		output wire		out_clklow,
		output wire		out_fref,
		output wire		out_iqtxrxclk_out0,
		output wire		out_iqtxrxclk_out1,
		output wire		out_jtaglpxn,
		output wire		out_jtaglpxp,
		output wire	[1:0]	out_pcie_sw_done,
		output wire	[1:0]	out_pcie_sw_master,
		output wire		out_pfdmode_lock,
		output wire		out_rx_detect_valid,
		output wire		out_rx_found,
		output wire	[63:0]	out_rxdata,
		output wire		out_rxpll_lock,
		output wire		out_sd,
		output wire		out_tx_n,
		output wire		out_tx_p
	//PORT_LIST_END
	);
	//wire declarations
	
	// wires for module twentynm_hssi_pma_rx_dfe
	wire	[7:0]	w_pma_rx_dfe_avmmreaddata;
	wire		w_pma_rx_dfe_blockselect;
	wire		w_pma_rx_dfe_clk0_bbpd;
	wire		w_pma_rx_dfe_clk180_bbpd;
	wire		w_pma_rx_dfe_clk270_bbpd;
	wire		w_pma_rx_dfe_clk90_bbpd;
	wire		w_pma_rx_dfe_deven;
	wire		w_pma_rx_dfe_devenb;
	wire	[7:0]	w_pma_rx_dfe_dfe_oc_tstmx;
	wire		w_pma_rx_dfe_dodd;
	wire		w_pma_rx_dfe_doddb;
	wire		w_pma_rx_dfe_edge270;
	wire		w_pma_rx_dfe_edge270b;
	wire		w_pma_rx_dfe_edge90;
	wire		w_pma_rx_dfe_edge90b;
	wire		w_pma_rx_dfe_err_ev;
	wire		w_pma_rx_dfe_err_evb;
	wire		w_pma_rx_dfe_err_od;
	wire		w_pma_rx_dfe_err_odb;
	wire		w_pma_rx_dfe_spec_vrefh;
	wire		w_pma_rx_dfe_spec_vrefl;
	
	// wires for module twentynm_hssi_pma_tx_ser
	wire	[7:0]	w_pma_tx_ser_avmmreaddata;
	wire		w_pma_tx_ser_blockselect;
	wire		w_pma_tx_ser_ckdrvn;
	wire		w_pma_tx_ser_ckdrvp;
	wire		w_pma_tx_ser_clk_divtx;
	wire		w_pma_tx_ser_clk_divtx_user;
	wire		w_pma_tx_ser_oe;
	wire		w_pma_tx_ser_oeb;
	wire		w_pma_tx_ser_oo;
	wire		w_pma_tx_ser_oob;
	
	// wires for module twentynm_hssi_pma_tx_buf
	wire	[2:0]	w_pma_tx_buf_atbsel;
	wire	[7:0]	w_pma_tx_buf_avmmreaddata;
	wire		w_pma_tx_buf_blockselect;
	wire		w_pma_tx_buf_ckn;
	wire		w_pma_tx_buf_ckp;
	wire		w_pma_tx_buf_dcd_out1;
	wire		w_pma_tx_buf_dcd_out2;
	wire		w_pma_tx_buf_dcd_out_ready;
	wire	[1:0]	w_pma_tx_buf_detect_on;
	wire		w_pma_tx_buf_lbvon;
	wire		w_pma_tx_buf_lbvop;
	wire		w_pma_tx_buf_rx_detect_valid;
	wire		w_pma_tx_buf_rx_found;
	wire		w_pma_tx_buf_rx_found_pcie_spl_test;
	wire		w_pma_tx_buf_sel_vreg;
	wire		w_pma_tx_buf_spl_clk_test;
	wire	[7:0]	w_pma_tx_buf_tx_dftout;
	wire		w_pma_tx_buf_vlptxn;
	wire		w_pma_tx_buf_vlptxp;
	wire		w_pma_tx_buf_von;
	wire		w_pma_tx_buf_vop;
	
	// wires for module twentynm_hssi_pma_tx_cgb
	wire	[7:0]	w_pma_cgb_avmmreaddata;
	wire		w_pma_cgb_bitslipstate;
	wire		w_pma_cgb_blockselect;
	wire	[5:0]	w_pma_cgb_cpulse_out_bus;
	wire		w_pma_cgb_div2;
	wire		w_pma_cgb_div4;
	wire		w_pma_cgb_div5;
	wire		w_pma_cgb_hifreqclkn;
	wire		w_pma_cgb_hifreqclkp;
	wire	[1:0]	w_pma_cgb_pcie_sw_done;
	wire	[1:0]	w_pma_cgb_pcie_sw_master;
	wire		w_pma_cgb_rstb;
	
	// wires for module twentynm_hssi_pma_rx_sd
	wire	[7:0]	w_pma_rx_sd_avmmreaddata;
	wire		w_pma_rx_sd_blockselect;
	wire		w_pma_rx_sd_sd;
	
	// wires for module twentynm_hssi_pma_rx_deser
	wire		w_pma_rx_deser_adapt_clk;
	wire	[7:0]	w_pma_rx_deser_avmmreaddata;
	wire		w_pma_rx_deser_blockselect;
	wire		w_pma_rx_deser_clkdiv;
	wire		w_pma_rx_deser_clkdiv_user;
	wire		w_pma_rx_deser_clkdivrx_rx;
	wire	[63:0]	w_pma_rx_deser_data;
	wire	[63:0]	w_pma_rx_deser_dout;
	wire	[63:0]	w_pma_rx_deser_error_deser;
	wire	[63:0]	w_pma_rx_deser_odi_dout;
	wire	[1:0]	w_pma_rx_deser_pcie_sw_ret;
	wire	[7:0]	w_pma_rx_deser_tstmx_deser;
	
	// wires for module twentynm_hssi_pma_cdr_refclk_select_mux
	wire	[7:0]	w_pma_cdr_refclk_avmmreaddata;
	wire		w_pma_cdr_refclk_blockselect;
	wire		w_pma_cdr_refclk_refclk;
	wire		w_pma_cdr_refclk_rx_det_clk;
	
	// wires for module twentynm_hssi_pma_adaptation
	wire	[7:0]	w_pma_adapt_avmmreaddata;
	wire		w_pma_adapt_blockselect;
	wire	[27:0]	w_pma_adapt_ctle_acgain_4s;
	wire	[14:0]	w_pma_adapt_ctle_eqz_1s_sel;
	wire	[6:0]	w_pma_adapt_ctle_lfeq_fb_sel;
	wire		w_pma_adapt_dfe_adapt_en;
	wire		w_pma_adapt_dfe_adp_clk;
	wire	[5:0]	w_pma_adapt_dfe_fltap1;
	wire		w_pma_adapt_dfe_fltap1_sgn;
	wire	[5:0]	w_pma_adapt_dfe_fltap2;
	wire		w_pma_adapt_dfe_fltap2_sgn;
	wire	[5:0]	w_pma_adapt_dfe_fltap3;
	wire		w_pma_adapt_dfe_fltap3_sgn;
	wire	[5:0]	w_pma_adapt_dfe_fltap4;
	wire		w_pma_adapt_dfe_fltap4_sgn;
	wire		w_pma_adapt_dfe_fltap_bypdeser;
	wire	[5:0]	w_pma_adapt_dfe_fltap_position;
	wire	[6:0]	w_pma_adapt_dfe_fxtap1;
	wire	[6:0]	w_pma_adapt_dfe_fxtap2;
	wire		w_pma_adapt_dfe_fxtap2_sgn;
	wire	[6:0]	w_pma_adapt_dfe_fxtap3;
	wire		w_pma_adapt_dfe_fxtap3_sgn;
	wire	[5:0]	w_pma_adapt_dfe_fxtap4;
	wire		w_pma_adapt_dfe_fxtap4_sgn;
	wire	[5:0]	w_pma_adapt_dfe_fxtap5;
	wire		w_pma_adapt_dfe_fxtap5_sgn;
	wire	[4:0]	w_pma_adapt_dfe_fxtap6;
	wire		w_pma_adapt_dfe_fxtap6_sgn;
	wire	[4:0]	w_pma_adapt_dfe_fxtap7;
	wire		w_pma_adapt_dfe_fxtap7_sgn;
	wire		w_pma_adapt_dfe_spec_disable;
	wire		w_pma_adapt_dfe_spec_sign_sel;
	wire		w_pma_adapt_dfe_vref_sign_sel;
	wire	[4:0]	w_pma_adapt_odi_vref;
	wire	[6:0]	w_pma_adapt_vga_sel;
	wire	[4:0]	w_pma_adapt_vref_sel;
	
	// wires for module twentynm_hssi_pma_rx_odi
	wire	[7:0]	w_pma_rx_odi_avmmreaddata;
	wire		w_pma_rx_odi_blockselect;
	wire		w_pma_rx_odi_clk0_eye;
	wire		w_pma_rx_odi_clk0_eye_lb;
	wire		w_pma_rx_odi_clk180_eye;
	wire		w_pma_rx_odi_clk180_eye_lb;
	wire		w_pma_rx_odi_de_eye;
	wire		w_pma_rx_odi_deb_eye;
	wire		w_pma_rx_odi_do_eye;
	wire		w_pma_rx_odi_dob_eye;
	wire		w_pma_rx_odi_odi_en;
	wire	[1:0]	w_pma_rx_odi_odi_oc_tstmx;
	
	// wires for module twentynm_hssi_pma_channel_pll
	wire	[7:0]	w_cdr_pll_avmmreaddata;
	wire		w_cdr_pll_blockselect;
	wire		w_cdr_pll_cdr_cnt_done;
	wire	[11:0]	w_cdr_pll_cdr_refclk_cal_out;
	wire	[11:0]	w_cdr_pll_cdr_vco_cal_out;
	wire		w_cdr_pll_clk0_des;
	wire		w_cdr_pll_clk0_odi;
	wire		w_cdr_pll_clk0_pd;
	wire		w_cdr_pll_clk0_pfd;
	wire		w_cdr_pll_clk180_des;
	wire		w_cdr_pll_clk180_odi;
	wire		w_cdr_pll_clk180_pd;
	wire		w_cdr_pll_clk180_pfd;
	wire		w_cdr_pll_clk270_odi;
	wire		w_cdr_pll_clk270_pd;
	wire		w_cdr_pll_clk90_odi;
	wire		w_cdr_pll_clk90_pd;
	wire		w_cdr_pll_clklow;
	wire		w_cdr_pll_deven_des;
	wire		w_cdr_pll_devenb_des;
	wire		w_cdr_pll_dodd_des;
	wire		w_cdr_pll_doddb_des;
	wire		w_cdr_pll_error_even_des;
	wire		w_cdr_pll_error_evenb_des;
	wire		w_cdr_pll_error_odd_des;
	wire		w_cdr_pll_error_oddb_des;
	wire		w_cdr_pll_fref;
	wire		w_cdr_pll_overrange;
	wire		w_cdr_pll_pfdmode_lock;
	wire		w_cdr_pll_rlpbkdn;
	wire		w_cdr_pll_rlpbkdp;
	wire		w_cdr_pll_rlpbkn;
	wire		w_cdr_pll_rlpbkp;
	wire		w_cdr_pll_rxpll_lock;
	wire		w_cdr_pll_tx_rlpbk;
	wire		w_cdr_pll_underrange;
	
	// wires for module twentynm_hssi_pma_rx_buf
	wire	[7:0]	w_pma_rx_buf_avmmreaddata;
	wire		w_pma_rx_buf_blockselect;
	wire		w_pma_rx_buf_inn;
	wire		w_pma_rx_buf_inp;
	wire		w_pma_rx_buf_outn;
	wire		w_pma_rx_buf_outp;
	wire		w_pma_rx_buf_pull_dn;
	wire		w_pma_rx_buf_rdlpbkn;
	wire		w_pma_rx_buf_rdlpbkp;
	
	
	generate
		
		//module instantiations
		
		// instantiating twentynm_hssi_pma_adaptation
		if ((xcvr_native_mode == "mode_rx_only") || (xcvr_native_mode == "mode_duplex")) begin:gen_twentynm_hssi_pma_adaptation
			twentynm_hssi_pma_adaptation #(
				.adapt_mode(pma_adapt_adapt_mode),
				.adp_1s_ctle_bypass(pma_adapt_adp_1s_ctle_bypass),
				.adp_4s_ctle_bypass(pma_adapt_adp_4s_ctle_bypass),
				.adp_ctle_adapt_cycle_window(pma_adapt_adp_ctle_adapt_cycle_window),
				.adp_ctle_en(pma_adapt_adp_ctle_en),
				.adp_dfe_fltap_bypass(pma_adapt_adp_dfe_fltap_bypass),
				.adp_dfe_fltap_en(pma_adapt_adp_dfe_fltap_en),
				.adp_dfe_fxtap_bypass(pma_adapt_adp_dfe_fxtap_bypass),
				.adp_dfe_fxtap_en(pma_adapt_adp_dfe_fxtap_en),
				.adp_dfe_fxtap_hold_en(pma_adapt_adp_dfe_fxtap_hold_en),
				.adp_dfe_mode(pma_adapt_adp_dfe_mode),
				.adp_mode(pma_adapt_adp_mode),
				.adp_onetime_dfe(pma_adapt_adp_onetime_dfe),
				.adp_vga_bypass(pma_adapt_adp_vga_bypass),
				.adp_vga_en(pma_adapt_adp_vga_en),
				.adp_vref_bypass(pma_adapt_adp_vref_bypass),
				.adp_vref_en(pma_adapt_adp_vref_en),
				.datarate(pma_adapt_datarate),
				.initial_settings("true"),       //PARAM_HIDE
				.odi_dfe_spec_en(pma_adapt_odi_dfe_spec_en),
				.optimal("false"),       //PARAM_HIDE
				.prot_mode(pma_adapt_prot_mode),
				.silicon_rev( "20nm5" ),       //PARAM_HIDE
				.sup_mode(pma_adapt_sup_mode)
			) inst_twentynm_hssi_pma_adaptation (
				// OUTPUTS
				.avmmreaddata(w_pma_adapt_avmmreaddata),
				.blockselect(w_pma_adapt_blockselect),
				.ctle_acgain_4s(w_pma_adapt_ctle_acgain_4s),
				.ctle_eqz_1s_sel(w_pma_adapt_ctle_eqz_1s_sel),
				.ctle_lfeq_fb_sel(w_pma_adapt_ctle_lfeq_fb_sel),
				.dfe_adapt_en(w_pma_adapt_dfe_adapt_en),
				.dfe_adp_clk(w_pma_adapt_dfe_adp_clk),
				.dfe_fltap1(w_pma_adapt_dfe_fltap1),
				.dfe_fltap1_sgn(w_pma_adapt_dfe_fltap1_sgn),
				.dfe_fltap2(w_pma_adapt_dfe_fltap2),
				.dfe_fltap2_sgn(w_pma_adapt_dfe_fltap2_sgn),
				.dfe_fltap3(w_pma_adapt_dfe_fltap3),
				.dfe_fltap3_sgn(w_pma_adapt_dfe_fltap3_sgn),
				.dfe_fltap4(w_pma_adapt_dfe_fltap4),
				.dfe_fltap4_sgn(w_pma_adapt_dfe_fltap4_sgn),
				.dfe_fltap_bypdeser(w_pma_adapt_dfe_fltap_bypdeser),
				.dfe_fltap_position(w_pma_adapt_dfe_fltap_position),
				.dfe_fxtap1(w_pma_adapt_dfe_fxtap1),
				.dfe_fxtap2(w_pma_adapt_dfe_fxtap2),
				.dfe_fxtap2_sgn(w_pma_adapt_dfe_fxtap2_sgn),
				.dfe_fxtap3(w_pma_adapt_dfe_fxtap3),
				.dfe_fxtap3_sgn(w_pma_adapt_dfe_fxtap3_sgn),
				.dfe_fxtap4(w_pma_adapt_dfe_fxtap4),
				.dfe_fxtap4_sgn(w_pma_adapt_dfe_fxtap4_sgn),
				.dfe_fxtap5(w_pma_adapt_dfe_fxtap5),
				.dfe_fxtap5_sgn(w_pma_adapt_dfe_fxtap5_sgn),
				.dfe_fxtap6(w_pma_adapt_dfe_fxtap6),
				.dfe_fxtap6_sgn(w_pma_adapt_dfe_fxtap6_sgn),
				.dfe_fxtap7(w_pma_adapt_dfe_fxtap7),
				.dfe_fxtap7_sgn(w_pma_adapt_dfe_fxtap7_sgn),
				.dfe_spec_disable(w_pma_adapt_dfe_spec_disable),
				.dfe_spec_sign_sel(w_pma_adapt_dfe_spec_sign_sel),
				.dfe_vref_sign_sel(w_pma_adapt_dfe_vref_sign_sel),
				.odi_vref(w_pma_adapt_odi_vref),
				.vga_sel(w_pma_adapt_vga_sel),
				.vref_sel(w_pma_adapt_vref_sel),
				// INPUTS
				.adapt_reset(in_pma_reserved_out[4]),
				.adapt_start(in_adapt_start),
				.avmmaddress({in_avmmaddress[8], in_avmmaddress[7], in_avmmaddress[6], in_avmmaddress[5], in_avmmaddress[4], in_avmmaddress[3], in_avmmaddress[2], in_avmmaddress[1], in_avmmaddress[0]}),
				.avmmclk(in_avmmclk),
				.avmmread(in_avmmread),
				.avmmrstn(in_avmmrstn),
				.avmmwrite(in_avmmwrite),
				.avmmwritedata({in_avmmwritedata[7], in_avmmwritedata[6], in_avmmwritedata[5], in_avmmwritedata[4], in_avmmwritedata[3], in_avmmwritedata[2], in_avmmwritedata[1], in_avmmwritedata[0]}),
				.deser_clk(w_pma_rx_deser_adapt_clk),
				.deser_data({w_pma_rx_deser_data[63], w_pma_rx_deser_data[62], w_pma_rx_deser_data[61], w_pma_rx_deser_data[60], w_pma_rx_deser_data[59], w_pma_rx_deser_data[58], w_pma_rx_deser_data[57], w_pma_rx_deser_data[56], w_pma_rx_deser_data[55], w_pma_rx_deser_data[54], w_pma_rx_deser_data[53], w_pma_rx_deser_data[52], w_pma_rx_deser_data[51], w_pma_rx_deser_data[50], w_pma_rx_deser_data[49], w_pma_rx_deser_data[48], w_pma_rx_deser_data[47], w_pma_rx_deser_data[46], w_pma_rx_deser_data[45], w_pma_rx_deser_data[44], w_pma_rx_deser_data[43], w_pma_rx_deser_data[42], w_pma_rx_deser_data[41], w_pma_rx_deser_data[40], w_pma_rx_deser_data[39], w_pma_rx_deser_data[38], w_pma_rx_deser_data[37], w_pma_rx_deser_data[36], w_pma_rx_deser_data[35], w_pma_rx_deser_data[34], w_pma_rx_deser_data[33], w_pma_rx_deser_data[32], w_pma_rx_deser_data[31], w_pma_rx_deser_data[30], w_pma_rx_deser_data[29], w_pma_rx_deser_data[28], w_pma_rx_deser_data[27], w_pma_rx_deser_data[26], w_pma_rx_deser_data[25], w_pma_rx_deser_data[24], w_pma_rx_deser_data[23], w_pma_rx_deser_data[22], w_pma_rx_deser_data[21], w_pma_rx_deser_data[20], w_pma_rx_deser_data[19], w_pma_rx_deser_data[18], w_pma_rx_deser_data[17], w_pma_rx_deser_data[16], w_pma_rx_deser_data[15], w_pma_rx_deser_data[14], w_pma_rx_deser_data[13], w_pma_rx_deser_data[12], w_pma_rx_deser_data[11], w_pma_rx_deser_data[10], w_pma_rx_deser_data[9], w_pma_rx_deser_data[8], w_pma_rx_deser_data[7], w_pma_rx_deser_data[6], w_pma_rx_deser_data[5], w_pma_rx_deser_data[4], w_pma_rx_deser_data[3], w_pma_rx_deser_data[2], w_pma_rx_deser_data[1], w_pma_rx_deser_data[0]}),
				.deser_error({w_pma_rx_deser_error_deser[63], w_pma_rx_deser_error_deser[62], w_pma_rx_deser_error_deser[61], w_pma_rx_deser_error_deser[60], w_pma_rx_deser_error_deser[59], w_pma_rx_deser_error_deser[58], w_pma_rx_deser_error_deser[57], w_pma_rx_deser_error_deser[56], w_pma_rx_deser_error_deser[55], w_pma_rx_deser_error_deser[54], w_pma_rx_deser_error_deser[53], w_pma_rx_deser_error_deser[52], w_pma_rx_deser_error_deser[51], w_pma_rx_deser_error_deser[50], w_pma_rx_deser_error_deser[49], w_pma_rx_deser_error_deser[48], w_pma_rx_deser_error_deser[47], w_pma_rx_deser_error_deser[46], w_pma_rx_deser_error_deser[45], w_pma_rx_deser_error_deser[44], w_pma_rx_deser_error_deser[43], w_pma_rx_deser_error_deser[42], w_pma_rx_deser_error_deser[41], w_pma_rx_deser_error_deser[40], w_pma_rx_deser_error_deser[39], w_pma_rx_deser_error_deser[38], w_pma_rx_deser_error_deser[37], w_pma_rx_deser_error_deser[36], w_pma_rx_deser_error_deser[35], w_pma_rx_deser_error_deser[34], w_pma_rx_deser_error_deser[33], w_pma_rx_deser_error_deser[32], w_pma_rx_deser_error_deser[31], w_pma_rx_deser_error_deser[30], w_pma_rx_deser_error_deser[29], w_pma_rx_deser_error_deser[28], w_pma_rx_deser_error_deser[27], w_pma_rx_deser_error_deser[26], w_pma_rx_deser_error_deser[25], w_pma_rx_deser_error_deser[24], w_pma_rx_deser_error_deser[23], w_pma_rx_deser_error_deser[22], w_pma_rx_deser_error_deser[21], w_pma_rx_deser_error_deser[20], w_pma_rx_deser_error_deser[19], w_pma_rx_deser_error_deser[18], w_pma_rx_deser_error_deser[17], w_pma_rx_deser_error_deser[16], w_pma_rx_deser_error_deser[15], w_pma_rx_deser_error_deser[14], w_pma_rx_deser_error_deser[13], w_pma_rx_deser_error_deser[12], w_pma_rx_deser_error_deser[11], w_pma_rx_deser_error_deser[10], w_pma_rx_deser_error_deser[9], w_pma_rx_deser_error_deser[8], w_pma_rx_deser_error_deser[7], w_pma_rx_deser_error_deser[6], w_pma_rx_deser_error_deser[5], w_pma_rx_deser_error_deser[4], w_pma_rx_deser_error_deser[3], w_pma_rx_deser_error_deser[2], w_pma_rx_deser_error_deser[1], w_pma_rx_deser_error_deser[0]}),
				.deser_odi({w_pma_rx_deser_odi_dout[63], w_pma_rx_deser_odi_dout[62], w_pma_rx_deser_odi_dout[61], w_pma_rx_deser_odi_dout[60], w_pma_rx_deser_odi_dout[59], w_pma_rx_deser_odi_dout[58], w_pma_rx_deser_odi_dout[57], w_pma_rx_deser_odi_dout[56], w_pma_rx_deser_odi_dout[55], w_pma_rx_deser_odi_dout[54], w_pma_rx_deser_odi_dout[53], w_pma_rx_deser_odi_dout[52], w_pma_rx_deser_odi_dout[51], w_pma_rx_deser_odi_dout[50], w_pma_rx_deser_odi_dout[49], w_pma_rx_deser_odi_dout[48], w_pma_rx_deser_odi_dout[47], w_pma_rx_deser_odi_dout[46], w_pma_rx_deser_odi_dout[45], w_pma_rx_deser_odi_dout[44], w_pma_rx_deser_odi_dout[43], w_pma_rx_deser_odi_dout[42], w_pma_rx_deser_odi_dout[41], w_pma_rx_deser_odi_dout[40], w_pma_rx_deser_odi_dout[39], w_pma_rx_deser_odi_dout[38], w_pma_rx_deser_odi_dout[37], w_pma_rx_deser_odi_dout[36], w_pma_rx_deser_odi_dout[35], w_pma_rx_deser_odi_dout[34], w_pma_rx_deser_odi_dout[33], w_pma_rx_deser_odi_dout[32], w_pma_rx_deser_odi_dout[31], w_pma_rx_deser_odi_dout[30], w_pma_rx_deser_odi_dout[29], w_pma_rx_deser_odi_dout[28], w_pma_rx_deser_odi_dout[27], w_pma_rx_deser_odi_dout[26], w_pma_rx_deser_odi_dout[25], w_pma_rx_deser_odi_dout[24], w_pma_rx_deser_odi_dout[23], w_pma_rx_deser_odi_dout[22], w_pma_rx_deser_odi_dout[21], w_pma_rx_deser_odi_dout[20], w_pma_rx_deser_odi_dout[19], w_pma_rx_deser_odi_dout[18], w_pma_rx_deser_odi_dout[17], w_pma_rx_deser_odi_dout[16], w_pma_rx_deser_odi_dout[15], w_pma_rx_deser_odi_dout[14], w_pma_rx_deser_odi_dout[13], w_pma_rx_deser_odi_dout[12], w_pma_rx_deser_odi_dout[11], w_pma_rx_deser_odi_dout[10], w_pma_rx_deser_odi_dout[9], w_pma_rx_deser_odi_dout[8], w_pma_rx_deser_odi_dout[7], w_pma_rx_deser_odi_dout[6], w_pma_rx_deser_odi_dout[5], w_pma_rx_deser_odi_dout[4], w_pma_rx_deser_odi_dout[3], w_pma_rx_deser_odi_dout[2], w_pma_rx_deser_odi_dout[1], w_pma_rx_deser_odi_dout[0]}),
				.deser_odi_clk(1'b0),
				.global_pipe_se(in_pma_atpg_los_en_n_in),
				.i_rxpreset({in_i_rxpreset[2], in_i_rxpreset[1], in_i_rxpreset[0]}),
				.rx_pllfreqlock(w_cdr_pll_rxpll_lock),
				.scan_clk(in_core_refclk_in),
				.scan_in({in_pma_reserved_out[3], in_pma_reserved_out[2], in_pma_reserved_out[1], in_pma_reserved_out[0], in_eye_monitor[5], in_eye_monitor[4], in_eye_monitor[3], in_eye_monitor[2], in_eye_monitor[1], in_eye_monitor[0]}),
				.test_mode(in_scan_mode_n),
				.test_se(in_scan_shift_n),
				
				// UNUSED
				.radp_ctle_hold_en(),
				.radp_ctle_patt_en(),
				.radp_ctle_preset_sel(),
				.radp_enable_max_lfeq_scale(),
				.radp_lfeq_hold_en(),
				.radp_vga_polarity(),
				.scan_out(),
				.status_bus()
			);
		end // if generate
		else begin
				assign w_pma_adapt_avmmreaddata[7:0] = 8'b0;
				assign w_pma_adapt_blockselect = 1'b0;
				assign w_pma_adapt_ctle_acgain_4s[27:0] = 28'b0;
				assign w_pma_adapt_ctle_eqz_1s_sel[14:0] = 15'b0;
				assign w_pma_adapt_ctle_lfeq_fb_sel[6:0] = 7'b0;
				assign w_pma_adapt_dfe_adapt_en = 1'b0;
				assign w_pma_adapt_dfe_adp_clk = 1'b0;
				assign w_pma_adapt_dfe_fltap1[5:0] = 6'b0;
				assign w_pma_adapt_dfe_fltap1_sgn = 1'b0;
				assign w_pma_adapt_dfe_fltap2[5:0] = 6'b0;
				assign w_pma_adapt_dfe_fltap2_sgn = 1'b0;
				assign w_pma_adapt_dfe_fltap3[5:0] = 6'b0;
				assign w_pma_adapt_dfe_fltap3_sgn = 1'b0;
				assign w_pma_adapt_dfe_fltap4[5:0] = 6'b0;
				assign w_pma_adapt_dfe_fltap4_sgn = 1'b0;
				assign w_pma_adapt_dfe_fltap_bypdeser = 1'b0;
				assign w_pma_adapt_dfe_fltap_position[5:0] = 6'b0;
				assign w_pma_adapt_dfe_fxtap1[6:0] = 7'b0;
				assign w_pma_adapt_dfe_fxtap2[6:0] = 7'b0;
				assign w_pma_adapt_dfe_fxtap2_sgn = 1'b0;
				assign w_pma_adapt_dfe_fxtap3[6:0] = 7'b0;
				assign w_pma_adapt_dfe_fxtap3_sgn = 1'b0;
				assign w_pma_adapt_dfe_fxtap4[5:0] = 6'b0;
				assign w_pma_adapt_dfe_fxtap4_sgn = 1'b0;
				assign w_pma_adapt_dfe_fxtap5[5:0] = 6'b0;
				assign w_pma_adapt_dfe_fxtap5_sgn = 1'b0;
				assign w_pma_adapt_dfe_fxtap6[4:0] = 5'b0;
				assign w_pma_adapt_dfe_fxtap6_sgn = 1'b0;
				assign w_pma_adapt_dfe_fxtap7[4:0] = 5'b0;
				assign w_pma_adapt_dfe_fxtap7_sgn = 1'b0;
				assign w_pma_adapt_dfe_spec_disable = 1'b0;
				assign w_pma_adapt_dfe_spec_sign_sel = 1'b0;
				assign w_pma_adapt_dfe_vref_sign_sel = 1'b0;
				assign w_pma_adapt_odi_vref[4:0] = 5'b0;
				assign w_pma_adapt_vga_sel[6:0] = 7'b0;
				assign w_pma_adapt_vref_sel[4:0] = 5'b0;
		end // if not generate
		
		// instantiating twentynm_hssi_pma_cdr_refclk_select_mux
		if ((xcvr_native_mode == "mode_rx_only") || (xcvr_native_mode == "mode_duplex")) begin:gen_twentynm_hssi_pma_cdr_refclk_select_mux
			twentynm_hssi_pma_cdr_refclk_select_mux #(
				.inclk0_logical_to_physical_mapping(pma_cdr_refclk_inclk0_logical_to_physical_mapping),
				.inclk1_logical_to_physical_mapping(pma_cdr_refclk_inclk1_logical_to_physical_mapping),
				.inclk2_logical_to_physical_mapping(pma_cdr_refclk_inclk2_logical_to_physical_mapping),
				.inclk3_logical_to_physical_mapping(pma_cdr_refclk_inclk3_logical_to_physical_mapping),
				.inclk4_logical_to_physical_mapping(pma_cdr_refclk_inclk4_logical_to_physical_mapping),
				.powerdown_mode(pma_cdr_refclk_powerdown_mode),
				.refclk_select(pma_cdr_refclk_refclk_select),
				.silicon_rev( "20nm5" )       //PARAM_HIDE
			) inst_twentynm_hssi_pma_cdr_refclk_select_mux (
				// OUTPUTS
				.avmmreaddata(w_pma_cdr_refclk_avmmreaddata),
				.blockselect(w_pma_cdr_refclk_blockselect),
				.refclk(w_pma_cdr_refclk_refclk),
				.rx_det_clk(w_pma_cdr_refclk_rx_det_clk),
				// INPUTS
				.avmmaddress({in_avmmaddress[8], in_avmmaddress[7], in_avmmaddress[6], in_avmmaddress[5], in_avmmaddress[4], in_avmmaddress[3], in_avmmaddress[2], in_avmmaddress[1], in_avmmaddress[0]}),
				.avmmclk(in_avmmclk),
				.avmmread(in_avmmread),
				.avmmrstn(in_avmmrstn),
				.avmmwrite(in_avmmwrite),
				.avmmwritedata({in_avmmwritedata[7], in_avmmwritedata[6], in_avmmwritedata[5], in_avmmwritedata[4], in_avmmwritedata[3], in_avmmwritedata[2], in_avmmwritedata[1], in_avmmwritedata[0]}),
				.core_refclk(in_core_refclk_in),
				.iqtxrxclk({in_iqtxrxclk[5], in_iqtxrxclk[4], in_iqtxrxclk[3], in_iqtxrxclk[2], in_iqtxrxclk[1], in_iqtxrxclk[0]}),
				.ref_iqclk({in_ref_iqclk[11], in_ref_iqclk[10], in_ref_iqclk[9], in_ref_iqclk[8], in_ref_iqclk[7], in_ref_iqclk[6], in_ref_iqclk[5], in_ref_iqclk[4], in_ref_iqclk[3], in_ref_iqclk[2], in_ref_iqclk[1], in_ref_iqclk[0]})
			);
		end // if generate
		else begin
				assign w_pma_cdr_refclk_avmmreaddata[7:0] = 8'b0;
				assign w_pma_cdr_refclk_blockselect = 1'b0;
				assign w_pma_cdr_refclk_refclk = 1'b0;
				assign w_pma_cdr_refclk_rx_det_clk = 1'b0;
		end // if not generate
		
		// instantiating twentynm_hssi_pma_channel_pll
		if ((xcvr_native_mode == "mode_rx_only") || (xcvr_native_mode == "mode_duplex")) begin:gen_twentynm_hssi_pma_channel_pll
			twentynm_hssi_pma_channel_pll #(
				.atb_select_control(cdr_pll_atb_select_control),
				.auto_reset_on(cdr_pll_auto_reset_on),
				.bbpd_data_pattern_filter_select(cdr_pll_bbpd_data_pattern_filter_select),
				.bw_sel(cdr_pll_bw_sel),
				.cal_vco_count_length(cdr_pll_cal_vco_count_length),
				.cdr_odi_select(cdr_pll_cdr_odi_select),
				.cdr_phaselock_mode(cdr_pll_cdr_phaselock_mode),
				.cdr_powerdown_mode(cdr_pll_cdr_powerdown_mode),
				.cgb_div(cdr_pll_cgb_div),
				.chgpmp_current_dn_pd(cdr_pll_chgpmp_current_dn_pd),
				.chgpmp_current_dn_trim(cdr_pll_chgpmp_current_dn_trim),
				.chgpmp_current_pd(cdr_pll_chgpmp_current_pd),
				.chgpmp_current_pfd(cdr_pll_chgpmp_current_pfd),
				.chgpmp_current_up_pd(cdr_pll_chgpmp_current_up_pd),
				.chgpmp_current_up_trim(cdr_pll_chgpmp_current_up_trim),
				.chgpmp_dn_pd_trim_double(cdr_pll_chgpmp_dn_pd_trim_double),
				.chgpmp_replicate(cdr_pll_chgpmp_replicate),
				.chgpmp_testmode(cdr_pll_chgpmp_testmode),
				.chgpmp_up_pd_trim_double(cdr_pll_chgpmp_up_pd_trim_double),
				.clklow_mux_select(cdr_pll_clklow_mux_select),
				.datarate(cdr_pll_datarate),
				.diag_loopback_enable(cdr_pll_diag_loopback_enable),
				.disable_up_dn(cdr_pll_disable_up_dn),
				.fb_select(cdr_pll_fb_select),
				.fref_clklow_div(cdr_pll_fref_clklow_div),
				.fref_mux_select(cdr_pll_fref_mux_select),
				.gpon_lck2ref_control(cdr_pll_gpon_lck2ref_control),
				.initial_settings(cdr_pll_initial_settings),
				.iqclk_mux_sel(cdr_pll_iqclk_mux_sel),
				.is_cascaded_pll(cdr_pll_is_cascaded_pll),
				.lck2ref_delay_control(cdr_pll_lck2ref_delay_control),
				.lf_resistor_pd(cdr_pll_lf_resistor_pd),
				.lf_resistor_pfd(cdr_pll_lf_resistor_pfd),
				.lf_ripple_cap(cdr_pll_lf_ripple_cap),
				.loop_filter_bias_select(cdr_pll_loop_filter_bias_select),
				.loopback_mode(cdr_pll_loopback_mode),
				.lpd_counter(cdr_pll_lpd_counter),
				.lpfd_counter(cdr_pll_lpfd_counter),
				.ltd_ltr_micro_controller_select(cdr_pll_ltd_ltr_micro_controller_select),
				.m_counter(cdr_pll_m_counter),
				.n_counter(cdr_pll_n_counter),
				.n_counter_scratch(cdr_pll_n_counter_scratch),
				.optimal("false"),       //PARAM_HIDE
				.output_clock_frequency(cdr_pll_output_clock_frequency),
				.pcie_gen(cdr_pll_pcie_gen),
				.pd_fastlock_mode(cdr_pll_pd_fastlock_mode),
				.pd_l_counter(cdr_pll_pd_l_counter),
				.pfd_l_counter(cdr_pll_pfd_l_counter),
				.pma_width(cdr_pll_pma_width),
				.primary_use(cdr_pll_primary_use),
				.prot_mode(cdr_pll_prot_mode),
				.reference_clock_frequency(cdr_pll_reference_clock_frequency),
				.reverse_serial_loopback(cdr_pll_reverse_serial_loopback),
				.set_cdr_input_freq_range(cdr_pll_set_cdr_input_freq_range),
				.set_cdr_v2i_enable(cdr_pll_set_cdr_v2i_enable),
				.set_cdr_vco_reset(cdr_pll_set_cdr_vco_reset),
				.set_cdr_vco_speed(cdr_pll_set_cdr_vco_speed),
				.set_cdr_vco_speed_fix(cdr_pll_set_cdr_vco_speed_fix),
				.set_cdr_vco_speed_pciegen3(cdr_pll_set_cdr_vco_speed_pciegen3),
				.silicon_rev( "20nm5" ),       //PARAM_HIDE
				.sup_mode(cdr_pll_sup_mode),
				.tx_pll_prot_mode(cdr_pll_tx_pll_prot_mode),
				.txpll_hclk_driver_enable(cdr_pll_txpll_hclk_driver_enable),
				.uc_ro_cal(cdr_pll_uc_ro_cal),
				.vco_freq(cdr_pll_vco_freq),
				.vco_overrange_voltage(cdr_pll_vco_overrange_voltage),
				.vco_underrange_voltage(cdr_pll_vco_underrange_voltage)
			) inst_twentynm_hssi_pma_channel_pll (
				// OUTPUTS
				.avmmreaddata(w_cdr_pll_avmmreaddata),
				.blockselect(w_cdr_pll_blockselect),
				.cdr_cnt_done(w_cdr_pll_cdr_cnt_done),
				.cdr_refclk_cal_out(w_cdr_pll_cdr_refclk_cal_out),
				.cdr_vco_cal_out(w_cdr_pll_cdr_vco_cal_out),
				.clk0_des(w_cdr_pll_clk0_des),
				.clk0_odi(w_cdr_pll_clk0_odi),
				.clk0_pd(w_cdr_pll_clk0_pd),
				.clk0_pfd(w_cdr_pll_clk0_pfd),
				.clk180_des(w_cdr_pll_clk180_des),
				.clk180_odi(w_cdr_pll_clk180_odi),
				.clk180_pd(w_cdr_pll_clk180_pd),
				.clk180_pfd(w_cdr_pll_clk180_pfd),
				.clk270_odi(w_cdr_pll_clk270_odi),
				.clk270_pd(w_cdr_pll_clk270_pd),
				.clk90_odi(w_cdr_pll_clk90_odi),
				.clk90_pd(w_cdr_pll_clk90_pd),
				.clklow(w_cdr_pll_clklow),
				.deven_des(w_cdr_pll_deven_des),
				.devenb_des(w_cdr_pll_devenb_des),
				.dodd_des(w_cdr_pll_dodd_des),
				.doddb_des(w_cdr_pll_doddb_des),
				.error_even_des(w_cdr_pll_error_even_des),
				.error_evenb_des(w_cdr_pll_error_evenb_des),
				.error_odd_des(w_cdr_pll_error_odd_des),
				.error_oddb_des(w_cdr_pll_error_oddb_des),
				.fref(w_cdr_pll_fref),
				.overrange(w_cdr_pll_overrange),
				.pfdmode_lock(w_cdr_pll_pfdmode_lock),
				.rlpbkdn(w_cdr_pll_rlpbkdn),
				.rlpbkdp(w_cdr_pll_rlpbkdp),
				.rlpbkn(w_cdr_pll_rlpbkn),
				.rlpbkp(w_cdr_pll_rlpbkp),
				.rxpll_lock(w_cdr_pll_rxpll_lock),
				.tx_rlpbk(w_cdr_pll_tx_rlpbk),
				.underrange(w_cdr_pll_underrange),
				// INPUTS
				.adapt_en(w_pma_adapt_dfe_adapt_en),
				.avmmaddress({in_avmmaddress[8], in_avmmaddress[7], in_avmmaddress[6], in_avmmaddress[5], in_avmmaddress[4], in_avmmaddress[3], in_avmmaddress[2], in_avmmaddress[1], in_avmmaddress[0]}),
				.avmmclk(in_avmmclk),
				.avmmread(in_avmmread),
				.avmmrstn(in_avmmrstn),
				.avmmwrite(in_avmmwrite),
				.avmmwritedata({in_avmmwritedata[7], in_avmmwritedata[6], in_avmmwritedata[5], in_avmmwritedata[4], in_avmmwritedata[3], in_avmmwritedata[2], in_avmmwritedata[1], in_avmmwritedata[0]}),
				.clk0_bbpd(w_pma_rx_dfe_clk0_bbpd),
				.clk180_bbpd(w_pma_rx_dfe_clk180_bbpd),
				.clk270_bbpd(w_pma_rx_dfe_clk270_bbpd),
				.clk90_bbpd(w_pma_rx_dfe_clk90_bbpd),
				.deven(w_pma_rx_dfe_deven),
				.devenb(w_pma_rx_dfe_devenb),
				.dfe_test(1'b0),
				.dodd(w_pma_rx_dfe_dodd),
				.doddb(w_pma_rx_dfe_doddb),
				.e270(w_pma_rx_dfe_edge270),
				.e270b(w_pma_rx_dfe_edge270b),
				.e90(w_pma_rx_dfe_edge90),
				.e90b(w_pma_rx_dfe_edge90b),
				.early_eios(in_early_eios),
				.error_even(w_pma_rx_dfe_err_ev),
				.error_evenb(w_pma_rx_dfe_err_evb),
				.error_odd(w_pma_rx_dfe_err_od),
				.error_oddb(w_pma_rx_dfe_err_odb),
				.fpll_test0(in_fpll_ppm_clk_in[0]),
				.fpll_test1(in_fpll_ppm_clk_in[1]),
				.iqtxrxclk({in_iqtxrxclk[5], in_iqtxrxclk[4], in_iqtxrxclk[3], in_iqtxrxclk[2], in_iqtxrxclk[1], in_iqtxrxclk[0]}),
				.ltd_b(in_ltd_b),
				.ltr(in_ltr),
				.odi_clk(w_pma_rx_odi_clk0_eye_lb),
				.odi_clkb(w_pma_rx_odi_clk180_eye_lb),
				.pcie_sw_ret({w_pma_rx_deser_pcie_sw_ret[1], w_pma_rx_deser_pcie_sw_ret[0]}),
				.ppm_lock(in_ppm_lock),
				.refclk(w_pma_cdr_refclk_refclk),
				.rst_n(in_rx_pma_rstb),
				.rx_deser_pclk_test(w_pma_rx_deser_clkdivrx_rx),
				.rx_lpbkn(w_pma_rx_buf_rdlpbkn),
				.rx_lpbkp(w_pma_rx_buf_rdlpbkp),
				.rxp(in_rx_p),
				.sd(w_pma_rx_sd_sd),
				.tx_ser_pclk_test(w_pma_tx_ser_clk_divtx),
				
				// UNUSED
				.atbsel(),
				.cdr_lpbkdp(),
				.cdr_lpbkp(),
				.clk270_des(),
				.clk90_des(),
				.lock2ref(),
				.rx_signal_ok(),
				.von_lp(),
				.vop_lp()
			);
		end // if generate
		else begin
				assign w_cdr_pll_avmmreaddata[7:0] = 8'b0;
				assign w_cdr_pll_blockselect = 1'b0;
				assign w_cdr_pll_cdr_cnt_done = 1'b0;
				assign w_cdr_pll_cdr_refclk_cal_out[11:0] = 12'b0;
				assign w_cdr_pll_cdr_vco_cal_out[11:0] = 12'b0;
				assign w_cdr_pll_clk0_des = 1'b0;
				assign w_cdr_pll_clk0_odi = 1'b0;
				assign w_cdr_pll_clk0_pd = 1'b0;
				assign w_cdr_pll_clk0_pfd = 1'b0;
				assign w_cdr_pll_clk180_des = 1'b0;
				assign w_cdr_pll_clk180_odi = 1'b0;
				assign w_cdr_pll_clk180_pd = 1'b0;
				assign w_cdr_pll_clk180_pfd = 1'b0;
				assign w_cdr_pll_clk270_odi = 1'b0;
				assign w_cdr_pll_clk270_pd = 1'b0;
				assign w_cdr_pll_clk90_odi = 1'b0;
				assign w_cdr_pll_clk90_pd = 1'b0;
				assign w_cdr_pll_clklow = 1'b0;
				assign w_cdr_pll_deven_des = 1'b0;
				assign w_cdr_pll_devenb_des = 1'b0;
				assign w_cdr_pll_dodd_des = 1'b0;
				assign w_cdr_pll_doddb_des = 1'b0;
				assign w_cdr_pll_error_even_des = 1'b0;
				assign w_cdr_pll_error_evenb_des = 1'b0;
				assign w_cdr_pll_error_odd_des = 1'b0;
				assign w_cdr_pll_error_oddb_des = 1'b0;
				assign w_cdr_pll_fref = 1'b0;
				assign w_cdr_pll_overrange = 1'b0;
				assign w_cdr_pll_pfdmode_lock = 1'b0;
				assign w_cdr_pll_rlpbkdn = 1'b0;
				assign w_cdr_pll_rlpbkdp = 1'b0;
				assign w_cdr_pll_rlpbkn = 1'b0;
				assign w_cdr_pll_rlpbkp = 1'b0;
				assign w_cdr_pll_rxpll_lock = 1'b0;
				assign w_cdr_pll_tx_rlpbk = 1'b0;
				assign w_cdr_pll_underrange = 1'b0;
		end // if not generate
		
		// instantiating twentynm_hssi_pma_rx_buf
		if ((xcvr_native_mode == "mode_rx_only") || (xcvr_native_mode == "mode_duplex")) begin:gen_twentynm_hssi_pma_rx_buf
			twentynm_hssi_pma_rx_buf #(
				.bypass_eqz_stages_234(pma_rx_buf_bypass_eqz_stages_234),
				.datarate(pma_rx_buf_datarate),
				.diag_lp_en(pma_rx_buf_diag_lp_en),
				.initial_settings("true"),       //PARAM_HIDE
				.loopback_modes(pma_rx_buf_loopback_modes),
				.optimal("false"),       //PARAM_HIDE
				.pdb_rx("normal_rx_on"),       //PARAM_HIDE
				.pm_tx_rx_cvp_mode(pma_rx_buf_pm_tx_rx_cvp_mode),
				.pm_tx_rx_pcie_gen(pma_rx_buf_pm_tx_rx_pcie_gen),
				.pm_tx_rx_pcie_gen_bitwidth(pma_rx_buf_pm_tx_rx_pcie_gen_bitwidth),
				.prot_mode(pma_rx_buf_prot_mode),
				.qpi_enable(pma_rx_buf_qpi_enable),
				.refclk_en(pma_rx_buf_refclk_en),
				.rx_refclk_divider(pma_rx_buf_rx_refclk_divider),
				.silicon_rev( "20nm5" ),       //PARAM_HIDE
				.sup_mode(pma_rx_buf_sup_mode),
				.xrx_path_datarate(pma_rx_buf_xrx_path_datarate),
				.xrx_path_datawidth(pma_rx_buf_xrx_path_datawidth),
				.xrx_path_initial_settings("true"),       //PARAM_HIDE
				.xrx_path_optimal("false"),       //PARAM_HIDE
				.xrx_path_pma_rx_divclk_hz(pma_rx_buf_xrx_path_pma_rx_divclk_hz),
				.xrx_path_prot_mode(pma_rx_buf_xrx_path_prot_mode),
				.xrx_path_sup_mode(pma_rx_buf_xrx_path_sup_mode),
				.xrx_path_uc_cal_enable(pma_rx_buf_xrx_path_uc_cal_enable)
			) inst_twentynm_hssi_pma_rx_buf (
				// OUTPUTS
				.avmmreaddata(w_pma_rx_buf_avmmreaddata),
				.blockselect(w_pma_rx_buf_blockselect),
				.inn(w_pma_rx_buf_inn),
				.inp(w_pma_rx_buf_inp),
				.outn(w_pma_rx_buf_outn),
				.outp(w_pma_rx_buf_outp),
				.pull_dn(w_pma_rx_buf_pull_dn),
				.rdlpbkn(w_pma_rx_buf_rdlpbkn),
				.rdlpbkp(w_pma_rx_buf_rdlpbkp),
				// INPUTS
				.avmmaddress({in_avmmaddress[8], in_avmmaddress[7], in_avmmaddress[6], in_avmmaddress[5], in_avmmaddress[4], in_avmmaddress[3], in_avmmaddress[2], in_avmmaddress[1], in_avmmaddress[0]}),
				.avmmclk(in_avmmclk),
				.avmmread(in_avmmread),
				.avmmrstn(in_avmmrstn),
				.avmmwrite(in_avmmwrite),
				.avmmwritedata({in_avmmwritedata[7], in_avmmwritedata[6], in_avmmwritedata[5], in_avmmwritedata[4], in_avmmwritedata[3], in_avmmwritedata[2], in_avmmwritedata[1], in_avmmwritedata[0]}),
				.clk_divrx(w_pma_rx_deser_clkdivrx_rx),
				.lpbkn(w_pma_tx_buf_lbvon),
				.lpbkp(w_pma_tx_buf_lbvop),
				.rx_qpi_pulldn(in_rx_qpi_pulldn),
				.rx_rstn(in_rx_pma_rstb),
				.rx_sel_b50({in_rx50_buf_in[5], in_rx50_buf_in[4], in_rx50_buf_in[3], in_rx50_buf_in[2], in_rx50_buf_in[1], in_rx50_buf_in[0]}),
				.rxn(in_rx_n),
				.rxp(in_rx_p),
				.s_lpbk_b(in_rs_lpbk_b),
				.vcz({w_pma_adapt_ctle_acgain_4s[27], w_pma_adapt_ctle_acgain_4s[26], w_pma_adapt_ctle_acgain_4s[25], w_pma_adapt_ctle_acgain_4s[24], w_pma_adapt_ctle_acgain_4s[23], w_pma_adapt_ctle_acgain_4s[22], w_pma_adapt_ctle_acgain_4s[21], w_pma_adapt_ctle_acgain_4s[20], w_pma_adapt_ctle_acgain_4s[19], w_pma_adapt_ctle_acgain_4s[18], w_pma_adapt_ctle_acgain_4s[17], w_pma_adapt_ctle_acgain_4s[16], w_pma_adapt_ctle_acgain_4s[15], w_pma_adapt_ctle_acgain_4s[14], w_pma_adapt_ctle_acgain_4s[13], w_pma_adapt_ctle_acgain_4s[12], w_pma_adapt_ctle_acgain_4s[11], w_pma_adapt_ctle_acgain_4s[10], w_pma_adapt_ctle_acgain_4s[9], w_pma_adapt_ctle_acgain_4s[8], w_pma_adapt_ctle_acgain_4s[7], w_pma_adapt_ctle_acgain_4s[6], w_pma_adapt_ctle_acgain_4s[5], w_pma_adapt_ctle_acgain_4s[4], w_pma_adapt_ctle_acgain_4s[3], w_pma_adapt_ctle_acgain_4s[2], w_pma_adapt_ctle_acgain_4s[1], w_pma_adapt_ctle_acgain_4s[0]}),
				.vds_eqz_s1_set({w_pma_adapt_ctle_eqz_1s_sel[14], w_pma_adapt_ctle_eqz_1s_sel[13], w_pma_adapt_ctle_eqz_1s_sel[12], w_pma_adapt_ctle_eqz_1s_sel[11], w_pma_adapt_ctle_eqz_1s_sel[10], w_pma_adapt_ctle_eqz_1s_sel[9], w_pma_adapt_ctle_eqz_1s_sel[8], w_pma_adapt_ctle_eqz_1s_sel[7], w_pma_adapt_ctle_eqz_1s_sel[6], w_pma_adapt_ctle_eqz_1s_sel[5], w_pma_adapt_ctle_eqz_1s_sel[4], w_pma_adapt_ctle_eqz_1s_sel[3], w_pma_adapt_ctle_eqz_1s_sel[2], w_pma_adapt_ctle_eqz_1s_sel[1], w_pma_adapt_ctle_eqz_1s_sel[0]}),
				.vds_lfeqz_czero({1'b0, 1'b0}),
				.vds_lfeqz_fb_set({w_pma_adapt_ctle_lfeq_fb_sel[6], w_pma_adapt_ctle_lfeq_fb_sel[5], w_pma_adapt_ctle_lfeq_fb_sel[4], w_pma_adapt_ctle_lfeq_fb_sel[3], w_pma_adapt_ctle_lfeq_fb_sel[2], w_pma_adapt_ctle_lfeq_fb_sel[1], w_pma_adapt_ctle_lfeq_fb_sel[0]}),
				.vds_vga_set({w_pma_adapt_vga_sel[6], w_pma_adapt_vga_sel[5], w_pma_adapt_vga_sel[4], w_pma_adapt_vga_sel[3], w_pma_adapt_vga_sel[2], w_pma_adapt_vga_sel[1], w_pma_adapt_vga_sel[0]}),
				
				// UNUSED
				.rx_refclk(),
				.vga_cm_bidir_in(),
				.vga_cm_bidir_out()
			);
		end // if generate
		else begin
				assign w_pma_rx_buf_avmmreaddata[7:0] = 8'b0;
				assign w_pma_rx_buf_blockselect = 1'b0;
				assign w_pma_rx_buf_inn = 1'b0;
				assign w_pma_rx_buf_inp = 1'b0;
				assign w_pma_rx_buf_outn = 1'b0;
				assign w_pma_rx_buf_outp = 1'b0;
				assign w_pma_rx_buf_pull_dn = 1'b0;
				assign w_pma_rx_buf_rdlpbkn = 1'b0;
				assign w_pma_rx_buf_rdlpbkp = 1'b0;
		end // if not generate
		
		// instantiating twentynm_hssi_pma_rx_deser
		if ((xcvr_native_mode == "mode_rx_only") || (xcvr_native_mode == "mode_duplex")) begin:gen_twentynm_hssi_pma_rx_deser
			twentynm_hssi_pma_rx_deser #(
				.bitslip_bypass(pma_rx_deser_bitslip_bypass),
				.clkdiv_source(pma_rx_deser_clkdiv_source),
				.clkdivrx_user_mode(pma_rx_deser_clkdivrx_user_mode),
				.datarate(pma_rx_deser_datarate),
				.deser_factor(pma_rx_deser_deser_factor),
				.deser_powerdown("deser_power_up"),       //PARAM_HIDE
				.force_clkdiv_for_testing(pma_rx_deser_force_clkdiv_for_testing),
				.optimal("false"),       //PARAM_HIDE
				.pcie_gen(pma_rx_deser_pcie_gen),
				.pcie_gen_bitwidth(pma_rx_deser_pcie_gen_bitwidth),
				.prot_mode(pma_rx_deser_prot_mode),
				.rst_n_adapt_odi(pma_rx_deser_rst_n_adapt_odi),
				.sdclk_enable(pma_rx_deser_sdclk_enable),
				.silicon_rev( "20nm5" ),       //PARAM_HIDE
				.sup_mode(pma_rx_deser_sup_mode),
				.tdr_mode("select_bbpd_data")       //PARAM_HIDE
			) inst_twentynm_hssi_pma_rx_deser (
				// OUTPUTS
				.adapt_clk(w_pma_rx_deser_adapt_clk),
				.avmmreaddata(w_pma_rx_deser_avmmreaddata),
				.blockselect(w_pma_rx_deser_blockselect),
				.clkdiv(w_pma_rx_deser_clkdiv),
				.clkdiv_user(w_pma_rx_deser_clkdiv_user),
				.clkdivrx_rx(w_pma_rx_deser_clkdivrx_rx),
				.data(w_pma_rx_deser_data),
				.dout(w_pma_rx_deser_dout),
				.error_deser(w_pma_rx_deser_error_deser),
				.odi_dout(w_pma_rx_deser_odi_dout),
				.pcie_sw_ret(w_pma_rx_deser_pcie_sw_ret),
				.tstmx_deser(w_pma_rx_deser_tstmx_deser),
				// INPUTS
				.adapt_en(w_pma_adapt_odi_vref[0]),
				.avmmaddress({in_avmmaddress[8], in_avmmaddress[7], in_avmmaddress[6], in_avmmaddress[5], in_avmmaddress[4], in_avmmaddress[3], in_avmmaddress[2], in_avmmaddress[1], in_avmmaddress[0]}),
				.avmmclk(in_avmmclk),
				.avmmread(in_avmmread),
				.avmmrstn(in_avmmrstn),
				.avmmwrite(in_avmmwrite),
				.avmmwritedata({in_avmmwritedata[7], in_avmmwritedata[6], in_avmmwritedata[5], in_avmmwritedata[4], in_avmmwritedata[3], in_avmmwritedata[2], in_avmmwritedata[1], in_avmmwritedata[0]}),
				.bitslip(in_rx_bitslip),
				.clk0(w_cdr_pll_clk0_des),
				.clk0_odi(w_pma_rx_odi_clk0_eye),
				.clk180(w_cdr_pll_clk180_des),
				.clk180_odi(w_pma_rx_odi_clk180_eye),
				.clklow(w_cdr_pll_clklow),
				.deven(w_cdr_pll_deven_des),
				.deven_odi(w_pma_rx_odi_de_eye),
				.devenb(w_cdr_pll_devenb_des),
				.devenb_odi(w_pma_rx_odi_deb_eye),
				.dodd(w_cdr_pll_dodd_des),
				.dodd_odi(w_pma_rx_odi_do_eye),
				.doddb(w_cdr_pll_doddb_des),
				.doddb_odi(w_pma_rx_odi_dob_eye),
				.error_even(w_cdr_pll_error_even_des),
				.error_evenb(w_cdr_pll_error_evenb_des),
				.error_odd(w_cdr_pll_error_odd_des),
				.error_oddb(w_cdr_pll_error_oddb_des),
				.fref(w_cdr_pll_fref),
				.odi_en(w_pma_rx_odi_odi_en),
				.pcie_sw({in_pcie_sw[1], in_pcie_sw[0]}),
				.pfdmode_lock(w_cdr_pll_pfdmode_lock),
				.rst_n(in_rx_pma_rstb),
				
				// UNUSED
				.clk270(),
				.clk90(),
				.odi_clkout(),
				.tdr_en()
			);
		end // if generate
		else begin
				assign w_pma_rx_deser_adapt_clk = 1'b0;
				assign w_pma_rx_deser_avmmreaddata[7:0] = 8'b0;
				assign w_pma_rx_deser_blockselect = 1'b0;
				assign w_pma_rx_deser_clkdiv = 1'b0;
				assign w_pma_rx_deser_clkdiv_user = 1'b0;
				assign w_pma_rx_deser_clkdivrx_rx = 1'b0;
				assign w_pma_rx_deser_data[63:0] = 64'b0;
				assign w_pma_rx_deser_dout[63:0] = 64'b0;
				assign w_pma_rx_deser_error_deser[63:0] = 64'b0;
				assign w_pma_rx_deser_odi_dout[63:0] = 64'b0;
				assign w_pma_rx_deser_pcie_sw_ret[1:0] = 2'b0;
				assign w_pma_rx_deser_tstmx_deser[7:0] = 8'b0;
		end // if not generate
		
		// instantiating twentynm_hssi_pma_rx_dfe
		if ((xcvr_native_mode == "mode_rx_only") || (xcvr_native_mode == "mode_duplex")) begin:gen_twentynm_hssi_pma_rx_dfe
			twentynm_hssi_pma_rx_dfe #(
				.datarate(pma_rx_dfe_datarate),
				.dft_en(pma_rx_dfe_dft_en),
				.initial_settings("true"),       //PARAM_HIDE
				.optimal("false"),       //PARAM_HIDE
				.pdb(pma_rx_dfe_pdb),
				.pdb_fixedtap(pma_rx_dfe_pdb_fixedtap),
				.pdb_floattap(pma_rx_dfe_pdb_floattap),
				.pdb_fxtap4t7(pma_rx_dfe_pdb_fxtap4t7),
				.prot_mode(pma_rx_dfe_prot_mode),
				.silicon_rev( "20nm5" ),       //PARAM_HIDE
				.sup_mode(pma_rx_dfe_sup_mode)
			) inst_twentynm_hssi_pma_rx_dfe (
				// OUTPUTS
				.avmmreaddata(w_pma_rx_dfe_avmmreaddata),
				.blockselect(w_pma_rx_dfe_blockselect),
				.clk0_bbpd(w_pma_rx_dfe_clk0_bbpd),
				.clk180_bbpd(w_pma_rx_dfe_clk180_bbpd),
				.clk270_bbpd(w_pma_rx_dfe_clk270_bbpd),
				.clk90_bbpd(w_pma_rx_dfe_clk90_bbpd),
				.deven(w_pma_rx_dfe_deven),
				.devenb(w_pma_rx_dfe_devenb),
				.dfe_oc_tstmx(w_pma_rx_dfe_dfe_oc_tstmx),
				.dodd(w_pma_rx_dfe_dodd),
				.doddb(w_pma_rx_dfe_doddb),
				.edge270(w_pma_rx_dfe_edge270),
				.edge270b(w_pma_rx_dfe_edge270b),
				.edge90(w_pma_rx_dfe_edge90),
				.edge90b(w_pma_rx_dfe_edge90b),
				.err_ev(w_pma_rx_dfe_err_ev),
				.err_evb(w_pma_rx_dfe_err_evb),
				.err_od(w_pma_rx_dfe_err_od),
				.err_odb(w_pma_rx_dfe_err_odb),
				.spec_vrefh(w_pma_rx_dfe_spec_vrefh),
				.spec_vrefl(w_pma_rx_dfe_spec_vrefl),
				// INPUTS
				.adapt_en(w_pma_adapt_dfe_adapt_en),
				.adp_clk(w_pma_adapt_dfe_adp_clk),
				.avmmaddress({in_avmmaddress[8], in_avmmaddress[7], in_avmmaddress[6], in_avmmaddress[5], in_avmmaddress[4], in_avmmaddress[3], in_avmmaddress[2], in_avmmaddress[1], in_avmmaddress[0]}),
				.avmmclk(in_avmmclk),
				.avmmread(in_avmmread),
				.avmmrstn(in_avmmrstn),
				.avmmwrite(in_avmmwrite),
				.avmmwritedata({in_avmmwritedata[7], in_avmmwritedata[6], in_avmmwritedata[5], in_avmmwritedata[4], in_avmmwritedata[3], in_avmmwritedata[2], in_avmmwritedata[1], in_avmmwritedata[0]}),
				.clk0(w_cdr_pll_clk0_pd),
				.clk180(w_cdr_pll_clk180_pd),
				.clk270(w_cdr_pll_clk270_pd),
				.clk90(w_cdr_pll_clk90_pd),
				.dfe_fltap1_coeff({w_pma_adapt_dfe_fltap1[5], w_pma_adapt_dfe_fltap1[4], w_pma_adapt_dfe_fltap1[3], w_pma_adapt_dfe_fltap1[2], w_pma_adapt_dfe_fltap1[1], w_pma_adapt_dfe_fltap1[0]}),
				.dfe_fltap1_sgn(w_pma_adapt_dfe_fltap1_sgn),
				.dfe_fltap2_coeff({w_pma_adapt_dfe_fltap2[5], w_pma_adapt_dfe_fltap2[4], w_pma_adapt_dfe_fltap2[3], w_pma_adapt_dfe_fltap2[2], w_pma_adapt_dfe_fltap2[1], w_pma_adapt_dfe_fltap2[0]}),
				.dfe_fltap2_sgn(w_pma_adapt_dfe_fltap2_sgn),
				.dfe_fltap3_coeff({w_pma_adapt_dfe_fltap3[5], w_pma_adapt_dfe_fltap3[4], w_pma_adapt_dfe_fltap3[3], w_pma_adapt_dfe_fltap3[2], w_pma_adapt_dfe_fltap3[1], w_pma_adapt_dfe_fltap3[0]}),
				.dfe_fltap3_sgn(w_pma_adapt_dfe_fltap3_sgn),
				.dfe_fltap4_coeff({w_pma_adapt_dfe_fltap4[5], w_pma_adapt_dfe_fltap4[4], w_pma_adapt_dfe_fltap4[3], w_pma_adapt_dfe_fltap4[2], w_pma_adapt_dfe_fltap4[1], w_pma_adapt_dfe_fltap4[0]}),
				.dfe_fltap4_sgn(w_pma_adapt_dfe_fltap4_sgn),
				.dfe_fltap_bypdeser(w_pma_adapt_dfe_fltap_bypdeser),
				.dfe_fltap_position({w_pma_adapt_dfe_fltap_position[5], w_pma_adapt_dfe_fltap_position[4], w_pma_adapt_dfe_fltap_position[3], w_pma_adapt_dfe_fltap_position[2], w_pma_adapt_dfe_fltap_position[1], w_pma_adapt_dfe_fltap_position[0]}),
				.dfe_fxtap1_coeff({w_pma_adapt_dfe_fxtap1[6], w_pma_adapt_dfe_fxtap1[5], w_pma_adapt_dfe_fxtap1[4], w_pma_adapt_dfe_fxtap1[3], w_pma_adapt_dfe_fxtap1[2], w_pma_adapt_dfe_fxtap1[1], w_pma_adapt_dfe_fxtap1[0]}),
				.dfe_fxtap2_coeff({w_pma_adapt_dfe_fxtap2[6], w_pma_adapt_dfe_fxtap2[5], w_pma_adapt_dfe_fxtap2[4], w_pma_adapt_dfe_fxtap2[3], w_pma_adapt_dfe_fxtap2[2], w_pma_adapt_dfe_fxtap2[1], w_pma_adapt_dfe_fxtap2[0]}),
				.dfe_fxtap2_sgn(w_pma_adapt_dfe_fxtap2_sgn),
				.dfe_fxtap3_coeff({w_pma_adapt_dfe_fxtap3[6], w_pma_adapt_dfe_fxtap3[5], w_pma_adapt_dfe_fxtap3[4], w_pma_adapt_dfe_fxtap3[3], w_pma_adapt_dfe_fxtap3[2], w_pma_adapt_dfe_fxtap3[1], w_pma_adapt_dfe_fxtap3[0]}),
				.dfe_fxtap3_sgn(w_pma_adapt_dfe_fxtap3_sgn),
				.dfe_fxtap4_coeff({w_pma_adapt_dfe_fxtap4[5], w_pma_adapt_dfe_fxtap4[4], w_pma_adapt_dfe_fxtap4[3], w_pma_adapt_dfe_fxtap4[2], w_pma_adapt_dfe_fxtap4[1], w_pma_adapt_dfe_fxtap4[0]}),
				.dfe_fxtap4_sgn(w_pma_adapt_dfe_fxtap4_sgn),
				.dfe_fxtap5_coeff({w_pma_adapt_dfe_fxtap5[5], w_pma_adapt_dfe_fxtap5[4], w_pma_adapt_dfe_fxtap5[3], w_pma_adapt_dfe_fxtap5[2], w_pma_adapt_dfe_fxtap5[1], w_pma_adapt_dfe_fxtap5[0]}),
				.dfe_fxtap5_sgn(w_pma_adapt_dfe_fxtap5_sgn),
				.dfe_fxtap6_coeff({w_pma_adapt_dfe_fxtap6[4], w_pma_adapt_dfe_fxtap6[3], w_pma_adapt_dfe_fxtap6[2], w_pma_adapt_dfe_fxtap6[1], w_pma_adapt_dfe_fxtap6[0]}),
				.dfe_fxtap6_sgn(w_pma_adapt_dfe_fxtap6_sgn),
				.dfe_fxtap7_coeff({w_pma_adapt_dfe_fxtap7[4], w_pma_adapt_dfe_fxtap7[3], w_pma_adapt_dfe_fxtap7[2], w_pma_adapt_dfe_fxtap7[1], w_pma_adapt_dfe_fxtap7[0]}),
				.dfe_fxtap7_sgn(w_pma_adapt_dfe_fxtap7_sgn),
				.dfe_rstn(in_rx_pma_rstb),
				.dfe_spec_disable(w_pma_adapt_dfe_spec_disable),
				.dfe_spec_sgn_sel(w_pma_adapt_dfe_spec_sign_sel),
				.dfe_vref_sgn_sel(w_pma_adapt_dfe_vref_sign_sel),
				.rxn(w_pma_rx_buf_outn),
				.rxp(w_pma_rx_buf_outp),
				.vga_vcm(1'b0),
				.vref_level_coeff({w_pma_adapt_vref_sel[4], w_pma_adapt_vref_sel[3], w_pma_adapt_vref_sel[2], w_pma_adapt_vref_sel[1], w_pma_adapt_vref_sel[0]})
			);
		end // if generate
		else begin
				assign w_pma_rx_dfe_avmmreaddata[7:0] = 8'b0;
				assign w_pma_rx_dfe_blockselect = 1'b0;
				assign w_pma_rx_dfe_clk0_bbpd = 1'b0;
				assign w_pma_rx_dfe_clk180_bbpd = 1'b0;
				assign w_pma_rx_dfe_clk270_bbpd = 1'b0;
				assign w_pma_rx_dfe_clk90_bbpd = 1'b0;
				assign w_pma_rx_dfe_deven = 1'b0;
				assign w_pma_rx_dfe_devenb = 1'b0;
				assign w_pma_rx_dfe_dfe_oc_tstmx[7:0] = 8'b0;
				assign w_pma_rx_dfe_dodd = 1'b0;
				assign w_pma_rx_dfe_doddb = 1'b0;
				assign w_pma_rx_dfe_edge270 = 1'b0;
				assign w_pma_rx_dfe_edge270b = 1'b0;
				assign w_pma_rx_dfe_edge90 = 1'b0;
				assign w_pma_rx_dfe_edge90b = 1'b0;
				assign w_pma_rx_dfe_err_ev = 1'b0;
				assign w_pma_rx_dfe_err_evb = 1'b0;
				assign w_pma_rx_dfe_err_od = 1'b0;
				assign w_pma_rx_dfe_err_odb = 1'b0;
				assign w_pma_rx_dfe_spec_vrefh = 1'b0;
				assign w_pma_rx_dfe_spec_vrefl = 1'b0;
		end // if not generate
		
		// instantiating twentynm_hssi_pma_rx_odi
		if ((xcvr_native_mode == "mode_rx_only") || (xcvr_native_mode == "mode_duplex")) begin:gen_twentynm_hssi_pma_rx_odi
			twentynm_hssi_pma_rx_odi #(
				.datarate(pma_rx_odi_datarate),
				.initial_settings("true"),       //PARAM_HIDE
				.optimal("false"),       //PARAM_HIDE
				.prot_mode(pma_rx_odi_prot_mode),
				.silicon_rev( "20nm5" ),       //PARAM_HIDE
				.step_ctrl_sel(pma_rx_odi_step_ctrl_sel),
				.sup_mode(pma_rx_odi_sup_mode)
			) inst_twentynm_hssi_pma_rx_odi (
				// OUTPUTS
				.avmmreaddata(w_pma_rx_odi_avmmreaddata),
				.blockselect(w_pma_rx_odi_blockselect),
				.clk0_eye(w_pma_rx_odi_clk0_eye),
				.clk0_eye_lb(w_pma_rx_odi_clk0_eye_lb),
				.clk180_eye(w_pma_rx_odi_clk180_eye),
				.clk180_eye_lb(w_pma_rx_odi_clk180_eye_lb),
				.de_eye(w_pma_rx_odi_de_eye),
				.deb_eye(w_pma_rx_odi_deb_eye),
				.do_eye(w_pma_rx_odi_do_eye),
				.dob_eye(w_pma_rx_odi_dob_eye),
				.odi_en(w_pma_rx_odi_odi_en),
				.odi_oc_tstmx(w_pma_rx_odi_odi_oc_tstmx),
				// INPUTS
				.avmmaddress({in_avmmaddress[8], in_avmmaddress[7], in_avmmaddress[6], in_avmmaddress[5], in_avmmaddress[4], in_avmmaddress[3], in_avmmaddress[2], in_avmmaddress[1], in_avmmaddress[0]}),
				.avmmclk(in_avmmclk),
				.avmmread(in_avmmread),
				.avmmrstn(in_avmmrstn),
				.avmmwrite(in_avmmwrite),
				.avmmwritedata({in_avmmwritedata[7], in_avmmwritedata[6], in_avmmwritedata[5], in_avmmwritedata[4], in_avmmwritedata[3], in_avmmwritedata[2], in_avmmwritedata[1], in_avmmwritedata[0]}),
				.clk0(w_cdr_pll_clk0_odi),
				.clk180(w_cdr_pll_clk180_odi),
				.clk270(w_cdr_pll_clk270_odi),
				.clk90(w_cdr_pll_clk90_odi),
				.odi_dft_clr(in_eye_monitor[3]),
				.odi_latch_clk(in_eye_monitor[1]),
				.odi_shift_clk(in_eye_monitor[0]),
				.odi_shift_in(in_eye_monitor[2]),
				.rx_n(w_pma_rx_buf_inn),
				.rx_p(w_pma_rx_buf_inp),
				.rxn_sum(w_pma_rx_buf_outn),
				.rxp_sum(w_pma_rx_buf_outp),
				.spec_vrefh(w_pma_rx_dfe_spec_vrefh),
				.spec_vrefl(w_pma_rx_dfe_spec_vrefl),
				.vcm_vref(1'b0),
				.vertical_fb({w_pma_adapt_odi_vref[4], w_pma_adapt_odi_vref[3], w_pma_adapt_odi_vref[2], w_pma_adapt_odi_vref[1], 1'b0}),
				
				// UNUSED
				.atb0(),
				.atb1(),
				.it50u(),
				.it50u2(),
				.it50u4(),
				.odi_atb_sel(),
				.tdr_en(),
				.vref_sel_out()
			);
		end // if generate
		else begin
				assign w_pma_rx_odi_avmmreaddata[7:0] = 8'b0;
				assign w_pma_rx_odi_blockselect = 1'b0;
				assign w_pma_rx_odi_clk0_eye = 1'b0;
				assign w_pma_rx_odi_clk0_eye_lb = 1'b0;
				assign w_pma_rx_odi_clk180_eye = 1'b0;
				assign w_pma_rx_odi_clk180_eye_lb = 1'b0;
				assign w_pma_rx_odi_de_eye = 1'b0;
				assign w_pma_rx_odi_deb_eye = 1'b0;
				assign w_pma_rx_odi_do_eye = 1'b0;
				assign w_pma_rx_odi_dob_eye = 1'b0;
				assign w_pma_rx_odi_odi_en = 1'b0;
				assign w_pma_rx_odi_odi_oc_tstmx[1:0] = 2'b0;
		end // if not generate
		
		// instantiating twentynm_hssi_pma_rx_sd
		if ((xcvr_native_mode == "mode_rx_only") || (xcvr_native_mode == "mode_duplex")) begin:gen_twentynm_hssi_pma_rx_sd
			twentynm_hssi_pma_rx_sd #(
				.optimal("false"),       //PARAM_HIDE
				.prot_mode(pma_rx_sd_prot_mode),
				.sd_output_off(pma_rx_sd_sd_output_off),
				.sd_output_on(pma_rx_sd_sd_output_on),
				.sd_pdb(pma_rx_sd_sd_pdb),
				.silicon_rev( "20nm5" ),       //PARAM_HIDE
				.sup_mode(pma_rx_sd_sup_mode)
			) inst_twentynm_hssi_pma_rx_sd (
				// OUTPUTS
				.avmmreaddata(w_pma_rx_sd_avmmreaddata),
				.blockselect(w_pma_rx_sd_blockselect),
				.sd(w_pma_rx_sd_sd),
				// INPUTS
				.avmmaddress({in_avmmaddress[8], in_avmmaddress[7], in_avmmaddress[6], in_avmmaddress[5], in_avmmaddress[4], in_avmmaddress[3], in_avmmaddress[2], in_avmmaddress[1], in_avmmaddress[0]}),
				.avmmclk(in_avmmclk),
				.avmmread(in_avmmread),
				.avmmrstn(in_avmmrstn),
				.avmmwrite(in_avmmwrite),
				.avmmwritedata({in_avmmwritedata[7], in_avmmwritedata[6], in_avmmwritedata[5], in_avmmwritedata[4], in_avmmwritedata[3], in_avmmwritedata[2], in_avmmwritedata[1], in_avmmwritedata[0]}),
				.clk(w_pma_rx_deser_clkdivrx_rx),
				.qpi(w_pma_rx_buf_pull_dn),
				.rstn_sd(in_rx_pma_rstb),
				.s_lpbk_b(in_rs_lpbk_b),
				.vin(w_pma_rx_buf_inn),
				.vip(w_pma_rx_buf_inp)
			);
		end // if generate
		else begin
				assign w_pma_rx_sd_avmmreaddata[7:0] = 8'b0;
				assign w_pma_rx_sd_blockselect = 1'b0;
				assign w_pma_rx_sd_sd = 1'b0;
		end // if not generate
		
		// instantiating twentynm_hssi_pma_tx_buf
		if ((xcvr_native_mode == "mode_tx_only") || (xcvr_native_mode == "mode_duplex")) begin:gen_twentynm_hssi_pma_tx_buf
			twentynm_hssi_pma_tx_buf #(
				.datarate(pma_tx_buf_datarate),
				.dft_sel("dft_disabled"),       //PARAM_HIDE
				.initial_settings("true"),       //PARAM_HIDE
				.jtag_drv_sel("drv1"),       //PARAM_HIDE
				.jtag_lp("lp_off"),       //PARAM_HIDE
				.lst("atb_disabled"),       //PARAM_HIDE
				.mcgb_location_for_pcie(pma_tx_buf_mcgb_location_for_pcie),
				.optimal("false"),       //PARAM_HIDE
				.prot_mode(pma_tx_buf_prot_mode),
				.rx_det(pma_tx_buf_rx_det),
				.rx_det_output_sel(pma_tx_buf_rx_det_output_sel),
				.rx_det_pdb(pma_tx_buf_rx_det_pdb),
				.ser_powerdown("normal_ser_on"),       //PARAM_HIDE
				.silicon_rev( "20nm5" ),       //PARAM_HIDE
				.sup_mode(pma_tx_buf_sup_mode),
				.tx_powerdown("normal_tx_on"),       //PARAM_HIDE
				.user_fir_coeff_ctrl_sel(pma_tx_buf_user_fir_coeff_ctrl_sel),
				.xtx_path_clock_divider_ratio(pma_tx_buf_xtx_path_clock_divider_ratio),
				.xtx_path_datarate(pma_tx_buf_xtx_path_datarate),
				.xtx_path_datawidth(pma_tx_buf_xtx_path_datawidth),
				.xtx_path_initial_settings("true"),       //PARAM_HIDE
				.xtx_path_optimal("false"),       //PARAM_HIDE
				.xtx_path_pma_tx_divclk_hz(pma_tx_buf_xtx_path_pma_tx_divclk_hz),
				.xtx_path_prot_mode(pma_tx_buf_xtx_path_prot_mode),
				.xtx_path_sup_mode(pma_tx_buf_xtx_path_sup_mode),
				.xtx_path_tx_pll_clk_hz(pma_tx_buf_xtx_path_tx_pll_clk_hz)
			) inst_twentynm_hssi_pma_tx_buf (
				// OUTPUTS
				.atbsel(w_pma_tx_buf_atbsel),
				.avmmreaddata(w_pma_tx_buf_avmmreaddata),
				.blockselect(w_pma_tx_buf_blockselect),
				.ckn(w_pma_tx_buf_ckn),
				.ckp(w_pma_tx_buf_ckp),
				.dcd_out1(w_pma_tx_buf_dcd_out1),
				.dcd_out2(w_pma_tx_buf_dcd_out2),
				.dcd_out_ready(w_pma_tx_buf_dcd_out_ready),
				.detect_on(w_pma_tx_buf_detect_on),
				.lbvon(w_pma_tx_buf_lbvon),
				.lbvop(w_pma_tx_buf_lbvop),
				.rx_detect_valid(w_pma_tx_buf_rx_detect_valid),
				.rx_found(w_pma_tx_buf_rx_found),
				.rx_found_pcie_spl_test(w_pma_tx_buf_rx_found_pcie_spl_test),
				.sel_vreg(w_pma_tx_buf_sel_vreg),
				.spl_clk_test(w_pma_tx_buf_spl_clk_test),
				.tx_dftout(w_pma_tx_buf_tx_dftout),
				.vlptxn(w_pma_tx_buf_vlptxn),
				.vlptxp(w_pma_tx_buf_vlptxp),
				.von(w_pma_tx_buf_von),
				.vop(w_pma_tx_buf_vop),
				// INPUTS
				.avmmaddress({in_avmmaddress[8], in_avmmaddress[7], in_avmmaddress[6], in_avmmaddress[5], in_avmmaddress[4], in_avmmaddress[3], in_avmmaddress[2], in_avmmaddress[1], in_avmmaddress[0]}),
				.avmmclk(in_avmmclk),
				.avmmread(in_avmmread),
				.avmmrstn(in_avmmrstn),
				.avmmwrite(in_avmmwrite),
				.avmmwritedata({in_avmmwritedata[7], in_avmmwritedata[6], in_avmmwritedata[5], in_avmmwritedata[4], in_avmmwritedata[3], in_avmmwritedata[2], in_avmmwritedata[1], in_avmmwritedata[0]}),
				.bsmode(1'b0),
				.bsoeb(1'b0),
				.bstxn_in(1'b0),
				.bstxp_in(1'b0),
				.clk0_tx(w_pma_cgb_hifreqclkp),
				.clk180_tx(w_pma_cgb_hifreqclkn),
				.clk_dcd(w_pma_cgb_cpulse_out_bus[0]),
				.clksn(w_pma_tx_ser_ckdrvp),
				.clksp(w_pma_tx_ser_ckdrvn),
				.i_coeff({in_i_coeff[17], in_i_coeff[16], in_i_coeff[15], in_i_coeff[14], in_i_coeff[13], in_i_coeff[12], in_i_coeff[11], in_i_coeff[10], in_i_coeff[9], in_i_coeff[8], in_i_coeff[7], in_i_coeff[6], in_i_coeff[5], in_i_coeff[4], in_i_coeff[3], in_i_coeff[2], in_i_coeff[1], in_i_coeff[0]}),
				.oe(w_pma_tx_ser_oe),
				.oeb(w_pma_tx_ser_oeb),
				.oo(w_pma_tx_ser_oo),
				.oob(w_pma_tx_ser_oob),
				.pcie_sw_master(w_pma_cgb_pcie_sw_master[1]),
				.rx_det_clk(w_pma_cdr_refclk_rx_det_clk),
				.rx_n_bidir_in(in_rx_n),
				.rx_p_bidir_in(in_rx_p),
				.s_lpbk_b(in_rs_lpbk_b),
				.tx50({in_tx50_buf_in[8], in_tx50_buf_in[7], in_tx50_buf_in[6], in_tx50_buf_in[5], in_tx50_buf_in[4], in_tx50_buf_in[3], in_tx50_buf_in[2], in_tx50_buf_in[1], in_tx50_buf_in[0]}),
				.tx_det_rx(in_tx_det_rx),
				.tx_elec_idle(in_tx_elec_idle),
				.tx_qpi_pulldn(in_tx_qpi_pulldn),
				.tx_qpi_pullup(in_tx_qpi_pullup),
				.tx_rlpbk(w_cdr_pll_tx_rlpbk),
				.vrlpbkn(w_cdr_pll_rlpbkn),
				.vrlpbkn_1t(w_cdr_pll_rlpbkdn),
				.vrlpbkp(w_cdr_pll_rlpbkp),
				.vrlpbkp_1t(w_cdr_pll_rlpbkdp),
				
				// UNUSED
				.cr_rdynamic_sw()
			);
		end // if generate
		else begin
				assign w_pma_tx_buf_atbsel[2:0] = 3'b0;
				assign w_pma_tx_buf_avmmreaddata[7:0] = 8'b0;
				assign w_pma_tx_buf_blockselect = 1'b0;
				assign w_pma_tx_buf_ckn = 1'b0;
				assign w_pma_tx_buf_ckp = 1'b0;
				assign w_pma_tx_buf_dcd_out1 = 1'b0;
				assign w_pma_tx_buf_dcd_out2 = 1'b0;
				assign w_pma_tx_buf_dcd_out_ready = 1'b0;
				assign w_pma_tx_buf_detect_on[1:0] = 2'b0;
				assign w_pma_tx_buf_lbvon = 1'b0;
				assign w_pma_tx_buf_lbvop = 1'b0;
				assign w_pma_tx_buf_rx_detect_valid = 1'b0;
				assign w_pma_tx_buf_rx_found = 1'b0;
				assign w_pma_tx_buf_rx_found_pcie_spl_test = 1'b0;
				assign w_pma_tx_buf_sel_vreg = 1'b0;
				assign w_pma_tx_buf_spl_clk_test = 1'b0;
				assign w_pma_tx_buf_tx_dftout[7:0] = 8'b0;
				assign w_pma_tx_buf_vlptxn = 1'b0;
				assign w_pma_tx_buf_vlptxp = 1'b0;
				assign w_pma_tx_buf_von = 1'b0;
				assign w_pma_tx_buf_vop = 1'b0;
		end // if not generate
		
		// instantiating twentynm_hssi_pma_tx_cgb
		if ((xcvr_native_mode == "mode_tx_only") || (xcvr_native_mode == "mode_duplex")) begin:gen_twentynm_hssi_pma_tx_cgb
			twentynm_hssi_pma_tx_cgb #(
				.bitslip_enable(pma_cgb_bitslip_enable),
				.bonding_reset_enable(pma_cgb_bonding_reset_enable),
				.cgb_power_down("normal_cgb"),       //PARAM_HIDE
				.datarate(pma_cgb_datarate),
				.initial_settings("true"),       //PARAM_HIDE
				.input_select_gen3(pma_cgb_input_select_gen3),
				.input_select_x1(pma_cgb_input_select_x1),
				.input_select_xn(pma_cgb_input_select_xn),
				.pcie_gen3_bitwidth(pma_cgb_pcie_gen3_bitwidth),
				.prot_mode(pma_cgb_prot_mode),
				.scratch0_x1_clock_src(pma_cgb_scratch0_x1_clock_src),
				.scratch1_x1_clock_src(pma_cgb_scratch1_x1_clock_src),
				.scratch2_x1_clock_src(pma_cgb_scratch2_x1_clock_src),
				.scratch3_x1_clock_src(pma_cgb_scratch3_x1_clock_src),
				.select_done_master_or_slave(pma_cgb_select_done_master_or_slave),
				.ser_mode(pma_cgb_ser_mode),
				.ser_powerdown("normal_poweron_ser"),       //PARAM_HIDE
				.silicon_rev( "20nm5" ),       //PARAM_HIDE
				.sup_mode(pma_cgb_sup_mode),
				.tx_ucontrol_en(pma_cgb_tx_ucontrol_en),
				.x1_div_m_sel(pma_cgb_x1_div_m_sel)
			) inst_twentynm_hssi_pma_tx_cgb (
				// OUTPUTS
				.avmmreaddata(w_pma_cgb_avmmreaddata),
				.bitslipstate(w_pma_cgb_bitslipstate),
				.blockselect(w_pma_cgb_blockselect),
				.cpulse_out_bus(w_pma_cgb_cpulse_out_bus),
				.div2(w_pma_cgb_div2),
				.div4(w_pma_cgb_div4),
				.div5(w_pma_cgb_div5),
				.hifreqclkn(w_pma_cgb_hifreqclkn),
				.hifreqclkp(w_pma_cgb_hifreqclkp),
				.pcie_sw_done(w_pma_cgb_pcie_sw_done),
				.pcie_sw_master(w_pma_cgb_pcie_sw_master),
				.rstb(w_pma_cgb_rstb),
				// INPUTS
				.avmmaddress({in_avmmaddress[8], in_avmmaddress[7], in_avmmaddress[6], in_avmmaddress[5], in_avmmaddress[4], in_avmmaddress[3], in_avmmaddress[2], in_avmmaddress[1], in_avmmaddress[0]}),
				.avmmclk(in_avmmclk),
				.avmmread(in_avmmread),
				.avmmrstn(in_avmmrstn),
				.avmmwrite(in_avmmwrite),
				.avmmwritedata({in_avmmwritedata[7], in_avmmwritedata[6], in_avmmwritedata[5], in_avmmwritedata[4], in_avmmwritedata[3], in_avmmwritedata[2], in_avmmwritedata[1], in_avmmwritedata[0]}),
				.ckdccn(w_pma_tx_buf_ckn),
				.ckdccp(w_pma_tx_buf_ckp),
				.clk_cdr_b(in_clk_cdr_b),
				.clk_cdr_direct(w_cdr_pll_clk0_pfd),
				.clk_cdr_t(in_clk_cdr_t),
				.clk_fpll_b(in_clk_fpll_b),
				.clk_fpll_t(in_clk_fpll_t),
				.clk_lc_b(in_clk_lc_b),
				.clk_lc_hs(in_clk_lc_hs),
				.clk_lc_t(in_clk_lc_t),
				.clkb_cdr_b(in_clkb_cdr_b),
				.clkb_cdr_direct(w_cdr_pll_clk180_pfd),
				.clkb_cdr_t(in_clkb_cdr_t),
				.clkb_fpll_b(in_clkb_fpll_b),
				.clkb_fpll_t(in_clkb_fpll_t),
				.clkb_lc_b(in_clkb_lc_b),
				.clkb_lc_hs(in_clkb_lc_hs),
				.clkb_lc_t(in_clkb_lc_t),
				.cpulse_x6_dn_bus({in_cpulse_x6_dn_bus[5], in_cpulse_x6_dn_bus[4], in_cpulse_x6_dn_bus[3], in_cpulse_x6_dn_bus[2], in_cpulse_x6_dn_bus[1], in_cpulse_x6_dn_bus[0]}),
				.cpulse_x6_up_bus({in_cpulse_x6_up_bus[5], in_cpulse_x6_up_bus[4], in_cpulse_x6_up_bus[3], in_cpulse_x6_up_bus[2], in_cpulse_x6_up_bus[1], in_cpulse_x6_up_bus[0]}),
				.cpulse_xn_dn_bus({in_cpulse_xn_dn_bus[5], in_cpulse_xn_dn_bus[4], in_cpulse_xn_dn_bus[3], in_cpulse_xn_dn_bus[2], in_cpulse_xn_dn_bus[1], in_cpulse_xn_dn_bus[0]}),
				.cpulse_xn_up_bus({in_cpulse_xn_up_bus[5], in_cpulse_xn_up_bus[4], in_cpulse_xn_up_bus[3], in_cpulse_xn_up_bus[2], in_cpulse_xn_up_bus[1], in_cpulse_xn_up_bus[0]}),
				.pcie_sw({in_pcie_sw[1], in_pcie_sw[0]}),
				.pcie_sw_done_master({in_pcie_sw_done_master_in[1], in_pcie_sw_done_master_in[0]}),
				.tx_bitslip(in_tx_bitslip),
				.tx_bonding_rstb(in_tx_bonding_rstb),
				.tx_pma_rstb(in_tx_pma_rstb)
			);
		end // if generate
		else begin
				assign w_pma_cgb_avmmreaddata[7:0] = 8'b0;
				assign w_pma_cgb_bitslipstate = 1'b0;
				assign w_pma_cgb_blockselect = 1'b0;
				assign w_pma_cgb_cpulse_out_bus[5:0] = 6'b0;
				assign w_pma_cgb_div2 = 1'b0;
				assign w_pma_cgb_div4 = 1'b0;
				assign w_pma_cgb_div5 = 1'b0;
				assign w_pma_cgb_hifreqclkn = 1'b0;
				assign w_pma_cgb_hifreqclkp = 1'b0;
				assign w_pma_cgb_pcie_sw_done[1:0] = 2'b0;
				assign w_pma_cgb_pcie_sw_master[1:0] = 2'b0;
				assign w_pma_cgb_rstb = 1'b0;
		end // if not generate
		
		// instantiating twentynm_hssi_pma_tx_ser
		if ((xcvr_native_mode == "mode_tx_only") || (xcvr_native_mode == "mode_duplex")) begin:gen_twentynm_hssi_pma_tx_ser
			twentynm_hssi_pma_tx_ser #(
				.control_clk_divtx("no_dft_control_clkdivtx"),       //PARAM_HIDE
				.initial_settings("true"),       //PARAM_HIDE
				.prot_mode(pma_tx_ser_prot_mode),
				.ser_clk_divtx_user_sel(pma_tx_ser_ser_clk_divtx_user_sel),
				.ser_powerdown("normal_poweron_ser"),       //PARAM_HIDE
				.silicon_rev( "20nm5" ),       //PARAM_HIDE
				.sup_mode(pma_tx_ser_sup_mode)
			) inst_twentynm_hssi_pma_tx_ser (
				// OUTPUTS
				.avmmreaddata(w_pma_tx_ser_avmmreaddata),
				.blockselect(w_pma_tx_ser_blockselect),
				.ckdrvn(w_pma_tx_ser_ckdrvn),
				.ckdrvp(w_pma_tx_ser_ckdrvp),
				.clk_divtx(w_pma_tx_ser_clk_divtx),
				.clk_divtx_user(w_pma_tx_ser_clk_divtx_user),
				.oe(w_pma_tx_ser_oe),
				.oeb(w_pma_tx_ser_oeb),
				.oo(w_pma_tx_ser_oo),
				.oob(w_pma_tx_ser_oob),
				// INPUTS
				.avmmaddress({in_avmmaddress[8], in_avmmaddress[7], in_avmmaddress[6], in_avmmaddress[5], in_avmmaddress[4], in_avmmaddress[3], in_avmmaddress[2], in_avmmaddress[1], in_avmmaddress[0]}),
				.avmmclk(in_avmmclk),
				.avmmread(in_avmmread),
				.avmmrstn(in_avmmrstn),
				.avmmwrite(in_avmmwrite),
				.avmmwritedata({in_avmmwritedata[7], in_avmmwritedata[6], in_avmmwritedata[5], in_avmmwritedata[4], in_avmmwritedata[3], in_avmmwritedata[2], in_avmmwritedata[1], in_avmmwritedata[0]}),
				.bitslipstate(w_pma_cgb_bitslipstate),
				.cpulse(w_pma_cgb_cpulse_out_bus[1]),
				.data({in_tx_data[63], in_tx_data[62], in_tx_data[61], in_tx_data[60], in_tx_data[59], in_tx_data[58], in_tx_data[57], in_tx_data[56], in_tx_data[55], in_tx_data[54], in_tx_data[53], in_tx_data[52], in_tx_data[51], in_tx_data[50], in_tx_data[49], in_tx_data[48], in_tx_data[47], in_tx_data[46], in_tx_data[45], in_tx_data[44], in_tx_data[43], in_tx_data[42], in_tx_data[41], in_tx_data[40], in_tx_data[39], in_tx_data[38], in_tx_data[37], in_tx_data[36], in_tx_data[35], in_tx_data[34], in_tx_data[33], in_tx_data[32], in_tx_data[31], in_tx_data[30], in_tx_data[29], in_tx_data[28], in_tx_data[27], in_tx_data[26], in_tx_data[25], in_tx_data[24], in_tx_data[23], in_tx_data[22], in_tx_data[21], in_tx_data[20], in_tx_data[19], in_tx_data[18], in_tx_data[17], in_tx_data[16], in_tx_data[15], in_tx_data[14], in_tx_data[13], in_tx_data[12], in_tx_data[11], in_tx_data[10], in_tx_data[9], in_tx_data[8], in_tx_data[7], in_tx_data[6], in_tx_data[5], in_tx_data[4], in_tx_data[3], in_tx_data[2], in_tx_data[1], in_tx_data[0]}),
				.hfclkn(w_pma_cgb_cpulse_out_bus[4]),
				.hfclkp(w_pma_cgb_cpulse_out_bus[5]),
				.lfclk(w_pma_cgb_cpulse_out_bus[3]),
				.lfclk2(w_pma_cgb_cpulse_out_bus[2]),
				.paraclk(w_pma_cgb_cpulse_out_bus[0]),
				.rser_div2(w_pma_cgb_div2),
				.rser_div4(w_pma_cgb_div4),
				.rser_div5(w_pma_cgb_div5),
				.rst_n(w_pma_cgb_rstb)
			);
		end // if generate
		else begin
				assign w_pma_tx_ser_avmmreaddata[7:0] = 8'b0;
				assign w_pma_tx_ser_blockselect = 1'b0;
				assign w_pma_tx_ser_ckdrvn = 1'b0;
				assign w_pma_tx_ser_ckdrvp = 1'b0;
				assign w_pma_tx_ser_clk_divtx = 1'b0;
				assign w_pma_tx_ser_clk_divtx_user = 1'b0;
				assign w_pma_tx_ser_oe = 1'b0;
				assign w_pma_tx_ser_oeb = 1'b0;
				assign w_pma_tx_ser_oo = 1'b0;
				assign w_pma_tx_ser_oob = 1'b0;
		end // if not generate
		
		//output assignments
		assign out_avmmreaddata_cdr_pll = {w_cdr_pll_avmmreaddata[7], w_cdr_pll_avmmreaddata[6], w_cdr_pll_avmmreaddata[5], w_cdr_pll_avmmreaddata[4], w_cdr_pll_avmmreaddata[3], w_cdr_pll_avmmreaddata[2], w_cdr_pll_avmmreaddata[1], w_cdr_pll_avmmreaddata[0]};
		assign out_avmmreaddata_pma_adapt = {w_pma_adapt_avmmreaddata[7], w_pma_adapt_avmmreaddata[6], w_pma_adapt_avmmreaddata[5], w_pma_adapt_avmmreaddata[4], w_pma_adapt_avmmreaddata[3], w_pma_adapt_avmmreaddata[2], w_pma_adapt_avmmreaddata[1], w_pma_adapt_avmmreaddata[0]};
		assign out_avmmreaddata_pma_cdr_refclk = {w_pma_cdr_refclk_avmmreaddata[7], w_pma_cdr_refclk_avmmreaddata[6], w_pma_cdr_refclk_avmmreaddata[5], w_pma_cdr_refclk_avmmreaddata[4], w_pma_cdr_refclk_avmmreaddata[3], w_pma_cdr_refclk_avmmreaddata[2], w_pma_cdr_refclk_avmmreaddata[1], w_pma_cdr_refclk_avmmreaddata[0]};
		assign out_avmmreaddata_pma_cgb = {w_pma_cgb_avmmreaddata[7], w_pma_cgb_avmmreaddata[6], w_pma_cgb_avmmreaddata[5], w_pma_cgb_avmmreaddata[4], w_pma_cgb_avmmreaddata[3], w_pma_cgb_avmmreaddata[2], w_pma_cgb_avmmreaddata[1], w_pma_cgb_avmmreaddata[0]};
		assign out_avmmreaddata_pma_rx_buf = {w_pma_rx_buf_avmmreaddata[7], w_pma_rx_buf_avmmreaddata[6], w_pma_rx_buf_avmmreaddata[5], w_pma_rx_buf_avmmreaddata[4], w_pma_rx_buf_avmmreaddata[3], w_pma_rx_buf_avmmreaddata[2], w_pma_rx_buf_avmmreaddata[1], w_pma_rx_buf_avmmreaddata[0]};
		assign out_avmmreaddata_pma_rx_deser = {w_pma_rx_deser_avmmreaddata[7], w_pma_rx_deser_avmmreaddata[6], w_pma_rx_deser_avmmreaddata[5], w_pma_rx_deser_avmmreaddata[4], w_pma_rx_deser_avmmreaddata[3], w_pma_rx_deser_avmmreaddata[2], w_pma_rx_deser_avmmreaddata[1], w_pma_rx_deser_avmmreaddata[0]};
		assign out_avmmreaddata_pma_rx_dfe = {w_pma_rx_dfe_avmmreaddata[7], w_pma_rx_dfe_avmmreaddata[6], w_pma_rx_dfe_avmmreaddata[5], w_pma_rx_dfe_avmmreaddata[4], w_pma_rx_dfe_avmmreaddata[3], w_pma_rx_dfe_avmmreaddata[2], w_pma_rx_dfe_avmmreaddata[1], w_pma_rx_dfe_avmmreaddata[0]};
		assign out_avmmreaddata_pma_rx_odi = {w_pma_rx_odi_avmmreaddata[7], w_pma_rx_odi_avmmreaddata[6], w_pma_rx_odi_avmmreaddata[5], w_pma_rx_odi_avmmreaddata[4], w_pma_rx_odi_avmmreaddata[3], w_pma_rx_odi_avmmreaddata[2], w_pma_rx_odi_avmmreaddata[1], w_pma_rx_odi_avmmreaddata[0]};
		assign out_avmmreaddata_pma_rx_sd = {w_pma_rx_sd_avmmreaddata[7], w_pma_rx_sd_avmmreaddata[6], w_pma_rx_sd_avmmreaddata[5], w_pma_rx_sd_avmmreaddata[4], w_pma_rx_sd_avmmreaddata[3], w_pma_rx_sd_avmmreaddata[2], w_pma_rx_sd_avmmreaddata[1], w_pma_rx_sd_avmmreaddata[0]};
		assign out_avmmreaddata_pma_tx_buf = {w_pma_tx_buf_avmmreaddata[7], w_pma_tx_buf_avmmreaddata[6], w_pma_tx_buf_avmmreaddata[5], w_pma_tx_buf_avmmreaddata[4], w_pma_tx_buf_avmmreaddata[3], w_pma_tx_buf_avmmreaddata[2], w_pma_tx_buf_avmmreaddata[1], w_pma_tx_buf_avmmreaddata[0]};
		assign out_avmmreaddata_pma_tx_ser = {w_pma_tx_ser_avmmreaddata[7], w_pma_tx_ser_avmmreaddata[6], w_pma_tx_ser_avmmreaddata[5], w_pma_tx_ser_avmmreaddata[4], w_pma_tx_ser_avmmreaddata[3], w_pma_tx_ser_avmmreaddata[2], w_pma_tx_ser_avmmreaddata[1], w_pma_tx_ser_avmmreaddata[0]};
		assign out_blockselect_cdr_pll = w_cdr_pll_blockselect;
		assign out_blockselect_pma_adapt = w_pma_adapt_blockselect;
		assign out_blockselect_pma_cdr_refclk = w_pma_cdr_refclk_blockselect;
		assign out_blockselect_pma_cgb = w_pma_cgb_blockselect;
		assign out_blockselect_pma_rx_buf = w_pma_rx_buf_blockselect;
		assign out_blockselect_pma_rx_deser = w_pma_rx_deser_blockselect;
		assign out_blockselect_pma_rx_dfe = w_pma_rx_dfe_blockselect;
		assign out_blockselect_pma_rx_odi = w_pma_rx_odi_blockselect;
		assign out_blockselect_pma_rx_sd = w_pma_rx_sd_blockselect;
		assign out_blockselect_pma_tx_buf = w_pma_tx_buf_blockselect;
		assign out_blockselect_pma_tx_ser = w_pma_tx_ser_blockselect;
		assign out_clk0_pfd = w_cdr_pll_clk0_pfd;
		assign out_clk180_pfd = w_cdr_pll_clk180_pfd;
		assign out_clk_divrx_iqtxrx = w_pma_rx_deser_clkdiv;
		assign out_clk_divtx_iqtxrx = w_pma_tx_ser_clk_divtx;
		assign out_clkdiv_rx = w_pma_rx_deser_clkdiv;
		assign out_clkdiv_rx_user = w_pma_rx_deser_clkdiv_user;
		assign out_clkdiv_tx = w_pma_tx_ser_clk_divtx;
		assign out_clkdiv_tx_user = w_pma_tx_ser_clk_divtx_user;
		assign out_clklow = w_cdr_pll_clklow;
		assign out_fref = w_cdr_pll_fref;
		assign out_iqtxrxclk_out0 = w_pma_tx_ser_clk_divtx;
		assign out_iqtxrxclk_out1 = w_pma_tx_ser_clk_divtx;
		assign out_jtaglpxn = w_pma_tx_buf_vlptxn;
		assign out_jtaglpxp = w_pma_tx_buf_vlptxp;
		assign out_pcie_sw_done = {w_pma_cgb_pcie_sw_done[1], w_pma_cgb_pcie_sw_done[0]};
		assign out_pcie_sw_master = {w_pma_cgb_pcie_sw_master[1], w_pma_cgb_pcie_sw_master[0]};
		assign out_pfdmode_lock = w_cdr_pll_pfdmode_lock;
		assign out_rx_detect_valid = w_pma_tx_buf_rx_detect_valid;
		assign out_rx_found = w_pma_tx_buf_rx_found;
		assign out_rxdata = {w_pma_rx_deser_dout[63], w_pma_rx_deser_dout[62], w_pma_rx_deser_dout[61], w_pma_rx_deser_dout[60], w_pma_rx_deser_dout[59], w_pma_rx_deser_dout[58], w_pma_rx_deser_dout[57], w_pma_rx_deser_dout[56], w_pma_rx_deser_dout[55], w_pma_rx_deser_dout[54], w_pma_rx_deser_dout[53], w_pma_rx_deser_dout[52], w_pma_rx_deser_dout[51], w_pma_rx_deser_dout[50], w_pma_rx_deser_dout[49], w_pma_rx_deser_dout[48], w_pma_rx_deser_dout[47], w_pma_rx_deser_dout[46], w_pma_rx_deser_dout[45], w_pma_rx_deser_dout[44], w_pma_rx_deser_dout[43], w_pma_rx_deser_dout[42], w_pma_rx_deser_dout[41], w_pma_rx_deser_dout[40], w_pma_rx_deser_dout[39], w_pma_rx_deser_dout[38], w_pma_rx_deser_dout[37], w_pma_rx_deser_dout[36], w_pma_rx_deser_dout[35], w_pma_rx_deser_dout[34], w_pma_rx_deser_dout[33], w_pma_rx_deser_dout[32], w_pma_rx_deser_dout[31], w_pma_rx_deser_dout[30], w_pma_rx_deser_dout[29], w_pma_rx_deser_dout[28], w_pma_rx_deser_dout[27], w_pma_rx_deser_dout[26], w_pma_rx_deser_dout[25], w_pma_rx_deser_dout[24], w_pma_rx_deser_dout[23], w_pma_rx_deser_dout[22], w_pma_rx_deser_dout[21], w_pma_rx_deser_dout[20], w_pma_rx_deser_dout[19], w_pma_rx_deser_dout[18], w_pma_rx_deser_dout[17], w_pma_rx_deser_dout[16], w_pma_rx_deser_dout[15], w_pma_rx_deser_dout[14], w_pma_rx_deser_dout[13], w_pma_rx_deser_dout[12], w_pma_rx_deser_dout[11], w_pma_rx_deser_dout[10], w_pma_rx_deser_dout[9], w_pma_rx_deser_dout[8], w_pma_rx_deser_dout[7], w_pma_rx_deser_dout[6], w_pma_rx_deser_dout[5], w_pma_rx_deser_dout[4], w_pma_rx_deser_dout[3], w_pma_rx_deser_dout[2], w_pma_rx_deser_dout[1], w_pma_rx_deser_dout[0]};
		assign out_rxpll_lock = w_cdr_pll_rxpll_lock;
		assign out_sd = w_pma_rx_sd_sd;
		assign out_tx_n = w_pma_tx_buf_von;
		assign out_tx_p = w_pma_tx_buf_vop;
	endgenerate
endmodule


 // altera message_on 10036

