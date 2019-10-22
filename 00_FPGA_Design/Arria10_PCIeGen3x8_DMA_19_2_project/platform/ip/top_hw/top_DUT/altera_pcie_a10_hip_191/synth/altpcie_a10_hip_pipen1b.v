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



// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings
// altera message_level Level1
// altera message_off 10034 10035 10036 10037 10230 10240 10030

module altpcie_a10_hip_pipen1b # (

      parameter MEM_CHECK=0,
      parameter USE_INTERNAL_250MHZ_PLL = 1,
      parameter hip_reconfig = 0,
      parameter USE_ALTPCIE_RS_HIP_LOGIC = 0,
      parameter cseb_autonomous_hwtcl   = 0, //1: Config-Bypass Autonomous mode
      parameter speed_change_hwtcl      = 0, //1: allow LTSSM to initiate sefl-speed change until link reach max supported speed
      parameter reconfig_address_width_integer_hwtcl              = 11,
      //Virtual Attributes
      parameter func_mode                                         = "enable",
      parameter sup_mode                                          = "user_mode",
      parameter lane_rate                                         = "gen1",
      parameter link_width                                        = "x1",
      parameter port_type                                         = "native_ep",
      parameter pcie_base_spec                                    = "pcie_3p0",
      parameter app_interface_width                               = "avst_64bit",
      parameter rx_buffer_credit_alloc                            = "balance",
      parameter hrdrstctrl_en                                     = "hrdrstctrl_en",
      parameter uc_calibration_en                                 = "uc_calibration_dis",
      parameter cvp_enable                                        = "cvp_dis",
      parameter enable_es_patch                                   = 0,  // Deprecated parameter since 15.0, must be set to 0
      parameter advance_error_reporting                           = "disable",
      parameter sim_mode                                          = "enable",
      parameter bar0_type                                         = "bar0_64bit_prefetch_mem",
      parameter bar1_type                                         = "bar1_disable",
      parameter bar2_type                                         = "bar2_disable",
      parameter bar3_type                                         = "bar3_disable",
      parameter bar4_type                                         = "bar4_disable",
      parameter bar5_type                                         = "bar5_disable",
      parameter bar0_size_mask                                    = 0,
      parameter bar1_size_mask                                    = 0,
      parameter bar2_size_mask                                    = 0,
      parameter bar3_size_mask                                    = 0,
      parameter bar4_size_mask                                    = 0,
      parameter bar5_size_mask                                    = 0,

      //HIP Attributes
      parameter silicon_rev                                       = "20nm5es",
      parameter [12:0] acknack_base                               = 13'h0,
      parameter acknack_set                                       = "false",
      parameter arb_upfc_30us_counter                             = 0,
      parameter arb_upfc_30us_en                                  = "enable",
      parameter aspm_config_management                            = "true",
      parameter aspm_patch_disable                                = "enable_both",
      parameter ast_width_rx                                      = "rx_64",
      parameter ast_width_tx                                      = "tx_64",
      parameter atomic_malformed                                  = "false",
      parameter atomic_op_completer_32bit                         = "false",
      parameter atomic_op_routing                                 = "false",
      parameter atomic_op_completer_64bit                         = "false",
      parameter auto_msg_drop_enable                              = "false",
      parameter base_counter_sel                                  = "count_clk_62p5",
      parameter [83:0] bist_memory_settings                       =  84'h0,
      parameter bridge_port_vga_enable                            = "false",
      parameter bridge_port_ssid_support                          = "false",
      parameter bypass_cdc                                        = "false",
      parameter bypass_clk_switch                                 = "false",
      parameter bypass_tl                                         = "false",
      parameter cas_completer_128bit                              = "false",
      parameter cdc_clk_relation                                  = "plesiochronous",
      parameter [3:0] cdc_dummy_insert_limit                      = 4'd11,
      parameter cfg_parchk_ena                                    = "disable",
      parameter cfgbp_req_recov_disable                           = "false",
      parameter [23:0] class_code                                 = 24'd16711680,
      parameter clock_pwr_management                              = "false",
      parameter completion_timeout                                = "abcd",
      parameter core_clk_divider                                  = "div_1",
      parameter core_clk_freq_mhz                                 = "core_clk_250mhz",
      parameter core_clk_out_sel                                  = "core_clk_out_div_1",
      parameter core_clk_sel                                      = "pld_clk",
      parameter core_clk_source                                   = "pll_fixed_clk",
      parameter cseb_bar_match_checking                           = "enable",
      parameter cseb_config_bypass                                = "disable",
      parameter cseb_cpl_status_during_cvp                        = "completer_abort",
      parameter cseb_cpl_tag_checking                             = "enable",
      parameter cseb_disable_auto_crs                             = "false",
      parameter cseb_extend_pci                                   = "false",
      parameter cseb_extend_pcie                                  = "false",
      parameter cseb_min_error_checking                           = "false",
      parameter cseb_route_to_avl_rx_st                           = "cseb",
      parameter cseb_temp_busy_crs                                = "completer_abort_tmp_busy",
      parameter cvp_clk_reset                                     = "false",
      parameter cvp_data_compressed                               = "false",
      parameter cvp_data_encrypted                                = "false",
      parameter cvp_mode_reset                                    = "false",
      parameter cvp_rate_sel                                      = "full_rate",
      parameter d0_pme                                            = "false",
      parameter d1_pme                                            = "false",
      parameter d2_pme                                            = "false",
      parameter d1_support                                        = "false",
      parameter d2_support                                        = "false",
      parameter d3_hot_pme                                        = "false",
      parameter d3_cold_pme                                       = "false",
      parameter data_pack_rx                                      = "disable",
      parameter deemphasis_enable                                 = "false",
      parameter deskew_comma                                      = "skp_eieos_deskw",
      parameter [15:0] device_id                                  = 16'd57345,
      parameter [4:0] device_number                               = 5'h0,
      parameter device_specific_init                              = "false",
      parameter dft_clock_obsrv_en                                = "disable",
      parameter dft_clock_obsrv_sel                               = "dft_pclk",
      parameter [7:0] diffclock_nfts_count                        = 8'h0,
      parameter dis_cplovf                                        = "disable",
      parameter dis_paritychk                                     = "enable",
      parameter disable_link_x2_support                           = "false",
      parameter disable_snoop_packet                              = "false",
      parameter dl_tx_check_parity_edb                            = "disable",
      parameter dll_active_report_support                         = "false",
      parameter early_dl_up                                       = "true",
      parameter ecrc_check_capable                                = "true",
      parameter ecrc_gen_capable                                  = "true",
      parameter egress_block_err_report_ena                       = "false",
      parameter [7:0] ei_delay_powerdown_count                    = 8'd10,
      parameter [3:0] eie_before_nfts_count                       = 4'h4,
      parameter electromech_interlock                             = "false",
      parameter en_ieiupdatefc                                    = "false",
      parameter en_lane_errchk                                    = "false",
      parameter en_phystatus_dly                                  = "false",
      parameter ena_ido_cpl                                       = "false",
      parameter ena_ido_req                                       = "false",
      parameter enable_adapter_half_rate_mode                     = "false",
      parameter enable_ch0_pclk_out                               = "pclk_ch01",
      parameter enable_ch01_pclk_out                              = "pclk_ch0",
      parameter enable_completion_timeout_disable                 = "true",
      parameter enable_directed_spd_chng                          = "false",
      parameter enable_function_msix_support                      = "true",
      parameter enable_l0s_aspm                                   = "false",
      parameter enable_l1_aspm                                    = "false",
      parameter enable_rx_buffer_checking                         = "false",
      parameter enable_rx_reordering                              = "true",
      parameter enable_slot_register                              = "false",
      parameter [2:0] endpoint_l0_latency                         = 3'h0,
      parameter [2:0] endpoint_l1_latency                         = 3'h0,
      parameter [5:0] eql_rq_int_en_number                        = 6'h0,
      parameter errmgt_fcpe_patch_dis                             = "enable",
      parameter errmgt_fep_patch_dis                              = "enable",
      parameter [31:0] expansion_base_address_register            = 32'h0,
      parameter extend_tag_field                                  = "false",
      parameter extended_format_field                             = "false",
      parameter extended_tag_reset                                = "false",
      parameter [10:0] fc_init_timer                              = 11'b10000000000,
      parameter [7:0] flow_control_timeout_count                  = 8'b11001000,
      parameter [4:0] flow_control_update_count                   = 5'b1110,
      parameter flr_capability                                    = "true",
      parameter force_dis_to_det                                  = "false",
      parameter force_gen1_dis                                    = "false",
      parameter force_tx_coeff_preset_lpbk                        = "false",
      parameter frame_err_patch_dis                               = "enable",
      parameter g3_bypass_equlz                                   = "false",
      parameter g3_coeff_done_tmout                               = "enable",
      parameter g3_deskew_char                                    = "default_sdsos",
      parameter g3_dis_be_frm_err                                 = "false",
      parameter [2:0] g3_dn_rx_hint_eqlz_0                        = 3'h0,
      parameter [2:0] g3_dn_rx_hint_eqlz_1                        = 3'h0,
      parameter [2:0] g3_dn_rx_hint_eqlz_2                        = 3'h0,
      parameter [2:0] g3_dn_rx_hint_eqlz_3                        = 3'h0,
      parameter [2:0] g3_dn_rx_hint_eqlz_4                        = 3'h0,
      parameter [2:0] g3_dn_rx_hint_eqlz_5                        = 3'h0,
      parameter [2:0] g3_dn_rx_hint_eqlz_6                        = 3'h0,
      parameter [2:0] g3_dn_rx_hint_eqlz_7                        = 3'h0,
      parameter [3:0] g3_dn_tx_preset_eqlz_0                      = 4'h0,
      parameter [3:0] g3_dn_tx_preset_eqlz_1                      = 4'h0,
      parameter [3:0] g3_dn_tx_preset_eqlz_2                      = 4'h0,
      parameter [3:0] g3_dn_tx_preset_eqlz_3                      = 4'h0,
      parameter [3:0] g3_dn_tx_preset_eqlz_4                      = 4'h0,
      parameter [3:0] g3_dn_tx_preset_eqlz_5                      = 4'h0,
      parameter [3:0] g3_dn_tx_preset_eqlz_6                      = 4'h0,
      parameter [3:0] g3_dn_tx_preset_eqlz_7                      = 4'h0,
      parameter g3_force_ber_max                                  = "false",
      parameter g3_force_ber_min                                  = "false",
      parameter g3_lnk_trn_rx_ts                                  = "false",
      parameter g3_ltssm_eq_dbg                                   = "false",
      parameter g3_ltssm_rec_dbg                                  = "false",
      parameter g3_pause_ltssm_rec_en                             = "disable",
      parameter g3_quiesce_guarant                                = "false",
      parameter g3_redo_equlz_dis                                 = "false",
      parameter g3_redo_equlz_en                                  = "false",
      parameter [2:0] g3_up_rx_hint_eqlz_0                        = 3'h0,
      parameter [2:0] g3_up_rx_hint_eqlz_1                        = 3'h0,
      parameter [2:0] g3_up_rx_hint_eqlz_2                        = 3'h0,
      parameter [2:0] g3_up_rx_hint_eqlz_3                        = 3'h0,
      parameter [2:0] g3_up_rx_hint_eqlz_4                        = 3'h0,
      parameter [2:0] g3_up_rx_hint_eqlz_5                        = 3'h0,
      parameter [2:0] g3_up_rx_hint_eqlz_6                        = 3'h0,
      parameter [2:0] g3_up_rx_hint_eqlz_7                        = 3'h0,
      parameter [3:0] g3_up_tx_preset_eqlz_0                      = 4'h0,
      parameter [3:0] g3_up_tx_preset_eqlz_1                      = 4'h0,
      parameter [3:0] g3_up_tx_preset_eqlz_2                      = 4'h0,
      parameter [3:0] g3_up_tx_preset_eqlz_3                      = 4'h0,
      parameter [3:0] g3_up_tx_preset_eqlz_4                      = 4'h0,
      parameter [3:0] g3_up_tx_preset_eqlz_5                      = 4'h0,
      parameter [3:0] g3_up_tx_preset_eqlz_6                      = 4'h0,
      parameter [3:0] g3_up_tx_preset_eqlz_7                      = 4'h0,
      parameter gen123_lane_rate_mode                             = "gen1_rate",
      parameter [7:0] gen2_diffclock_nfts_count                   = 8'd255,
      parameter gen2_pma_pll_usage                                = "not_applicaple",
      parameter [7:0] gen2_sameclock_nfts_count                   = 8'd255,

      parameter [17:0]gen3_coeff_1                                = 18'h4,
      parameter       gen3_coeff_1_sel                            = "preset_1",
      parameter [2:0] gen3_coeff_1_preset_hint                    = 3'b010,
      parameter [3:0] gen3_coeff_1_nxtber_more                    = 4'd6,
      parameter [3:0] gen3_coeff_1_nxtber_less                    = 4'd12,
      parameter [4:0] gen3_coeff_1_reqber                         = 5'h8,
      parameter [5:0] gen3_coeff_1_ber_meas                       = 6'h2,
      parameter [17:0]gen3_coeff_2                                = 18'h1,
      parameter       gen3_coeff_2_sel                            = "preset_2",
      parameter [2:0] gen3_coeff_2_preset_hint                    = 3'b100,
      parameter [3:0] gen3_coeff_2_nxtber_more                    = 4'h4,
      parameter [3:0] gen3_coeff_2_nxtber_less                    = 4'h2,
      parameter [4:0] gen3_coeff_2_reqber                         = 5'h8,
      parameter [5:0] gen3_coeff_2_ber_meas                       = 6'h2,
      parameter [17:0]gen3_coeff_3                                = 18'h1,
      parameter       gen3_coeff_3_sel                            = "preset_3",
      parameter [2:0] gen3_coeff_3_preset_hint                    = 3'h0,
      parameter [3:0] gen3_coeff_3_nxtber_more                    = 4'h3,
      parameter [3:0] gen3_coeff_3_nxtber_less                    = 4'd15,
      parameter [4:0] gen3_coeff_3_reqber                         = 5'h8,
      parameter [5:0] gen3_coeff_3_ber_meas                       = 6'h2,
      parameter [17:0]gen3_coeff_4                                = 18'h0,
      parameter       gen3_coeff_4_sel                            = "preset_4",
      parameter [2:0] gen3_coeff_4_preset_hint                    = 0,
      parameter [3:0] gen3_coeff_4_nxtber_more                    = 4'h4,
      parameter [3:0] gen3_coeff_4_nxtber_less                    = 4'd15,
      parameter [4:0] gen3_coeff_4_reqber                         = 5'h8,
      parameter [5:0] gen3_coeff_4_ber_meas                       = 6'h2,
      parameter [17:0]gen3_coeff_5                                = 0,
      parameter       gen3_coeff_5_sel                            = "preset_5",
      parameter [2:0] gen3_coeff_5_preset_hint                    = 3'b100,
      parameter [3:0] gen3_coeff_5_nxtber_more                    = 4'd5,
      parameter [3:0] gen3_coeff_5_nxtber_less                    = 4'd15,
      parameter [4:0] gen3_coeff_5_reqber                         = 5'h8,
      parameter [5:0] gen3_coeff_5_ber_meas                       = 6'h2,
      parameter [17:0]gen3_coeff_6                                = 18'h7,
      parameter       gen3_coeff_6_sel                            = "preset_6",
      parameter [2:0] gen3_coeff_6_preset_hint                    = 3'b100,
      parameter [3:0] gen3_coeff_6_nxtber_more                    = 4'd15,
      parameter [3:0] gen3_coeff_6_nxtber_less                    = 4'd15,
      parameter [4:0] gen3_coeff_6_reqber                         = 5'h8,
      parameter [5:0] gen3_coeff_6_ber_meas                       = 6'h2,
      parameter [17:0]gen3_coeff_7                                = 18'h1,
      parameter       gen3_coeff_7_sel                            = "preset_7",
      parameter [2:0] gen3_coeff_7_preset_hint                    = 3'b010,
      parameter [3:0] gen3_coeff_7_nxtber_more                    = 4'h7,
      parameter [3:0] gen3_coeff_7_nxtber_less                    = 4'h1,
      parameter [4:0] gen3_coeff_7_reqber                         = 5'h8,
      parameter [5:0] gen3_coeff_7_ber_meas                       = 6'h2,
      parameter [17:0]gen3_coeff_8                                = 0,
      parameter       gen3_coeff_8_sel                            = "preset_8",
      parameter [2:0] gen3_coeff_8_preset_hint                    = 3'b010,
      parameter [3:0] gen3_coeff_8_nxtber_more                    = 4'h8,
      parameter [3:0] gen3_coeff_8_nxtber_less                    = 4'h4,
      parameter [4:0] gen3_coeff_8_reqber                         = 5'h8,
      parameter [5:0] gen3_coeff_8_ber_meas                       = 6'h2,
      parameter [17:0]gen3_coeff_9                                = 0,
      parameter       gen3_coeff_9_sel                            = "preset_9",
      parameter [2:0] gen3_coeff_9_preset_hint                    = 3'b011,
      parameter [3:0] gen3_coeff_9_nxtber_more                    = 4'h9,
      parameter [3:0] gen3_coeff_9_nxtber_less                    = 4'd11,
      parameter [4:0] gen3_coeff_9_reqber                         = 5'h8,
      parameter [5:0] gen3_coeff_9_ber_meas                       = 6'h2,
      parameter [17:0]gen3_coeff_10                               = 18'h7,
      parameter       gen3_coeff_10_sel                           = "preset_10",
      parameter [2:0] gen3_coeff_10_preset_hint                   = 3'b011,
      parameter [3:0] gen3_coeff_10_nxtber_more                   = 4'd10,
      parameter [3:0] gen3_coeff_10_nxtber_less                   = 4'd15,
      parameter [4:0] gen3_coeff_10_reqber                        = 5'h8,
      parameter [5:0] gen3_coeff_10_ber_meas                      = 6'h2,
      parameter [17:0]gen3_coeff_11                               = 18'h7,
      parameter       gen3_coeff_11_sel                           = "preset_11",
      parameter [2:0] gen3_coeff_11_preset_hint                   = 3'b100,
      parameter [3:0] gen3_coeff_11_nxtber_more                   = 4'd15,
      parameter [3:0] gen3_coeff_11_nxtber_less                   = 4'd15,
      parameter [4:0] gen3_coeff_11_reqber                        = 5'h8,
      parameter [5:0] gen3_coeff_11_ber_meas                      = 6'h2,
      parameter [17:0]gen3_coeff_12                               = 18'h7,
      parameter       gen3_coeff_12_sel                           = "preset_12",
      parameter [2:0] gen3_coeff_12_preset_hint                   = 3'b010,
      parameter [3:0] gen3_coeff_12_nxtber_more                   = 4'd15,
      parameter [3:0] gen3_coeff_12_nxtber_less                   = 4'd15,
      parameter [4:0] gen3_coeff_12_reqber                        = 5'h8,
      parameter [5:0] gen3_coeff_12_ber_meas                      = 6'h2,
      parameter [17:0]gen3_coeff_13                               = 18'h4,
      parameter       gen3_coeff_13_sel                           = "preset_13",
      parameter [2:0] gen3_coeff_13_preset_hint                   = 3'b100,
      parameter [3:0] gen3_coeff_13_nxtber_more                   = 4'h1,
      parameter [3:0] gen3_coeff_13_nxtber_less                   = 4'd13,
      parameter [4:0] gen3_coeff_13_reqber                        = 5'h8,
      parameter [5:0] gen3_coeff_13_ber_meas                      = 6'h2,
      parameter [17:0]gen3_coeff_14                               = 18'h4,
      parameter       gen3_coeff_14_sel                           = "preset_14",
      parameter [2:0] gen3_coeff_14_preset_hint                   = 0,
      parameter [3:0] gen3_coeff_14_nxtber_more                   = 4'h2,
      parameter [3:0] gen3_coeff_14_nxtber_less                   = 4'd15,
      parameter [4:0] gen3_coeff_14_reqber                        = 5'h8,
      parameter [5:0] gen3_coeff_14_ber_meas                      = 6'h2,
      parameter [17:0]gen3_coeff_15                               = 0,
      parameter       gen3_coeff_15_sel                           = "coeff_15",
      parameter [2:0] gen3_coeff_15_preset_hint                   = 0,
      parameter [3:0] gen3_coeff_15_nxtber_more                   = 0,
      parameter [3:0] gen3_coeff_15_nxtber_less                   = 0,
      parameter [4:0] gen3_coeff_15_reqber                        = 0,
      parameter [5:0] gen3_coeff_15_ber_meas                      = 0,
      parameter [17:0]gen3_coeff_16                               = 0,
      parameter       gen3_coeff_16_sel                           = "coeff_16",
      parameter [2:0] gen3_coeff_16_preset_hint                   = 0,
      parameter [3:0] gen3_coeff_16_nxtber_more                   = 0,
      parameter [3:0] gen3_coeff_16_nxtber_less                   = 0,
      parameter [4:0] gen3_coeff_16_reqber                        = 0,
      parameter [5:0] gen3_coeff_16_ber_meas                      = 0,
      parameter [17:0]gen3_coeff_17                               = 0,
      parameter       gen3_coeff_17_sel                           = "coeff_17",
      parameter [2:0] gen3_coeff_17_preset_hint                   = 0,
      parameter [3:0] gen3_coeff_17_nxtber_more                   = 0,
      parameter [3:0] gen3_coeff_17_nxtber_less                   = 0,
      parameter [4:0] gen3_coeff_17_reqber                        = 0,
      parameter [5:0] gen3_coeff_17_ber_meas                      = 0,
      parameter [17:0]gen3_coeff_18                               = 0,
      parameter       gen3_coeff_18_sel                           = "coeff_18",
      parameter [2:0] gen3_coeff_18_preset_hint                   = 0,
      parameter [3:0] gen3_coeff_18_nxtber_more                   = 0,
      parameter [3:0] gen3_coeff_18_nxtber_less                   = 0,
      parameter [4:0] gen3_coeff_18_reqber                        = 0,
      parameter [5:0] gen3_coeff_18_ber_meas                      = 0,
      parameter [17:0]gen3_coeff_19                               = 0,
      parameter       gen3_coeff_19_sel                           = "coeff_19",
      parameter [2:0] gen3_coeff_19_preset_hint                   = 0,
      parameter [3:0] gen3_coeff_19_nxtber_more                   = 0,
      parameter [3:0] gen3_coeff_19_nxtber_less                   = 0,
      parameter [4:0] gen3_coeff_19_reqber                        = 0,
      parameter [5:0] gen3_coeff_19_ber_meas                      = 0,
      parameter [17:0]gen3_coeff_20                               = 0,
      parameter       gen3_coeff_20_sel                           = "coeff_20",
      parameter [2:0] gen3_coeff_20_preset_hint                   = 0,
      parameter [3:0] gen3_coeff_20_nxtber_more                   = 0,
      parameter [3:0] gen3_coeff_20_nxtber_less                   = 0,
      parameter [4:0] gen3_coeff_20_reqber                        = 0,
      parameter [5:0] gen3_coeff_20_ber_meas                      = 0,
      parameter [17:0]gen3_coeff_21                               = 0,
      parameter       gen3_coeff_21_sel                           = "coeff_21",
      parameter [2:0] gen3_coeff_21_preset_hint                   = 0,
      parameter [3:0] gen3_coeff_21_nxtber_more                   = 0,
      parameter [3:0] gen3_coeff_21_nxtber_less                   = 0,
      parameter [4:0] gen3_coeff_21_reqber                        = 0,
      parameter [5:0] gen3_coeff_21_ber_meas                      = 0,
      parameter [17:0]gen3_coeff_22                               = 0,
      parameter       gen3_coeff_22_sel                           = "coeff_22",
      parameter [2:0] gen3_coeff_22_preset_hint                   = 0,
      parameter [3:0] gen3_coeff_22_nxtber_more                   = 0,
      parameter [3:0] gen3_coeff_22_nxtber_less                   = 0,
      parameter [4:0] gen3_coeff_22_reqber                        = 0,
      parameter [5:0] gen3_coeff_22_ber_meas                      = 0,
      parameter [17:0]gen3_coeff_23                               = 0,
      parameter       gen3_coeff_23_sel                           = "coeff_23",
      parameter [2:0] gen3_coeff_23_preset_hint                   = 0,
      parameter [3:0] gen3_coeff_23_nxtber_more                   = 0,
      parameter [3:0] gen3_coeff_23_nxtber_less                   = 0,
      parameter [4:0] gen3_coeff_23_reqber                        = 0,
      parameter [5:0] gen3_coeff_23_ber_meas                      = 0,
      parameter [17:0]gen3_coeff_24                               = 0,
      parameter       gen3_coeff_24_sel                           = "coeff_24",
      parameter [2:0] gen3_coeff_24_preset_hint                   = 0,
      parameter [3:0] gen3_coeff_24_nxtber_more                   = 0,
      parameter [3:0] gen3_coeff_24_nxtber_less                   = 0,
      parameter [4:0] gen3_coeff_24_reqber                        = 0,
      parameter [5:0] gen3_coeff_24_ber_meas                      = 0,

      parameter [6:0] gen3_coeff_delay_count                      = 7'b1111101,
      parameter       gen3_coeff_errchk                           = "enable",
      parameter       gen3_dcbal_en                               = "true",
      parameter [7:0] gen3_diffclock_nfts_count                   = 8'b10000000,
      parameter       gen3_force_local_coeff                      = "false",
      parameter [5:0] gen3_full_swing                             = 6'b111111,
      parameter       gen3_half_swing                             = "false",
      parameter [5:0] gen3_low_freq                               = 0,
      parameter       gen3_paritychk                              = "enable",
      parameter       gen3_pl_framing_err_dis                     = "enable",
      parameter [17:0] gen3_preset_coeff_1                        = 18'd3402,
      parameter [17:0] gen3_preset_coeff_2                        = 18'd3339,
      parameter [17:0] gen3_preset_coeff_3                        = 18'd3213,
      parameter [17:0] gen3_preset_coeff_4                        = 18'd3528,
      parameter [17:0] gen3_preset_coeff_5                        = 18'd4032,
      parameter [17:0] gen3_preset_coeff_6                        = 18'd28224,
      parameter [17:0] gen3_preset_coeff_7                        = 18'd36288,
      parameter [17:0] gen3_preset_coeff_8                        = 18'd27405,
      parameter [17:0] gen3_preset_coeff_9                        = 18'd35784,
      parameter [17:0] gen3_preset_coeff_10                       = 18'd48384,
      parameter [17:0] gen3_preset_coeff_11                       = 18'd124992,
      parameter       gen3_reset_eieos_cnt_bit                    = "false",
      parameter [19:0]gen3_rxfreqlock_counter                     = 20'h0,
      parameter [7:0] gen3_sameclock_nfts_count                   = 8'b10000000,
      parameter       gen3_scrdscr_bypass                         = "false",
      parameter       gen3_skip_ph2_ph3                           = "false",
      parameter       hard_reset_bypass                           = "false",
      parameter       hard_rst_sig_chnl_en                        = "disable_hrc_sig",
      parameter       hard_rst_tx_pll_rst_chnl_en                 = "disable_hrc_txpll_rst",
      parameter [9:0] hip_base_address                            = 10'h0,
      parameter       hip_clock_dis                               = "enable_hip_clk",
      parameter       hip_hard_reset                              = "enable",
      parameter       hip_pcs_sig_chnl_en                         = "disable_hip_pcs_sig",
      parameter [6:0] hot_plug_support                            = 0,
      parameter       hrc_chnl_txpll_master_cgb_rst_select        = "disable_master_cgb_sel",
      parameter       iei_enable_settings                         = "gen3gen2_infei_infsd_gen1_infei_sd",
      parameter [2:0] indicator                                   = 0,
      parameter       intel_id_access                             = "false",
      parameter       interrupt_pin                               = "inta",
      parameter       io_window_addr_width                        = "window_32_bit",
      parameter [127:0] jtag_id                                   = 128'h0,
      parameter [2:0] l0_exit_latency_diffclock                   = 3'h6,
      parameter [2:0] l0_exit_latency_sameclock                   = 3'h6,
      parameter [4:0] l01_entry_latency                           = 5'd31,
      parameter       l0s_adj_rply_timer_dis                      = "enable",
      parameter [2:0] l1_exit_latency_diffclock                   = 3'h0,
      parameter [2:0] l1_exit_latency_sameclock                   = 3'h0,
      parameter       l2_async_logic                              = "disable",
      parameter       lane_mask                                   = "ln_mask_x4",
      parameter       low_priority_vc                             = "single_vc_low_pr",
      parameter       ltr_mechanism                               = "false",
      parameter       ltssm_1ms_timeout                           = "disable",
      parameter       ltssm_freqlocked_check                      = "disable",
      parameter       malformed_tlp_truncate_en                   = "disable",
      parameter       max_link_width                              = "x4_link_width",
      parameter       max_payload_size                            = "payload_512",
      parameter [2:0] maximum_current                             = 3'h0,
      parameter [19:0]millisecond_cycle_count                     = 20'h0,
      parameter       msi_64bit_addressing_capable                = "true",
      parameter       msi_masking_capable                         = "false",
      parameter       msi_multi_message_capable                   = "count_4",
      parameter       msi_support                                 = "true",
      parameter [2:0] msix_pba_bir                                = 3'h0,
      parameter [28:0]msix_pba_offset                             = 29'h0,
      parameter [2:0] msix_table_bir                              = 3'h0,
      parameter [28:0]msix_table_offset                           = 29'h0,
      parameter [10:0]msix_table_size                             = 11'h0,
      parameter       national_inst_thru_enhance                  = "true",
      parameter       no_command_completed                        = "true",
      parameter       no_soft_reset                               = "false",
      parameter       pcie_mode                                   = "shared_mode",
      parameter       pcie_spec_1p0_compliance                    = "spec_1p1",
      parameter       pcie_spec_version                           = "v2",
      parameter       pclk_out_sel                                = "pclk",
      parameter       pld_in_use_reg                              = "false",
      parameter       pm_latency_patch_dis                        = "enable",
      parameter       pm_txdl_patch_dis                           = "enable",
      parameter       pme_clock                                   = "false",
      parameter [7:0] port_link_number                            = 8'h1,
      parameter       powerdown_mode                              = "powerup",
      parameter       prefetchable_mem_window_addr_width          = "prefetch_32",
      parameter       r2c_mask_easy                               = "false",
      parameter       r2c_mask_enable                             = "false",
      parameter       rec_frqlk_mon_en                            = "disable",
      parameter       register_pipe_signals                       = "false",
      parameter [9:0] retry_buffer_last_active_address            = 10'd1023,
      parameter [35:0]retry_buffer_memory_settings                = 36'h0,
      parameter       retry_ecc_corr_mask_dis                     = "enable",
      parameter [7:0] revision_id                                 = 8'h1,
      parameter       role_based_error_reporting                  = "false",
      parameter [6:0] rp_bug_fix_pri_sec_stat_reg                 = 7'b1111111,
      parameter [12:0]rpltim_base                                 = 13'h10,
      parameter       rpltim_set                                  = "false",
      parameter       rstctl_ltssm_dis                            = "false",
      parameter       [19:0] rstctrl_1ms_count_fref_clk           = 20'd62500,
      parameter       [19:0] rstctrl_1us_count_fref_clk           = 20'd63,
      parameter       rstctrl_pld_clr                             = "false",
      parameter       rstctrl_pll_cal_done_select                 = "not_active_pll_cal_done",
      parameter       rstctrl_debug_en                            = "false",
      parameter       rstctrl_force_inactive_rst                  = "false",
      parameter       rstctrl_perst_enable                        = "level",
      parameter       rstctrl_hip_ep                              = "hip_ep",
      parameter       rstctrl_hard_block_enable                   = "hard_rst_ctl",
      parameter       rstctrl_rx_pma_rstb_inv                     = "false",
      parameter       rstctrl_tx_pma_rstb_inv                     = "false",
      parameter       rstctrl_rx_pcs_rst_n_inv                    = "false",
      parameter       rstctrl_tx_pcs_rst_n_inv                    = "false",
      parameter       rstctrl_altpe3_crst_n_inv                   = "false",
      parameter       rstctrl_altpe3_srst_n_inv                   = "false",
      parameter       rstctrl_altpe3_rst_n_inv                    = "false",
      parameter       rstctrl_chnl_cal_done_select                = "not_active_chnl_cal_done",
      parameter       rstctrl_tx_pma_syncp_inv                    = "false",
      parameter       rstctrl_rx_pma_rstb_select                 = "not_active_rx_pma_rstb",
      parameter       rstctrl_rx_pll_freq_lock_select            = "not_active_rx_pll_f_lock",
      parameter       rstctrl_mask_tx_pll_lock_select            = "not_active_mask_tx_pll_lock",
      parameter       rstctrl_rx_pll_lock_select                 = "not_active_rx_pll_lock",
      parameter       rstctrl_perstn_select                      = "perstn_pin",
      parameter       rstctrl_fref_clk_select                    = "ch0_sel",
      parameter       rstctrl_tx_pma_syncp_select                = "not_active_tx_pma_syncp",
      parameter       rstctrl_rx_pcs_rst_n_select                = "not_active_rx_pcs_rst",
      parameter       rstctrl_tx_pcs_rst_n_select                = "not_active_tx_pcs_rst",
      parameter       rstctrl_timer_a_type                       = "a_timer_milli_secs",
      parameter       [7:0] rstctrl_timer_a                      = 8'd10,
      parameter       rstctrl_timer_b_type                       = "b_timer_milli_secs",
      parameter       [7:0] rstctrl_timer_b                      = 8'd10,
      parameter       rstctrl_timer_c_type                       = "c_timer_milli_secs",
      parameter       [7:0] rstctrl_timer_c                      = 8'd10,
      parameter       rstctrl_timer_d_type                       = "d_timer_milli_secs",
      parameter       [7:0] rstctrl_timer_d                      = 8'd20,
      parameter       rstctrl_timer_e_type                       = "e_timer_milli_secs",
      parameter       [7:0] rstctrl_timer_e                      = 8'd1,
      parameter       rstctrl_timer_f_type                       = "f_timer_milli_secs",
      parameter       [7:0] rstctrl_timer_f                      = 8'd10,
      parameter       rstctrl_timer_g_type                       = "g_timer_milli_secs",
      parameter       [7:0] rstctrl_timer_g                      = 8'd10,
      parameter       rstctrl_timer_h_type                       = "h_timer_milli_secs",
      parameter       [7:0] rstctrl_timer_h                      = 8'd4,
      parameter       rstctrl_timer_i_type                       = "i_timer_milli_secs",
      parameter       [7:0] rstctrl_timer_i                      = 8'd20,
      parameter       rstctrl_timer_j_type                       = "j_timer_milli_secs",
      parameter       [7:0] rstctrl_timer_j                      = 8'd20,
      parameter       rstctrl_tx_lcff_pll_lock_select            = "not_active_lcff_pll_lock",
      parameter       rstctrl_tx_lcff_pll_rstb_select            = "not_active_lcff_pll_rstb",
      parameter       rx_ast_parity                              = "disable",
      parameter       tx_ast_parity                              = "disable",
      parameter [19:0]rx_buffer_fc_protect                       = 20'd68,
      parameter [10:0]rx_buffer_protect                          = 20'd68,
      parameter [3:0] rx_cdc_almost_empty                        = 4'h3,
      parameter [3:0] rx_cdc_almost_full                         = 4'd12,
      parameter       rx_cred_ctl_param                          = "disable",
      parameter       rx_ei_l0s                                  = "disable",
      parameter [7:0] rx_l0s_count_idl                           = 8'h0,
      parameter [10:0]rx_ptr0_posted_dpram_min                   = 11'h0,
      parameter [10:0]rx_ptr0_posted_dpram_max                   = 11'h0,
      parameter [10:0]rx_ptr0_nonposted_dpram_min                = 11'h0,
      parameter [10:0]rx_ptr0_nonposted_dpram_max                = 11'h0,
      parameter       rx_runt_patch_dis                          = "enable",
      parameter       rx_sop_ctrl                                = "rx_sop_boundary_64",
      parameter       rx_trunc_patch_dis                         = "enable",
      parameter       rx_use_prst                                = "false",
      parameter       rx_use_prst_ep                             = "true",
      parameter       rxbuf_ecc_corr_mask_dis                    = "enable",
      parameter [7:0] sameclock_nfts_count                       = 8'h0,
      parameter       sel_enable_pcs_rx_fifo_err                 = "disable_sel",
      parameter       simple_ro_fifo_control_en                  = "disable",
      parameter       single_rx_detect                           = "detect_all_lanes",
      parameter [10:0]skp_os_gen3_count                          = 11'h0,
      parameter [10:0]skp_os_schedule_count                      = 11'h0,
      parameter [12:0]slot_number                                = 13'h0,
      parameter [7:0] slot_power_limit                           = 8'h0,
      parameter [1:0] slot_power_scale                           = 2'h0,
      parameter       slotclk_cfg                                = "static_slotclkcfgon",
      parameter [15:0]ssvid                                      = 16'h0,
      parameter [15:0]ssid                                       = 16'h0,
      parameter [15:0]subsystem_vendor_id                        = 16'd4466,
      parameter [15:0]subsystem_device_id                        = 16'd57345,
      parameter       surprise_down_error_support                = "false",
      parameter       tl_cfg_div                                 = "cfg_clk_div_7",
      parameter       tl_tx_check_parity_msg                     = "disable",
      parameter       tph_completer                              = "false",
      parameter [3:0] tx_cdc_almost_empty                        = 4'd5,
      parameter [3:0] tx_cdc_almost_full                         = 4'd12,
      parameter       tx_sop_ctrl                                = "boundary_64",
      parameter [7:0] tx_swing                                   = 8'h0,
      parameter [3:0] txdl_fair_arbiter_counter                  = 4'h0,
      parameter       txdl_fair_arbiter_en                       = "enable",
      parameter       txrate_adv                                 = "capability",
      parameter       use_aer                                    = "false",
      parameter       use_crc_forwarding                         = "false",
      parameter [15:0]user_id                                    = 16'h0,
      parameter       vc_arbitration                             = "single_vc_arb",
      parameter       vc_enable                                  = "single_vc",
      parameter       vc0_clk_enable                             = "true",
      parameter [35:0]vc0_rx_buffer_memory_settings              = 36'h0,
      parameter [7:0] vc0_rx_flow_ctrl_posted_header             = 8'd50,
      parameter [11:0]vc0_rx_flow_ctrl_posted_data               = 12'd360,
      parameter [7:0] vc0_rx_flow_ctrl_nonposted_header          = 8'd54,
      parameter [7:0] vc0_rx_flow_ctrl_nonposted_data            = 8'd0,
      parameter [7:0] vc0_rx_flow_ctrl_compl_header              = 8'd112,
      parameter [11:0]vc0_rx_flow_ctrl_compl_data                = 12'd448,
      parameter [7:0] ko_compl_header                            = 8'd0,
      parameter [11:0] ko_compl_data                             = 12'd0,
      parameter       vc1_clk_enable                             = "false",
      parameter [15:0]vendor_id                                  = 16'd4466,
      parameter [3:0] vsec_cap                                   = 4'h0,
      parameter [15:0]vsec_id                                    = 16'd4466,
      parameter       wrong_device_id                            = "disable",
      parameter       not_use_k_gbl_bits                         = "not_used_k_gbl",
      parameter       avmm_force_inter_sel_csr_ctrl              = "disable",
      parameter       operating_voltage                          = "standard",
      parameter       rxdl_bad_tlp_patch_dis                     = "rxdlbug2_enable_both",
      parameter       avmm_dprio_broadcast_en_csr_ctrl           = "disable",
      parameter       hip_ac_pwr_uw_per_mhz                      = 30'd0,
      parameter       hip_ac_pwr_clk_freq_in_hz                  = 30'd0,
      parameter       rxdl_bad_sop_eop_filter_dis                = "rxdlbug1_enable_both",
      parameter       rxdl_lcrc_patch_dis                        = "rxdlbug3_enable_both",
      parameter       capab_rate_rxcfg_en                        = "disable",
      parameter       avmm_cvp_inter_sel_csr_ctrl                = "disable",
      parameter       lmi_hold_off_cfg_timer_en                  = "disable",
      parameter       avmm_power_iso_en_csr_ctrl                 = "disable",
      parameter       eco_fb332688_dis                           = "true", 

      // PCIe Inspector
      parameter       TLP_INSPECTOR                              = 0,
      parameter       TLP_INSPECTOR_USE_SIGNAL_PROBE             = 0,
      parameter       TLP_INSPECTOR_POWER_UP_TRIGGER             = 128'h0,
      parameter       inspector_enable                           = 0,
      parameter       export_phy_input_to_top_level_hwtcl        = 0,
      parameter       adme_enable_hwtcl                          = 0,

     //DFE enable
      parameter       enable_soft_dfe                            = 0,

      //rx_polarity_inversion_soft_logic
      parameter       rx_polinv_soft_logic_enable                = 0,
      
      parameter       enable_skp_det                             = 0
      )
      (
      // Reset signals
      input                 pipe32_sim_only, // when set, enable pipe 32-bit simulation
      input                 pin_perst,
      input                 npor,
      output                reset_status,
      output                serdes_pll_locked,

      // Clock
      input                 pld_clk,
      input                 pclk_in,
      output                pld_clk_inuse,
      input                 pld_core_ready,

      // Serdes related
      input                 refclk,

      // HIP control signals
      input  [1 : 0]        mode,
      input  [4 : 0]        hpg_ctrler,
      input  [1 : 0]        swctmod,
      input  [63 : 0]       test_in,
      output [319 : 0]      test_out,

      // Input PIPE simulation _ext for simulation only
      input                 phystatus0_ext,
      input                 phystatus1_ext,
      input                 phystatus2_ext,
      input                 phystatus3_ext,
      input                 phystatus4_ext,
      input                 phystatus5_ext,
      input                 phystatus6_ext,
      input                 phystatus7_ext,
      input  [31 : 0]       rxdata0_ext,
      input  [31 : 0]       rxdata1_ext,
      input  [31 : 0]       rxdata2_ext,
      input  [31 : 0]       rxdata3_ext,
      input  [31 : 0]       rxdata4_ext,
      input  [31 : 0]       rxdata5_ext,
      input  [31 : 0]       rxdata6_ext,
      input  [31 : 0]       rxdata7_ext,
      input  [ 3 : 0]       rxdatak0_ext,
      input  [ 3 : 0]       rxdatak1_ext,
      input  [ 3 : 0]       rxdatak2_ext,
      input  [ 3 : 0]       rxdatak3_ext,
      input  [ 3 : 0]       rxdatak4_ext,
      input  [ 3 : 0]       rxdatak5_ext,
      input  [ 3 : 0]       rxdatak6_ext,
      input  [ 3 : 0]       rxdatak7_ext,
      input                 rxelecidle0_ext,
      input                 rxelecidle1_ext,
      input                 rxelecidle2_ext,
      input                 rxelecidle3_ext,
      input                 rxelecidle4_ext,
      input                 rxelecidle5_ext,
      input                 rxelecidle6_ext,
      input                 rxelecidle7_ext,
      input  [2 : 0]        rxstatus0_ext,
      input  [2 : 0]        rxstatus1_ext,
      input  [2 : 0]        rxstatus2_ext,
      input  [2 : 0]        rxstatus3_ext,
      input  [2 : 0]        rxstatus4_ext,
      input  [2 : 0]        rxstatus5_ext,
      input  [2 : 0]        rxstatus6_ext,
      input  [2 : 0]        rxstatus7_ext,
      input                 rxdataskip0_ext,
      input                 rxdataskip1_ext,
      input                 rxdataskip2_ext,
      input                 rxdataskip3_ext,
      input                 rxdataskip4_ext,
      input                 rxdataskip5_ext,
      input                 rxdataskip6_ext,
      input                 rxdataskip7_ext,
      input                 rxblkst0_ext,
      input                 rxblkst1_ext,
      input                 rxblkst2_ext,
      input                 rxblkst3_ext,
      input                 rxblkst4_ext,
      input                 rxblkst5_ext,
      input                 rxblkst6_ext,
      input                 rxblkst7_ext,
      input  [1 : 0]        rxsynchd0_ext,
      input  [1 : 0]        rxsynchd1_ext,
      input  [1 : 0]        rxsynchd2_ext,
      input  [1 : 0]        rxsynchd3_ext,
      input  [1 : 0]        rxsynchd4_ext,
      input  [1 : 0]        rxsynchd5_ext,
      input  [1 : 0]        rxsynchd6_ext,
      input  [1 : 0]        rxsynchd7_ext,
      input                 rxvalid0_ext,
      input                 rxvalid1_ext,
      input                 rxvalid2_ext,
      input                 rxvalid3_ext,
      input                 rxvalid4_ext,
      input                 rxvalid5_ext,
      input                 rxvalid6_ext,
      input                 rxvalid7_ext,

      // Application signals inputs
      input  [4 : 0]        aer_msi_num,
      input                 app_int_sts,
      input  [4 : 0]        app_msi_num,
      input                 app_msi_req,
      input  [2 : 0]        app_msi_tc,
      input  [4 : 0]        pex_msi_num,
      input  [11 : 0]       lmi_addr,
      input  [7  : 0]       lmi_din,
      input                 lmi_rden,
      input                 lmi_wren,
      input                 pm_auxpwr,
      input  [9 : 0]        pm_data,
      input                 pme_to_cr,
      input                 pm_event,
      input                 rx_st_mask,
      input                 rx_st_ready,
      input  [255 : 0]      tx_st_data,
      input  [1 :0]        tx_st_empty,
      input  [3 :0]        tx_st_eop,
      input  [3 :0]        tx_st_err,
      input  [31:0]        tx_st_parity,
      input  [3 :0]        tx_st_sop,
      input                tx_st_valid,
      input  [15:0]        cfglink2csrpld,
      input  [6 :0]        cpl_err,
      input                cpl_pending,
      input                tl_slotclk_cfg,

      // Input for internal test port (PE/TE)
      input                 bistenrcv,
      input                 bistenrpl,
      input                 bistscanen,
      input                 bistscanin,
      input                 bisttesten,
      input                 memhiptestenable,
      input                 memregscanen,
      input                 memredenscan,//UC
      input                 memredscen,//UC
      input                 memredscin,//UC
      input                 memredsclk, //UC
      input                 memredscrst, //UC
      input                 memredscsel, //UC
      input                 memregscanin,//UC
      input                 scanmoden,
      input                 scanshiftn,
      input  [2 : 0]        m10k_select,

      // Input for past QII 10.0 support
      input  [31 : 0]       csebrddata,
      input  [3 : 0]        csebrddataparity,
      input  [4 : 0]        csebrdresponse,
      input                 csebwaitrequest,
      input  [4 : 0]        csebwrresponse,
      input                 csebwrrespvalid,
      input  [43 : 0]       dbgpipex1rx,


      // Output Pipe interface
      output [2 : 0]        eidle_infer_sel0_ext,
      output [2 : 0]        eidle_infer_sel1_ext,
      output [2 : 0]        eidle_infer_sel2_ext,
      output [2 : 0]        eidle_infer_sel3_ext,
      output [2 : 0]        eidle_infer_sel4_ext,
      output [2 : 0]        eidle_infer_sel5_ext,
      output [2 : 0]        eidle_infer_sel6_ext,
      output [2 : 0]        eidle_infer_sel7_ext,
      output [1 : 0]        powerdown0_ext,
      output [1 : 0]        powerdown1_ext,
      output [1 : 0]        powerdown2_ext,
      output [1 : 0]        powerdown3_ext,
      output [1 : 0]        powerdown4_ext,
      output [1 : 0]        powerdown5_ext,
      output [1 : 0]        powerdown6_ext,
      output [1 : 0]        powerdown7_ext,
      output                rxpolarity0_ext,
      output                rxpolarity1_ext,
      output                rxpolarity2_ext,
      output                rxpolarity3_ext,
      output                rxpolarity4_ext,
      output                rxpolarity5_ext,
      output                rxpolarity6_ext,
      output                rxpolarity7_ext,
      output                txcompl0_ext,
      output                txcompl1_ext,
      output                txcompl2_ext,
      output                txcompl3_ext,
      output                txcompl4_ext,
      output                txcompl5_ext,
      output                txcompl6_ext,
      output                txcompl7_ext,
      output [31 : 0]       txdata0_ext,
      output [31 : 0]       txdata1_ext,
      output [31 : 0]       txdata2_ext,
      output [31 : 0]       txdata3_ext,
      output [31 : 0]       txdata4_ext,
      output [31 : 0]       txdata5_ext,
      output [31 : 0]       txdata6_ext,
      output [31 : 0]       txdata7_ext,
      output [ 3 : 0]       txdatak0_ext,
      output [ 3 : 0]       txdatak1_ext,
      output [ 3 : 0]       txdatak2_ext,
      output [ 3 : 0]       txdatak3_ext,
      output [ 3 : 0]       txdatak4_ext,
      output [ 3 : 0]       txdatak5_ext,
      output [ 3 : 0]       txdatak6_ext,
      output [ 3 : 0]       txdatak7_ext,
      output                txdetectrx0_ext,
      output                txdetectrx1_ext,
      output                txdetectrx2_ext,
      output                txdetectrx3_ext,
      output                txdetectrx4_ext,
      output                txdetectrx5_ext,
      output                txdetectrx6_ext,
      output                txdetectrx7_ext,
      output                txelecidle0_ext,
      output                txelecidle1_ext,
      output                txelecidle2_ext,
      output                txelecidle3_ext,
      output                txelecidle4_ext,
      output                txelecidle5_ext,
      output                txelecidle6_ext,
      output                txelecidle7_ext,
      output [2 : 0]        tx_margin0_ext,
      output [2 : 0]        tx_margin1_ext,
      output [2 : 0]        tx_margin2_ext,
      output [2 : 0]        tx_margin3_ext,
      output [2 : 0]        tx_margin4_ext,
      output [2 : 0]        tx_margin5_ext,
      output [2 : 0]        tx_margin6_ext,
      output [2 : 0]        tx_margin7_ext,
      output                tx_deemph0_ext,
      output                tx_deemph1_ext,
      output                tx_deemph2_ext,
      output                tx_deemph3_ext,
      output                tx_deemph4_ext,
      output                tx_deemph5_ext,
      output                tx_deemph6_ext,
      output                tx_deemph7_ext,
      output                txswing0_ext,
      output                txswing1_ext,
      output                txswing2_ext,
      output                txswing3_ext,
      output                txswing4_ext,
      output                txswing5_ext,
      output                txswing6_ext,
      output                txswing7_ext,
      output [1:0]          rate0_ext,
      output [1:0]          rate1_ext,
      output [1:0]          rate2_ext,
      output [1:0]          rate3_ext,
      output [1:0]          rate4_ext,
      output [1:0]          rate5_ext,
      output [1:0]          rate6_ext,
      output [1:0]          rate7_ext,
      output                txdataskip0_ext,
      output                txdataskip1_ext,
      output                txdataskip2_ext,
      output                txdataskip3_ext,
      output                txdataskip4_ext,
      output                txdataskip5_ext,
      output                txdataskip6_ext,
      output                txdataskip7_ext,
      output                txblkst0_ext,
      output                txblkst1_ext,
      output                txblkst2_ext,
      output                txblkst3_ext,
      output                txblkst4_ext,
      output                txblkst5_ext,
      output                txblkst6_ext,
      output                txblkst7_ext,
      output [1 : 0]        txsynchd0_ext,
      output [1 : 0]        txsynchd1_ext,
      output [1 : 0]        txsynchd2_ext,
      output [1 : 0]        txsynchd3_ext,
      output [1 : 0]        txsynchd4_ext,
      output [1 : 0]        txsynchd5_ext,
      output [1 : 0]        txsynchd6_ext,
      output [1 : 0]        txsynchd7_ext,
      output [17 : 0]       current_coeff0_ext,
      output [17 : 0]       current_coeff1_ext,
      output [17 : 0]       current_coeff2_ext,
      output [17 : 0]       current_coeff3_ext,
      output [17 : 0]       current_coeff4_ext,
      output [17 : 0]       current_coeff5_ext,
      output [17 : 0]       current_coeff6_ext,
      output [17 : 0]       current_coeff7_ext,
      output [2 : 0]        current_rxpreset0_ext,
      output [2 : 0]        current_rxpreset1_ext,
      output [2 : 0]        current_rxpreset2_ext,
      output [2 : 0]        current_rxpreset3_ext,
      output [2 : 0]        current_rxpreset4_ext,
      output [2 : 0]        current_rxpreset5_ext,
      output [2 : 0]        current_rxpreset6_ext,
      output [2 : 0]        current_rxpreset7_ext,


      // Output HIP Status signals
      output                coreclkout,
      output [1 : 0]        currentspeed,
      output                derr_cor_ext_rcv,
      output                derr_cor_ext_rpl,
      output                derr_rpl,
      output                rx_par_err ,
      output [1:0]          tx_par_err ,
      output                rxfc_cplbuf_ovf,
      output                cfg_par_err,
      output                dlup,
      output                dlup_exit,
      output                ev128ns,
      output                ev1us,
      output                hotrst_exit,
      output [3 : 0]        int_status,
      output                l2_exit,
      output [3 : 0]        lane_act,
      output [4 : 0]        ltssmstate,
      output [1 : 0]        rate,

      // rx_cred control
      input  [15 : 0]       rx_cred_ctl        ,
      output  [19 : 0]      rx_cred_status     ,

      // Output Application interface
      output                app_int_ack,
      output                app_msi_ack,
      output                lmi_ack,
      output [7 : 0]        lmi_dout,
      output                pme_to_sr,
      output [7 : 0]        rx_st_bardec1,
      output [7 : 0]        rx_st_bardec2,
      output [31 : 0]       rx_st_be,
      output [255 : 0]      rx_st_data,
      output [1 : 0]        rx_st_empty,
      output [3 : 0]        rx_st_eop,
      output [3 : 0]        rx_st_err,
      output [31 : 0]       rx_st_parity,
      output [3 : 0]        rx_st_sop,
      output [3 : 0]        rx_st_valid,
      output                serr_out,
      output [3 : 0]        tl_cfg_add,
      output [31 : 0]       tl_cfg_ctl,
      output [52 : 0]       tl_cfg_sts,
      output [11 : 0]       tx_cred_data_fc,
      output [5 : 0]        tx_cred_fc_hip_cons,
      output [5 : 0]        tx_cred_fc_infinite,
      output [7 : 0]        tx_cred_hdr_fc,
      input  [1:0]          tx_cred_fc_sel,
      input                 tx_cred_cons_select,
      output                tx_st_ready,

      // serial interface
      input    rx_in0,
      input    rx_in1,
      input    rx_in2,
      input    rx_in3,
      input    rx_in4,
      input    rx_in5,
      input    rx_in6,
      input    rx_in7,

      output   tx_out0,
      output   tx_out1,
      output   tx_out2,
      output   tx_out3,
      output   tx_out4,
      output   tx_out5,
      output   tx_out6,
      output   tx_out7,

      // HIP Reconfig
      input             avmm_rst_n,      // DPRIO reset
      input             avmm_clk,        // DPRIO clock
      input             avmm_write,      // write enable input
      input             avmm_read,       // read enable input
      input   [1:0]     avmm_byte_en,    // Byte enable
      input   [9:0]     avmm_address,    // address input
      input   [15:0]    avmm_writedata,  // write data input
      output  [15:0]    avmm_readdata,   // Read data output
      input             ser_shift_load,  // 1'b1=shift in data from si into scan flop
                                         // 1'b0=load data from writedata into scan flop
      input             interface_sel,   // Interface selection inputs
                                         // 1'b1: select CSR as a source for CRAM
                                         // 1'b0: select Avalon-MM interface

      // XCVR Reconfig interface
      input                 xcvr_reconfig_clk,
      input                 xcvr_reconfig_reset,
      input                 xcvr_reconfig_write,
      input                 xcvr_reconfig_read,
      input  [reconfig_address_width_integer_hwtcl-1:0]         xcvr_reconfig_address,
      input  [31:0]         xcvr_reconfig_writedata,
      output [31:0]         xcvr_reconfig_readdata,
      output                xcvr_reconfig_waitrequest,

      // PLL Reconfig interface
      input  wire           reconfig_pll0_clk,                                       //     reconfig_clk.clk
      input  wire           reconfig_pll0_reset,                                     //   reconfig_reset.reset
      input  wire           reconfig_pll0_write,                                     //    reconfig_avmm.write
      input  wire           reconfig_pll0_read,                                      //                 .read
      input  wire [9:0]     reconfig_pll0_address,                                   //                 .address
      input  wire [31:0]    reconfig_pll0_writedata,                                 //                 .writedata
      output wire [31:0]    reconfig_pll0_readdata,                                  //                 .readdata
      output wire           reconfig_pll0_waitrequest,                               //                 .waitrequest

      input  wire           reconfig_pll1_clk,                                       //     reconfig_clk.clk
      input  wire           reconfig_pll1_reset,                                     //   reconfig_reset.reset
      input  wire           reconfig_pll1_write,                                     //    reconfig_avmm.write
      input  wire           reconfig_pll1_read,                                      //                 .read
      input  wire [9:0]     reconfig_pll1_address,                                   //                 .address
      input  wire [31:0]    reconfig_pll1_writedata,                                 //                 .writedata
      output wire [31:0]    reconfig_pll1_readdata,                                  //                 .readdata
      output wire           reconfig_pll1_waitrequest,                               //                 .waitrequest

      output                avmm_thinmaster_write,                                   //     | _______________________________|//
      output [7:0]          avmm_thinmaster_address,                                 //     |                   | Offset 48h |//
      output [15:0]         avmm_thinmaster_writedata,                               //     | AVMM thin Master  |____________|//
      output [1:0]          avmm_thinmaster_byteenable,                              //     | [15:0]  data                   |//
      output                avmm_thinmaster_read,                                    //     | [23:16] Address                |//
      input                 avmm_thinmaster_waitrequest,                             //     | [24]    ReadReq                |//
      input  [15:0]         avmm_thinmaster_readdata,                                //     | [25]    WriteReq               |//
      input                 avmm_thinmaster_readdatavalid,                           //     | [31:26] Reserved               |//

      // Output for past QII 10.0 support
      output [31 : 0]       csebaddr,
      output [3 : 0]        csebaddrparity,
      output [3 : 0]        csebbe,
      output                csebisshadow,
      output                csebrden,
      output [31 : 0]       csebwrdata,
      output [3 : 0]        csebwrdataparity,
      output                csebwren,
      output                csebwrrespreq,

      // Output for internal test port (PE/TE)
      output                wakeoen,

      // Export PHY/PLL PCIE clk in/out
      input  wire           pipe_hclk_in,
      output wire           pll_pcie_clk,
      
      output wire           skp_os
      );

   function [8*25:1] low_str;
   // Convert parameter strings to lower case
      input [8*25:1] input_string;
      reg [8*25:1] return_string;
      reg [8*25:1] reg_string;
      reg [8:1] tmp;
      reg [8:1] conv_char;
      integer byte_count;
      begin
         reg_string = input_string;
		 return_string = 0;
         for (byte_count = 25; byte_count >= 1; byte_count = byte_count - 1) begin
            tmp = reg_string[8*25:(8*(25-1)+1)];
            reg_string = reg_string << 8;
            if ((tmp >= 65) && (tmp <= 90)) // ASCII number of 'A' is 65, 'Z' is 90
               begin
               conv_char = tmp + 32; // 32 is the difference in the position of 'A' and 'a' in the ASCII char set
               return_string = {return_string, conv_char};
               end
            else
               return_string = {return_string, tmp};
         end
      low_str = return_string;
      end
   endfunction

   function integer is_pld_clk_250MHz;
      input [8*25:1] l_ast_width;
      input [8*25:1] l_gen123_lane_rate_mode;
      input [8*25:1] l_lane_mask;
      begin
              if ((low_str(l_ast_width)=="avst_64bit" ) && (low_str(l_gen123_lane_rate_mode)=="gen1_gen2") && (low_str(l_lane_mask)=="x4"))  is_pld_clk_250MHz=USE_INTERNAL_250MHZ_PLL;
         else if ((low_str(l_ast_width)=="avst_128bit") && (low_str(l_gen123_lane_rate_mode)=="gen1_gen2") && (low_str(l_lane_mask)=="x8"))  is_pld_clk_250MHz=USE_INTERNAL_250MHZ_PLL;
         else if ((low_str(l_ast_width)=="avst_64bit") && (low_str(l_gen123_lane_rate_mode)=="gen1_gen2_gen3") && (low_str(l_lane_mask)=="x2"))  is_pld_clk_250MHz=USE_INTERNAL_250MHZ_PLL;
         else if ((low_str(l_ast_width)=="avst_128bit") && (low_str(l_gen123_lane_rate_mode)=="gen1_gen2_gen3") && (low_str(l_lane_mask)=="x4"))  is_pld_clk_250MHz=USE_INTERNAL_250MHZ_PLL;
         else if ((low_str(l_ast_width)=="avst_256bit") && (low_str(l_gen123_lane_rate_mode)=="gen1_gen2_gen3") && (low_str(l_lane_mask)=="x8"))  is_pld_clk_250MHz=USE_INTERNAL_250MHZ_PLL;
         else                                                                                                                              is_pld_clk_250MHz=0;
      end
   endfunction

   // Convert parameter strings to lower case
   genvar i;

   localparam LANES          = (low_str(link_width)=="x1")?1:(low_str(link_width)=="x2")?2:(low_str(link_width)=="x4")?4:8;
   //synthesis translate_off
   localparam ALTPCIE_HIP_256_PIPEN1B_SIM_ONLY  = 1;
   //synthesis translate_on

   //synthesis read_comments_as_HDL on
   //localparam ALTPCIE_HIP_256_PIPEN1B_SIM_ONLY = 0;
   //synthesis read_comments_as_HDL off

   localparam [4:0] LTSSM_EQ_DET_QUIET   = 5'b00000 ; // 5'h0
   localparam [4:0] LTSSM_EQ_DET_ACT     = 5'b00001 ; // 5'h1
   localparam [4:0] LTSSM_EQ_POL_ACT     = 5'b00010 ; // 5'h2
   localparam [4:0] LTSSM_EQ_POL_COMP    = 5'b00011 ; // 5'h3
   localparam [4:0] LTSSM_EQ_POL_CFG     = 5'b00100 ; // 5'h4
   localparam [4:0] LTSSM_EQ_CFG_LKST    = 5'b00110 ; // 5'h6
   localparam [4:0] LTSSM_EQ_CFG_LKAC    = 5'b00111 ; // 5'h7
   localparam [4:0] LTSSM_EQ_CFG_LNAC    = 5'b01000 ; // 5'h8
   localparam [4:0] LTSSM_EQ_CFG_LNWT    = 5'b01001 ; // 5'h9
   localparam [4:0] LTSSM_EQ_CFG_CPL     = 5'b01010 ; // 5'hA
   localparam [4:0] LTSSM_EQ_CFG_IDL     = 5'b01011 ; // 5'hB
   localparam [4:0] LTSSM_EQ_REC_RXLK    = 5'b01100 ; // 5'hC
   localparam [4:0] LTSSM_EQ_REC_RXCFG   = 5'b01101 ; // 5'hD
   localparam [4:0] LTSSM_EQ_REC_IDL     = 5'b01110 ; // 5'hE
   localparam [4:0] LTSSM_EQ_L0          = 5'b01111 ; // 5'hF
   localparam [4:0] LTSSM_EQ_DISAB       = 5'b10000 ; // 5'h10
   localparam [4:0] LTSSM_EQ_LPBK_ENT    = 5'b10001 ; // 5'h11
   localparam [4:0] LTSSM_EQ_LPBK_ACT    = 5'b10010 ; // 5'h12
   localparam [4:0] LTSSM_EQ_LPBK_EXIT   = 5'b10011 ; // 5'h13
   localparam [4:0] LTSSM_EQ_HOT_RST     = 5'b10100 ; // 5'h14
   localparam [4:0] LTSSM_EQ_L0S         = 5'b10101 ; // 5'h15
   localparam [4:0] LTSSM_EQ_L1_ENT      = 5'b10110 ; // 5'h16
   localparam [4:0] LTSSM_EQ_L1_IDL      = 5'b10111 ; // 5'h17
   localparam [4:0] LTSSM_EQ_L2_IDL      = 5'b11000 ; // 5'h18
   localparam [4:0] LTSSM_EQ_REC_SPEED   = 5'b11010 ; // 5'h1A
   localparam [4:0] LTSSM_EQ_EQZ_PHASE_0 = 5'b11011 ; // 5'h1B
   localparam [4:0] LTSSM_EQ_EQZ_PHASE_1 = 5'b11100 ; // 5'h1C
   localparam [4:0] LTSSM_EQ_EQZ_PHASE_2 = 5'b11101 ; // 5'h1D
   localparam [4:0] LTSSM_EQ_EQZ_PHASE_3 = 5'b11110 ; // 5'h1E

   localparam PLD_CLK_IS_250MHZ = is_pld_clk_250MHz(app_interface_width, gen123_lane_rate_mode, lane_mask);
   localparam USE_HARD_RESET    = (low_str(hrdrstctrl_en)=="hrdrstctrl_dis") ? 0:1;
   localparam ST_DATA_WIDTH     = (low_str(app_interface_width)=="avst_256bit")?256:(low_str(app_interface_width)=="avst_128bit")?128:64;
   localparam ST_BE_WIDTH       = (low_str(app_interface_width)=="avst_256bit")? 32:(low_str(app_interface_width)=="avst_128bit")? 16: 8;
   localparam ST_CTRL_WIDTH     = (low_str(app_interface_width)=="avst_256bit")?  4:(low_str(app_interface_width)=="avst_128bit")?  2: 1;

   //localparam LANES                = (low_str(lane_mask)=="x1")?1:(low_str(lane_mask)=="x2")?2:(low_str(lane_mask)=="x4")?4:8; //legal value: 1+
   localparam LANES_P1             = LANES+1;


   localparam pll_refclk_freq = "100 MHz"; //legal value = "100 MHz"
   localparam starting_channel_number = 0; //legal value: 0+
   localparam protocol_version = (low_str(gen123_lane_rate_mode)=="gen1_rate")?"Gen 1":
                                 (low_str(gen123_lane_rate_mode)=="gen1_gen2")?"Gen 2":
                                 (low_str(gen123_lane_rate_mode)=="gen1_gen2_gen3")?"Gen 3":"<invalid>"; //legal value: "Gen 1", "Gen 2", "Gen 3"

   localparam deser_factor = 32;
   localparam hip_enable = "true";

   localparam [255:0] ONES  = 256'HFFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF;
   localparam [255:0] ZEROS = 256'H0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000;

   localparam deskew_comma_sim_only             = "com_deskw";
   localparam enable_directed_spd_chng_sim_only = "false";
   localparam g3_ltssm_rec_dbg_sim_only         = "true";
   localparam rstctl_ltssm_dis_sim_only         = "true";
   localparam gen3_coeff_3_ber_meas_sim_only    = 6'h4;
   localparam millisecond_cycle_count_sim_only  = (low_str(core_clk_freq_mhz)=="core_clk_250mhz")?20'd400:
                                                  (low_str(core_clk_freq_mhz)=="core_clk_125mhz")?20'd200:
                                                  (low_str(core_clk_freq_mhz)=="core_clk_62p5mhz")?20'd100:20'h0;

   localparam SPEED_CHANGE_ACTIVE = (speed_change_hwtcl==1) || ((cseb_autonomous_hwtcl==1) && (cseb_config_bypass=="enable"));

   localparam PCISIG_PCIECV_TD_1_41_TLS_0_WORKAROUND = 0;
   localparam PCISIG_PTC_PM_WORKAROUND               = 0;

   wire  [11 : 0]       lmi_wpciecv_addr;
   wire  [7  : 0]       lmi_wpciecv_din ;
   wire                 lmi_wpciecv_rden;
   wire                 lmi_wpciecv_wren;
// SERDES
//
   //input from reset controller
   wire  [LANES-1:0]                   serdes_xcvr_powerdown;  //
   wire                                serdes_tx_analogreset;
   wire                                serdes_fixedclk;
   wire                                fboutclk_fixedclk;
   wire                                open_fbclk_serdes;
   wire  [LANES-1:0]                   serdes_tx_digitalreset;
   wire  [LANES-1:0]                   serdes_rx_analogreset; // for rx pma
   wire  [LANES-1:0]                   serdes_rx_digitalreset; //for rx pcs
   wire  [LANES-1:0]                   serdes_rx_cal_busy;
   wire  [LANES-1:0]                   serdes_tx_cal_busy;

   //pipe interface ports
   wire  [LANES * deser_factor - 1:0]        serdes_pipe_txdata;
   wire  [((LANES * deser_factor)/8) - 1:0]  serdes_pipe_txdatak;
   wire  [LANES - 1:0]                       serdes_pipe_txdetectrx_loopback;
   wire  [LANES - 1:0]                       serdes_pipe_txcompliance;
   wire  [LANES - 1:0]                       serdes_pipe_txelecidle;
   wire  [LANES - 1:0]                       serdes_pipe_tx_deemph;
   wire  [LANES - 1:0]                       serdes_pipe_txswing;
   wire  [LANES - 1:0]                       serdes_pipe_tx_data_valid;
   wire  [LANES - 1:0]                       serdes_pipe_tx_blk_start;
   wire  [8 - 1:0]                           serdes_pipe_rx_data_valid;
   wire  [8 - 1:0]                           serdes_pipe_rx_blk_start;
   wire  [LANES*18 -1:0]                     serdes_current_coeff;
   wire  [LANES*3  -1:0]                     serdes_current_rxpreset;
   wire  [LANES*2  -1:0]                     serdes_pipe_tx_sync_hdr;
   wire  [8*2  -1:0]                         serdes_pipe_rx_sync_hdr;

   wire  [LANES*3 - 1:0]                     serdes_pipe_tx_margin;
   wire  [LANES*2 - 1:0]                     serdes_pipe_rate;
   wire  [1:0]                               serdes_ratectrl;
   wire  [LANES*2 - 1:0]                     serdes_pipe_powerdown;

   wire  [8 * deser_factor - 1:0]        serdes_pipe_rxdata;
   wire  [((8 * deser_factor)/8) - 1:0]  serdes_pipe_rxdatak;
   wire  [8 - 1:0]                       serdes_pipe_rxvalid;
   wire  [LANES - 1:0]                   serdes_pipe_rxpolarity;
   wire  [8 - 1:0]                       serdes_pipe_rx_elecidle;
   wire  [8 - 1:0]                       serdes_pipe_phystatus;
   wire  [8*3 - 1:0]                     serdes_pipe_rxstatus;
   wire  [9*3 - 1:0]                     serdes_pld8grxstatus;

   //non-PIPE ports
   //MM ports
   wire  [LANES*3-1:0]                 serdes_rx_eidle_infer_sel;
   wire  [LANES-1:0]                   serdes_rx_set_locktodata;
   wire  [LANES-1:0]                   serdes_rx_set_locktoref;
   wire  [LANES-1:0]                   serdes_tx_invpolarity;
   wire  [((LANES*deser_factor)/8) -1:0] serdes_rx_errdetect;
   wire  [((LANES*deser_factor)/8) -1:0] serdes_rx_disperr;
   wire  [((LANES*deser_factor)/8) -1:0] serdes_rx_patterndetect;
   wire  [((LANES*deser_factor)/8) -1:0] serdes_rx_syncstatus;
   wire  [LANES-1:0]                   serdes_rx_phase_comp_fifo_error;
   wire  [LANES-1:0]                   serdes_tx_phase_comp_fifo_error;
   wire  [LANES-1:0]                   serdes_rx_is_lockedtoref;
   wire  [LANES-1:0]                   serdes_rx_signaldetect;
   wire  [LANES-1:0]                   serdes_rx_is_lockedtodata;

   //non-MM ports
   wire  [LANES-1:0]                   serdes_rx_serial_data;
   wire  [LANES-1:0]                   serdes_tx_serial_data;
   wire                                serdes_pipe_pclk;
   wire                                serdes_pllfixedclk;

   wire                                mserdes_pipe_pclk;
   wire                                mserdes_pipe_pclkch1      ;
   wire                                mserdes_pipe_pclkcentral  ;
   wire                                mserdes_pllfixedclkch0;
   wire                                mserdes_pllfixedclkch1;
   wire                                mserdes_pllfixedclkcentral;

   wire                                reset_status_hip;

   // reset controller signal
   wire rst_ctrl_rx_pll_locked  ; //
   wire rst_ctrl_rxanalogreset  ;
   wire rst_ctrl_rxdigitalreset ;
   wire rst_ctrl_xcvr_powerdown  ;
   wire rst_ctrl_txdigitalreset ;

   // Pull to known values
   wire unconnected_wire = 1'b0;
   wire [512:0] unconnected_bus = {512{1'b0}};
   wire [512:0] UNCON;

   // TLP Inspector
   wire [31:0]    tlp_inspect_trigger;
   wire [31:0]    tlp_inspector_monitor_data  ;
   wire [7:0]     tlp_inspector_monitor_addr  ;
   wire           tlp_inspector_monitor_fifo_pop  ;
   wire  [31 : 0] tlp_inspect_i_csebrddata;
   wire  [4 : 0]  tlp_inspect_i_csebrdresponse;
   wire           tlp_inspect_i_csebwaitrequest;
   wire  [4 : 0]  tlp_inspect_i_csebwrresponse;
   wire           tlp_inspect_i_csebwrrespvalid;

   wire [6:0] unconnected_swdnout      ;
   wire [2:0] unconnected_swupout      ;
   //Debug Signals for pol inv workaround
    reg [31:0 ] dbg_test_in_1_hip ;
    reg [7:0]  dbg_pld_rx_polinv_all_ln ;
        //dynamic_reconfig - To reconfig the rx_dyn_polinv to enable after the
        //core is up
   // Reconfig interface
    reg                 dbg_rx_dyn_polinv_reconfig                                               ; // reconfig enable
    wire                dbg_rx_dyn_polinv_reconfig_clk                                           ; // reconfig_clk.clk
    wire                dbg_rx_dyn_polinv_reconfig_reset                                         ; // reconfig_reset.reset
    wire                dbg_rx_dyn_polinv_reconfig_write                                         ; // reconfig_avmm.write
    wire                dbg_rx_dyn_polinv_reconfig_read                                          ; // reconfig_avmm.read
    reg [31:0]          dbg_rx_dyn_polinv_reconfig_writedata                                     ; // reconfig_avmm.writedata
    wire [31:0]          dbg_rx_dyn_polinv_reconfig_readdata                                      ; // reconfig_avmm.readdata
    wire                 dbg_rx_dyn_polinv_reconfig_waitrequest                                   ; // reconfig_avmm.waitrequest
    reg [reconfig_address_width_integer_hwtcl-1:0] dbg_rx_dyn_polinv_reconfig_address            ; // reconfig_avmm.address

    wire [31:0]         xcvr_reconfig_readdata_int                                               ;
    wire                xcvr_reconfig_waitrequest_int                                            ;

// DFE signals
     wire          [1:0]         current_rate_wire;
     wire                        ltssm_eq_phase2_wire;
     wire                        ltssm_detect_quiet_wire;
     wire                        ltssm_detect_active_wire;
     reg           [1:0]         current_rate_r;
     reg                         ltssm_eq_phase2_r;
     reg                         ltssm_detect_quiet_r;
     reg                         ltssm_detect_active_r;

assign current_rate_wire        = (enable_soft_dfe == 1) ? current_rate_r : 2'b00;
assign ltssm_eq_phase2_wire     = (enable_soft_dfe == 1) ? ltssm_eq_phase2_r : 1'b0;
assign ltssm_detect_quiet_wire  = (enable_soft_dfe == 1) ? ltssm_detect_quiet_r : 1'b0;
assign ltssm_detect_active_wire = (enable_soft_dfe == 1) ? ltssm_detect_active_r : 1'b0;
   ////////////////////////////////////////////////////////////////////////////////////
   //
   // HIP Control signals
   //
   reg     flr_reset; // Hip input
   wire    flr_sts;   // HIP Output Open

   wire npor_sync;
   wire npor_int;

   // Simulation Only Clocks
   wire     clk250_out;
   wire     clk500_out;
   ////////////////////////////////////////////////////////////////////////////////////
   //
   // Application AST interface
   //
   wire  [255 : 0]      txstdata;
   wire  [1 : 0]        txstempty;
   wire  [3 : 0]        txsteop;
   wire  [3 : 0]        txsterr;
   wire  [31 : 0]       txstparity;
   wire  [3 : 0]        txstsop;
   wire                 txstvalid;
   wire                 txstready;

   wire                 rxstmask;
   wire                 rxstready;
   wire  [7 : 0]        rxstbardec1;
   wire  [7 : 0]        rxstbardec2;
   wire  [31 : 0]       rxstbe;
   wire  [255 : 0]      rxstdata;
   wire  [1 : 0]        rxstempty;
   wire  [3 : 0]        rxsteop;
   wire  [3 : 0]        rxsterr;
   wire  [31 : 0]       rxstparity;
   wire  [3 : 0]        rxstsop;
   wire  [3 : 0]        rxstvalid;

   wire                 gnd_pm_exit_d0_ack      = 1'b0;
   wire                 gnd_egress_blk_err      = 1'b0;
   wire  [31 : 0]       gnd_test_pl_dbg_eqin    = ZEROS[31:0];
   wire  [7  : 0]       gnd_pld_gp_status       = ZEROS[8:0];
   wire  [7  : 0]       gnd_cfg_prmbus_pld      = ZEROS[8:0];
   wire  [1  : 0]       gnd_app_int_err         = ZEROS[1:0];

  // Autonmous and Speed change logic
   wire        sc_test_in_9;
   wire [63:0] test_in_int;


   assign  txstdata   =  (ST_DATA_WIDTH==256)?tx_st_data  [ST_DATA_WIDTH-1 :0]:(ST_DATA_WIDTH==128)?{128'h0,tx_st_data  [ST_DATA_WIDTH-1 :0]}:{192'h0,tx_st_data  [ST_DATA_WIDTH-1 :0]};
   assign  txsteop    =  (ST_DATA_WIDTH==256)?tx_st_eop   [ST_CTRL_WIDTH-1 :0]:(ST_DATA_WIDTH==128)?{2'h0  ,tx_st_eop   [ST_CTRL_WIDTH-1 :0]}:{3'h0  ,tx_st_eop   [ST_CTRL_WIDTH-1 :0]};
   assign  txsterr    =  (ST_DATA_WIDTH==256)?tx_st_err   [ST_CTRL_WIDTH-1 :0]:(ST_DATA_WIDTH==128)?{2'h0  ,tx_st_err   [ST_CTRL_WIDTH-1 :0]}:{3'h0  ,tx_st_err   [ST_CTRL_WIDTH-1 :0]};
   assign  txstparity =  (ST_DATA_WIDTH==256)?tx_st_parity[ST_BE_WIDTH-1   :0]:(ST_DATA_WIDTH==128)?{16'h0 ,tx_st_parity[ST_BE_WIDTH-1   :0]}:{24'h0 ,tx_st_parity[ST_BE_WIDTH-1   :0]};
   assign  txstsop    =  (ST_DATA_WIDTH==256)?tx_st_sop   [ST_CTRL_WIDTH-1 :0]:(ST_DATA_WIDTH==128)?{2'h0  ,tx_st_sop   [ST_CTRL_WIDTH-1 :0]}:{3'h0  ,tx_st_sop   [ST_CTRL_WIDTH-1 :0]};
   assign  txstvalid  =  tx_st_valid                     ;
   assign  txstempty  =  tx_st_empty [1               :0];
   assign  tx_st_ready=  txstready   ;

   assign  rxstmask                         = rx_st_mask ;
   assign  rxstready                        = rx_st_ready;
   assign  rx_st_bardec1[7              :0] = rxstbardec1[7              :0];
   assign  rx_st_bardec2[7              :0] = rxstbardec2[7              :0];
   assign  rx_st_be     [ST_BE_WIDTH-1  :0] = rxstbe     [ST_BE_WIDTH-1  :0];
   assign  rx_st_data   [ST_DATA_WIDTH-1:0] = rxstdata   [ST_DATA_WIDTH-1:0];
   assign  rx_st_empty  [1              :0] = rxstempty  [1              :0];
   assign  rx_st_eop    [ST_CTRL_WIDTH-1:0] = rxsteop    [ST_CTRL_WIDTH-1:0];
   assign  rx_st_err                        = rxsterr;
   assign  rx_st_parity [ST_BE_WIDTH-1  :0] = rxstparity [ST_BE_WIDTH-1  :0];
   assign  rx_st_sop    [ST_CTRL_WIDTH-1:0] = rxstsop    [ST_CTRL_WIDTH-1:0];
   assign  rx_st_valid  [ST_CTRL_WIDTH-1:0] = rxstvalid  [ST_CTRL_WIDTH-1:0];

   generate begin : g_rx_st_data_ext
      if ((ST_DATA_WIDTH<256)&&(ST_CTRL_WIDTH<4)&&(ST_BE_WIDTH<32)) begin : g01
         assign  rx_st_be      [31  :ST_BE_WIDTH]   = ZEROS [31  :ST_BE_WIDTH]    ;
         assign  rx_st_data    [255 :ST_DATA_WIDTH] = ZEROS [255 :ST_DATA_WIDTH]  ;
         assign  rx_st_parity  [31  :ST_BE_WIDTH]   = ZEROS [31  :ST_BE_WIDTH]    ;
         assign  rx_st_eop     [3   :ST_CTRL_WIDTH] = ZEROS [3   :ST_CTRL_WIDTH]  ;
         assign  rx_st_sop     [3   :ST_CTRL_WIDTH] = ZEROS [3   :ST_CTRL_WIDTH]  ;
         assign  rx_st_valid   [3   :ST_CTRL_WIDTH] = ZEROS [3   :ST_CTRL_WIDTH]  ;
      end
   end
   endgenerate
   ////////////////////////////////////////////////////////////////////////////////////
   //
   // PIPE signals interface
   //
   wire                phystatus0     ;// HIP input
   wire                phystatus1     ;// HIP input
   wire                phystatus2     ;// HIP input
   wire                phystatus3     ;// HIP input
   wire                phystatus4     ;// HIP input
   wire                phystatus5     ;// HIP input
   wire                phystatus6     ;// HIP input
   wire                phystatus7     ;// HIP input
   wire                rxblkst0       ;//= 1'b0;// HIP input
   wire                rxblkst1       ;//= 1'b0;// HIP input
   wire                rxblkst2       ;//= 1'b0;// HIP input
   wire                rxblkst3       ;//= 1'b0;// HIP input
   wire                rxblkst4       ;//= 1'b0;// HIP input
   wire                rxblkst5       ;//= 1'b0;// HIP input
   wire                rxblkst6       ;//= 1'b0;// HIP input
   wire                rxblkst7       ;//= 1'b0;// HIP input
   wire [31 : 0]       rxdata0        ;// HIP input  [31 : 0]
   wire [31 : 0]       rxdata1        ;// HIP input  [31 : 0]
   wire [31 : 0]       rxdata2        ;// HIP input  [31 : 0]
   wire [31 : 0]       rxdata3        ;// HIP input  [31 : 0]
   wire [31 : 0]       rxdata4        ;// HIP input  [31 : 0]
   wire [31 : 0]       rxdata5        ;// HIP input  [31 : 0]
   wire [31 : 0]       rxdata6        ;// HIP input  [31 : 0]
   wire [31 : 0]       rxdata7        ;// HIP input  [31 : 0]
   wire [3 : 0]        rxdatak0       ;// HIP input  [3 : 0]
   wire [3 : 0]        rxdatak1       ;// HIP input  [3 : 0]
   wire [3 : 0]        rxdatak2       ;// HIP input  [3 : 0]
   wire [3 : 0]        rxdatak3       ;// HIP input  [3 : 0]
   wire [3 : 0]        rxdatak4       ;// HIP input  [3 : 0]
   wire [3 : 0]        rxdatak5       ;// HIP input  [3 : 0]
   wire [3 : 0]        rxdatak6       ;// HIP input  [3 : 0]
   wire [3 : 0]        rxdatak7       ;// HIP input  [3 : 0]
   wire                rxdataskip0    ;//= 1'b0;// HIP input
   wire                rxdataskip1    ;//= 1'b0;// HIP input
   wire                rxdataskip2    ;//= 1'b0;// HIP input
   wire                rxdataskip3    ;//= 1'b0;// HIP input
   wire                rxdataskip4    ;//= 1'b0;// HIP input
   wire                rxdataskip5    ;//= 1'b0;// HIP input
   wire                rxdataskip6    ;//= 1'b0;// HIP input
   wire                rxdataskip7    ;//= 1'b0;// HIP input
   wire                rxelecidle0    ;// HIP input
   wire                rxelecidle1    ;// HIP input
   wire                rxelecidle2    ;// HIP input
   wire                rxelecidle3    ;// HIP input
   wire                rxelecidle4    ;// HIP input
   wire                rxelecidle5    ;// HIP input
   wire                rxelecidle6    ;// HIP input
   wire                rxelecidle7    ;// HIP input
   wire                rxfreqlocked0  ;//= 1'b0;// HIP input
   wire                rxfreqlocked1  ;//= 1'b0;// HIP input
   wire                rxfreqlocked2  ;//= 1'b0;// HIP input
   wire                rxfreqlocked3  ;//= 1'b0;// HIP input
   wire                rxfreqlocked4  ;//= 1'b0;// HIP input
   wire                rxfreqlocked5  ;//= 1'b0;// HIP input
   wire                rxfreqlocked6  ;//= 1'b0;// HIP input
   wire                rxfreqlocked7  ;//= 1'b0;// HIP input
   wire [2 : 0]        rxstatus0      ;// HIP input  [2 : 0]
   wire [2 : 0]        rxstatus1      ;// HIP input  [2 : 0]
   wire [2 : 0]        rxstatus2      ;// HIP input  [2 : 0]
   wire [2 : 0]        rxstatus3      ;// HIP input  [2 : 0]
   wire [2 : 0]        rxstatus4      ;// HIP input  [2 : 0]
   wire [2 : 0]        rxstatus5      ;// HIP input  [2 : 0]
   wire [2 : 0]        rxstatus6      ;// HIP input  [2 : 0]
   wire [2 : 0]        rxstatus7      ;// HIP input  [2 : 0]
   wire [1 : 0]        rxsynchd0      ;//= 2'b00;// HIP input  [1 : 0]
   wire [1 : 0]        rxsynchd1      ;//= 2'b00;// HIP input  [1 : 0]
   wire [1 : 0]        rxsynchd2      ;//= 2'b00;// HIP input  [1 : 0]
   wire [1 : 0]        rxsynchd3      ;//= 2'b00;// HIP input  [1 : 0]
   wire [1 : 0]        rxsynchd4      ;//= 2'b00;// HIP input  [1 : 0]
   wire [1 : 0]        rxsynchd5      ;//= 2'b00;// HIP input  [1 : 0]
   wire [1 : 0]        rxsynchd6      ;//= 2'b00;// HIP input  [1 : 0]
   wire [1 : 0]        rxsynchd7      ;//= 2'b00;// HIP input  [1 : 0]
   wire                rxvalid0       ;// HIP input
   wire                rxvalid1       ;// HIP input
   wire                rxvalid2       ;// HIP input
   wire                rxvalid3       ;// HIP input
   wire                rxvalid4       ;// HIP input
   wire                rxvalid5       ;// HIP input
   wire                rxvalid6       ;// HIP input
   wire                rxvalid7       ;// HIP input
   wire [17 : 0]       current_coeff0             ;// HIP output [17 : 0]
   wire [17 : 0]       current_coeff1             ;// HIP output [17 : 0]
   wire [17 : 0]       current_coeff2             ;// HIP output [17 : 0]
   wire [17 : 0]       current_coeff3             ;// HIP output [17 : 0]
   wire [17 : 0]       current_coeff4             ;// HIP output [17 : 0]
   wire [17 : 0]       current_coeff5             ;// HIP output [17 : 0]
   wire [17 : 0]       current_coeff6             ;// HIP output [17 : 0]
   wire [17 : 0]       current_coeff7             ;// HIP output [17 : 0]
   wire [2 : 0]        current_rxpreset0          ;// HIP output [2 : 0]
   wire [2 : 0]        current_rxpreset1          ;// HIP output [2 : 0]
   wire [2 : 0]        current_rxpreset2          ;// HIP output [2 : 0]
   wire [2 : 0]        current_rxpreset3          ;// HIP output [2 : 0]
   wire [2 : 0]        current_rxpreset4          ;// HIP output [2 : 0]
   wire [2 : 0]        current_rxpreset5          ;// HIP output [2 : 0]
   wire [2 : 0]        current_rxpreset6          ;// HIP output [2 : 0]
   wire [2 : 0]        current_rxpreset7          ;// HIP output [2 : 0]
   wire [2 : 0]        eidle_infer_sel0            ;// HIP output [2 : 0]
   wire [2 : 0]        eidle_infer_sel1            ;// HIP output [2 : 0]
   wire [2 : 0]        eidle_infer_sel2            ;// HIP output [2 : 0]
   wire [2 : 0]        eidle_infer_sel3            ;// HIP output [2 : 0]
   wire [2 : 0]        eidle_infer_sel4            ;// HIP output [2 : 0]
   wire [2 : 0]        eidle_infer_sel5            ;// HIP output [2 : 0]
   wire [2 : 0]        eidle_infer_sel6            ;// HIP output [2 : 0]
   wire [2 : 0]        eidle_infer_sel7            ;// HIP output [2 : 0]
   wire [1 : 0]        powerdown0                ;// HIP output [1 : 0]
   wire [1 : 0]        powerdown1                ;// HIP output [1 : 0]
   wire [1 : 0]        powerdown2                ;// HIP output [1 : 0]
   wire [1 : 0]        powerdown3                ;// HIP output [1 : 0]
   wire [1 : 0]        powerdown4                ;// HIP output [1 : 0]
   wire [1 : 0]        powerdown5                ;// HIP output [1 : 0]
   wire [1 : 0]        powerdown6                ;// HIP output [1 : 0]
   wire [1 : 0]        powerdown7                ;// HIP output [1 : 0]
   wire                rxpolarity0               ;// HIP output
   wire                rxpolarity1               ;// HIP output
   wire                rxpolarity2               ;// HIP output
   wire                rxpolarity3               ;// HIP output
   wire                rxpolarity4               ;// HIP output
   wire                rxpolarity5               ;// HIP output
   wire                rxpolarity6               ;// HIP output
   wire                rxpolarity7               ;// HIP output
   wire                txblkst0                  ;// HIP output
   wire                txblkst1                  ;// HIP output
   wire                txblkst2                  ;// HIP output
   wire                txblkst3                  ;// HIP output
   wire                txblkst4                  ;// HIP output
   wire                txblkst5                  ;// HIP output
   wire                txblkst6                  ;// HIP output
   wire                txblkst7                  ;// HIP output
   wire                txcompl0                  ;// HIP output
   wire                txcompl1                  ;// HIP output
   wire                txcompl2                  ;// HIP output
   wire                txcompl3                  ;// HIP output
   wire                txcompl4                  ;// HIP output
   wire                txcompl5                  ;// HIP output
   wire                txcompl6                  ;// HIP output
   wire                txcompl7                  ;// HIP output
   wire [31 : 0]       txdata0                   ;// HIP output [31 : 0]
   wire [31 : 0]       txdata1                   ;// HIP output [31 : 0]
   wire [31 : 0]       txdata2                   ;// HIP output [31 : 0]
   wire [31 : 0]       txdata3                   ;// HIP output [31 : 0]
   wire [31 : 0]       txdata4                   ;// HIP output [31 : 0]
   wire [31 : 0]       txdata5                   ;// HIP output [31 : 0]
   wire [31 : 0]       txdata6                   ;// HIP output [31 : 0]
   wire [31 : 0]       txdata7                   ;// HIP output [31 : 0]
   wire [3 : 0]        txdatak0                  ;// HIP output [3 : 0]
   wire [3 : 0]        txdatak1                  ;// HIP output [3 : 0]
   wire [3 : 0]        txdatak2                  ;// HIP output [3 : 0]
   wire [3 : 0]        txdatak3                  ;// HIP output [3 : 0]
   wire [3 : 0]        txdatak4                  ;// HIP output [3 : 0]
   wire [3 : 0]        txdatak5                  ;// HIP output [3 : 0]
   wire [3 : 0]        txdatak6                  ;// HIP output [3 : 0]
   wire [3 : 0]        txdatak7                  ;// HIP output [3 : 0]
   wire                txswing0                  ;// HIP output
   wire                txswing1                  ;// HIP output
   wire                txswing2                  ;// HIP output
   wire                txswing3                  ;// HIP output
   wire                txswing4                  ;// HIP output
   wire                txswing5                  ;// HIP output
   wire                txswing6                  ;// HIP output
   wire                txswing7                  ;// HIP output
   wire                txdataskip0               ;//HIP output
   wire                txdataskip1               ;//HIP output
   wire                txdataskip2               ;//HIP output
   wire                txdataskip3               ;//HIP output
   wire                txdataskip4               ;//HIP output
   wire                txdataskip5               ;//HIP output
   wire                txdataskip6               ;//HIP output
   wire                txdataskip7               ;//HIP output
   wire                tx_deemph0                 ;// HIP output
   wire                tx_deemph1                 ;// HIP output
   wire                tx_deemph2                 ;// HIP output
   wire                tx_deemph3                 ;// HIP output
   wire                tx_deemph4                 ;// HIP output
   wire                tx_deemph5                 ;// HIP output
   wire                tx_deemph6                 ;// HIP output
   wire                tx_deemph7                 ;// HIP output
   wire                txdetectrx0               ;// HIP output
   wire                txdetectrx1               ;// HIP output
   wire                txdetectrx2               ;// HIP output
   wire                txdetectrx3               ;// HIP output
   wire                txdetectrx4               ;// HIP output
   wire                txdetectrx5               ;// HIP output
   wire                txdetectrx6               ;// HIP output
   wire                txdetectrx7               ;// HIP output
   wire                txelecidle0               ;// HIP output
   wire                txelecidle1               ;// HIP output
   wire                txelecidle2               ;// HIP output
   wire                txelecidle3               ;// HIP output
   wire                txelecidle4               ;// HIP output
   wire                txelecidle5               ;// HIP output
   wire                txelecidle6               ;// HIP output
   wire                txelecidle7               ;// HIP output
   wire [2 : 0]        tx_margin0                ;// HIP output [2 : 0]
   wire [2 : 0]        tx_margin1                ;// HIP output [2 : 0]
   wire [2 : 0]        tx_margin2                ;// HIP output [2 : 0]
   wire [2 : 0]        tx_margin3                ;// HIP output [2 : 0]
   wire [2 : 0]        tx_margin4                ;// HIP output [2 : 0]
   wire [2 : 0]        tx_margin5                ;// HIP output [2 : 0]
   wire [2 : 0]        tx_margin6                ;// HIP output [2 : 0]
   wire [2 : 0]        tx_margin7                ;// HIP output [2 : 0]
   wire [1 : 0]        txsynchd0                 ;// HIP output [1 : 0]
   wire [1 : 0]        txsynchd1                 ;// HIP output [1 : 0]
   wire [1 : 0]        txsynchd2                 ;// HIP output [1 : 0]
   wire [1 : 0]        txsynchd3                 ;// HIP output [1 : 0]
   wire [1 : 0]        txsynchd4                 ;// HIP output [1 : 0]
   wire [1 : 0]        txsynchd5                 ;// HIP output [1 : 0]
   wire [1 : 0]        txsynchd6                 ;// HIP output [1 : 0]
   wire [1 : 0]        txsynchd7                 ;// HIP output [1 : 0]

   wire [ 1:0 ]        rate0;
   wire [ 1:0 ]        rate1;
   wire [ 1:0 ]        rate2;
   wire [ 1:0 ]        rate3;
   wire [ 1:0 ]        rate4;
   wire [ 1:0 ]        rate5;
   wire [ 1:0 ]        rate6;
   wire [ 1:0 ]        rate7;
   wire [ 1:0 ]        ratectrl;

   // Hardreset signals
   // Reset Control Interface Ch0
   wire [7:0] tx_pcs_rst_n;          // HIP output
   wire [7:0] rx_pcs_rst_n;          // HIP output
   wire [7:0] g3_tx_pcs_rst_n;        // HIP output     //not connected anywhere
   wire [7:0] g3_rx_pcs_rst_n;        // HIP output       //not connected anywhere
   wire [7:0] tx_pma_syncp;         // HIP output     //not connected anywhere
   wire [7:0] rx_pma_rstb;          // HIP output
   wire [7:0] tx_lcff_pll_rstb;        // HIP output
   wire [7:0] fref_clk;            // HIP input
   wire [7:0] rx_pll_phase_lock;     // HIP input
   wire [7:0] rx_pll_freq_lock;     // HIP input
   wire [7:0] mask_tx_pll_lock;      // HIP input
   wire       pll_cal_done0;
   wire       pll_cal_done1;
   wire       pll_cal_done2;
   wire       pll_cal_done3;
   wire       pll_cal_done4;
   wire       pll_cal_done5;
   wire       pll_cal_done6;
   wire       pll_cal_done7;
   wire       tx_lcff_pll_lock0;
   wire       tx_lcff_pll_lock1;
   wire       tx_lcff_pll_lock2;
   wire       tx_lcff_pll_lock3;
   wire       tx_lcff_pll_lock4;
   wire       tx_lcff_pll_lock5;
   wire       tx_lcff_pll_lock6;
   wire       tx_lcff_pll_lock7;
   wire       chnl_cal_done0;
   wire       chnl_cal_done1;
   wire       chnl_cal_done2;
   wire       chnl_cal_done3;
   wire       chnl_cal_done4;
   wire       chnl_cal_done5;
   wire       chnl_cal_done6;
   wire       chnl_cal_done7;

   wire [7:0] serdes_tx_pcs_rst_n;                         // HIP output
   wire [7:0] serdes_rx_pcs_rst_n;                         // HIP output
   wire [7:0] serdes_g3_tx_pcs_rst_n;                       // HIP output
   wire [7:0] serdes_g3_rx_pcs_rst_n;                       // HIP output
   wire [7:0] serdes_tx_pma_syncp;                        // HIP output
   wire [7:0] serdes_rx_pma_rstb;
   wire       serdes_tx_lc_pll_rstb;                  // HIP output
   wire       serdes_tx_fpll_rstb;                    // HIP output
   wire       serdes_mcgb_rstb;                       // HIP output
   wire [7:0] serdes_fref_clk;                        // HIP input
   wire [7:0] serdes_mask_tx_pll_lock;                // HIP input
   wire [64*LANES -1:0]  serdes_tx_hip_data;          // HIP Output
   wire [51*8 -1:0]  serdes_rx_hip_data;              // HIP Input
   wire [8*8  -1:0]  serdes_hip_ctrl;                 // HIP Input
   wire [8    -1:0]  serdes_chnl_cal_done;            // HIP Input
   wire                  serdes_pll_locked_lcpll;     // HIP Input
   wire                  serdes_pll_locked_fpll;      // HIP Input
   wire                  serdes_pll_cal_done_lcpll;   // HIP Input
   wire                  serdes_pll_cal_done_fpll;    // HIP Input
   wire crst;
   wire srst;
   wire hiprst;
   wire [LANES-1:0]            int_sigdet;

   wire pld_clk_in_use_hip;

   // DPRIO for speed change in Config-Bypass Autonomous mode
   wire            sc_dprio_clk;
   wire            sc_dprio_reset_n;
   wire            sc_dprio_write;
   wire    [15:0]  sc_dprio_writedata;
   wire    [1:0]   sc_dprio_byteen;
   wire    [9:0]   sc_dprio_address;
   wire            sc_dprio_read;
   wire    [15:0]  sc_dprio_readdata;
   wire            sc_hold_ltssm_rec;
// For the g2tog1 patch
   wire                 hip_dprio_clk;
   wire                 hip_dprio_reset_n;
   wire [9:0]           hip_dprio_address;
   wire                 hip_dprio_read;
   wire [15:0]          hip_dprio_readdata;
   wire                 hip_dprio_write;
   wire [15:0]          hip_dprio_writedata;
   wire [1:0]           hip_dprio_byteen;

   wire                force_tx_eidle;

   // For tx coeff patch
   wire [31:0] test_in_1_hip_eq;
   wire [18*LANES-1:0]  current_coeff_eq;
   wire [LANES-1:0]     wr_current_coeff_eq;
   // serial assignment
   assign serdes_pll_locked= (pipe32_sim_only==1'b1)?1'b1:(lane_rate!="gen3")? serdes_pll_locked_fpll : serdes_pll_locked_lcpll & serdes_pll_locked_fpll;

   assign npor_int = npor & pin_perst;

   altpcie_reset_delay_sync #(
      .ACTIVE_RESET           (0),
      .WIDTH_RST              (1),
      .NODENAME               ("por_sync_altpcie_reset_delay_sync"),
      .LOCK_TIME_CNT_WIDTH    (1)
   ) npor_sync_altpcie_reset_delay_sync(
      .clk         (pld_clk),
      .async_rst   (npor_int),
      .sync_rst    (npor_sync)
   );


   altpcie_sc_bitsync_node #(
      .DWIDTH    (1), // Sync Data input
      .SYNCSTAGE (2), // Sync stages
      .SDC_TYPE  (0), // 0: Multi Cycle=3, 1:Multi Cycle=2, 2: Set False Path
      .NODENAME  ("pld_clk_in_use_altpcie_sc_bitsync"),
      .RESET_VAL (0)  // Reset value
    ) pld_clk_in_use_altpcie_sc_bitsync(
      .clk       (pld_clk) ,// clock
      .rst_n     (npor_sync) ,// async reset
      .data_in   (pld_clk_in_use_hip) ,// data in
      .data_out  (pld_clk_inuse) // data out
   );

   altpcie_sc_bitsync_node #(
      .DWIDTH    (1), // Sync Data input
      .SYNCSTAGE (2), // Sync stages
      .SDC_TYPE  (0), // 0: Multi Cycle=3, 1:Multi Cycle=2, 2: Set False Path
      .NODENAME  ("reset_status_altpcie_sc_bitsync"),
      .RESET_VAL (1)  // Reset value
    ) reset_status_altpcie_sc_bitsync(
      .clk       (pld_clk) ,// clock
      .rst_n     (npor_sync) ,// async reset
      .data_in   (reset_status_hip) ,// data in
      .data_out  (reset_status) // data out
   );

   always @(posedge pld_clk or posedge reset_status) begin
      if (reset_status==1'b1) begin
         flr_reset              <= 1'b0;
      end
      else begin
         flr_reset              <= (flr_capability=="true")?flr_sts:1'b0;
      end
   end

   // testin is a static signal and can be safely false path
//   localparam MULTI_FROM   = "-name SDC_STATEMENT \"set_multicycle_path -from [get_keepers *altpcie_a10_hip_pipen1b*altpcie_test_in_static_signal_to_be_false_path\[*\]] 5\" ";
//   localparam MULTI_TO     = "-name SDC_STATEMENT \"set_multicycle_path -to   [get_keepers *altpcie_a10_hip_pipen1b*altpcie_test_in_static_signal_to_be_false_path\[*\]] 5\" ";
//   localparam FPATH_TO     = "-name SDC_STATEMENT \"set_false_path -from [get_keepers *altpcie_a10_hip_pipen1b*altpcie_test_in_static_signal_to_be_false_path\[*\]]\" ";
//   localparam FPATH_FROM   = "-name SDC_STATEMENT \"set_false_path -to   [get_keepers *altpcie_a10_hip_pipen1b*altpcie_test_in_static_signal_to_be_false_path\[*\]]\" ";
//   localparam SDC          = {FPATH_TO  ,";", MULTI_FROM};
//   (* altera_attribute = SDC *)
   reg [63:0] altpcie_test_in_static_signal_to_be_false_path;

   // synthesis translate_off
   initial begin
      altpcie_test_in_static_signal_to_be_false_path = 64'h1;
   end
   // synthesis translate_on
   always @(posedge pld_clk) begin
      altpcie_test_in_static_signal_to_be_false_path <= test_in;
   end


   generate begin : g_soft_reset
      if (USE_HARD_RESET==0) begin : g01

         altpcie_rs_a10_serdes altpcie_rs_a10_serdes (
            .pld_clk(pld_clk),                                                          // input
            .test_in({33'h0,test_in[6],5'h00,test_in[0]}),                              // input  [39:0]
            .ltssm(ltssmstate),                                                         // input  [4:0]
            .dlup_exit (dlup_exit),
            .hotrst_exit (hotrst_exit),
            .l2_exit (l2_exit),
            .npor_serdes((pipe32_sim_only==1'b1)?1'b0:npor_int),// input
            .npor_core(npor_int & pld_clk_inuse),                                           // input
            .tx_cal_busy(|serdes_tx_cal_busy),
            .rx_cal_busy(|serdes_rx_cal_busy),
            .pll_locked(serdes_pll_locked),                                             // input
            .rx_freqlocked  ((LANES==1)?{7'h7F,serdes_rx_is_lockedtodata[LANES-1:0]}:(LANES==2)?{6'h3F,serdes_rx_is_lockedtodata[LANES-1:0]}:(LANES==4)?{4'hF, serdes_rx_is_lockedtodata[LANES-1:0]}:serdes_rx_is_lockedtodata[LANES-1:0]),                                                            // input  [7:0]
            .rx_pll_locked  ((LANES==1)?{7'h7F,serdes_rx_is_lockedtoref[LANES-1:0] }:(LANES==2)?{6'h3F,serdes_rx_is_lockedtoref[LANES-1:0]}:(LANES==4)?{4'hF, serdes_rx_is_lockedtoref[LANES-1:0] }:serdes_rx_is_lockedtoref[LANES-1:0] ),                                                            // input  [7:0]
            .rx_signaldetect  (serdes_rx_signaldetect),
            .simu_serial(!pipe32_sim_only),                     // input
            .fifo_err(1'b0),                                                             // input
            .rc_inclk_eq_125mhz((PLD_CLK_IS_250MHZ==0)?1'b1:1'b0),                       // input
            .detect_mask_rxdrst(1'b1),                                                   // input
            .crst (crst),
            .srst (srst),
            .txdigitalreset (rst_ctrl_txdigitalreset),                                   // output
            .rxanalogreset  (rst_ctrl_rxanalogreset),                                    // output
            .rxdigitalreset (rst_ctrl_rxdigitalreset)                                    // output
            );
         assign rst_ctrl_xcvr_powerdown = (pipe32_sim_only==1'b1)?1'b1:~npor_int;
      end
      else begin : g02

         assign rst_ctrl_rxanalogreset    =1'b0;
         assign rst_ctrl_rxdigitalreset   =1'b0;
         assign rst_ctrl_xcvr_powerdown   =1'b0;
         assign rst_ctrl_txdigitalreset   =1'b0;

         if (USE_ALTPCIE_RS_HIP_LOGIC==1) begin : g03
            // legacy HIP complementary reset circuit when using Hard Reset Controller
            altpcie_rs_a10_hip altpcie_rs_a10_hip (
               .pld_clk       (pld_clk),
               .dlup_exit     (dlup_exit),
               .hotrst_exit   (hotrst_exit),
               .ltssm         (ltssmstate),
               .l2_exit       (l2_exit),
               .npor_core     (npor & pld_clk_inuse),
               .hiprst        (hiprst));
         end
         else begin : g04
            assign hiprst = 1'b0;
         end
      end
   end
   endgenerate

   assign serdes_fixedclk = refclk;

   generate begin : g_serdes_soft_rst_input
      for (i=0;i<LANES;i=i+1) begin : g_serdes_rst
         assign serdes_xcvr_powerdown[i] =  (pipe32_sim_only==1'b1)?1'b1:(low_str(hip_hard_reset)=="disable")?rst_ctrl_xcvr_powerdown    :1'b0;
         assign serdes_tx_digitalreset[i] = (pipe32_sim_only==1'b1)?1'b1:(low_str(hip_hard_reset)=="disable")?rst_ctrl_txdigitalreset    :1'b0;
         assign serdes_rx_analogreset [i] = (pipe32_sim_only==1'b1)?1'b1:(low_str(hip_hard_reset)=="disable")?rst_ctrl_rxanalogreset     :1'b0;
         assign serdes_rx_digitalreset[i] = (pipe32_sim_only==1'b1)?1'b1:(low_str(hip_hard_reset)=="disable")?rst_ctrl_rxdigitalreset    :1'b0;
      end
   end
   endgenerate

   assign serdes_tx_analogreset      = (pipe32_sim_only==1'b1)?1'b0           :(low_str(hip_hard_reset)=="disable")?~npor_int:1'b0;
   assign serdes_rx_set_locktodata   = {LANES{1'b0}};
   assign serdes_rx_set_locktoref    = {LANES{1'b0}};
   assign serdes_tx_invpolarity      = {LANES{1'b0}};

   assign serdes_tx_pcs_rst_n        = tx_pcs_rst_n[LANES-1:0]   ;// HIP Hard Reset Controller output
   assign serdes_rx_pcs_rst_n        = rx_pcs_rst_n[LANES-1:0]   ;// HIP Hard Reset Controller output
   assign serdes_tx_lc_pll_rstb      = ((lane_rate!="gen3")? 1'b0: (LANES==4) || (LANES==8)) ? tx_lcff_pll_rstb[3]: tx_lcff_pll_rstb[0];// HIP Hard Reset Controller output
   assign serdes_tx_fpll_rstb        = ((LANES==4) || (LANES==8)) ? tx_lcff_pll_rstb[4]: tx_lcff_pll_rstb[1];
   assign serdes_mcgb_rstb           = ((LANES==4) || (LANES==8)) ? tx_pcs_rst_n[3]: tx_pcs_rst_n[0];// HIP Hard Reset Controller output to MST CGB
   assign serdes_rx_pma_rstb         = rx_pma_rstb[LANES-1:0] ;// HIP Hard Reset Controller output

   assign fref_clk[LANES-1:0]           = (pipe32_sim_only==1'b1)?{LANES{refclk}}:serdes_fref_clk           ;// HIP Hard Reset Controller input

   //tying off the unconnected wires
   generate begin : g_tieoff_serdes_frefclk
      if (LANES!=8) begin : g01
         assign fref_clk[7:LANES]              = ONES[7-LANES:0]    ;// HIP Hard Reset Controller input
      end
   end
   endgenerate

   // Transceiver Lock Signals bindled in 'serdes_hip_ctrl' -> Input to the HRC
   assign rxfreqlocked0        = (pipe32_sim_only==1'b1)?ONES[0]:                                          serdes_hip_ctrl[0]           ;// HIP Hard Reset Controller input
   assign rxfreqlocked1        = (pipe32_sim_only==1'b1)?ONES[0]:((LANES<2)                      )?ONES[0]:serdes_hip_ctrl[8]           ;// HIP Hard Reset Controller input
   assign rxfreqlocked2        = (pipe32_sim_only==1'b1)?ONES[0]:((LANES<2)||(LANES<4)           )?ONES[0]:serdes_hip_ctrl[16]          ;// HIP Hard Reset Controller input
   assign rxfreqlocked3        = (pipe32_sim_only==1'b1)?ONES[0]:((LANES<2)||(LANES<4)           )?ONES[0]:serdes_hip_ctrl[24]          ;// HIP Hard Reset Controller input
   assign rxfreqlocked4        = (pipe32_sim_only==1'b1)?ONES[0]:((LANES<2)||(LANES<4)||(LANES<8))?ONES[0]:serdes_hip_ctrl[32]          ;// HIP Hard Reset Controller input
   assign rxfreqlocked5        = (pipe32_sim_only==1'b1)?ONES[0]:((LANES<2)||(LANES<4)||(LANES<8))?ONES[0]:serdes_hip_ctrl[40]          ;// HIP Hard Reset Controller input
   assign rxfreqlocked6        = (pipe32_sim_only==1'b1)?ONES[0]:((LANES<2)||(LANES<4)||(LANES<8))?ONES[0]:serdes_hip_ctrl[48]          ;// HIP Hard Reset Controller input
   assign rxfreqlocked7        = (pipe32_sim_only==1'b1)?ONES[0]:((LANES<2)||(LANES<4)||(LANES<8))?ONES[0]:serdes_hip_ctrl[56]          ;// HIP Hard Reset Controller input
   assign mask_tx_pll_lock[0]  = (pipe32_sim_only==1'b1)?ONES[0]:                                          serdes_hip_ctrl[2]           ;// HIP Hard Reset Controller input
   assign mask_tx_pll_lock[1]  = (pipe32_sim_only==1'b1)?ONES[0]:((LANES<2)                      )?ONES[0]:serdes_hip_ctrl[10]          ;// HIP Hard Reset Controller input
   assign mask_tx_pll_lock[2]  = (pipe32_sim_only==1'b1)?ONES[0]:((LANES<2)||(LANES<4)           )?ONES[0]:serdes_hip_ctrl[18]          ;// HIP Hard Reset Controller input
   assign mask_tx_pll_lock[3]  = (pipe32_sim_only==1'b1)?ONES[0]:((LANES<2)||(LANES<4)           )?ONES[0]:serdes_hip_ctrl[26]          ;// HIP Hard Reset Controller input
   assign mask_tx_pll_lock[4]  = (pipe32_sim_only==1'b1)?ONES[0]:((LANES<2)||(LANES<4)||(LANES<8))?ONES[0]:serdes_hip_ctrl[34]          ;// HIP Hard Reset Controller input
   assign mask_tx_pll_lock[5]  = (pipe32_sim_only==1'b1)?ONES[0]:((LANES<2)||(LANES<4)||(LANES<8))?ONES[0]:serdes_hip_ctrl[42]          ;// HIP Hard Reset Controller input
   assign mask_tx_pll_lock[6]  = (pipe32_sim_only==1'b1)?ONES[0]:((LANES<2)||(LANES<4)||(LANES<8))?ONES[0]:serdes_hip_ctrl[50]          ;// HIP Hard Reset Controller input
   assign mask_tx_pll_lock[7]  = (pipe32_sim_only==1'b1)?ONES[0]:((LANES<2)||(LANES<4)||(LANES<8))?ONES[0]:serdes_hip_ctrl[58]          ;// HIP Hard Reset Controller input
   assign rx_pll_phase_lock[0] = (pipe32_sim_only==1'b1)?ONES[0]:                                          serdes_hip_ctrl[3]           ;// HIP Hard Reset Controller input
   assign rx_pll_phase_lock[1] = (pipe32_sim_only==1'b1)?ONES[0]:((LANES<2)                      )?ONES[0]:serdes_hip_ctrl[11]          ;// HIP Hard Reset Controller input
   assign rx_pll_phase_lock[2] = (pipe32_sim_only==1'b1)?ONES[0]:((LANES<2)||(LANES<4)           )?ONES[0]:serdes_hip_ctrl[19]          ;// HIP Hard Reset Controller input
   assign rx_pll_phase_lock[3] = (pipe32_sim_only==1'b1)?ONES[0]:((LANES<2)||(LANES<4)           )?ONES[0]:serdes_hip_ctrl[27]          ;// HIP Hard Reset Controller input
   assign rx_pll_phase_lock[4] = (pipe32_sim_only==1'b1)?ONES[0]:((LANES<2)||(LANES<4)||(LANES<8))?ONES[0]:serdes_hip_ctrl[35]          ;// HIP Hard Reset Controller input
   assign rx_pll_phase_lock[5] = (pipe32_sim_only==1'b1)?ONES[0]:((LANES<2)||(LANES<4)||(LANES<8))?ONES[0]:serdes_hip_ctrl[43]          ;// HIP Hard Reset Controller input
   assign rx_pll_phase_lock[6] = (pipe32_sim_only==1'b1)?ONES[0]:((LANES<2)||(LANES<4)||(LANES<8))?ONES[0]:serdes_hip_ctrl[51]          ;// HIP Hard Reset Controller input
   assign rx_pll_phase_lock[7] = (pipe32_sim_only==1'b1)?ONES[0]:((LANES<2)||(LANES<4)||(LANES<8))?ONES[0]:serdes_hip_ctrl[59]          ;// HIP Hard Reset Controller input
   assign rx_pll_freq_lock[0]  = (pipe32_sim_only==1'b1)?ONES[0]:                                          serdes_hip_ctrl[4]           ;// HIP Hard Reset Controller input
   assign rx_pll_freq_lock[1]  = (pipe32_sim_only==1'b1)?ONES[0]:((LANES<2)                      )?ONES[0]:serdes_hip_ctrl[12]          ;// HIP Hard Reset Controller input
   assign rx_pll_freq_lock[2]  = (pipe32_sim_only==1'b1)?ONES[0]:((LANES<2)||(LANES<4)           )?ONES[0]:serdes_hip_ctrl[20]          ;// HIP Hard Reset Controller input
   assign rx_pll_freq_lock[3]  = (pipe32_sim_only==1'b1)?ONES[0]:((LANES<2)||(LANES<4)           )?ONES[0]:serdes_hip_ctrl[28]          ;// HIP Hard Reset Controller input
   assign rx_pll_freq_lock[4]  = (pipe32_sim_only==1'b1)?ONES[0]:((LANES<2)||(LANES<4)||(LANES<8))?ONES[0]:serdes_hip_ctrl[36]          ;// HIP Hard Reset Controller input
   assign rx_pll_freq_lock[5]  = (pipe32_sim_only==1'b1)?ONES[0]:((LANES<2)||(LANES<4)||(LANES<8))?ONES[0]:serdes_hip_ctrl[44]          ;// HIP Hard Reset Controller input
   assign rx_pll_freq_lock[6]  = (pipe32_sim_only==1'b1)?ONES[0]:((LANES<2)||(LANES<4)||(LANES<8))?ONES[0]:serdes_hip_ctrl[52]          ;// HIP Hard Reset Controller input
   assign rx_pll_freq_lock[7]  = (pipe32_sim_only==1'b1)?ONES[0]:((LANES<2)||(LANES<4)||(LANES<8))?ONES[0]:serdes_hip_ctrl[60]          ;// HIP Hard Reset Controller input

   assign pll_cal_done0        = (pipe32_sim_only==1'b1)?ONES[0]:(LANES>2)?ONES[0]:(lane_rate!="gen3")?ONES[0]:serdes_pll_cal_done_lcpll;
   assign pll_cal_done1        = (pipe32_sim_only==1'b1)?ONES[0]:(LANES>2)?ONES[0]:                            serdes_pll_cal_done_fpll;
   assign pll_cal_done2        = ONES[0];
   assign pll_cal_done3        = (pipe32_sim_only==1'b1)?ONES[0]:(LANES<4)?ONES[0]:(lane_rate!="gen3")?ONES[0]:serdes_pll_cal_done_lcpll;
   assign pll_cal_done4        = (pipe32_sim_only==1'b1)?ONES[0]:(LANES<4)?ONES[0]:                            serdes_pll_cal_done_fpll;
   assign {pll_cal_done5, pll_cal_done6, pll_cal_done7} = ONES[2:0];

   assign tx_lcff_pll_lock0    = (pipe32_sim_only==1'b1)?ONES[0]:(LANES>2)?ONES[0]:(lane_rate!="gen3")?ONES[0]:serdes_pll_locked_lcpll;
   assign tx_lcff_pll_lock1    = (pipe32_sim_only==1'b1)?ONES[0]:(LANES>2)?ONES[0]:                            serdes_pll_locked_fpll;
   assign tx_lcff_pll_lock2    = ONES[0];
   assign tx_lcff_pll_lock3    = (pipe32_sim_only==1'b1)?ONES[0]:(LANES<4)?ONES[0]:(lane_rate!="gen3")?ONES[0]:serdes_pll_locked_lcpll;
   assign tx_lcff_pll_lock4    = (pipe32_sim_only==1'b1)?ONES[0]:(LANES<4)?ONES[0]:                            serdes_pll_locked_fpll;
   assign {tx_lcff_pll_lock5, tx_lcff_pll_lock6, tx_lcff_pll_lock7} = ONES[2:0];

   assign chnl_cal_done0       = (pipe32_sim_only==1'b1)?ONES[0]:                                          serdes_chnl_cal_done[0];
   assign chnl_cal_done1       = (pipe32_sim_only==1'b1)?ONES[0]:((LANES<2)                      )?ONES[0]:serdes_chnl_cal_done[1];
   assign chnl_cal_done2       = (pipe32_sim_only==1'b1)?ONES[0]:((LANES<2)||(LANES<4)           )?ONES[0]:serdes_chnl_cal_done[2];
   assign chnl_cal_done3       = (pipe32_sim_only==1'b1)?ONES[0]:((LANES<2)||(LANES<4)           )?ONES[0]:serdes_chnl_cal_done[3];
   assign chnl_cal_done4       = (pipe32_sim_only==1'b1)?ONES[0]:((LANES<2)||(LANES<4)||(LANES<8))?ONES[0]:serdes_chnl_cal_done[4];
   assign chnl_cal_done5       = (pipe32_sim_only==1'b1)?ONES[0]:((LANES<2)||(LANES<4)||(LANES<8))?ONES[0]:serdes_chnl_cal_done[5];
   assign chnl_cal_done6       = (pipe32_sim_only==1'b1)?ONES[0]:((LANES<2)||(LANES<4)||(LANES<8))?ONES[0]:serdes_chnl_cal_done[6];
   assign chnl_cal_done7       = (pipe32_sim_only==1'b1)?ONES[0]:((LANES<2)||(LANES<4)||(LANES<8))?ONES[0]:serdes_chnl_cal_done[7];

   generate begin : g_serdes_pipe_io
      if (LANES==1) begin :gln1
         assign int_sigdet = serdes_rx_is_lockedtodata;
// assign  in_hip_tx_data[63:0] = {3'b000,txdataskip,3'b000,txblkst,txsynchd[1:0],
//                       txswing,tx_deemph,tx_margin[2:0],powerdown[1:0],txdetectrx,2'b00,
//                       2'b00,txdatak[3],txdata[31:24],
//                       2'b00,txdatak[2],txdata[23:16],
//                       2'b00,txdatak[1],txdata[15:8],
//                        txelecidle,txcompl,txdatak[0],txdata[7:0]};

         // TX
         assign serdes_ratectrl                    = unconnected_bus[1:0];
         assign serdes_pipe_rate[1:0]              = rate0[1:0];   // Currently only Gen2 rate0[1] is unconnected
         assign serdes_tx_hip_data[63:0]           = {3'h0, txdataskip0, 3'h0, txblkst0, txsynchd0, txswing0, tx_deemph0, tx_margin0, powerdown0, txdetectrx0, 4'h0, txdatak0[3], txdata0[31:24], 2'h0, txdatak0[2], txdata0[23:16], 2'h0, txdatak0[1], txdata0[15:8], txelecidle0, txcompl0, txdatak0[0], txdata0[7:0]};
         assign serdes_current_coeff[17:0]         = current_coeff0;          //Gen 3
         assign serdes_current_rxpreset[2:0]       = current_rxpreset0;       //Gen 3
         assign serdes_pipe_rxpolarity[0]          = rxpolarity0;
         assign serdes_rx_serial_data[0]           = rx_in0;
         assign serdes_rx_eidle_infer_sel[2:0]     = eidle_infer_sel0;

         //RX
         //
         assign tx_out0                            = serdes_tx_serial_data[0];
         assign mserdes_pipe_pclk                  = serdes_pipe_pclk;
         assign mserdes_pipe_pclkch1               = unconnected_wire;
         assign mserdes_pipe_pclkcentral           = unconnected_wire;
         assign mserdes_pllfixedclkch0             = serdes_pllfixedclk;
         assign mserdes_pllfixedclkch1             = unconnected_wire;
         assign mserdes_pllfixedclkcentral         = unconnected_wire;

         // Reset signals

      end
      else if (LANES==2) begin :gln2
         assign int_sigdet = {
         serdes_rx_is_lockedtodata[1] | serdes_rx_is_lockedtodata[0],
         serdes_rx_is_lockedtodata[0] | serdes_rx_is_lockedtodata[0]
         };
         // TX
         assign serdes_ratectrl                    = unconnected_bus[1:0];
         assign serdes_pipe_rate[1:0]              = rate0[1:0];
         assign serdes_pipe_rate[3:2]              = rate1[1:0];
         assign serdes_tx_hip_data[63:0]           = {3'h0, txdataskip0, 3'h0, txblkst0, txsynchd0, txswing0, tx_deemph0, tx_margin0, powerdown0, txdetectrx0, 4'h0, txdatak0[3], txdata0[31:24], 2'h0, txdatak0[2], txdata0[23:16], 2'h0, txdatak0[1], txdata0[15:8], txelecidle0, txcompl0, txdatak0[0], txdata0[7:0]};
         assign serdes_tx_hip_data[127:64]         = {3'h0, txdataskip1, 3'h0, txblkst1, txsynchd1, txswing1, tx_deemph1, tx_margin1, powerdown1, txdetectrx1, 4'h0, txdatak1[3], txdata1[31:24], 2'h0, txdatak1[2], txdata1[23:16], 2'h0, txdatak1[1], txdata1[15:8], txelecidle1, txcompl1, txdatak1[0], txdata1[7:0]};
         assign serdes_current_coeff[17:0]         = current_coeff0;
         assign serdes_current_coeff[35:18]        = current_coeff1;
         assign serdes_current_rxpreset[2:0]       = current_rxpreset0;
         assign serdes_current_rxpreset[5:3]       = current_rxpreset1;
         assign serdes_pipe_rxpolarity[0]          = rxpolarity0;
         assign serdes_pipe_rxpolarity[1]          = rxpolarity1;
         assign serdes_rx_eidle_infer_sel[2:0]     = eidle_infer_sel0;
         assign serdes_rx_eidle_infer_sel[5:3]     = eidle_infer_sel1;
         assign     tx_out0                        = serdes_tx_serial_data[0];
         assign     tx_out1                        = serdes_tx_serial_data[1];

         //RX
         //
         assign  serdes_rx_serial_data[0]=rx_in0;
         assign  serdes_rx_serial_data[1]=rx_in1;

         assign mserdes_pipe_pclk         = serdes_pipe_pclk;
         assign mserdes_pipe_pclkch1      = unconnected_wire;
         assign mserdes_pipe_pclkcentral  = unconnected_wire;
         assign mserdes_pllfixedclkch0    = serdes_pllfixedclk;
         assign mserdes_pllfixedclkch1    = unconnected_wire;
         assign mserdes_pllfixedclkcentral= unconnected_wire;

      end
      else if (LANES==4) begin :gln4
         assign int_sigdet = {
         serdes_rx_is_lockedtodata[3] | serdes_rx_is_lockedtodata[0],
         serdes_rx_is_lockedtodata[2] | serdes_rx_is_lockedtodata[0],
         serdes_rx_is_lockedtodata[1] | serdes_rx_is_lockedtodata[0],
         serdes_rx_is_lockedtodata[0] | serdes_rx_is_lockedtodata[0]
         };
         // TX
         assign serdes_ratectrl                    = unconnected_bus[1:0];
         assign serdes_pipe_rate[1:0]              = rate0[1:0];
         assign serdes_pipe_rate[3:2]              = rate1[1:0];
         assign serdes_pipe_rate[5:4]              = rate2[1:0];
         assign serdes_pipe_rate[7:6]              = rate3[1:0];
         assign serdes_tx_hip_data[63:0]           = {3'h0, txdataskip0, 3'h0, txblkst0, txsynchd0, txswing0, tx_deemph0, tx_margin0, powerdown0, txdetectrx0, 4'h0, txdatak0[3], txdata0[31:24], 2'h0, txdatak0[2], txdata0[23:16], 2'h0, txdatak0[1], txdata0[15:8], txelecidle0, txcompl0, txdatak0[0], txdata0[7:0]};
         assign serdes_tx_hip_data[127:64]         = {3'h0, txdataskip1, 3'h0, txblkst1, txsynchd1, txswing1, tx_deemph1, tx_margin1, powerdown1, txdetectrx1, 4'h0, txdatak1[3], txdata1[31:24], 2'h0, txdatak1[2], txdata1[23:16], 2'h0, txdatak1[1], txdata1[15:8], txelecidle1, txcompl1, txdatak1[0], txdata1[7:0]};
         assign serdes_tx_hip_data[191:128]        = {3'h0, txdataskip2, 3'h0, txblkst2, txsynchd2, txswing2, tx_deemph2, tx_margin2, powerdown2, txdetectrx2, 4'h0, txdatak2[3], txdata2[31:24], 2'h0, txdatak2[2], txdata2[23:16], 2'h0, txdatak2[1], txdata2[15:8], txelecidle2, txcompl2, txdatak2[0], txdata2[7:0]};
         assign serdes_tx_hip_data[255:192]        = {3'h0, txdataskip3, 3'h0, txblkst3, txsynchd3, txswing3, tx_deemph3, tx_margin3, powerdown3, txdetectrx3, 4'h0, txdatak3[3], txdata3[31:24], 2'h0, txdatak3[2], txdata3[23:16], 2'h0, txdatak3[1], txdata3[15:8], txelecidle3, txcompl3, txdatak3[0], txdata3[7:0]};
         assign serdes_current_coeff[17:0]         = current_coeff0;
         assign serdes_current_coeff[35:18]        = current_coeff1;
         assign serdes_current_coeff[53:36]        = current_coeff2;
         assign serdes_current_coeff[71:54]        = current_coeff3;
         assign serdes_current_rxpreset[2:0]       = current_rxpreset0;
         assign serdes_current_rxpreset[5:3]       = current_rxpreset1;
         assign serdes_current_rxpreset[8:6]       = current_rxpreset2;
         assign serdes_current_rxpreset[11:9]      = current_rxpreset3;
         assign serdes_pipe_rxpolarity[0]          = rxpolarity0;
         assign serdes_pipe_rxpolarity[1]          = rxpolarity1;
         assign serdes_pipe_rxpolarity[2]          = rxpolarity2;
         assign serdes_pipe_rxpolarity[3]          = rxpolarity3;
         assign serdes_rx_eidle_infer_sel[2:0]     = eidle_infer_sel0;
         assign serdes_rx_eidle_infer_sel[5:3]     = eidle_infer_sel1;
         assign serdes_rx_eidle_infer_sel[8:6]     = eidle_infer_sel2;
         assign serdes_rx_eidle_infer_sel[11:9]    = eidle_infer_sel3;

         assign     tx_out0                = serdes_tx_serial_data[0];
         assign     tx_out1                = serdes_tx_serial_data[1];
         assign     tx_out2                = serdes_tx_serial_data[2];
         assign     tx_out3                = serdes_tx_serial_data[3];

         //RX
         //
         assign  serdes_rx_serial_data[0]=rx_in0;
         assign  serdes_rx_serial_data[1]=rx_in1;
         assign  serdes_rx_serial_data[2]=rx_in2;
         assign  serdes_rx_serial_data[3]=rx_in3;

         assign mserdes_pipe_pclk         = unconnected_wire;
         assign mserdes_pipe_pclkch1      = unconnected_wire;
         assign mserdes_pipe_pclkcentral  = serdes_pipe_pclk;
         assign mserdes_pllfixedclkch0    = unconnected_wire;
         assign mserdes_pllfixedclkch1    = unconnected_wire;
         assign mserdes_pllfixedclkcentral= serdes_pllfixedclk;

      end
      else begin  :gln8// x8
         assign int_sigdet = {
         serdes_rx_is_lockedtodata[7] | serdes_rx_is_lockedtodata[0],
         serdes_rx_is_lockedtodata[6] | serdes_rx_is_lockedtodata[0],
         serdes_rx_is_lockedtodata[5] | serdes_rx_is_lockedtodata[0],
         serdes_rx_is_lockedtodata[4] | serdes_rx_is_lockedtodata[0],
         serdes_rx_is_lockedtodata[3] | serdes_rx_is_lockedtodata[0],
         serdes_rx_is_lockedtodata[2] | serdes_rx_is_lockedtodata[0],
         serdes_rx_is_lockedtodata[1] | serdes_rx_is_lockedtodata[0],
         serdes_rx_is_lockedtodata[0] | serdes_rx_is_lockedtodata[0]
         };
         // TX
         assign serdes_ratectrl                    = ratectrl;
         assign serdes_pipe_rate[1 : 0]            = rate0[1:0];
         assign serdes_pipe_rate[3 : 2]            = rate1[1:0];
         assign serdes_pipe_rate[5 : 4]            = rate2[1:0];
         assign serdes_pipe_rate[7 : 6]            = rate3[1:0];
         assign serdes_pipe_rate[9 : 8]            = rate4[1:0];
         assign serdes_pipe_rate[11:10]            = rate5[1:0];
         assign serdes_pipe_rate[13:12]            = rate6[1:0];
         assign serdes_pipe_rate[15:14]            = rate7[1:0];
         assign serdes_tx_hip_data[63:0]           = {3'h0, txdataskip0, 3'h0, txblkst0, txsynchd0, txswing0, tx_deemph0, tx_margin0, powerdown0, txdetectrx0, 4'h0, txdatak0[3], txdata0[31:24], 2'h0, txdatak0[2], txdata0[23:16], 2'h0, txdatak0[1], txdata0[15:8], txelecidle0, txcompl0, txdatak0[0], txdata0[7:0]};
         assign serdes_tx_hip_data[127:64]         = {3'h0, txdataskip1, 3'h0, txblkst1, txsynchd1, txswing1, tx_deemph1, tx_margin1, powerdown1, txdetectrx1, 4'h0, txdatak1[3], txdata1[31:24], 2'h0, txdatak1[2], txdata1[23:16], 2'h0, txdatak1[1], txdata1[15:8], txelecidle1, txcompl1, txdatak1[0], txdata1[7:0]};
         assign serdes_tx_hip_data[191:128]        = {3'h0, txdataskip2, 3'h0, txblkst2, txsynchd2, txswing2, tx_deemph2, tx_margin2, powerdown2, txdetectrx2, 4'h0, txdatak2[3], txdata2[31:24], 2'h0, txdatak2[2], txdata2[23:16], 2'h0, txdatak2[1], txdata2[15:8], txelecidle2, txcompl2, txdatak2[0], txdata2[7:0]};
         assign serdes_tx_hip_data[255:192]        = {3'h0, txdataskip3, 3'h0, txblkst3, txsynchd3, txswing3, tx_deemph3, tx_margin3, powerdown3, txdetectrx3, 4'h0, txdatak3[3], txdata3[31:24], 2'h0, txdatak3[2], txdata3[23:16], 2'h0, txdatak3[1], txdata3[15:8], txelecidle3, txcompl3, txdatak3[0], txdata3[7:0]};
         assign serdes_tx_hip_data[319:256]        = {3'h0, txdataskip4, 3'h0, txblkst4, txsynchd4, txswing4, tx_deemph4, tx_margin4, powerdown4, txdetectrx4, 4'h0, txdatak4[3], txdata4[31:24], 2'h0, txdatak4[2], txdata4[23:16], 2'h0, txdatak4[1], txdata4[15:8], txelecidle4, txcompl4, txdatak4[0], txdata4[7:0]};
         assign serdes_tx_hip_data[383:320]        = {3'h0, txdataskip5, 3'h0, txblkst5, txsynchd5, txswing5, tx_deemph5, tx_margin5, powerdown5, txdetectrx5, 4'h0, txdatak5[3], txdata5[31:24], 2'h0, txdatak5[2], txdata5[23:16], 2'h0, txdatak5[1], txdata5[15:8], txelecidle5, txcompl5, txdatak5[0], txdata5[7:0]};
         assign serdes_tx_hip_data[447:384]        = {3'h0, txdataskip6, 3'h0, txblkst6, txsynchd6, txswing6, tx_deemph6, tx_margin6, powerdown6, txdetectrx6, 4'h0, txdatak6[3], txdata6[31:24], 2'h0, txdatak6[2], txdata6[23:16], 2'h0, txdatak6[1], txdata6[15:8], txelecidle6, txcompl6, txdatak6[0], txdata6[7:0]};
         assign serdes_tx_hip_data[511:448]        = {3'h0, txdataskip7, 3'h0, txblkst7, txsynchd7, txswing7, tx_deemph7, tx_margin7, powerdown7, txdetectrx7, 4'h0, txdatak7[3], txdata7[31:24], 2'h0, txdatak7[2], txdata7[23:16], 2'h0, txdatak7[1], txdata7[15:8], txelecidle7, txcompl7, txdatak7[0], txdata7[7:0]};
         assign serdes_current_coeff[17:0]         = current_coeff0;
         assign serdes_current_coeff[35:18]        = current_coeff1;
         assign serdes_current_coeff[53:36]        = current_coeff2;
         assign serdes_current_coeff[71:54]        = current_coeff3;
         assign serdes_current_coeff[89:72]        = current_coeff4;
         assign serdes_current_coeff[107:90]       = current_coeff5;
         assign serdes_current_coeff[125:108]      = current_coeff6;
         assign serdes_current_coeff[143:126]      = current_coeff7;
         assign serdes_current_rxpreset[2:0]       = current_rxpreset0;
         assign serdes_current_rxpreset[5:3]       = current_rxpreset1;
         assign serdes_current_rxpreset[8:6]       = current_rxpreset2;
         assign serdes_current_rxpreset[11:9]      = current_rxpreset3;
         assign serdes_current_rxpreset[14:12]     = current_rxpreset4;
         assign serdes_current_rxpreset[17:15]     = current_rxpreset5;
         assign serdes_current_rxpreset[20:18]     = current_rxpreset6;
         assign serdes_current_rxpreset[23:21]     = current_rxpreset7;
         assign serdes_pipe_rxpolarity[0]          = rxpolarity0;
         assign serdes_pipe_rxpolarity[1]          = rxpolarity1;
         assign serdes_pipe_rxpolarity[2]          = rxpolarity2;
         assign serdes_pipe_rxpolarity[3]          = rxpolarity3;
         assign serdes_pipe_rxpolarity[4]          = rxpolarity4;
         assign serdes_pipe_rxpolarity[5]          = rxpolarity5;
         assign serdes_pipe_rxpolarity[6]          = rxpolarity6;
         assign serdes_pipe_rxpolarity[7]          = rxpolarity7;
         assign serdes_rx_eidle_infer_sel[2:0]     = eidle_infer_sel0;
         assign serdes_rx_eidle_infer_sel[5:3]     = eidle_infer_sel1;
         assign serdes_rx_eidle_infer_sel[8:6]     = eidle_infer_sel2;
         assign serdes_rx_eidle_infer_sel[11:9]    = eidle_infer_sel3;
         assign serdes_rx_eidle_infer_sel[14:12]   = eidle_infer_sel4;
         assign serdes_rx_eidle_infer_sel[17:15]   = eidle_infer_sel5;
         assign serdes_rx_eidle_infer_sel[20:18]   = eidle_infer_sel6;
         assign serdes_rx_eidle_infer_sel[23:21]   = eidle_infer_sel7;

         assign tx_out0                            = serdes_tx_serial_data[0];
         assign tx_out1                            = serdes_tx_serial_data[1];
         assign tx_out2                            = serdes_tx_serial_data[2];
         assign tx_out3                            = serdes_tx_serial_data[3];
         assign tx_out4                            = serdes_tx_serial_data[4];
         assign tx_out5                            = serdes_tx_serial_data[5];
         assign tx_out6                            = serdes_tx_serial_data[6];
         assign tx_out7                            = serdes_tx_serial_data[7];

         //RX
         //
         assign  serdes_rx_serial_data[0]=rx_in0;
         assign  serdes_rx_serial_data[1]=rx_in1;
         assign  serdes_rx_serial_data[2]=rx_in2;
         assign  serdes_rx_serial_data[3]=rx_in3;
         assign  serdes_rx_serial_data[4]=rx_in4;
         assign  serdes_rx_serial_data[5]=rx_in5;
         assign  serdes_rx_serial_data[6]=rx_in6;
         assign  serdes_rx_serial_data[7]=rx_in7;

         assign mserdes_pipe_pclk         = unconnected_wire;
         assign mserdes_pipe_pclkch1      = unconnected_wire;
         assign mserdes_pipe_pclkcentral  = serdes_pipe_pclk;
         assign mserdes_pllfixedclkch0    = unconnected_wire;
         assign mserdes_pllfixedclkch1    = unconnected_wire;
         assign mserdes_pllfixedclkcentral= serdes_pllfixedclk;

      end
   end
   endgenerate

   assign rate          = (pipe32_sim_only==1'b1)?rate0:currentspeed; 

   // HIP Pipe Inputs (Bundled as 'rx_hip_data' out of Native PHY)
   assign rxdata0       = (pipe32_sim_only==1'b1)?rxdata0_ext       :                                              serdes_rx_hip_data[ 31:  0];
   assign rxdata1       = (pipe32_sim_only==1'b1)?rxdata1_ext       :((LANES<2)                      )?ZEROS[31:0]:serdes_rx_hip_data[ 82: 51];
   assign rxdata2       = (pipe32_sim_only==1'b1)?rxdata2_ext       :((LANES<2)||(LANES<4)           )?ZEROS[31:0]:serdes_rx_hip_data[133:102];
   assign rxdata3       = (pipe32_sim_only==1'b1)?rxdata3_ext       :((LANES<2)||(LANES<4)           )?ZEROS[31:0]:serdes_rx_hip_data[184:153];
   assign rxdata4       = (pipe32_sim_only==1'b1)?rxdata4_ext       :((LANES<2)||(LANES<4)||(LANES<8))?ZEROS[31:0]:serdes_rx_hip_data[235:204];
   assign rxdata5       = (pipe32_sim_only==1'b1)?rxdata5_ext       :((LANES<2)||(LANES<4)||(LANES<8))?ZEROS[31:0]:serdes_rx_hip_data[286:255];
   assign rxdata6       = (pipe32_sim_only==1'b1)?rxdata6_ext       :((LANES<2)||(LANES<4)||(LANES<8))?ZEROS[31:0]:serdes_rx_hip_data[337:306];
   assign rxdata7       = (pipe32_sim_only==1'b1)?rxdata7_ext       :((LANES<2)||(LANES<4)||(LANES<8))?ZEROS[31:0]:serdes_rx_hip_data[388:357];
   assign rxdatak0      = (pipe32_sim_only==1'b1)?rxdatak0_ext      :                                              serdes_rx_hip_data[ 35: 32] ;
   assign rxdatak1      = (pipe32_sim_only==1'b1)?rxdatak1_ext      :((LANES<2)                      )?ZEROS[ 3:0]:serdes_rx_hip_data[ 86: 83] ;
   assign rxdatak2      = (pipe32_sim_only==1'b1)?rxdatak2_ext      :((LANES<2)||(LANES<4)           )?ZEROS[ 3:0]:serdes_rx_hip_data[137:134];
   assign rxdatak3      = (pipe32_sim_only==1'b1)?rxdatak3_ext      :((LANES<2)||(LANES<4)           )?ZEROS[ 3:0]:serdes_rx_hip_data[188:185] ;
   assign rxdatak4      = (pipe32_sim_only==1'b1)?rxdatak4_ext      :((LANES<2)||(LANES<4)||(LANES<8))?ZEROS[ 3:0]:serdes_rx_hip_data[239:236] ;
   assign rxdatak5      = (pipe32_sim_only==1'b1)?rxdatak5_ext      :((LANES<2)||(LANES<4)||(LANES<8))?ZEROS[ 3:0]:serdes_rx_hip_data[290:287] ;
   assign rxdatak6      = (pipe32_sim_only==1'b1)?rxdatak6_ext      :((LANES<2)||(LANES<4)||(LANES<8))?ZEROS[ 3:0]:serdes_rx_hip_data[341:338] ;
   assign rxdatak7      = (pipe32_sim_only==1'b1)?rxdatak7_ext      :((LANES<2)||(LANES<4)||(LANES<8))?ZEROS[ 3:0]:serdes_rx_hip_data[392:389] ;
   assign rxvalid0      = (pipe32_sim_only==1'b1)?rxvalid0_ext      :                                              serdes_rx_hip_data[ 37];
   assign rxvalid1      = (pipe32_sim_only==1'b1)?rxvalid1_ext      :((LANES<2)                      )?ZEROS[ 0:0]:serdes_rx_hip_data[ 88];
   assign rxvalid2      = (pipe32_sim_only==1'b1)?rxvalid2_ext      :((LANES<2)||(LANES<4)           )?ZEROS[ 0:0]:serdes_rx_hip_data[139];
   assign rxvalid3      = (pipe32_sim_only==1'b1)?rxvalid3_ext      :((LANES<2)||(LANES<4)           )?ZEROS[ 0:0]:serdes_rx_hip_data[190];
   assign rxvalid4      = (pipe32_sim_only==1'b1)?rxvalid4_ext      :((LANES<2)||(LANES<4)||(LANES<8))?ZEROS[ 0:0]:serdes_rx_hip_data[241];
   assign rxvalid5      = (pipe32_sim_only==1'b1)?rxvalid5_ext      :((LANES<2)||(LANES<4)||(LANES<8))?ZEROS[ 0:0]:serdes_rx_hip_data[292];
   assign rxvalid6      = (pipe32_sim_only==1'b1)?rxvalid6_ext      :((LANES<2)||(LANES<4)||(LANES<8))?ZEROS[ 0:0]:serdes_rx_hip_data[343];
   assign rxvalid7      = (pipe32_sim_only==1'b1)?rxvalid7_ext      :((LANES<2)||(LANES<4)||(LANES<8))?ZEROS[ 0:0]:serdes_rx_hip_data[394];
   assign rxelecidle0   = (pipe32_sim_only==1'b1)?rxelecidle0_ext   :                                              serdes_hip_ctrl[ 1];
   assign rxelecidle1   = (pipe32_sim_only==1'b1)?rxelecidle1_ext   :((LANES<2)                      )?ZEROS[ 0:0]:serdes_hip_ctrl[ 9];
   assign rxelecidle2   = (pipe32_sim_only==1'b1)?rxelecidle2_ext   :((LANES<2)||(LANES<4)           )?ZEROS[ 0:0]:serdes_hip_ctrl[17];
   assign rxelecidle3   = (pipe32_sim_only==1'b1)?rxelecidle3_ext   :((LANES<2)||(LANES<4)           )?ZEROS[ 0:0]:serdes_hip_ctrl[25];
   assign rxelecidle4   = (pipe32_sim_only==1'b1)?rxelecidle4_ext   :((LANES<2)||(LANES<4)||(LANES<8))?ZEROS[ 0:0]:serdes_hip_ctrl[33];
   assign rxelecidle5   = (pipe32_sim_only==1'b1)?rxelecidle5_ext   :((LANES<2)||(LANES<4)||(LANES<8))?ZEROS[ 0:0]:serdes_hip_ctrl[41];
   assign rxelecidle6   = (pipe32_sim_only==1'b1)?rxelecidle6_ext   :((LANES<2)||(LANES<4)||(LANES<8))?ZEROS[ 0:0]:serdes_hip_ctrl[49];
   assign rxelecidle7   = (pipe32_sim_only==1'b1)?rxelecidle7_ext   :((LANES<2)||(LANES<4)||(LANES<8))?ZEROS[ 0:0]:serdes_hip_ctrl[57];
   assign phystatus0    = (pipe32_sim_only==1'b1)?phystatus0_ext    :                                              serdes_rx_hip_data[ 36];
   assign phystatus1    = (pipe32_sim_only==1'b1)?phystatus1_ext    :((LANES<2)                      )?ZEROS[ 0:0]:serdes_rx_hip_data[ 87];
   assign phystatus2    = (pipe32_sim_only==1'b1)?phystatus2_ext    :((LANES<2)||(LANES<4)           )?ZEROS[ 0:0]:serdes_rx_hip_data[138];
   assign phystatus3    = (pipe32_sim_only==1'b1)?phystatus3_ext    :((LANES<2)||(LANES<4)           )?ZEROS[ 0:0]:serdes_rx_hip_data[189];
   assign phystatus4    = (pipe32_sim_only==1'b1)?phystatus4_ext    :((LANES<2)||(LANES<4)||(LANES<8))?ZEROS[ 0:0]:serdes_rx_hip_data[240];
   assign phystatus5    = (pipe32_sim_only==1'b1)?phystatus5_ext    :((LANES<2)||(LANES<4)||(LANES<8))?ZEROS[ 0:0]:serdes_rx_hip_data[291];
   assign phystatus6    = (pipe32_sim_only==1'b1)?phystatus6_ext    :((LANES<2)||(LANES<4)||(LANES<8))?ZEROS[ 0:0]:serdes_rx_hip_data[342];
   assign phystatus7    = (pipe32_sim_only==1'b1)?phystatus7_ext    :((LANES<2)||(LANES<4)||(LANES<8))?ZEROS[ 0:0]:serdes_rx_hip_data[393];
   assign rxstatus0     = (pipe32_sim_only==1'b1)?rxstatus0_ext     :                                              serdes_rx_hip_data[ 40: 38];
   assign rxstatus1     = (pipe32_sim_only==1'b1)?rxstatus1_ext     :((LANES<2)                      )?ZEROS[ 2:0]:serdes_rx_hip_data[ 91: 89];
   assign rxstatus2     = (pipe32_sim_only==1'b1)?rxstatus2_ext     :((LANES<2)||(LANES<4)           )?ZEROS[ 2:0]:serdes_rx_hip_data[142:140];
   assign rxstatus3     = (pipe32_sim_only==1'b1)?rxstatus3_ext     :((LANES<2)||(LANES<4)           )?ZEROS[ 2:0]:serdes_rx_hip_data[193:191];
   assign rxstatus4     = (pipe32_sim_only==1'b1)?rxstatus4_ext     :((LANES<2)||(LANES<4)||(LANES<8))?ZEROS[ 2:0]:serdes_rx_hip_data[244:242];
   assign rxstatus5     = (pipe32_sim_only==1'b1)?rxstatus5_ext     :((LANES<2)||(LANES<4)||(LANES<8))?ZEROS[ 2:0]:serdes_rx_hip_data[295:293];
   assign rxstatus6     = (pipe32_sim_only==1'b1)?rxstatus6_ext     :((LANES<2)||(LANES<4)||(LANES<8))?ZEROS[ 2:0]:serdes_rx_hip_data[346:344];
   assign rxstatus7     = (pipe32_sim_only==1'b1)?rxstatus7_ext     :((LANES<2)||(LANES<4)||(LANES<8))?ZEROS[ 2:0]:serdes_rx_hip_data[397:395];
   assign rxdataskip0   = (pipe32_sim_only==1'b1)?rxdataskip0_ext   :                                              serdes_rx_hip_data[47];
   assign rxdataskip1   = (pipe32_sim_only==1'b1)?rxdataskip1_ext   :((LANES<2)                      )?ZEROS[ 0:0]:serdes_rx_hip_data[98];
   assign rxdataskip2   = (pipe32_sim_only==1'b1)?rxdataskip2_ext   :((LANES<2)||(LANES<4)           )?ZEROS[ 0:0]:serdes_rx_hip_data[149];
   assign rxdataskip3   = (pipe32_sim_only==1'b1)?rxdataskip3_ext   :((LANES<2)||(LANES<4)           )?ZEROS[ 0:0]:serdes_rx_hip_data[200];
   assign rxdataskip4   = (pipe32_sim_only==1'b1)?rxdataskip4_ext   :((LANES<2)||(LANES<4)||(LANES<8))?ZEROS[ 0:0]:serdes_rx_hip_data[251];
   assign rxdataskip5   = (pipe32_sim_only==1'b1)?rxdataskip5_ext   :((LANES<2)||(LANES<4)||(LANES<8))?ZEROS[ 0:0]:serdes_rx_hip_data[302];
   assign rxdataskip6   = (pipe32_sim_only==1'b1)?rxdataskip6_ext   :((LANES<2)||(LANES<4)||(LANES<8))?ZEROS[ 0:0]:serdes_rx_hip_data[353];
   assign rxdataskip7   = (pipe32_sim_only==1'b1)?rxdataskip7_ext   :((LANES<2)||(LANES<4)||(LANES<8))?ZEROS[ 0:0]:serdes_rx_hip_data[404];
   assign rxblkst0      = (pipe32_sim_only==1'b1)?rxblkst0_ext      :                                              serdes_rx_hip_data[ 43];
   assign rxblkst1      = (pipe32_sim_only==1'b1)?rxblkst1_ext      :((LANES<2)                      )?ZEROS[ 0:0]:serdes_rx_hip_data[ 94];
   assign rxblkst2      = (pipe32_sim_only==1'b1)?rxblkst2_ext      :((LANES<2)||(LANES<4)           )?ZEROS[ 0:0]:serdes_rx_hip_data[145];
   assign rxblkst3      = (pipe32_sim_only==1'b1)?rxblkst3_ext      :((LANES<2)||(LANES<4)           )?ZEROS[ 0:0]:serdes_rx_hip_data[196];
   assign rxblkst4      = (pipe32_sim_only==1'b1)?rxblkst4_ext      :((LANES<2)||(LANES<4)||(LANES<8))?ZEROS[ 0:0]:serdes_rx_hip_data[247];
   assign rxblkst5      = (pipe32_sim_only==1'b1)?rxblkst5_ext      :((LANES<2)||(LANES<4)||(LANES<8))?ZEROS[ 0:0]:serdes_rx_hip_data[298];
   assign rxblkst6      = (pipe32_sim_only==1'b1)?rxblkst6_ext      :((LANES<2)||(LANES<4)||(LANES<8))?ZEROS[ 0:0]:serdes_rx_hip_data[349];
   assign rxblkst7      = (pipe32_sim_only==1'b1)?rxblkst7_ext      :((LANES<2)||(LANES<4)||(LANES<8))?ZEROS[ 0:0]:serdes_rx_hip_data[400];
   assign rxsynchd0     = (pipe32_sim_only==1'b1)?rxsynchd0_ext     :                                              serdes_rx_hip_data[ 42: 41];
   assign rxsynchd1     = (pipe32_sim_only==1'b1)?rxsynchd1_ext     :((LANES<2)                      )?ZEROS[ 1:0]:serdes_rx_hip_data[ 93: 92];
   assign rxsynchd2     = (pipe32_sim_only==1'b1)?rxsynchd2_ext     :((LANES<2)||(LANES<4)           )?ZEROS[ 1:0]:serdes_rx_hip_data[144:143];
   assign rxsynchd3     = (pipe32_sim_only==1'b1)?rxsynchd3_ext     :((LANES<2)||(LANES<4)           )?ZEROS[ 1:0]:serdes_rx_hip_data[195:194];
   assign rxsynchd4     = (pipe32_sim_only==1'b1)?rxsynchd4_ext     :((LANES<2)||(LANES<4)||(LANES<8))?ZEROS[ 1:0]:serdes_rx_hip_data[246:245];
   assign rxsynchd5     = (pipe32_sim_only==1'b1)?rxsynchd5_ext     :((LANES<2)||(LANES<4)||(LANES<8))?ZEROS[ 1:0]:serdes_rx_hip_data[297:296];
   assign rxsynchd6     = (pipe32_sim_only==1'b1)?rxsynchd6_ext     :((LANES<2)||(LANES<4)||(LANES<8))?ZEROS[ 1:0]:serdes_rx_hip_data[348:347];
   assign rxsynchd7     = (pipe32_sim_only==1'b1)?rxsynchd7_ext     :((LANES<2)||(LANES<4)||(LANES<8))?ZEROS[ 1:0]:serdes_rx_hip_data[399:398];

   //Fix for FogBugz: 311040 : PCIe - HIP to Core (unexpected) timing failure path on NF5 I3
   wire  pm_exit_d0_req;
   reg   pm_exit_d0_req_r;

   always @(posedge pld_clk)
      begin
         pm_exit_d0_req_r <= pm_exit_d0_req;
      end

   // HIP Atom

	// cyquek.hold_ltssm_rec.rev1.begin
	wire		hold_ltssm_rec;
	
	reg	         hold_ltssm_rec_r;
	reg   [21:0]	hold_ltssm_rec_count;
      
	reg   [1:0]		currentspeed_r;
	reg   [1:0]		currentspeed_rr;
	reg   [4:0]		ltssmstate_r;
	reg   [4:0]		ltssmstate_rr;

	localparam	HOLD_COUNT_MAX_G3 = ALTPCIE_HIP_256_PIPEN1B_SIM_ONLY ? 22'h0 : 22'd2500_000; // 10ms
	localparam	HOLD_COUNT_MAX_G2G1 = ALTPCIE_HIP_256_PIPEN1B_SIM_ONLY ? 22'h0 : 22'd175_000; // 700us
   
   assign	hold_ltssm_rec = hold_ltssm_rec_r;
	
	always @(posedge pld_clk, negedge npor)
		begin
		if (~npor)
			begin
			hold_ltssm_rec_r     <= 1'd0;
			hold_ltssm_rec_count <= 22'd0;			
			currentspeed_r       <= 2'd0;			
			currentspeed_rr      <= 2'd0;			
			ltssmstate_r         <= 5'd0;			
			ltssmstate_rr        <= 5'd0;			
			end
		else
			begin
			currentspeed_r  <= currentspeed;
			currentspeed_rr <= currentspeed_r;
			ltssmstate_r    <= ltssmstate;
			ltssmstate_rr   <= ltssmstate_r;
				// only speed.change will reset the count, to avoid subsequent retrain gating the rec.rxlk??
				if(currentspeed_rr != currentspeed_r)
					begin
					hold_ltssm_rec_r <= 1'b0;
					hold_ltssm_rec_count <= 22'd0;
					end
				// if current.state = rec.rxlk & current.speed = gen3, assert hold_ltssm_rec until timeout (10ms)
				else if(ltssmstate_rr == LTSSM_EQ_REC_RXLK && currentspeed_rr == 2'h3 && hold_ltssm_rec_count != HOLD_COUNT_MAX_G3)
					begin
					hold_ltssm_rec_r <= 1'b1;
					hold_ltssm_rec_count <= hold_ltssm_rec_count + 22'd1;
					end
				// if current.state = rec.rxlk & current.speed = (gen1 || gen2), assert hold_ltssm_rec until timeout (700us)
				else if(ltssmstate_rr == LTSSM_EQ_REC_RXLK && (currentspeed_rr == 2'h1 || currentspeed_rr == 2'h2) && hold_ltssm_rec_count != HOLD_COUNT_MAX_G2G1)
					begin
					hold_ltssm_rec_r <= 1'b1;
					hold_ltssm_rec_count <= hold_ltssm_rec_count + 22'd1;
					end
				// de-assert hold_ltssm_rec but remain the count, to avoid subsequent retrain gating the rec.rxlk??
				else 
					begin
					hold_ltssm_rec_r <= 1'b0;
					hold_ltssm_rec_count <= hold_ltssm_rec_count;
					end
			end
		end
	// cyquek.hold_ltssm_rec.rev1.end

   twentynm_hssi_gen3_x8_pcie_hip  # (
      .func_mode                                                     (func_mode                                                     ),
      .sup_mode                                                      (sup_mode                                                      ),
      .lane_rate                                                     (lane_rate                                                     ),
      .link_width                                                    (link_width                                                    ),
      .port_type                                                     (port_type                                                     ),
      .pcie_base_spec                                                (pcie_base_spec                                                ),
      .app_interface_width                                           (app_interface_width                                           ),
      .rx_buffer_credit_alloc                                        (rx_buffer_credit_alloc                                        ),
      .hrdrstctrl_en                                                 (hrdrstctrl_en                                                 ),
      .uc_calibration_en                                             (uc_calibration_en                                             ),
      .cvp_enable                                                    (cvp_enable                                                    ),
      .advance_error_reporting                                       (advance_error_reporting                                       ),
      .sim_mode                                                      ((ALTPCIE_HIP_256_PIPEN1B_SIM_ONLY==1)?"enable":sim_mode       ),
      .bar0_type                                                     (bar0_type                                                     ),
      .bar1_type                                                     (bar1_type                                                     ),
      .bar2_type                                                     (bar2_type                                                     ),
      .bar3_type                                                     (bar3_type                                                     ),
      .bar4_type                                                     (bar4_type                                                     ),
      .bar5_type                                                     (bar5_type                                                     ),
      .bar0_size_mask                                                (bar0_size_mask                                                ),
      .bar1_size_mask                                                (bar1_size_mask                                                ),
      .bar2_size_mask                                                (bar2_size_mask                                                ),
      .bar3_size_mask                                                (bar3_size_mask                                                ),
      .bar4_size_mask                                                (bar4_size_mask                                                ),
      .bar5_size_mask                                                (bar5_size_mask                                                ),
      .acknack_base                                                  (acknack_base                                                  ),
      .silicon_rev                                                   (silicon_rev                                                   ),
      .acknack_set                                                   (acknack_set                                                   ),
      .arb_upfc_30us_counter                                         (arb_upfc_30us_counter                                         ),
      .arb_upfc_30us_en                                              (arb_upfc_30us_en                                              ),
      .aspm_config_management                                        (aspm_config_management                                        ),
      .aspm_patch_disable                                            (aspm_patch_disable                                            ),
      .ast_width_rx                                                  (ast_width_rx                                                  ),
      .ast_width_tx                                                  (ast_width_tx                                                  ),
      .atomic_malformed                                              (atomic_malformed                                              ),
      .atomic_op_completer_32bit                                     (atomic_op_completer_32bit                                     ),
      .atomic_op_routing                                             (atomic_op_routing                                             ),
      .atomic_op_completer_64bit                                     (atomic_op_completer_64bit                                     ),
      .auto_msg_drop_enable                                          (auto_msg_drop_enable                                          ),
      .base_counter_sel                                              (base_counter_sel                                              ),
      .bist_memory_settings                                          (bist_memory_settings                                          ),
      .bridge_port_vga_enable                                        (bridge_port_vga_enable                                        ),
      .bridge_port_ssid_support                                      (bridge_port_ssid_support                                      ),
      .bypass_cdc                                                    (bypass_cdc                                                    ),
      .bypass_clk_switch                                             (bypass_clk_switch                                             ),
      .bypass_tl                                                     (bypass_tl                                                     ),
      .cas_completer_128bit                                          (cas_completer_128bit                                          ),
      .cdc_clk_relation                                              (cdc_clk_relation                                              ),
      .cdc_dummy_insert_limit                                        (cdc_dummy_insert_limit                                        ),
      .cfg_parchk_ena                                                (cfg_parchk_ena                                                ),
      .cfgbp_req_recov_disable                                       (cfgbp_req_recov_disable                                       ),
      .class_code                                                    (class_code                                                    ),
      .clock_pwr_management                                          (clock_pwr_management                                          ),
      .completion_timeout                                            (completion_timeout                                            ),
      .core_clk_divider                                              (core_clk_divider                                              ),
      .core_clk_freq_mhz                                             (core_clk_freq_mhz                                             ),
      .core_clk_out_sel                                              (core_clk_out_sel                                              ),
      .core_clk_sel                                                  (core_clk_sel                                                  ),
      .core_clk_source                                               (core_clk_source                                               ),
      .cseb_extend_pci                                               (((TLP_INSPECTOR==1)&&(cseb_config_bypass=="disable"))?"false"              : cseb_extend_pci),
      .cseb_extend_pcie                                              (((TLP_INSPECTOR==1)&&(cseb_config_bypass=="disable"))?"true"               : cseb_extend_pcie),
      .cseb_cpl_status_during_cvp                                    (((TLP_INSPECTOR==1)&&(cseb_config_bypass=="disable"))?"config_retry_status": cseb_cpl_status_during_cvp),
      .cseb_route_to_avl_rx_st                                       (((TLP_INSPECTOR==1)&&(cseb_config_bypass=="disable"))?"cseb"               : cseb_route_to_avl_rx_st),
      .cseb_config_bypass                                            (                                                                             cseb_config_bypass),
      .cseb_cpl_tag_checking                                         (                                                                             cseb_cpl_tag_checking),
      .cseb_bar_match_checking                                       (((TLP_INSPECTOR==1)&&(cseb_config_bypass=="disable"))?"enable"             : cseb_bar_match_checking),
      .cseb_min_error_checking                                       (                                                                             cseb_min_error_checking),
      .cseb_temp_busy_crs                                            (                                                                             cseb_temp_busy_crs),
      .cseb_disable_auto_crs                                         (                                                                             cseb_disable_auto_crs),
      .cvp_clk_reset                                                 (cvp_clk_reset                                                 ),
      .cvp_data_compressed                                           (cvp_data_compressed                                           ),
      .cvp_data_encrypted                                            (cvp_data_encrypted                                            ),
      .cvp_mode_reset                                                (cvp_mode_reset                                                ),
      .cvp_rate_sel                                                  (cvp_rate_sel                                                  ),
      .d0_pme                                                        (d0_pme                                                        ),
      .d1_pme                                                        (d1_pme                                                        ),
      .d2_pme                                                        (d2_pme                                                        ),
      .d1_support                                                    (d1_support                                                    ),
      .d2_support                                                    (d2_support                                                    ),
      .d3_hot_pme                                                    (d3_hot_pme                                                    ),
      .d3_cold_pme                                                   (d3_cold_pme                                                   ),
      .data_pack_rx                                                  (data_pack_rx                                                  ),
      .deemphasis_enable                                             (deemphasis_enable                                             ),
      .deskew_comma                                                  ((ALTPCIE_HIP_256_PIPEN1B_SIM_ONLY==1)?deskew_comma_sim_only:deskew_comma),
      .device_id                                                     (device_id                                                     ),
      .device_number                                                 (device_number                                                 ),
      .device_specific_init                                          (device_specific_init                                          ),
      .dft_clock_obsrv_en                                            (dft_clock_obsrv_en                                            ),
      .dft_clock_obsrv_sel                                           (dft_clock_obsrv_sel                                           ),
      .diffclock_nfts_count                                          (diffclock_nfts_count                                          ),
      .dis_cplovf                                                    (dis_cplovf                                                    ),
      .dis_paritychk                                                 (dis_paritychk                                                 ),
      .disable_link_x2_support                                       (disable_link_x2_support                                       ),
      .disable_snoop_packet                                          (disable_snoop_packet                                          ),
      .dl_tx_check_parity_edb                                        (dl_tx_check_parity_edb                                        ),
      .dll_active_report_support                                     (dll_active_report_support                                     ),
      .early_dl_up                                                   (early_dl_up                                                   ),
      .ecrc_check_capable                                            (ecrc_check_capable                                            ),
      .ecrc_gen_capable                                              (ecrc_gen_capable                                              ),
      .egress_block_err_report_ena                                   (egress_block_err_report_ena                                   ),
      .ei_delay_powerdown_count                                      (ei_delay_powerdown_count                                      ),
      .eie_before_nfts_count                                         (eie_before_nfts_count                                         ),
      .electromech_interlock                                         (electromech_interlock                                         ),
      .en_ieiupdatefc                                                (en_ieiupdatefc                                                ),
      .en_lane_errchk                                                (en_lane_errchk                                                ),
      .en_phystatus_dly                                              (en_phystatus_dly                                              ),
      .ena_ido_cpl                                                   (ena_ido_cpl                                                   ),
      .ena_ido_req                                                   (ena_ido_req                                                   ),
      .enable_adapter_half_rate_mode                                 (enable_adapter_half_rate_mode                                 ),
      .enable_ch0_pclk_out                                           (enable_ch0_pclk_out                                           ),
      .enable_ch01_pclk_out                                          (enable_ch01_pclk_out                                          ),
      .enable_completion_timeout_disable                             (enable_completion_timeout_disable                             ),
      .enable_directed_spd_chng                                      ((ALTPCIE_HIP_256_PIPEN1B_SIM_ONLY==1)?enable_directed_spd_chng_sim_only:enable_directed_spd_chng),
      .enable_function_msix_support                                  (enable_function_msix_support                                  ),
      .enable_l0s_aspm                                               (enable_l0s_aspm                                               ),
      .enable_l1_aspm                                                (enable_l1_aspm                                                ),
      .enable_rx_buffer_checking                                     (enable_rx_buffer_checking                                     ),
      .enable_rx_reordering                                          (enable_rx_reordering                                          ),
      .enable_slot_register                                          (enable_slot_register                                          ),
      .endpoint_l0_latency                                           (endpoint_l0_latency                                           ),
      .endpoint_l1_latency                                           (endpoint_l1_latency                                           ),
      .eql_rq_int_en_number                                          (eql_rq_int_en_number                                          ),
      .errmgt_fcpe_patch_dis                                         (errmgt_fcpe_patch_dis                                         ),
      .errmgt_fep_patch_dis                                          (errmgt_fep_patch_dis                                          ),
      .expansion_base_address_register                               (expansion_base_address_register                               ),
      .extend_tag_field                                              (extend_tag_field                                              ),
      .extended_format_field                                         (extended_format_field                                         ),
      .extended_tag_reset                                            (extended_tag_reset                                            ),
      .fc_init_timer                                                 (fc_init_timer                                                 ),
      .flow_control_timeout_count                                    (flow_control_timeout_count                                    ),
      .flow_control_update_count                                     (flow_control_update_count                                     ),
      .flr_capability                                                (flr_capability                                                ),
      .force_dis_to_det                                              (force_dis_to_det                                              ),
      .force_gen1_dis                                                (force_gen1_dis                                                ),
      .force_tx_coeff_preset_lpbk                                    (force_tx_coeff_preset_lpbk                                    ),
      .frame_err_patch_dis                                           (frame_err_patch_dis                                           ),
      .g3_bypass_equlz                                               (g3_bypass_equlz                                               ),
      .g3_coeff_done_tmout                                           (g3_coeff_done_tmout                                           ),
      .g3_deskew_char                                                (g3_deskew_char                                                ),
      .g3_dis_be_frm_err                                             (g3_dis_be_frm_err                                             ),
      .g3_dn_rx_hint_eqlz_0                                          (g3_dn_rx_hint_eqlz_0                                          ),
      .g3_dn_rx_hint_eqlz_1                                          (g3_dn_rx_hint_eqlz_1                                          ),
      .g3_dn_rx_hint_eqlz_2                                          (g3_dn_rx_hint_eqlz_2                                          ),
      .g3_dn_rx_hint_eqlz_3                                          (g3_dn_rx_hint_eqlz_3                                          ),
      .g3_dn_rx_hint_eqlz_4                                          (g3_dn_rx_hint_eqlz_4                                          ),
      .g3_dn_rx_hint_eqlz_5                                          (g3_dn_rx_hint_eqlz_5                                          ),
      .g3_dn_rx_hint_eqlz_6                                          (g3_dn_rx_hint_eqlz_6                                          ),
      .g3_dn_rx_hint_eqlz_7                                          (g3_dn_rx_hint_eqlz_7                                          ),
      .g3_dn_tx_preset_eqlz_0                                        (g3_dn_tx_preset_eqlz_0                                        ),
      .g3_dn_tx_preset_eqlz_1                                        (g3_dn_tx_preset_eqlz_1                                        ),
      .g3_dn_tx_preset_eqlz_2                                        (g3_dn_tx_preset_eqlz_2                                        ),
      .g3_dn_tx_preset_eqlz_3                                        (g3_dn_tx_preset_eqlz_3                                        ),
      .g3_dn_tx_preset_eqlz_4                                        (g3_dn_tx_preset_eqlz_4                                        ),
      .g3_dn_tx_preset_eqlz_5                                        (g3_dn_tx_preset_eqlz_5                                        ),
      .g3_dn_tx_preset_eqlz_6                                        (g3_dn_tx_preset_eqlz_6                                        ),
      .g3_dn_tx_preset_eqlz_7                                        (g3_dn_tx_preset_eqlz_7                                        ),
      .g3_force_ber_max                                              (g3_force_ber_max                                              ),
      .g3_force_ber_min                                              (g3_force_ber_min                                              ),
      .g3_lnk_trn_rx_ts                                              (g3_lnk_trn_rx_ts                                              ),
      .g3_ltssm_eq_dbg                                               (g3_ltssm_eq_dbg                                               ),
      .g3_ltssm_rec_dbg                                              ((ALTPCIE_HIP_256_PIPEN1B_SIM_ONLY==1)?g3_ltssm_rec_dbg_sim_only:g3_ltssm_rec_dbg),
      .g3_pause_ltssm_rec_en                                         (g3_pause_ltssm_rec_en                                         ),
      .g3_quiesce_guarant                                            (g3_quiesce_guarant                                            ),
      .g3_redo_equlz_dis                                             (g3_redo_equlz_dis                                             ),
      .g3_redo_equlz_en                                              (g3_redo_equlz_en                                              ),
      .g3_up_rx_hint_eqlz_0                                          (g3_up_rx_hint_eqlz_0                                          ),
      .g3_up_rx_hint_eqlz_1                                          (g3_up_rx_hint_eqlz_1                                          ),
      .g3_up_rx_hint_eqlz_2                                          (g3_up_rx_hint_eqlz_2                                          ),
      .g3_up_rx_hint_eqlz_3                                          (g3_up_rx_hint_eqlz_3                                          ),
      .g3_up_rx_hint_eqlz_4                                          (g3_up_rx_hint_eqlz_4                                          ),
      .g3_up_rx_hint_eqlz_5                                          (g3_up_rx_hint_eqlz_5                                          ),
      .g3_up_rx_hint_eqlz_6                                          (g3_up_rx_hint_eqlz_6                                          ),
      .g3_up_rx_hint_eqlz_7                                          (g3_up_rx_hint_eqlz_7                                          ),
      .g3_up_tx_preset_eqlz_0                                        (g3_up_tx_preset_eqlz_0                                        ),
      .g3_up_tx_preset_eqlz_1                                        (g3_up_tx_preset_eqlz_1                                        ),
      .g3_up_tx_preset_eqlz_2                                        (g3_up_tx_preset_eqlz_2                                        ),
      .g3_up_tx_preset_eqlz_3                                        (g3_up_tx_preset_eqlz_3                                        ),
      .g3_up_tx_preset_eqlz_4                                        (g3_up_tx_preset_eqlz_4                                        ),
      .g3_up_tx_preset_eqlz_5                                        (g3_up_tx_preset_eqlz_5                                        ),
      .g3_up_tx_preset_eqlz_6                                        (g3_up_tx_preset_eqlz_6                                        ),
      .g3_up_tx_preset_eqlz_7                                        (g3_up_tx_preset_eqlz_7                                        ),
      .gen123_lane_rate_mode                                         (gen123_lane_rate_mode                                         ),
      .gen2_diffclock_nfts_count                                     (gen2_diffclock_nfts_count                                     ),
      .gen2_pma_pll_usage                                            (gen2_pma_pll_usage                                            ),
      .gen2_sameclock_nfts_count                                     (gen2_sameclock_nfts_count                                     ),
      .gen3_coeff_1                                                  (gen3_coeff_1                                                  ),
      .gen3_coeff_1_sel                                              (gen3_coeff_1_sel                                              ),
      .gen3_coeff_1_preset_hint                                      (gen3_coeff_1_preset_hint                                      ),
      .gen3_coeff_1_nxtber_more                                      (gen3_coeff_1_nxtber_more                                      ),
      .gen3_coeff_1_nxtber_less                                      (gen3_coeff_1_nxtber_less                                      ),
      .gen3_coeff_1_reqber                                           (gen3_coeff_1_reqber                                           ),
      .gen3_coeff_1_ber_meas                                         (gen3_coeff_1_ber_meas                                         ),
      .gen3_coeff_2                                                  (gen3_coeff_2                                                  ),
      .gen3_coeff_2_sel                                              (gen3_coeff_2_sel                                              ),
      .gen3_coeff_2_preset_hint                                      (gen3_coeff_2_preset_hint                                      ),
      .gen3_coeff_2_nxtber_more                                      (gen3_coeff_2_nxtber_more                                      ),
      .gen3_coeff_2_nxtber_less                                      (gen3_coeff_2_nxtber_less                                      ),
      .gen3_coeff_2_reqber                                           (gen3_coeff_2_reqber                                           ),
      .gen3_coeff_2_ber_meas                                         (gen3_coeff_2_ber_meas                                         ),
      .gen3_coeff_3                                                  (gen3_coeff_3                                                  ),
      .gen3_coeff_3_sel                                              (gen3_coeff_3_sel                                              ),
      .gen3_coeff_3_preset_hint                                      (gen3_coeff_3_preset_hint                                      ),
      .gen3_coeff_3_nxtber_more                                      (gen3_coeff_3_nxtber_more                                      ),
      .gen3_coeff_3_nxtber_less                                      (gen3_coeff_3_nxtber_less                                      ),
      .gen3_coeff_3_reqber                                           (gen3_coeff_3_reqber                                           ),
      .gen3_coeff_3_ber_meas                                         ((ALTPCIE_HIP_256_PIPEN1B_SIM_ONLY==1)?gen3_coeff_3_ber_meas_sim_only:gen3_coeff_3_ber_meas),
      .gen3_coeff_4                                                  (gen3_coeff_4                                                  ),
      .gen3_coeff_4_sel                                              (gen3_coeff_4_sel                                              ),
      .gen3_coeff_4_preset_hint                                      (gen3_coeff_4_preset_hint                                      ),
      .gen3_coeff_4_nxtber_more                                      (gen3_coeff_4_nxtber_more                                      ),
      .gen3_coeff_4_nxtber_less                                      (gen3_coeff_4_nxtber_less                                      ),
      .gen3_coeff_4_reqber                                           (gen3_coeff_4_reqber                                           ),
      .gen3_coeff_4_ber_meas                                         (gen3_coeff_4_ber_meas                                         ),
      .gen3_coeff_5                                                  (gen3_coeff_5                                                  ),
      .gen3_coeff_5_sel                                              (gen3_coeff_5_sel                                              ),
      .gen3_coeff_5_preset_hint                                      (gen3_coeff_5_preset_hint                                      ),
      .gen3_coeff_5_nxtber_more                                      (gen3_coeff_5_nxtber_more                                      ),
      .gen3_coeff_5_nxtber_less                                      (gen3_coeff_5_nxtber_less                                      ),
      .gen3_coeff_5_reqber                                           (gen3_coeff_5_reqber                                           ),
      .gen3_coeff_5_ber_meas                                         (gen3_coeff_5_ber_meas                                         ),
      .gen3_coeff_6                                                  (gen3_coeff_6                                                  ),
      .gen3_coeff_6_sel                                              (gen3_coeff_6_sel                                              ),
      .gen3_coeff_6_preset_hint                                      (gen3_coeff_6_preset_hint                                      ),
      .gen3_coeff_6_nxtber_more                                      (gen3_coeff_6_nxtber_more                                      ),
      .gen3_coeff_6_nxtber_less                                      (gen3_coeff_6_nxtber_less                                      ),
      .gen3_coeff_6_reqber                                           (gen3_coeff_6_reqber                                           ),
      .gen3_coeff_6_ber_meas                                         (gen3_coeff_6_ber_meas                                         ),
      .gen3_coeff_7                                                  (gen3_coeff_7                                                  ),
      .gen3_coeff_7_sel                                              (gen3_coeff_7_sel                                              ),
      .gen3_coeff_7_preset_hint                                      (gen3_coeff_7_preset_hint                                      ),
      .gen3_coeff_7_nxtber_more                                      (gen3_coeff_7_nxtber_more                                      ),
      .gen3_coeff_7_nxtber_less                                      (gen3_coeff_7_nxtber_less                                      ),
      .gen3_coeff_7_reqber                                           (gen3_coeff_7_reqber                                           ),
      .gen3_coeff_7_ber_meas                                         (gen3_coeff_7_ber_meas                                         ),
      .gen3_coeff_8                                                  (gen3_coeff_8                                                  ),
      .gen3_coeff_8_sel                                              (gen3_coeff_8_sel                                              ),
      .gen3_coeff_8_preset_hint                                      (gen3_coeff_8_preset_hint                                      ),
      .gen3_coeff_8_nxtber_more                                      (gen3_coeff_8_nxtber_more                                      ),
      .gen3_coeff_8_nxtber_less                                      (gen3_coeff_8_nxtber_less                                      ),
      .gen3_coeff_8_reqber                                           (gen3_coeff_8_reqber                                           ),
      .gen3_coeff_8_ber_meas                                         (gen3_coeff_8_ber_meas                                         ),
      .gen3_coeff_9                                                  (gen3_coeff_9                                                  ),
      .gen3_coeff_9_sel                                              (gen3_coeff_9_sel                                              ),
      .gen3_coeff_9_preset_hint                                      (gen3_coeff_9_preset_hint                                      ),
      .gen3_coeff_9_nxtber_more                                      (gen3_coeff_9_nxtber_more                                      ),
      .gen3_coeff_9_nxtber_less                                      (gen3_coeff_9_nxtber_less                                      ),
      .gen3_coeff_9_reqber                                           (gen3_coeff_9_reqber                                           ),
      .gen3_coeff_9_ber_meas                                         (gen3_coeff_9_ber_meas                                         ),
      .gen3_coeff_10                                                 (gen3_coeff_10                                                 ),
      .gen3_coeff_10_sel                                             (gen3_coeff_10_sel                                             ),
      .gen3_coeff_10_preset_hint                                     (gen3_coeff_10_preset_hint                                     ),
      .gen3_coeff_10_nxtber_more                                     (gen3_coeff_10_nxtber_more                                     ),
      .gen3_coeff_10_nxtber_less                                     (gen3_coeff_10_nxtber_less                                     ),
      .gen3_coeff_10_reqber                                          (gen3_coeff_10_reqber                                          ),
      .gen3_coeff_10_ber_meas                                        (gen3_coeff_10_ber_meas                                        ),
      .gen3_coeff_11                                                 (gen3_coeff_11                                                 ),
      .gen3_coeff_11_sel                                             (gen3_coeff_11_sel                                             ),
      .gen3_coeff_11_preset_hint                                     (gen3_coeff_11_preset_hint                                     ),
      .gen3_coeff_11_nxtber_more                                     (gen3_coeff_11_nxtber_more                                     ),
      .gen3_coeff_11_nxtber_less                                     (gen3_coeff_11_nxtber_less                                     ),
      .gen3_coeff_11_reqber                                          (gen3_coeff_11_reqber                                          ),
      .gen3_coeff_11_ber_meas                                        (gen3_coeff_11_ber_meas                                        ),
      .gen3_coeff_12                                                 (gen3_coeff_12                                                 ),
      .gen3_coeff_12_sel                                             (gen3_coeff_12_sel                                             ),
      .gen3_coeff_12_preset_hint                                     (gen3_coeff_12_preset_hint                                     ),
      .gen3_coeff_12_nxtber_more                                     (gen3_coeff_12_nxtber_more                                     ),
      .gen3_coeff_12_nxtber_less                                     (gen3_coeff_12_nxtber_less                                     ),
      .gen3_coeff_12_reqber                                          (gen3_coeff_12_reqber                                          ),
      .gen3_coeff_12_ber_meas                                        (gen3_coeff_12_ber_meas                                        ),
      .gen3_coeff_13                                                 (gen3_coeff_13                                                 ),
      .gen3_coeff_13_sel                                             (gen3_coeff_13_sel                                             ),
      .gen3_coeff_13_preset_hint                                     (gen3_coeff_13_preset_hint                                     ),
      .gen3_coeff_13_nxtber_more                                     (gen3_coeff_13_nxtber_more                                     ),
      .gen3_coeff_13_nxtber_less                                     (gen3_coeff_13_nxtber_less                                     ),
      .gen3_coeff_13_reqber                                          (gen3_coeff_13_reqber                                          ),
      .gen3_coeff_13_ber_meas                                        (gen3_coeff_13_ber_meas                                        ),
      .gen3_coeff_14                                                 (gen3_coeff_14                                                 ),
      .gen3_coeff_14_sel                                             (gen3_coeff_14_sel                                             ),
      .gen3_coeff_14_preset_hint                                     (gen3_coeff_14_preset_hint                                     ),
      .gen3_coeff_14_nxtber_more                                     (gen3_coeff_14_nxtber_more                                     ),
      .gen3_coeff_14_nxtber_less                                     (gen3_coeff_14_nxtber_less                                     ),
      .gen3_coeff_14_reqber                                          (gen3_coeff_14_reqber                                          ),
      .gen3_coeff_14_ber_meas                                        (gen3_coeff_14_ber_meas                                        ),
      .gen3_coeff_15                                                 (gen3_coeff_15                                                 ),
      .gen3_coeff_15_sel                                             (gen3_coeff_15_sel                                             ),
      .gen3_coeff_15_preset_hint                                     (gen3_coeff_15_preset_hint                                     ),
      .gen3_coeff_15_nxtber_more                                     (gen3_coeff_15_nxtber_more                                     ),
      .gen3_coeff_15_nxtber_less                                     (gen3_coeff_15_nxtber_less                                     ),
      .gen3_coeff_15_reqber                                          (gen3_coeff_15_reqber                                          ),
      .gen3_coeff_15_ber_meas                                        (gen3_coeff_15_ber_meas                                        ),
      .gen3_coeff_16                                                 (gen3_coeff_16                                                 ),
      .gen3_coeff_16_sel                                             (gen3_coeff_16_sel                                             ),
      .gen3_coeff_16_preset_hint                                     (gen3_coeff_16_preset_hint                                     ),
      .gen3_coeff_16_nxtber_more                                     (gen3_coeff_16_nxtber_more                                     ),
      .gen3_coeff_16_nxtber_less                                     (gen3_coeff_16_nxtber_less                                     ),
      .gen3_coeff_16_reqber                                          (gen3_coeff_16_reqber                                          ),
      .gen3_coeff_16_ber_meas                                        (gen3_coeff_16_ber_meas                                        ),
      .gen3_coeff_17                                                 (gen3_coeff_17                                                 ),
      .gen3_coeff_17_sel                                             (gen3_coeff_17_sel                                             ),
      .gen3_coeff_17_preset_hint                                     (gen3_coeff_17_preset_hint                                     ),
      .gen3_coeff_17_nxtber_more                                     (gen3_coeff_17_nxtber_more                                     ),
      .gen3_coeff_17_nxtber_less                                     (gen3_coeff_17_nxtber_less                                     ),
      .gen3_coeff_17_reqber                                          (gen3_coeff_17_reqber                                          ),
      .gen3_coeff_17_ber_meas                                        (gen3_coeff_17_ber_meas                                        ),
      .gen3_coeff_18                                                 (gen3_coeff_18                                                 ),
      .gen3_coeff_18_sel                                             (gen3_coeff_18_sel                                             ),
      .gen3_coeff_18_preset_hint                                     (gen3_coeff_18_preset_hint                                     ),
      .gen3_coeff_18_nxtber_more                                     (gen3_coeff_18_nxtber_more                                     ),
      .gen3_coeff_18_nxtber_less                                     (gen3_coeff_18_nxtber_less                                     ),
      .gen3_coeff_18_reqber                                          (gen3_coeff_18_reqber                                          ),
      .gen3_coeff_18_ber_meas                                        (gen3_coeff_18_ber_meas                                        ),
      .gen3_coeff_19                                                 (gen3_coeff_19                                                 ),
      .gen3_coeff_19_sel                                             (gen3_coeff_19_sel                                             ),
      .gen3_coeff_19_preset_hint                                     (gen3_coeff_19_preset_hint                                     ),
      .gen3_coeff_19_nxtber_more                                     (gen3_coeff_19_nxtber_more                                     ),
      .gen3_coeff_19_nxtber_less                                     (gen3_coeff_19_nxtber_less                                     ),
      .gen3_coeff_19_reqber                                          (gen3_coeff_19_reqber                                          ),
      .gen3_coeff_19_ber_meas                                        (gen3_coeff_19_ber_meas                                        ),
      .gen3_coeff_20                                                 (gen3_coeff_20                                                 ),
      .gen3_coeff_20_sel                                             (gen3_coeff_20_sel                                             ),
      .gen3_coeff_20_preset_hint                                     (gen3_coeff_20_preset_hint                                     ),
      .gen3_coeff_20_nxtber_more                                     (gen3_coeff_20_nxtber_more                                     ),
      .gen3_coeff_20_nxtber_less                                     (gen3_coeff_20_nxtber_less                                     ),
      .gen3_coeff_20_reqber                                          (gen3_coeff_20_reqber                                          ),
      .gen3_coeff_20_ber_meas                                        (gen3_coeff_20_ber_meas                                        ),
      .gen3_coeff_21                                                 (gen3_coeff_21                                                 ),
      .gen3_coeff_21_sel                                             (gen3_coeff_21_sel                                             ),
      .gen3_coeff_21_preset_hint                                     (gen3_coeff_21_preset_hint                                     ),
      .gen3_coeff_21_nxtber_more                                     (gen3_coeff_21_nxtber_more                                     ),
      .gen3_coeff_21_nxtber_less                                     (gen3_coeff_21_nxtber_less                                     ),
      .gen3_coeff_21_reqber                                          (gen3_coeff_21_reqber                                          ),
      .gen3_coeff_21_ber_meas                                        (gen3_coeff_21_ber_meas                                        ),
      .gen3_coeff_22                                                 (gen3_coeff_22                                                 ),
      .gen3_coeff_22_sel                                             (gen3_coeff_22_sel                                             ),
      .gen3_coeff_22_preset_hint                                     (gen3_coeff_22_preset_hint                                     ),
      .gen3_coeff_22_nxtber_more                                     (gen3_coeff_22_nxtber_more                                     ),
      .gen3_coeff_22_nxtber_less                                     (gen3_coeff_22_nxtber_less                                     ),
      .gen3_coeff_22_reqber                                          (gen3_coeff_22_reqber                                          ),
      .gen3_coeff_22_ber_meas                                        (gen3_coeff_22_ber_meas                                        ),
      .gen3_coeff_23                                                 (gen3_coeff_23                                                 ),
      .gen3_coeff_23_sel                                             (gen3_coeff_23_sel                                             ),
      .gen3_coeff_23_preset_hint                                     (gen3_coeff_23_preset_hint                                     ),
      .gen3_coeff_23_nxtber_more                                     (gen3_coeff_23_nxtber_more                                     ),
      .gen3_coeff_23_nxtber_less                                     (gen3_coeff_23_nxtber_less                                     ),
      .gen3_coeff_23_reqber                                          (gen3_coeff_23_reqber                                          ),
      .gen3_coeff_23_ber_meas                                        (gen3_coeff_23_ber_meas                                        ),
      .gen3_coeff_24                                                 (gen3_coeff_24                                                 ),
      .gen3_coeff_24_sel                                             (gen3_coeff_24_sel                                             ),
      .gen3_coeff_24_preset_hint                                     (gen3_coeff_24_preset_hint                                     ),
      .gen3_coeff_24_nxtber_more                                     (gen3_coeff_24_nxtber_more                                     ),
      .gen3_coeff_24_nxtber_less                                     (gen3_coeff_24_nxtber_less                                     ),
      .gen3_coeff_24_reqber                                          (gen3_coeff_24_reqber                                          ),
      .gen3_coeff_24_ber_meas                                        (gen3_coeff_24_ber_meas                                        ),
      .gen3_coeff_delay_count                                        (gen3_coeff_delay_count                                        ),
      .gen3_coeff_errchk                                             (gen3_coeff_errchk                                             ),
      .gen3_dcbal_en                                                 (gen3_dcbal_en                                                 ),
      .gen3_diffclock_nfts_count                                     (gen3_diffclock_nfts_count                                     ),
      .gen3_force_local_coeff                                        (gen3_force_local_coeff                                        ),
      .gen3_full_swing                                               (gen3_full_swing                                               ),
      .gen3_half_swing                                               (gen3_half_swing                                               ),
      .gen3_low_freq                                                 (gen3_low_freq                                                 ),
      .gen3_paritychk                                                (gen3_paritychk                                                ),
      .gen3_pl_framing_err_dis                                       (gen3_pl_framing_err_dis                                       ),
      .gen3_preset_coeff_1                                           (gen3_preset_coeff_1                                           ),
      .gen3_preset_coeff_2                                           (gen3_preset_coeff_2                                           ),
      .gen3_preset_coeff_3                                           (gen3_preset_coeff_3                                           ),
      .gen3_preset_coeff_4                                           (gen3_preset_coeff_4                                           ),
      .gen3_preset_coeff_5                                           (gen3_preset_coeff_5                                           ),
      .gen3_preset_coeff_6                                           (gen3_preset_coeff_6                                           ),
      .gen3_preset_coeff_7                                           (gen3_preset_coeff_7                                           ),
      .gen3_preset_coeff_8                                           (gen3_preset_coeff_8                                           ),
      .gen3_preset_coeff_9                                           (gen3_preset_coeff_9                                           ),
      .gen3_preset_coeff_10                                          (gen3_preset_coeff_10                                          ),
      .gen3_preset_coeff_11                                          (gen3_preset_coeff_11                                          ),
      .gen3_reset_eieos_cnt_bit                                      (gen3_reset_eieos_cnt_bit                                      ),
      .gen3_rxfreqlock_counter                                       (gen3_rxfreqlock_counter                                       ),
      .gen3_sameclock_nfts_count                                     (gen3_sameclock_nfts_count                                     ),
      .gen3_scrdscr_bypass                                           (gen3_scrdscr_bypass                                           ),
      .gen3_skip_ph2_ph3                                             (gen3_skip_ph2_ph3                                             ),
      .hard_reset_bypass                                             (hard_reset_bypass                                             ),
      .hard_rst_sig_chnl_en                                          (hard_rst_sig_chnl_en                                          ),
      .hard_rst_tx_pll_rst_chnl_en                                   (hard_rst_tx_pll_rst_chnl_en                                   ),
      .hip_base_address                                              (hip_base_address                                              ),
      .hip_clock_dis                                                 (hip_clock_dis                                                 ),
      .hip_hard_reset                                                (hip_hard_reset                                                ),
      .hip_pcs_sig_chnl_en                                           (hip_pcs_sig_chnl_en                                           ),
      .hot_plug_support                                              (hot_plug_support                                              ),
      .hrc_chnl_txpll_master_cgb_rst_select                          (hrc_chnl_txpll_master_cgb_rst_select                          ),
      .iei_enable_settings                                           (iei_enable_settings                                           ),
      .indicator                                                     (indicator                                                     ),
      .intel_id_access                                               (intel_id_access                                               ),
      .interrupt_pin                                                 (interrupt_pin                                                 ),
      .io_window_addr_width                                          (io_window_addr_width                                          ),
      .jtag_id                                                       (jtag_id                                                       ),
      .l0_exit_latency_diffclock                                     (l0_exit_latency_diffclock                                     ),
      .l0_exit_latency_sameclock                                     (l0_exit_latency_sameclock                                     ),
      .l01_entry_latency                                             (l01_entry_latency                                             ),
      .l0s_adj_rply_timer_dis                                        (l0s_adj_rply_timer_dis                                        ),
      .l1_exit_latency_diffclock                                     (l1_exit_latency_diffclock                                     ),
      .l1_exit_latency_sameclock                                     (l1_exit_latency_sameclock                                     ),
      .l2_async_logic                                                (l2_async_logic                                                ),
      .lane_mask                                                     (lane_mask                                                     ),
      .low_priority_vc                                               (low_priority_vc                                               ),
      .ltr_mechanism                                                 (ltr_mechanism                                                 ),
      .ltssm_1ms_timeout                                             (ltssm_1ms_timeout                                             ),
      .ltssm_freqlocked_check                                        (ltssm_freqlocked_check                                        ),
      .malformed_tlp_truncate_en                                     (malformed_tlp_truncate_en                                     ),
      .max_link_width                                                (max_link_width                                                ),
      .max_payload_size                                              (max_payload_size                                              ),
      .maximum_current                                               (maximum_current                                               ),
      .millisecond_cycle_count                                       ((ALTPCIE_HIP_256_PIPEN1B_SIM_ONLY==1)?millisecond_cycle_count_sim_only:millisecond_cycle_count),
      .msi_64bit_addressing_capable                                  (msi_64bit_addressing_capable                                  ),
      .msi_masking_capable                                           (msi_masking_capable                                           ),
      .msi_multi_message_capable                                     (msi_multi_message_capable                                     ),
      .msi_support                                                   (msi_support                                                   ),
      .msix_pba_bir                                                  (msix_pba_bir                                                  ),
      .msix_pba_offset                                               (msix_pba_offset                                               ),
      .msix_table_bir                                                (msix_table_bir                                                ),
      .msix_table_offset                                             (msix_table_offset                                             ),
      .msix_table_size                                               (msix_table_size                                               ),
      .national_inst_thru_enhance                                    (national_inst_thru_enhance                                    ),
      .no_command_completed                                          (no_command_completed                                          ),
      .no_soft_reset                                                 (no_soft_reset                                                 ),
      .pcie_mode                                                     (pcie_mode                                                     ),
      .pcie_spec_1p0_compliance                                      (pcie_spec_1p0_compliance                                      ),
      .pcie_spec_version                                             (pcie_spec_version                                             ),
      .pclk_out_sel                                                  (pclk_out_sel                                                  ),
      .pld_in_use_reg                                                (pld_in_use_reg                                                ),
      .pm_latency_patch_dis                                          (pm_latency_patch_dis                                          ),
      .pm_txdl_patch_dis                                             (pm_txdl_patch_dis                                             ),
      .pme_clock                                                     (pme_clock                                                     ),
      .port_link_number                                              (port_link_number                                              ),
      .powerdown_mode                                                (powerdown_mode                                                ),
      .prefetchable_mem_window_addr_width                            (prefetchable_mem_window_addr_width                            ),
      .r2c_mask_easy                                                 (r2c_mask_easy                                                 ),
      .r2c_mask_enable                                               (r2c_mask_enable                                               ),
      .rec_frqlk_mon_en                                              (rec_frqlk_mon_en                                              ),
      .register_pipe_signals                                         (register_pipe_signals                                         ),
      .retry_buffer_last_active_address                              (retry_buffer_last_active_address                              ),
      .retry_buffer_memory_settings                                  (retry_buffer_memory_settings                                  ),
      .retry_ecc_corr_mask_dis                                       (retry_ecc_corr_mask_dis                                       ),
      .revision_id                                                   (revision_id                                                   ),
      .role_based_error_reporting                                    (role_based_error_reporting                                    ),
      .rp_bug_fix_pri_sec_stat_reg                                   (rp_bug_fix_pri_sec_stat_reg                                   ),
      .rpltim_base                                                   (rpltim_base                                                   ),
      .rpltim_set                                                    (rpltim_set                                                    ),
      .rstctl_ltssm_dis                                              ((ALTPCIE_HIP_256_PIPEN1B_SIM_ONLY==1)?rstctl_ltssm_dis_sim_only:rstctl_ltssm_dis),
      .rstctrl_1ms_count_fref_clk                                    (rstctrl_1ms_count_fref_clk                                    ),
      .rstctrl_1us_count_fref_clk                                    (rstctrl_1us_count_fref_clk                                    ),
      .rstctrl_pld_clr                                               (rstctrl_pld_clr                                               ),
      .rstctrl_pll_cal_done_select                                   (rstctrl_pll_cal_done_select                                   ),
      .rstctrl_debug_en                                              (rstctrl_debug_en                                              ),
      .rstctrl_force_inactive_rst                                    (rstctrl_force_inactive_rst                                    ),
      .rstctrl_perst_enable                                          (rstctrl_perst_enable                                          ),
      .rstctrl_hip_ep                                                (rstctrl_hip_ep                                                ),
      .rstctrl_hard_block_enable                                     (rstctrl_hard_block_enable                                     ),
      .rstctrl_rx_pma_rstb_inv                                       (rstctrl_rx_pma_rstb_inv                                       ),
      .rstctrl_tx_pma_rstb_inv                                       (rstctrl_tx_pma_rstb_inv                                       ),
      .rstctrl_rx_pcs_rst_n_inv                                      (rstctrl_rx_pcs_rst_n_inv                                      ),
      .rstctrl_tx_pcs_rst_n_inv                                      (rstctrl_tx_pcs_rst_n_inv                                      ),
      .rstctrl_altpe3_crst_n_inv                                     (rstctrl_altpe3_crst_n_inv                                     ),
      .rstctrl_altpe3_srst_n_inv                                     (rstctrl_altpe3_srst_n_inv                                     ),
      .rstctrl_altpe3_rst_n_inv                                      (rstctrl_altpe3_rst_n_inv                                      ),
      .rstctrl_chnl_cal_done_select                                  (rstctrl_chnl_cal_done_select                                  ),
      .rstctrl_tx_pma_syncp_inv                                      (rstctrl_tx_pma_syncp_inv                                      ),
      .rstctrl_rx_pma_rstb_select                                    (rstctrl_rx_pma_rstb_select                                    ),
      .rstctrl_rx_pll_freq_lock_select                               (rstctrl_rx_pll_freq_lock_select                               ),
      .rstctrl_mask_tx_pll_lock_select                               (rstctrl_mask_tx_pll_lock_select                               ),
      .rstctrl_rx_pll_lock_select                                    (rstctrl_rx_pll_lock_select                                    ),
      .rstctrl_perstn_select                                         (rstctrl_perstn_select                                         ),
      .rstctrl_fref_clk_select                                       (rstctrl_fref_clk_select                                       ),
      .rstctrl_tx_pma_syncp_select                                   (rstctrl_tx_pma_syncp_select                                   ),
      .rstctrl_rx_pcs_rst_n_select                                   (rstctrl_rx_pcs_rst_n_select                                   ),
      .rstctrl_tx_pcs_rst_n_select                                   (rstctrl_tx_pcs_rst_n_select                                   ),
      .rstctrl_timer_a_type                                          (rstctrl_timer_a_type                                          ),
      .rstctrl_timer_a                                               (rstctrl_timer_a                                               ),
      .rstctrl_timer_b_type                                          (rstctrl_timer_b_type                                          ),
      .rstctrl_timer_b                                               (rstctrl_timer_b                                               ),
      .rstctrl_timer_c_type                                          (rstctrl_timer_c_type                                          ),
      .rstctrl_timer_c                                               (rstctrl_timer_c                                               ),
      .rstctrl_timer_d_type                                          (rstctrl_timer_d_type                                          ),
      .rstctrl_timer_d                                               (rstctrl_timer_d                                               ),
      .rstctrl_timer_e_type                                          (rstctrl_timer_e_type                                          ),
      .rstctrl_timer_e                                               (rstctrl_timer_e                                               ),
      .rstctrl_timer_f_type                                          (rstctrl_timer_f_type                                          ),
      .rstctrl_timer_f                                               (rstctrl_timer_f                                               ),
      .rstctrl_timer_g_type                                          (rstctrl_timer_g_type                                          ),
      .rstctrl_timer_g                                               (rstctrl_timer_g                                               ),
      .rstctrl_timer_h_type                                          (rstctrl_timer_h_type                                          ),
      .rstctrl_timer_h                                               (rstctrl_timer_h                                               ),
      .rstctrl_timer_i_type                                          (rstctrl_timer_i_type                                          ),
      .rstctrl_timer_i                                               (rstctrl_timer_i                                               ),
      .rstctrl_timer_j_type                                          (rstctrl_timer_j_type                                          ),
      .rstctrl_timer_j                                               (rstctrl_timer_j                                               ),
      .rstctrl_tx_lcff_pll_lock_select                               (rstctrl_tx_lcff_pll_lock_select                               ),
      .rstctrl_tx_lcff_pll_rstb_select                               (rstctrl_tx_lcff_pll_rstb_select                               ),
      .rx_ast_parity                                                 (rx_ast_parity                                                 ),
      .tx_ast_parity                                                 (tx_ast_parity                                                 ),
      .rx_buffer_fc_protect                                          (rx_buffer_fc_protect                                          ),
      .rx_buffer_protect                                             (rx_buffer_protect                                             ),
      .rx_cdc_almost_empty                                           (rx_cdc_almost_empty                                           ),
      .rx_cdc_almost_full                                            (rx_cdc_almost_full                                            ),
      .rx_cred_ctl_param                                             (rx_cred_ctl_param                                             ),
      .rx_ei_l0s                                                     (rx_ei_l0s                                                     ),
      .rx_l0s_count_idl                                              (rx_l0s_count_idl                                              ),
      .rx_ptr0_posted_dpram_min                                      (rx_ptr0_posted_dpram_min                                      ),
      .rx_ptr0_posted_dpram_max                                      (rx_ptr0_posted_dpram_max                                      ),
      .rx_ptr0_nonposted_dpram_min                                   (rx_ptr0_nonposted_dpram_min                                   ),
      .rx_ptr0_nonposted_dpram_max                                   (rx_ptr0_nonposted_dpram_max                                   ),
      .rx_runt_patch_dis                                             (rx_runt_patch_dis                                             ),
      .rx_sop_ctrl                                                   (rx_sop_ctrl                                                   ),
      .rx_trunc_patch_dis                                            (rx_trunc_patch_dis                                            ),
      .rx_use_prst                                                   (rx_use_prst                                                   ),
      .rx_use_prst_ep                                                (rx_use_prst_ep                                                ),
      .rxbuf_ecc_corr_mask_dis                                       (rxbuf_ecc_corr_mask_dis                                       ),
      .sameclock_nfts_count                                          (sameclock_nfts_count                                          ),
      .sel_enable_pcs_rx_fifo_err                                    (sel_enable_pcs_rx_fifo_err                                    ),
      .simple_ro_fifo_control_en                                     (simple_ro_fifo_control_en                                     ),
      .single_rx_detect                                              (single_rx_detect                                              ),
      .skp_os_gen3_count                                             (skp_os_gen3_count                                             ),
      .skp_os_schedule_count                                         (skp_os_schedule_count                                         ),
      .slot_number                                                   (slot_number                                                   ),
      .slot_power_limit                                              (slot_power_limit                                              ),
      .slot_power_scale                                              (slot_power_scale                                              ),
      .slotclk_cfg                                                   (slotclk_cfg                                                   ),
      .ssvid                                                         (ssvid                                                         ),
      .ssid                                                          (ssid                                                          ),
      .subsystem_vendor_id                                           (subsystem_vendor_id                                           ),
      .subsystem_device_id                                           (subsystem_device_id                                           ),
      .surprise_down_error_support                                   (surprise_down_error_support                                   ),
      .tl_cfg_div                                                    (tl_cfg_div                                                    ),
      .tl_tx_check_parity_msg                                        (tl_tx_check_parity_msg                                        ),
      .tph_completer                                                 (tph_completer                                                 ),
      .tx_cdc_almost_empty                                           (tx_cdc_almost_empty                                           ),
      .tx_cdc_almost_full                                            (tx_cdc_almost_full                                            ),
      .tx_sop_ctrl                                                   (tx_sop_ctrl                                                   ),
      .tx_swing                                                      (tx_swing                                                      ),
      .txdl_fair_arbiter_counter                                     (txdl_fair_arbiter_counter                                     ),
      .txdl_fair_arbiter_en                                          (txdl_fair_arbiter_en                                          ),
      .txrate_adv                                                    (txrate_adv                                                    ),
      .use_aer                                                       (use_aer                                                       ),
      .use_crc_forwarding                                            (use_crc_forwarding                                            ),
      .user_id                                                       (user_id                                                       ),
      .vc_arbitration                                                (vc_arbitration                                                ),
      .vc_enable                                                     (vc_enable                                                     ),
      .vc0_clk_enable                                                (vc0_clk_enable                                                ),
      .vc0_rx_buffer_memory_settings                                 (vc0_rx_buffer_memory_settings                                 ),
      .vc0_rx_flow_ctrl_posted_header                                (vc0_rx_flow_ctrl_posted_header                                ),
      .vc0_rx_flow_ctrl_posted_data                                  (vc0_rx_flow_ctrl_posted_data                                  ),
      .vc0_rx_flow_ctrl_nonposted_header                             (vc0_rx_flow_ctrl_nonposted_header                             ),
      .vc0_rx_flow_ctrl_nonposted_data                               (vc0_rx_flow_ctrl_nonposted_data                               ),
      .vc0_rx_flow_ctrl_compl_header                                 (vc0_rx_flow_ctrl_compl_header                                 ),
      .vc0_rx_flow_ctrl_compl_data                                   (vc0_rx_flow_ctrl_compl_data                                   ),
      .ko_compl_data                                                 (ko_compl_data                                                 ),
      .ko_compl_header                                               (ko_compl_header                                               ),
      .vc1_clk_enable                                                (vc1_clk_enable                                                ),
      .vendor_id                                                     (vendor_id                                                     ),
      .vsec_cap                                                      (vsec_cap                                                      ),
      .vsec_id                                                       (vsec_id                                                       ),
      .wrong_device_id                                               (wrong_device_id                                               ),
      .not_use_k_gbl_bits                                            (not_use_k_gbl_bits                                            ),
      .avmm_force_inter_sel_csr_ctrl                                 (avmm_force_inter_sel_csr_ctrl                                 ),
      .operating_voltage                                             (operating_voltage                                             ),
      .rxdl_bad_tlp_patch_dis                                        (rxdl_bad_tlp_patch_dis                                        ),
      .avmm_dprio_broadcast_en_csr_ctrl                              (avmm_dprio_broadcast_en_csr_ctrl                              ),
      .hip_ac_pwr_uw_per_mhz                                         (hip_ac_pwr_uw_per_mhz                                         ),
      .hip_ac_pwr_clk_freq_in_hz                                     (hip_ac_pwr_clk_freq_in_hz                                     ),
      .rxdl_bad_sop_eop_filter_dis                                   (rxdl_bad_sop_eop_filter_dis                                   ),
      .rxdl_lcrc_patch_dis                                           (rxdl_lcrc_patch_dis                                           ),
      .capab_rate_rxcfg_en                                           (capab_rate_rxcfg_en                                           ),
      .avmm_cvp_inter_sel_csr_ctrl                                   (avmm_cvp_inter_sel_csr_ctrl                                   ),
      .lmi_hold_off_cfg_timer_en                                     (lmi_hold_off_cfg_timer_en                                     ),
      .avmm_power_iso_en_csr_ctrl                                    (avmm_power_iso_en_csr_ctrl                                    ),
      .eco_fb332688_dis                                              (eco_fb332688_dis                                              )
      ) wys  (
               .aer_msi_num                  (aer_msi_num                          ),
               .app_inta_sts                 (app_int_sts                          ),
               .app_msi_num                  (app_msi_num                          ),
               .app_msi_req                  (app_msi_req                          ),
               .app_msi_tc                   (app_msi_tc                           ),
               .bisten_rcv_n                 ((MEM_CHECK==0)?1'b1:bistenrcv ),
               .bisten_rpl_n                 ((MEM_CHECK==0)?1'b1:bistenrpl ),
               .bist_scanen                  ((MEM_CHECK==0)?1'b0:bistscanen),
               .bist_scanin                  ((MEM_CHECK==0)?1'b0:bistscanin),
               .bistmode_n                   ((MEM_CHECK==0)?1'b1:bisttesten),
               .cfg_link2csr_pld             (cfglink2csrpld                       ),
               .cfg_prmbus_pld               (gnd_cfg_prmbus_pld                   ),
               .core_clk_in                  (pld_clk                              ),
               .flr_reset                    (flr_reset                            ),
               .flr_sts                      (flr_sts                              ),
               .pld_clrpmapcship_n           (pin_perst                            ),
               .pld_clrpcship_n              (1'b1                                 ),
               .pld_clrhip_n                 ((USE_HARD_RESET==0)?1'b1:~hiprst     ),
               .core_crst                    ((USE_HARD_RESET==0)?crst:1'b0        ),
               .core_por                     ((USE_HARD_RESET==0)?~npor_int:1'b0   ),
               .core_rst                     ((USE_HARD_RESET==0)?~npor_int:1'b0   ),
               .core_srst                    ((USE_HARD_RESET==0)?srst:1'b0        ),
               .pin_perst_n                  (pin_perst                            ),
               .pld_perst_n                  (1'b1                                 ),
               .cpl_err                      (cpl_err                              ),//
               .cpl_pending                  (cpl_pending                          ),//
               .cseb_rddata                  (((TLP_INSPECTOR==1)&&(cseb_config_bypass=="disable"))?tlp_inspect_i_csebrddata          :csebrddata      ),
               .cseb_rddata_parity           (                                                                                         csebrddataparity),
               .cseb_rdresponse              (((TLP_INSPECTOR==1)&&(cseb_config_bypass=="disable"))?tlp_inspect_i_csebrdresponse      :csebrdresponse  ),
               .cseb_waitrequest             (((TLP_INSPECTOR==1)&&(cseb_config_bypass=="disable"))?tlp_inspect_i_csebwaitrequest     :csebwaitrequest ),
               .cseb_wrresponse              (((TLP_INSPECTOR==1)&&(cseb_config_bypass=="disable"))?tlp_inspect_i_csebwrresponse      :csebwrresponse  ),
               .cseb_wrresp_valid            (((TLP_INSPECTOR==1)&&(cseb_config_bypass=="disable"))?tlp_inspect_i_csebwrrespvalid     :csebwrrespvalid ),
               .hpg_ctrler                   (hpg_ctrler                            ),
               .lmi_addr                     ((PCISIG_PCIECV_TD_1_41_TLS_0_WORKAROUND==1)?lmi_wpciecv_addr  :lmi_addr                              ),//
               .lmi_din                      ((PCISIG_PCIECV_TD_1_41_TLS_0_WORKAROUND==1)?lmi_wpciecv_din   :lmi_din                               ),//
               .lmi_rden                     ((PCISIG_PCIECV_TD_1_41_TLS_0_WORKAROUND==1)?lmi_wpciecv_rden  :lmi_rden                              ),//
               .lmi_wren                     ((PCISIG_PCIECV_TD_1_41_TLS_0_WORKAROUND==1)?lmi_wpciecv_wren  :lmi_wren                              ),//
               .mem_hip_test_enable          ((MEM_CHECK==0)?1'b0:memhiptestenable           ),
               .mem_regscanen_n              ((MEM_CHECK==0)?1'b1:memregscanen               ),
               .m10k_select                  ((MEM_CHECK==0)?3'h0:m10k_select                ),
               .pclk_central                 ((pipe32_sim_only==1'b1)? pclk_in: mserdes_pipe_pclkcentral), //
               .pclk_ch0                     ((pipe32_sim_only==1'b1)? pclk_in: mserdes_pipe_pclk       ),
               .pclk_ch1                     ((pipe32_sim_only==1'b1)? pclk_in: mserdes_pipe_pclkch1    ),//
               .pex_msi_num                  (pex_msi_num                  ),
               .phy_rst                      ((USE_HARD_RESET==0)?~npor_int:1'b0),
               .phy_srst                     ((USE_HARD_RESET==0)?srst:1'b0    ), //
               .phystatus0                   (phystatus0                 ),
               .phystatus1                   (phystatus1                 ),
               .phystatus2                   (phystatus2                 ),
               .phystatus3                   (phystatus3                 ),
               .phystatus4                   (phystatus4                 ),
               .phystatus5                   (phystatus5                 ),
               .phystatus6                   (phystatus6                 ),
               .phystatus7                   (phystatus7                 ),
               .pld_clk                      (pld_clk      ),  //
               // pipe32_sim_only = 32-bit pipe mode
               // Fixed clocks are 500Mhz for Gen1/Gen2/Gen3 Capable cores
               .pll_fixed_clk_central        ((pipe32_sim_only==1'b1)? clk500_out: mserdes_pllfixedclkcentral),  //
               .pll_fixed_clk_ch0            ((pipe32_sim_only==1'b1)? clk500_out: mserdes_pllfixedclkch0    ),  //
               .pll_fixed_clk_ch1            ((pipe32_sim_only==1'b1)? clk500_out: mserdes_pllfixedclkch1    ),  //
               .pm_auxpwr                    (pm_auxpwr                  ),
               .pm_data                      (pm_data                    ),
               .pme_to_cr                    ((PCISIG_PTC_PM_WORKAROUND==1)?pme_to_sr:pme_to_cr                  ),
               .pm_event                     (pm_event                   ),
               .pm_exit_d0_ack               (pm_exit_d0_req_r           ),
               .pm_exit_d0_req               (pm_exit_d0_req             ),
               .egress_blk_err               (gnd_egress_blk_err         ),
               .test_pl_dbg_eqin             (gnd_test_pl_dbg_eqin       ),
               .rx_cred_ctl                  (rx_cred_ctl            ),
               .rx_cred_status               (rx_cred_status         ),
               .pld_gp_status                (gnd_pld_gp_status          ),
               .app_int_err                  (gnd_app_int_err            ),
               .rxblkst0                     (rxblkst0                   ),//
               .rxblkst1                     (rxblkst1                   ),//
               .rxblkst2                     (rxblkst2                   ),//
               .rxblkst3                     (rxblkst3                   ),//
               .rxblkst4                     (rxblkst4                   ),//
               .rxblkst5                     (rxblkst5                   ),//
               .rxblkst6                     (rxblkst6                   ),//
               .rxblkst7                     (rxblkst7                   ),//
               .rxdata0                      (rxdata0                    ),
               .rxdata1                      (rxdata1                    ),
               .rxdata2                      (rxdata2                    ),
               .rxdata3                      (rxdata3                    ),
               .rxdata4                      (rxdata4                    ),
               .rxdata5                      (rxdata5                    ),
               .rxdata6                      (rxdata6                    ),
               .rxdata7                      (rxdata7                    ),
               .rxdatak0                     (rxdatak0                   ),
               .rxdatak1                     (rxdatak1                   ),
               .rxdatak2                     (rxdatak2                   ),
               .rxdatak3                     (rxdatak3                   ),
               .rxdatak4                     (rxdatak4                   ),
               .rxdatak5                     (rxdatak5                   ),
               .rxdatak6                     (rxdatak6                   ),
               .rxdatak7                     (rxdatak7                   ),
               .rxdataskip0                  (rxdataskip0                ),
               .rxdataskip1                  (rxdataskip1                ),
               .rxdataskip2                  (rxdataskip2                ),
               .rxdataskip3                  (rxdataskip3                ),
               .rxdataskip4                  (rxdataskip4                ),
               .rxdataskip5                  (rxdataskip5                ),
               .rxdataskip6                  (rxdataskip6                ),
               .rxdataskip7                  (rxdataskip7                ),
               .rxelecidle0                  (rxelecidle0                ),
               .rxelecidle1                  (rxelecidle1                ),
               .rxelecidle2                  (rxelecidle2                ),
               .rxelecidle3                  (rxelecidle3                ),
               .rxelecidle4                  (rxelecidle4                ),
               .rxelecidle5                  (rxelecidle5                ),
               .rxelecidle6                  (rxelecidle6                ),
               .rxelecidle7                  (rxelecidle7                ),
               .rxfreqlocked0                (rxfreqlocked0              ),
               .rxfreqlocked1                (rxfreqlocked1              ),
               .rxfreqlocked2                (rxfreqlocked2              ),
               .rxfreqlocked3                (rxfreqlocked3              ),
               .rxfreqlocked4                (rxfreqlocked4              ),
               .rxfreqlocked5                (rxfreqlocked5              ),
               .rxfreqlocked6                (rxfreqlocked6              ),
               .rxfreqlocked7                (rxfreqlocked7              ),
               .rxstatus0                    (rxstatus0                  ),
               .rxstatus1                    (rxstatus1                  ),
               .rxstatus2                    (rxstatus2                  ),
               .rxstatus3                    (rxstatus3                  ),
               .rxstatus4                    (rxstatus4                  ),
               .rxstatus5                    (rxstatus5                  ),
               .rxstatus6                    (rxstatus6                  ),
               .rxstatus7                    (rxstatus7                  ),
               .rx_st_mask                   (rxstmask                   ),
               .rx_st_ready                  (rxstready                  ),
               .rxsynchd0                    (rxsynchd0                  ),
               .rxsynchd1                    (rxsynchd1                  ),
               .rxsynchd2                    (rxsynchd2                  ),
               .rxsynchd3                    (rxsynchd3                  ),
               .rxsynchd4                    (rxsynchd4                  ),
               .rxsynchd5                    (rxsynchd5                  ),
               .rxsynchd6                    (rxsynchd6                  ),
               .rxsynchd7                    (rxsynchd7                  ),
               .rxvalid0                     (rxvalid0                   ),
               .rxvalid1                     (rxvalid1                   ),
               .rxvalid2                     (rxvalid2                   ),
               .rxvalid3                     (rxvalid3                   ),
               .rxvalid4                     (rxvalid4                   ),
               .rxvalid5                     (rxvalid5                   ),
               .rxvalid6                     (rxvalid6                   ),
               .rxvalid7                     (rxvalid7                   ),
               .scan_mode_n                  ((MEM_CHECK==0)?1'b1:scanmoden),
               .scan_shift_n                 ((MEM_CHECK==0)?1'b1:scanshiftn),
               .sw_ctmod                     (swctmod                    ),
               .swdn_in                      (3'b000                     ),
               .swup_in                      (7'b0000000                 ),
               .test_in_hip                  (test_in_int[31:0]          ),
               .test_in_1_hip                (dbg_test_in_1_hip),
               .tx_st_data                   (txstdata                   ),//
               .tx_st_empty                  (txstempty                  ),//
               .tx_st_eop                    (txsteop                    ),//
               .tx_st_err                    (txsterr                    ),//
               .tx_st_parity                 (txstparity                 ),//
               .tx_st_sop                    (txstsop                    ),//
               .tx_st_valid                  (txstvalid                  ),//
               .tx_st_ready                  (txstready                  ),
               .app_inta_ack                 (app_int_ack                ),
               .app_msi_ack                  (app_msi_ack                ),
               .cfg_par_err                  (cfg_par_err                ),
               .core_clk_out                 (coreclkout                 ),
               .cseb_addr                    (csebaddr                   ),
               .cseb_addr_parity             (csebaddrparity             ),
               .cseb_be                      (csebbe                     ),
               .cseb_is_shadow               (csebisshadow               ),
               .cseb_rden                    (csebrden                   ),
               .cseb_wrdata                  (csebwrdata                 ),
               .cseb_wrdata_parity           (csebwrdataparity           ),
               .cseb_wren                    (csebwren                   ),
               .cseb_wrresp_req              (csebwrrespreq              ),
               .current_coeff0               (current_coeff0             ),
               .current_coeff1               (current_coeff1             ),
               .current_coeff2               (current_coeff2             ),
               .current_coeff3               (current_coeff3             ),
               .current_coeff4               (current_coeff4             ),
               .current_coeff5               (current_coeff5             ),
               .current_coeff6               (current_coeff6             ),
               .current_coeff7               (current_coeff7             ),
               .current_rxpreset0            (current_rxpreset0          ),
               .current_rxpreset1            (current_rxpreset1          ),
               .current_rxpreset2            (current_rxpreset2          ),
               .current_rxpreset3            (current_rxpreset3          ),
               .current_rxpreset4            (current_rxpreset4          ),
               .current_rxpreset5            (current_rxpreset5          ),
               .current_rxpreset6            (current_rxpreset6          ),
               .current_rxpreset7            (current_rxpreset7          ),
               .current_speed                (currentspeed               ),
               .rx_par_err                   (rx_par_err                 ),
               .tx_par_err                   (tx_par_err                 ),
               .rxfc_cplbuf_ovf              (rxfc_cplbuf_ovf            ),
               .dl_up                        (dlup                       ),
               .dlup_exit                    (dlup_exit                  ),
               .eidle_infer_sel0             (eidle_infer_sel0           ),
               .eidle_infer_sel1             (eidle_infer_sel1           ),
               .eidle_infer_sel2             (eidle_infer_sel2           ),
               .eidle_infer_sel3             (eidle_infer_sel3           ),
               .eidle_infer_sel4             (eidle_infer_sel4           ),
               .eidle_infer_sel5             (eidle_infer_sel5           ),
               .eidle_infer_sel6             (eidle_infer_sel6           ),
               .eidle_infer_sel7             (eidle_infer_sel7           ),
               .ev_128ns                     (ev128ns                    ),
               .ev_1us                       (ev1us                      ),
               .hotrst_exit                  (hotrst_exit                ),
               .int_status                   (int_status                 ),
               .l2_exit                      (l2_exit                    ),
               .lane_act                     (lane_act                   ),
               .lmi_ack                      (lmi_ack                    ),
               .lmi_dout                     (lmi_dout                   ),
               .ltssm_state                  (ltssmstate                 ),
               .pme_to_sr                    (pme_to_sr                  ),
               .powerdown0                   (powerdown0                 ),
               .powerdown1                   (powerdown1                 ),
               .powerdown2                   (powerdown2                 ),
               .powerdown3                   (powerdown3                 ),
               .powerdown4                   (powerdown4                 ),
               .powerdown5                   (powerdown5                 ),
               .powerdown6                   (powerdown6                 ),
               .powerdown7                   (powerdown7                 ),
               .rate0                        (rate0                      ),
               .rate1                        (rate1                      ),
               .rate2                        (rate2                      ),
               .rate3                        (rate3                      ),
               .rate4                        (rate4                      ),
               .rate5                        (rate5                      ),
               .rate6                        (rate6                      ),
               .rate7                        (rate7                      ),
               .rate_ctrl                    (ratectrl                   ),
               .reset_status                 (reset_status_hip           ),
               .rxpolarity0                  (rxpolarity0                ),
               .rxpolarity1                  (rxpolarity1                ),
               .rxpolarity2                  (rxpolarity2                ),
               .rxpolarity3                  (rxpolarity3                ),
               .rxpolarity4                  (rxpolarity4                ),
               .rxpolarity5                  (rxpolarity5                ),
               .rxpolarity6                  (rxpolarity6                ),
               .rxpolarity7                  (rxpolarity7                ),
               .rx_st_bardec1                (rxstbardec1                ),//
               .rx_st_bardec2                (rxstbardec2                ),//
               .rx_st_be                     (rxstbe                     ),//
               .rx_st_data                   (rxstdata                   ),//
               .rx_st_empty                  (rxstempty                  ),//
               .rx_st_eop                    (rxsteop                    ),//
               .rx_st_err                    (rxsterr                    ),//
               .rx_st_parity                 (rxstparity                 ),//
               .rx_st_sop                    (rxstsop                    ),//
               .rx_st_valid                  (rxstvalid                  ),//
               .serr_out                     (serr_out                   ),
               .swdn_out                     (unconnected_swdnout        ),
               .swup_out                     (unconnected_swupout        ),
               .test_out_hip                 (test_out[319:64]           ),
               .test_out_1_hip               (test_out[63:0]             ),
               .hold_ltssm_rec               (hold_ltssm_rec             ), // cyquek
               .force_tx_eidle               (1'b0),
               .pld_clk_in_use               (pld_clk_in_use_hip         ),
               .pld_core_ready               (pld_core_ready             ),
               .tl_cfg_add                   (tl_cfg_add                 ),
               .tl_cfg_ctl                   (tl_cfg_ctl                 ),
               .tl_cfg_sts                   (tl_cfg_sts                 ),
               .txblkst0                     (txblkst0                   ),
               .txblkst1                     (txblkst1                   ),
               .txblkst2                     (txblkst2                   ),
               .txblkst3                     (txblkst3                   ),
               .txblkst4                     (txblkst4                   ),
               .txblkst5                     (txblkst5                   ),
               .txblkst6                     (txblkst6                   ),
               .txblkst7                     (txblkst7                   ),
               .txdataskip0                  (txdataskip0                ),
               .txdataskip1                  (txdataskip1                ),
               .txdataskip2                  (txdataskip2                ),
               .txdataskip3                  (txdataskip3                ),
               .txdataskip4                  (txdataskip4                ),
               .txdataskip5                  (txdataskip5                ),
               .txdataskip6                  (txdataskip6                ),
               .txdataskip7                  (txdataskip7                ),
               .txcompl0                     (txcompl0                   ),
               .txcompl1                     (txcompl1                   ),
               .txcompl2                     (txcompl2                   ),
               .txcompl3                     (txcompl3                   ),
               .txcompl4                     (txcompl4                   ),
               .txcompl5                     (txcompl5                   ),
               .txcompl6                     (txcompl6                   ),
               .txcompl7                     (txcompl7                   ),
               .tx_cred_data_fc              (tx_cred_data_fc            ),
               .tx_cred_fc_hip_cons          (tx_cred_fc_hip_cons        ),
               .tx_cred_fc_infinite          (tx_cred_fc_infinite        ),
               .tx_cred_hdr_fc               (tx_cred_hdr_fc             ),
               .tx_cred_fc_sel               (tx_cred_fc_sel             ),
               .tx_cred_cons_select          (tx_cred_cons_select        ),
               .txdata0                      (txdata0                    ),
               .txdata1                      (txdata1                    ),
               .txdata2                      (txdata2                    ),
               .txdata3                      (txdata3                    ),
               .txdata4                      (txdata4                    ),
               .txdata5                      (txdata5                    ),
               .txdata6                      (txdata6                    ),
               .txdata7                      (txdata7                    ),
               .txdatak0                     (txdatak0                   ),
               .txdatak1                     (txdatak1                   ),
               .txdatak2                     (txdatak2                   ),
               .txdatak3                     (txdatak3                   ),
               .txdatak4                     (txdatak4                   ),
               .txdatak5                     (txdatak5                   ),
               .txdatak6                     (txdatak6                   ),
               .txdatak7                     (txdatak7                   ),
               .tx_deemph0                   (tx_deemph0                  ),
               .tx_deemph1                   (tx_deemph1                  ),
               .tx_deemph2                   (tx_deemph2                  ),
               .tx_deemph3                   (tx_deemph3                  ),
               .tx_deemph4                   (tx_deemph4                  ),
               .tx_deemph5                   (tx_deemph5                  ),
               .tx_deemph6                   (tx_deemph6                  ),
               .tx_deemph7                   (tx_deemph7                  ),
               .txswing0                     (txswing0                   ),
               .txswing1                     (txswing1                   ),
               .txswing2                     (txswing2                   ),
               .txswing3                     (txswing3                   ),
               .txswing4                     (txswing4                   ),
               .txswing5                     (txswing5                   ),
               .txswing6                     (txswing6                   ),
               .txswing7                     (txswing7                   ),
               .txdetectrx0                  (txdetectrx0                ),
               .txdetectrx1                  (txdetectrx1                ),
               .txdetectrx2                  (txdetectrx2                ),
               .txdetectrx3                  (txdetectrx3                ),
               .txdetectrx4                  (txdetectrx4                ),
               .txdetectrx5                  (txdetectrx5                ),
               .txdetectrx6                  (txdetectrx6                ),
               .txdetectrx7                  (txdetectrx7                ),
               .txelecidle0                  (txelecidle0                ),
               .txelecidle1                  (txelecidle1                ),
               .txelecidle2                  (txelecidle2                ),
               .txelecidle3                  (txelecidle3                ),
               .txelecidle4                  (txelecidle4                ),
               .txelecidle5                  (txelecidle5                ),
               .txelecidle6                  (txelecidle6                ),
               .txelecidle7                  (txelecidle7                ),
               .tx_margin0                   (tx_margin0                 ),
               .tx_margin1                   (tx_margin1                 ),
               .tx_margin2                   (tx_margin2                 ),
               .tx_margin3                   (tx_margin3                 ),
               .tx_margin4                   (tx_margin4                 ),
               .tx_margin5                   (tx_margin5                 ),
               .tx_margin6                   (tx_margin6                 ),
               .tx_margin7                   (tx_margin7                 ),
               .txsynchd0                    (txsynchd0                  ),
               .txsynchd1                    (txsynchd1                  ),
               .txsynchd2                    (txsynchd2                  ),
               .txsynchd3                    (txsynchd3                  ),
               .txsynchd4                    (txsynchd4                  ),
               .txsynchd5                    (txsynchd5                  ),
               .txsynchd6                    (txsynchd6                  ),
               .txsynchd7                    (txsynchd7                  ),
               .tx_pcs_rst_n0                (tx_pcs_rst_n[0]           ),
               .rx_pcs_rst_n0                (rx_pcs_rst_n[0]           ),
               .g3_tx_pcs_rst_n0             (g3_tx_pcs_rst_n[0]         ),
               .g3_rx_pcs_rst_n0             (g3_rx_pcs_rst_n[0]         ),
               .tx_pma_syncp0                (tx_pma_syncp[0]          ),
               .rx_pma_rstb0                 (rx_pma_rstb[0]           ),
               .tx_lcff_pll_rstb0            (tx_lcff_pll_rstb[0]    ),
               .fref_clk0                    (fref_clk[0]             ),
               .chnl_cal_done0               (chnl_cal_done0         ),
               .pll_cal_done0                (pll_cal_done0        ),
               .tx_lcff_pll_lock0            (tx_lcff_pll_lock0    ),
               .rx_pll_phase_lock0           (rx_pll_phase_lock[0]   ),
               .rx_pll_freq_lock0            (rx_pll_freq_lock[0]    ),
               .mask_tx_pll_lock0            (mask_tx_pll_lock[0]    ),
               .tx_pcs_rst_n1                (tx_pcs_rst_n[1]           ),
               .rx_pcs_rst_n1                (rx_pcs_rst_n[1]           ),
               .g3_tx_pcs_rst_n1             (g3_tx_pcs_rst_n[1]         ),
               .g3_rx_pcs_rst_n1             (g3_rx_pcs_rst_n[1]         ),
               .tx_pma_syncp1                (tx_pma_syncp[1]          ),
               .rx_pma_rstb1                 (rx_pma_rstb[1]           ),
               .tx_lcff_pll_rstb1            (tx_lcff_pll_rstb[1]    ),
               .fref_clk1                    (fref_clk[1]             ),
               .chnl_cal_done1               (chnl_cal_done1         ),
               .pll_cal_done1                (pll_cal_done1        ),
               .tx_lcff_pll_lock1            (tx_lcff_pll_lock1    ),
               .rx_pll_phase_lock1           (rx_pll_phase_lock[1]   ),
               .rx_pll_freq_lock1            (rx_pll_freq_lock[1]    ),
               .mask_tx_pll_lock1            (mask_tx_pll_lock[1]    ),
               .tx_pcs_rst_n2                (tx_pcs_rst_n[2]           ),
               .rx_pcs_rst_n2                (rx_pcs_rst_n[2]           ),
               .g3_tx_pcs_rst_n2             (g3_tx_pcs_rst_n[2]         ),
               .g3_rx_pcs_rst_n2             (g3_rx_pcs_rst_n[2]         ),
               .tx_pma_syncp2                (tx_pma_syncp[2]          ),
               .rx_pma_rstb2                 (rx_pma_rstb[2]           ),
               .tx_lcff_pll_rstb2            (tx_lcff_pll_rstb[2]    ),
               .fref_clk2                    (fref_clk[2]             ),
               .chnl_cal_done2               (chnl_cal_done2         ),
               .pll_cal_done2                (pll_cal_done2        ),
               .tx_lcff_pll_lock2            (tx_lcff_pll_lock2    ),
               .rx_pll_phase_lock2           (rx_pll_phase_lock[2]   ),
               .rx_pll_freq_lock2            (rx_pll_freq_lock[2]    ),
               .mask_tx_pll_lock2            (mask_tx_pll_lock[2]    ),
               .tx_pcs_rst_n3                (tx_pcs_rst_n[3]           ),
               .rx_pcs_rst_n3                (rx_pcs_rst_n[3]           ),
               .g3_tx_pcs_rst_n3             (g3_tx_pcs_rst_n[3]         ),
               .g3_rx_pcs_rst_n3             (g3_rx_pcs_rst_n[3]         ),
               .tx_pma_syncp3                (tx_pma_syncp[3]          ),
               .rx_pma_rstb3                 (rx_pma_rstb[3]           ),
               .tx_lcff_pll_rstb3            (tx_lcff_pll_rstb[3]    ),
               .fref_clk3                    (fref_clk[3]             ),
               .chnl_cal_done3               (chnl_cal_done3         ),
               .pll_cal_done3                (pll_cal_done3        ),
               .tx_lcff_pll_lock3            (tx_lcff_pll_lock3    ),
               .rx_pll_phase_lock3           (rx_pll_phase_lock[3]   ),
               .rx_pll_freq_lock3            (rx_pll_freq_lock[3]    ),
               .mask_tx_pll_lock3            (mask_tx_pll_lock[3]    ),
               .tx_pcs_rst_n4                (tx_pcs_rst_n[4]           ),
               .rx_pcs_rst_n4                (rx_pcs_rst_n[4]           ),
               .g3_tx_pcs_rst_n4             (g3_tx_pcs_rst_n[4]         ),
               .g3_rx_pcs_rst_n4             (g3_rx_pcs_rst_n[4]         ),
               .tx_pma_syncp4                (tx_pma_syncp[4]          ),
               .rx_pma_rstb4                 (rx_pma_rstb[4]           ),
               .tx_lcff_pll_rstb4            (tx_lcff_pll_rstb[4]    ),
               .fref_clk4                    (fref_clk[4]             ),
               .chnl_cal_done4               (chnl_cal_done4         ),
               .pll_cal_done4                (pll_cal_done4        ),
               .tx_lcff_pll_lock4            (tx_lcff_pll_lock4    ),
               .rx_pll_phase_lock4           (rx_pll_phase_lock[4]   ),
               .rx_pll_freq_lock4            (rx_pll_freq_lock[4]    ),
               .mask_tx_pll_lock4            (mask_tx_pll_lock[4]    ),
               .tx_pcs_rst_n5                (tx_pcs_rst_n[5]           ),
               .rx_pcs_rst_n5                (rx_pcs_rst_n[5]           ),
               .g3_tx_pcs_rst_n5             (g3_tx_pcs_rst_n[5]         ),
               .g3_rx_pcs_rst_n5             (g3_rx_pcs_rst_n[5]         ),
               .tx_pma_syncp5                (tx_pma_syncp[5]          ),
               .rx_pma_rstb5                 (rx_pma_rstb[5]           ),
               .tx_lcff_pll_rstb5            (tx_lcff_pll_rstb[5]    ),
               .fref_clk5                    (fref_clk[5]             ),
               .chnl_cal_done5               (chnl_cal_done5         ),
               .pll_cal_done5                (pll_cal_done5        ),
               .tx_lcff_pll_lock5            (tx_lcff_pll_lock5    ),
               .rx_pll_phase_lock5           (rx_pll_phase_lock[5]   ),
               .rx_pll_freq_lock5            (rx_pll_freq_lock[5]    ),
               .mask_tx_pll_lock5            (mask_tx_pll_lock[5]    ),
               .tx_pcs_rst_n6                (tx_pcs_rst_n[6]           ),
               .rx_pcs_rst_n6                (rx_pcs_rst_n[6]           ),
               .g3_tx_pcs_rst_n6             (g3_tx_pcs_rst_n[6]         ),
               .g3_rx_pcs_rst_n6             (g3_rx_pcs_rst_n[6]         ),
               .tx_pma_syncp6                (tx_pma_syncp[6]          ),
               .rx_pma_rstb6                 (rx_pma_rstb[6]           ),
               .tx_lcff_pll_rstb6            (tx_lcff_pll_rstb[6]    ),
               .fref_clk6                    (fref_clk[6]             ),
               .chnl_cal_done6               (chnl_cal_done6         ),
               .pll_cal_done6                (pll_cal_done6        ),
               .tx_lcff_pll_lock6            (tx_lcff_pll_lock6    ),
               .rx_pll_phase_lock6           (rx_pll_phase_lock[6]   ),
               .rx_pll_freq_lock6            (rx_pll_freq_lock[6]    ),
               .mask_tx_pll_lock6            (mask_tx_pll_lock[6]    ),
               .tx_pcs_rst_n7                (tx_pcs_rst_n[7]           ),
               .rx_pcs_rst_n7                (rx_pcs_rst_n[7]           ),
               .g3_tx_pcs_rst_n7             (g3_tx_pcs_rst_n[7]         ),
               .g3_rx_pcs_rst_n7             (g3_rx_pcs_rst_n[7]         ),
               .tx_pma_syncp7                (tx_pma_syncp[7]          ),
               .rx_pma_rstb7                 (rx_pma_rstb[7]           ),
               .tx_lcff_pll_rstb7            (tx_lcff_pll_rstb[7]    ),
               .fref_clk7                    (fref_clk[7]             ),
               .chnl_cal_done7               (chnl_cal_done7         ),
               .pll_cal_done7                (pll_cal_done7        ),
               .tx_lcff_pll_lock7            (tx_lcff_pll_lock7    ),
               .rx_pll_phase_lock7           (rx_pll_phase_lock[7]   ),
               .rx_pll_freq_lock7            (rx_pll_freq_lock[7]    ),
               .mask_tx_pll_lock7            (mask_tx_pll_lock[7]    ),
               .avmm_rst_n                   (((SPEED_CHANGE_ACTIVE==1) ? sc_dprio_reset_n  :((hip_reconfig==1)?avmm_rst_n          :1'b1))),
               .avmm_clk                     (((SPEED_CHANGE_ACTIVE==1) ? sc_dprio_clk      :((hip_reconfig==1)?avmm_clk            :1'b0))),
               .avmm_write                   (((SPEED_CHANGE_ACTIVE==1) ? sc_dprio_write    :((hip_reconfig==1)?avmm_write          :1'b0))),
               .avmm_read                    (((SPEED_CHANGE_ACTIVE==1) ? sc_dprio_read     :((hip_reconfig==1)?avmm_read           :1'b0))),
               .avmm_byte_en                 (((SPEED_CHANGE_ACTIVE==1) ? sc_dprio_byteen   :((hip_reconfig==1)?avmm_byte_en[1:0]   :2'b00))),
               .avmm_address                 (((SPEED_CHANGE_ACTIVE==1) ? sc_dprio_address  :((hip_reconfig==1)?avmm_address        :10'h0))),
               .avmm_writedata               (((SPEED_CHANGE_ACTIVE==1) ? sc_dprio_writedata:((hip_reconfig==1)?avmm_writedata[15:0]:16'h0))),
               .avmm_readdata                (avmm_readdata),
// synthesis translate_off
               .csr_cbdin                    (1'b0),
               .csr_clk                      (1'b0),
               .csr_din                      (1'b0),
               .csr_en                       (1'b0),
               .csr_enscan                   (1'b0),
               .csr_entest                   (1'b0),
               .csr_in                       (1'b0),
               .csr_load_csr                 (1'b0),
               .csr_pipe_in                  (1'b0),
               .csr_seg                      (1'b0),
               .csr_tcsrin                   (1'b0),
               .csr_tverify                  (1'b0),
               .cvp_config_done              (1'b0),
               .cvp_config_error             (1'b0),
               .cvp_config_ready             (1'b0),
               .cvp_en                       (1'b0),
               .entest                       (1'b0),
               .nfrzdrv                      (1'b0),
               .iocsrrdy_dly                 (1'b0),
               .user_mode                    (1'b0),
// synthesis translate_on

               .wake_oen                     (wakeoen              )

        );

// SKP Detect Logic

   wire [LANES-1:0]        core_clk;
   wire [128*LANES -1:0]   pld_rx_parallel_data;
   wire [128*LANES -1:0]   pld_rx_parallel_data_temp;
   
   reg  [128*LANES -1:0]   pld_rx_parallel_data_temp_1dly;
   reg  [128*LANES -1:0]   pld_rx_parallel_data_temp_2dly;
   wire [LANES-1:0]        pld_clk_out;
   wire [LANES-1:0]        core_rst_n;
   reg  [3*LANES -1:0]     core_rst_n_sync;
   wire [LANES-1:0]        skp_pat_det_g3_ps     /*synthesis keep*/;
   reg  [1:0]              skp_pat_det_g3_ps_or_sync;
   reg                     skp_pat_det_g3_ps_or  /*synthesis preserve*/;
   wire [8*LANES -1:0]     skp_pat_det_g3_ps_cnt /*synthesis keep*/;
   reg  [LANES-1:0]        skp_pat_det_g3_ps_r1, skp_pat_det_g3_ps_r2 /*synthesis keep*/;
   reg                     npor_int_r1, npor_int_r2;
   reg  [LANES-1:0]        reset_status_1sync;
   reg  [LANES-1:0]        reset_status_2sync;

generate begin: gen_det_skp_os
      if (enable_skp_det==1) begin

         genvar j;

         // Synchronize reset_status to the core_clk[j]
         for (j=0; j<LANES; j=j+1) begin: reset_status_sync
            always @(posedge core_clk[j]) begin
               reset_status_1sync[j] <= reset_status;
               reset_status_2sync[j] <= reset_status_1sync[j];
            end
         end


         for(j=0; j<LANES; j=j+1) begin: skp_det

            assign core_clk[j] = pld_clk_out[j];

            always @(posedge core_clk[j] or posedge reset_status_2sync[j]) begin
               if (reset_status_2sync[j] == 1'b1) begin
                  core_rst_n_sync[3*j +: 3] <= 3'b000;
               end
               else begin
                  core_rst_n_sync[3*j +: 3] <= {core_rst_n_sync[3*j+1], core_rst_n_sync[3*j], 1'b1};
               end
            end

            assign core_rst_n[j] = core_rst_n_sync[3*j+2];
				
				always @(posedge core_clk[j] or negedge core_rst_n[j]) begin
               if(core_rst_n[j] == 1'b0) begin
                  pld_rx_parallel_data_temp_1dly[128*j +: 128] <= 128'h0;
                  pld_rx_parallel_data_temp_2dly[128*j +: 128] <= 128'h0;
               end
               else begin
                 pld_rx_parallel_data_temp_1dly[128*j +: 128] <= pld_rx_parallel_data_temp[128*j +: 128];
                 pld_rx_parallel_data_temp_2dly[128*j +: 128] <= pld_rx_parallel_data_temp_1dly[128*j +: 128];
                  end
            end
            
            assign pld_rx_parallel_data = pld_rx_parallel_data_temp_2dly;

            skp_det_g3 inst(
               .rxdata                 ({pld_rx_parallel_data[128*j+55:128*j+48], pld_rx_parallel_data[128*j+39:128*j+32],pld_rx_parallel_data[128*j+23:128*j+16], pld_rx_parallel_data[128*j+7:128*j+0]}),
               .rxstartblock           (pld_rx_parallel_data[128*j+72]),
               .rxsynchdr              (pld_rx_parallel_data[128*j+71:128*j+70]),
               .rxvalid                (pld_rx_parallel_data[128*j+66]),
               .rxdatavalid            (pld_rx_parallel_data[128*j+76]),
               .rate_g3                ((currentspeed == 2'b11)?1'b1:1'b0),
               .core_clk               (core_clk[j]),
               .core_rst_n             (core_rst_n[j]),
               .skp_pat_det_g3_ps      (skp_pat_det_g3_ps[j])
            );
         end
      end
      else begin 
          assign skp_pat_det_g3_ps = 0;
      end
    end
   endgenerate
   
   // Synchronize npor_int to the coreclkout_hip
   always @(posedge coreclkout) begin
      npor_int_r1 <= npor_int;
      npor_int_r2 <= npor_int_r1;
   end

   // Synchronize skp_pat_det_g3_ps to the coreclkout_hip 
   always @(posedge coreclkout) begin
      if (npor_int_r2 == 1'b0) begin
         skp_pat_det_g3_ps_r1 <= 8'b0;
         skp_pat_det_g3_ps_r2 <= 8'b0;
      end	
      else begin
         skp_pat_det_g3_ps_r1 <= skp_pat_det_g3_ps;
         skp_pat_det_g3_ps_r2 <= skp_pat_det_g3_ps_r1;
      end
   end

   // synchronize the skp_pat_det_g3_ps_or to coreclkout_hip
   always @(posedge coreclkout)  begin  //replace the reset with the reset that is synchronized to coreclkout_hip
      if (npor_int_r2 == 1'b0) begin
         {skp_pat_det_g3_ps_or, skp_pat_det_g3_ps_or_sync[1], skp_pat_det_g3_ps_or_sync[0]} <= 3'b0;
      end
      else begin
         {skp_pat_det_g3_ps_or, skp_pat_det_g3_ps_or_sync[1], skp_pat_det_g3_ps_or_sync[0]} <= {skp_pat_det_g3_ps_or_sync[1], skp_pat_det_g3_ps_or_sync[0], |skp_pat_det_g3_ps_r2};
      end
   end

   assign skp_os = skp_pat_det_g3_ps_or;

   generate begin : g_xcvr
         altpcie_a10_hip_pllnphy #(
            .protocol_version                     (protocol_version                                      ),
            .LANES                                (LANES                                                 ),
            .export_phy_input_to_top_level_hwtcl  (export_phy_input_to_top_level_hwtcl                   ),
            .reconfig_address_width_integer_hwtcl (reconfig_address_width_integer_hwtcl                  )
         ) altpcie_a10_hip_pllnphy (
            .rx_parallel_data             (pld_rx_parallel_data_temp     [128*LANES -1:0]                ),
            .rx_clkout                    (pld_clk_out                   [LANES   -1:0]                  ),
            .tx_analogreset               (~serdes_tx_pcs_rst_n          [LANES   -1:0]                  ),
            .tx_digitalreset              (~serdes_tx_pcs_rst_n          [LANES   -1:0]                  ),
            .rx_analogreset               (~serdes_rx_pma_rstb           [LANES   -1:0]                  ),
            .rx_digitalreset              (~serdes_rx_pcs_rst_n          [LANES   -1:0]                  ),
            .tx_cal_busy                  (serdes_tx_cal_busy            [LANES   -1:0]                  ),
            .rx_cal_busy                  (serdes_rx_cal_busy            [LANES   -1:0]                  ),
            .rx_cdr_refclk0               ((pipe32_sim_only==1'b1)?1'b0:refclk                           ),
            .tx_serial_data               (serdes_tx_serial_data         [LANES   -1:0]                  ),
            .rx_serial_data               (serdes_rx_serial_data         [LANES   -1:0]                  ),
            .rx_set_locktodata            (serdes_rx_set_locktodata      [LANES   -1:0]                  ),
            .rx_set_locktoref             (serdes_rx_set_locktoref       [LANES   -1:0]                  ),
            .rx_is_lockedtoref            (serdes_rx_is_lockedtoref      [LANES   -1:0]                  ),
            .rx_is_lockedtodata           (serdes_rx_is_lockedtodata     [LANES   -1:0]                  ),
            .pipe_rx_polarity             (serdes_pipe_rxpolarity        [LANES   -1:0]                  ),
            .tx_hip_data                  (serdes_tx_hip_data            [64*LANES-1:0]                  ),
            .rx_hip_data                  (serdes_rx_hip_data            [51*LANES-1:0]                  ),
            .hip_pipe_pclk                (serdes_pipe_pclk                                              ),
            .hip_fixedclk                 (serdes_pllfixedclk                                            ),
            .hip_frefclk                  (serdes_fref_clk               [LANES   -1:0]                  ),
            .hip_ctrl                     (serdes_hip_ctrl               [8*LANES -1:0]                  ),
            .chnl_cal_done                (serdes_chnl_cal_done          [LANES   -1:0]                  ),
            .pipe_rate                    (serdes_pipe_rate              [2*LANES -1:0]                  ),
            .pipe_rx_eidleinfersel        (serdes_rx_eidle_infer_sel     [3*LANES -1:0]                  ),
            .pipe_rx_elecidle             (serdes_pipe_rx_elecidle       [LANES   -1:0]                  ),
            .reconfig_clk                 (dbg_rx_dyn_polinv_reconfig==1'b1 ? dbg_rx_dyn_polinv_reconfig_clk 		: xcvr_reconfig_clk       ),
            .reconfig_reset               (dbg_rx_dyn_polinv_reconfig==1'b1 ? dbg_rx_dyn_polinv_reconfig_reset      : xcvr_reconfig_reset     ),
            .reconfig_write               (dbg_rx_dyn_polinv_reconfig==1'b1 ? dbg_rx_dyn_polinv_reconfig_write      : xcvr_reconfig_write     ),
            .reconfig_read                (dbg_rx_dyn_polinv_reconfig==1'b1 ? dbg_rx_dyn_polinv_reconfig_read       : xcvr_reconfig_read      ),
            .reconfig_address             (dbg_rx_dyn_polinv_reconfig==1'b1 ? dbg_rx_dyn_polinv_reconfig_address    : xcvr_reconfig_address   ),
            .reconfig_writedata           (dbg_rx_dyn_polinv_reconfig==1'b1 ? dbg_rx_dyn_polinv_reconfig_writedata  : xcvr_reconfig_writedata ),
            .reconfig_readdata            (xcvr_reconfig_readdata_int                                    ),
            .hip_reduce_counters          (test_in[0]                                                    ), 
            .current_rate                 (current_rate_wire                                             ),           
            .ltssm_eq_phase2              (ltssm_eq_phase2_wire                                          ),   
            .ltssm_detect_active          (ltssm_detect_active_wire                                      ),
            .ltssm_detect_quiet           (ltssm_detect_quiet_wire                                       ),
            .reconfig_waitrequest         (xcvr_reconfig_waitrequest_int                                 ),
           .reconfig_pll0_clk            (reconfig_pll0_clk                                             ),
            .reconfig_pll0_reset          (reconfig_pll0_reset                                           ),
            .reconfig_pll0_write          (reconfig_pll0_write                                           ),
            .reconfig_pll0_read           (reconfig_pll0_read                                            ),
            .reconfig_pll0_address        (reconfig_pll0_address                                         ),
            .reconfig_pll0_writedata      (reconfig_pll0_writedata                                       ),
            .reconfig_pll0_readdata       (reconfig_pll0_readdata                                        ),
            .reconfig_pll0_waitrequest    (reconfig_pll0_waitrequest                                     ),
            .reconfig_pll1_clk            (reconfig_pll1_clk                                             ),
            .reconfig_pll1_reset          (reconfig_pll1_reset                                           ),
            .reconfig_pll1_write          (reconfig_pll1_write                                           ),
            .reconfig_pll1_read           (reconfig_pll1_read                                            ),
            .reconfig_pll1_address        (reconfig_pll1_address                                         ),
            .reconfig_pll1_writedata      (reconfig_pll1_writedata                                       ),
            .reconfig_pll1_readdata       (reconfig_pll1_readdata                                        ),
            .reconfig_pll1_waitrequest    (reconfig_pll1_waitrequest                                     ),
            .pipe_g3_txdeemph             (serdes_current_coeff          [18*LANES-1:0]                  ),   //   input  wire [18*LANES-1:0] pipe_g3_txdeemph,
            .pipe_g3_rxpresethint         (serdes_current_rxpreset       [3*LANES-1:0]                   ),   //   input  wire [3*LANES-1:0]  pipe_g3_rxpresethint,
            .pll_powerdown_lcpll          (~serdes_tx_lc_pll_rstb                                        ),
            .pll_powerdown_fpll           (~serdes_tx_fpll_rstb                                          ),
            .mcgb_rst                     (~serdes_mcgb_rstb                                             ),
            .pll_refclk0                  ((pipe32_sim_only==1'b1)?1'b0:refclk                           ),
            .pll_locked_lcpll             (serdes_pll_locked_lcpll                                       ),
            .pll_locked_fpll              (serdes_pll_locked_fpll                                        ),
            .pll_cal_done_lcpll           (serdes_pll_cal_done_lcpll                                     ),
            .pll_cal_done_fpll            (serdes_pll_cal_done_fpll                                      ),
            .pipe_hclk_in                 (pipe_hclk_in                                                  ),
            .pll_pcie_clk                 (pll_pcie_clk                                                  ),
            .rx_polinv                    (dbg_pld_rx_polinv_all_ln[LANES-1:0]                           )
         );
   end
   endgenerate

   assign force_tx_eidle           = 1'b0;
   assign test_in_1_hip_eq         = 32'h0;
   assign hip_dprio_clk            = 1'b0;
   assign hip_dprio_reset_n        = 1'b0;
   assign hip_dprio_address        = 10'h0;
   assign hip_dprio_read           = 1'b0;
   assign hip_dprio_write          = 1'b0;
   assign hip_dprio_writedata      = 16'h0;
   assign hip_dprio_byteen         = 2'h0;
   assign hip_dprio_readdata       = 16'h0;

  //==================================
  // Config-Bypass Autonomous mode
  ////////////////////////////////////////////////////////////////////////////
  // Speed Change and Config-Bypass autonomous mode
  //==================================================
  // Config-Bypass Autonomous and speed change logic
  //==================================================

 generate begin : sc_dprio

  if (SPEED_CHANGE_ACTIVE == 1) begin :gspact

   ///////////////////////////////////////////////////////////////////////////
   // Generate dprio_reconfig_clk and dprio_reconfig_reset_n
   ///////////////////////////////////////////////////////////////////////////
      reg dprio_reconfig_clk;
      reg npor_sync_dprio_reconfig_clk;
      reg npor_sync_dprio_reconfig_clk_r;
      reg npor_int_sync_fixedclk_r, npor_int_sync_fixedclk;
      reg npor_sync_coreclkout_hip;
      reg npor_sync_coreclkout_hip_r;

      wire dprio_reconfig_reset_n = npor_sync_dprio_reconfig_clk;

      always@( posedge serdes_fixedclk or negedge npor_int ) begin
         if( ~npor_int ) begin
            npor_int_sync_fixedclk_r <= 1'b0;
            npor_int_sync_fixedclk   <= 1'b0;
         end
         else begin
            npor_int_sync_fixedclk_r <= 1'b1;
            npor_int_sync_fixedclk <= npor_int_sync_fixedclk_r;
         end
      end
      always@( posedge serdes_fixedclk or negedge npor_int_sync_fixedclk ) begin
         if( ~npor_int_sync_fixedclk )
            dprio_reconfig_clk <= 1'b0;
         else
            dprio_reconfig_clk <= ~dprio_reconfig_clk;
      end

      always@( posedge dprio_reconfig_clk or negedge npor_int ) begin
         if( ~npor_int ) begin
            npor_sync_dprio_reconfig_clk_r <= 1'b0;
            npor_sync_dprio_reconfig_clk   <= 1'b0;
         end
         else begin
            npor_sync_dprio_reconfig_clk_r <= 1'b1;
            npor_sync_dprio_reconfig_clk   <= npor_sync_dprio_reconfig_clk_r;
         end
      end

      always@( posedge coreclkout or negedge npor_int ) begin
         if( ~npor_int ) begin
            npor_sync_coreclkout_hip_r <= 1'b0;
            npor_sync_coreclkout_hip   <= 1'b0;
         end
         else begin
            npor_sync_coreclkout_hip_r <= 1'b1;
            npor_sync_coreclkout_hip   <= npor_sync_coreclkout_hip_r;
         end
      end


      // Instantiate autonomous speed change logic
      altpcie_sc_dprio_top #(
         .use_config_bypass_hwtcl   (cseb_config_bypass=="enable" ? 1'b1 : 1'b0),
         .cseb_autonomous_hwtcl     (cseb_autonomous_hwtcl),
         .default_speed             ((low_str(gen123_lane_rate_mode)=="gen1_gen2_gen3") ? 2'b11 :
                                    (low_str(gen123_lane_rate_mode)=="gen1_gen2") ? 2'b10 :
                                    (low_str(gen123_lane_rate_mode)=="gen1") ? 2'b01 : 2'b11)
      )
      altpcie_sc_dprio_top (
         .pld_clk                 ( coreclkout              ),
         .pld_reset_n             ( npor_sync_coreclkout_hip),
         .test_sim                ( test_in[0]              ),
         .reconfig_clk            ( dprio_reconfig_clk      ),
         .reconfig_reset_n        ( dprio_reconfig_reset_n  ),
         .hip_reconfig_clk        ( sc_dprio_clk            ),
         .hip_reconfig_reset_n    ( sc_dprio_reset_n        ),
         .hip_reconfig_write      ( sc_dprio_write          ),
         .hip_reconfig_writedata  ( sc_dprio_writedata      ),
         .hip_reconfig_byteen     ( sc_dprio_byteen         ),
         .hip_reconfig_address    ( sc_dprio_address        ),
         .hip_reconfig_read       ( sc_dprio_read           ),
       //.hip_reconfig_readdata   ( sc_dprio_readdata       ),
         .hip_reconfig_readdata   ( 16'h5555                ),
         .ltssm                   ( ltssmstate              ),
         .app_speed_chg_en_i      ( 1'b0                    ),
         .app_cseb_switch_i       ( 1'b0                    ),
         .test_in_9_o             ( sc_test_in_9            ),
         .hold_ltssm_rec_o        ( sc_hold_ltssm_rec       ),
         .current_speed_i         ( currentspeed            ),
         .tl_cfg_add_i            (tl_cfg_add               ),
         .tl_cfg_ctl_i            (tl_cfg_ctl               ),
         .cfglink2csrpld_i        (cfglink2csrpld           )

      );

      assign test_in_int         =  {altpcie_test_in_static_signal_to_be_false_path[63:32], altpcie_test_in_static_signal_to_be_false_path[31:10], sc_test_in_9, altpcie_test_in_static_signal_to_be_false_path[8:0]};
      assign sc_dprio_readdata    =  avmm_readdata;

  end else begin :gspna

     assign sc_dprio_clk             = 1'b0;
     assign sc_dprio_reset_n         = 1'b0;
     assign sc_dprio_write           = 1'b0;
     assign sc_dprio_writedata       = 16'h0;
     assign sc_dprio_byteen          = 2'h0;
     assign sc_dprio_address         = 10'h0;
     assign sc_dprio_read            = 1'b0;
     assign sc_dprio_readdata        = 16'h0;
     assign sc_hold_ltssm_rec        = 1'b0;
     assign sc_test_in_9             = 1'b0;
     assign test_in_int              =  altpcie_test_in_static_signal_to_be_false_path;

   end // SPEED_CHANGE_ACTIVE
end
endgenerate     //sc_dprio

  //========================
  //PIPE output signals
  assign txdata0_ext           [31 : 0]   = (pipe32_sim_only==1'b0)?ZEROS[31 : 0]:txdata0;
  assign txdata1_ext           [31 : 0]   = (pipe32_sim_only==1'b0)?ZEROS[31 : 0]:txdata1;
  assign txdata2_ext           [31 : 0]   = (pipe32_sim_only==1'b0)?ZEROS[31 : 0]:txdata2;
  assign txdata3_ext           [31 : 0]   = (pipe32_sim_only==1'b0)?ZEROS[31 : 0]:txdata3;
  assign txdata4_ext           [31 : 0]   = (pipe32_sim_only==1'b0)?ZEROS[31 : 0]:txdata4;
  assign txdata5_ext           [31 : 0]   = (pipe32_sim_only==1'b0)?ZEROS[31 : 0]:txdata5;
  assign txdata6_ext           [31 : 0]   = (pipe32_sim_only==1'b0)?ZEROS[31 : 0]:txdata6;
  assign txdata7_ext           [31 : 0]   = (pipe32_sim_only==1'b0)?ZEROS[31 : 0]:txdata7;
  assign txdatak0_ext          [ 3 : 0]   = (pipe32_sim_only==1'b0)?ZEROS[ 3 : 0]:txdatak0;
  assign txdatak1_ext          [ 3 : 0]   = (pipe32_sim_only==1'b0)?ZEROS[ 3 : 0]:txdatak1;
  assign txdatak2_ext          [ 3 : 0]   = (pipe32_sim_only==1'b0)?ZEROS[ 3 : 0]:txdatak2;
  assign txdatak3_ext          [ 3 : 0]   = (pipe32_sim_only==1'b0)?ZEROS[ 3 : 0]:txdatak3;
  assign txdatak4_ext          [ 3 : 0]   = (pipe32_sim_only==1'b0)?ZEROS[ 3 : 0]:txdatak4;
  assign txdatak5_ext          [ 3 : 0]   = (pipe32_sim_only==1'b0)?ZEROS[ 3 : 0]:txdatak5;
  assign txdatak6_ext          [ 3 : 0]   = (pipe32_sim_only==1'b0)?ZEROS[ 3 : 0]:txdatak6;
  assign txdatak7_ext          [ 3 : 0]   = (pipe32_sim_only==1'b0)?ZEROS[ 3 : 0]:txdatak7;
  assign eidle_infer_sel0_ext  [2 : 0]    = (pipe32_sim_only==1'b0)?ZEROS[2 : 0] :eidle_infer_sel0   ;
  assign eidle_infer_sel1_ext  [2 : 0]    = (pipe32_sim_only==1'b0)?ZEROS[2 : 0] :eidle_infer_sel1   ;
  assign eidle_infer_sel2_ext  [2 : 0]    = (pipe32_sim_only==1'b0)?ZEROS[2 : 0] :eidle_infer_sel2   ;
  assign eidle_infer_sel3_ext  [2 : 0]    = (pipe32_sim_only==1'b0)?ZEROS[2 : 0] :eidle_infer_sel3   ;
  assign eidle_infer_sel4_ext  [2 : 0]    = (pipe32_sim_only==1'b0)?ZEROS[2 : 0] :eidle_infer_sel4   ;
  assign eidle_infer_sel5_ext  [2 : 0]    = (pipe32_sim_only==1'b0)?ZEROS[2 : 0] :eidle_infer_sel5   ;
  assign eidle_infer_sel6_ext  [2 : 0]    = (pipe32_sim_only==1'b0)?ZEROS[2 : 0] :eidle_infer_sel6   ;
  assign eidle_infer_sel7_ext  [2 : 0]    = (pipe32_sim_only==1'b0)?ZEROS[2 : 0] :eidle_infer_sel7   ;
  assign powerdown0_ext        [1 : 0]    = (pipe32_sim_only==1'b0)?ZEROS[1 : 0] :powerdown0         ;
  assign powerdown1_ext        [1 : 0]    = (pipe32_sim_only==1'b0)?ZEROS[1 : 0] :powerdown1         ;
  assign powerdown2_ext        [1 : 0]    = (pipe32_sim_only==1'b0)?ZEROS[1 : 0] :powerdown2         ;
  assign powerdown3_ext        [1 : 0]    = (pipe32_sim_only==1'b0)?ZEROS[1 : 0] :powerdown3         ;
  assign powerdown4_ext        [1 : 0]    = (pipe32_sim_only==1'b0)?ZEROS[1 : 0] :powerdown4         ;
  assign powerdown5_ext        [1 : 0]    = (pipe32_sim_only==1'b0)?ZEROS[1 : 0] :powerdown5         ;
  assign powerdown6_ext        [1 : 0]    = (pipe32_sim_only==1'b0)?ZEROS[1 : 0] :powerdown6         ;
  assign powerdown7_ext        [1 : 0]    = (pipe32_sim_only==1'b0)?ZEROS[1 : 0] :powerdown7         ;
  assign rxpolarity0_ext                  = (pipe32_sim_only==1'b0)?1'b0         :rxpolarity0        ;
  assign rxpolarity1_ext                  = (pipe32_sim_only==1'b0)?1'b0         :rxpolarity1        ;
  assign rxpolarity2_ext                  = (pipe32_sim_only==1'b0)?1'b0         :rxpolarity2        ;
  assign rxpolarity3_ext                  = (pipe32_sim_only==1'b0)?1'b0         :rxpolarity3        ;
  assign rxpolarity4_ext                  = (pipe32_sim_only==1'b0)?1'b0         :rxpolarity4        ;
  assign rxpolarity5_ext                  = (pipe32_sim_only==1'b0)?1'b0         :rxpolarity5        ;
  assign rxpolarity6_ext                  = (pipe32_sim_only==1'b0)?1'b0         :rxpolarity6        ;
  assign rxpolarity7_ext                  = (pipe32_sim_only==1'b0)?1'b0         :rxpolarity7        ;
  assign txcompl0_ext                     = (pipe32_sim_only==1'b0)?1'b0         :txcompl0           ;
  assign txcompl1_ext                     = (pipe32_sim_only==1'b0)?1'b0         :txcompl1           ;
  assign txcompl2_ext                     = (pipe32_sim_only==1'b0)?1'b0         :txcompl2           ;
  assign txcompl3_ext                     = (pipe32_sim_only==1'b0)?1'b0         :txcompl3           ;
  assign txcompl4_ext                     = (pipe32_sim_only==1'b0)?1'b0         :txcompl4           ;
  assign txcompl5_ext                     = (pipe32_sim_only==1'b0)?1'b0         :txcompl5           ;
  assign txcompl6_ext                     = (pipe32_sim_only==1'b0)?1'b0         :txcompl6           ;
  assign txcompl7_ext                     = (pipe32_sim_only==1'b0)?1'b0         :txcompl7           ;
  assign txdetectrx0_ext                  = (pipe32_sim_only==1'b0)?1'b0         :txdetectrx0        ;
  assign txdetectrx1_ext                  = (pipe32_sim_only==1'b0)?1'b0         :txdetectrx1        ;
  assign txdetectrx2_ext                  = (pipe32_sim_only==1'b0)?1'b0         :txdetectrx2        ;
  assign txdetectrx3_ext                  = (pipe32_sim_only==1'b0)?1'b0         :txdetectrx3        ;
  assign txdetectrx4_ext                  = (pipe32_sim_only==1'b0)?1'b0         :txdetectrx4        ;
  assign txdetectrx5_ext                  = (pipe32_sim_only==1'b0)?1'b0         :txdetectrx5        ;
  assign txdetectrx6_ext                  = (pipe32_sim_only==1'b0)?1'b0         :txdetectrx6        ;
  assign txdetectrx7_ext                  = (pipe32_sim_only==1'b0)?1'b0         :txdetectrx7        ;
  assign txelecidle0_ext                  = (pipe32_sim_only==1'b0)?1'b0         :txelecidle0        ;
  assign txelecidle1_ext                  = (pipe32_sim_only==1'b0)?1'b0         :txelecidle1        ;
  assign txelecidle2_ext                  = (pipe32_sim_only==1'b0)?1'b0         :txelecidle2        ;
  assign txelecidle3_ext                  = (pipe32_sim_only==1'b0)?1'b0         :txelecidle3        ;
  assign txelecidle4_ext                  = (pipe32_sim_only==1'b0)?1'b0         :txelecidle4        ;
  assign txelecidle5_ext                  = (pipe32_sim_only==1'b0)?1'b0         :txelecidle5        ;
  assign txelecidle6_ext                  = (pipe32_sim_only==1'b0)?1'b0         :txelecidle6        ;
  assign txelecidle7_ext                  = (pipe32_sim_only==1'b0)?1'b0         :txelecidle7        ;
  assign tx_margin0_ext       [2 : 0]     = (pipe32_sim_only==1'b0)?ZEROS[2 : 0] :tx_margin0         ;
  assign tx_margin1_ext       [2 : 0]     = (pipe32_sim_only==1'b0)?ZEROS[2 : 0] :tx_margin1         ;
  assign tx_margin2_ext       [2 : 0]     = (pipe32_sim_only==1'b0)?ZEROS[2 : 0] :tx_margin2         ;
  assign tx_margin3_ext       [2 : 0]     = (pipe32_sim_only==1'b0)?ZEROS[2 : 0] :tx_margin3         ;
  assign tx_margin4_ext       [2 : 0]     = (pipe32_sim_only==1'b0)?ZEROS[2 : 0] :tx_margin4         ;
  assign tx_margin5_ext       [2 : 0]     = (pipe32_sim_only==1'b0)?ZEROS[2 : 0] :tx_margin5         ;
  assign tx_margin6_ext       [2 : 0]     = (pipe32_sim_only==1'b0)?ZEROS[2 : 0] :tx_margin6         ;
  assign tx_margin7_ext       [2 : 0]     = (pipe32_sim_only==1'b0)?ZEROS[2 : 0] :tx_margin7         ;
  assign tx_deemph0_ext                   = (pipe32_sim_only==1'b0)?1'b0         :tx_deemph0         ;
  assign tx_deemph1_ext                   = (pipe32_sim_only==1'b0)?1'b0         :tx_deemph1         ;
  assign tx_deemph2_ext                   = (pipe32_sim_only==1'b0)?1'b0         :tx_deemph2         ;
  assign tx_deemph3_ext                   = (pipe32_sim_only==1'b0)?1'b0         :tx_deemph3         ;
  assign tx_deemph4_ext                   = (pipe32_sim_only==1'b0)?1'b0         :tx_deemph4         ;
  assign tx_deemph5_ext                   = (pipe32_sim_only==1'b0)?1'b0         :tx_deemph5         ;
  assign tx_deemph6_ext                   = (pipe32_sim_only==1'b0)?1'b0         :tx_deemph6         ;
  assign tx_deemph7_ext                   = (pipe32_sim_only==1'b0)?1'b0         :tx_deemph7         ;
  assign txswing0_ext                     = (pipe32_sim_only==1'b0)?1'b0         :txswing0           ;
  assign txswing1_ext                     = (pipe32_sim_only==1'b0)?1'b0         :txswing1           ;
  assign txswing2_ext                     = (pipe32_sim_only==1'b0)?1'b0         :txswing2           ;
  assign txswing3_ext                     = (pipe32_sim_only==1'b0)?1'b0         :txswing3           ;
  assign txswing4_ext                     = (pipe32_sim_only==1'b0)?1'b0         :txswing4           ;
  assign txswing5_ext                     = (pipe32_sim_only==1'b0)?1'b0         :txswing5           ;
  assign txswing6_ext                     = (pipe32_sim_only==1'b0)?1'b0         :txswing6           ;
  assign txswing7_ext                     = (pipe32_sim_only==1'b0)?1'b0         :txswing7           ;
  assign rate0_ext            [1:0]       = (pipe32_sim_only==1'b0)?ZEROS[1:0]   :rate0              ;
  assign rate1_ext            [1:0]       = (pipe32_sim_only==1'b0)?ZEROS[1:0]   :rate1              ;
  assign rate2_ext            [1:0]       = (pipe32_sim_only==1'b0)?ZEROS[1:0]   :rate2              ;
  assign rate3_ext            [1:0]       = (pipe32_sim_only==1'b0)?ZEROS[1:0]   :rate3              ;
  assign rate4_ext            [1:0]       = (pipe32_sim_only==1'b0)?ZEROS[1:0]   :rate4              ;
  assign rate5_ext            [1:0]       = (pipe32_sim_only==1'b0)?ZEROS[1:0]   :rate5              ;
  assign rate6_ext            [1:0]       = (pipe32_sim_only==1'b0)?ZEROS[1:0]   :rate6              ;
  assign rate7_ext            [1:0]       = (pipe32_sim_only==1'b0)?ZEROS[1:0]   :rate7              ;
  assign txdataskip0_ext                = (pipe32_sim_only==1'b0)?1'b0           :txdataskip0        ;
  assign txdataskip1_ext                = (pipe32_sim_only==1'b0)?1'b0           :txdataskip1        ;
  assign txdataskip2_ext                = (pipe32_sim_only==1'b0)?1'b0           :txdataskip2        ;
  assign txdataskip3_ext                = (pipe32_sim_only==1'b0)?1'b0           :txdataskip3        ;
  assign txdataskip4_ext                = (pipe32_sim_only==1'b0)?1'b0           :txdataskip4        ;
  assign txdataskip5_ext                = (pipe32_sim_only==1'b0)?1'b0           :txdataskip5        ;
  assign txdataskip6_ext                = (pipe32_sim_only==1'b0)?1'b0           :txdataskip6        ;
  assign txdataskip7_ext                = (pipe32_sim_only==1'b0)?1'b0           :txdataskip7        ;
  assign txblkst0_ext                   = (pipe32_sim_only==1'b0)?1'b0           :txblkst0           ;
  assign txblkst1_ext                   = (pipe32_sim_only==1'b0)?1'b0           :txblkst1           ;
  assign txblkst2_ext                   = (pipe32_sim_only==1'b0)?1'b0           :txblkst2           ;
  assign txblkst3_ext                   = (pipe32_sim_only==1'b0)?1'b0           :txblkst3           ;
  assign txblkst4_ext                   = (pipe32_sim_only==1'b0)?1'b0           :txblkst4           ;
  assign txblkst5_ext                   = (pipe32_sim_only==1'b0)?1'b0           :txblkst5           ;
  assign txblkst6_ext                   = (pipe32_sim_only==1'b0)?1'b0           :txblkst6           ;
  assign txblkst7_ext                   = (pipe32_sim_only==1'b0)?1'b0           :txblkst7           ;
  assign txsynchd0_ext        [1 : 0]   = (pipe32_sim_only==1'b0)?ZEROS[1 : 0]   :txsynchd0          ;
  assign txsynchd1_ext        [1 : 0]   = (pipe32_sim_only==1'b0)?ZEROS[1 : 0]   :txsynchd1          ;
  assign txsynchd2_ext        [1 : 0]   = (pipe32_sim_only==1'b0)?ZEROS[1 : 0]   :txsynchd2          ;
  assign txsynchd3_ext        [1 : 0]   = (pipe32_sim_only==1'b0)?ZEROS[1 : 0]   :txsynchd3          ;
  assign txsynchd4_ext        [1 : 0]   = (pipe32_sim_only==1'b0)?ZEROS[1 : 0]   :txsynchd4          ;
  assign txsynchd5_ext        [1 : 0]   = (pipe32_sim_only==1'b0)?ZEROS[1 : 0]   :txsynchd5          ;
  assign txsynchd6_ext        [1 : 0]   = (pipe32_sim_only==1'b0)?ZEROS[1 : 0]   :txsynchd6          ;
  assign txsynchd7_ext        [1 : 0]   = (pipe32_sim_only==1'b0)?ZEROS[1 : 0]   :txsynchd7          ;
  assign current_coeff0_ext   [17 : 0]  = (pipe32_sim_only==1'b0)?ZEROS[17 : 0]  :current_coeff0     ;
  assign current_coeff1_ext   [17 : 0]  = (pipe32_sim_only==1'b0)?ZEROS[17 : 0]  :current_coeff1     ;
  assign current_coeff2_ext   [17 : 0]  = (pipe32_sim_only==1'b0)?ZEROS[17 : 0]  :current_coeff2     ;
  assign current_coeff3_ext   [17 : 0]  = (pipe32_sim_only==1'b0)?ZEROS[17 : 0]  :current_coeff3     ;
  assign current_coeff4_ext   [17 : 0]  = (pipe32_sim_only==1'b0)?ZEROS[17 : 0]  :current_coeff4     ;
  assign current_coeff5_ext   [17 : 0]  = (pipe32_sim_only==1'b0)?ZEROS[17 : 0]  :current_coeff5     ;
  assign current_coeff6_ext   [17 : 0]  = (pipe32_sim_only==1'b0)?ZEROS[17 : 0]  :current_coeff6     ;
  assign current_coeff7_ext   [17 : 0]  = (pipe32_sim_only==1'b0)?ZEROS[17 : 0]  :current_coeff7     ;
  assign current_rxpreset0_ext[2 : 0]   = (pipe32_sim_only==1'b0)?ZEROS[2 : 0]   :current_rxpreset0  ;
  assign current_rxpreset1_ext[2 : 0]   = (pipe32_sim_only==1'b0)?ZEROS[2 : 0]   :current_rxpreset1  ;
  assign current_rxpreset2_ext[2 : 0]   = (pipe32_sim_only==1'b0)?ZEROS[2 : 0]   :current_rxpreset2  ;
  assign current_rxpreset3_ext[2 : 0]   = (pipe32_sim_only==1'b0)?ZEROS[2 : 0]   :current_rxpreset3  ;
  assign current_rxpreset4_ext[2 : 0]   = (pipe32_sim_only==1'b0)?ZEROS[2 : 0]   :current_rxpreset4  ;
  assign current_rxpreset5_ext[2 : 0]   = (pipe32_sim_only==1'b0)?ZEROS[2 : 0]   :current_rxpreset5  ;
  assign current_rxpreset6_ext[2 : 0]   = (pipe32_sim_only==1'b0)?ZEROS[2 : 0]   :current_rxpreset6  ;
  assign current_rxpreset7_ext[2 : 0]   = (pipe32_sim_only==1'b0)?ZEROS[2 : 0]   :current_rxpreset7  ;

////////////////////////////////////////////////////////////////////////////
// Simulation only

// synthesis translate_off

`ifndef ALTPCIE_MONITOR_A10_HIP_DL_SKIP
   altpcie_monitor_a10_dlhip_sim #(
        .IS_EP((port_type=="root_port")?0:1)
    )    altpcie_monitor_a10_dlhip_sim (
        .tx_st_data    (wys.twentynm_hssi_gen3_x8_pcie_hip_encrypted_inst.hd_altpe3_hip_core_top_inst.twentynm_hssirtl_hd_altpe3_hip_core.altpcie_pipe.twentynm_hssirtl_hd_altpe3_dl.tx_st_data              ),
        .tx_st_valid   (wys.twentynm_hssi_gen3_x8_pcie_hip_encrypted_inst.hd_altpe3_hip_core_top_inst.twentynm_hssirtl_hd_altpe3_hip_core.altpcie_pipe.twentynm_hssirtl_hd_altpe3_dl.tx_st_valid             ),
        .tx_st_sop     (wys.twentynm_hssi_gen3_x8_pcie_hip_encrypted_inst.hd_altpe3_hip_core_top_inst.twentynm_hssirtl_hd_altpe3_hip_core.altpcie_pipe.twentynm_hssirtl_hd_altpe3_dl.tx_st_sop               ),
        .tx_st_eop     (wys.twentynm_hssi_gen3_x8_pcie_hip_encrypted_inst.hd_altpe3_hip_core_top_inst.twentynm_hssirtl_hd_altpe3_hip_core.altpcie_pipe.twentynm_hssirtl_hd_altpe3_dl.tx_st_eop               ),
        .tx_st_ready   (wys.twentynm_hssi_gen3_x8_pcie_hip_encrypted_inst.hd_altpe3_hip_core_top_inst.twentynm_hssirtl_hd_altpe3_hip_core.altpcie_pipe.twentynm_hssirtl_hd_altpe3_dl.tx_st_ready             ),
        .rx_st_data    (wys.twentynm_hssi_gen3_x8_pcie_hip_encrypted_inst.hd_altpe3_hip_core_top_inst.twentynm_hssirtl_hd_altpe3_hip_core.altpcie_pipe.twentynm_hssirtl_hd_altpe3_dl.rx_st_data              ),
        .rx_st_sop     (wys.twentynm_hssi_gen3_x8_pcie_hip_encrypted_inst.hd_altpe3_hip_core_top_inst.twentynm_hssirtl_hd_altpe3_hip_core.altpcie_pipe.twentynm_hssirtl_hd_altpe3_dl.rx_st_sop               ),
        .rx_st_eop     (wys.twentynm_hssi_gen3_x8_pcie_hip_encrypted_inst.hd_altpe3_hip_core_top_inst.twentynm_hssirtl_hd_altpe3_hip_core.altpcie_pipe.twentynm_hssirtl_hd_altpe3_dl.rx_st_eop               ),
        .rx_st_valid   (wys.twentynm_hssi_gen3_x8_pcie_hip_encrypted_inst.hd_altpe3_hip_core_top_inst.twentynm_hssirtl_hd_altpe3_hip_core.altpcie_pipe.twentynm_hssirtl_hd_altpe3_dl.rx_st_valid             ),
        .rx_val_pm     (wys.twentynm_hssi_gen3_x8_pcie_hip_encrypted_inst.hd_altpe3_hip_core_top_inst.twentynm_hssirtl_hd_altpe3_hip_core.altpcie_pipe.twentynm_hssirtl_hd_altpe3_dl.rx_val_pm               ),
        .rx_typ_pm     (wys.twentynm_hssi_gen3_x8_pcie_hip_encrypted_inst.hd_altpe3_hip_core_top_inst.twentynm_hssirtl_hd_altpe3_hip_core.altpcie_pipe.twentynm_hssirtl_hd_altpe3_dl.rx_typ_pm               ),
        .rx_val_fc     (wys.twentynm_hssi_gen3_x8_pcie_hip_encrypted_inst.hd_altpe3_hip_core_top_inst.twentynm_hssirtl_hd_altpe3_hip_core.altpcie_pipe.twentynm_hssirtl_hd_altpe3_dl.rx_val_fc               ),
        .rx_typ_fc     (wys.twentynm_hssi_gen3_x8_pcie_hip_encrypted_inst.hd_altpe3_hip_core_top_inst.twentynm_hssirtl_hd_altpe3_hip_core.altpcie_pipe.twentynm_hssirtl_hd_altpe3_dl.rx_typ_fc               ),
        .rx_vcid_fc    (wys.twentynm_hssi_gen3_x8_pcie_hip_encrypted_inst.hd_altpe3_hip_core_top_inst.twentynm_hssirtl_hd_altpe3_hip_core.altpcie_pipe.twentynm_hssirtl_hd_altpe3_dl.rx_vcid_fc              ),
        .rx_hdr_fc     (wys.twentynm_hssi_gen3_x8_pcie_hip_encrypted_inst.hd_altpe3_hip_core_top_inst.twentynm_hssirtl_hd_altpe3_hip_core.altpcie_pipe.twentynm_hssirtl_hd_altpe3_dl.rx_hdr_fc               ),
        .rx_data_fc    (wys.twentynm_hssi_gen3_x8_pcie_hip_encrypted_inst.hd_altpe3_hip_core_top_inst.twentynm_hssirtl_hd_altpe3_hip_core.altpcie_pipe.twentynm_hssirtl_hd_altpe3_dl.rx_data_fc              ),
        .rx_val_nak    (wys.twentynm_hssi_gen3_x8_pcie_hip_encrypted_inst.hd_altpe3_hip_core_top_inst.twentynm_hssirtl_hd_altpe3_hip_core.altpcie_pipe.twentynm_hssirtl_hd_altpe3_dl.rx_val_nak              ),
        .rx_res_nak    (wys.twentynm_hssi_gen3_x8_pcie_hip_encrypted_inst.hd_altpe3_hip_core_top_inst.twentynm_hssirtl_hd_altpe3_hip_core.altpcie_pipe.twentynm_hssirtl_hd_altpe3_dl.rx_res_nak              ),
        .rx_num_nak    (wys.twentynm_hssi_gen3_x8_pcie_hip_encrypted_inst.hd_altpe3_hip_core_top_inst.twentynm_hssirtl_hd_altpe3_hip_core.altpcie_pipe.twentynm_hssirtl_hd_altpe3_dl.rx_num_nak              ),
        .req_upfc      (wys.twentynm_hssi_gen3_x8_pcie_hip_encrypted_inst.hd_altpe3_hip_core_top_inst.twentynm_hssirtl_hd_altpe3_hip_core.altpcie_pipe.twentynm_hssirtl_hd_altpe3_dl.req_upfc                ),
        .ack_snd_upfc  (wys.twentynm_hssi_gen3_x8_pcie_hip_encrypted_inst.hd_altpe3_hip_core_top_inst.twentynm_hssirtl_hd_altpe3_hip_core.altpcie_pipe.twentynm_hssirtl_hd_altpe3_dl.ack_snd_upfc            ),
        .snd_upfc      (wys.twentynm_hssi_gen3_x8_pcie_hip_encrypted_inst.hd_altpe3_hip_core_top_inst.twentynm_hssirtl_hd_altpe3_hip_core.altpcie_pipe.twentynm_hssirtl_hd_altpe3_dl.snd_upfc                ),
        .ack_req_upfc  (wys.twentynm_hssi_gen3_x8_pcie_hip_encrypted_inst.hd_altpe3_hip_core_top_inst.twentynm_hssirtl_hd_altpe3_hip_core.altpcie_pipe.twentynm_hssirtl_hd_altpe3_dl.ack_req_upfc            ),
        .ack_upfc      (wys.twentynm_hssi_gen3_x8_pcie_hip_encrypted_inst.hd_altpe3_hip_core_top_inst.twentynm_hssirtl_hd_altpe3_hip_core.altpcie_pipe.twentynm_hssirtl_hd_altpe3_dl.ack_upfc                ),
        .typ_upfc      (wys.twentynm_hssi_gen3_x8_pcie_hip_encrypted_inst.hd_altpe3_hip_core_top_inst.twentynm_hssirtl_hd_altpe3_hip_core.altpcie_pipe.twentynm_hssirtl_hd_altpe3_dl.typ_upfc                ),
        .vcid_upfc     (wys.twentynm_hssi_gen3_x8_pcie_hip_encrypted_inst.hd_altpe3_hip_core_top_inst.twentynm_hssirtl_hd_altpe3_hip_core.altpcie_pipe.twentynm_hssirtl_hd_altpe3_dl.vcid_upfc               ),
        .hdr_upfc      (wys.twentynm_hssi_gen3_x8_pcie_hip_encrypted_inst.hd_altpe3_hip_core_top_inst.twentynm_hssirtl_hd_altpe3_hip_core.altpcie_pipe.twentynm_hssirtl_hd_altpe3_dl.hdr_upfc                ),
        .data_upfc     (wys.twentynm_hssi_gen3_x8_pcie_hip_encrypted_inst.hd_altpe3_hip_core_top_inst.twentynm_hssirtl_hd_altpe3_hip_core.altpcie_pipe.twentynm_hssirtl_hd_altpe3_dl.data_upfc               ),
        .val_upfc      (wys.twentynm_hssi_gen3_x8_pcie_hip_encrypted_inst.hd_altpe3_hip_core_top_inst.twentynm_hssirtl_hd_altpe3_hip_core.altpcie_pipe.twentynm_hssirtl_hd_altpe3_dl.val_upfc                ),
        .tx_ack_nak    (wys.twentynm_hssi_gen3_x8_pcie_hip_encrypted_inst.hd_altpe3_hip_core_top_inst.twentynm_hssirtl_hd_altpe3_hip_core.altpcie_pipe.twentynm_hssirtl_hd_altpe3_dl.tx_ack_nak              ),
        .tx_req_nak    (wys.twentynm_hssi_gen3_x8_pcie_hip_encrypted_inst.hd_altpe3_hip_core_top_inst.twentynm_hssirtl_hd_altpe3_hip_core.altpcie_pipe.twentynm_hssirtl_hd_altpe3_dl.tx_req_nak              ),
        .tx_val_seqnum (wys.twentynm_hssi_gen3_x8_pcie_hip_encrypted_inst.hd_altpe3_hip_core_top_inst.twentynm_hssirtl_hd_altpe3_hip_core.altpcie_pipe.twentynm_hssirtl_hd_altpe3_dl.tx_val_seqnum           ),
        .tx_snd_nak    (wys.twentynm_hssi_gen3_x8_pcie_hip_encrypted_inst.hd_altpe3_hip_core_top_inst.twentynm_hssirtl_hd_altpe3_hip_core.altpcie_pipe.twentynm_hssirtl_hd_altpe3_dl.tx_snd_nak              ),
        .tx_res_nak    (wys.twentynm_hssi_gen3_x8_pcie_hip_encrypted_inst.hd_altpe3_hip_core_top_inst.twentynm_hssirtl_hd_altpe3_hip_core.altpcie_pipe.twentynm_hssirtl_hd_altpe3_dl.tx_res_nak              ),
        .tx_num_nak    (wys.twentynm_hssi_gen3_x8_pcie_hip_encrypted_inst.hd_altpe3_hip_core_top_inst.twentynm_hssirtl_hd_altpe3_hip_core.altpcie_pipe.twentynm_hssirtl_hd_altpe3_dl.tx_seqnum_nak           ),
        .tx_req_pm     (wys.twentynm_hssi_gen3_x8_pcie_hip_encrypted_inst.hd_altpe3_hip_core_top_inst.twentynm_hssirtl_hd_altpe3_hip_core.altpcie_pipe.twentynm_hssirtl_hd_altpe3_dl.tx_req_pm               ),
        .tx_ack_pm     (wys.twentynm_hssi_gen3_x8_pcie_hip_encrypted_inst.hd_altpe3_hip_core_top_inst.twentynm_hssirtl_hd_altpe3_hip_core.altpcie_pipe.twentynm_hssirtl_hd_altpe3_dl.tx_ack_pm               ),
        .tx_typ_pm     (wys.twentynm_hssi_gen3_x8_pcie_hip_encrypted_inst.hd_altpe3_hip_core_top_inst.twentynm_hssirtl_hd_altpe3_hip_core.altpcie_pipe.twentynm_hssirtl_hd_altpe3_dl.tx_typ_pm               ),
        .k_gbl         (wys.twentynm_hssi_gen3_x8_pcie_hip_encrypted_inst.hd_altpe3_hip_core_top_inst.twentynm_hssirtl_hd_altpe3_hip_core.altpcie_pipe.twentynm_hssirtl_hd_altpe3_dl.k_gbl                   ),
        .clk           (wys.twentynm_hssi_gen3_x8_pcie_hip_encrypted_inst.hd_altpe3_hip_core_top_inst.twentynm_hssirtl_hd_altpe3_hip_core.altpcie_pipe.twentynm_hssirtl_hd_altpe3_dl.clk                     ),
        .rstn          (wys.twentynm_hssi_gen3_x8_pcie_hip_encrypted_inst.hd_altpe3_hip_core_top_inst.twentynm_hssirtl_hd_altpe3_hip_core.altpcie_pipe.twentynm_hssirtl_hd_altpe3_dl.rstn                    ),
        .srst          (wys.twentynm_hssi_gen3_x8_pcie_hip_encrypted_inst.hd_altpe3_hip_core_top_inst.twentynm_hssirtl_hd_altpe3_hip_core.altpcie_pipe.twentynm_hssirtl_hd_altpe3_dl.srst                    )
        );
`endif
// synthesis translate_on

// synthesis translate_off
   wire open_locked;
   wire open_fbclkout;

   generic_pll #        ( .reference_clock_frequency(pll_refclk_freq), .output_clock_frequency("250.0 MHz") )
      refclk_to_250mhz      ( .refclk(refclk), .outclk(clk250_out), .locked(open_locked),    .fboutclk(open_fbclkout), .rst(1'b0), .fbclk(fbclkout));

   generic_pll #        ( .reference_clock_frequency(pll_refclk_freq), .output_clock_frequency("500.0 MHz") )
      pll_100mhz_to_500mhz      ( .refclk(refclk), .outclk(clk500_out), .locked(open_locked),    .fboutclk(open_fbclkout), .rst(1'b0), .fbclk(fbclkout));
// synthesis translate_on

   assign serdes_rx_signaldetect = ((LANES==1)?{7'h00,int_sigdet[LANES-1:0]}:(LANES==2)?{6'h00,int_sigdet[LANES-1:0]}:(LANES==4)?{4'h0, int_sigdet[LANES-1:0]}:int_sigdet[LANES-1:0]);

   generate begin :g_inspector
      if ((TLP_INSPECTOR==1)||(inspector_enable==1)) begin : g_insp
               altpcie_tlp_inspector_a10 # (
               .ST_DATA_WIDTH       (ST_DATA_WIDTH   ),
               .ST_BE_WIDTH         (ST_BE_WIDTH     ),
               .ST_CTRL_WIDTH       (ST_CTRL_WIDTH   ),
               .LANES               (LANES           ),
               .USE_SIGNAL_PROBE    (TLP_INSPECTOR_USE_SIGNAL_PROBE),
               .POWER_UP_TRIGGER    (TLP_INSPECTOR_POWER_UP_TRIGGER),
               .USE_ADME            (inspector_enable),
               .PLD_CLK_IS_250MHZ   (PLD_CLK_IS_250MHZ)
            ) altpcie_tlp_inspector (
                  .rx_st_be                        (rx_st_be   [ST_BE_WIDTH-1 : 0]   ),
                  .rx_st_data                      (rx_st_data [ST_DATA_WIDTH-1 : 0] ),
                  .rx_st_empty                     (rx_st_empty[1 : 0]               ),
                  .rx_st_eop                       (rx_st_eop  [ST_CTRL_WIDTH-1 : 0] ),
                  .rx_st_sop                       (rx_st_sop  [ST_CTRL_WIDTH-1 : 0] ),
                  .rx_st_valid                     (rx_st_valid[ST_CTRL_WIDTH-1 : 0] ),
                  .rx_st_ready                     (rx_st_ready                      ),
                  .tx_st_data                      (tx_st_data [ST_DATA_WIDTH-1 : 0] ),
                  .tx_st_empty                     (tx_st_empty[1 :0]                ),
                  .tx_st_eop                       (tx_st_eop  [ST_CTRL_WIDTH-1 :0]  ),
                  .tx_st_sop                       (tx_st_sop  [ST_CTRL_WIDTH-1 :0]  ),
                  .tx_st_valid                     (tx_st_valid                      ),
                  .tx_st_ready                     (tx_st_ready                      ),
                  .ev128ns                         (ev128ns                          ),
                  .lane_act                        (lane_act                         ),
                  .ltssmstate                      (ltssmstate                       ),
                  .rate                            (rate                             ),
                  .signaldetect                    (serdes_rx_signaldetect           ),
                  .is_lockedtodata                 (serdes_rx_is_lockedtodata        ),
                  .npor_perstn                     (npor_sync                    ),
                  .ev1us                           (ev1us                            ),
                  .csebrddata                      (tlp_inspect_i_csebrddata         ),
                  .csebrdresponse                  (tlp_inspect_i_csebrdresponse     ),
                  .csebwaitrequest                 (tlp_inspect_i_csebwaitrequest    ),
                  .csebwrresponse                  (tlp_inspect_i_csebwrresponse     ),
                  .csebwrrespvalid                 (tlp_inspect_i_csebwrrespvalid    ),
                  .csebaddr                        (csebaddr                         ),
                  .csebbe                          (csebbe                           ),
                  .csebisshadow                    (csebisshadow                     ),
                  .csebrden                        (csebrden                         ),
                  .csebwrdata                      (csebwrdata                       ),
                  .csebwren                        (csebwren                         ),
                  .csebwrrespreq                   (csebwrrespreq                    ),

                  .avmm_thinmaster_write           (avmm_thinmaster_write         ),  //     | _______________________________|//
                  .avmm_thinmaster_address         (avmm_thinmaster_address       ),  //     |                   | Offset 48h |//
                  .avmm_thinmaster_writedata       (avmm_thinmaster_writedata     ),  //     | AVMM thin Master  |____________|//
                  .avmm_thinmaster_byteenable      (avmm_thinmaster_byteenable    ),  //     | [15:0]  data                   |//
                  .avmm_thinmaster_read            (avmm_thinmaster_read          ),  //     | [23:16] Address                |//
                  .avmm_thinmaster_waitrequest     (avmm_thinmaster_waitrequest   ),  //     | [24]    ReadReq                |//
                  .avmm_thinmaster_readdata        (avmm_thinmaster_readdata      ),  //     | [25]    WriteReq               |//
                  .avmm_thinmaster_readdatavalid   (avmm_thinmaster_readdatavalid ),  //     | [31:26] Reserved               |//

                  //To Toolkit
                  .trigger                         ((inspector_enable==1)?tlp_inspect_trigger:TLP_INSPECTOR_POWER_UP_TRIGGER), // input
                  .monitor_data                    (tlp_inspector_monitor_data  ), // Output
                  .monitor_addr                    ((inspector_enable==1)?tlp_inspector_monitor_addr:8'h0  ), // Input
                  .monitor_fifo_pop                ((inspector_enable==1)?tlp_inspector_monitor_fifo_pop:1'h0  ), // Input
                  .clk                             (pld_clk),
                  .sclr                            (reset_status)
                  );
      end
      else begin : g_ninsp
         assign tlp_inspect_trigger             = 128'h0;
         assign tlp_inspector_monitor_data      = 32'h0     ;
         assign tlp_inspector_monitor_addr      = 8'h0      ;
         assign tlp_inspector_monitor_fifo_pop  = 1'h0      ;

         assign tlp_inspect_i_csebrddata        = 32'h0;
         assign tlp_inspect_i_csebrdresponse    = 5'h0;
         assign tlp_inspect_i_csebwaitrequest   = 1'h0;
         assign tlp_inspect_i_csebwrresponse    = 5'h0;
         assign tlp_inspect_i_csebwrrespvalid   = 1'h0;

         assign avmm_thinmaster_write           = 1'b0;
         assign avmm_thinmaster_address         = 8'h0;
         assign avmm_thinmaster_writedata       = 16'h0;
         assign avmm_thinmaster_byteenable      = 2'h0;
         assign avmm_thinmaster_read            = 1'h0;
      end
   end
   endgenerate // g_tlp_inspector





generate begin : g_pciecv

   if (PCISIG_PCIECV_TD_1_41_TLS_0_WORKAROUND==1) begin : g_pciecv
      //
      // This workaround prevents the target link speed of link control register 2 (0xB0) to be
      // incorrectly set to 0
      //
      reg [31:0]  current_tls;
      reg [4:0]   pcie_cvfix_state;

      localparam [4:0] S_IDLE       = 5'h0;
      localparam [4:0] S_READ       = 5'h1;
      localparam [4:0] S_CPL1       = 5'h2;
      localparam [4:0] S_CPL2       = 5'h3;
      localparam [4:0] S_CPL3       = 5'h4;
      localparam [4:0] S_CPL4       = 5'h5;
      localparam [4:0] S_WRITE1     = 5'h6;
      localparam [4:0] S_WRITE2     = 5'h7;
      localparam [4:0] S_WRITE3     = 5'h8;
      localparam [4:0] S_WRITE4     = 5'h9;
      localparam [4:0] S_WRITE_DONE = 5'hA;
      localparam [3:0] VALID_TLS    = 4'h3;
      localparam [3:0] INVALID_TLS  = 4'h0;

      reg  [11 : 0]       lmi_pciecv_addr;
      reg  [7  : 0]       lmi_pciecv_din ;
      reg                 lmi_pciecv_rden;
      reg                 lmi_pciecv_wren;

      assign  lmi_wpciecv_addr[11 : 0]=lmi_pciecv_addr [11 : 0];
      assign  lmi_wpciecv_din [7  : 0]=lmi_pciecv_din  [7  : 0];
      assign  lmi_wpciecv_rden        =lmi_pciecv_rden         ;
      assign  lmi_wpciecv_wren        =lmi_pciecv_wren         ;

      // synthesis translate_off
      initial begin
         lmi_pciecv_addr = 12'h0;
         lmi_pciecv_din  = 8'h0;
         lmi_pciecv_rden = 1'h0;
         lmi_pciecv_wren = 11'h0;
      end
      // synthesis translate_on
      always @(posedge pld_clk or posedge reset_status) begin
         if (reset_status==1'b1) begin
            pcie_cvfix_state             <= S_IDLE;
            current_tls       <= {28'h0, VALID_TLS};
            lmi_pciecv_addr   <= 12'h0;
            lmi_pciecv_din    <= 8'h0;
            lmi_pciecv_rden   <= 1'h0;
            lmi_pciecv_wren   <= 1'h0;
         end
         else begin

            lmi_pciecv_addr <= 12'hb0;

            case (pcie_cvfix_state)

               S_IDLE: begin
                  lmi_pciecv_rden         <= 1'b0;
                  lmi_pciecv_wren         <= 1'b0;
                  current_tls             <= {28'h0, VALID_TLS};
                  pcie_cvfix_state        <= S_READ;
               end
               S_READ: begin
                  lmi_pciecv_rden         <= 1'b1;
                  lmi_pciecv_wren         <= 1'b0;
                  pcie_cvfix_state        <= S_CPL1;
               end
               S_CPL1: begin
                  lmi_pciecv_wren         <= 1'b0;
                  lmi_pciecv_rden         <= 1'b0;
                  if (lmi_ack) begin
                     current_tls[7:0]     <= lmi_dout;
                     pcie_cvfix_state     <= S_CPL2;
                  end
               end
               S_CPL2: begin
                     lmi_pciecv_wren      <= 1'b0;
                     lmi_pciecv_rden      <= 1'b0;
                     current_tls[15:8]    <= lmi_dout;
                     pcie_cvfix_state     <= S_CPL3;
               end
               S_CPL3: begin
                     lmi_pciecv_wren      <= 1'b0;
                     lmi_pciecv_rden      <= 1'b0;
                     current_tls[23:16]   <= lmi_dout;
                     pcie_cvfix_state     <= S_CPL4;
               end
               S_CPL4: begin
                     lmi_pciecv_wren      <= 1'b0;
                     lmi_pciecv_rden      <= 1'b0;
                     current_tls[31:24]   <= lmi_dout;
                     if (current_tls[3:0] == INVALID_TLS) begin
                        pcie_cvfix_state  <= S_WRITE1;
                        current_tls[3:0]  <= VALID_TLS;
                     end
                     else begin
                        pcie_cvfix_state  <= S_IDLE;
                     end
               end
               S_WRITE1: begin
                  lmi_pciecv_wren   <= 1'b1;
                  lmi_pciecv_rden   <= 1'b0;
                  lmi_pciecv_din    <= current_tls[7:0];
                  pcie_cvfix_state             <= S_WRITE2;
               end
               S_WRITE2: begin
                  lmi_pciecv_wren   <= 1'b0;
                  lmi_pciecv_rden   <= 1'b0;
                  lmi_pciecv_din    <= current_tls[15:8];
                  pcie_cvfix_state             <= S_WRITE3;
               end
               S_WRITE3: begin
                  lmi_pciecv_wren   <= 1'b0;
                  lmi_pciecv_rden   <= 1'b0;
                  lmi_pciecv_din    <= current_tls[23:16];
                  pcie_cvfix_state             <= S_WRITE4;
               end
               S_WRITE4: begin
                  lmi_pciecv_wren   <= 1'b0;
                  lmi_pciecv_rden   <= 1'b0;
                  lmi_pciecv_din    <= current_tls[31:24];
                  pcie_cvfix_state             <= S_WRITE_DONE;
               end
               S_WRITE_DONE: begin
                  lmi_pciecv_wren      <= 1'b0;
                  lmi_pciecv_rden      <= 1'b0;
                  if (lmi_ack) begin
                     pcie_cvfix_state  <= S_IDLE;
                  end
               end
               default: begin
                  pcie_cvfix_state  <= S_IDLE;
                  lmi_pciecv_wren   <= 1'b0;
                  lmi_pciecv_rden   <= 1'b0;
                  current_tls       <= {28'h0, VALID_TLS};
               end
            endcase
         end
      end
   end
   else begin
      assign  lmi_wpciecv_addr[11 : 0]=ZEROS [11 : 0];
      assign  lmi_wpciecv_din [7  : 0]=ZEROS [7  : 0];
      assign  lmi_wpciecv_rden        =ZEROS [0]     ;
      assign  lmi_wpciecv_wren        =ZEROS [0]     ;
   end
end
endgenerate

localparam core_clk_freq_mhz_int  = low_str(core_clk_freq_mhz) ;
    //********************************************************************
    // Declare Variables -
    //********************************************************************
    //Regs/Wires
   //Two lanes are decoded at a time using test_out. 4 cycles are needed to
    //cover all 8 lanes

    //Lane 0
        wire dbg_rx_valid ;
        wire dbg_rx_valid_sync;
        reg [32:0] dbg_rx_data_reg  ;
        reg [3:0]  dbg_rx_datak_reg ;
        reg [32:0] dbg_rx_data_reg2_odd  ;
        reg [3:0]  dbg_rx_datak_reg2_odd ;
        reg [32:0] dbg_rx_data_reg2_even ;
        reg [3:0]  dbg_rx_datak_reg2_even;
        wire dbg_rx_polarity  ;
        wire dbg_rx_polarity_even ;
        wire dbg_rx_polarity_odd  ;
        wire dbg_rx_polarity_even_done ;
        wire dbg_rx_polarity_odd_done  ;
        wire dbg_rx_polarity_done  ;

    //Lane 1
        wire dbg_rx_valid_1 ;
        wire dbg_rx_valid_sync_1;
        reg [32:0] dbg_rx_data_reg_1  ;
        reg [3:0]  dbg_rx_datak_reg_1 ;
        reg [32:0] dbg_rx_data_reg2_odd_1  ;
        reg [3:0]  dbg_rx_datak_reg2_odd_1 ;
        reg [32:0] dbg_rx_data_reg2_even_1 ;
        reg [3:0]  dbg_rx_datak_reg2_even_1;
        wire dbg_rx_polarity_1  ;
        wire dbg_rx_polarity_even_1 ;
        wire dbg_rx_polarity_odd_1  ;
        wire dbg_rx_polarity_even_done_1 ;
        wire dbg_rx_polarity_odd_done_1  ;
        wire dbg_rx_polarity_done_1  ;


        integer j;
        reg [1:0] count ;
        reg [7:0]  dbg_pld_rx_polinv_done_all_ln ;
        reg [2:0]  dbg_srst;
        reg [8:0] dbg_timeout_counter ;
        reg       dbg_avmm_timeout    ;
        reg [9:0] dbg_avmm_timeout_count ;
        reg dbg_1us_timeout ;
        reg [4:0] dbg_ltssmstate_reg ;


        reg [7:0] dbg_reconfig_avmm_next_state;
        reg [7:0] dbg_reconfig_avmm_state;
        reg [31:0] dbg_reconfig_avmm_readdata;


        wire dbg_rx_dyn_polinv_reconfig_reset_int;
        reg dbg_rx_dyn_polinv_reconfig_reset_int_r;
        wire dbg_reconfig_avmm_write  ;
        reg dbg_reconfig_avmm_write_done  ;
        reg dbg_reconfig_avmm_check_done  ;
        wire dbg_reconfig_avmm_read   ;
        wire dbg_reconfig_avmm_readdone   ;
        wire dbg_reconfig_avmm_idle   ;
        wire dbg_reconfig_avmm_check  ;
	    wire dbg_reconfig_avmm_non_RevD_chk_idle;
	    wire dbg_reconfig_avmm_non_RevD_chk_read;
	    wire dbg_non_RevD_det_sync;

        reg     [2:0]         avmm_lane_num_done ;
        reg     [LANES-1:0]        avmm_lanes_done ;
	    reg                   dbg_non_RevD_detected;
        reg     [11:0]        time_cnt_10us ;

        localparam dbg_timeout_limit = ( core_clk_freq_mhz_int == "core_clk_250mhz" ) ? 9'h0FA : 9'h07D; //1us timeout counter

        //AVMM State Machine States

        localparam DBG_AVMM_NON_REVD_CHK_IDLE     = 8'b01000000;
        localparam DBG_AVMM_NON_REVD_CHK_READ     = 8'b10000000;
	    localparam DBG_AVMM_IDLE                  = 8'b00000001;
        localparam DBG_AVMM_READ                  = 8'b00000010;
        localparam DBG_AVMM_READDONE              = 8'b00000100;
        localparam DBG_AVMM_WRITE                 = 8'b00001000;
        localparam DBG_AVMM_CHECK                 = 8'b00010000;
        localparam DBG_AVMM_DONE                  = 8'b00100000;

generate begin : rx_polinv_dbg

    if ( (( core_clk_freq_mhz_int == "core_clk_250mhz" ) || ( core_clk_freq_mhz_int == "core_clk_125mhz" ) ) && rx_polinv_soft_logic_enable == 1'b1 )begin




/**********************************************
//Reconfig Logic to change hssi_rx_pcs_pma_interface_rx_dyn_polarity_inversion bit setting to rx_dyn_polinv_en
***********************************************/
    assign dbg_rx_dyn_polinv_reconfig_clk = serdes_fixedclk;
    //assign dbg_rx_dyn_polinv_reconfig_reset_int  = ~npor_int;


    //Synchronize reset
    //always @ (posedge dbg_rx_dyn_polinv_reconfig_clk or posedge  dbg_rx_dyn_polinv_reconfig_reset_int)
    //begin
    //     if (dbg_rx_dyn_polinv_reconfig_reset_int) begin
    //
    //           dbg_rx_dyn_polinv_reconfig_reset_int_r  <= 1'b1 ;
    //           dbg_rx_dyn_polinv_reconfig_reset        <= 1'b1 ;
    //     end
    //     else begin
    //
    //           dbg_rx_dyn_polinv_reconfig_reset_int_r <= dbg_rx_dyn_polinv_reconfig_reset_int ;
    //           dbg_rx_dyn_polinv_reconfig_reset <= dbg_rx_dyn_polinv_reconfig_reset_int_r ;
    //     end
    //end

	 // Base on reset_status_hip instead since the hot reset decode is from the hip itself and not the pins (perst + npor)
	 // This allows the IP to be reset by PERST, NPOR, or hot reset
	altpcie_reset_delay_sync #(
		.ACTIVE_RESET           (1),
		.WIDTH_RST              (1),
		.NODENAME               ("polinv_reconfig_reset_bitsync"),
		.LOCK_TIME_CNT_WIDTH    (1)
	) polinv_reconfig_reset_bitsync(
		.clk         (dbg_rx_dyn_polinv_reconfig_clk),
		.async_rst   (reset_status_hip),
		.sync_rst    (dbg_rx_dyn_polinv_reconfig_reset)
	);

      always @ (posedge dbg_rx_dyn_polinv_reconfig_clk or posedge dbg_rx_dyn_polinv_reconfig_reset) begin
        if (dbg_rx_dyn_polinv_reconfig_reset == 1'b1)
           time_cnt_10us <= 10'h0;
        else
	   if (time_cnt_10us[10] == 1'b0)
	       time_cnt_10us <= time_cnt_10us + 1'b1;
      end


    always @ (posedge dbg_rx_dyn_polinv_reconfig_clk or posedge  dbg_rx_dyn_polinv_reconfig_reset)
    begin
         if (dbg_rx_dyn_polinv_reconfig_reset) begin
             dbg_reconfig_avmm_state = DBG_AVMM_NON_REVD_CHK_IDLE;
         end
         else begin
            dbg_reconfig_avmm_state = dbg_reconfig_avmm_next_state;
         end

    end

//Reconfig AVMM State Machine
    always @*
    begin
        case (dbg_reconfig_avmm_state)

            DBG_AVMM_NON_REVD_CHK_IDLE :
                if ( dbg_rx_dyn_polinv_reconfig == 1'b0 )
                         dbg_reconfig_avmm_next_state = DBG_AVMM_NON_REVD_CHK_IDLE;
                else  if (time_cnt_10us[10] == 1'b1)
                         dbg_reconfig_avmm_next_state = DBG_AVMM_NON_REVD_CHK_READ;
                else
                         dbg_reconfig_avmm_next_state = DBG_AVMM_NON_REVD_CHK_IDLE;


            DBG_AVMM_NON_REVD_CHK_READ :
                if ( dbg_rx_dyn_polinv_reconfig == 1'b0 )
                         dbg_reconfig_avmm_next_state = DBG_AVMM_NON_REVD_CHK_IDLE;
                else if (dbg_rx_dyn_polinv_reconfig_waitrequest == 1'b1 )
                         dbg_reconfig_avmm_next_state = DBG_AVMM_NON_REVD_CHK_READ;
                else
                         dbg_reconfig_avmm_next_state = DBG_AVMM_IDLE;


            DBG_AVMM_IDLE :
                if ( dbg_rx_dyn_polinv_reconfig == 1'b0 || avmm_lanes_done[LANES-1:0] == {LANES{1'b1}}  || dbg_non_RevD_detected == 1'b1)
                         dbg_reconfig_avmm_next_state = DBG_AVMM_IDLE;
                else
                         dbg_reconfig_avmm_next_state = DBG_AVMM_READ;

            DBG_AVMM_READ :
                if ( dbg_rx_dyn_polinv_reconfig == 1'b0 )
                         dbg_reconfig_avmm_next_state = DBG_AVMM_IDLE;
                else if (dbg_rx_dyn_polinv_reconfig_waitrequest == 1'b1 )
                         dbg_reconfig_avmm_next_state = DBG_AVMM_READ;
                else
                         dbg_reconfig_avmm_next_state = DBG_AVMM_READDONE;

            DBG_AVMM_READDONE :
                if ( dbg_rx_dyn_polinv_reconfig == 1'b0 )
                         dbg_reconfig_avmm_next_state = DBG_AVMM_IDLE;
                else if (dbg_reconfig_avmm_write_done ==1'b1)
                         dbg_reconfig_avmm_next_state = DBG_AVMM_CHECK ;
                else
                         dbg_reconfig_avmm_next_state = DBG_AVMM_WRITE;


            DBG_AVMM_WRITE :
                if ( dbg_rx_dyn_polinv_reconfig == 1'b0 )
                         dbg_reconfig_avmm_next_state = DBG_AVMM_IDLE;
                else if (dbg_rx_dyn_polinv_reconfig_waitrequest == 1'b1 )
                         dbg_reconfig_avmm_next_state = DBG_AVMM_WRITE;
                else
                         dbg_reconfig_avmm_next_state = DBG_AVMM_READ;

            DBG_AVMM_CHECK :
                if ( dbg_rx_dyn_polinv_reconfig == 1'b0 || dbg_avmm_timeout ==1'b1 )
                         dbg_reconfig_avmm_next_state = DBG_AVMM_IDLE;
                else if (!dbg_reconfig_avmm_check_done)
                         dbg_reconfig_avmm_next_state = DBG_AVMM_CHECK ;
                else
                         dbg_reconfig_avmm_next_state = DBG_AVMM_DONE ;

            DBG_AVMM_DONE :
                if ( dbg_rx_dyn_polinv_reconfig == 1'b0 )
                         dbg_reconfig_avmm_next_state = DBG_AVMM_IDLE;
                else if  (avmm_lanes_done[LANES-1:0] != {LANES{1'b1}})
                         dbg_reconfig_avmm_next_state = DBG_AVMM_READ;
                else
                         dbg_reconfig_avmm_next_state = DBG_AVMM_IDLE;

             default :
                         dbg_reconfig_avmm_next_state = DBG_AVMM_IDLE;
        endcase
    end

    //State Machine States
    assign dbg_reconfig_avmm_non_RevD_chk_idle        = (dbg_reconfig_avmm_state == DBG_AVMM_NON_REVD_CHK_IDLE );
    assign dbg_reconfig_avmm_non_RevD_chk_read        = (dbg_reconfig_avmm_state == DBG_AVMM_NON_REVD_CHK_READ );


    assign dbg_reconfig_avmm_write     = (dbg_reconfig_avmm_state == DBG_AVMM_WRITE );
    assign dbg_reconfig_avmm_read      = (dbg_reconfig_avmm_state == DBG_AVMM_READ  );
    assign dbg_reconfig_avmm_readdone  = (dbg_reconfig_avmm_state == DBG_AVMM_READDONE  );
    assign dbg_reconfig_avmm_idle      = (dbg_reconfig_avmm_state == DBG_AVMM_IDLE  );
    assign dbg_reconfig_avmm_check     = (dbg_reconfig_avmm_state == DBG_AVMM_CHECK );

    //Read and Write Control Signals
    assign  dbg_rx_dyn_polinv_reconfig_read         =  dbg_reconfig_avmm_read  || dbg_reconfig_avmm_non_RevD_chk_read;
    assign  dbg_rx_dyn_polinv_reconfig_write        =  dbg_reconfig_avmm_write ;
    assign  dbg_rx_dyn_polinv_reconfig_readdata     =  xcvr_reconfig_readdata_int    ;
    assign  dbg_rx_dyn_polinv_reconfig_waitrequest  =  xcvr_reconfig_waitrequest_int ;

    assign xcvr_reconfig_readdata = dbg_rx_dyn_polinv_reconfig_reset ? 32'h0000_0000 : dbg_rx_dyn_polinv_reconfig ?  32'h0000_0000 : xcvr_reconfig_readdata_int   ;
    assign xcvr_reconfig_waitrequest  = dbg_rx_dyn_polinv_reconfig_reset ? 1'b1 : dbg_rx_dyn_polinv_reconfig ? 1'b1 : xcvr_reconfig_waitrequest_int    ;



    always @ (posedge dbg_rx_dyn_polinv_reconfig_clk or posedge  dbg_rx_dyn_polinv_reconfig_reset)
    begin
         if (dbg_rx_dyn_polinv_reconfig_reset) begin
             dbg_rx_dyn_polinv_reconfig            <= 1'b1;
             dbg_reconfig_avmm_write_done          <=1'b0;
             dbg_reconfig_avmm_check_done          <=1'b0;
             dbg_reconfig_avmm_readdata            <= 32'h0000_0000;
             dbg_rx_dyn_polinv_reconfig_writedata  <= 32'h0000_0000;
             //dbg_rx_dyn_polinv_reconfig_address    <= 13'b0_0000_0000_1011;
			 dbg_rx_dyn_polinv_reconfig_address    <= 13'b0_0001_0000_0011;
             avmm_lane_num_done <= 3'b000;
             avmm_lanes_done <= 7'b0000000;
             dbg_avmm_timeout <= 1'b0;
             dbg_avmm_timeout_count <= 10'h000;

			 dbg_non_RevD_detected <= 1'b0;

         end
         else if (avmm_lanes_done[LANES-1:0] == {LANES{1'b1}} )
                    dbg_rx_dyn_polinv_reconfig            <= 1'b0;
	     else if (dbg_reconfig_avmm_non_RevD_chk_read ) begin
	            if (dbg_rx_dyn_polinv_reconfig_waitrequest == 1'b0) begin
		            dbg_non_RevD_detected <= dbg_rx_dyn_polinv_reconfig_readdata[5];
                    dbg_rx_dyn_polinv_reconfig_address    <= 13'b0_0000_0000_1011;
	            end
	     end
         else if (dbg_reconfig_avmm_read) begin
                    dbg_reconfig_avmm_check_done          <=1'b0;

                     if (  dbg_rx_dyn_polinv_reconfig_waitrequest == 1'b0)
                            dbg_reconfig_avmm_readdata <= dbg_rx_dyn_polinv_reconfig_readdata;
                     end
         else if  (dbg_reconfig_avmm_readdone) begin
                dbg_rx_dyn_polinv_reconfig_writedata  <= dbg_reconfig_avmm_readdata | 32'h0000_0001 ;
         end
         else if  (dbg_reconfig_avmm_write) begin
                if (  dbg_rx_dyn_polinv_reconfig_waitrequest == 1'b0)
                      dbg_reconfig_avmm_write_done <=1'b1;
         end
         else if  (dbg_reconfig_avmm_check) begin
                if ( dbg_reconfig_avmm_readdata[0] == 1'b1) begin
                    dbg_reconfig_avmm_check_done          <=1'b1;
                    dbg_reconfig_avmm_write_done <=1'b0;
                end
                if (dbg_reconfig_avmm_check_done == 1'b1) begin
                    dbg_rx_dyn_polinv_reconfig_address    <= dbg_rx_dyn_polinv_reconfig_address  + 13'b0_0100_0000_0000;
                    avmm_lane_num_done <= avmm_lane_num_done+1'b1;
                    avmm_lanes_done[avmm_lane_num_done] <= 1'b1;
                    dbg_avmm_timeout_count <= 10'h000;
                end
                else begin
                     dbg_avmm_timeout_count <= dbg_avmm_timeout_count + 10'h001;
                     if (dbg_avmm_timeout_count == 10'h3E8 ) begin  //10us timeout
                           dbg_avmm_timeout <= 1'b1;
                     end


                end
         end
         else if ( dbg_reconfig_avmm_idle ) begin
             dbg_reconfig_avmm_write_done          <=1'b0;
             dbg_reconfig_avmm_check_done          <=1'b0;
             dbg_reconfig_avmm_readdata            <= 32'h0000_0000;
             dbg_rx_dyn_polinv_reconfig_writedata  <= 32'h0000_0000;
			 dbg_rx_dyn_polinv_reconfig_address    <= 13'b0_0000_0000_1011;
             dbg_avmm_timeout <= 1'b0;
             dbg_avmm_timeout_count <= 10'h000;
         end





     end

    always @ *
    begin
       if (dbg_ltssmstate_reg == 5'b00010 || dbg_ltssmstate_reg == 5'b00100 )
          case (j[3:0] )
                0:
                   dbg_test_in_1_hip = 32'h00000000;

                2:
                   dbg_test_in_1_hip = 32'h00000001;

                4:
                   dbg_test_in_1_hip = 32'h00000002;

                6:
                   dbg_test_in_1_hip = 32'h00000003;

                15:
                   dbg_test_in_1_hip = 32'h00008020;
                default :
                   dbg_test_in_1_hip = 32'h00000000;
            endcase
       else
          dbg_test_in_1_hip = test_in[63:32];
    end


    //********************************************************************
    //Synchronizer for rx_valid obtained from test_out to pld_clk
    //********************************************************************
        assign dbg_rx_valid = test_out[86];
           altpcie_sc_bitsync_node #(
              .DWIDTH    (1), // Sync Data input
              .SYNCSTAGE (2), // Sync stages
              .SDC_TYPE  (0), // 0: Multi Cycle=3, 1:Multi Cycle=2, 2: Set False Path
              .NODENAME  ("dbg_rx_valid_altpcie_sc_bitsync"),
              .RESET_VAL (0)  // Reset value
            ) dbg_rx_valid_altpcie_sc_bitsync (
              .clk       (pld_clk) ,// clock
              .rst_n     (npor_sync) ,// async reset
              .data_in   (dbg_rx_valid) ,// data in
              .data_out  (dbg_rx_valid_sync) // data out
           );


        assign dbg_rx_valid_1  = test_out[246];
           altpcie_sc_bitsync_node #(
              .DWIDTH    (1), // Sync Data input
              .SYNCSTAGE (2), // Sync stages
              .SDC_TYPE  (0), // 0: Multi Cycle=3, 1:Multi Cycle=2, 2: Set False Path
              .NODENAME  ("dbg_rx_valid_1_altpcie_sc_bitsync"),
              .RESET_VAL (0)  // Reset value
            ) dbg_rx_valid_1_altpcie_sc_bitsync (
              .clk       (pld_clk) ,// clock
              .rst_n     (npor_sync) ,// async reset
              .data_in   (dbg_rx_valid_1 ) ,// data in
              .data_out  (dbg_rx_valid_sync_1 ) // data out
           );


           altpcie_sc_bitsync_node #(
              .DWIDTH    (1), // Sync Data input
              .SYNCSTAGE (2), // Sync stages
              .SDC_TYPE  (2), // 0: Multi Cycle=3, 1:Multi Cycle=2, 2: Set False Path
              .NODENAME  ("dbg_non_RevD_det_altpcie_sync"),
              .RESET_VAL (0)  // Reset value
            ) dbg_non_RevD_det_altpcie_sync(
              .clk       (pld_clk) ,// clock
              .rst_n     (npor_sync) ,// async reset
              .data_in   (dbg_non_RevD_detected) ,// data in
              .data_out  (dbg_non_RevD_det_sync) // data out
           );


    //********************************************************************
    // Timeout counter
    //********************************************************************
        always @ (posedge pld_clk or negedge npor_sync)
        begin
                if ( !npor_sync ) begin
                     dbg_timeout_counter <=9'h000;
                     dbg_1us_timeout <= 1'b0;

                end
                else if ( dbg_srst[2] ) begin
                     dbg_timeout_counter <=9'h000;
                     dbg_1us_timeout <= 1'b0;

                end
                else begin
                     if ( dbg_timeout_counter < dbg_timeout_limit) begin
                        dbg_timeout_counter <= dbg_timeout_counter + 9'h001;
                        dbg_1us_timeout <= 1'b0;
                     end
                     else begin
                        dbg_1us_timeout <= 1'b1;
                        dbg_timeout_counter <=9'h000;
                     end

                end
         end



    //********************************************************************
    //Register ltssmstate . To meet timing
    //********************************************************************
        always @ (posedge pld_clk or negedge npor_sync)
        begin
            if ( !npor_sync ) begin
               dbg_ltssmstate_reg <= 5'h00;

            end
            else begin
               dbg_ltssmstate_reg <= ltssmstate ;
            end
       end

        always @ (posedge pld_clk or negedge npor_sync)
        begin
                if ( !npor_sync ) begin
                        dbg_rx_data_reg  <= 32'h0000_0000;
                        dbg_rx_datak_reg <= 4'h0;
                        dbg_rx_data_reg_1  <= 32'h0000_0000;
                        dbg_rx_datak_reg_1 <= 4'h0;
               end
               else begin

                         dbg_rx_data_reg    <= {test_out[77:46] } ;
                         dbg_rx_datak_reg   <= {test_out[81:78] } ;
                         dbg_rx_data_reg_1  <= {test_out[237:206] } ;
                         dbg_rx_datak_reg_1 <= {test_out[241:238] } ;
               end

        end
    //********************************************************************
    //Register test_out data. Over sampling test_out data with pld_clk. Calculating rxpolarity inversion for both odd edges end even edges. OR the two rxpolarities
    //********************************************************************
        always @ (posedge pld_clk or negedge npor_sync)
        begin
                if ( !npor_sync ) begin
                        dbg_rx_data_reg2_odd  <= 32'h0000_0000;
                        dbg_rx_datak_reg2_odd <= 4'h0;
                        dbg_rx_data_reg2_even  <= 32'h0000_0000;
                        dbg_rx_datak_reg2_even <= 4'h0;
                        dbg_rx_data_reg2_odd_1  <= 32'h0000_0000;
                        dbg_rx_datak_reg2_odd_1 <= 4'h0;
                        dbg_rx_data_reg2_even_1  <= 32'h0000_0000;
                        dbg_rx_datak_reg2_even_1 <= 4'h0;
                        j<=12 ;
                        count <=2'b00;
                        dbg_srst= 3'b100;
                        dbg_pld_rx_polinv_all_ln <= 8'h00;
                        dbg_pld_rx_polinv_done_all_ln <=8'h00;

                end
                else begin
                        if ( (dbg_ltssmstate_reg  == 5'b00010 || dbg_ltssmstate_reg  == 5'b00100 ) && dbg_pld_rx_polinv_done_all_ln[LANES-1:0 ] != ONES[LANES-1:0] && dbg_non_RevD_det_sync ==1'b0)  begin
                            if (j==12 ) begin
                                 j<=0;
                                 dbg_srst <= 3'b100;
                            end
                            else begin

                               if (((core_clk_freq_mhz_int)=="core_clk_250mhz" )? (count == 2'b00) : (count[0]==1'b0)) begin
                                        dbg_rx_data_reg2_even    <= dbg_rx_data_reg;
                                        dbg_rx_datak_reg2_even   <= dbg_rx_datak_reg;
                                        dbg_rx_data_reg2_even_1  <= dbg_rx_data_reg_1;
                                        dbg_rx_datak_reg2_even_1 <= dbg_rx_datak_reg_1;
                                end
                                else if (((core_clk_freq_mhz_int)=="core_clk_250mhz") ? (count == 2'b10) : (count[0]==1'b1)) begin
                                        dbg_rx_data_reg2_odd    <= dbg_rx_data_reg;
                                        dbg_rx_datak_reg2_odd   <= dbg_rx_datak_reg;
                                        dbg_rx_data_reg2_odd_1  <= dbg_rx_data_reg_1;
                                        dbg_rx_datak_reg2_odd_1 <= dbg_rx_datak_reg_1;
                                end
                                count <= count + 2'b01;


// Cycle 2 lanes every 2us till we find 2 TS2's within 2 us.
                               if(dbg_pld_rx_polinv_done_all_ln[j] && dbg_pld_rx_polinv_done_all_ln[j+1] ) begin
                                          dbg_srst <=3'b100;
                                          if (LANES <= 2 )
                                              j<=0;
                                          else if (j<LANES - 2 )
                                                  j<=j+2;
                                                else
                                                   j<=0;

                               end
                               else if ( (dbg_1us_timeout || (dbg_rx_polarity_done && dbg_rx_polarity_done_1 ) ) && (dbg_srst == 3'b00)  ) begin
                                       dbg_srst <=3'b100;
                                       if (dbg_rx_polarity_done) begin
                                             if(dbg_rx_polarity)
                                                  dbg_pld_rx_polinv_all_ln[j] <= dbg_rx_polarity ;
                                             dbg_pld_rx_polinv_done_all_ln[j] <= dbg_rx_polarity_done ;
                                       end

                                       if (dbg_rx_polarity_done_1) begin
                                             if(dbg_rx_polarity_1)
                                                  dbg_pld_rx_polinv_all_ln[j+1] <= dbg_rx_polarity_1 ;
                                             dbg_pld_rx_polinv_done_all_ln[j+1] <= dbg_rx_polarity_done_1 ;
                                       end
                                          if (LANES <= 2 )
                                              j<=0;
                                          else if (j<LANES - 2 )
                                                  j<=j+2;
                                                else
                                                   j<=0;
                               end
                               if (dbg_srst[2])
                                     dbg_srst <=dbg_srst + 3'b001;

                               end
                        end
                        else if ( dbg_ltssmstate_reg == 5'b00001) begin  // To reset dbg_pld_rx_polinv_done_all_ln when going to Detect Active. Needed for Autonomous HIP , when software forces to go to Detect Active after fabric is alive
                            dbg_pld_rx_polinv_done_all_ln <=8'h00;
                        end
                        else begin

                        dbg_rx_data_reg2_odd  <= 32'h0000_0000;
                        dbg_rx_datak_reg2_odd <= 4'h0;
                        dbg_rx_data_reg2_even  <= 32'h0000_0000;
                        dbg_rx_datak_reg2_even <= 4'h0;
                        dbg_rx_data_reg2_odd_1   <= 32'h0000_0000;
                        dbg_rx_datak_reg2_odd_1  <= 4'h0;
                        dbg_rx_data_reg2_even_1   <= 32'h0000_0000;
                        dbg_rx_datak_reg2_even_1  <= 4'h0;
                        dbg_srst <= 3'b100 ;
                        j<=12 ;
                        end
                end
        end




        altpcie_rxpolarity_decode  # (
          .core_clk_freq_mhz                     (core_clk_freq_mhz_int)
        )  altpcie_rxpolarity_decode_even_inst
        (
        .pld_clk           (   pld_clk                       ),
        .npor_sync         (   npor_sync                     ),
        .dbg_srst              (   dbg_srst[2]                       ),
        .rxdata            (   dbg_rx_data_reg2_even         ),
        .rxdatak           (   dbg_rx_datak_reg2_even        ),
        .rxvalid           (   dbg_rx_valid_sync             ),
        .rxpolarity        (   dbg_rx_polarity_even          ),
        .rxpolarity_done   (   dbg_rx_polarity_even_done     )
        );

        altpcie_rxpolarity_decode  # (
          .core_clk_freq_mhz                     (core_clk_freq_mhz_int)
        )  altpcie_rxpolarity_decode_odd_inst
        (
        .pld_clk           (   pld_clk                       ),
        .npor_sync         (   npor_sync                     ),
        .dbg_srst              (   dbg_srst[2]                       ),
        .rxdata            (   dbg_rx_data_reg2_odd          ),
        .rxdatak           (   dbg_rx_datak_reg2_odd         ),
        .rxvalid           (   dbg_rx_valid_sync             ),
        .rxpolarity        (   dbg_rx_polarity_odd           ),
        .rxpolarity_done   (   dbg_rx_polarity_odd_done      )
        );





        altpcie_rxpolarity_decode  # (
          .core_clk_freq_mhz                     (core_clk_freq_mhz_int)
        ) altpcie_rxpolarity_decode_even_inst_1
        (
        .pld_clk           (   pld_clk                       ),
        .npor_sync         (   npor_sync                     ),
        .dbg_srst              (   dbg_srst[2]                       ),
        .rxdata            (   dbg_rx_data_reg2_even_1         ),
        .rxdatak           (   dbg_rx_datak_reg2_even_1        ),
        .rxvalid           (   dbg_rx_valid_sync_1             ),
        .rxpolarity        (   dbg_rx_polarity_even_1          ),
        .rxpolarity_done   (   dbg_rx_polarity_even_done_1     )
        );

        altpcie_rxpolarity_decode  # (
          .core_clk_freq_mhz                     (core_clk_freq_mhz_int)
        ) altpcie_rxpolarity_decode_odd_inst_1
        (
        .pld_clk           (   pld_clk                       ),
        .npor_sync         (   npor_sync                     ),
        .dbg_srst              (   dbg_srst[2]                       ),
        .rxdata            (   dbg_rx_data_reg2_odd_1          ),
        .rxdatak           (   dbg_rx_datak_reg2_odd_1         ),
        .rxvalid           (   dbg_rx_valid_sync_1             ),
        .rxpolarity        (   dbg_rx_polarity_odd_1           ),
        .rxpolarity_done   (   dbg_rx_polarity_odd_done_1      )
        );


    //When any one of the samples have indentified  TS2_P , TS2_N
        assign dbg_rx_polarity_done     = dbg_rx_polarity_odd_done || dbg_rx_polarity_even_done ;
        assign dbg_rx_polarity_done_1   = dbg_rx_polarity_odd_done_1  || dbg_rx_polarity_even_done_1 ;

        assign dbg_rx_polarity =  ( dbg_rx_polarity_even && dbg_rx_polarity_even_done )|| (dbg_rx_polarity_odd && dbg_rx_polarity_odd_done )  ;
        assign dbg_rx_polarity_1 =  ( dbg_rx_polarity_even_1 && dbg_rx_polarity_even_done_1 )|| (dbg_rx_polarity_odd_1 && dbg_rx_polarity_odd_done_1  ) ;

    end
else begin

		assign  dbg_rx_dyn_polinv_reconfig_reset  = 1'b0;

    always @*
    begin
         dbg_test_in_1_hip = test_in[63:32];
         dbg_rx_dyn_polinv_reconfig = 1'b0;
         dbg_rx_dyn_polinv_reconfig_writedata = 32'h0000_0000;
         dbg_rx_dyn_polinv_reconfig_address = {reconfig_address_width_integer_hwtcl{1'b0}};
         dbg_pld_rx_polinv_all_ln=7'h00;
         //dbg_rx_dyn_polinv_reconfig_reset   = 1'b0;
    end
    assign               dbg_rx_dyn_polinv_reconfig_clk     = 1'b0                                       ; // reconfig_clk.clk
    assign               dbg_rx_dyn_polinv_reconfig_write   = 1'b0                                       ; // reconfig_avmm.write
    assign               dbg_rx_dyn_polinv_reconfig_read    = 1'b0                                       ; // reconfig_avmm.read
    assign xcvr_reconfig_readdata     =  xcvr_reconfig_readdata_int          ;
    assign xcvr_reconfig_waitrequest  =  xcvr_reconfig_waitrequest_int       ;


end
end

endgenerate
generate
    if (enable_soft_dfe == 1) begin
    
       always @(posedge pld_clk,  negedge npor ) begin
         if (!npor) begin
          current_rate_r <= 2'b00;
          ltssm_eq_phase2_r <= 1'b0;
          ltssm_detect_quiet_r <= 1'b0;
          ltssm_detect_active_r <= 1'b0;
         end
         else begin
           current_rate_r <= currentspeed_r;
           ltssm_eq_phase2_r <= ((port_type=="root_port") ? (ltssmstate_rr == LTSSM_EQ_EQZ_PHASE_3) : (ltssmstate_rr == LTSSM_EQ_EQZ_PHASE_2));
                      
           ltssm_detect_quiet_r <= ((ltssmstate_rr == LTSSM_EQ_DET_QUIET) ? 1'b1 : 1'b0);
           ltssm_detect_active_r <= ((ltssmstate_rr == LTSSM_EQ_DET_ACT) ? 1'b1 : 1'b0);
        end 
      end
    end
endgenerate
endmodule



module altpcie_rxpolarity_decode #(
      parameter core_clk_freq_mhz                                 = "core_clk_250mhz"
)
(
input                      pld_clk,
input              npor_sync,
input              dbg_srst,
input   [31:0]     rxdata ,
input   [3:0]      rxdatak ,
input              rxvalid ,
output  reg           rxpolarity,
output  reg        rxpolarity_done
);





    localparam DWIDTH_LN_BYTES =4;
    localparam K_COM = 9'h1bc;
    localparam K_PAD = 9'h1f7;
    localparam D_TS1_P  = 9'h04a;
    localparam D_TS1_N  = 9'h0b5;
    localparam D_TS2_P  = 9'h045;
    localparam D_TS2_N  = 9'h0ba;
    localparam TS2_COUNT  = 2;


//********************************************************************
// Define Variables
//********************************************************************
//Regs/Wires
    wire                        [8:0] data_in_array [DWIDTH_LN_BYTES-1:0];
    reg                         [8:0] data_in_array_d0 [DWIDTH_LN_BYTES-1:0];
    reg                         [8:0] algn_data [DWIDTH_LN_BYTES-1:0];
    wire  [DWIDTH_LN_BYTES-1:0]       com_dec_c;
    reg   [DWIDTH_LN_BYTES-1:0]       com_dec_d0;
    wire  [DWIDTH_LN_BYTES-1:0]       com_dec_al_c;
    wire  [DWIDTH_LN_BYTES-1:0]       pad_dec_al_c;
    reg   [DWIDTH_LN_BYTES-1:0]       dat_dec_al_c;
    wire  [DWIDTH_LN_BYTES-1:0]       ts2_dec_al_c;
    wire  [DWIDTH_LN_BYTES-1:0]       polinv_dec_al_c;
    reg   [1:0]                       cpt_ts;
    reg   [8:0]                       rxsymb6;
    wire  [8:0]                       rxsymb6_i;
    reg                               rxpolinv;
    reg                               rxts2;
    reg                               rxtse;
    reg                               ts_cpl;
    wire                              ts_det;
    reg    [4:0]                      ts_count;
    reg    [7:0]                      rx_polarity_out;
    reg    [1:0]                      clk_count;
//********************************************************************
// Assign to arrays for easy data manipulation
//********************************************************************
    genvar m;
    generate
       for (m = 0; m<= (DWIDTH_LN_BYTES-1); m = m+1) begin : DATA_INOUT_ARRAY
      // Input
          assign data_in_array[m]         = rxvalid ? {rxdatak[m],rxdata[(m*8)+7:(m*8)]} : 9'd0;
       end
    endgenerate

//********************************************************************
// Decode all the bytes for K_COM for Aligning the data
//********************************************************************
    genvar n;
    generate
       for (n = 0; n<= (DWIDTH_LN_BYTES-1); n = n+1) begin : COMP_SKP_UALGN
          assign com_dec_c[n]   = (data_in_array[n] == K_COM) ? 1'b1 : 1'b0;
       end
    endgenerate


//********************************************************************
//****** TS2 Decoder
//********************************************************************
//--------------------------------------------------------------------
// Align data received so that COM twentynm_hssirtl_is always in LSB
//--------------------------------------------------------------------
    integer p;
    always @(negedge npor_sync or posedge pld_clk) begin
       if (npor_sync == 1'b0) begin
          for (p = 0; p<= (DWIDTH_LN_BYTES-1); p = p+1) begin
             data_in_array_d0[p]  <= 9'd0;
          end
          com_dec_d0        <= 4'd0;
          clk_count         <= 2'b00;
       end
       else if ( dbg_srst ) begin
          for (p = 0; p<= (DWIDTH_LN_BYTES-1); p = p+1) begin
             data_in_array_d0[p]  <= 9'd0;
          end
          com_dec_d0        <= 4'd0;
          clk_count         <= 2'b00;
       end
       else if ((core_clk_freq_mhz)=="core_clk_250mhz" ? clk_count ==2'b11 : clk_count[0]==1'b1 ) begin
          for (p = 0; p<= (DWIDTH_LN_BYTES-1); p = p+1) begin
             data_in_array_d0[p]  <= data_in_array[p];
          end
          com_dec_d0        <= (|com_dec_c == 1'b1) ? com_dec_c : com_dec_d0;
          clk_count<=clk_count+2'b01;
       end
       else clk_count<=clk_count+2'b01;
    end

//--------------------------------------------------------------------
// Align data received so that COM twentynm_hssirtl_is always in LSB
//--------------------------------------------------------------------
    integer q;
    always @(negedge npor_sync or posedge pld_clk) begin
       if (npor_sync == 1'b0 ) begin
          for (q = 0; q<= (DWIDTH_LN_BYTES-1); q = q+1) begin
             algn_data[q]          <= 9'd0;
          end
       end
       else if ( dbg_srst ) begin
          for (q = 0; q<= (DWIDTH_LN_BYTES-1); q = q+1) begin
             algn_data[q]          <= 9'd0;
          end
       end
       else if ((core_clk_freq_mhz)=="core_clk_250mhz" ? clk_count ==2'b11 : clk_count[0]==1'b1 ) begin
          // 4'b0001
          if (com_dec_d0 == 4'b0001) begin
             for (q = 0; q<= (DWIDTH_LN_BYTES-1); q = q+1) begin
                algn_data[q]    <= data_in_array_d0[q];
             end
          end
          // 4'b001x
          else if (com_dec_d0[3:1] == 3'b001) begin
             {algn_data[3],
              algn_data[2],
              algn_data[1],
              algn_data[0]} <= {data_in_array[0],data_in_array_d0[3],data_in_array_d0[2],data_in_array_d0[1]};
          end
          // 4'b01xx
          else if (com_dec_d0[3:2] == 2'b01) begin
             {algn_data[3],
              algn_data[2],
              algn_data[1],
              algn_data[0]} <= {data_in_array[1],data_in_array[0],data_in_array_d0[3],data_in_array_d0[2]};
          end
          // 4'b1xxx
          else if (com_dec_d0[3] == 1'b1) begin
             {algn_data[3],
              algn_data[2],
              algn_data[1],
              algn_data[0]} <= {data_in_array[2],data_in_array[1],data_in_array[0],data_in_array_d0[3]};
          end
       end
    end

//--------------------------------------------------------------------
// Decode all the bytes from the Aligned data
//--------------------------------------------------------------------
    genvar i;
    generate
       for (i = 0; i<= (DWIDTH_LN_BYTES-1); i = i+1) begin : COM_SKP_DEC_ALGN
      // Decode all the bytes for K_COM
          assign com_dec_al_c[i]   = (algn_data[i] == K_COM) ? 1'b1 : 1'b0;

          // Decode all the bytes for K_PAD
          assign pad_dec_al_c[i]   = (algn_data[i] == K_PAD) ? 1'b1 : 1'b0;


         // Decode all the bytes for D_TS2
         assign ts2_dec_al_c[i]   = (algn_data[i] == D_TS2_P | algn_data[i] == D_TS2_N) ? 1'b1 : 1'b0;

         // Decode all the bytes for  D_TS2_N
         assign polinv_dec_al_c[i]= ( algn_data[i] == D_TS2_N) ? 1'b1 : 1'b0;

          // Decode Control for DATA
          always @(*) begin
             casex(algn_data[i])
                9'b0_xxxx_xxxx: dat_dec_al_c[i] = 1'b1;
                default       : dat_dec_al_c[i] = 1'b0;
             endcase
          end
       end
    endgenerate


// Decode the TS2 Found
    assign ts_det = (dat_dec_al_c[3] & (pad_dec_al_c[2] | dat_dec_al_c[2]) & (pad_dec_al_c[1] | dat_dec_al_c[1]) & com_dec_al_c[0]) ? 1'b1 : 1'b0;

//--------------------------------------------------------------------
//  TS2 Decoder
//--------------------------------------------------------------------
    assign rxsymb6_i = algn_data[2];
    always @(negedge npor_sync or posedge pld_clk) begin
       if (npor_sync == 1'b0  ) begin
          cpt_ts    <= 2'b11;
          rxsymb6   <= 9'd0;
          rxpolinv  <= 1'b0;
          rxts2     <= 1'b0;
          rxtse     <= 1'b0;
          ts_cpl    <= 1'b0;
       end
       else if ( dbg_srst ) begin
          cpt_ts    <= 2'b11;
          rxsymb6   <= 9'd0;
          rxpolinv  <= 1'b0;
          rxts2     <= 1'b0;
          rxtse     <= 1'b0;
          ts_cpl    <= 1'b0;
       end
       else if ((core_clk_freq_mhz)=="core_clk_250mhz" ? clk_count ==2'b11 : clk_count[0]==1'b1 ) begin
          // Count the TS2 Length and clear when TS2 twentynm_hssirtl_is illegal
          if (ts_det == 1'b1) begin
             cpt_ts <= 2'b10;
          end
          else if (cpt_ts != 2'b11) begin
             if (cpt_ts == 2'b00 | (&dat_dec_al_c == 1'b1)) begin
                cpt_ts <= cpt_ts - 2'b01;
             end
             else begin
                cpt_ts <= 2'b00;
             end
          end


          // Store -- TS2 "Pol Inv" signal
          if (cpt_ts == 2'b10) begin
             rxsymb6   <= rxsymb6_i;
             rxpolinv  <= polinv_dec_al_c[3];
             // When EQ TS2 received dont check Symbol6, check only symbol7
             if (rxsymb6_i[8:7] == 2'b01) begin
                rxts2     <= ts2_dec_al_c[3];
             end
             else begin
                rxts2     <= &ts2_dec_al_c[3:2];
             end
          end
          else if (cpt_ts <= 2'b01) begin
             rxpolinv  <= &polinv_dec_al_c;
             rxts2     <= &ts2_dec_al_c;
          end

          // Check if any error found in TS2 detection
          if (ts_det == 1'b1) begin
             rxtse <= 1'b0;
          end
          else begin
             case(cpt_ts)
                2'b10: if (rxsymb6_i[8:7] == 2'b01) begin
                          rxtse <= (&dat_dec_al_c[2:0] == 1'b1 & ( (&ts2_dec_al_c[3] == 1'b1))) ? rxtse : 1'b1;
                       end
                       else begin
                          rxtse <= (&dat_dec_al_c[1:0] == 1'b1 & ( (&ts2_dec_al_c[3:2] == 1'b1))) ? rxtse : 1'b1;
                       end
                2'b01: rxtse <= (rxts2 & (&ts2_dec_al_c))  ? rxtse : 1'b1;
                2'b00: rxtse <= (rxts2 & (&ts2_dec_al_c))  ? rxtse : 1'b1;
                default: begin end
             endcase
          end

          // Generate a signal to indicate a Complete TS2 was found
          if (cpt_ts == 2'b00 & rxtse == 1'b0) begin
             ts_cpl    <= 1'b1;
          end
          else begin
             ts_cpl <= 1'b0;
          end
       end
    end
    always @(negedge npor_sync or posedge pld_clk) begin
            if (~npor_sync ) begin
                      ts_count<=4'h0;
                      rx_polarity_out[7:0] <= 8'h00;
                      rxpolarity_done <=1'b0;
                      rxpolarity<=1'b0;

            end
            else if ( dbg_srst) begin
                      ts_count<=4'h0;
                      rx_polarity_out[7:0] <= 8'h00;
                      rxpolarity_done <=1'b0;
                      rxpolarity <=1'b0;

            end
            else if ((core_clk_freq_mhz)=="core_clk_250mhz" ? clk_count ==2'b11 : clk_count[0]==1'b1 ) begin
                  if (cpt_ts == 2'b00 & rxtse == 1'b1) begin
                        //ts_count <=0; //TODO : Add this if there is No SKIP in between. To check if there is 8 consecutive TS2s
                  end
                  else if (ts_count <= TS2_COUNT-1 ) begin
                    if (ts_cpl == 1'b1) begin
                           if (ts_count >0 ) begin
                                 if (rx_polarity_out[ts_count-1 ] == rxpolinv) begin
                                       rx_polarity_out[ts_count] <= rxpolinv ;
                                       ts_count <= ts_count +1 ;
                                 end
                                 else ts_count <=0;
                           end
                           else begin
                                 rx_polarity_out[ts_count] <= rxpolinv ;
                                 ts_count <= ts_count +1 ;
                           end
                    end
                    rxpolarity_done <=1'b0;
                  end
                else if (ts_count ==TS2_COUNT )
                        rxpolarity_done<=1'b1;
                        rxpolarity <= &rx_polarity_out[TS2_COUNT-1:0];
             end


    end

endmodule



// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on
module altpcie_grounder
 # (
    parameter WIDTH = 1

    )
 (
   input [WIDTH-1:0] in_sig,
   input grounded,
   output [WIDTH-1:0] out_sig
 );

 assign out_sig =           (grounded)? {(WIDTH){1'b0}} :in_sig;
endmodule
