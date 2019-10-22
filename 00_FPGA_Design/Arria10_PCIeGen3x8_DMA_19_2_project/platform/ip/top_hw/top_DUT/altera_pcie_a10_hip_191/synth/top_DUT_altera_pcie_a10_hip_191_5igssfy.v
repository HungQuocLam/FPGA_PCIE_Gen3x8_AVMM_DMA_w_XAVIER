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

//`default_nettype none

// altera message_off  10036 10034 10230 10764

// THis is used in Makefile to check Terp file syntax at make check time
module top_DUT_altera_pcie_a10_hip_191_5igssfy # (
      parameter interface_type_integer_hwtcl                      = 0,       // 0 --> AST, 1 --> AVMM
      //Virtual Attributes
      parameter func_mode                                         = "enable",
      parameter sup_mode                                          = "user_mode",
      parameter lane_rate                                         = "gen1",
      parameter lane_rate_hwtcl                                   = "Gen1 (2.5 Gbps)",
      parameter link_width                                        = "x1",
      parameter port_type                                         = "native_ep",
      parameter pcie_base_spec                                    = "pcie_3p0",
      parameter app_interface_width                               = "avst_64bit",
      parameter rx_buffer_credit_alloc                            = "balance",
      parameter hrdrstctrl_en                                     = "hrdrstctrl_en",
      parameter uc_calibration_en                                 = "uc_calibration_dis",
      parameter cvp_enable                                        = "cvp_dis",
      parameter advance_error_reporting                           = "disable",
      parameter sim_mode                                          = "enable",
      parameter bar0_type                                         = "bar0_64bit_prefetch_mem",
      parameter bar1_type                                         = "bar1_disable",
      parameter bar2_type                                         = "bar2_disable",
      parameter bar3_type                                         = "bar3_disable",
      parameter bar4_type                                         = "bar4_disable",
      parameter bar5_type                                         = "bar5_disable",
      parameter bar0_address_width_mux_hwtcl                      = 0,
      parameter bar1_address_width_mux_hwtcl                      = 0,
      parameter bar2_address_width_mux_hwtcl                      = 0,
      parameter bar3_address_width_mux_hwtcl                      = 0,
      parameter bar4_address_width_mux_hwtcl                      = 0,
      parameter bar5_address_width_mux_hwtcl                      = 0,

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
      parameter bist_memory_settings                              =  "0",
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
      parameter expansion_base_address_register_hwtcl             = 32'h0,
      parameter extend_tag_field                                  = "false",
      parameter force_tag_checking_on_hwtcl                       = 0,
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
      parameter enable_g3_bypass_equlz_rp_sim_hwtcl               = 0,
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
      parameter       jtag_id                                     = "0",
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
      parameter [31:0] msix_pba_offset_hwtcl                       = 32'b0,
      parameter [2:0] msix_table_bir                              = 3'h0,
      parameter [31:0] msix_table_offset_hwtcl                     = 32'b0,
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
      parameter       retry_buffer_memory_settings                = "0",
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
      parameter       rstctrl_rx_pma_rstb_select                  = "not_active_rx_pma_rstb",
      parameter       rstctrl_rx_pll_freq_lock_select             = "not_active_rx_pll_f_lock",
      parameter       rstctrl_mask_tx_pll_lock_select             = "not_active_mask_tx_pll_lock",
      parameter       rstctrl_rx_pll_lock_select                  = "not_active_rx_pll_lock",
      parameter       rstctrl_perstn_select                       = "perstn_pin",
      parameter       rstctrl_fref_clk_select                     = "ch0_sel",
      parameter       rstctrl_tx_pma_syncp_select                 = "not_active_tx_pma_syncp",
      parameter       rstctrl_rx_pcs_rst_n_select                 = "not_active_rx_pcs_rst",
      parameter       rstctrl_tx_pcs_rst_n_select                 = "not_active_tx_pcs_rst",
      parameter       rstctrl_timer_a_type                        = "a_timer_milli_secs",
      parameter       [7:0] rstctrl_timer_a                       = 8'd10,
      parameter       rstctrl_timer_b_type                        = "b_timer_milli_secs",
      parameter       [7:0] rstctrl_timer_b                       = 8'd10,
      parameter       rstctrl_timer_c_type                        = "c_timer_milli_secs",
      parameter       [7:0] rstctrl_timer_c                       = 8'd10,
      parameter       rstctrl_timer_d_type                        = "d_timer_milli_secs",
      parameter       [7:0] rstctrl_timer_d                       = 8'd20,
      parameter       rstctrl_timer_e_type                        = "e_timer_milli_secs",
      parameter       [7:0] rstctrl_timer_e                       = 8'd1,
      parameter       rstctrl_timer_f_type                        = "f_timer_milli_secs",
      parameter       [7:0] rstctrl_timer_f                       = 8'd10,
      parameter       rstctrl_timer_g_type                        = "g_timer_milli_secs",
      parameter       [7:0] rstctrl_timer_g                       = 8'd10,
      parameter       rstctrl_timer_h_type                        = "h_timer_milli_secs",
      parameter       [7:0] rstctrl_timer_h                       = 8'd4,
      parameter       rstctrl_timer_i_type                        = "i_timer_milli_secs",
      parameter       [7:0] rstctrl_timer_i                       = 8'd20,
      parameter       rstctrl_timer_j_type                        = "j_timer_milli_secs",
      parameter       [7:0] rstctrl_timer_j                       = 8'd20,
      parameter       rstctrl_tx_lcff_pll_lock_select             = "not_active_lcff_pll_lock",
      parameter       rstctrl_tx_lcff_pll_rstb_select             = "not_active_lcff_pll_rstb",
      parameter       rx_ast_parity                               = "disable",
      parameter       tx_ast_parity                               = "disable",
      parameter [19:0]rx_buffer_fc_protect                        = 20'd68,
      parameter [10:0]rx_buffer_protect                           = 20'd68,
      parameter [3:0] rx_cdc_almost_empty                         = 4'h3,
      parameter [3:0] rx_cdc_almost_full                          = 4'd12,
      parameter       rx_cred_ctl_param                           = "disable",
      parameter       rx_ei_l0s                                   = "disable",
      parameter [7:0] rx_l0s_count_idl                            = 8'h0,
      parameter [10:0]rx_ptr0_posted_dpram_min                    = 11'h0,
      parameter [10:0]rx_ptr0_posted_dpram_max                    = 11'h0,
      parameter [10:0]rx_ptr0_nonposted_dpram_min                 = 11'h0,
      parameter [10:0]rx_ptr0_nonposted_dpram_max                 = 11'h0,
      parameter       rx_runt_patch_dis                           = "enable",
      parameter       rx_sop_ctrl                                 = "rx_sop_boundary_64",
      parameter       rx_trunc_patch_dis                          = "enable",
      parameter       rx_use_prst                                 = "false",
      parameter       rx_use_prst_ep                              = "true",
      parameter       rxbuf_ecc_corr_mask_dis                     = "enable",
      parameter [7:0] sameclock_nfts_count                        = 8'h0,
      parameter       sel_enable_pcs_rx_fifo_err                  = "disable_sel",
      parameter       simple_ro_fifo_control_en                   = "disable",
      parameter       single_rx_detect                            = "detect_all_lanes",
      parameter [10:0]skp_os_gen3_count                           = 11'h0,
      parameter [10:0]skp_os_schedule_count                       = 11'h0,
      parameter [12:0]slot_number                                 = 13'h0,
      parameter [7:0] slot_power_limit                            = 8'h0,
      parameter [1:0] slot_power_scale                            = 2'h0,
      parameter       slotclk_cfg                                 = "static_slotclkcfgon",
      parameter [15:0]ssvid                                       = 16'h0,
      parameter [15:0]ssid                                        = 16'h0,
      parameter [15:0]subsystem_vendor_id                         = 16'd4466,
      parameter [15:0]subsystem_device_id                         = 16'd57345,
      parameter [15:0]pf0_vf_subsystem_device_id_hwtcl            = 16'd57345,
      parameter       surprise_down_error_support                 = "false",
      parameter       tl_cfg_div                                  = "cfg_clk_div_7",
      parameter       tl_tx_check_parity_msg                      = "disable",
      parameter       tph_completer                               = "false",
      parameter [3:0] tx_cdc_almost_empty                         = 4'd5,
      parameter [3:0] tx_cdc_almost_full                          = 4'd12,
      parameter       tx_sop_ctrl                                 = "boundary_64",
      parameter [7:0] tx_swing                                    = 8'h0,
      parameter [3:0] txdl_fair_arbiter_counter                   = 4'h0,
      parameter       txdl_fair_arbiter_en                        = "enable",
      parameter       txrate_adv                                  = "capability",
      parameter       use_aer                                     = "false",
      parameter       use_crc_forwarding                          = "false",
      parameter [15:0]user_id                                     = 16'h0,
      parameter       vc_arbitration                              = "single_vc_arb",
      parameter       vc_enable                                   = "single_vc",
      parameter       vc0_clk_enable                              = "true",
      parameter       vc0_rx_buffer_memory_settings               = "0",
      parameter [7:0] vc0_rx_flow_ctrl_posted_header              = 8'd50,
      parameter [11:0]vc0_rx_flow_ctrl_posted_data                = 12'd360,
      parameter [7:0] vc0_rx_flow_ctrl_nonposted_header           = 8'd54,
      parameter [7:0] vc0_rx_flow_ctrl_nonposted_data             = 8'd0,
      parameter [7:0] vc0_rx_flow_ctrl_compl_header               = 8'd112,
      parameter [11:0]vc0_rx_flow_ctrl_compl_data                 = 12'd448,
      parameter [7:0]ko_compl_header                              = 8'd0,
      parameter [11:0]ko_compl_data                               = 12'd0,
      parameter       vc1_clk_enable                              = "false",
      parameter [15:0]vendor_id                                   = 16'd4466,
      parameter [3:0] vsec_cap                                    = 4'h0,
      parameter [15:0]vsec_id                                     = 16'd4466,
      parameter       wrong_device_id                             = "disable",
      parameter       not_use_k_gbl_bits                          = "not_used_k_gbl",
      parameter       avmm_force_inter_sel_csr_ctrl               = "disable",
      parameter       operating_voltage                           = "standard",
      parameter       rxdl_bad_tlp_patch_dis                      = "rxdlbug2_enable_both",
      parameter       avmm_dprio_broadcast_en_csr_ctrl            = "disable",
      parameter [29:0]hip_ac_pwr_uw_per_mhz                       = 30'd0,
      parameter [29:0]hip_ac_pwr_clk_freq_in_hz                   = 30'd0,
      parameter       rxdl_bad_sop_eop_filter_dis                 = "rxdlbug1_enable_both",
      parameter       rxdl_lcrc_patch_dis                         = "rxdlbug3_enable_both",
      parameter       capab_rate_rxcfg_en                         = "disable",
      parameter       avmm_cvp_inter_sel_csr_ctrl                 = "disable",
      parameter       lmi_hold_off_cfg_timer_en                   = "disable",
      parameter       avmm_power_iso_en_csr_ctrl                  = "disable",
      parameter slot_clock_cfg_hwtcl                                = 1,          //TODO Confirm if the 'slotclkcfg' port is removed on the HIP and if yes, removed all the fanout of this param
      
      // new RevE attribute on HIP atom 
      parameter       eco_fb332688_dis                            = "true", 
      //Debug/Additional features parameters
      parameter reserved_debug_hwtcl                              = 0,
      parameter use_tx_cons_cred_sel_hwtcl                        = 0,
      parameter hip_reconfig_hwtcl                                = 0,
      parameter reconfig_address_width_integer_hwtcl              = 11,
      parameter xcvr_reconfig_hwtcl                               = 0,
      parameter multiple_packets_per_cycle_hwtcl                  = 0,
      parameter enable_avst_reset_hwtcl                           = 0,

      /////////////////////////////////////////////////////////////////////////////
      ///                        AVMM Parameters                               ////
      /////////////////////////////////////////////////////////////////////////////
      parameter data_width_integer_hwtcl                      = 64,
      parameter data_width_integer_rxm_txs_hwtcl              = 64,
          parameter data_width_integer_txs_hwtcl                  = 32,
      parameter data_byte_width_integer_hwtcl                 = 8,
      parameter empty_integer_hwtcl                           = 1,
      parameter burst_count_integer_hwtcl                     = 7,
      parameter txs_addr_width_integer_hwtcl                  = 21,
      parameter avmm_addr_width_hwtcl                         = 32,
      parameter cb_pcie_mode_hwtcl                            = 0,
      parameter cb_pcie_rx_lite_hwtcl                         = 0,
      parameter cg_impl_cra_av_slave_port_hwtcl               = 1,
      parameter cg_enable_a2p_interrupt_hwtcl                 = 1,
      parameter cg_a2p_addr_map_num_entries_hwtcl             = 2,
      parameter cg_a2p_addr_map_pass_thru_bits_hwtcl          = 20,
      parameter cg_enable_advanced_interrupt_hwtcl            = 0,
      parameter internal_controller_hwtcl                     = 0,
      parameter enable_rxm_burst_hwtcl                        = 0,
      parameter extended_tag_support_hwtcl                    = 0,
      parameter include_dma_hwtcl                             = 0,
      parameter dma_width_hwtcl                               = 256,
      parameter dma_be_width_hwtcl                            = 32,
      parameter dma_brst_cnt_w_hwtcl                          = 5,

      //Misc Soft IP workaround related parameters
      parameter enable_es_patch                               = 0,

      /////////////////////////////////////////////////////////////////////////////
      //     dma_use_scfifo_ext_hwtcl :Specify SCFIFO module to be used          //
      //       When 0 uses generic LPM SCFIFO                                    //
      //       When 1 uses speed optimized cascaded A10 FIFO                     //
      //       When 2 uses speed optimized cascaded SV FIFO  TODO                //
      /////////////////////////////////////////////////////////////////////////////
      parameter dma_use_scfifo_ext_hwtcl                      = 0,
      /////////////////////////////////////////////////////////////////////////////
      ///                       SRIOV -Autonomous Parameters                   ////
      /////////////////////////////////////////////////////////////////////////////
      parameter cseb_autonomous_hwtcl                         = 0, //1: allow to use CSEB when config-bypass is in autonomous mode
      parameter speed_change_hwtcl                            = 0, //1: allow LTSSM to initiate sefl-speed change until link reach max supported speed
      parameter test_cseb_switch_hwtcl                        = 0, //1: test switching between CSEB and AVST

      /////////////////////////////////////////////////////////////////////////////
      ///                       SRIOV Parameters                               ////
      /////////////////////////////////////////////////////////////////////////////
      parameter sriov2_en                                         = 0,
      parameter enable_alternate_link_list_hwtcl                  = 0,
      parameter pf_msi_support_hwtcl                              = 0,
      parameter enable_completion_timeout_disable_hwtcl           = 1,
      parameter pf_enable_function_msix_support_hwtcl             = 1,
      parameter flr_capability_hwtcl                              = 0,
      parameter link2csr_width_hwtcl                              = 16,
      parameter cfg_num_vf_width_hwtcl                            = 8,
      parameter app_msi_req_fn_hwtcl                              = 8,
      parameter flr_completed_vf_width_hwtcl                      = 1,

      parameter include_sriov_hwtcl                 = 0,
      parameter ari_support_hwtcl                   = 1,
      parameter sr_iov_support_hwtcl                = 1,    //
      parameter total_pf_count_hwtcl                = 2,    // Number of Physical Functions (1 or 2)
      parameter total_vf_count_hwtcl                = 128,  // 0 - 7 when ARI is not supported.
                                                            // 4 - 128 in steps of 4 when ARI is supported.
      parameter total_pf_count_width_hwtcl          = 4,
      parameter total_vf_count_width_hwtcl          = 4,

      parameter pf0_vf_count_hwtcl                  = 64, // Qsys derived value: Number of VFs attached to PF 0
      parameter pf1_vf_count_hwtcl                  = 64, // Qsys derived value: Number of VFs attached to PF 1
      parameter pf2_vf_count_hwtcl                  = 64, // Qsys derived value: Number of VFs attached to PF 2
      parameter pf3_vf_count_hwtcl                  = 64, // Qsys derived value: Number of VFs attached to PF 3

      parameter pf0_subclass_code_hwtcl             = 8'd0,
      parameter pf0_vf_device_id_hwtcl              = 16'hE001,

      parameter pf1_vendor_id_hwtcl                 = 4466,
      parameter pf1_device_id_hwtcl                 = 57345,
      parameter pf1_vf_device_id_hwtcl              = 16'hE001,
      parameter pf1_revision_id_hwtcl               = 1,
      parameter pf1_class_code_hwtcl                = 255,
      parameter pf1_subclass_code_hwtcl             = 8'd0,
      parameter pf1_subsystem_vendor_id_hwtcl       = 4466,
      parameter pf1_subsystem_device_id_hwtcl       = 57345,
      parameter pf1_vf_subsystem_device_id_hwtcl    = 57345,

      parameter pf2_vendor_id_hwtcl                 = 4466,
      parameter pf2_device_id_hwtcl                 = 57345,
      parameter pf2_vf_device_id_hwtcl              = 16'hE001,
      parameter pf2_revision_id_hwtcl               = 1,
      parameter pf2_class_code_hwtcl                = 255,
      parameter pf2_subclass_code_hwtcl             = 8'd0,
      parameter pf2_subsystem_vendor_id_hwtcl       = 4466,
      parameter pf2_subsystem_device_id_hwtcl       = 57345,
      parameter pf2_vf_subsystem_device_id_hwtcl    = 57345,

      parameter pf3_vendor_id_hwtcl                 = 4466,
      parameter pf3_device_id_hwtcl                 = 57345,
      parameter pf3_vf_device_id_hwtcl              = 16'hE001,
      parameter pf3_revision_id_hwtcl               = 1,
      parameter pf3_class_code_hwtcl                = 255,
      parameter pf3_subclass_code_hwtcl             = 8'd0,
      parameter pf3_subsystem_vendor_id_hwtcl       = 4466,
      parameter pf3_subsystem_device_id_hwtcl       = 57345,
      parameter pf3_vf_subsystem_device_id_hwtcl    = 57345,

      parameter pf4_vendor_id_hwtcl                 = 4466,
      parameter pf4_device_id_hwtcl                 = 57345,
      parameter pf4_vf_device_id_hwtcl              = 16'hE001,
      parameter pf4_revision_id_hwtcl               = 1,
      parameter pf4_class_code_hwtcl                = 255,
      parameter pf4_subclass_code_hwtcl             = 8'd0,
      parameter pf4_subsystem_vendor_id_hwtcl       = 4466,
      parameter pf4_subsystem_device_id_hwtcl       = 57345,
      parameter pf4_vf_subsystem_device_id_hwtcl    = 57345,

      parameter pf5_vendor_id_hwtcl                 = 4466,
      parameter pf5_device_id_hwtcl                 = 57345,
      parameter pf5_vf_device_id_hwtcl              = 16'hE001,
      parameter pf5_revision_id_hwtcl               = 1,
      parameter pf5_class_code_hwtcl                = 255,
      parameter pf5_subclass_code_hwtcl             = 8'd0,
      parameter pf5_subsystem_vendor_id_hwtcl       = 4466,
      parameter pf5_subsystem_device_id_hwtcl       = 57345,
      parameter pf5_vf_subsystem_device_id_hwtcl    = 57345,

      parameter pf6_vendor_id_hwtcl                 = 4466,
      parameter pf6_device_id_hwtcl                 = 57345,
      parameter pf6_vf_device_id_hwtcl              = 16'hE001,
      parameter pf6_revision_id_hwtcl               = 1,
      parameter pf6_class_code_hwtcl                = 255,
      parameter pf6_subclass_code_hwtcl             = 8'd0,
      parameter pf6_subsystem_vendor_id_hwtcl       = 4466,
      parameter pf6_subsystem_device_id_hwtcl       = 57345,
      parameter pf6_vf_subsystem_device_id_hwtcl    = 57345,

      parameter pf7_vendor_id_hwtcl                 = 4466,
      parameter pf7_device_id_hwtcl                 = 57345,
      parameter pf7_vf_device_id_hwtcl              = 16'hE001,
      parameter pf7_revision_id_hwtcl               = 1,
      parameter pf7_class_code_hwtcl                = 255,
      parameter pf7_subclass_code_hwtcl             = 8'd0,
      parameter pf7_subsystem_vendor_id_hwtcl       = 4466,
      parameter pf7_subsystem_device_id_hwtcl       = 57345,
      parameter pf7_vf_subsystem_device_id_hwtcl    = 57345,

      parameter pf0_msi_multi_message_capable_hwtcl = 3'd4,
      parameter pf0_msix_table_size_hwtcl           = 11'h1F, // 32
      parameter pf0_msix_table_offset_hwtcl         = 29'd0,
      parameter pf0_msix_table_bir_hwtcl            = 0,
      parameter pf0_msix_pba_offset_hwtcl           = 29'h1000,
      parameter pf0_msix_pba_bir_hwtcl              = 0,

      parameter pf1_msi_multi_message_capable_hwtcl = 3'd4,
      parameter pf1_msix_table_size_hwtcl           = 11'h1F, // 32
      parameter pf1_msix_table_offset_hwtcl         = 29'd0,
      parameter pf1_msix_table_bir_hwtcl            = 0,
      parameter pf1_msix_pba_offset_hwtcl           = 29'h1000,
      parameter pf1_msix_pba_bir_hwtcl              = 0,

      parameter pf2_msi_multi_message_capable_hwtcl = 3'd4,
      parameter pf2_msix_table_size_hwtcl           = 11'h1F, // 32
      parameter pf2_msix_table_offset_hwtcl         = 29'd0,
      parameter pf2_msix_table_bir_hwtcl            = 0,
      parameter pf2_msix_pba_offset_hwtcl           = 29'h1000,
      parameter pf2_msix_pba_bir_hwtcl              = 0,

      parameter pf3_msi_multi_message_capable_hwtcl = 3'd4,
      parameter pf3_msix_table_size_hwtcl           = 11'h1F, // 32
      parameter pf3_msix_table_offset_hwtcl         = 29'd0,
      parameter pf3_msix_table_bir_hwtcl            = 0,
      parameter pf3_msix_pba_offset_hwtcl           = 29'h1000,
      parameter pf3_msix_pba_bir_hwtcl              = 0,

      parameter pf4_msi_multi_message_capable_hwtcl = 3'd4,
      parameter pf4_msix_table_size_hwtcl           = 11'h1F, // 32
      parameter pf4_msix_table_offset_hwtcl         = 29'd0,
      parameter pf4_msix_table_bir_hwtcl            = 0,
      parameter pf4_msix_pba_offset_hwtcl           = 29'h1000,
      parameter pf4_msix_pba_bir_hwtcl              = 0,

      parameter pf5_msi_multi_message_capable_hwtcl = 3'd4,
      parameter pf5_msix_table_size_hwtcl           = 11'h1F, // 32
      parameter pf5_msix_table_offset_hwtcl         = 29'd0,
      parameter pf5_msix_table_bir_hwtcl            = 0,
      parameter pf5_msix_pba_offset_hwtcl           = 29'h1000,
      parameter pf5_msix_pba_bir_hwtcl              = 0,

      parameter pf6_msi_multi_message_capable_hwtcl = 3'd4,
      parameter pf6_msix_table_size_hwtcl           = 11'h1F, // 32
      parameter pf6_msix_table_offset_hwtcl         = 29'd0,
      parameter pf6_msix_table_bir_hwtcl            = 0,
      parameter pf6_msix_pba_offset_hwtcl           = 29'h1000,
      parameter pf6_msix_pba_bir_hwtcl              = 0,

      parameter pf7_msi_multi_message_capable_hwtcl = 3'd4,
      parameter pf7_msix_table_size_hwtcl           = 11'h1F, // 32
      parameter pf7_msix_table_offset_hwtcl         = 29'd0,
      parameter pf7_msix_table_bir_hwtcl            = 0,
      parameter pf7_msix_pba_offset_hwtcl           = 29'h1000,
      parameter pf7_msix_pba_bir_hwtcl              = 0,

      parameter pf0_interrupt_pin_hwtcl             = "intb",
      parameter pf0_intr_line_hwtcl                 = 8'hff,

      parameter pf1_interrupt_pin_hwtcl             = "intb",
      parameter pf1_intr_line_hwtcl                 = 8'hff,

      parameter pf2_interrupt_pin_hwtcl             = "intb",
      parameter pf2_intr_line_hwtcl                 = 8'hff,

      parameter pf3_interrupt_pin_hwtcl             = "intb",
      parameter pf3_intr_line_hwtcl                 = 8'hff,

      parameter pf4_interrupt_pin_hwtcl             = "intb",
      parameter pf4_intr_line_hwtcl                 = 8'hff,

      parameter pf5_interrupt_pin_hwtcl             = "intb",
      parameter pf5_intr_line_hwtcl                 = 8'hff,

      parameter pf6_interrupt_pin_hwtcl             = "intb",
      parameter pf6_intr_line_hwtcl                 = 8'hff,

      parameter pf7_interrupt_pin_hwtcl             = "intb",
      parameter pf7_intr_line_hwtcl                 = 8'hff,

      // Device-Level Parameters
      parameter pf0_pci_prog_intfc_byte_hwtcl      = 8'd0,
      parameter pf1_pci_prog_intfc_byte_hwtcl      = 8'd0,
      parameter pf2_pci_prog_intfc_byte_hwtcl      = 8'd0,
      parameter pf3_pci_prog_intfc_byte_hwtcl      = 8'd0,
      parameter pf4_pci_prog_intfc_byte_hwtcl      = 8'd0,
      parameter pf5_pci_prog_intfc_byte_hwtcl      = 8'd0,
      parameter pf6_pci_prog_intfc_byte_hwtcl      = 8'd0,
      parameter pf7_pci_prog_intfc_byte_hwtcl      = 8'd0,
      parameter drop_poisoned_req_hwtcl             = 0, // Set this to 1 to make the bridge drop Poisoned requests received from the link
      parameter drop_poisoned_compl_hwtcl           = 0, // Set this to 1 to make the bridge drop Poisoned Completions received from the link

   // Config Space pointers
      parameter vf_msix_cap_present_hwtcl       = 0, // Indicates whether VFs include MSIX Capability Structure
      parameter vf_msix_multi_msg_capable_hwtcl = 3'd1,
      parameter pf0_vf_msix_tbl_size_hwtcl      = 11'h1F, // 32
      parameter pf0_vf_msix_tbl_offset_hwtcl    = 29'd0,
      parameter pf0_vf_msix_tbl_bir_hwtcl       = 3'd0,
      parameter pf0_vf_msix_pba_offset_hwtcl    = 29'h1000,
      parameter pf0_vf_msix_pba_bir_hwtcl       = 3'd0,

      parameter pf1_vf_msix_tbl_size_hwtcl      = 11'h1F, // 32
      parameter pf1_vf_msix_tbl_offset_hwtcl    = 29'd0,
      parameter pf1_vf_msix_tbl_bir_hwtcl       = 3'd0,
      parameter pf1_vf_msix_pba_offset_hwtcl    = 29'h1000,
      parameter pf1_vf_msix_pba_bir_hwtcl       = 3'd0,

      parameter pf2_vf_msix_tbl_size_hwtcl      = 11'h1F, // 32
      parameter pf2_vf_msix_tbl_offset_hwtcl    = 29'd0,
      parameter pf2_vf_msix_tbl_bir_hwtcl       = 3'd0,
      parameter pf2_vf_msix_pba_offset_hwtcl    = 29'h1000,
      parameter pf2_vf_msix_pba_bir_hwtcl       = 3'd0,

      parameter pf3_vf_msix_tbl_size_hwtcl      = 11'h1F, // 32
      parameter pf3_vf_msix_tbl_offset_hwtcl    = 29'd0,
      parameter pf3_vf_msix_tbl_bir_hwtcl       = 3'd0,
      parameter pf3_vf_msix_pba_offset_hwtcl    = 29'h1000,
      parameter pf3_vf_msix_pba_bir_hwtcl       = 3'd0,

      parameter relaxed_order_support_hwtcl     = 1'b1, // Device supports relaxed ordering
      parameter system_page_sizes_supported_hwtcl = 32'h553, // Supported page sizes for SR-IOV
      parameter log_vf_errors_in_pf_hwtcl       = 0, // Log VF-specific errors in parent PF (for debug only)

      // PF BAR parameters

      parameter pf0_bar0_present_hwtcl        = 1,  // 0 = not present, 1 = present
      parameter pf1_bar0_present_hwtcl        = 1,  // 0 = not present, 1 = present
      parameter pf0_bar1_present_hwtcl        = 1,  // 0 = not present, 1 = present
      parameter pf1_bar1_present_hwtcl        = 1,  // 0 = not present, 1 = present
      parameter pf0_bar2_present_hwtcl        = 1,  // 0 = not present, 1 = present
      parameter pf1_bar2_present_hwtcl        = 1,  // 0 = not present, 1 = present
      parameter pf0_bar3_present_hwtcl        = 1,  // 0 = not present, 1 = present
      parameter pf1_bar3_present_hwtcl        = 1,  // 0 = not present, 1 = present
      parameter pf0_bar4_present_hwtcl        = 1,  // 0 = not present, 1 = present
      parameter pf1_bar4_present_hwtcl        = 1,  // 0 = not present, 1 = present
      parameter pf0_bar5_present_hwtcl        = 1,  // 0 = not present, 1 = present
      parameter pf1_bar5_present_hwtcl        = 1,  // 0 = not present, 1 = present
      parameter pf0_bar0_type_hwtcl           = 0, // 0 = 32-bit addressing, 1 = 64-bit addressing
      parameter pf1_bar0_type_hwtcl           = 0, // 0 = 32-bit addressing, 1 = 64-bit addressing
      parameter pf0_bar2_type_hwtcl           = 0, // 0 = 32-bit addressing, 1 = 64-bit addressing
      parameter pf1_bar2_type_hwtcl           = 0, // 0 = 32-bit addressing, 1 = 64-bit addressing
      parameter pf0_bar4_type_hwtcl           = 1, // 0 = 32-bit addressing, 1 = 64-bit addressing
      parameter pf1_bar4_type_hwtcl           = 1, // 0 = 32-bit addressing, 1 = 64-bit addressing
      parameter pf0_bar0_prefetchable_hwtcl   = 0, // 0 = non-prefetchable, 1 = prefetchable
      parameter pf1_bar0_prefetchable_hwtcl   = 0, // 0 = non-prefetchable, 1 = prefetchable
      parameter pf0_bar1_prefetchable_hwtcl   = 0, // 0 = non-prefetchable, 1 = prefetchable
      parameter pf1_bar1_prefetchable_hwtcl   = 0, // 0 = non-prefetchable, 1 = prefetchable
      parameter pf0_bar2_prefetchable_hwtcl   = 1, // 0 = non-prefetchable, 1 = prefetchable
      parameter pf1_bar2_prefetchable_hwtcl   = 1, // 0 = non-prefetchable, 1 = prefetchable
      parameter pf0_bar3_prefetchable_hwtcl   = 1, // 0 = non-prefetchable, 1 = prefetchable
      parameter pf1_bar3_prefetchable_hwtcl   = 1, // 0 = non-prefetchable, 1 = prefetchable
      parameter pf0_bar4_prefetchable_hwtcl   = 1, // 0 = non-prefetchable, 1 = prefetchable
      parameter pf1_bar4_prefetchable_hwtcl   = 1, // 0 = non-prefetchable, 1 = prefetchable
      parameter pf0_bar5_prefetchable_hwtcl   = 1, // 0 = non-prefetchable, 1 = prefetchable
      parameter pf1_bar5_prefetchable_hwtcl   = 1, // 0 = non-prefetchable, 1 = prefetchable
      parameter pf0_bar0_size_hwtcl           = 22, // 7 = 128 bytes, 8 = 256 bytes, 9 = 512 bytes, ..., 31 = 2G
      parameter pf1_bar0_size_hwtcl           = 22, // 7 = 128 bytes, 8 = 256 bytes, 9 = 512 bytes, ..., 31 = 2G
      parameter pf0_bar1_size_hwtcl           = 22, // 7 = 128 bytes, 8 = 256 bytes, 9 = 512 bytes, ..., 31 = 2G
      parameter pf1_bar1_size_hwtcl           = 22, // 7 = 128 bytes, 8 = 256 bytes, 9 = 512 bytes, ..., 31 = 2G
      parameter pf0_bar2_size_hwtcl           = 22, // 7 = 128 bytes, 8 = 256 bytes, 9 = 512 bytes, ..., 31 = 2G
      parameter pf1_bar2_size_hwtcl           = 22, // 7 = 128 bytes, 8 = 256 bytes, 9 = 512 bytes, ..., 31 = 2G
      parameter pf0_bar3_size_hwtcl           = 22, // 7 = 128 bytes, 8 = 256 bytes, 9 = 512 bytes, ..., 31 = 2G
      parameter pf1_bar3_size_hwtcl           = 22, // 7 = 128 bytes, 8 = 256 bytes, 9 = 512 bytes, ..., 31 = 2G
      parameter pf0_bar4_size_hwtcl           = 22, // 7 = 128 bytes, 8 = 256 bytes, 9 = 512 bytes, ..., 31 = 2G
      parameter pf1_bar4_size_hwtcl           = 22, // 7 = 128 bytes, 8 = 256 bytes, 9 = 512 bytes, ..., 31 = 2G
      parameter pf0_bar5_size_hwtcl           = 22, // 7 = 128 bytes, 8 = 256 bytes, 9 = 512 bytes, ..., 31 = 2G
      parameter pf1_bar5_size_hwtcl           = 22, // 7 = 128 bytes, 8 = 256 bytes, 9 = 512 bytes, ..., 31 = 2G

      parameter pf2_bar0_present_hwtcl        = 1,  // 0 = not present, 1 = present
      parameter pf3_bar0_present_hwtcl        = 1,  // 0 = not present, 1 = present
      parameter pf2_bar1_present_hwtcl        = 1,  // 0 = not present, 1 = present
      parameter pf3_bar1_present_hwtcl        = 1,  // 0 = not present, 1 = present
      parameter pf2_bar2_present_hwtcl        = 1,  // 0 = not present, 1 = present
      parameter pf3_bar2_present_hwtcl        = 1,  // 0 = not present, 1 = present
      parameter pf2_bar3_present_hwtcl        = 1,  // 0 = not present, 1 = present
      parameter pf3_bar3_present_hwtcl        = 1,  // 0 = not present, 1 = present
      parameter pf2_bar4_present_hwtcl        = 1,  // 0 = not present, 1 = present
      parameter pf3_bar4_present_hwtcl        = 1,  // 0 = not present, 1 = present
      parameter pf2_bar5_present_hwtcl        = 1,  // 0 = not present, 1 = present
      parameter pf3_bar5_present_hwtcl        = 1,  // 0 = not present, 1 = present
      parameter pf0_exprom_bar_present_hwtcl  = 0,  // 0 = not present, 1 = present
      parameter pf1_exprom_bar_present_hwtcl  = 0,  // 0 = not present, 1 = present
      parameter pf2_exprom_bar_present_hwtcl  = 0,  // 0 = not present, 1 = present    
      parameter pf3_exprom_bar_present_hwtcl  = 0,  // 0 = not present, 1 = present      
      parameter pf2_bar0_type_hwtcl           = 0, // 0 = 32-bit addressing, 1 = 64-bit addressing
      parameter pf3_bar0_type_hwtcl           = 0, // 0 = 32-bit addressing, 1 = 64-bit addressing
      parameter pf2_bar2_type_hwtcl           = 0, // 0 = 32-bit addressing, 1 = 64-bit addressing
      parameter pf3_bar2_type_hwtcl           = 0, // 0 = 32-bit addressing, 1 = 64-bit addressing
      parameter pf2_bar4_type_hwtcl           = 1, // 0 = 32-bit addressing, 1 = 64-bit addressing
      parameter pf3_bar4_type_hwtcl           = 1, // 0 = 32-bit addressing, 1 = 64-bit addressing
      parameter pf2_bar0_prefetchable_hwtcl   = 0, // 0 = non-prefetchable, 1 = prefetchable
      parameter pf3_bar0_prefetchable_hwtcl   = 0, // 0 = non-prefetchable, 1 = prefetchable
      parameter pf2_bar1_prefetchable_hwtcl   = 0, // 0 = non-prefetchable, 1 = prefetchable
      parameter pf3_bar1_prefetchable_hwtcl   = 0, // 0 = non-prefetchable, 1 = prefetchable
      parameter pf2_bar2_prefetchable_hwtcl   = 1, // 0 = non-prefetchable, 1 = prefetchable
      parameter pf3_bar2_prefetchable_hwtcl   = 1, // 0 = non-prefetchable, 1 = prefetchable
      parameter pf2_bar3_prefetchable_hwtcl   = 1, // 0 = non-prefetchable, 1 = prefetchable
      parameter pf3_bar3_prefetchable_hwtcl   = 1, // 0 = non-prefetchable, 1 = prefetchable
      parameter pf2_bar4_prefetchable_hwtcl   = 1, // 0 = non-prefetchable, 1 = prefetchable
      parameter pf3_bar4_prefetchable_hwtcl   = 1, // 0 = non-prefetchable, 1 = prefetchable
      parameter pf2_bar5_prefetchable_hwtcl   = 1, // 0 = non-prefetchable, 1 = prefetchable
      parameter pf3_bar5_prefetchable_hwtcl   = 1, // 0 = non-prefetchable, 1 = prefetchable
      parameter pf2_bar0_size_hwtcl           = 22, // 7 = 128 bytes, 8 = 256 bytes, 9 = 512 bytes, ..., 31 = 2G
      parameter pf3_bar0_size_hwtcl           = 22, // 7 = 128 bytes, 8 = 256 bytes, 9 = 512 bytes, ..., 31 = 2G
      parameter pf2_bar1_size_hwtcl           = 22, // 7 = 128 bytes, 8 = 256 bytes, 9 = 512 bytes, ..., 31 = 2G
      parameter pf3_bar1_size_hwtcl           = 22, // 7 = 128 bytes, 8 = 256 bytes, 9 = 512 bytes, ..., 31 = 2G
      parameter pf2_bar2_size_hwtcl           = 22, // 7 = 128 bytes, 8 = 256 bytes, 9 = 512 bytes, ..., 31 = 2G
      parameter pf3_bar2_size_hwtcl           = 22, // 7 = 128 bytes, 8 = 256 bytes, 9 = 512 bytes, ..., 31 = 2G
      parameter pf2_bar3_size_hwtcl           = 22, // 7 = 128 bytes, 8 = 256 bytes, 9 = 512 bytes, ..., 31 = 2G
      parameter pf3_bar3_size_hwtcl           = 22, // 7 = 128 bytes, 8 = 256 bytes, 9 = 512 bytes, ..., 31 = 2G
      parameter pf2_bar4_size_hwtcl           = 22, // 7 = 128 bytes, 8 = 256 bytes, 9 = 512 bytes, ..., 31 = 2G
      parameter pf3_bar4_size_hwtcl           = 22, // 7 = 128 bytes, 8 = 256 bytes, 9 = 512 bytes, ..., 31 = 2G
      parameter pf2_bar5_size_hwtcl           = 22, // 7 = 128 bytes, 8 = 256 bytes, 9 = 512 bytes, ..., 31 = 2G
      parameter pf3_bar5_size_hwtcl           = 22, // 7 = 128 bytes, 8 = 256 bytes, 9 = 512 bytes, ..., 31 = 2G
      parameter pf0_exprom_bar_size_hwtcl     = 12, //11 = 2K bytes, 12 = 4K bytes,  13= 8K bytes,  ..., 24 = 2M 
      parameter pf1_exprom_bar_size_hwtcl     = 12, //11 = 2K bytes, 12 = 4K bytes,  13= 8K bytes,  ..., 24 = 2M
      parameter pf2_exprom_bar_size_hwtcl     = 12, //11 = 2K bytes, 12 = 4K bytes,  13= 8K bytes,  ..., 24 = 2M
      parameter pf3_exprom_bar_size_hwtcl     = 12, //11 = 2K bytes, 12 = 4K bytes,  13= 8K bytes,  ..., 24 = 2M      

      parameter pf4_bar0_present_hwtcl        = 1,  // 0 = not present, 1 = present
      parameter pf5_bar0_present_hwtcl        = 1,  // 0 = not present, 1 = present
      parameter pf4_bar1_present_hwtcl        = 1,  // 0 = not present, 1 = present
      parameter pf5_bar1_present_hwtcl        = 1,  // 0 = not present, 1 = present
      parameter pf4_bar2_present_hwtcl        = 1,  // 0 = not present, 1 = present
      parameter pf5_bar2_present_hwtcl        = 1,  // 0 = not present, 1 = present
      parameter pf4_bar3_present_hwtcl        = 1,  // 0 = not present, 1 = present
      parameter pf5_bar3_present_hwtcl        = 1,  // 0 = not present, 1 = present
      parameter pf4_bar4_present_hwtcl        = 1,  // 0 = not present, 1 = present
      parameter pf5_bar4_present_hwtcl        = 1,  // 0 = not present, 1 = present
      parameter pf4_bar5_present_hwtcl        = 1,  // 0 = not present, 1 = present
      parameter pf5_bar5_present_hwtcl        = 1,  // 0 = not present, 1 = present
      parameter pf4_bar0_type_hwtcl           = 0, // 0 = 32-bit addressing, 1 = 64-bit addressing
      parameter pf5_bar0_type_hwtcl           = 0, // 0 = 32-bit addressing, 1 = 64-bit addressing
      parameter pf4_bar2_type_hwtcl           = 0, // 0 = 32-bit addressing, 1 = 64-bit addressing
      parameter pf5_bar2_type_hwtcl           = 0, // 0 = 32-bit addressing, 1 = 64-bit addressing
      parameter pf4_bar4_type_hwtcl           = 1, // 0 = 32-bit addressing, 1 = 64-bit addressing
      parameter pf5_bar4_type_hwtcl           = 1, // 0 = 32-bit addressing, 1 = 64-bit addressing
      parameter pf4_bar0_prefetchable_hwtcl   = 0, // 0 = non-prefetchable, 1 = prefetchable
      parameter pf5_bar0_prefetchable_hwtcl   = 0, // 0 = non-prefetchable, 1 = prefetchable
      parameter pf4_bar1_prefetchable_hwtcl   = 0, // 0 = non-prefetchable, 1 = prefetchable
      parameter pf5_bar1_prefetchable_hwtcl   = 0, // 0 = non-prefetchable, 1 = prefetchable
      parameter pf4_bar2_prefetchable_hwtcl   = 1, // 0 = non-prefetchable, 1 = prefetchable
      parameter pf5_bar2_prefetchable_hwtcl   = 1, // 0 = non-prefetchable, 1 = prefetchable
      parameter pf4_bar3_prefetchable_hwtcl   = 1, // 0 = non-prefetchable, 1 = prefetchable
      parameter pf5_bar3_prefetchable_hwtcl   = 1, // 0 = non-prefetchable, 1 = prefetchable
      parameter pf4_bar4_prefetchable_hwtcl   = 1, // 0 = non-prefetchable, 1 = prefetchable
      parameter pf5_bar4_prefetchable_hwtcl   = 1, // 0 = non-prefetchable, 1 = prefetchable
      parameter pf4_bar5_prefetchable_hwtcl   = 1, // 0 = non-prefetchable, 1 = prefetchable
      parameter pf5_bar5_prefetchable_hwtcl   = 1, // 0 = non-prefetchable, 1 = prefetchable
      parameter pf4_bar0_size_hwtcl           = 22, // 7 = 128 bytes, 8 = 256 bytes, 9 = 512 bytes, ..., 31 = 2G
      parameter pf5_bar0_size_hwtcl           = 22, // 7 = 128 bytes, 8 = 256 bytes, 9 = 512 bytes, ..., 31 = 2G
      parameter pf4_bar1_size_hwtcl           = 22, // 7 = 128 bytes, 8 = 256 bytes, 9 = 512 bytes, ..., 31 = 2G
      parameter pf5_bar1_size_hwtcl           = 22, // 7 = 128 bytes, 8 = 256 bytes, 9 = 512 bytes, ..., 31 = 2G
      parameter pf4_bar2_size_hwtcl           = 22, // 7 = 128 bytes, 8 = 256 bytes, 9 = 512 bytes, ..., 31 = 2G
      parameter pf5_bar2_size_hwtcl           = 22, // 7 = 128 bytes, 8 = 256 bytes, 9 = 512 bytes, ..., 31 = 2G
      parameter pf4_bar3_size_hwtcl           = 22, // 7 = 128 bytes, 8 = 256 bytes, 9 = 512 bytes, ..., 31 = 2G
      parameter pf5_bar3_size_hwtcl           = 22, // 7 = 128 bytes, 8 = 256 bytes, 9 = 512 bytes, ..., 31 = 2G
      parameter pf4_bar4_size_hwtcl           = 22, // 7 = 128 bytes, 8 = 256 bytes, 9 = 512 bytes, ..., 31 = 2G
      parameter pf5_bar4_size_hwtcl           = 22, // 7 = 128 bytes, 8 = 256 bytes, 9 = 512 bytes, ..., 31 = 2G
      parameter pf4_bar5_size_hwtcl           = 22, // 7 = 128 bytes, 8 = 256 bytes, 9 = 512 bytes, ..., 31 = 2G
      parameter pf5_bar5_size_hwtcl           = 22, // 7 = 128 bytes, 8 = 256 bytes, 9 = 512 bytes, ..., 31 = 2G

      parameter pf6_bar0_present_hwtcl        = 1,  // 0 = not present, 1 = present
      parameter pf7_bar0_present_hwtcl        = 1,  // 0 = not present, 1 = present
      parameter pf6_bar1_present_hwtcl        = 1,  // 0 = not present, 1 = present
      parameter pf7_bar1_present_hwtcl        = 1,  // 0 = not present, 1 = present
      parameter pf6_bar2_present_hwtcl        = 1,  // 0 = not present, 1 = present
      parameter pf7_bar2_present_hwtcl        = 1,  // 0 = not present, 1 = present
      parameter pf6_bar3_present_hwtcl        = 1,  // 0 = not present, 1 = present
      parameter pf7_bar3_present_hwtcl        = 1,  // 0 = not present, 1 = present
      parameter pf6_bar4_present_hwtcl        = 1,  // 0 = not present, 1 = present
      parameter pf7_bar4_present_hwtcl        = 1,  // 0 = not present, 1 = present
      parameter pf6_bar5_present_hwtcl        = 1,  // 0 = not present, 1 = present
      parameter pf7_bar5_present_hwtcl        = 1,  // 0 = not present, 1 = present
      parameter pf4_exprom_bar_present_hwtcl  = 0,  // 0 = not present, 1 = present
      parameter pf5_exprom_bar_present_hwtcl  = 0,  // 0 = not present, 1 = present
      parameter pf6_exprom_bar_present_hwtcl  = 0,  // 0 = not present, 1 = present    
      parameter pf7_exprom_bar_present_hwtcl  = 0,  // 0 = not present, 1 = present      
      parameter pf6_bar0_type_hwtcl           = 0, // 0 = 32-bit addressing, 1 = 64-bit addressing
      parameter pf7_bar0_type_hwtcl           = 0, // 0 = 32-bit addressing, 1 = 64-bit addressing
      parameter pf6_bar2_type_hwtcl           = 0, // 0 = 32-bit addressing, 1 = 64-bit addressing
      parameter pf7_bar2_type_hwtcl           = 0, // 0 = 32-bit addressing, 1 = 64-bit addressing
      parameter pf6_bar4_type_hwtcl           = 1, // 0 = 32-bit addressing, 1 = 64-bit addressing
      parameter pf7_bar4_type_hwtcl           = 1, // 0 = 32-bit addressing, 1 = 64-bit addressing
      parameter pf6_bar0_prefetchable_hwtcl   = 0, // 0 = non-prefetchable, 1 = prefetchable
      parameter pf7_bar0_prefetchable_hwtcl   = 0, // 0 = non-prefetchable, 1 = prefetchable
      parameter pf6_bar1_prefetchable_hwtcl   = 0, // 0 = non-prefetchable, 1 = prefetchable
      parameter pf7_bar1_prefetchable_hwtcl   = 0, // 0 = non-prefetchable, 1 = prefetchable
      parameter pf6_bar2_prefetchable_hwtcl   = 1, // 0 = non-prefetchable, 1 = prefetchable
      parameter pf7_bar2_prefetchable_hwtcl   = 1, // 0 = non-prefetchable, 1 = prefetchable
      parameter pf6_bar3_prefetchable_hwtcl   = 1, // 0 = non-prefetchable, 1 = prefetchable
      parameter pf7_bar3_prefetchable_hwtcl   = 1, // 0 = non-prefetchable, 1 = prefetchable
      parameter pf6_bar4_prefetchable_hwtcl   = 1, // 0 = non-prefetchable, 1 = prefetchable
      parameter pf7_bar4_prefetchable_hwtcl   = 1, // 0 = non-prefetchable, 1 = prefetchable
      parameter pf6_bar5_prefetchable_hwtcl   = 1, // 0 = non-prefetchable, 1 = prefetchable
      parameter pf7_bar5_prefetchable_hwtcl   = 1, // 0 = non-prefetchable, 1 = prefetchable
      parameter pf6_bar0_size_hwtcl           = 22, // 7 = 128 bytes, 8 = 256 bytes, 9 = 512 bytes, ..., 31 = 2G
      parameter pf7_bar0_size_hwtcl           = 22, // 7 = 128 bytes, 8 = 256 bytes, 9 = 512 bytes, ..., 31 = 2G
      parameter pf6_bar1_size_hwtcl           = 22, // 7 = 128 bytes, 8 = 256 bytes, 9 = 512 bytes, ..., 31 = 2G
      parameter pf7_bar1_size_hwtcl           = 22, // 7 = 128 bytes, 8 = 256 bytes, 9 = 512 bytes, ..., 31 = 2G
      parameter pf6_bar2_size_hwtcl           = 22, // 7 = 128 bytes, 8 = 256 bytes, 9 = 512 bytes, ..., 31 = 2G
      parameter pf7_bar2_size_hwtcl           = 22, // 7 = 128 bytes, 8 = 256 bytes, 9 = 512 bytes, ..., 31 = 2G
      parameter pf6_bar3_size_hwtcl           = 22, // 7 = 128 bytes, 8 = 256 bytes, 9 = 512 bytes, ..., 31 = 2G
      parameter pf7_bar3_size_hwtcl           = 22, // 7 = 128 bytes, 8 = 256 bytes, 9 = 512 bytes, ..., 31 = 2G
      parameter pf6_bar4_size_hwtcl           = 22, // 7 = 128 bytes, 8 = 256 bytes, 9 = 512 bytes, ..., 31 = 2G
      parameter pf7_bar4_size_hwtcl           = 22, // 7 = 128 bytes, 8 = 256 bytes, 9 = 512 bytes, ..., 31 = 2G
      parameter pf6_bar5_size_hwtcl           = 22, // 7 = 128 bytes, 8 = 256 bytes, 9 = 512 bytes, ..., 31 = 2G
      parameter pf7_bar5_size_hwtcl           = 22, // 7 = 128 bytes, 8 = 256 bytes, 9 = 512 bytes, ..., 31 = 2G
      parameter pf4_exprom_bar_size_hwtcl     = 12, //11 = 2K bytes, 12 = 4K bytes,  13= 8K bytes,  ..., 24 = 2M 
      parameter pf5_exprom_bar_size_hwtcl     = 12, //11 = 2K bytes, 12 = 4K bytes,  13= 8K bytes,  ..., 24 = 2M
      parameter pf6_exprom_bar_size_hwtcl     = 12, //11 = 2K bytes, 12 = 4K bytes,  13= 8K bytes,  ..., 24 = 2M
      parameter pf7_exprom_bar_size_hwtcl     = 12, //11 = 2K bytes, 12 = 4K bytes,  13= 8K bytes,  ..., 24 = 2M      

      // VF BAR parameters
      parameter pf0_vf_bar0_present_hwtcl         = 1,  // 0 = not present, 1 = present
      parameter pf1_vf_bar0_present_hwtcl         = 1,  // 0 = not present, 1 = present
      parameter pf0_vf_bar1_present_hwtcl         = 1,  // 0 = not present, 1 = present
      parameter pf1_vf_bar1_present_hwtcl         = 1,  // 0 = not present, 1 = present
      parameter pf0_vf_bar2_present_hwtcl         = 1,  // 0 = not present, 1 = present
      parameter pf1_vf_bar2_present_hwtcl         = 1,  // 0 = not present, 1 = present
      parameter pf0_vf_bar3_present_hwtcl         = 1,  // 0 = not present, 1 = present
      parameter pf1_vf_bar3_present_hwtcl         = 1,  // 0 = not present, 1 = present
      parameter pf0_vf_bar4_present_hwtcl         = 1,  // 0 = not present, 1 = present
      parameter pf1_vf_bar4_present_hwtcl         = 1,  // 0 = not present, 1 = present
      parameter pf0_vf_bar5_present_hwtcl         = 1,  // 0 = not present, 1 = present
      parameter pf1_vf_bar5_present_hwtcl         = 1,  // 0 = not present, 1 = present
      parameter pf0_vf_bar0_type_hwtcl            = 0, // 0 = 32-bit addressing, 1 = 64-bit addressing
      parameter pf1_vf_bar0_type_hwtcl            = 0, // 0 = 32-bit addressing, 1 = 64-bit addressing
      parameter pf0_vf_bar2_type_hwtcl            = 1, // 0 = 32-bit addressing, 1 = 64-bit addressing
      parameter pf1_vf_bar2_type_hwtcl            = 1, // 0 = 32-bit addressing, 1 = 64-bit addressing
      parameter pf0_vf_bar4_type_hwtcl            = 1, // 0 = 32-bit addressing, 1 = 64-bit addressing
      parameter pf1_vf_bar4_type_hwtcl            = 1, // 0 = 32-bit addressing, 1 = 64-bit addressing
      parameter pf0_vf_bar0_prefetchable_hwtcl    = 0, // 0 = non-prefetchable, 1 = prefetchable
      parameter pf1_vf_bar0_prefetchable_hwtcl    = 0, // 0 = non-prefetchable, 1 = prefetchable
      parameter pf0_vf_bar1_prefetchable_hwtcl    = 0, // 0 = non-prefetchable, 1 = prefetchable
      parameter pf1_vf_bar1_prefetchable_hwtcl    = 0, // 0 = non-prefetchable, 1 = prefetchable
      parameter pf0_vf_bar2_prefetchable_hwtcl    = 1, // 0 = non-prefetchable, 1 = prefetchable
      parameter pf1_vf_bar2_prefetchable_hwtcl    = 1, // 0 = non-prefetchable, 1 = prefetchable
      parameter pf0_vf_bar3_prefetchable_hwtcl    = 1, // 0 = non-prefetchable, 1 = prefetchable
      parameter pf1_vf_bar3_prefetchable_hwtcl    = 1, // 0 = non-prefetchable, 1 = prefetchable
      parameter pf0_vf_bar4_prefetchable_hwtcl    = 1, // 0 = non-prefetchable, 1 = prefetchable
      parameter pf1_vf_bar4_prefetchable_hwtcl    = 1, // 0 = non-prefetchable, 1 = prefetchable
      parameter pf0_vf_bar5_prefetchable_hwtcl    = 1, // 0 = non-prefetchable, 1 = prefetchable
      parameter pf1_vf_bar5_prefetchable_hwtcl    = 1, // 0 = non-prefetchable, 1 = prefetchable
      parameter pf0_vf_bar0_size_hwtcl            = 22, // 7 = 128 bytes, 8 = 256 bytes, 9 = 512 bytes, ..., 31 = 2G
      parameter pf1_vf_bar0_size_hwtcl            = 22, // 7 = 128 bytes, 8 = 256 bytes, 9 = 512 bytes, ..., 31 = 2G
      parameter pf0_vf_bar1_size_hwtcl            = 22, // 7 = 128 bytes, 8 = 256 bytes, 9 = 512 bytes, ..., 31 = 2G
      parameter pf1_vf_bar1_size_hwtcl            = 22, // 7 = 128 bytes, 8 = 256 bytes, 9 = 512 bytes, ..., 31 = 2G
      parameter pf0_vf_bar2_size_hwtcl            = 22, // 7 = 128 bytes, 8 = 256 bytes, 9 = 512 bytes, ..., 31 = 2G
      parameter pf1_vf_bar2_size_hwtcl            = 22, // 7 = 128 bytes, 8 = 256 bytes, 9 = 512 bytes, ..., 31 = 2G
      parameter pf0_vf_bar3_size_hwtcl            = 22, // 7 = 128 bytes, 8 = 256 bytes, 9 = 512 bytes, ..., 31 = 2G
      parameter pf1_vf_bar3_size_hwtcl            = 22, // 7 = 128 bytes, 8 = 256 bytes, 9 = 512 bytes, ..., 31 = 2G
      parameter pf0_vf_bar4_size_hwtcl            = 22, // 7 = 128 bytes, 8 = 256 bytes, 9 = 512 bytes, ..., 31 = 2G
      parameter pf1_vf_bar4_size_hwtcl            = 22, // 7 = 128 bytes, 8 = 256 bytes, 9 = 512 bytes, ..., 31 = 2G
      parameter pf0_vf_bar5_size_hwtcl            = 22, // 7 = 128 bytes, 8 = 256 bytes, 9 = 512 bytes, ..., 31 = 2G
      parameter pf1_vf_bar5_size_hwtcl            = 22, // 7 = 128 bytes, 8 = 256 bytes, 9 = 512 bytes, ..., 31 = 2G

      parameter pf2_vf_bar0_present_hwtcl         = 1,  // 0 = not present, 1 = present
      parameter pf3_vf_bar0_present_hwtcl         = 1,  // 0 = not present, 1 = present
      parameter pf2_vf_bar1_present_hwtcl         = 1,  // 0 = not present, 1 = present
      parameter pf3_vf_bar1_present_hwtcl         = 1,  // 0 = not present, 1 = present
      parameter pf2_vf_bar2_present_hwtcl         = 1,  // 0 = not present, 1 = present
      parameter pf3_vf_bar2_present_hwtcl         = 1,  // 0 = not present, 1 = present
      parameter pf2_vf_bar3_present_hwtcl         = 1,  // 0 = not present, 1 = present
      parameter pf3_vf_bar3_present_hwtcl         = 1,  // 0 = not present, 1 = present
      parameter pf2_vf_bar4_present_hwtcl         = 1,  // 0 = not present, 1 = present
      parameter pf3_vf_bar4_present_hwtcl         = 1,  // 0 = not present, 1 = present
      parameter pf2_vf_bar5_present_hwtcl         = 1,  // 0 = not present, 1 = present
      parameter pf3_vf_bar5_present_hwtcl         = 1,  // 0 = not present, 1 = present
      parameter pf2_vf_bar0_type_hwtcl            = 0, // 0 = 32-bit addressing, 1 = 64-bit addressing
      parameter pf3_vf_bar0_type_hwtcl            = 0, // 0 = 32-bit addressing, 1 = 64-bit addressing
      parameter pf2_vf_bar2_type_hwtcl            = 1, // 0 = 32-bit addressing, 1 = 64-bit addressing
      parameter pf3_vf_bar2_type_hwtcl            = 1, // 0 = 32-bit addressing, 1 = 64-bit addressing
      parameter pf2_vf_bar4_type_hwtcl            = 1, // 0 = 32-bit addressing, 1 = 64-bit addressing
      parameter pf3_vf_bar4_type_hwtcl            = 1, // 0 = 32-bit addressing, 1 = 64-bit addressing
      parameter pf2_vf_bar0_prefetchable_hwtcl    = 0, // 0 = non-prefetchable, 1 = prefetchable
      parameter pf3_vf_bar0_prefetchable_hwtcl    = 0, // 0 = non-prefetchable, 1 = prefetchable
      parameter pf2_vf_bar1_prefetchable_hwtcl    = 0, // 0 = non-prefetchable, 1 = prefetchable
      parameter pf3_vf_bar1_prefetchable_hwtcl    = 0, // 0 = non-prefetchable, 1 = prefetchable
      parameter pf2_vf_bar2_prefetchable_hwtcl    = 1, // 0 = non-prefetchable, 1 = prefetchable
      parameter pf3_vf_bar2_prefetchable_hwtcl    = 1, // 0 = non-prefetchable, 1 = prefetchable
      parameter pf2_vf_bar3_prefetchable_hwtcl    = 1, // 0 = non-prefetchable, 1 = prefetchable
      parameter pf3_vf_bar3_prefetchable_hwtcl    = 1, // 0 = non-prefetchable, 1 = prefetchable
      parameter pf2_vf_bar4_prefetchable_hwtcl    = 1, // 0 = non-prefetchable, 1 = prefetchable
      parameter pf3_vf_bar4_prefetchable_hwtcl    = 1, // 0 = non-prefetchable, 1 = prefetchable
      parameter pf2_vf_bar5_prefetchable_hwtcl    = 1, // 0 = non-prefetchable, 1 = prefetchable
      parameter pf3_vf_bar5_prefetchable_hwtcl    = 1, // 0 = non-prefetchable, 1 = prefetchable
      parameter pf2_vf_bar0_size_hwtcl            = 22, // 7 = 128 bytes, 8 = 256 bytes, 9 = 512 bytes, ..., 31 = 2G
      parameter pf3_vf_bar0_size_hwtcl            = 22, // 7 = 128 bytes, 8 = 256 bytes, 9 = 512 bytes, ..., 31 = 2G
      parameter pf2_vf_bar1_size_hwtcl            = 22, // 7 = 128 bytes, 8 = 256 bytes, 9 = 512 bytes, ..., 31 = 2G
      parameter pf3_vf_bar1_size_hwtcl            = 22, // 7 = 128 bytes, 8 = 256 bytes, 9 = 512 bytes, ..., 31 = 2G
      parameter pf2_vf_bar2_size_hwtcl            = 22, // 7 = 128 bytes, 8 = 256 bytes, 9 = 512 bytes, ..., 31 = 2G
      parameter pf3_vf_bar2_size_hwtcl            = 22, // 7 = 128 bytes, 8 = 256 bytes, 9 = 512 bytes, ..., 31 = 2G
      parameter pf2_vf_bar3_size_hwtcl            = 22, // 7 = 128 bytes, 8 = 256 bytes, 9 = 512 bytes, ..., 31 = 2G
      parameter pf3_vf_bar3_size_hwtcl            = 22, // 7 = 128 bytes, 8 = 256 bytes, 9 = 512 bytes, ..., 31 = 2G
      parameter pf2_vf_bar4_size_hwtcl            = 22, // 7 = 128 bytes, 8 = 256 bytes, 9 = 512 bytes, ..., 31 = 2G
      parameter pf3_vf_bar4_size_hwtcl            = 22, // 7 = 128 bytes, 8 = 256 bytes, 9 = 512 bytes, ..., 31 = 2G
      parameter pf2_vf_bar5_size_hwtcl            = 22, // 7 = 128 bytes, 8 = 256 bytes, 9 = 512 bytes, ..., 31 = 2G
      parameter pf3_vf_bar5_size_hwtcl            = 22, // 7 = 128 bytes, 8 = 256 bytes, 9 = 512 bytes, ..., 31 = 2G
      parameter pf_tph_support_hwtcl                           = 1,
      parameter pf0_tph_int_mode_support_hwtcl                 = 1,
      parameter pf1_tph_int_mode_support_hwtcl                 = 1,
      parameter pf2_tph_int_mode_support_hwtcl                 = 1,
      parameter pf3_tph_int_mode_support_hwtcl                 = 1,
      parameter pf0_tph_dev_specific_mode_support_hwtcl        = 1,
      parameter pf1_tph_dev_specific_mode_support_hwtcl        = 1,
      parameter pf2_tph_dev_specific_mode_support_hwtcl        = 1,
      parameter pf3_tph_dev_specific_mode_support_hwtcl        = 1,
      parameter pf0_tph_st_table_location_hwtcl                = 0,
      parameter pf1_tph_st_table_location_hwtcl                = 0,
      parameter pf2_tph_st_table_location_hwtcl                = 0,
      parameter pf3_tph_st_table_location_hwtcl                = 0,
      parameter pf0_tph_st_table_size_hwtcl                    = 63,
      parameter pf1_tph_st_table_size_hwtcl                    = 63,
      parameter pf2_tph_st_table_size_hwtcl                    = 63,
      parameter pf3_tph_st_table_size_hwtcl                    = 63,
      parameter vf_tph_support_hwtcl                           = 1,
      parameter pf0_vf_tph_int_mode_support_hwtcl              = 1,
      parameter pf1_vf_tph_int_mode_support_hwtcl              = 1,
      parameter pf2_vf_tph_int_mode_support_hwtcl              = 1,
      parameter pf3_vf_tph_int_mode_support_hwtcl              = 1,
      parameter pf0_vf_tph_dev_specific_mode_support_hwtcl     = 1,
      parameter pf1_vf_tph_dev_specific_mode_support_hwtcl     = 1,
      parameter pf2_vf_tph_dev_specific_mode_support_hwtcl     = 1,
      parameter pf3_vf_tph_dev_specific_mode_support_hwtcl     = 1,
      parameter pf0_vf_tph_st_table_location_hwtcl             = 0,
      parameter pf1_vf_tph_st_table_location_hwtcl             = 0,
      parameter pf2_vf_tph_st_table_location_hwtcl             = 0,
      parameter pf3_vf_tph_st_table_location_hwtcl             = 0,
      parameter pf0_vf_tph_st_table_size_hwtcl                 = 63,
      parameter pf1_vf_tph_st_table_size_hwtcl                 = 63,
      parameter pf2_vf_tph_st_table_size_hwtcl                 = 63,
      parameter pf3_vf_tph_st_table_size_hwtcl                 = 63,
      parameter pf_ats_support_hwtcl                           = 1,
      parameter pf0_ats_invalidate_queue_depth_hwtcl           = 0,
      parameter pf1_ats_invalidate_queue_depth_hwtcl           = 0,
      parameter pf2_ats_invalidate_queue_depth_hwtcl           = 0,
      parameter pf3_ats_invalidate_queue_depth_hwtcl           = 0,
      parameter vf_ats_support_hwtcl                           = 1,
     //****************************************************************************************************
     // VirtIO Specific Parameters PF0
     //****************************************************************************************************   
      parameter pf0_virtio_capability_present_hwtcl                = 0,            //Indicates VIRTIO Capability is Present             
      parameter pf0_virtio_device_specific_cap_present_hwtcl       = 0,            //This is optional capability for VIRTIO
               
      parameter pf0_virtio_cmn_config_bar_indicator_hwtcl          = 8'h00,        //Indicates BAR holding the Common Config Structure
      parameter pf0_virtio_notification_bar_indicator_hwtcl        = 8'h00,        //Indicates BAR holding the Notification Structure
      parameter pf0_virtio_isrstatus_bar_indicator_hwtcl           = 8'h00,        //Indicates BAR holding the ISR STATUS Structure 
      parameter pf0_virtio_pciconfig_access_bar_indicator_hwtcl    = 8'h00,        //Indicates BAR holding the PCI Config Access Structure 
      parameter pf0_virtio_devspecific_bar_indicator_hwtcl         = 8'h00,        //Indicates BAR holding the Device Specific Configuration Structure    
                                                                 
      parameter pf0_virtio_cmn_config_bar_offset_hwtcl             = 32'h00000000, //Indicates Starting position of Common Config Structure in given BAR
      parameter pf0_virtio_notification_bar_offset_hwtcl           = 32'h00000000, //Indicates Starting position of Notification Structure in given BAR
      parameter pf0_virtio_isrstatus_bar_offset_hwtcl              = 32'h00000000, //Indicates Starting position of ISR STATUS Structure in given BAR
      parameter pf0_virtio_pciconfig_access_bar_offset_hwtcl       = 32'h00000000, //Indicates Starting position of PCI Config Access Structure in given BAR
      parameter pf0_virtio_devspecific_bar_offset_hwtcl            = 32'h00000000, //Indicates Starting position of Device Specific Configuration Structure in given BAR
                                                                 
      parameter pf0_virtio_cmn_config_structure_length_hwtcl       = 32'h00000008, //Indicates length of Common Config Structure
      parameter pf0_virtio_notification_structure_length_hwtcl     = 32'h00000008, //Indicates length of Notification Structure
      parameter pf0_virtio_isrstatus_structure_length_hwtcl        = 32'h00000008, //Indicates length of ISR STATUS Structure 
      parameter pf0_virtio_pciconfig_access_structure_length_hwtcl = 32'h00000008, //Indicates length of PCI Config Access Structure 
      parameter pf0_virtio_devspecific_structure_length_hwtcl      = 32'h00000008, //Indicates length of Device Specific Configuration Structure  
      parameter pf0_virtio_notify_off_multiplier_hwtcl             = 32'h00000008, //Indicates Multiplier for queue_notify_off  
     //****************************************************************************************************
     // VirtIO Specific Parameters PF1
     //****************************************************************************************************   
      parameter pf1_virtio_capability_present_hwtcl                = 0,            //Indicates VIRTIO Capability is Present             
      parameter pf1_virtio_device_specific_cap_present_hwtcl       = 0,            //This is optional capability for VIRTIO
               
      parameter pf1_virtio_cmn_config_bar_indicator_hwtcl          = 8'h00,        //Indicates BAR holding the Common Config Structure
      parameter pf1_virtio_notification_bar_indicator_hwtcl        = 8'h00,        //Indicates BAR holding the Notification Structure
      parameter pf1_virtio_isrstatus_bar_indicator_hwtcl           = 8'h00,        //Indicates BAR holding the ISR STATUS Structure 
      parameter pf1_virtio_pciconfig_access_bar_indicator_hwtcl    = 8'h00,        //Indicates BAR holding the PCI Config Access Structure 
      parameter pf1_virtio_devspecific_bar_indicator_hwtcl         = 8'h00,        //Indicates BAR holding the Device Specific Configuration Structure    
                                                                 
      parameter pf1_virtio_cmn_config_bar_offset_hwtcl             = 32'h00000000, //Indicates Starting position of Common Config Structure in given BAR
      parameter pf1_virtio_notification_bar_offset_hwtcl           = 32'h00000000, //Indicates Starting position of Notification Structure in given BAR
      parameter pf1_virtio_isrstatus_bar_offset_hwtcl              = 32'h00000000, //Indicates Starting position of ISR STATUS Structure in given BAR
      parameter pf1_virtio_pciconfig_access_bar_offset_hwtcl       = 32'h00000000, //Indicates Starting position of PCI Config Access Structure in given BAR
      parameter pf1_virtio_devspecific_bar_offset_hwtcl            = 32'h00000000, //Indicates Starting position of Device Specific Configuration Structure in given BAR
                                                                 
      parameter pf1_virtio_cmn_config_structure_length_hwtcl       = 32'h00000008, //Indicates length of Common Config Structure
      parameter pf1_virtio_notification_structure_length_hwtcl     = 32'h00000008, //Indicates length of Notification Structure
      parameter pf1_virtio_isrstatus_structure_length_hwtcl        = 32'h00000008, //Indicates length of ISR STATUS Structure 
      parameter pf1_virtio_pciconfig_access_structure_length_hwtcl = 32'h00000008, //Indicates length of PCI Config Access Structure 
      parameter pf1_virtio_devspecific_structure_length_hwtcl      = 32'h00000008, //Indicates length of Device Specific Configuration Structure  
      parameter pf1_virtio_notify_off_multiplier_hwtcl             = 32'h00000008, //Indicates Multiplier for queue_notify_off  
     //****************************************************************************************************
     // VirtIO Specific Parameters PF2
     //****************************************************************************************************   
      parameter pf2_virtio_capability_present_hwtcl                = 0,            //Indicates VIRTIO Capability is Present             
      parameter pf2_virtio_device_specific_cap_present_hwtcl       = 0,            //This is optional capability for VIRTIO
               
      parameter pf2_virtio_cmn_config_bar_indicator_hwtcl          = 8'h00,        //Indicates BAR holding the Common Config Structure
      parameter pf2_virtio_notification_bar_indicator_hwtcl        = 8'h00,        //Indicates BAR holding the Notification Structure
      parameter pf2_virtio_isrstatus_bar_indicator_hwtcl           = 8'h00,        //Indicates BAR holding the ISR STATUS Structure 
      parameter pf2_virtio_pciconfig_access_bar_indicator_hwtcl    = 8'h00,        //Indicates BAR holding the PCI Config Access Structure 
      parameter pf2_virtio_devspecific_bar_indicator_hwtcl         = 8'h00,        //Indicates BAR holding the Device Specific Configuration Structure    
                                                                 
      parameter pf2_virtio_cmn_config_bar_offset_hwtcl             = 32'h00000000, //Indicates Starting position of Common Config Structure in given BAR
      parameter pf2_virtio_notification_bar_offset_hwtcl           = 32'h00000000, //Indicates Starting position of Notification Structure in given BAR
      parameter pf2_virtio_isrstatus_bar_offset_hwtcl              = 32'h00000000, //Indicates Starting position of ISR STATUS Structure in given BAR
      parameter pf2_virtio_pciconfig_access_bar_offset_hwtcl       = 32'h00000000, //Indicates Starting position of PCI Config Access Structure in given BAR
      parameter pf2_virtio_devspecific_bar_offset_hwtcl            = 32'h00000000, //Indicates Starting position of Device Specific Configuration Structure in given BAR
                                                                 
      parameter pf2_virtio_cmn_config_structure_length_hwtcl       = 32'h00000008, //Indicates length of Common Config Structure
      parameter pf2_virtio_notification_structure_length_hwtcl     = 32'h00000008, //Indicates length of Notification Structure
      parameter pf2_virtio_isrstatus_structure_length_hwtcl        = 32'h00000008, //Indicates length of ISR STATUS Structure 
      parameter pf2_virtio_pciconfig_access_structure_length_hwtcl = 32'h00000008, //Indicates length of PCI Config Access Structure 
      parameter pf2_virtio_devspecific_structure_length_hwtcl      = 32'h00000008, //Indicates length of Device Specific Configuration Structure  
      parameter pf2_virtio_notify_off_multiplier_hwtcl             = 32'h00000008, //Indicates Multiplier for queue_notify_off  
     //****************************************************************************************************
     // VirtIO Specific Parameters PF3
     //****************************************************************************************************   
      parameter pf3_virtio_capability_present_hwtcl                = 0,            //Indicates VIRTIO Capability is Present             
      parameter pf3_virtio_device_specific_cap_present_hwtcl       = 0,            //This is optional capability for VIRTIO
               
      parameter pf3_virtio_cmn_config_bar_indicator_hwtcl          = 8'h00,        //Indicates BAR holding the Common Config Structure
      parameter pf3_virtio_notification_bar_indicator_hwtcl        = 8'h00,        //Indicates BAR holding the Notification Structure
      parameter pf3_virtio_isrstatus_bar_indicator_hwtcl           = 8'h00,        //Indicates BAR holding the ISR STATUS Structure 
      parameter pf3_virtio_pciconfig_access_bar_indicator_hwtcl    = 8'h00,        //Indicates BAR holding the PCI Config Access Structure 
      parameter pf3_virtio_devspecific_bar_indicator_hwtcl         = 8'h00,        //Indicates BAR holding the Device Specific Configuration Structure    
                                                                 
      parameter pf3_virtio_cmn_config_bar_offset_hwtcl             = 32'h00000000, //Indicates Starting position of Common Config Structure in given BAR
      parameter pf3_virtio_notification_bar_offset_hwtcl           = 32'h00000000, //Indicates Starting position of Notification Structure in given BAR
      parameter pf3_virtio_isrstatus_bar_offset_hwtcl              = 32'h00000000, //Indicates Starting position of ISR STATUS Structure in given BAR
      parameter pf3_virtio_pciconfig_access_bar_offset_hwtcl       = 32'h00000000, //Indicates Starting position of PCI Config Access Structure in given BAR
      parameter pf3_virtio_devspecific_bar_offset_hwtcl            = 32'h00000000, //Indicates Starting position of Device Specific Configuration Structure in given BAR
                                                                 
      parameter pf3_virtio_cmn_config_structure_length_hwtcl       = 32'h00000008, //Indicates length of Common Config Structure
      parameter pf3_virtio_notification_structure_length_hwtcl     = 32'h00000008, //Indicates length of Notification Structure
      parameter pf3_virtio_isrstatus_structure_length_hwtcl        = 32'h00000008, //Indicates length of ISR STATUS Structure 
      parameter pf3_virtio_pciconfig_access_structure_length_hwtcl = 32'h00000008, //Indicates length of PCI Config Access Structure 
      parameter pf3_virtio_devspecific_structure_length_hwtcl      = 32'h00000008, //Indicates length of Device Specific Configuration Structure  
      parameter pf3_virtio_notify_off_multiplier_hwtcl             = 32'h00000008, //Indicates Multiplier for queue_notify_off  
     //****************************************************************************************************
     // VirtIO Specific Parameters PF4
     //****************************************************************************************************   
      parameter pf4_virtio_capability_present_hwtcl                = 0,            //Indicates VIRTIO Capability is Present             
      parameter pf4_virtio_device_specific_cap_present_hwtcl       = 0,            //This is optional capability for VIRTIO
               
      parameter pf4_virtio_cmn_config_bar_indicator_hwtcl          = 8'h00,        //Indicates BAR holding the Common Config Structure
      parameter pf4_virtio_notification_bar_indicator_hwtcl        = 8'h00,        //Indicates BAR holding the Notification Structure
      parameter pf4_virtio_isrstatus_bar_indicator_hwtcl           = 8'h00,        //Indicates BAR holding the ISR STATUS Structure 
      parameter pf4_virtio_pciconfig_access_bar_indicator_hwtcl    = 8'h00,        //Indicates BAR holding the PCI Config Access Structure 
      parameter pf4_virtio_devspecific_bar_indicator_hwtcl         = 8'h00,        //Indicates BAR holding the Device Specific Configuration Structure    
                                                                 
      parameter pf4_virtio_cmn_config_bar_offset_hwtcl             = 32'h00000000, //Indicates Starting position of Common Config Structure in given BAR
      parameter pf4_virtio_notification_bar_offset_hwtcl           = 32'h00000000, //Indicates Starting position of Notification Structure in given BAR
      parameter pf4_virtio_isrstatus_bar_offset_hwtcl              = 32'h00000000, //Indicates Starting position of ISR STATUS Structure in given BAR
      parameter pf4_virtio_pciconfig_access_bar_offset_hwtcl       = 32'h00000000, //Indicates Starting position of PCI Config Access Structure in given BAR
      parameter pf4_virtio_devspecific_bar_offset_hwtcl            = 32'h00000000, //Indicates Starting position of Device Specific Configuration Structure in given BAR
                                                                 
      parameter pf4_virtio_cmn_config_structure_length_hwtcl       = 32'h00000008, //Indicates length of Common Config Structure
      parameter pf4_virtio_notification_structure_length_hwtcl     = 32'h00000008, //Indicates length of Notification Structure
      parameter pf4_virtio_isrstatus_structure_length_hwtcl        = 32'h00000008, //Indicates length of ISR STATUS Structure 
      parameter pf4_virtio_pciconfig_access_structure_length_hwtcl = 32'h00000008, //Indicates length of PCI Config Access Structure 
      parameter pf4_virtio_devspecific_structure_length_hwtcl      = 32'h00000008, //Indicates length of Device Specific Configuration Structure  
      parameter pf4_virtio_notify_off_multiplier_hwtcl             = 32'h00000008, //Indicates Multiplier for queue_notify_off  
     //****************************************************************************************************
     // VirtIO Specific Parameters PF5
     //****************************************************************************************************   
      parameter pf5_virtio_capability_present_hwtcl                = 0,            //Indicates VIRTIO Capability is Present             
      parameter pf5_virtio_device_specific_cap_present_hwtcl       = 0,            //This is optional capability for VIRTIO
               
      parameter pf5_virtio_cmn_config_bar_indicator_hwtcl          = 8'h00,        //Indicates BAR holding the Common Config Structure
      parameter pf5_virtio_notification_bar_indicator_hwtcl        = 8'h00,        //Indicates BAR holding the Notification Structure
      parameter pf5_virtio_isrstatus_bar_indicator_hwtcl           = 8'h00,        //Indicates BAR holding the ISR STATUS Structure 
      parameter pf5_virtio_pciconfig_access_bar_indicator_hwtcl    = 8'h00,        //Indicates BAR holding the PCI Config Access Structure 
      parameter pf5_virtio_devspecific_bar_indicator_hwtcl         = 8'h00,        //Indicates BAR holding the Device Specific Configuration Structure    
                                                                 
      parameter pf5_virtio_cmn_config_bar_offset_hwtcl             = 32'h00000000, //Indicates Starting position of Common Config Structure in given BAR
      parameter pf5_virtio_notification_bar_offset_hwtcl           = 32'h00000000, //Indicates Starting position of Notification Structure in given BAR
      parameter pf5_virtio_isrstatus_bar_offset_hwtcl              = 32'h00000000, //Indicates Starting position of ISR STATUS Structure in given BAR
      parameter pf5_virtio_pciconfig_access_bar_offset_hwtcl       = 32'h00000000, //Indicates Starting position of PCI Config Access Structure in given BAR
      parameter pf5_virtio_devspecific_bar_offset_hwtcl            = 32'h00000000, //Indicates Starting position of Device Specific Configuration Structure in given BAR
                                                                 
      parameter pf5_virtio_cmn_config_structure_length_hwtcl       = 32'h00000008, //Indicates length of Common Config Structure
      parameter pf5_virtio_notification_structure_length_hwtcl     = 32'h00000008, //Indicates length of Notification Structure
      parameter pf5_virtio_isrstatus_structure_length_hwtcl        = 32'h00000008, //Indicates length of ISR STATUS Structure 
      parameter pf5_virtio_pciconfig_access_structure_length_hwtcl = 32'h00000008, //Indicates length of PCI Config Access Structure 
      parameter pf5_virtio_devspecific_structure_length_hwtcl      = 32'h00000008, //Indicates length of Device Specific Configuration Structure  
      parameter pf5_virtio_notify_off_multiplier_hwtcl             = 32'h00000008, //Indicates Multiplier for queue_notify_off  
     //****************************************************************************************************
     // VirtIO Specific Parameters PF6
     //****************************************************************************************************   
      parameter pf6_virtio_capability_present_hwtcl                = 0,            //Indicates VIRTIO Capability is Present             
      parameter pf6_virtio_device_specific_cap_present_hwtcl       = 0,            //This is optional capability for VIRTIO
               
      parameter pf6_virtio_cmn_config_bar_indicator_hwtcl          = 8'h00,        //Indicates BAR holding the Common Config Structure
      parameter pf6_virtio_notification_bar_indicator_hwtcl        = 8'h00,        //Indicates BAR holding the Notification Structure
      parameter pf6_virtio_isrstatus_bar_indicator_hwtcl           = 8'h00,        //Indicates BAR holding the ISR STATUS Structure 
      parameter pf6_virtio_pciconfig_access_bar_indicator_hwtcl    = 8'h00,        //Indicates BAR holding the PCI Config Access Structure 
      parameter pf6_virtio_devspecific_bar_indicator_hwtcl         = 8'h00,        //Indicates BAR holding the Device Specific Configuration Structure    
                                                                 
      parameter pf6_virtio_cmn_config_bar_offset_hwtcl             = 32'h00000000, //Indicates Starting position of Common Config Structure in given BAR
      parameter pf6_virtio_notification_bar_offset_hwtcl           = 32'h00000000, //Indicates Starting position of Notification Structure in given BAR
      parameter pf6_virtio_isrstatus_bar_offset_hwtcl              = 32'h00000000, //Indicates Starting position of ISR STATUS Structure in given BAR
      parameter pf6_virtio_pciconfig_access_bar_offset_hwtcl       = 32'h00000000, //Indicates Starting position of PCI Config Access Structure in given BAR
      parameter pf6_virtio_devspecific_bar_offset_hwtcl            = 32'h00000000, //Indicates Starting position of Device Specific Configuration Structure in given BAR
                                                                 
      parameter pf6_virtio_cmn_config_structure_length_hwtcl       = 32'h00000008, //Indicates length of Common Config Structure
      parameter pf6_virtio_notification_structure_length_hwtcl     = 32'h00000008, //Indicates length of Notification Structure
      parameter pf6_virtio_isrstatus_structure_length_hwtcl        = 32'h00000008, //Indicates length of ISR STATUS Structure 
      parameter pf6_virtio_pciconfig_access_structure_length_hwtcl = 32'h00000008, //Indicates length of PCI Config Access Structure 
      parameter pf6_virtio_devspecific_structure_length_hwtcl      = 32'h00000008, //Indicates length of Device Specific Configuration Structure  
      parameter pf6_virtio_notify_off_multiplier_hwtcl             = 32'h00000008, //Indicates Multiplier for queue_notify_off  
     //****************************************************************************************************
     // VirtIO Specific Parameters PF7
     //****************************************************************************************************   
      parameter pf7_virtio_capability_present_hwtcl                = 0,            //Indicates VIRTIO Capability is Present             
      parameter pf7_virtio_device_specific_cap_present_hwtcl       = 0,            //This is optional capability for VIRTIO
               
      parameter pf7_virtio_cmn_config_bar_indicator_hwtcl          = 8'h00,        //Indicates BAR holding the Common Config Structure
      parameter pf7_virtio_notification_bar_indicator_hwtcl        = 8'h00,        //Indicates BAR holding the Notification Structure
      parameter pf7_virtio_isrstatus_bar_indicator_hwtcl           = 8'h00,        //Indicates BAR holding the ISR STATUS Structure 
      parameter pf7_virtio_pciconfig_access_bar_indicator_hwtcl    = 8'h00,        //Indicates BAR holding the PCI Config Access Structure 
      parameter pf7_virtio_devspecific_bar_indicator_hwtcl         = 8'h00,        //Indicates BAR holding the Device Specific Configuration Structure    
                                                                 
      parameter pf7_virtio_cmn_config_bar_offset_hwtcl             = 32'h00000000, //Indicates Starting position of Common Config Structure in given BAR
      parameter pf7_virtio_notification_bar_offset_hwtcl           = 32'h00000000, //Indicates Starting position of Notification Structure in given BAR
      parameter pf7_virtio_isrstatus_bar_offset_hwtcl              = 32'h00000000, //Indicates Starting position of ISR STATUS Structure in given BAR
      parameter pf7_virtio_pciconfig_access_bar_offset_hwtcl       = 32'h00000000, //Indicates Starting position of PCI Config Access Structure in given BAR
      parameter pf7_virtio_devspecific_bar_offset_hwtcl            = 32'h00000000, //Indicates Starting position of Device Specific Configuration Structure in given BAR
                                                                 
      parameter pf7_virtio_cmn_config_structure_length_hwtcl       = 32'h00000008, //Indicates length of Common Config Structure
      parameter pf7_virtio_notification_structure_length_hwtcl     = 32'h00000008, //Indicates length of Notification Structure
      parameter pf7_virtio_isrstatus_structure_length_hwtcl        = 32'h00000008, //Indicates length of ISR STATUS Structure 
      parameter pf7_virtio_pciconfig_access_structure_length_hwtcl = 32'h00000008, //Indicates length of PCI Config Access Structure 
      parameter pf7_virtio_devspecific_structure_length_hwtcl      = 32'h00000008, //Indicates length of Device Specific Configuration Structure  
      parameter pf7_virtio_notify_off_multiplier_hwtcl             = 32'h00000008, //Indicates Multiplier for queue_notify_off  
     //****************************************************************************************************
     // VirtIO Specific Parameters PF0 VFs
     //****************************************************************************************************   
      parameter pf0vf_virtio_capability_present_hwtcl                = 0,            //Indicates VIRTIO Capability is Present             
      parameter pf0vf_virtio_device_specific_cap_present_hwtcl       = 0,            //This is optional capability for VIRTIO
               
      parameter pf0vf_virtio_cmn_config_bar_indicator_hwtcl          = 8'h00,        //Indicates BAR holding the Common Config Structure
      parameter pf0vf_virtio_notification_bar_indicator_hwtcl        = 8'h00,        //Indicates BAR holding the Notification Structure
      parameter pf0vf_virtio_isrstatus_bar_indicator_hwtcl           = 8'h00,        //Indicates BAR holding the ISR STATUS Structure 
      parameter pf0vf_virtio_pciconfig_access_bar_indicator_hwtcl    = 8'h00,        //Indicates BAR holding the PCI Config Access Structure 
      parameter pf0vf_virtio_devspecific_bar_indicator_hwtcl         = 8'h00,        //Indicates BAR holding the Device Specific Configuration Structure    
                                                                 
      parameter pf0vf_virtio_cmn_config_bar_offset_hwtcl             = 32'h00000000, //Indicates Starting position of Common Config Structure in given BAR
      parameter pf0vf_virtio_notification_bar_offset_hwtcl           = 32'h00000000, //Indicates Starting position of Notification Structure in given BAR
      parameter pf0vf_virtio_isrstatus_bar_offset_hwtcl              = 32'h00000000, //Indicates Starting position of ISR STATUS Structure in given BAR
      parameter pf0vf_virtio_pciconfig_access_bar_offset_hwtcl       = 32'h00000000, //Indicates Starting position of PCI Config Access Structure in given BAR
      parameter pf0vf_virtio_devspecific_bar_offset_hwtcl            = 32'h00000000, //Indicates Starting position of Device Specific Configuration Structure in given BAR
                                                                 
      parameter pf0vf_virtio_cmn_config_structure_length_hwtcl       = 32'h00000008, //Indicates length of Common Config Structure
      parameter pf0vf_virtio_notification_structure_length_hwtcl     = 32'h00000008, //Indicates length of Notification Structure
      parameter pf0vf_virtio_isrstatus_structure_length_hwtcl        = 32'h00000008, //Indicates length of ISR STATUS Structure 
      parameter pf0vf_virtio_pciconfig_access_structure_length_hwtcl = 32'h00000008, //Indicates length of PCI Config Access Structure 
      parameter pf0vf_virtio_devspecific_structure_length_hwtcl      = 32'h00000008, //Indicates length of Device Specific Configuration Structure  
      parameter pf0vf_virtio_notify_off_multiplier_hwtcl             = 32'h00000008, //Indicates Multiplier for queue_notify_off  
     //****************************************************************************************************
     // VirtIO Specific Parameters PF1 VFs
     //****************************************************************************************************   
      parameter pf1vf_virtio_capability_present_hwtcl                = 0,            //Indicates VIRTIO Capability is Present             
      parameter pf1vf_virtio_device_specific_cap_present_hwtcl       = 0,            //This is optional capability for VIRTIO
               
      parameter pf1vf_virtio_cmn_config_bar_indicator_hwtcl          = 8'h00,        //Indicates BAR holding the Common Config Structure
      parameter pf1vf_virtio_notification_bar_indicator_hwtcl        = 8'h00,        //Indicates BAR holding the Notification Structure
      parameter pf1vf_virtio_isrstatus_bar_indicator_hwtcl           = 8'h00,        //Indicates BAR holding the ISR STATUS Structure 
      parameter pf1vf_virtio_pciconfig_access_bar_indicator_hwtcl    = 8'h00,        //Indicates BAR holding the PCI Config Access Structure 
      parameter pf1vf_virtio_devspecific_bar_indicator_hwtcl         = 8'h00,        //Indicates BAR holding the Device Specific Configuration Structure    
                                                                 
      parameter pf1vf_virtio_cmn_config_bar_offset_hwtcl             = 32'h00000000, //Indicates Starting position of Common Config Structure in given BAR
      parameter pf1vf_virtio_notification_bar_offset_hwtcl           = 32'h00000000, //Indicates Starting position of Notification Structure in given BAR
      parameter pf1vf_virtio_isrstatus_bar_offset_hwtcl              = 32'h00000000, //Indicates Starting position of ISR STATUS Structure in given BAR
      parameter pf1vf_virtio_pciconfig_access_bar_offset_hwtcl       = 32'h00000000, //Indicates Starting position of PCI Config Access Structure in given BAR
      parameter pf1vf_virtio_devspecific_bar_offset_hwtcl            = 32'h00000000, //Indicates Starting position of Device Specific Configuration Structure in given BAR
                                                                 
      parameter pf1vf_virtio_cmn_config_structure_length_hwtcl       = 32'h00000008, //Indicates length of Common Config Structure
      parameter pf1vf_virtio_notification_structure_length_hwtcl     = 32'h00000008, //Indicates length of Notification Structure
      parameter pf1vf_virtio_isrstatus_structure_length_hwtcl        = 32'h00000008, //Indicates length of ISR STATUS Structure 
      parameter pf1vf_virtio_pciconfig_access_structure_length_hwtcl = 32'h00000008, //Indicates length of PCI Config Access Structure 
      parameter pf1vf_virtio_devspecific_structure_length_hwtcl      = 32'h00000008, //Indicates length of Device Specific Configuration Structure  
      parameter pf1vf_virtio_notify_off_multiplier_hwtcl             = 32'h00000008, //Indicates Multiplier for queue_notify_off  
     //****************************************************************************************************
     // VirtIO Specific Parameters PF2 VFs
     //****************************************************************************************************   
      parameter pf2vf_virtio_capability_present_hwtcl                = 0,            //Indicates VIRTIO Capability is Present             
      parameter pf2vf_virtio_device_specific_cap_present_hwtcl       = 0,            //This is optional capability for VIRTIO
               
      parameter pf2vf_virtio_cmn_config_bar_indicator_hwtcl          = 8'h00,        //Indicates BAR holding the Common Config Structure
      parameter pf2vf_virtio_notification_bar_indicator_hwtcl        = 8'h00,        //Indicates BAR holding the Notification Structure
      parameter pf2vf_virtio_isrstatus_bar_indicator_hwtcl           = 8'h00,        //Indicates BAR holding the ISR STATUS Structure 
      parameter pf2vf_virtio_pciconfig_access_bar_indicator_hwtcl    = 8'h00,        //Indicates BAR holding the PCI Config Access Structure 
      parameter pf2vf_virtio_devspecific_bar_indicator_hwtcl         = 8'h00,        //Indicates BAR holding the Device Specific Configuration Structure    
                                                                 
      parameter pf2vf_virtio_cmn_config_bar_offset_hwtcl             = 32'h00000000, //Indicates Starting position of Common Config Structure in given BAR
      parameter pf2vf_virtio_notification_bar_offset_hwtcl           = 32'h00000000, //Indicates Starting position of Notification Structure in given BAR
      parameter pf2vf_virtio_isrstatus_bar_offset_hwtcl              = 32'h00000000, //Indicates Starting position of ISR STATUS Structure in given BAR
      parameter pf2vf_virtio_pciconfig_access_bar_offset_hwtcl       = 32'h00000000, //Indicates Starting position of PCI Config Access Structure in given BAR
      parameter pf2vf_virtio_devspecific_bar_offset_hwtcl            = 32'h00000000, //Indicates Starting position of Device Specific Configuration Structure in given BAR
                                                                 
      parameter pf2vf_virtio_cmn_config_structure_length_hwtcl       = 32'h00000008, //Indicates length of Common Config Structure
      parameter pf2vf_virtio_notification_structure_length_hwtcl     = 32'h00000008, //Indicates length of Notification Structure
      parameter pf2vf_virtio_isrstatus_structure_length_hwtcl        = 32'h00000008, //Indicates length of ISR STATUS Structure 
      parameter pf2vf_virtio_pciconfig_access_structure_length_hwtcl = 32'h00000008, //Indicates length of PCI Config Access Structure 
      parameter pf2vf_virtio_devspecific_structure_length_hwtcl      = 32'h00000008, //Indicates length of Device Specific Configuration Structure  
      parameter pf2vf_virtio_notify_off_multiplier_hwtcl             = 32'h00000008, //Indicates Multiplier for queue_notify_off  
     //****************************************************************************************************
     // VirtIO Specific Parameters PF3 VFs
     //****************************************************************************************************   
      parameter pf3vf_virtio_capability_present_hwtcl                = 0,            //Indicates VIRTIO Capability is Present             
      parameter pf3vf_virtio_device_specific_cap_present_hwtcl       = 0,            //This is optional capability for VIRTIO
               
      parameter pf3vf_virtio_cmn_config_bar_indicator_hwtcl          = 8'h00,        //Indicates BAR holding the Common Config Structure
      parameter pf3vf_virtio_notification_bar_indicator_hwtcl        = 8'h00,        //Indicates BAR holding the Notification Structure
      parameter pf3vf_virtio_isrstatus_bar_indicator_hwtcl           = 8'h00,        //Indicates BAR holding the ISR STATUS Structure 
      parameter pf3vf_virtio_pciconfig_access_bar_indicator_hwtcl    = 8'h00,        //Indicates BAR holding the PCI Config Access Structure 
      parameter pf3vf_virtio_devspecific_bar_indicator_hwtcl         = 8'h00,        //Indicates BAR holding the Device Specific Configuration Structure    
                                                                 
      parameter pf3vf_virtio_cmn_config_bar_offset_hwtcl             = 32'h00000000, //Indicates Starting position of Common Config Structure in given BAR
      parameter pf3vf_virtio_notification_bar_offset_hwtcl           = 32'h00000000, //Indicates Starting position of Notification Structure in given BAR
      parameter pf3vf_virtio_isrstatus_bar_offset_hwtcl              = 32'h00000000, //Indicates Starting position of ISR STATUS Structure in given BAR
      parameter pf3vf_virtio_pciconfig_access_bar_offset_hwtcl       = 32'h00000000, //Indicates Starting position of PCI Config Access Structure in given BAR
      parameter pf3vf_virtio_devspecific_bar_offset_hwtcl            = 32'h00000000, //Indicates Starting position of Device Specific Configuration Structure in given BAR
                                                                 
      parameter pf3vf_virtio_cmn_config_structure_length_hwtcl       = 32'h00000008, //Indicates length of Common Config Structure
      parameter pf3vf_virtio_notification_structure_length_hwtcl     = 32'h00000008, //Indicates length of Notification Structure
      parameter pf3vf_virtio_isrstatus_structure_length_hwtcl        = 32'h00000008, //Indicates length of ISR STATUS Structure 
      parameter pf3vf_virtio_pciconfig_access_structure_length_hwtcl = 32'h00000008, //Indicates length of PCI Config Access Structure 
      parameter pf3vf_virtio_devspecific_structure_length_hwtcl      = 32'h00000008, //Indicates length of Device Specific Configuration Structure  
      parameter pf3vf_virtio_notify_off_multiplier_hwtcl             = 32'h00000008, //Indicates Multiplier for queue_notify_off  
      
      
      parameter enable_custom_features_hwtcl                   = 0,
      parameter pf0_extra_bar_present_hwtcl                    = 0,
      parameter pf0_extra_bar_size_hwtcl                       = 12,
      parameter devhide_support_hwtcl                          = 0,
      parameter device_embedded_ep_support_hwtcl               = 0,


      parameter lmi_width_hwtcl                   = 8,

      /////////////////////////////////////////////////////////////////////////////
      ///                        DEVKIT Conduit parameter                      ////
      /////////////////////////////////////////////////////////////////////////////
      parameter enable_devkit_conduit_hwtcl                    = 0,
      /////////////////////////////////////////////////////////////////////////////
      ///                        TLP Inspector Parameters                      ////
      /////////////////////////////////////////////////////////////////////////////
      parameter tlp_inspector_hwtcl                            = 0,
      parameter tlp_inspector_use_signal_probe_hwtcl           = 0,
      parameter tlp_inspector_use_thin_rx_master               = 0,
      parameter tlp_insp_trg_dw0_hwtcl                         = 2049,
      parameter tlp_insp_trg_dw1_hwtcl                         = 0,
      parameter tlp_insp_trg_dw2_hwtcl                         = 0,
      parameter tlp_insp_trg_dw3_hwtcl                         = 0,
      parameter pcie_inspector_hwtcl                           = 0,
      parameter export_phy_input_to_top_level_hwtcl            = 0,
      /////////////////////////////////////////////////////////////////////////////
      ///                       A10 HIP AST Translator                         ////
      /////////////////////////////////////////////////////////////////////////////
      // Translator Parameters
      parameter enable_ast_trs_hwtcl            = 0,
      parameter ast_trs_num_desc_hwtcl          = 16,
      parameter ast_trs_txdata_width_hwtcl      = 256,
      parameter ast_trs_txdesc_width_hwtcl      = 256,
      parameter ast_trs_txstatus_width_hwtcl    = 256,
      parameter ast_trs_txmty_width_hwtcl       = 32,
      parameter ast_trs_rxmty_width_hwtcl       = 32,
      parameter ast_trs_rxdata_width_hwtcl      = 256,
      parameter ast_trs_rxdesc_width_hwtcl      = 256,
      
      parameter enable_soft_dfe                                = 0,
      parameter adme_enable_hwtcl                              = 0,
      parameter rx_polinv_soft_logic_enable                    = 0,
      parameter enable_skp_det                                 = 0
) (
      // Control signals
      input  wire [31 : 0]       test_in,
      input  wire                simu_mode_pipe,

      // Reset signals
      input  wire                pin_perst,
      input  wire                npor,
      output wire                reset_status,
      output wire                serdes_pll_locked,
      output wire                pld_clk_inuse,
      input  wire                pld_core_ready,
      output wire                testin_zero,

      // Clock
      input  wire                pld_clk,

      // Serdes related
      input  wire                refclk,

      // HIP control signals
      input wire [4 : 0]         hpg_ctrler,

      // Input PIPE simulation _ext for simulation only
      output wire [1 : 0]        sim_pipe_rate,
      input  wire                sim_pipe_pclk_in,
      output wire                sim_pipe_pclk_out,
      output wire [4 : 0]        sim_ltssmstate,
      input  wire                phystatus0,
      input  wire                phystatus1,
      input  wire                phystatus2,
      input  wire                phystatus3,
      input  wire                phystatus4,
      input  wire                phystatus5,
      input  wire                phystatus6,
      input  wire                phystatus7,
      input  wire [31 : 0]       rxdata0,
      input  wire [31 : 0]       rxdata1,
      input  wire [31 : 0]       rxdata2,
      input  wire [31 : 0]       rxdata3,
      input  wire [31 : 0]       rxdata4,
      input  wire [31 : 0]       rxdata5,
      input  wire [31 : 0]       rxdata6,
      input  wire [31 : 0]       rxdata7,
      input  wire [ 3 : 0]       rxdatak0,
      input  wire [ 3 : 0]       rxdatak1,
      input  wire [ 3 : 0]       rxdatak2,
      input  wire [ 3 : 0]       rxdatak3,
      input  wire [ 3 : 0]       rxdatak4,
      input  wire [ 3 : 0]       rxdatak5,
      input  wire [ 3 : 0]       rxdatak6,
      input  wire [ 3 : 0]       rxdatak7,
      input  wire                rxelecidle0,
      input  wire                rxelecidle1,
      input  wire                rxelecidle2,
      input  wire                rxelecidle3,
      input  wire                rxelecidle4,
      input  wire                rxelecidle5,
      input  wire                rxelecidle6,
      input  wire                rxelecidle7,
      input  wire [2 : 0]        rxstatus0,
      input  wire [2 : 0]        rxstatus1,
      input  wire [2 : 0]        rxstatus2,
      input  wire [2 : 0]        rxstatus3,
      input  wire [2 : 0]        rxstatus4,
      input  wire [2 : 0]        rxstatus5,
      input  wire [2 : 0]        rxstatus6,
      input  wire [2 : 0]        rxstatus7,
      input  wire                rxdataskip0,
      input  wire                rxdataskip1,
      input  wire                rxdataskip2,
      input  wire                rxdataskip3,
      input  wire                rxdataskip4,
      input  wire                rxdataskip5,
      input  wire                rxdataskip6,
      input  wire                rxdataskip7,
      input  wire                rxblkst0,
      input  wire                rxblkst1,
      input  wire                rxblkst2,
      input  wire                rxblkst3,
      input  wire                rxblkst4,
      input  wire                rxblkst5,
      input  wire                rxblkst6,
      input  wire                rxblkst7,
      input  wire [1 : 0]        rxsynchd0,
      input  wire [1 : 0]        rxsynchd1,
      input  wire [1 : 0]        rxsynchd2,
      input  wire [1 : 0]        rxsynchd3,
      input  wire [1 : 0]        rxsynchd4,
      input  wire [1 : 0]        rxsynchd5,
      input  wire [1 : 0]        rxsynchd6,
      input  wire [1 : 0]        rxsynchd7,
      input  wire                rxvalid0,
      input  wire                rxvalid1,
      input  wire                rxvalid2,
      input  wire                rxvalid3,
      input  wire                rxvalid4,
      input  wire                rxvalid5,
      input  wire                rxvalid6,
      input  wire                rxvalid7,

      // Application signals inputs
      input wire  [4 : 0]        aer_msi_num,
      input wire                 app_int_sts,
      input wire  [total_pf_count_hwtcl-1 : 0]               app_int_pf_sts,
      input wire  [4 : 0]        app_msi_num,
      input wire                 app_msi_req,
      input wire  [2 : 0]        app_msi_tc,
      input wire  [4 : 0]        pex_msi_num,

      // rx_cred control
      input  [15 : 0]            rx_cred_ctl   ,
      output  [19 : 0]           rx_cred_status,

      input wire  [11 : 0]       lmi_addr,
      input wire  [lmi_width_hwtcl-1  : 0]  lmi_din,
      input wire                 lmi_rden,
      input wire                 lmi_wren,
      input wire                 pm_auxpwr,
      input wire  [9 : 0]        pm_data,
      input wire                 pme_to_cr,
      input wire                 pm_event,
      input wire                 rx_st_mask,
      input wire                 rx_st_ready,

      input wire [data_width_integer_hwtcl-1 : 0]          tx_st_data,
      input wire [empty_integer_hwtcl     -1 : 0]          tx_st_empty,
      input wire [multiple_packets_per_cycle_hwtcl :0]     tx_st_eop,
      input wire [multiple_packets_per_cycle_hwtcl :0]     tx_st_err,
      input wire [multiple_packets_per_cycle_hwtcl :0]     tx_st_sop,
      input wire [data_byte_width_integer_hwtcl -1:0]      tx_st_parity,
      input wire [multiple_packets_per_cycle_hwtcl :0]     tx_st_valid,

      input wire [6:0]           cpl_err,  // Error indications for Function 0 from user application
                                           // [0] = Completion timeout with recovery
                                           // [1] = Completion timeout without recovery
                                           // [2] = Completer Abort sent
                                           // [3] = Unexpected Completion received
                                           // [4] = Posted request received and flagged as UR
                                           // [5] = Non-Posted request received and flagged as UR
                                           // [6] = Header Logging enable (header supplied on log_hdr input)
      input wire                cpl_pending,


      // Output Pipe interface
      output wire [2 : 0]        eidleinfersel0,
      output wire [2 : 0]        eidleinfersel1,
      output wire [2 : 0]        eidleinfersel2,
      output wire [2 : 0]        eidleinfersel3,
      output wire [2 : 0]        eidleinfersel4,
      output wire [2 : 0]        eidleinfersel5,
      output wire [2 : 0]        eidleinfersel6,
      output wire [2 : 0]        eidleinfersel7,
      output wire [1 : 0]        powerdown0,
      output wire [1 : 0]        powerdown1,
      output wire [1 : 0]        powerdown2,
      output wire [1 : 0]        powerdown3,
      output wire [1 : 0]        powerdown4,
      output wire [1 : 0]        powerdown5,
      output wire [1 : 0]        powerdown6,
      output wire [1 : 0]        powerdown7,
      output wire                rxpolarity0,
      output wire                rxpolarity1,
      output wire                rxpolarity2,
      output wire                rxpolarity3,
      output wire                rxpolarity4,
      output wire                rxpolarity5,
      output wire                rxpolarity6,
      output wire                rxpolarity7,
      output wire                txcompl0,
      output wire                txcompl1,
      output wire                txcompl2,
      output wire                txcompl3,
      output wire                txcompl4,
      output wire                txcompl5,
      output wire                txcompl6,
      output wire                txcompl7,
      output wire [31: 0]        txdata0,
      output wire [31: 0]        txdata1,
      output wire [31: 0]        txdata2,
      output wire [31: 0]        txdata3,
      output wire [31: 0]        txdata4,
      output wire [31: 0]        txdata5,
      output wire [31: 0]        txdata6,
      output wire [31: 0]        txdata7,
      output wire [3 : 0]        txdatak0,
      output wire [3 : 0]        txdatak1,
      output wire [3 : 0]        txdatak2,
      output wire [3 : 0]        txdatak3,
      output wire [3 : 0]        txdatak4,
      output wire [3 : 0]        txdatak5,
      output wire [3 : 0]        txdatak6,
      output wire [3 : 0]        txdatak7,
      output wire                txdetectrx0,
      output wire                txdetectrx1,
      output wire                txdetectrx2,
      output wire                txdetectrx3,
      output wire                txdetectrx4,
      output wire                txdetectrx5,
      output wire                txdetectrx6,
      output wire                txdetectrx7,
      output wire                txelecidle0,
      output wire                txelecidle1,
      output wire                txelecidle2,
      output wire                txelecidle3,
      output wire                txelecidle4,
      output wire                txelecidle5,
      output wire                txelecidle6,
      output wire                txelecidle7,
      output wire [2 : 0]        txmargin0,
      output wire [2 : 0]        txmargin1,
      output wire [2 : 0]        txmargin2,
      output wire [2 : 0]        txmargin3,
      output wire [2 : 0]        txmargin4,
      output wire [2 : 0]        txmargin5,
      output wire [2 : 0]        txmargin6,
      output wire [2 : 0]        txmargin7,
      output wire                txdeemph0,
      output wire                txdeemph1,
      output wire                txdeemph2,
      output wire                txdeemph3,
      output wire                txdeemph4,
      output wire                txdeemph5,
      output wire                txdeemph6,
      output wire                txdeemph7,
      output wire                txswing0,
      output wire                txswing1,
      output wire                txswing2,
      output wire                txswing3,
      output wire                txswing4,
      output wire                txswing5,
      output wire                txswing6,
      output wire                txswing7,
      output wire [1:0]          rate0,
      output wire [1:0]          rate1,
      output wire [1:0]          rate2,
      output wire [1:0]          rate3,
      output wire [1:0]          rate4,
      output wire [1:0]          rate5,
      output wire [1:0]          rate6,
      output wire [1:0]          rate7,
      output wire                txdataskip0,
      output wire                txdataskip1,
      output wire                txdataskip2,
      output wire                txdataskip3,
      output wire                txdataskip4,
      output wire                txdataskip5,
      output wire                txdataskip6,
      output wire                txdataskip7,
      output wire                txblkst0,
      output wire                txblkst1,
      output wire                txblkst2,
      output wire                txblkst3,
      output wire                txblkst4,
      output wire                txblkst5,
      output wire                txblkst6,
      output wire                txblkst7,
      output wire [1 : 0]        txsynchd0,
      output wire [1 : 0]        txsynchd1,
      output wire [1 : 0]        txsynchd2,
      output wire [1 : 0]        txsynchd3,
      output wire [1 : 0]        txsynchd4,
      output wire [1 : 0]        txsynchd5,
      output wire [1 : 0]        txsynchd6,
      output wire [1 : 0]        txsynchd7,
      output wire [17 : 0]       currentcoeff0,
      output wire [17 : 0]       currentcoeff1,
      output wire [17 : 0]       currentcoeff2,
      output wire [17 : 0]       currentcoeff3,
      output wire [17 : 0]       currentcoeff4,
      output wire [17 : 0]       currentcoeff5,
      output wire [17 : 0]       currentcoeff6,
      output wire [17 : 0]       currentcoeff7,
      output wire [2 : 0]        currentrxpreset0,
      output wire [2 : 0]        currentrxpreset1,
      output wire [2 : 0]        currentrxpreset2,
      output wire [2 : 0]        currentrxpreset3,
      output wire [2 : 0]        currentrxpreset4,
      output wire [2 : 0]        currentrxpreset5,
      output wire [2 : 0]        currentrxpreset6,
      output wire [2 : 0]        currentrxpreset7,


      // Output HIP Status signals
      output wire                coreclkout_hip,
      output wire                app_nreset_status,
      output wire [1 : 0]        currentspeed,
      output wire                derr_cor_ext_rcv,
      output wire                derr_cor_ext_rpl,
      output wire                derr_rpl,
      output wire                rx_par_err,
      output wire [1:0]          tx_par_err,
      output wire                cfg_par_err,
      output wire                dlup,
      output wire                dlup_exit,
      output wire                ev128ns,
      output wire                ev1us,
      output wire                hotrst_exit,
      output wire [3 : 0]        int_status,
      output wire                l2_exit,
      output wire [3 : 0]        lane_act,
      output wire [4 : 0]        ltssmstate,
      output wire [7 :0]         ko_cpl_spc_header,
      output wire [11 :0]        ko_cpl_spc_data,
      output wire                rxfc_cplbuf_ovf,

      // Output Application interface
      output wire                serr_out,
      output wire                app_int_ack,
      output wire                app_msi_ack,
      output wire                lmi_ack,
      output wire [lmi_width_hwtcl-1: 0] lmi_dout,
      output wire                pme_to_sr,

      output wire [7 : 0]        rx_st_bar,
      output wire                clr_st ,

      output wire [data_byte_width_integer_hwtcl-1 :0]    rx_st_parity,
      output wire [data_width_integer_hwtcl     -1 :0]    rx_st_data,
      output wire [multiple_packets_per_cycle_hwtcl:0]    rx_st_sop,
      output wire [multiple_packets_per_cycle_hwtcl:0]    rx_st_valid,
      output wire [empty_integer_hwtcl          -1 :0]    rx_st_empty,
      output wire [multiple_packets_per_cycle_hwtcl:0]    rx_st_eop,
      output wire [multiple_packets_per_cycle_hwtcl:0]    rx_st_err,

      input  wire                tx_cred_cons_select,
      output wire [3 : 0]        tl_cfg_add,
      output wire [31 : 0]       tl_cfg_ctl,
      output wire [52 : 0]       tl_cfg_sts,
      output wire [11 : 0]       tx_cred_data_fc,
      output wire [5 : 0]        tx_cred_fc_hip_cons,
      output wire [5 : 0]        tx_cred_fc_infinite,
      output wire [7 : 0]        tx_cred_hdr_fc,
      input  wire [1:0]          tx_cred_fc_sel,
      output wire                tx_st_ready,
      // HIP Reconfig
      input  wire            hip_reconfig_rst_n,      // DPRIO reset
      input  wire            hip_reconfig_clk,        // DPRIO clock
      input  wire            hip_reconfig_write,      // write enable input
      input  wire            hip_reconfig_read,       // read enable input
      input  wire  [1:0]     hip_reconfig_byte_en,    // Byte enable
      input  wire  [9:0]     hip_reconfig_address,    // address input
      input  wire  [15:0]    hip_reconfig_writedata,  // write data input
      output wire  [15:0]    hip_reconfig_readdata,   // Read data output
      input  wire            ser_shift_load,          // 1'b1=shift in data from si into scan flop
                                                 // 1'b0=load data from writedata into scan flop
                                                 // Toggle 1->0 (10 clock cycle) 0->1 cp CSR  bits into DPRIO  Register
      input  wire           interface_sel,           // Interface selection inputs
                                                 // 1'b1: select CSR as a source for CRAM
                                                 // After toggling ser_shift_load
                                                 // de-assert interface_sel 1-->0
      // XCVR Reconfig interface
      input  wire            xcvr_reconfig_clk,
      input  wire            xcvr_reconfig_reset,
      input  wire            xcvr_reconfig_write,
      input  wire            xcvr_reconfig_read,
      input  wire [reconfig_address_width_integer_hwtcl-1:0]     xcvr_reconfig_address,
      input  wire [31:0]     xcvr_reconfig_writedata,
      output wire [31:0]     xcvr_reconfig_readdata,
      output wire            xcvr_reconfig_waitrequest,

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

      // serial interface
      input  wire  rx_in0,
      input  wire  rx_in1,
      input  wire  rx_in2,
      input  wire  rx_in3,
      input  wire  rx_in4,
      input  wire  rx_in5,
      input  wire  rx_in6,
      input  wire  rx_in7,

      output wire  tx_out0,
      output wire  tx_out1,
      output wire  tx_out2,
      output wire  tx_out3,
      output wire  tx_out4,
      output wire  tx_out5,
      output wire  tx_out6,
      output wire  tx_out7,


      // Config. Bypass
      input  wire  [link2csr_width_hwtcl-1:0]     cfgbp_link2csr,
      input  wire             cfgbp_comclk_reg,
      input  wire             cfgbp_extsy_reg,
      input  wire  [2:0]      cfgbp_max_pload,
      input  wire             cfgbp_tx_ecrcgen,
      input  wire             cfgbp_rx_ecrchk,
      input  wire  [7:0]      cfgbp_secbus,
      input  wire             cfgbp_linkcsr_bit0,
      input  wire             cfgbp_tx_req_pm,
      input  wire  [2:0]      cfgbp_tx_typ_pm,
      input  wire  [3:0]      cfgbp_req_phypm,
      input  wire  [3:0]      cfgbp_req_phycfg,
      input  wire  [6:0]      cfgbp_vc0_tcmap_pld,
      input  wire             cfgbp_inh_dllp,
      input  wire             cfgbp_inh_tx_tlp,
      input  wire             cfgbp_req_wake,
      input  wire  [1:0]      cfgbp_link3_ctl,

      output wire [7:0]      cfgbp_lane_err,
      output wire            cfgbp_link_equlz_req,
      output wire            cfgbp_equiz_complete,
      output wire            cfgbp_phase_3_successful,
      output wire            cfgbp_phase_2_successful,
      output wire            cfgbp_phase_1_successful,
      output wire            cfgbp_current_deemph,
      output wire [1:0]      cfgbp_current_speed,
      output wire            cfgbp_link_up,
      output wire            cfgbp_link_train,
      output wire            cfgbp_10state,
      output wire            cfgbp_10sstate,
      output wire            cfgbp_rx_val_pm,
      output wire [2:0]      cfgbp_rx_typ_pm,
      output wire            cfgbp_tx_ack_pm,
      output wire [1:0]      cfgbp_ack_phypm,
      output wire            cfgbp_vc_status,
      output wire            cfgbp_rxfc_max,
      output wire            cfgbp_txfc_max,
      output wire            cfgbp_txbuf_emp,
      output wire            cfgbp_cfgbuf_emp,
      output wire            cfgbp_rpbuf_emp,
      output wire            cfgbp_dll_req,
      output wire            cfgbp_link_auto_bdw_status,
      output wire            cfgbp_link_bdw_mng_status,
      output wire            cfgbp_rst_tx_margin_field,
      output wire            cfgbp_rst_enter_comp_bit,
      output wire [3:0]      cfgbp_rx_st_ecrcerr,
      output wire            cfgbp_err_uncorr_internal,
      output wire            cfgbp_rx_corr_internal,
      output wire            cfgbp_err_tlrcvovf,
      output wire            cfgbp_txfc_err,
      output wire            cfgbp_err_tlmalf,
      output wire            cfgbp_err_surpdwn_dll,
      output wire            cfgbp_err_dllrev,
      output wire            cfgbp_err_dll_repnum,
      output wire            cfgbp_err_dllreptim,
      output wire            cfgbp_err_dllp_baddllp,
      output wire            cfgbp_err_dll_badtlp,
      output wire            cfgbp_err_phy_tng,
      output wire            cfgbp_err_phy_rcv,
      output wire            cfgbp_root_err_reg_sts,
      output wire            cfgbp_corr_err_reg_sts,
      output wire            cfgbp_unc_err_reg_sts,

      // CSEB I/O
      input  wire [31 : 0]       cseb_rddata,
      input  wire [3 : 0]        cseb_rddata_parity,
      input  wire [4 : 0]        cseb_rdresponse,
      input  wire                cseb_waitrequest,
      input  wire [4 : 0]        cseb_wrresponse,
      input  wire                cseb_wrresp_valid,

      output wire [32 : 0]       cseb_addr,
      output wire [4 : 0]        cseb_addr_parity,
      output wire [3 : 0]        cseb_be,
      output wire                cseb_is_shadow,
      output wire                cseb_rden,
      output wire [31 : 0]       cseb_wrdata,
      output wire [3 : 0]        cseb_wrdata_parity,
      output wire                cseb_wren,
      output wire                cseb_wrresp_req,

      ////////////////////////////////////////////////////////////////////////
      ////                          AVMM Interfaces                        ///
      ////////////////////////////////////////////////////////////////////////
      // Avalon Tx Slave interface
      input  wire                                            txs_chipselect_i,
      input  wire                                            txs_read_i,
      input  wire                                            txs_write_i,
      input  wire [data_width_integer_txs_hwtcl-1:0]         txs_writedata_i,
      input  wire [burst_count_integer_hwtcl-1:0]            txs_burstcount_i,
      input  wire [txs_addr_width_integer_hwtcl-1:0]         txs_address_i,
      input  wire [(data_width_integer_txs_hwtcl/8)-1:0]     txs_byteenable_i,
      output wire                                            txs_readdatavalid_o,
      output wire  [data_width_integer_txs_hwtcl-1:0]        txs_readdata_o,
      output wire                                            txs_waitrequest_o,


      // Avalon- RX Master
      input wire   [15:0]                                    rxm_irq_i,
      // Avalon Rx Master interface 0
      output wire                                            rxm_bar0_write_o,
      output wire [avmm_addr_width_hwtcl-1:0]                rxm_bar0_address_o,
      output wire [data_width_integer_rxm_txs_hwtcl-1:0]     rxm_bar0_writedata_o,
      output wire [(data_width_integer_rxm_txs_hwtcl/8)-1:0] rxm_bar0_byteenable_o,
      output wire [burst_count_integer_hwtcl-1:0]            rxm_bar0_burstcount_o,
      input  wire                                            rxm_bar0_waitrequest_i,
      output wire                                            rxm_bar0_read_o,
      input  wire [data_width_integer_rxm_txs_hwtcl-1:0]     rxm_bar0_readdata_i,
      input  wire                                            rxm_bar0_readdatavalid_i,

      // Avalon Rx Master interface 1
      output wire                                            rxm_bar1_write_o,
      output wire [avmm_addr_width_hwtcl-1:0]                rxm_bar1_address_o,
      output wire [data_width_integer_rxm_txs_hwtcl-1:0]     rxm_bar1_writedata_o,
      output wire [(data_width_integer_rxm_txs_hwtcl/8)-1:0] rxm_bar1_byteenable_o,
      output wire [burst_count_integer_hwtcl-1:0]            rxm_bar1_burstcount_o,
      input  wire                                            rxm_bar1_waitrequest_i,
      output wire                                            rxm_bar1_read_o,
      input  wire [data_width_integer_rxm_txs_hwtcl-1:0]     rxm_bar1_readdata_i,
      input  wire                                            rxm_bar1_readdatavalid_i,

      // Avalon Rx Master interface 2
      output wire                                             rxm_bar2_write_o,
      output wire  [avmm_addr_width_hwtcl-1:0]                rxm_bar2_address_o,
      output wire  [data_width_integer_rxm_txs_hwtcl-1:0]     rxm_bar2_writedata_o,
      output wire  [(data_width_integer_rxm_txs_hwtcl/8)-1:0] rxm_bar2_byteenable_o,
      output wire  [burst_count_integer_hwtcl-1:0]            rxm_bar2_burstcount_o,
      input  wire                                             rxm_bar2_waitrequest_i,
      output wire                                             rxm_bar2_read_o,
      input  wire  [data_width_integer_rxm_txs_hwtcl-1:0]     rxm_bar2_readdata_i,
      input  wire                                             rxm_bar2_readdatavalid_i,

      // Avalon Rx Master interface 3
      output wire                                            rxm_bar3_write_o,
      output wire [avmm_addr_width_hwtcl-1:0]                rxm_bar3_address_o,
      output wire [data_width_integer_rxm_txs_hwtcl-1:0]     rxm_bar3_writedata_o,
      output wire [(data_width_integer_rxm_txs_hwtcl/8)-1:0] rxm_bar3_byteenable_o,
      output wire [burst_count_integer_hwtcl-1:0]            rxm_bar3_burstcount_o,
      input wire                                             rxm_bar3_waitrequest_i,
      output wire                                            rxm_bar3_read_o,
      input wire  [data_width_integer_rxm_txs_hwtcl-1:0]     rxm_bar3_readdata_i,
      input wire                                             rxm_bar3_readdatavalid_i,

      // Avalon Rx Master interface 4
      output wire                                            rxm_bar4_write_o,
      output wire [avmm_addr_width_hwtcl-1:0]                rxm_bar4_address_o,
      output wire [data_width_integer_rxm_txs_hwtcl-1:0]     rxm_bar4_writedata_o,
      output wire [(data_width_integer_rxm_txs_hwtcl/8)-1:0] rxm_bar4_byteenable_o,
      output wire [burst_count_integer_hwtcl-1:0]            rxm_bar4_burstcount_o,
      input wire                                             rxm_bar4_waitrequest_i,
      output wire                                            rxm_bar4_read_o,
      input wire  [data_width_integer_rxm_txs_hwtcl-1:0]     rxm_bar4_readdata_i,
      input wire                                             rxm_bar4_readdatavalid_i,

      // Avalon Rx Master interface 5
      output wire                                            rxm_bar5_write_o,
      output wire [avmm_addr_width_hwtcl-1:0]                rxm_bar5_address_o,
      output wire [data_width_integer_rxm_txs_hwtcl-1:0]     rxm_bar5_writedata_o,
      output wire [(data_width_integer_rxm_txs_hwtcl/8)-1:0] rxm_bar5_byteenable_o,
      output wire [burst_count_integer_hwtcl-1:0]            rxm_bar5_burstcount_o,
      input wire                                             rxm_bar5_waitrequest_i,
      output wire                                            rxm_bar5_read_o,
      input wire  [data_width_integer_rxm_txs_hwtcl-1:0]     rxm_bar5_readdata_i,
      input wire                                             rxm_bar5_readdatavalid_i,

      // Avalon HP Rx Master
      output wire                                            hprxm_write_o,
      output wire [avmm_addr_width_hwtcl-1:0]                hprxm_address_o,
      output wire [data_width_integer_hwtcl-1:0]             hprxm_writedata_o,
      output wire [(data_width_integer_hwtcl/8)-1:0]         hprxm_byteenable_o,
      output wire [burst_count_integer_hwtcl-1:0]            hprxm_burstcount_o,
      input wire                                             hprxm_waitrequest_i,
      output wire                                            hprxm_read_o,
      input wire  [data_width_integer_hwtcl-1:0]             hprxm_readdata_i,
      input wire                                             hprxm_readdatavalid_i,

            // Avalon Control Register Access (CRA) Slave (This is 32-bit interface)
      input wire                                  cra_chipselect_i,
      input wire                                  cra_read_i,
      input wire                                  cra_write_i,
      input wire  [31:0]                          cra_writedata_i,
      input wire  [13:0]                          cra_address_i,
      input wire  [3:0]                           cra_byteenable_i,
      output wire [31:0]                          cra_readdata_o,      // This comes from Rx Completion to be returned to Avalon master
      output wire                                 cra_waitrequest_o,
      output wire                                 cra_irq_o,

      // MSI/MSI-X/INTx supported signals
      output wire  [81:0]                         msi_intfc_o,
      output wire  [15:0]                         msi_control_o,
      output wire  [15:0]                         msix_intfc_o,
      input wire                                  intx_req_i,
      output wire                                 intx_ack_o,

      // 256b AVMM ports
      input wire          rd_ast_rx_valid_i,
      input wire  [159:0] rd_ast_rx_data_i,
      output wire         rd_ast_rx_ready_o,

      output wire         rd_ast_tx_valid_o,
      output wire [31:0]  rd_ast_tx_data_o,

      input wire          wr_ast_rx_valid_i,
      input wire  [159:0] wr_ast_rx_data_i,
      output wire         wr_ast_rx_ready_o,

      output wire         wr_ast_tx_valid_o,
      output wire [31:0]  wr_ast_tx_data_o,

      output wire [avmm_addr_width_hwtcl-1:0]         rd_dma_address_o,
      output wire                                     rd_dma_write_o,
      output wire [data_width_integer_hwtcl-1:0]      rd_dma_write_data_o,
      input wire                                      rd_dma_wait_request_i,
      output wire [burst_count_integer_hwtcl-1:0]     rd_dma_burst_count_o,
      output wire [data_byte_width_integer_hwtcl-1:0] rd_dma_byte_enable_o,

      output wire [avmm_addr_width_hwtcl-1:0]         wr_dma_address_o,
      output wire                                     wr_dma_read_o,
      input wire  [data_width_integer_hwtcl-1:0]      wr_dma_read_data_i,
      input wire                                      wr_dma_wait_request_i,
      output wire [burst_count_integer_hwtcl-1:0]     wr_dma_burst_count_o,
      input wire                                      wr_dma_read_data_valid_i,

      input wire                                      rd_dts_chip_select_i,
      input wire                                      rd_dts_write_i,
      input wire  [4:0]                               rd_dts_burst_count_i,
      input wire  [7:0]                               rd_dts_address_i,
      input wire  [255:0]                             rd_dts_write_data_i,
      output wire                                     rd_dts_wait_request_o,

      input wire                                      wr_dts_chip_select_i,
      input wire                                      wr_dts_write_i,
      input wire  [4:0]                               wr_dts_burst_count_i,
      input wire  [7:0]                               wr_dts_address_i,
      input wire  [255:0]                             wr_dts_write_data_i,
      output wire                                     wr_dts_wait_request_o,

      output wire [63:0]                              rd_dcm_address_o,
      output wire                                     rd_dcm_write_o,
      output wire [31:0]                              rd_dcm_writedata_o,
      output wire                                     rd_dcm_read_o,
      output wire [3:0]                               rd_dcm_byte_enable_o,
      input wire                                      rd_dcm_wait_request_i,
      input wire  [31:0]                              rd_dcm_read_data_i,
      input wire                                      rd_dcm_read_data_valid_i,

      output wire [63:0]                              wr_dcm_address_o,
      output wire                                     wr_dcm_write_o,
      output wire [31:0]                              wr_dcm_writedata_o,
      output wire                                     wr_dcm_read_o,
      output wire [3:0]                               wr_dcm_byte_enable_o,
      input wire                                      wr_dcm_wait_request_i,
      input wire  [31:0]                              wr_dcm_read_data_i,
      input wire                                      wr_dcm_read_data_valid_i,

     //======================================
     // A10 HIP AST Translator IO
     //======================================
      output wire                                      TxData_rdy_o  , // Begin User Streaming Interface
      input wire                                       TxData_val_i  ,
      input wire                                       TxData_sop_i  ,
      input wire                                       TxData_eop_i  ,
      input wire                                       TxData_err_i  ,
      input wire   [ast_trs_txdata_width_hwtcl-1:0]    TxData_dat_i  ,
      input wire   [ast_trs_txmty_width_hwtcl -1 :0]   TxData_sty_i  ,
      input wire   [ast_trs_txmty_width_hwtcl -1 :0]   TxData_mty_i  ,
      input wire   [ast_trs_txdesc_width_hwtcl-1:0]    TxData_dsc_i  ,
      output wire                                      TxStatus_val_o,
      output wire  [ast_trs_txstatus_width_hwtcl-1:0]  TxStatus_dat_o,
      input wire                                       RxData_rdy_i  ,
      output wire                                      RxData_val_o  ,
      output wire                                      RxData_sop_o  ,
      output wire                                      RxData_eop_o  ,
      output wire                                      RxData_err_o  ,
      output wire  [ast_trs_rxdata_width_hwtcl-1:0]    RxData_dat_o  ,
      output wire  [ast_trs_rxmty_width_hwtcl -1 :0]   RxData_sty_o  ,
      output wire  [ast_trs_rxmty_width_hwtcl -1 :0]   RxData_mty_o  ,
      output wire  [ast_trs_rxdesc_width_hwtcl-1:0]    RxData_dsc_o  ,//End  User Streaming Interface
     //======================================
     // SRIOV2 Bridge Additional I/O signals
     //======================================
     // Function number and BAR identification signals
      output wire [2:0]                                rx_st_bar_range, // Matching BAR number
      output wire [total_pf_count_width_hwtcl-1:0]     rx_st_pf_num,    // PF number that was hit
      output wire [total_vf_count_width_hwtcl-1:0]     rx_st_vf_num,    // Offset of VF number that was hit
      output wire                                      rx_st_vf_active, // Indicates that the Function
                                                                        // that was hit is a VF
      output wire                                      rx_st_pf_exprom_bar_hit,                                                                        
      input  wire [total_pf_count_width_hwtcl-1:0]     tx_st_pf_num,
      input  wire [total_vf_count_width_hwtcl-1:0]     tx_st_vf_num,
      input  wire                                      tx_st_vf_active,
      //input  wire [total_pf_count_hwtcl-1:0]           app_int_sts,
      input  wire [total_pf_count_width_hwtcl-1:0]     app_msix_pf_num,
      input  wire [total_vf_count_width_hwtcl-1:0]     app_msix_vf_num,
      input  wire                                      app_msix_vf_active,
      output wire [7:0]                                bus_num_f2,
      output wire [4:0]                                device_num_f2,
      output wire [7:0]                                bus_num_f3,
      output wire [4:0]                                device_num_f3,
      output wire [7:0]                                bus_num_f4,
      output wire [4:0]                                device_num_f4,
      output wire [7:0]                                bus_num_f5,
      output wire [4:0]                                device_num_f5,
      output wire [7:0]                                bus_num_f6,
      output wire [4:0]                                device_num_f6,
      output wire [7:0]                                bus_num_f7,
      output wire [4:0]                                device_num_f7,
      output wire [cfg_num_vf_width_hwtcl-1:0]         pf2_num_vfs,
      output wire [cfg_num_vf_width_hwtcl-1:0]         pf3_num_vfs,
      output wire [total_pf_count_hwtcl-1:0]           compl_timeout_disable_pf,
      output wire [total_pf_count_hwtcl-1:0]           atomic_op_requester_en_pf,
      output wire [total_pf_count_hwtcl-1:0]           extended_tag_en_pf,
      output wire [total_pf_count_hwtcl*2-1:0]         tph_st_mode_pf,
      output wire [total_pf_count_hwtcl-1:0]           tph_requester_en_pf,
      output wire [total_pf_count_hwtcl*5-1:0]         ats_stu_pf,
      output wire [total_pf_count_hwtcl-1:0]           ats_en_pf,
      output wire                                      ctl_shdw_update,
      output wire [total_pf_count_width_hwtcl-1:0]     ctl_shdw_pf_num,
      output wire [total_vf_count_width_hwtcl-1:0]     ctl_shdw_vf_num,
      output wire                                      ctl_shdw_vf_active,
      output wire [6:0]                                ctl_shdw_cfg,
      input  wire                                      ctl_shdw_req_all,
      input  wire [total_pf_count_width_hwtcl-1:0]     lmi_pf_num_app,
      input  wire [total_vf_count_width_hwtcl-1:0]     lmi_vf_num_app,
      output wire                                      lmi_vf_active_app,
      input  wire [total_pf_count_width_hwtcl-1:0]     cpl_err_pf_num,
      input  wire [total_vf_count_width_hwtcl-1:0]     cpl_err_vf_num,
      input  wire                                      cpl_err_vf_active,
      input  wire                                      vf_compl_status_update,
      input  wire                                      vf_compl_status,
      input  wire [total_pf_count_width_hwtcl-1:0]     vf_compl_status_pf_num,
      input  wire [total_vf_count_width_hwtcl-1:0]     vf_compl_status_vf_num,
      output wire                                      vf_compl_status_update_ack,
      output wire                                      flr_rcvd_vf,
      output wire [total_pf_count_width_hwtcl-1:0]     flr_rcvd_pf_num,
      output wire [total_vf_count_width_hwtcl-1:0]     flr_rcvd_vf_num,
      input  wire [total_pf_count_width_hwtcl-1:0]     flr_completed_pf_num,
      input  wire [total_vf_count_width_hwtcl-1:0]     flr_completed_vf_num,
     //======================================
     // SRIOV Bridge I/O signals
     //======================================
      input wire  [8 : 0]        lmi_func, // [7:0] =  Function Number, for SR-IOV only
                                      // [ 8] = 0 => access to Hard IP register
                                      // [ 8] = 1 => access to SR-IOV bridge config space
      // BAR hit signals
      output wire [7:0]    rx_st_bar_hit_tlp0, // BAR hit information for first TLP in this cycle
      output wire [7:0]    rx_st_bar_hit_fn_tlp0, // Target Function for first TLP in this cycle
      output wire [7:0]    rx_st_bar_hit_tlp1, // BAR hit information for second TLP in this cycle
      output wire [7:0]    rx_st_bar_hit_fn_tlp1, // Target Function for second TLP in this cycle
   //###################################################################################
   //VIRTIO PCICFG ACCESS Hooks PF0
   //###################################################################################
   output [7:0 ]    f0_virtio_pcicfg_bar_o,       
   output [31:0 ]   f0_virtio_pcicfg_length_o,    
   output [31:0 ]   f0_virtio_pcicfg_baroffset_o, 
   output [31:0 ]   f0_virtio_pcicfg_cfgdata_o,   
   output           f0_virtio_pcicfg_cfgwr_o,     
   output           f0_virtio_pcicfg_cfgrd_o,
   input            f0_virtio_pcicfg_rdack_i,     //Application Read Data Ack to store config data
   input  [3:0]     f0_virtio_pcicfg_rdbe_i,      //Application indicates which byte to store
   input  [31:0]    f0_virtio_pcicfg_data_i,      //Data to be stored in config data register
   //###################################################################################
   //VIRTIO PCICFG ACCESS Hooks PF1
   //###################################################################################
   output [7:0 ]    f1_virtio_pcicfg_bar_o,       
   output [31:0 ]   f1_virtio_pcicfg_length_o,    
   output [31:0 ]   f1_virtio_pcicfg_baroffset_o, 
   output [31:0 ]   f1_virtio_pcicfg_cfgdata_o,   
   output           f1_virtio_pcicfg_cfgwr_o,     
   output           f1_virtio_pcicfg_cfgrd_o,
   input            f1_virtio_pcicfg_rdack_i,     //Application Read Data Ack to store config data
   input  [3:0]     f1_virtio_pcicfg_rdbe_i,      //Application indicates which byte to store
   input  [31:0]    f1_virtio_pcicfg_data_i,      //Data to be stored in config data register
   //###################################################################################
   //VIRTIO PCICFG ACCESS Hooks PF2
   //###################################################################################
   output [7:0 ]    f2_virtio_pcicfg_bar_o,       
   output [31:0 ]   f2_virtio_pcicfg_length_o,    
   output [31:0 ]   f2_virtio_pcicfg_baroffset_o, 
   output [31:0 ]   f2_virtio_pcicfg_cfgdata_o,   
   output           f2_virtio_pcicfg_cfgwr_o,     
   output           f2_virtio_pcicfg_cfgrd_o,
   input            f2_virtio_pcicfg_rdack_i,     //Application Read Data Ack to store config data
   input  [3:0]     f2_virtio_pcicfg_rdbe_i,      //Application indicates which byte to store
   input  [31:0]    f2_virtio_pcicfg_data_i,      //Data to be stored in config data register
   //###################################################################################
   //VIRTIO PCICFG ACCESS Hooks PF3
   //###################################################################################
   output [7:0 ]    f3_virtio_pcicfg_bar_o,       
   output [31:0 ]   f3_virtio_pcicfg_length_o,    
   output [31:0 ]   f3_virtio_pcicfg_baroffset_o, 
   output [31:0 ]   f3_virtio_pcicfg_cfgdata_o,   
   output           f3_virtio_pcicfg_cfgwr_o,     
   output           f3_virtio_pcicfg_cfgrd_o,
   input            f3_virtio_pcicfg_rdack_i,     //Application Read Data Ack to store config data
   input  [3:0]     f3_virtio_pcicfg_rdbe_i,      //Application indicates which byte to store
   input  [31:0]    f3_virtio_pcicfg_data_i,      //Data to be stored in config data register
   //###################################################################################
   //VIRTIO PCICFG ACCESS Hooks PF4
   //###################################################################################
   output [7:0 ]    f4_virtio_pcicfg_bar_o,       
   output [31:0 ]   f4_virtio_pcicfg_length_o,    
   output [31:0 ]   f4_virtio_pcicfg_baroffset_o, 
   output [31:0 ]   f4_virtio_pcicfg_cfgdata_o,   
   output           f4_virtio_pcicfg_cfgwr_o,     
   output           f4_virtio_pcicfg_cfgrd_o,
   input            f4_virtio_pcicfg_rdack_i,     //Application Read Data Ack to store config data
   input  [3:0]     f4_virtio_pcicfg_rdbe_i,      //Application indicates which byte to store
   input  [31:0]    f4_virtio_pcicfg_data_i,      //Data to be stored in config data register
   //###################################################################################
   //VIRTIO PCICFG ACCESS Hooks PF5
   //###################################################################################
   output [7:0 ]    f5_virtio_pcicfg_bar_o,       
   output [31:0 ]   f5_virtio_pcicfg_length_o,    
   output [31:0 ]   f5_virtio_pcicfg_baroffset_o, 
   output [31:0 ]   f5_virtio_pcicfg_cfgdata_o,   
   output           f5_virtio_pcicfg_cfgwr_o,     
   output           f5_virtio_pcicfg_cfgrd_o,
   input            f5_virtio_pcicfg_rdack_i,     //Application Read Data Ack to store config data
   input  [3:0]     f5_virtio_pcicfg_rdbe_i,      //Application indicates which byte to store
   input  [31:0]    f5_virtio_pcicfg_data_i,      //Data to be stored in config data register
   //###################################################################################
   //VIRTIO PCICFG ACCESS Hooks PF6
   //###################################################################################
   output [7:0 ]    f6_virtio_pcicfg_bar_o,       
   output [31:0 ]   f6_virtio_pcicfg_length_o,    
   output [31:0 ]   f6_virtio_pcicfg_baroffset_o, 
   output [31:0 ]   f6_virtio_pcicfg_cfgdata_o,   
   output           f6_virtio_pcicfg_cfgwr_o,     
   output           f6_virtio_pcicfg_cfgrd_o,
   input            f6_virtio_pcicfg_rdack_i,     //Application Read Data Ack to store config data
   input  [3:0]     f6_virtio_pcicfg_rdbe_i,      //Application indicates which byte to store
   input  [31:0]    f6_virtio_pcicfg_data_i,      //Data to be stored in config data register
   //###################################################################################
   //VIRTIO PCICFG ACCESS Hooks PF7
   //###################################################################################
   output [7:0 ]    f7_virtio_pcicfg_bar_o,       
   output [31:0 ]   f7_virtio_pcicfg_length_o,    
   output [31:0 ]   f7_virtio_pcicfg_baroffset_o, 
   output [31:0 ]   f7_virtio_pcicfg_cfgdata_o,   
   output           f7_virtio_pcicfg_cfgwr_o,     
   output           f7_virtio_pcicfg_cfgrd_o,
   input            f7_virtio_pcicfg_rdack_i,     //Application Read Data Ack to store config data
   input  [3:0]     f7_virtio_pcicfg_rdbe_i,      //Application indicates which byte to store
   input  [31:0]    f7_virtio_pcicfg_data_i,      //Data to be stored in config data register
   //###################################################################################
   //VIRTIO PCICFG ACCESS Hooks PF0 VFs
   //###################################################################################
   output [7:0 ]                      f0vf_virtio_pcicfg_bar_o,       
   output [31:0]                      f0vf_virtio_pcicfg_length_o,    
   output [31:0]                      f0vf_virtio_pcicfg_baroffset_o, 
   output [31:0]                      f0vf_virtio_pcicfg_cfgdata_o,   
   output                             f0vf_virtio_pcicfg_cfgwr_o,     
   output                             f0vf_virtio_pcicfg_cfgrd_o,
   output [total_vf_count_width_hwtcl-1:0]    f0vf_virtio_pcicfg_vfnum_o,
   input                              f0vf_virtio_pcicfg_rdack_i,     // Application Read Data Ack to store config data
   input  [3:0 ]                      f0vf_virtio_pcicfg_rdbe_i,      // Application indicates which byte to store
   input  [31:0]                      f0vf_virtio_pcicfg_data_i,      // Data to be stored in config data register
   input  [total_vf_count_width_hwtcl-1:0]    f0vf_virtio_pcicfg_appvfnum_i,  // Application indicates for which VF
   //###################################################################################
   //VIRTIO PCICFG ACCESS Hooks PF1 VFs
   //###################################################################################
   output [7:0 ]                      f1vf_virtio_pcicfg_bar_o,       
   output [31:0]                      f1vf_virtio_pcicfg_length_o,    
   output [31:0]                      f1vf_virtio_pcicfg_baroffset_o, 
   output [31:0]                      f1vf_virtio_pcicfg_cfgdata_o,   
   output                             f1vf_virtio_pcicfg_cfgwr_o,     
   output                             f1vf_virtio_pcicfg_cfgrd_o,
   output [total_vf_count_width_hwtcl-1:0]    f1vf_virtio_pcicfg_vfnum_o,
   input                              f1vf_virtio_pcicfg_rdack_i,     // Application Read Data Ack to store config data
   input  [3:0 ]                      f1vf_virtio_pcicfg_rdbe_i,      // Application indicates which byte to store
   input  [31:0]                      f1vf_virtio_pcicfg_data_i,      // Data to be stored in config data register
   input  [total_vf_count_width_hwtcl-1:0]    f1vf_virtio_pcicfg_appvfnum_i,  // Application indicates for which VF
   //###################################################################################
   //VIRTIO PCICFG ACCESS Hooks PF2 VFs
   //###################################################################################
   output [7:0 ]                      f2vf_virtio_pcicfg_bar_o,       
   output [31:0]                      f2vf_virtio_pcicfg_length_o,    
   output [31:0]                      f2vf_virtio_pcicfg_baroffset_o, 
   output [31:0]                      f2vf_virtio_pcicfg_cfgdata_o,   
   output                             f2vf_virtio_pcicfg_cfgwr_o,     
   output                             f2vf_virtio_pcicfg_cfgrd_o,
   output [total_vf_count_width_hwtcl-1:0]    f2vf_virtio_pcicfg_vfnum_o,
   input                              f2vf_virtio_pcicfg_rdack_i,     // Application Read Data Ack to store config data
   input  [3:0 ]                      f2vf_virtio_pcicfg_rdbe_i,      // Application indicates which byte to store
   input  [31:0]                      f2vf_virtio_pcicfg_data_i,      // Data to be stored in config data register
   input  [total_vf_count_width_hwtcl-1:0]    f2vf_virtio_pcicfg_appvfnum_i,  // Application indicates for which VF
   //###################################################################################
   //VIRTIO PCICFG ACCESS Hooks PF3 VFs
   //###################################################################################
   output [7:0 ]                      f3vf_virtio_pcicfg_bar_o,       
   output [31:0]                      f3vf_virtio_pcicfg_length_o,    
   output [31:0]                      f3vf_virtio_pcicfg_baroffset_o, 
   output [31:0]                      f3vf_virtio_pcicfg_cfgdata_o,   
   output                             f3vf_virtio_pcicfg_cfgwr_o,     
   output                             f3vf_virtio_pcicfg_cfgrd_o,
   output [total_vf_count_width_hwtcl-1:0]    f3vf_virtio_pcicfg_vfnum_o,
   input                              f3vf_virtio_pcicfg_rdack_i,     // Application Read Data Ack to store config data
   input  [3:0 ]                      f3vf_virtio_pcicfg_rdbe_i,      // Application indicates which byte to store
   input  [31:0]                      f3vf_virtio_pcicfg_data_i,      // Data to be stored in config data register
   input  [total_vf_count_width_hwtcl-1:0]    f3vf_virtio_pcicfg_appvfnum_i,  // Application indicates for which VF
   //###################################################################################
   // Completion Status Signals from user application
   //###################################################################################
    input wire [7:0]                 cpl_err_fn,     // Function number of reporting Function
    input wire [total_pf_count_hwtcl-1:0]  cpl_pending_pf, // Completion pending status from PF 0
    input wire [total_vf_count_hwtcl-1:0]  cpl_pending_vf, // Completion pending status from VFs
    input wire [127:0]               log_hdr,        // TLP header for logging

   //###################################################################################
   // FLR Interface
   //###################################################################################
    output wire [total_pf_count_hwtcl-1:0] flr_active_pf,    // FLR status for PF 0
    output wire [total_vf_count_hwtcl-1:0] flr_active_vf, // FLR status for VFs
    input wire  [total_pf_count_hwtcl-1:0] flr_completed_pf, // Indication from user to re-enable PF 0 after FLR
    input wire  [flr_completed_vf_width_hwtcl-1:0] flr_completed_vf, // Indication from user to re-enable VFs after FLR
   //###################################################################################
   // Configuration Status Interface
   //###################################################################################
    output wire [7:0]          bus_num_f0,       // Captured bus number for Function 0
    output wire [4:0]          device_num_f0,    // Captured device number for Function 0
    output wire [7:0]          bus_num_f1,       // Captured bus number for Function 1
    output wire [4:0]          device_num_f1,    // Captured device number for Function 1 (set to 0 for an ARI device)
    output wire [total_pf_count_hwtcl-1:0] mem_space_en_pf,  // Memory Space Enable for PFs
    output wire [total_pf_count_hwtcl-1:0] bus_master_en_pf, // Bus Master Enable for PFs
    output wire [total_pf_count_hwtcl-1:0] mem_space_en_vf,  // Memory Space Enable for VFs
                                         // (common for all VFs attached to the same PF)
    output wire [total_pf_count_hwtcl-1:0]            exprom_en_pf,  //Expansion ROM Enable per PF                                         
    output wire [total_vf_count_hwtcl-1:0] bus_master_en_vf, // Bus Master Enable for VFs
    output wire [cfg_num_vf_width_hwtcl-1:0]          pf0_num_vfs, // Number of enabled VFs for PF 0
    output wire [cfg_num_vf_width_hwtcl-1:0]          pf1_num_vfs, // Number of enabled VFs for PF 1
    output wire [2:0]          pf_max_payload_size, // Max payload size from Device Control Register of PF 0
    output wire [2:0]          pf_rd_req_size,      // Read Request Size from Device Control Register of PF 0
   //###################################################################################
   // Interrupt interface
   //###################################################################################
   // Legacy interrupt
   input wire                  app_int_sts_a,  // Legacy interrupt request, INTA
   input wire                  app_int_sts_b,  // Legacy interrupt request, INTB
   input wire                  app_int_sts_c,  // Legacy interrupt request, INTC
   input wire                  app_int_sts_d,  // Legacy interrupt request, INTD
   input wire                  app_int_sts_fn, // Function Num associated with the Legacy interrupt request
   // MSI and MSIX interrupt
   output wire [1:0]           app_msi_status, // Execution status of MSI interrupt request, common for all Functions
                                               // 00 = MSI message sent, 01 = Pending bit set and no message sent, 10 = error
   input wire [app_msi_req_fn_hwtcl-1:0]   app_msi_req_fn, // Function number corresponding to MSI interrupt request
   input wire                  app_msix_req, // MSIX interrupt request, common for all Functions
   input wire [2:0]            app_msix_tc,  // Traffic Class corresponding to MSIX interrupt request
   output wire                 app_msix_ack, // Ack to MSIX interrupt request, common for all Functions
   output wire                 app_msix_err, // Error status for MSIX interrupt request, common for all Functions
   input wire [63:0]           app_msix_addr,  // Address to be sent in MSIX interrupt message
   input wire [31:0]           app_msix_data,  // Data to be sent in MSIX interrupt message
   input wire  [1:0]           app_int_pend_status,  // Interrupt pending status from Function
   input wire                  app_msi_pending_bit_write_en,   // Write enable for bit in the MSI Pending Bit Register
   input wire                  app_msi_pending_bit_write_data, // Write data for bit in the MSI Pending Bit Register
   output wire [total_pf_count_hwtcl-1:0] app_intx_disable,    // INTX Disable from PCI Command Register of PFs

   // PF MSI Capability Register Outputs
   output wire [total_pf_count_hwtcl*64-1:0] app_msi_addr_pf,// MSI Address Register setting of PFs
   output wire [total_pf_count_hwtcl*16-1:0] app_msi_data_pf,// MSI Data Register setting of PFs
   output wire [total_pf_count_hwtcl*32-1:0] app_msi_mask_pf,// MSI Mask Register setting of PFs
   output wire [total_pf_count_hwtcl*32-1:0] app_msi_pending_pf,// MSI Pending Bit Register setting of PFs
   output wire [total_pf_count_hwtcl-1:0]    app_msi_enable_pf,// MSI Enable setting of PFs
   output wire [total_pf_count_hwtcl*3-1:0]  app_msi_multi_msg_enable_pf,// MSI Multiple Msg field setting of PFs

   // MSIX Capability Register Outputs
   output wire [total_pf_count_hwtcl-1:0]    app_msix_en_pf, // MSIX Enable bit from MSIX Control Reg of PFs
   output wire [total_pf_count_hwtcl-1:0]    app_msix_fn_mask_pf, // MSIX Function Mask bit from MSIX Control Reg of PFs
   output wire [total_vf_count_hwtcl-1:0]    app_msix_en_vf, // MSIX Enable bits from MSIX Control Reg of VFs
   output wire [total_vf_count_hwtcl-1:0]    app_msix_fn_mask_vf, // MSIX Function Mask bits from MSIX Control Reg of VFs

   input wire                                   extraBAR_lock, // Set to 1 to disable writes to Extra BAR
   input wire [total_pf_count_hwtcl-1:0]        devhide_pf,    // When the ith bits is set to 1, Config accesses
                                                               // to PF i will generate UR.
   input wire                                   device_rciep,  // When set to 1, device will advertise itself
                                                               // as RC Integrated EndPoint.
   output wire                                  extraBAR_hit,  // Signals a hit to extra BAR on a mem access.
                                                               // Valid when rx_st_sop_app and rx_st_valid_app are both high.

   // PCIE Inspector Optional Thin AVMM RX Master
   output wire                           avmm_thinmaster_write,               //     | _______________________________|//
   output wire [7:0]                     avmm_thinmaster_address,             //     |                   | Offset 48h |//
   output wire [15:0]                    avmm_thinmaster_writedata,           //     | AVMM thin Master  |____________|//
   output wire [1:0]                     avmm_thinmaster_byteenable,          //     | [15:0]  data                   |//
   output wire                           avmm_thinmaster_read,                //     | [23:16] Address                |//
   input wire                            avmm_thinmaster_waitrequest,         //     | [24]    ReadReq                |//
   input wire  [15:0]                    avmm_thinmaster_readdata,            //     | [25]    WriteReq               |//
   input wire                            avmm_thinmaster_readdatavalid,       //     | [31:26] Reserved               |//
   output wire                           avmm_thinmaster_reset,               //     | _______________________________|//

   // Controlled by parameter enable_devkit_conduit_hwtcl
   output wire [255:0]     devkit_status,
   input  wire [255:0]     devkit_ctrl, // devkit_ctrl[63:0] --> test_in
                              // devkit_ctrl[255:64] --> reserved
   input   wire            pipe_hclk_in,
   output  wire            pll_pcie_clk,

   // SKP OS Flag
   output  wire           skp_os



  );
  localparam link_width_integer    = (link_width == "x8") ? 8 :
                              (link_width == "x4") ? 4 :
                              (link_width == "x2") ? 2 : 1;

// Derive local parameters for Autonomous mode
localparam AVMM_TEMP_BUSY = 5'h8;                        //CSEB retry
localparam cfbp_cseb_autonomous_en                       = (cseb_config_bypass == "enable") && (cseb_autonomous_hwtcl==1);

localparam surprise_down_error_support_hwtcl   = (surprise_down_error_support == "true");

localparam  MAX_CONVERSION_SIZE = 128;
localparam  MAX_STRING_CHARS    = 64;

//Soft DFE requires eq phase2 time around 23ms
//resolution of 0.5ms; 4ms is already accounted in hardware
localparam gen3_phase2_eq_time = enable_soft_dfe ? 6'd38 : gen3_coeff_3_ber_meas;

function [MAX_CONVERSION_SIZE-1:0] str_2_bin;
  input [MAX_STRING_CHARS*8-1:0] instring;

  integer this_char;
  integer i;
  begin
    this_char = 0;
    i = 0;
    // Initialize accumulator
    str_2_bin = {MAX_CONVERSION_SIZE{1'b0}};
    for(i=MAX_STRING_CHARS-1;i>=0;i=i-1) begin
      this_char = instring[i*8+:8];
      // Add value of this digit
      if(this_char >= 48 && this_char <= 57)
        str_2_bin = (str_2_bin * 10) + (this_char - 48);
    end
  end
endfunction

localparam USE_ALTPCIE_RS_HIP_LOGIC                         = 0;
localparam [127:0]  bist_memory_settings_bit_vec            = str_2_bin(bist_memory_settings           );
localparam [127:0]  jtag_id_bit_vec                         = str_2_bin(jtag_id                        );
localparam [127:0]  retry_buffer_memory_settings_bit_vec    = str_2_bin(retry_buffer_memory_settings   );
localparam [127:0]  vc0_rx_buffer_memory_settings_bit_vec   = str_2_bin(vc0_rx_buffer_memory_settings  );

//localparam [127:0]  msix_table_offset                     = str_2_bin(msix_table_offset_hwtcl        );
//localparam [127:0]  msix_pba_offset                       = str_2_bin(msix_pba_offset_hwtcl          );
localparam [31:0]  msix_table_offset                       = msix_table_offset_hwtcl                    ;
localparam [31:0]  msix_pba_offset                         = msix_pba_offset_hwtcl                     ;

function [63:0] get_bar_size_mask;
   // Compute bar size mask based on BAR size
   input integer bara_64bit_mem_space ;// Integer 1 or 0
   input integer bara_size            ;// Integer number of bits
   input integer barb_size            ;// Integer number of bits
   reg [63:0] barab_size_mask64;
   reg [31:0] bara_size_mask32;
   reg [31:0] barb_size_mask32;
   begin
      barab_size_mask64 = {60'hffff_ffff_ffff_fff << (bara_size - 4), 4'h0};
      bara_size_mask32  = {28'hffff_fff           << (bara_size - 4), 4'h0};
      barb_size_mask32  = {28'hffff_fff           << (barb_size - 4), 4'h0};
      get_bar_size_mask = (bara_64bit_mem_space == 1)? barab_size_mask64[63:0]:
                              {barb_size_mask32[31:0]  , bara_size_mask32[31:0]};
   end
endfunction

function [31:0] get_expansion_base_addr_mask;
   // Compute expansion ROM size mask based on expansion ROM size
   input integer expansion_base_address_size;
   begin
      get_expansion_base_addr_mask = {28'hffff_fff << (expansion_base_address_size - 4), 4'h0};
   end
endfunction

//synthesis translate_off
localparam ALTPCIE_A10_HIP_AST_HWTCL_SIM_ONLY  = 1;
//synthesis translate_on

//synthesis read_comments_as_HDL on
//localparam ALTPCIE_A10_HIP_AST_HWTCL_SIM_ONLY  = 0;
//synthesis read_comments_as_HDL off

localparam [255:0] ONES                                  = 256'HFFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF;
localparam [255:0] ZEROS                                 = 256'H0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000;
localparam pll_refclk_freq                               = "100 MHz";

localparam [63:0] bar01_size_mask                        =  get_bar_size_mask((bar0_type=="bar0_64bit_prefetch_mem")?1:0,bar0_address_width_mux_hwtcl, bar1_address_width_mux_hwtcl) ;
localparam [27:0] bar0_size_mask                         =  bar01_size_mask[31:4]                                               ;
localparam [27:0] bar1_size_mask                         =  bar01_size_mask[63:36]                                              ;
localparam bar1_type_mod                                 = (bar0_type!="bar0_64bit_prefetch_mem")? bar1_type          :
                                                           (bar01_size_mask[35:32]==4'b1111)        ?"bar1_64_all_one":
                                                           (bar01_size_mask[35:32]==4'b1110)        ?"bar1_64_3_one"  :
                                                           (bar01_size_mask[35:32]==4'b1100)        ?"bar1_64_2_one"  :
                                                           (bar01_size_mask[35:32]==4'b1000)        ?"bar1_64_1_one"  :"bar1_disable";

localparam [63:0] bar23_size_mask                        =  get_bar_size_mask((bar2_type=="bar2_64bit_prefetch_mem")?1:0,bar2_address_width_mux_hwtcl, bar3_address_width_mux_hwtcl) ;
localparam [27:0] bar2_size_mask                         =  bar23_size_mask[31:4]                                               ;
localparam [27:0] bar3_size_mask                         =  bar23_size_mask[63:36]                                              ;
localparam bar3_type_mod                                 = (bar2_type!="bar2_64bit_prefetch_mem")? bar3_type          :
                                                           (bar23_size_mask[35:32]==4'b1111)        ?"bar3_64_all_one":
                                                           (bar23_size_mask[35:32]==4'b1110)        ?"bar3_64_3_one"  :
                                                           (bar23_size_mask[35:32]==4'b1100)        ?"bar3_64_2_one"  :
                                                           (bar23_size_mask[35:32]==4'b1000)        ?"bar3_64_1_one"  :"bar3_disable";

localparam [63:0] bar45_size_mask                        =  get_bar_size_mask((bar4_type=="bar4_64bit_prefetch_mem")?1:0,bar4_address_width_mux_hwtcl, bar5_address_width_mux_hwtcl) ;
localparam [27:0] bar4_size_mask                         =  bar45_size_mask[31:4]                                               ;
localparam [27:0] bar5_size_mask                         =  bar45_size_mask[63:36]                                              ;
localparam bar5_type_mod                                 = (bar4_type!="bar4_64bit_prefetch_mem")? bar5_type          :
                                                           (bar45_size_mask[35:32]==4'b1111)        ?"bar5_64_all_one":
                                                           (bar45_size_mask[35:32]==4'b1110)        ?"bar5_64_3_one"  :
                                                           (bar45_size_mask[35:32]==4'b1100)        ?"bar5_64_2_one"  :
                                                           (bar45_size_mask[35:32]==4'b1000)        ?"bar5_64_1_one"  :"bar5_disable";

localparam [31:0] expansion_base_address_register        = get_expansion_base_addr_mask(expansion_base_address_register_hwtcl);

localparam MEM_CHECK=0;
localparam USE_INTERNAL_250MHZ_PLL = 1;
localparam cseb_on            = ((cseb_extend_pci=="true") || (cseb_extend_pcie=="true"))?1:0;

/// AVMM local param

localparam port_type_avmm = (port_type == "native_ep")? "Native endpoint" : "Root port";
localparam bar0_64bit_mem_space = (bar0_type == "bar0_64bit_prefetch_mem")?  "true" : "false";
localparam bar0_io_space = (bar0_type == "bar0_io_addr_space")?  "true" : "false";
localparam bar0_prefetchable = (bar0_type == "bar0_32bit_prefetch_mem")?  "true" : "false";
localparam avmm_bar0_size_mask =  bar0_address_width_mux_hwtcl;
localparam avmm_bar0_type = (bar0_type == "bar0_64bit_prefetch_mem")?  64 : 32;

localparam bar1_64bit_mem_space = (bar1_type == "bar1_64bit_prefetch_mem")?  "true" : "false";
localparam bar1_io_space = (bar1_type == "bar1_io_addr_space")?  "true" : "false";
localparam bar1_prefetchable = (bar1_type == "bar1_32bit_prefetch_mem")?  "true" : "false";
localparam avmm_bar1_size_mask =  bar1_address_width_mux_hwtcl;
localparam avmm_bar1_type = (bar1_type == "bar1_64bit_prefetch_mem")?  64 : 32;


localparam bar2_64bit_mem_space = (bar2_type == "bar2_64bit_prefetch_mem")?  "true" : "false";
localparam bar2_io_space = (bar2_type == "bar2_io_addr_space")?  "true" : "false";
localparam bar2_prefetchable = (bar2_type == "bar2_32bit_prefetch_mem")?  "true" : "false";
localparam avmm_bar2_size_mask =  bar2_address_width_mux_hwtcl;
localparam avmm_bar2_type = (bar2_type == "bar2_64bit_prefetch_mem")?  64 : 32;

localparam bar3_64bit_mem_space = (bar3_type == "bar3_64bit_prefetch_mem")?  "true" : "false";
localparam bar3_io_space = (bar3_type == "bar3_io_addr_space")?  "true" : "false";
localparam bar3_prefetchable = (bar3_type == "bar3_32bit_prefetch_mem")?  "true" : "false";
localparam avmm_bar3_size_mask =  bar3_address_width_mux_hwtcl;
localparam avmm_bar3_type = (bar3_type == "bar3_64bit_prefetch_mem")?  64 : 32;

localparam bar4_64bit_mem_space = (bar4_type == "bar4_64bit_prefetch_mem")?  "true" : "false";
localparam bar4_io_space = (bar4_type == "bar4_io_addr_space")?  "true" : "false";
localparam bar4_prefetchable = (bar4_type == "bar4_32bit_prefetch_mem")?  "true" : "false";
localparam avmm_bar4_size_mask =  bar4_address_width_mux_hwtcl;
localparam avmm_bar4_type = (bar4_type == "bar4_64bit_prefetch_mem")?  64 : 32;

localparam bar5_64bit_mem_space = (bar5_type == "bar5_64bit_prefetch_mem")?  "true" : "false";
localparam bar5_io_space = (bar5_type == "bar5_io_addr_space")?  "true" : "false";
localparam bar5_prefetchable = (bar5_type == "bar5_32bit_prefetch_mem")?  "true" : "false";
localparam avmm_bar5_size_mask =  bar5_address_width_mux_hwtcl;
localparam avmm_bar5_type = (bar5_type == "bar5_64bit_prefetch_mem")?  64 : 32;


localparam TLP_INSPECTOR                           = tlp_inspector_hwtcl;
localparam TLP_INSPECTOR_USE_SIGNAL_PROBE          = tlp_inspector_use_signal_probe_hwtcl;
localparam [127:0] TLP_INSPECTOR_POWER_UP_TRIGGER  = {tlp_insp_trg_dw3_hwtcl[31:0],tlp_insp_trg_dw2_hwtcl[31:0],tlp_insp_trg_dw1_hwtcl[31:0],tlp_insp_trg_dw0_hwtcl[31:0] };
localparam cb_pcie_rx_lite_hwtcl_local             = (interface_type_integer_hwtcl==0)?0:(include_dma_hwtcl==1)?0:cb_pcie_rx_lite_hwtcl;

// Input for internal test port (PE/TE)
wire                 synth_mode                   ;
wire                 gnd_bistenrcv          = 1'b0;
wire                 gnd_bistenrpl          = 1'b0;
wire                 gnd_bistscanen         = 1'b0;
wire                 gnd_bistscanin         = 1'b0;
wire                 gnd_bisttesten         = 1'b0;
wire                 gnd_memhiptestenable   = 1'b0;
wire                 gnd_memregscanen       = 1'b0;
wire                 gnd_scanmoden          = 1'b0;
wire                 gnd_scanshiftn         = 1'b0;
wire  [2 : 0]        gnd_m10k_select        = ZEROS[2 : 0];
// Input for past QII 10.0 support
wire  [31 : 0]       gnd_csebrddata         = ZEROS[31 : 0];
wire  [3 : 0]        gnd_csebrddataparity   = ZEROS[3 : 0];
wire  [4 : 0]        gnd_csebrdresponse     = ZEROS[4 : 0];
wire                 gnd_csebwaitrequest    = 1'b0;
wire  [4 : 0]        gnd_csebwrresponse     = ZEROS[4 : 0];
wire                 gnd_csebwrrespvalid    = 1'b0;
wire  [1 : 0]        gnd_swctmod            = ZEROS[1 : 0];
wire  [43:0]          gnd_dbgpipex1rx        = 44'h0;


wire [3 :0]        tx_st_eop_int;
wire [3 :0]        tx_st_err_int;
wire [3 :0]        tx_st_sop_int;
wire [255 : 0]     tx_st_data_int;
wire [31 : 0]      tx_st_parity_int;
wire [255 : 0]     rx_st_data_int;
wire [31 : 0]      rx_st_parity_int;
wire [31 : 0]      rx_st_be_int;
wire [3 : 0]       rx_st_sop_int;
wire [3 : 0]       rx_st_valid_int;
wire [3 : 0]       rx_st_eop_int;
wire [3 : 0]       rx_st_err_int;
wire [1 : 0]       rx_st_empty_int;
wire [7 : 0]       rx_st_bardec1;
wire [7 : 0]       rx_st_bardec2;

wire [5 : 0]       tx_cred_fc_hip_cons_int,txcredit_consumed_sriov;
wire               tx_st_err_avmm_int;

wire  [1 : 0]        mode;

// Internal wire for internal test port (PE/TE)
//wire [32 : 0] open_csebaddr;
//wire [4 : 0]  open_csebaddrparity;
//wire [3 : 0]  open_csebbe;
//wire          open_csebisshadow;
//wire          open_csebrden;
//wire [31 : 0] open_csebwrdata;
//wire [3 : 0]  open_csebwrdataparity;
//wire          open_csebwren;
//wire          open_csebwrrespreq;
wire           open_wakeoen;

wire [319:0] testout;
wire [63:0]  testin;

wire [9:0]      app_rstn;

wire        rx_st_ready_mux;
wire        rx_st_mask_mux;
wire[255:0] tx_st_data_mux;
wire [31:0] tx_st_parity_mux;
wire [3:0]  tx_st_err_mux;
wire [3:0]  tx_st_sop_mux;
wire [3:0]  tx_st_eop_mux;
wire [empty_integer_hwtcl-1:0]  tx_st_empty_mux;
wire        tx_st_valid_mux;
wire        cpl_pending_mux;
wire        app_msi_req_mux;
wire [2:0]  app_msi_tc_mux;
wire [4:0]  app_msi_num_mux;
wire        app_int_sts_mux;
wire        tx_cons_cred_sel_mux;
wire  [1:0] tx_cred_fcsel_mux;

wire        rx_st_ready_avmm;
wire        rx_st_mask_avmm;
wire[255:0] tx_st_data_avmm;
wire [31:0] tx_st_parity_avmm;
wire [3:0]  tx_st_err_avmm;
wire [3:0]  tx_st_sop_avmm;
wire [3:0]  tx_st_eop_avmm;
wire [1:0]  tx_st_empty_avmm;
wire        tx_st_valid_avmm;
wire        cpl_pending_avmm;
wire        app_msi_req_avmm;
wire [2:0]  app_msi_tc_avmm;
wire [4:0]  app_msi_num_avmm;
wire        app_int_sts_avmm;
wire        tx_cons_cred_sel_avmm;
wire [1:0]  tx_cred_fcsel_avmm;

wire[data_width_integer_hwtcl-1:0]   tx_st_data_avmm_int;
wire        tx_st_sop_avmm_int;
wire        tx_st_eop_avmm_int;
wire        pld_clk_source;
wire        coreclkout;

//=========================
// Interrupts app output mux

// legacy interrupt
wire        sriov_app_int_ack;
wire        hip_app_int_ack;

// MSI
wire        hip_app_msi_ack;
wire        sriov_app_msi_ack;

//======================================
// SR-IOV signals start
//======================================
   //RX_ST SRIOV Bridge signals connected to HIP
wire [multiple_packets_per_cycle_hwtcl:0]   rx_st_sop_hip;
wire [multiple_packets_per_cycle_hwtcl:0]   rx_st_eop_hip;
wire [multiple_packets_per_cycle_hwtcl:0]   rx_st_valid_hip;       // DUT:rx_st_valid -> bridge:rx_st_valid_hip
wire [multiple_packets_per_cycle_hwtcl:0]   rx_st_error_hip;       // DUT:rx_st_err -> bridge:rx_st_err_hip
wire [data_width_integer_hwtcl-1:0]         rx_st_data_hip;        // DUT:rx_st_data -> bridge:rx_st_data_hip
wire [empty_integer_hwtcl-1:0]              rx_st_empty_hip;       // DUT:rx_st_empty -> bridge:rx_st_empty_hip
wire                                        rx_st_ready_hip;       // Bridge: rx_st_ready_hip -> DUT:rx_st_ready
wire [data_byte_width_integer_hwtcl-1:0]    rx_st_parity_hip;      // DUT:rx_st_parity -> bridge:rx_st_parity_hip
wire                                        rx_st_mask_hip;        // Bridge:rx_st_mask_hip -> DUT:rx_st_mask

   //RX_ST SRIOV Bridge signals connected to APP
wire [multiple_packets_per_cycle_hwtcl:0]   rx_st_sop_app;
wire [multiple_packets_per_cycle_hwtcl:0]   rx_st_eop_app;
wire [multiple_packets_per_cycle_hwtcl:0]   rx_st_valid_app;       // APP:rx_st_valid -> bridge:rx_st_valid_app
wire [multiple_packets_per_cycle_hwtcl:0]   rx_st_err_app;         // APP:rx_st_err -> bridge:rx_st_err_app
wire [data_width_integer_hwtcl-1:0]         rx_st_data_app;        // APP:rx_st_data -> bridge:rx_st_data_app
wire [empty_integer_hwtcl-1:0]              rx_st_empty_app;       // APP:rx_st_empty -> bridge:rx_st_empty_app  // TBD => Check how empty_integer_hwtcl is derived
wire [data_byte_width_integer_hwtcl-1:0]    rx_st_parity_app;      // APP:rx_st_parity -> bridge:rx_st_parity_app

   // TX_ST SR-IOV Bridge signals connected to HIP
wire    [multiple_packets_per_cycle_hwtcl:0] tx_st_sop_hip;        // bridge:tx_st_sop_hip -> DUT:tx_st_sop
wire    [multiple_packets_per_cycle_hwtcl:0] tx_st_eop_hip;        // bridge:tx_st_eop_hip -> DUT:tx_st_eop
wire    [multiple_packets_per_cycle_hwtcl:0] tx_st_error_hip;      // bridge:tx_st_err_hip -> DUT:tx_st_err
wire    [multiple_packets_per_cycle_hwtcl:0] tx_st_valid_hip;      // bridge:tx_st_valid_hip -> DUT:tx_st_valid
wire    [1:0]                                tx_st_empty_hip;      // bridge:tx_st_empty_hip -> DUT:tx_st_empty
wire                                         tx_st_ready_hip;      // DUT:tx_st_ready -> bridge:tx_st_ready_hip
wire  [data_width_integer_hwtcl-1:0]         tx_st_data_hip;       // bridge:tx_st_data_hip -> DUT:tx_st_data
wire  [data_byte_width_integer_hwtcl-1:0]    tx_st_parity_hip;

   // TX_ST SR-IOV Bridge signals connected to APP
wire                                         tx_st_ready_app;      // APP:tx_st_ready -> bridge:tx_st_ready_app
wire  [1:0]                                  tx_st_empty_app;

wire                                   extraBAR_lock_int; // Set to 1 to disable writes to Extra BAR
wire [total_pf_count_hwtcl-1:0]        devhide_pf_int;    // When the ith bits is set to 1, Config accesses
                                                          // to PF i will generate UR.
wire                                   device_rciep_int;  // When set to 1, device will advertise itself
                                                          // as RC Integrated EndPoint.


//===================
// LMI Interface
//===================
//  From SR-IOV to LMI SHIM
wire   [11:0] lmi_addr_pld;                  // bridge:lmi_addr_hip -> SHIM:lmi_addr
wire   [31:0] lmi_din_pld;                   // bridge:lmi_din_hip -> SHIM:lmi_din
wire          lmi_wren_pld;                  // bridge:lmi_wren_hip -> SHIM:lmi_wren
wire          lmi_rden_pld;                  // bridge:lmi_rden_hip -> SHIM:lmi_rden
wire          lmi_ack_pld;                   // SHIM:lmi_ack -> bridge:lmi_ack_hip
wire   [31:0] lmi_dout_pld;                  // SHIM:lmi_dout -> bridge:lmi_dout_hip

//  From LMI SHIM to HIP
wire   [11:0] lmi_addr_hip;                  // SHIM:lmi_addr_hip -> HIP:lmi_addr
wire   [ 7:0] lmi_din_hip;                   // SHIM:lmi_din_hip -> HIP:lmi_din
wire          lmi_wren_hip;                  // SHIM:lmi_wren_hip -> HIP:lmi_wren
wire          lmi_rden_hip;                  // SHIM:lmi_rden_hip -> HIP:lmi_rden
wire          lmi_ack_hip;                   // HIP:lmi_ack -> SHIM:lmi_ack_hip
wire   [ 7:0] lmi_dout_hip;                  // HIP:lmi_dout -> SHIM:lmi_dout_hip

// From Mux To HIP
wire   [11:0] lmi_addr_mux;                  // MUX:lmi_addr_mux -> DUT:lmi_addr
wire   [ 7:0] lmi_din_mux;                   // MUX:lmi_din_mux  -> DUT:lmi_din
wire          lmi_wren_mux;                  // MUX:lmi_wren_mux -> DUT:lmi_wren
wire          lmi_rden_mux;                  // MUX:lmi_rden_mux -> DUT:lmi_rden

// To External APP
wire          lmi_ack_app;                   // APP:lmi_ack -> bridge:lmi_ack_app
wire   [31:0] lmi_dout_app;                  // APP:lmi_dout -> bridge:lmi_dout_app

// Config-Bypass Outputs from SR-IOV
wire  [link2csr_width_hwtcl-1 :0]     sriov_cfgbp_link2csr;
wire             sriov_cfgbp_comclk_reg;
wire             sriov_cfgbp_extsy_reg;
wire  [2:0]      sriov_cfgbp_max_pload;
wire             sriov_cfgbp_tx_ecrcgen;
wire             sriov_cfgbp_rx_ecrchk;
wire  [7:0]      sriov_cfgbp_secbus;
wire             sriov_cfgbp_linkcsr_bit0;
wire             sriov_cfgbp_tx_req_pm;
wire  [2:0]      sriov_cfgbp_tx_typ_pm;
wire  [3:0]      sriov_cfgbp_req_phypm;
wire  [3:0]      sriov_cfgbp_req_phycfg;
wire  [6:0]      sriov_cfgbp_vc0_tcmap_pld;
wire             sriov_cfgbp_inh_dllp;
wire             sriov_cfgbp_inh_tx_tlp;
wire             sriov_cfgbp_req_wake;
wire  [1:0]      sriov_cfgbp_link3_ctl;

// Config-Bypass Outputs from HIP
wire  [link2csr_width_hwtcl-1 :0]     hip_cfgbp_link2csr;
wire             hip_cfgbp_comclk_reg;
wire             hip_cfgbp_extsy_reg;
wire  [2:0]      hip_cfgbp_max_pload;
wire             hip_cfgbp_tx_ecrcgen;
wire             hip_cfgbp_rx_ecrchk;
wire  [7:0]      hip_cfgbp_secbus;
wire             hip_cfgbp_linkcsr_bit0;
wire             hip_cfgbp_tx_req_pm;
wire  [2:0]      hip_cfgbp_tx_typ_pm;
wire  [3:0]      hip_cfgbp_req_phypm;
wire  [3:0]      hip_cfgbp_req_phycfg;
wire  [6:0]      hip_cfgbp_vc0_tcmap_pld;
wire             hip_cfgbp_inh_dllp;
wire             hip_cfgbp_inh_tx_tlp;
wire             hip_cfgbp_req_wake;
wire  [1:0]      hip_cfgbp_link3_ctl;


reg [1:0]       ltssmstate_reg0;
reg [1:0]       ltssmstate_reg1;
reg [1:0]       ltssmstate_reg2;
reg [1:0]       ltssmstate_reg3;
reg [1:0]       ltssmstate_reg4;
wire [4:0]      ltssmstate_reg;


//=============== End of SR-IOV signals

wire             pld_core_ready_int;

assign mode            = (port_type=="native_ep")?2'b00:2'b10;
assign tx_st_eop_int   = (multiple_packets_per_cycle_hwtcl==1)?{2'b00, tx_st_eop}:{3'b000, tx_st_eop};
assign tx_st_err_int   = (multiple_packets_per_cycle_hwtcl==1)?{2'b00, tx_st_err}:{3'b000, tx_st_err};
assign tx_st_sop_int   = (multiple_packets_per_cycle_hwtcl==1)?{2'b00, tx_st_sop}:{3'b000, tx_st_sop};

assign rx_st_sop_hip   = (multiple_packets_per_cycle_hwtcl==1)?rx_st_sop_int[1:0]:rx_st_sop_int[0];
assign rx_st_eop_hip   = (multiple_packets_per_cycle_hwtcl==1)?rx_st_eop_int[1:0]:rx_st_eop_int[0];
assign rx_st_valid_hip = (multiple_packets_per_cycle_hwtcl==1)?{1'b0,rx_st_valid_int[0]}:rx_st_valid_int[0];
assign rx_st_error_hip = (multiple_packets_per_cycle_hwtcl==1)?{1'b0,|rx_st_err_int}:|rx_st_err_int;
assign rx_st_data_hip[data_width_integer_hwtcl-1 :0]        = rx_st_data_int[ data_width_integer_hwtcl-1 :0];
assign rx_st_parity_hip[data_byte_width_integer_hwtcl-1 :0] = rx_st_parity_int[data_byte_width_integer_hwtcl-1:0];
assign rx_st_empty_hip =  rx_st_empty_int;

assign pld_core_ready_int = (interface_type_integer_hwtcl==1)? serdes_pll_locked : pld_core_ready;

generate begin : g_rx_st
   if (include_sriov_hwtcl==1) begin : sriov
      // External APP RX_ST outputs
      assign  rx_st_sop       = rx_st_sop_app    ;
      assign  rx_st_eop       = rx_st_eop_app    ;
      assign  rx_st_valid     = rx_st_valid_app  ;
      assign  rx_st_err       = rx_st_err_app    ;
      assign  rx_st_data      = rx_st_data_app   ;
      assign  rx_st_empty     = rx_st_empty_app[empty_integer_hwtcl-1:0];
      assign  rx_st_parity    = rx_st_parity_app ;

      // HIP Inputs => Muxing between SR-IOV output and external inputs
      assign rx_st_ready_mux  =  rx_st_ready_hip;
      assign rx_st_mask_mux   =  rx_st_mask_hip;
   end else begin : nosriov
      // External APP RX_ST outputs
      assign  rx_st_sop       = rx_st_sop_hip   ;
      assign  rx_st_eop       = rx_st_eop_hip   ;
      assign  rx_st_valid     = rx_st_valid_hip ;
      assign  rx_st_err       = rx_st_error_hip;
      assign  rx_st_data      = rx_st_data_hip  ;
      assign  rx_st_empty     = rx_st_empty_hip[empty_integer_hwtcl-1:0];
      assign  rx_st_parity    = rx_st_parity_hip;

      // HIP Inputs => Muxing between AVMM output and external inputs
      assign rx_st_ready_mux      =  (interface_type_integer_hwtcl==1)? rx_st_ready_avmm  : rx_st_ready;
      assign rx_st_mask_mux       =  (interface_type_integer_hwtcl==1)? rx_st_mask_avmm   : rx_st_mask;
   end
end
endgenerate
generate begin : g_tx_credit_hip
  if (include_sriov_hwtcl==1 && sriov2_en==1) begin : sriovcredit
    assign tx_cred_fc_hip_cons = txcredit_consumed_sriov;
  end else begin : nosriovcredit
    assign tx_cred_fc_hip_cons = tx_cred_fc_hip_cons_int;
  end
end
endgenerate

//=================================
//Derive TX_ST interface
//=================================
generate begin : g_tx_st
   if (include_sriov_hwtcl==1) begin : sriov
      // Inputs to HIP
      assign tx_st_sop_mux        =  {3'h0, tx_st_sop_hip};
      assign tx_st_eop_mux        =  {3'h0, tx_st_eop_hip};
      assign tx_st_err_mux        =  {3'h0, tx_st_error_hip};
      assign tx_st_valid_mux      =  {4'h0, tx_st_valid_hip};
      assign tx_st_empty_mux      =  tx_st_empty_hip ;
      assign tx_st_data_mux       =  tx_st_data_hip;
      assign tx_st_parity_mux     =  tx_st_parity_hip;

      // Outputs from HIP or SR-IOV Bridge to external APP
      assign tx_st_ready          =  tx_st_ready_app;
      assign tx_st_empty_app      =  tx_st_empty;
          assign tx_st_sop_avmm       = {4{1'b0}};
          assign tx_st_eop_avmm       = {4{1'b0}};
          assign tx_st_data_avmm_int  = {data_width_integer_hwtcl{1'b0}};
   end else begin : nosriov
      // Inputs to HIP
      // Muxing between AVMM apps output and external inputs to the HIP
      assign tx_st_sop_mux        =  (interface_type_integer_hwtcl==1)? tx_st_sop_avmm_int     : tx_st_sop_int;
      assign tx_st_eop_mux        =  (interface_type_integer_hwtcl==1)? tx_st_eop_avmm_int     : tx_st_eop_int;
      assign tx_st_err_mux        =  (interface_type_integer_hwtcl==1)? 4'h0                   : tx_st_err_int;
      //assign tx_st_err_mux        =  (interface_type_integer_hwtcl==1)? {3'h0, tx_st_err_avmm_int}   : tx_st_err_int;
      assign tx_st_valid_mux      =  (interface_type_integer_hwtcl==1)? tx_st_valid_avmm       : tx_st_valid;
      assign tx_st_empty_mux      =  (interface_type_integer_hwtcl==1)? tx_st_empty_avmm       : tx_st_empty;
      assign tx_st_data_mux       =  (interface_type_integer_hwtcl==1)? tx_st_data_avmm        : tx_st_data_int;
      assign tx_st_parity_mux     =  (interface_type_integer_hwtcl==1)? 32'h0                  : tx_st_parity_int;

      // Outputs from HIP or SR-IOV Bridge to external APP
      assign tx_st_ready          =  tx_st_ready_hip;
   end
end
endgenerate

generate begin : g_custom_features_if
  if (enable_custom_features_hwtcl==1) begin : custom_features
    assign extraBAR_lock_int         =   extraBAR_lock   ;
    assign devhide_pf_int            =   devhide_pf  ;
    assign device_rciep_int          =   device_rciep;
  end else begin : no_custom_features
    assign extraBAR_lock_int         =   1'b0   ;
    assign devhide_pf_int            =   {total_pf_count_hwtcl{1'b0}}  ;
    assign device_rciep_int          =   1'b0;
  end
end
endgenerate

//=================================
// Reset synchronizer
//=================================
generate begin : g_rst_sync
   if ((interface_type_integer_hwtcl == 1) || (include_sriov_hwtcl == 1)) begin : syncrstn_avmm_sriov
         // Reset synchronizer
         altpcie_reset_delay_sync #(
            .ACTIVE_RESET           (0),
            .WIDTH_RST              (10),
            .NODENAME               ("app_rstn_altpcie_reset_delay_sync_altpcie_a10_hip_hwtcl"),
            .LOCK_TIME_CNT_WIDTH    (1)
         ) app_rstn_altpcie_reset_delay_sync_altpcie_a10_hip_hwtcl (
            .clk         (coreclkout_hip),
            .async_rst   (~reset_status),
            .sync_rst(app_rstn[9:0])
         );
   end
end
endgenerate

//=================================
//Derive LMI interface
//=================================
generate begin : g_lmi
   if (include_sriov_hwtcl==1) begin : sriov
      // From SR-IOV to HIP
      assign lmi_addr_mux  = lmi_addr_hip ;
      assign lmi_din_mux   = lmi_din_hip[7:0] ;
      assign lmi_wren_mux  = lmi_wren_hip ;
      assign lmi_rden_mux  = lmi_rden_hip ;
      // From SR-IOV to external APP
      assign lmi_ack       = lmi_ack_app  ;
      assign lmi_dout      = lmi_dout_app ;
   end else begin : nosriov
      // From external APP to HIP
      assign lmi_addr_mux  = lmi_addr  ;
      assign lmi_din_mux   = lmi_din[7:0];
      assign lmi_wren_mux  = lmi_wren  ;
      assign lmi_rden_mux  = lmi_rden  ;
      // From HIP to external APP
      assign lmi_ack       = lmi_ack_hip;
      assign lmi_dout      = lmi_dout_hip;
   end
end
endgenerate

generate begin : g_int
   if (include_sriov_hwtcl==1) begin : g_sriov
      assign cpl_pending_mux      =  1'b0 ;
      assign app_msi_req_mux      =  1'b0 ;
      assign app_msi_tc_mux       =  3'h0 ;
      assign app_msi_num_mux      =  5'h0 ;
      assign app_int_sts_mux      =  1'b0 ;
      assign app_int_ack          =  sriov_app_int_ack;
      assign app_msi_ack          =  sriov_app_msi_ack;
   end else begin : g_nosriov
      assign cpl_pending_mux      =  (interface_type_integer_hwtcl==1)? cpl_pending_avmm       : cpl_pending;
      assign app_msi_req_mux      =  (interface_type_integer_hwtcl==1)? app_msi_req_avmm       : app_msi_req;
      assign app_msi_tc_mux       =  (interface_type_integer_hwtcl==1)? app_msi_tc_avmm        : app_msi_tc;
      assign app_msi_num_mux      =  (interface_type_integer_hwtcl==1)? app_msi_num_avmm       : app_msi_num;
      assign app_int_sts_mux      =  (interface_type_integer_hwtcl==1 && cg_enable_advanced_interrupt_hwtcl== 1)? intx_req_i : (interface_type_integer_hwtcl==1)? app_int_sts_avmm    : app_int_sts;
      assign app_int_ack          =  hip_app_int_ack;
      assign app_msi_ack          =  hip_app_msi_ack;
   end
end
endgenerate

// Config-Bypass signals
generate begin : g_cfgbp
   if (include_sriov_hwtcl==1) begin : cfgbp
      assign  hip_cfgbp_link2csr                = sriov_cfgbp_link2csr ;
      assign  hip_cfgbp_comclk_reg              = sriov_cfgbp_comclk_reg ;
      assign  hip_cfgbp_extsy_reg               = sriov_cfgbp_extsy_reg ;
      assign  hip_cfgbp_max_pload               = sriov_cfgbp_max_pload ;
      assign  hip_cfgbp_tx_ecrcgen              = sriov_cfgbp_tx_ecrcgen ;
      assign  hip_cfgbp_rx_ecrchk               = sriov_cfgbp_rx_ecrchk ;
      assign  hip_cfgbp_secbus                  = sriov_cfgbp_secbus ;
      assign  hip_cfgbp_linkcsr_bit0            = sriov_cfgbp_linkcsr_bit0 ;
      assign  hip_cfgbp_tx_req_pm               = sriov_cfgbp_tx_req_pm ;
      assign  hip_cfgbp_tx_typ_pm               = sriov_cfgbp_tx_typ_pm ;
      assign  hip_cfgbp_req_phypm               = sriov_cfgbp_req_phypm ;
      assign  hip_cfgbp_req_phycfg              = sriov_cfgbp_req_phycfg ;
      assign  hip_cfgbp_vc0_tcmap_pld           = sriov_cfgbp_vc0_tcmap_pld ;
      assign  hip_cfgbp_inh_dllp                = sriov_cfgbp_inh_dllp ;
      assign  hip_cfgbp_inh_tx_tlp              = sriov_cfgbp_inh_tx_tlp ;
      assign  hip_cfgbp_req_wake                = sriov_cfgbp_req_wake ;
      assign  hip_cfgbp_link3_ctl               = sriov_cfgbp_link3_ctl;
   end else begin : g_nosriov
      assign  hip_cfgbp_link2csr                = cfgbp_link2csr ;
      assign  hip_cfgbp_comclk_reg              = cfgbp_comclk_reg ;
      assign  hip_cfgbp_extsy_reg               = cfgbp_extsy_reg ;
      assign  hip_cfgbp_max_pload               = cfgbp_max_pload ;
      assign  hip_cfgbp_tx_ecrcgen              = cfgbp_tx_ecrcgen ;
      assign  hip_cfgbp_rx_ecrchk               = cfgbp_rx_ecrchk ;
      assign  hip_cfgbp_secbus                  = cfgbp_secbus ;
      assign  hip_cfgbp_linkcsr_bit0            = cfgbp_linkcsr_bit0 ;
      assign  hip_cfgbp_tx_req_pm               = cfgbp_tx_req_pm ;
      assign  hip_cfgbp_tx_typ_pm               = cfgbp_tx_typ_pm ;
      assign  hip_cfgbp_req_phypm               = cfgbp_req_phypm ;
      assign  hip_cfgbp_req_phycfg              = cfgbp_req_phycfg ;
      assign  hip_cfgbp_vc0_tcmap_pld           = cfgbp_vc0_tcmap_pld ;
      assign  hip_cfgbp_inh_dllp                = cfgbp_inh_dllp ;
      assign  hip_cfgbp_inh_tx_tlp              = cfgbp_inh_tx_tlp ;
      assign  hip_cfgbp_req_wake                = cfgbp_req_wake ;
      assign  hip_cfgbp_link3_ctl               = cfgbp_link3_ctl;
   end
end
endgenerate


assign tx_cons_cred_sel_mux =  (interface_type_integer_hwtcl==1)? tx_cons_cred_sel_avmm  : tx_cred_cons_select;
assign tx_cred_fcsel_mux    =  (interface_type_integer_hwtcl==1)? tx_cred_fcsel_avmm     : tx_cred_fc_sel;
assign pld_clk_source       =  (interface_type_integer_hwtcl==1)? coreclkout_hip         : pld_clk;

assign ko_cpl_spc_header = ko_compl_header;
assign ko_cpl_spc_data = ko_compl_data;

assign rx_st_bar       =  rx_st_bardec1[7:0];

generate begin : g_tx_data
   if (ast_width_tx=="tx_256") begin : tx256
      assign tx_st_data_int[255:0]       = tx_st_data[255:0] ;
      assign tx_st_parity_int[31:0]      = tx_st_parity[31:0];
   end
   else if (ast_width_tx=="tx_128") begin : tx128
      assign tx_st_data_int[255:0]       = {128'h0,tx_st_data[127:0]};
      assign tx_st_parity_int[31:0]      = {16'h0,tx_st_parity[15:0]};
   end
   else begin : tx_64
      assign tx_st_data_int[255:0]       = {192'h0,tx_st_data[63:0]};
      assign tx_st_parity_int[31:0]      = {24'h0,tx_st_parity[7:0]};
   end
end
endgenerate


//npor Reset Synchronizer on pld_clk
assign testin_zero                  = (enable_devkit_conduit_hwtcl==1)?devkit_ctrl[0]:test_in[0];
assign sim_ltssmstate               = ltssmstate;
assign sim_pipe_pclk_out            = sim_pipe_pclk_in;

//Config. Bypass output ports
assign cfgbp_lane_err               = tl_cfg_sts[52:45];
assign cfgbp_link_equlz_req         = tl_cfg_sts[44];
assign cfgbp_equiz_complete         = tl_cfg_sts[43];
assign cfgbp_phase_3_successful     = tl_cfg_sts[42];
assign cfgbp_phase_2_successful     = tl_cfg_sts[41];
assign cfgbp_phase_1_successful     = tl_cfg_sts[40];
assign cfgbp_current_deemph         = tl_cfg_sts[39];
assign cfgbp_current_speed          = tl_cfg_sts[38:37];
assign cfgbp_link_up                = tl_cfg_sts[26];
assign cfgbp_link_train             = tl_cfg_sts[25];
assign cfgbp_10state                = tl_cfg_sts[24];
assign cfgbp_10sstate               = tl_cfg_sts[23];
assign cfgbp_rx_val_pm              = tl_cfg_sts[19];
assign cfgbp_rx_typ_pm              = tl_cfg_sts[18:16];
assign cfgbp_tx_ack_pm              = tl_cfg_sts[15];
assign cfgbp_ack_phypm              = tl_cfg_sts[12:11];
assign cfgbp_vc_status              = tl_cfg_sts[10];
assign cfgbp_rxfc_max               = tl_cfg_sts[9];
assign cfgbp_txfc_max               = tl_cfg_sts[8];
assign cfgbp_txbuf_emp              = tl_cfg_sts[7];
assign cfgbp_cfgbuf_emp             = tl_cfg_sts[6];
assign cfgbp_rpbuf_emp              = tl_cfg_sts[5];
assign cfgbp_dll_req                = tl_cfg_sts[4];
assign cfgbp_link_auto_bdw_status   = tl_cfg_sts[3];
assign cfgbp_link_bdw_mng_status    = tl_cfg_sts[2];
assign cfgbp_rst_tx_margin_field    = tl_cfg_sts[1];
assign cfgbp_rst_enter_comp_bit     = tl_cfg_sts[0];
assign cfgbp_rx_st_ecrcerr          = rx_st_bardec1[3:0];
assign cfgbp_err_uncorr_internal    = tl_cfg_ctl[15];
assign cfgbp_rx_corr_internal       = tl_cfg_ctl[14];
assign cfgbp_err_tlrcvovf           = tl_cfg_ctl[13];
assign cfgbp_txfc_err               = tl_cfg_ctl[12];
assign cfgbp_err_tlmalf             = tl_cfg_ctl[11];
assign cfgbp_err_surpdwn_dll        = tl_cfg_ctl[10];
assign cfgbp_err_dllrev             = tl_cfg_ctl[9];
assign cfgbp_err_dll_repnum         = tl_cfg_ctl[8];
assign cfgbp_err_dllreptim          = tl_cfg_ctl[7];
assign cfgbp_err_dllp_baddllp       = tl_cfg_ctl[6];
assign cfgbp_err_dll_badtlp         = tl_cfg_ctl[5];
assign cfgbp_err_phy_tng            = tl_cfg_ctl[4];
assign cfgbp_err_phy_rcv            = tl_cfg_ctl[3];
assign cfgbp_root_err_reg_sts       = tl_cfg_ctl[2];
assign cfgbp_corr_err_reg_sts       = tl_cfg_ctl[1];
assign cfgbp_unc_err_reg_sts        = tl_cfg_ctl[0];


// Output Pipe interface
wire  [2 : 0]        eidleinfersel0_w;
wire  [2 : 0]        eidleinfersel1_w;
wire  [2 : 0]        eidleinfersel2_w;
wire  [2 : 0]        eidleinfersel3_w;
wire  [2 : 0]        eidleinfersel4_w;
wire  [2 : 0]        eidleinfersel5_w;
wire  [2 : 0]        eidleinfersel6_w;
wire  [2 : 0]        eidleinfersel7_w;
wire  [1 : 0]        powerdown0_w;
wire  [1 : 0]        powerdown1_w;
wire  [1 : 0]        powerdown2_w;
wire  [1 : 0]        powerdown3_w;
wire  [1 : 0]        powerdown4_w;
wire  [1 : 0]        powerdown5_w;
wire  [1 : 0]        powerdown6_w;
wire  [1 : 0]        powerdown7_w;
wire                 rxpolarity0_w;
wire                 rxpolarity1_w;
wire                 rxpolarity2_w;
wire                 rxpolarity3_w;
wire                 rxpolarity4_w;
wire                 rxpolarity5_w;
wire                 rxpolarity6_w;
wire                 rxpolarity7_w;
wire                 txcompl0_w;
wire                 txcompl1_w;
wire                 txcompl2_w;
wire                 txcompl3_w;
wire                 txcompl4_w;
wire                 txcompl5_w;
wire                 txcompl6_w;
wire                 txcompl7_w;
wire  [31 : 0]       txdata0_w;
wire  [31 : 0]       txdata1_w;
wire  [31 : 0]       txdata2_w;
wire  [31 : 0]       txdata3_w;
wire  [31 : 0]       txdata4_w;
wire  [31 : 0]       txdata5_w;
wire  [31 : 0]       txdata6_w;
wire  [31 : 0]       txdata7_w;
wire  [3  : 0]       txdatak0_w;
wire  [3  : 0]       txdatak1_w;
wire  [3  : 0]       txdatak2_w;
wire  [3  : 0]       txdatak3_w;
wire  [3  : 0]       txdatak4_w;
wire  [3  : 0]       txdatak5_w;
wire  [3  : 0]       txdatak6_w;
wire  [3  : 0]       txdatak7_w;
wire                 txdetectrx0_w;
wire                 txdetectrx1_w;
wire                 txdetectrx2_w;
wire                 txdetectrx3_w;
wire                 txdetectrx4_w;
wire                 txdetectrx5_w;
wire                 txdetectrx6_w;
wire                 txdetectrx7_w;
wire                 txelecidle0_w;
wire                 txelecidle1_w;
wire                 txelecidle2_w;
wire                 txelecidle3_w;
wire                 txelecidle4_w;
wire                 txelecidle5_w;
wire                 txelecidle6_w;
wire                 txelecidle7_w;
wire  [2 : 0]        txmargin0_w;
wire  [2 : 0]        txmargin1_w;
wire  [2 : 0]        txmargin2_w;
wire  [2 : 0]        txmargin3_w;
wire  [2 : 0]        txmargin4_w;
wire  [2 : 0]        txmargin5_w;
wire  [2 : 0]        txmargin6_w;
wire  [2 : 0]        txmargin7_w;
wire                 txdeemph0_w;
wire                 txdeemph1_w;
wire                 txdeemph2_w;
wire                 txdeemph3_w;
wire                 txdeemph4_w;
wire                 txdeemph5_w;
wire                 txdeemph6_w;
wire                 txdeemph7_w;
wire                 txswing0_w;
wire                 txswing1_w;
wire                 txswing2_w;
wire                 txswing3_w;
wire                 txswing4_w;
wire                 txswing5_w;
wire                 txswing6_w;
wire                 txswing7_w;
wire  [1 : 0]        rate0_w;
wire  [1 : 0]        rate1_w;
wire  [1 : 0]        rate2_w;
wire  [1 : 0]        rate3_w;
wire  [1 : 0]        rate4_w;
wire  [1 : 0]        rate5_w;
wire  [1 : 0]        rate6_w;
wire  [1 : 0]        rate7_w;
wire                 txdataskip0_w;
wire                 txdataskip1_w;
wire                 txdataskip2_w;
wire                 txdataskip3_w;
wire                 txdataskip4_w;
wire                 txdataskip5_w;
wire                 txdataskip6_w;
wire                 txdataskip7_w;
wire                 txblkst0_w;
wire                 txblkst1_w;
wire                 txblkst2_w;
wire                 txblkst3_w;
wire                 txblkst4_w;
wire                 txblkst5_w;
wire                 txblkst6_w;
wire                 txblkst7_w;
wire  [1 : 0]        txsynchd0_w;
wire  [1 : 0]        txsynchd1_w;
wire  [1 : 0]        txsynchd2_w;
wire  [1 : 0]        txsynchd3_w;
wire  [1 : 0]        txsynchd4_w;
wire  [1 : 0]        txsynchd5_w;
wire  [1 : 0]        txsynchd6_w;
wire  [1 : 0]        txsynchd7_w;
wire  [17 : 0]       currentcoeff0_w;
wire  [17 : 0]       currentcoeff1_w;
wire  [17 : 0]       currentcoeff2_w;
wire  [17 : 0]       currentcoeff3_w;
wire  [17 : 0]       currentcoeff4_w;
wire  [17 : 0]       currentcoeff5_w;
wire  [17 : 0]       currentcoeff6_w;
wire  [17 : 0]       currentcoeff7_w;
wire  [2 : 0]        currentrxpreset0_w;
wire  [2 : 0]        currentrxpreset1_w;
wire  [2 : 0]        currentrxpreset2_w;
wire  [2 : 0]        currentrxpreset3_w;
wire  [2 : 0]        currentrxpreset4_w;
wire  [2 : 0]        currentrxpreset5_w;
wire  [2 : 0]        currentrxpreset6_w;
wire  [2 : 0]        currentrxpreset7_w;

//Add the connection for the reconfig_clk signals when adme is enabled

wire                 xcvr_reconfig_clk_muxed;
wire                 reconfig_pll0_clk_muxed;
wire                 reconfig_pll1_clk_muxed;

assign xcvr_reconfig_clk_muxed = adme_enable_hwtcl ? refclk : enable_soft_dfe ? refclk : xcvr_reconfig_clk;
assign reconfig_pll0_clk_muxed = adme_enable_hwtcl ? refclk : reconfig_pll0_clk;
assign reconfig_pll1_clk_muxed = adme_enable_hwtcl ? refclk : reconfig_pll1_clk;


altpcie_a10_hip_pipen1b # (
      .adme_enable_hwtcl                                             (adme_enable_hwtcl                                             ),
      .reconfig_address_width_integer_hwtcl                          (reconfig_address_width_integer_hwtcl                          ),
      .MEM_CHECK                                                     (MEM_CHECK                                                     ),
      .USE_INTERNAL_250MHZ_PLL                                       (USE_INTERNAL_250MHZ_PLL                                       ),
      .USE_ALTPCIE_RS_HIP_LOGIC                                      (USE_ALTPCIE_RS_HIP_LOGIC                                      ),
      .cseb_autonomous_hwtcl                                         (cseb_autonomous_hwtcl                                         ),
      .speed_change_hwtcl                                            (speed_change_hwtcl                                            ),
      .hip_reconfig                                                  (hip_reconfig_hwtcl                                            ),
      .func_mode                                                     (func_mode                                                     ),
      .sup_mode                                                      (sup_mode                                                      ),
      .lane_rate                                                     (lane_rate                                                     ),
      .link_width                                                    (link_width                                                    ),
      .port_type                                                     (port_type                                                     ),
      .pcie_base_spec                                                (pcie_base_spec                                                ),
      .app_interface_width                                           (app_interface_width                                           ),
      .rx_buffer_credit_alloc                                        (rx_buffer_credit_alloc                                        ),
      .hrdrstctrl_en                                                 (hrdrstctrl_en                                                 ),
      .uc_calibration_en                                             ((ALTPCIE_A10_HIP_AST_HWTCL_SIM_ONLY==1)?"uc_calibration_dis":uc_calibration_en  ),
      .cvp_enable                                                    ((ALTPCIE_A10_HIP_AST_HWTCL_SIM_ONLY==1)?"cvp_dis":cvp_enable  ),
      .enable_es_patch                                               (enable_es_patch                                               ),
      .advance_error_reporting                                       (advance_error_reporting                                       ),
      .sim_mode                                                      (sim_mode                                                      ),
      .bar0_type                                                     (bar0_type                                                     ),
      .bar1_type                                                     (bar1_type_mod                                                 ),
      .bar2_type                                                     (bar2_type                                                     ),
      .bar3_type                                                     (bar3_type_mod                                                 ),
      .bar4_type                                                     (bar4_type                                                     ),
      .bar5_type                                                     (bar5_type_mod                                                 ),
      .bar0_size_mask                                                (bar0_size_mask                                                ),
      .bar1_size_mask                                                (bar1_size_mask                                                ),
      .bar2_size_mask                                                (bar2_size_mask                                                ),
      .bar3_size_mask                                                (bar3_size_mask                                                ),
      .bar4_size_mask                                                (bar4_size_mask                                                ),
      .bar5_size_mask                                                (bar5_size_mask                                                ),
      .acknack_base                                                  (acknack_base                                                  ),
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
      .bist_memory_settings                                          (bist_memory_settings_bit_vec[83:0]                            ),
      .bridge_port_vga_enable                                        (bridge_port_vga_enable                                        ),
      .bridge_port_ssid_support                                      (bridge_port_ssid_support                                      ),
      .bypass_cdc                                                    (bypass_cdc                                                    ),
      .bypass_clk_switch                                             ((ALTPCIE_A10_HIP_AST_HWTCL_SIM_ONLY==1)?"true":bypass_clk_switch),
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
      .cseb_bar_match_checking                                       (cseb_bar_match_checking                                       ),
      .cseb_config_bypass                                            (cseb_config_bypass                                            ),
      .cseb_cpl_status_during_cvp                                    ((ALTPCIE_A10_HIP_AST_HWTCL_SIM_ONLY==1)?"config_retry_status":cseb_cpl_status_during_cvp),
      .cseb_cpl_tag_checking                                         ((force_tag_checking_on_hwtcl == 1)? "enable" : (cseb_config_bypass=="enable")?cseb_cpl_tag_checking:(extended_tag_support_hwtcl== 1)? "disable" : "enable"        ),
      .cseb_disable_auto_crs                                         (cseb_disable_auto_crs                                         ),
      .cseb_extend_pci                                               (cseb_extend_pci                                               ),
      .cseb_extend_pcie                                              (cseb_extend_pcie                                              ),
      .cseb_min_error_checking                                       (cseb_min_error_checking                                       ),
      .cseb_route_to_avl_rx_st                                       (cseb_route_to_avl_rx_st                                       ),
      .cseb_temp_busy_crs                                            (cseb_temp_busy_crs                                            ),
      .cvp_clk_reset                                                 ((ALTPCIE_A10_HIP_AST_HWTCL_SIM_ONLY==1)?"false":cvp_clk_reset),
      .cvp_data_compressed                                           ((ALTPCIE_A10_HIP_AST_HWTCL_SIM_ONLY==1)?"false":cvp_data_compressed),
      .cvp_data_encrypted                                            ((ALTPCIE_A10_HIP_AST_HWTCL_SIM_ONLY==1)?"false":cvp_data_encrypted),
      .cvp_mode_reset                                                ((ALTPCIE_A10_HIP_AST_HWTCL_SIM_ONLY==1)?"false":cvp_mode_reset),
      .cvp_rate_sel                                                  ((ALTPCIE_A10_HIP_AST_HWTCL_SIM_ONLY==1)?"full_rate":cvp_rate_sel),
      .d0_pme                                                        (d0_pme                                                        ),
      .d1_pme                                                        (d1_pme                                                        ),
      .d2_pme                                                        (d2_pme                                                        ),
      .d1_support                                                    (d1_support                                                    ),
      .d2_support                                                    (d2_support                                                    ),
      .d3_hot_pme                                                    (d3_hot_pme                                                    ),
      .d3_cold_pme                                                   (d3_cold_pme                                                   ),
      .data_pack_rx                                                  (data_pack_rx                                                  ),
      .deemphasis_enable                                             (deemphasis_enable                                             ),
      .deskew_comma                                                  (deskew_comma                                                  ),
      .device_id                                                     (device_id                                                     ),
      .device_number                                                 (device_number                                                 ),
      .device_specific_init                                          (device_specific_init                                          ),
      .dft_clock_obsrv_en                                            (dft_clock_obsrv_en                                            ),
      .dft_clock_obsrv_sel                                           (dft_clock_obsrv_sel                                           ),
      .diffclock_nfts_count                                          (diffclock_nfts_count                                          ),
      .dis_cplovf                                                    (dis_cplovf                                                    ),
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
      .enable_directed_spd_chng                                      (enable_directed_spd_chng                                      ),
      .enable_function_msix_support                                  (enable_function_msix_support                                  ),
      .enable_l0s_aspm                                               (enable_l0s_aspm                                               ),
      .enable_l1_aspm                                                (enable_l1_aspm                                                ),
      .enable_rx_buffer_checking                                     (enable_rx_buffer_checking                                     ),
      .enable_rx_reordering                                          (enable_rx_reordering                                          ),
      .enable_slot_register                                          (enable_slot_register                                          ),
      .endpoint_l0_latency                                           (endpoint_l0_latency                                           ),
      .enable_soft_dfe                                               (enable_soft_dfe                                               ),
      .endpoint_l1_latency                                           (endpoint_l1_latency                                           ),
      .eql_rq_int_en_number                                          (eql_rq_int_en_number                                          ),
      .errmgt_fcpe_patch_dis                                         (errmgt_fcpe_patch_dis                                         ),
      .errmgt_fep_patch_dis                                          (errmgt_fep_patch_dis                                          ),
      .expansion_base_address_register                               (expansion_base_address_register                               ),
//      .extend_tag_field                                              ((extended_tag_support_hwtcl== 1)? "true" : "false"            ),
      .extend_tag_field                                              (extend_tag_field),
      .extended_format_field                                         (extended_format_field                                         ),
      .extended_tag_reset                                            (extended_tag_reset                                            ),
      .fc_init_timer                                                 (fc_init_timer                                                 ),
      .flow_control_timeout_count                                    (flow_control_timeout_count                                    ),
      .flow_control_update_count                                     (flow_control_update_count                                     ),
      .flr_capability                                                ((include_sriov_hwtcl==1) ? "false" : flr_capability           ),
      .force_dis_to_det                                              (force_dis_to_det                                              ),
      .force_gen1_dis                                                (force_gen1_dis                                                ),
      .force_tx_coeff_preset_lpbk                                    (force_tx_coeff_preset_lpbk                                    ),
      .frame_err_patch_dis                                           (frame_err_patch_dis                                           ),
      .g3_bypass_equlz                                               ((ALTPCIE_A10_HIP_AST_HWTCL_SIM_ONLY==1 && enable_g3_bypass_equlz_rp_sim_hwtcl==1) ? "true" : g3_bypass_equlz                                               ),
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
      .g3_ltssm_rec_dbg                                              (g3_ltssm_rec_dbg                                              ),
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
      .gen3_coeff_3_ber_meas                                         (gen3_phase2_eq_time                                           ),
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
      .jtag_id                                                       (jtag_id_bit_vec[127:0]                                        ),
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
      .millisecond_cycle_count                                       (millisecond_cycle_count                                       ),
      .msi_64bit_addressing_capable                                  (msi_64bit_addressing_capable                                  ),
      .msi_masking_capable                                           (msi_masking_capable                                           ),
      .msi_multi_message_capable                                     (msi_multi_message_capable                                     ),
      .msi_support                                                   (msi_support                                                   ),
      .msix_pba_bir                                                  (msix_pba_bir                                                  ),
      .msix_pba_offset                                               (msix_pba_offset[31:3]                                         ),
      .msix_table_bir                                                (msix_table_bir                                                ),
      .msix_table_offset                                             (msix_table_offset[31:3]                                       ),
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
      .retry_buffer_memory_settings                                  (retry_buffer_memory_settings_bit_vec[35:0]                    ),
      .retry_ecc_corr_mask_dis                                       (retry_ecc_corr_mask_dis                                       ),
      .revision_id                                                   (revision_id                                                   ),
      .role_based_error_reporting                                    (role_based_error_reporting                                    ),
      .rp_bug_fix_pri_sec_stat_reg                                   (rp_bug_fix_pri_sec_stat_reg                                   ),
      .rpltim_base                                                   (rpltim_base                                                   ),
      .rpltim_set                                                    (rpltim_set                                                    ),
      .rstctl_ltssm_dis                                              (rstctl_ltssm_dis                                              ),
      .rstctrl_1ms_count_fref_clk                                    (rstctrl_1ms_count_fref_clk                                    ),
      .rstctrl_1us_count_fref_clk                                    (rstctrl_1us_count_fref_clk                                    ),
      .rstctrl_pld_clr                                               (rstctrl_pld_clr                                               ),
      .rstctrl_pll_cal_done_select                                   ((ALTPCIE_A10_HIP_AST_HWTCL_SIM_ONLY==1)?"not_active_pll_cal_done":rstctrl_pll_cal_done_select),
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
      .rstctrl_chnl_cal_done_select                                  ((ALTPCIE_A10_HIP_AST_HWTCL_SIM_ONLY==1)?"not_active_chnl_cal_done":rstctrl_chnl_cal_done_select),
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
      .dis_paritychk                                                 ((interface_type_integer_hwtcl>0)?"disable":dis_paritychk      ),
      .rx_ast_parity                                                 ((interface_type_integer_hwtcl>0)?"disable":rx_ast_parity      ),
      .tx_ast_parity                                                 ((interface_type_integer_hwtcl>0)?"disable":tx_ast_parity      ),
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
      .vc0_rx_buffer_memory_settings                                 (vc0_rx_buffer_memory_settings_bit_vec[35:0]                   ),
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
      .eco_fb332688_dis                                              (eco_fb332688_dis                                              ),
      .TLP_INSPECTOR                                                 (TLP_INSPECTOR                                                 ),
      .TLP_INSPECTOR_USE_SIGNAL_PROBE                                (TLP_INSPECTOR_USE_SIGNAL_PROBE                                ),
      .TLP_INSPECTOR_POWER_UP_TRIGGER                                (TLP_INSPECTOR_POWER_UP_TRIGGER                                ),
      .inspector_enable                                              (pcie_inspector_hwtcl                                          ),
      .export_phy_input_to_top_level_hwtcl                           (export_phy_input_to_top_level_hwtcl                           ),
      .rx_polinv_soft_logic_enable                                   (rx_polinv_soft_logic_enable                                   ),
      .enable_skp_det                                                (enable_skp_det                                                )
     ) altpcie_a10_hip_pipen1b (
      .pipe_hclk_in                                                   (pipe_hclk_in                                                  ),
      .pll_pcie_clk                                                   (pll_pcie_clk                                                  ),
      .pipe32_sim_only                                                ((ALTPCIE_A10_HIP_AST_HWTCL_SIM_ONLY==0)?1'b0:simu_mode_pipe         ),//input
      .pin_perst                                                      (pin_perst                                                           ),//input
      .npor                                                           (npor                                                                ),//input
      .reset_status                                                   (reset_status                                                        ),//output
      .serdes_pll_locked                                              (serdes_pll_locked                                                   ),//output
      .pld_clk                                                        (pld_clk_source                                                      ),//input
      .pclk_in                                                        (sim_pipe_pclk_in                                                    ),//input
      .rate                                                           (sim_pipe_rate                                                       ),//output [1 : 0]
      .pld_clk_inuse                                                  (pld_clk_inuse                                                       ),//output
      .pld_core_ready                                                 (pld_core_ready_int                                                  ),//input
      .refclk                                                         (refclk                                                              ),//input
      .mode                                                           (mode                                                                ),//input  [1 : 0]
      .hpg_ctrler                                                     ((cseb_config_bypass=="enable")?
                                                                          {hip_cfgbp_linkcsr_bit0, hip_cfgbp_tx_req_pm, hip_cfgbp_tx_typ_pm}:hpg_ctrler),//input  [4 : 0]
      .avmm_rst_n                                                     ((hip_reconfig_hwtcl==0)?1'b1 :hip_reconfig_rst_n                    ),//input
      .avmm_clk                                                       ((hip_reconfig_hwtcl==0)?1'b0 :hip_reconfig_clk                      ),//input
      .avmm_write                                                     ((hip_reconfig_hwtcl==0)?1'b0 :hip_reconfig_write                    ),//input
      .avmm_read                                                      ((hip_reconfig_hwtcl==0)?1'b0 :hip_reconfig_read                     ),//input
      .avmm_byte_en                                                   ((hip_reconfig_hwtcl==0)?2'h0 :hip_reconfig_byte_en                  ),//input   [1:0]
      .avmm_address                                                   ((hip_reconfig_hwtcl==0)?10'h0:hip_reconfig_address                  ),//input   [9:0]
      .avmm_writedata                                                 ((hip_reconfig_hwtcl==0)?16'h0:hip_reconfig_writedata                ),//input   [15:0]
      .avmm_readdata                                                  (                              hip_reconfig_readdata                 ),//output  [15:0]
      .ser_shift_load                                                 ((hip_reconfig_hwtcl==0)?1'b1 :ser_shift_load                        ),
      .interface_sel                                                  ((hip_reconfig_hwtcl==0)?1'b1 :interface_sel                         ),
      .xcvr_reconfig_clk                                              (xcvr_reconfig_clk_muxed                                             ),
      .xcvr_reconfig_reset                                            (xcvr_reconfig_reset                                                 ),
      .xcvr_reconfig_write                                            (xcvr_reconfig_write                                                 ),
      .xcvr_reconfig_read                                             (xcvr_reconfig_read                                                  ),
      .xcvr_reconfig_address                                          (xcvr_reconfig_address                                               ),
      .xcvr_reconfig_writedata                                        (xcvr_reconfig_writedata                                             ),
      .xcvr_reconfig_readdata                                         (xcvr_reconfig_readdata                                              ),
      .xcvr_reconfig_waitrequest                                      (xcvr_reconfig_waitrequest                                           ),
      .reconfig_pll0_clk            (reconfig_pll0_clk_muxed                                       ),
      .reconfig_pll0_reset          (reconfig_pll0_reset                                           ),
      .reconfig_pll0_write          (reconfig_pll0_write                                           ),
      .reconfig_pll0_read           (reconfig_pll0_read                                            ),
      .reconfig_pll0_address        (reconfig_pll0_address                                         ),
      .reconfig_pll0_writedata      (reconfig_pll0_writedata                                       ),
      .reconfig_pll0_readdata       (reconfig_pll0_readdata                                        ),
      .reconfig_pll0_waitrequest    (reconfig_pll0_waitrequest                                     ),
      .reconfig_pll1_clk            (reconfig_pll1_clk_muxed                                       ),
      .reconfig_pll1_reset          (reconfig_pll1_reset                                           ),
      .reconfig_pll1_write          (reconfig_pll1_write                                           ),
      .reconfig_pll1_read           (reconfig_pll1_read                                            ),
      .reconfig_pll1_address        (reconfig_pll1_address                                         ),
      .reconfig_pll1_writedata      (reconfig_pll1_writedata                                       ),
      .reconfig_pll1_readdata       (reconfig_pll1_readdata                                        ),
      .reconfig_pll1_waitrequest    (reconfig_pll1_waitrequest                                     ),
      .swctmod                                                        (gnd_swctmod                                                          ),//input  [1 : 0]
      .test_in                                                        ({testin[63:1],(ALTPCIE_A10_HIP_AST_HWTCL_SIM_ONLY==0)?1'b0:testin[0]}),//input  [31 : 0]
      .avmm_thinmaster_write                                          (avmm_thinmaster_write                                                ),  //     | _______________________________|//
      .avmm_thinmaster_address                                        (avmm_thinmaster_address                                              ),  //     |                   | Offset 48h |//
      .avmm_thinmaster_writedata                                      (avmm_thinmaster_writedata                                            ),  //     | AVMM thin Master  |____________|//
      .avmm_thinmaster_byteenable                                     (avmm_thinmaster_byteenable                                           ),  //     | [15:0]  data                   |//
      .avmm_thinmaster_read                                           (avmm_thinmaster_read                                                 ),  //     | [23:16] Address                |//
      .avmm_thinmaster_waitrequest                                    (avmm_thinmaster_waitrequest                                          ),  //     | [24]    ReadReq                |//
      .avmm_thinmaster_readdata                                       (avmm_thinmaster_readdata                                             ),  //     | [25]    WriteReq               |//
      .avmm_thinmaster_readdatavalid                                  (avmm_thinmaster_readdatavalid                                        ),  //     | [31:26] Reserved               |//
      .phystatus0_ext                                                 (phystatus0                                                          ),//input
      .phystatus1_ext                                                 (phystatus1                                                          ),//input
      .phystatus2_ext                                                 (phystatus2                                                          ),//input
      .phystatus3_ext                                                 (phystatus3                                                          ),//input
      .phystatus4_ext                                                 (phystatus4                                                          ),//input
      .phystatus5_ext                                                 (phystatus5                                                          ),//input
      .phystatus6_ext                                                 (phystatus6                                                          ),//input
      .phystatus7_ext                                                 (phystatus7                                                          ),//input
      .rxdata0_ext                                                    (rxdata0                                                             ),//input  [7 : 0]
      .rxdata1_ext                                                    (rxdata1                                                             ),//input  [7 : 0]
      .rxdata2_ext                                                    (rxdata2                                                             ),//input  [7 : 0]
      .rxdata3_ext                                                    (rxdata3                                                             ),//input  [7 : 0]
      .rxdata4_ext                                                    (rxdata4                                                             ),//input  [7 : 0]
      .rxdata5_ext                                                    (rxdata5                                                             ),//input  [7 : 0]
      .rxdata6_ext                                                    (rxdata6                                                             ),//input  [7 : 0]
      .rxdata7_ext                                                    (rxdata7                                                             ),//input  [7 : 0]
      .rxdatak0_ext                                                   (rxdatak0                                                            ),//input
      .rxdatak1_ext                                                   (rxdatak1                                                            ),//input
      .rxdatak2_ext                                                   (rxdatak2                                                            ),//input
      .rxdatak3_ext                                                   (rxdatak3                                                            ),//input
      .rxdatak4_ext                                                   (rxdatak4                                                            ),//input
      .rxdatak5_ext                                                   (rxdatak5                                                            ),//input
      .rxdatak6_ext                                                   (rxdatak6                                                            ),//input
      .rxdatak7_ext                                                   (rxdatak7                                                            ),//input
      .rxelecidle0_ext                                                (rxelecidle0                                                         ),//input
      .rxelecidle1_ext                                                (rxelecidle1                                                         ),//input
      .rxelecidle2_ext                                                (rxelecidle2                                                         ),//input
      .rxelecidle3_ext                                                (rxelecidle3                                                         ),//input
      .rxelecidle4_ext                                                (rxelecidle4                                                         ),//input
      .rxelecidle5_ext                                                (rxelecidle5                                                         ),//input
      .rxelecidle6_ext                                                (rxelecidle6                                                         ),//input
      .rxelecidle7_ext                                                (rxelecidle7                                                         ),//input
      .rxstatus0_ext                                                  (rxstatus0                                                           ),//input  [2 : 0]
      .rxstatus1_ext                                                  (rxstatus1                                                           ),//input  [2 : 0]
      .rxstatus2_ext                                                  (rxstatus2                                                           ),//input  [2 : 0]
      .rxstatus3_ext                                                  (rxstatus3                                                           ),//input  [2 : 0]
      .rxstatus4_ext                                                  (rxstatus4                                                           ),//input  [2 : 0]
      .rxstatus5_ext                                                  (rxstatus5                                                           ),//input  [2 : 0]
      .rxstatus6_ext                                                  (rxstatus6                                                           ),//input  [2 : 0]
      .rxstatus7_ext                                                  (rxstatus7                                                           ),//input  [2 : 0]
      .rxdataskip0_ext                                                (rxdataskip0                                                         ),//input
      .rxdataskip1_ext                                                (rxdataskip1                                                         ),//input
      .rxdataskip2_ext                                                (rxdataskip2                                                         ),//input
      .rxdataskip3_ext                                                (rxdataskip3                                                         ),//input
      .rxdataskip4_ext                                                (rxdataskip4                                                         ),//input
      .rxdataskip5_ext                                                (rxdataskip5                                                         ),//input
      .rxdataskip6_ext                                                (rxdataskip6                                                         ),//input
      .rxdataskip7_ext                                                (rxdataskip7                                                         ),//input
      .rxblkst0_ext                                                   (rxblkst0                                                            ),//input
      .rxblkst1_ext                                                   (rxblkst1                                                            ),//input
      .rxblkst2_ext                                                   (rxblkst2                                                            ),//input
      .rxblkst3_ext                                                   (rxblkst3                                                            ),//input
      .rxblkst4_ext                                                   (rxblkst4                                                            ),//input
      .rxblkst5_ext                                                   (rxblkst5                                                            ),//input
      .rxblkst6_ext                                                   (rxblkst6                                                            ),//input
      .rxblkst7_ext                                                   (rxblkst7                                                            ),//input
      .rxsynchd0_ext                                                  (rxsynchd0                                                           ),//input  [1 : 0]
      .rxsynchd1_ext                                                  (rxsynchd1                                                           ),//input  [1 : 0]
      .rxsynchd2_ext                                                  (rxsynchd2                                                           ),//input  [1 : 0]
      .rxsynchd3_ext                                                  (rxsynchd3                                                           ),//input  [1 : 0]
      .rxsynchd4_ext                                                  (rxsynchd4                                                           ),//input  [1 : 0]
      .rxsynchd5_ext                                                  (rxsynchd5                                                           ),//input  [1 : 0]
      .rxsynchd6_ext                                                  (rxsynchd6                                                           ),//input  [1 : 0]
      .rxsynchd7_ext                                                  (rxsynchd7                                                           ),//input  [1 : 0]
      .rxvalid0_ext                                                   (rxvalid0                                                            ),//input
      .rxvalid1_ext                                                   (rxvalid1                                                            ),//input
      .rxvalid2_ext                                                   (rxvalid2                                                            ),//input
      .rxvalid3_ext                                                   (rxvalid3                                                            ),//input
      .rxvalid4_ext                                                   (rxvalid4                                                            ),//input
      .rxvalid5_ext                                                   (rxvalid5                                                            ),//input
      .rxvalid6_ext                                                   (rxvalid6                                                            ),//input
      .rxvalid7_ext                                                   (rxvalid7                                                            ),//input
      .aer_msi_num                                                    ((cseb_config_bypass=="enable")?
                                                                        {hip_cfgbp_inh_dllp, hip_cfgbp_req_phycfg}:(port_type=="root_port")?
                                                                                                                           aer_msi_num:5'h0    ),//input  [4 : 0]
      .app_int_sts                                                    (app_int_sts_mux                                                         ),//input
      .app_msi_num                                                    ((cseb_config_bypass=="enable")?
                                                                        {hip_cfgbp_comclk_reg, hip_cfgbp_extsy_reg, hip_cfgbp_max_pload}:app_msi_num_mux   ),//input  [4 : 0]
      .app_msi_req                                                    ((cseb_config_bypass=="enable")?hip_cfgbp_req_wake:app_msi_req_mux   ),//input
      .app_msi_tc                                                     ((cseb_config_bypass=="enable")?
                                                                                                {1'b0, hip_cfgbp_link3_ctl}:app_msi_tc_mux ),//input  [2 : 0]
      .pex_msi_num                                                    ((cseb_config_bypass=="enable")?
                                                                        {hip_cfgbp_inh_tx_tlp, hip_cfgbp_req_phypm}:
                                                                           (port_type=="root_port")?pex_msi_num:5'h0                       ),//input  [4 : 0]
      .lmi_addr                                                       (lmi_addr_mux                                                        ),//input  [11 : 0]
      .lmi_din                                                        (lmi_din_mux                                                         ),//input  [31 : 0]
      .lmi_rden                                                       (lmi_rden_mux                                                        ),//input
      .lmi_wren                                                       (lmi_wren_mux                                                        ),//input
      .pm_auxpwr                                                      ((cseb_config_bypass=="enable")?hip_cfgbp_rx_ecrchk:pm_auxpwr        ),//input
      .pm_data                                                        ((cseb_config_bypass=="enable")?
                                                                          {1'b0, hip_cfgbp_vc0_tcmap_pld, 1'b0}:pm_data                    ),//input  [9 : 0]
      .pme_to_cr                                                      (pme_to_cr                                                           ),//input
      .pm_event                                                       ((cseb_config_bypass=="enable")?hip_cfgbp_tx_ecrcgen:pm_event        ),//input
      .rx_cred_ctl                                                    (rx_cred_ctl                                                         ),
      .rx_cred_status                                                 (rx_cred_status                                                      ),
      .rx_st_mask                                                     (rx_st_mask_mux                                                      ),//input
      .rx_st_ready                                                    (rx_st_ready_mux                                                     ),//input
      .tx_st_data                                                     (tx_st_data_mux                                                      ),//input  [255 : 0]
      .tx_st_empty                                                    ((app_interface_width=="avst_64bit")?2'b00:tx_st_empty_mux           ),//input  [1 :0]        t
      .tx_st_eop                                                      (tx_st_eop_mux                                                       ),//input  [3 :0]        t
      .tx_st_err                                                      (tx_st_err_mux                                                       ),//input  [3 :0]        t
      .tx_st_parity                                                   (tx_st_parity_mux                                                    ),//input  [31:0]        t
      .tx_st_sop                                                      (tx_st_sop_mux                                                       ),//input  [3 :0]        t
      .tx_st_valid                                                    (tx_st_valid_mux                                                     ),//input                t
      .cfglink2csrpld                                                 ((cseb_config_bypass=="enable")?hip_cfgbp_link2csr:16'h0             ),//input  [15:0]
      .cpl_err                                                        ((cseb_config_bypass=="enable")?hip_cfgbp_secbus[6:0]:cpl_err        ),//input  [6 :0]        c
      .cpl_pending                                                    ((cseb_config_bypass=="enable")?hip_cfgbp_secbus[7]:cpl_pending_mux  ),//input                c
      .tl_slotclk_cfg                                                 ((slot_clock_cfg_hwtcl==1)?1'b1:1'b0                                 ),//input                t
      .bistenrcv                                                      (gnd_bistenrcv                                                       ),//input
      .bistenrpl                                                      (gnd_bistenrpl                                                       ),//input
      .bistscanen                                                     (gnd_bistscanen                                                      ),//input
      .bistscanin                                                     (gnd_bistscanin                                                      ),//input
      .bisttesten                                                     (gnd_bisttesten                                                      ),//input
      .memhiptestenable                                               (gnd_memhiptestenable                                                ),//input
      .memregscanen                                                   (gnd_memregscanen                                                    ),//input
      .scanmoden                                                      (gnd_scanmoden                                                       ),//input
      .scanshiftn                                                     (gnd_scanshiftn                                                      ),//input
      .m10k_select                                                    (gnd_m10k_select                                                     ),//input
      .csebrddata                                                     ((cseb_on==1)?cseb_rddata:
                                                                       (cfbp_cseb_autonomous_en & test_cseb_switch_hwtcl) ? 32'hbabeface :
                                                                        gnd_csebrddata                                                     ),
      .csebrddataparity                                               ((cseb_on==1)?cseb_rddata_parity:gnd_csebrddataparity                ),//input  [3 : 0]
      .csebrdresponse                                                 ((cseb_on==1)?cseb_rdresponse:
                                                                                    (cfbp_cseb_autonomous_en & !test_cseb_switch_hwtcl) ? AVMM_TEMP_BUSY :
                                                                                     gnd_csebrdresponse ),// Response with CRS status in Autonomous mode
      .csebwaitrequest                                                ((cseb_on==1)?cseb_waitrequest:gnd_csebwaitrequest                   ),//input
      .csebwrresponse                                                 ((cseb_on==1)?cseb_wrresponse:gnd_csebwrresponse                     ),//input  [2 : 0]
      .csebwrrespvalid                                                ((cseb_on==1)?cseb_wrresp_valid:gnd_csebwrrespvalid                  ),//input
      .dbgpipex1rx                                                    (gnd_dbgpipex1rx                                                     ),//input  [43 : 0]
      .eidle_infer_sel0_ext                                           (eidleinfersel0_w                                                    ),//output [2 : 0]        eidleinfersel0,
      .eidle_infer_sel1_ext                                           (eidleinfersel1_w                                                    ),//output [2 : 0]        eidleinfersel1,
      .eidle_infer_sel2_ext                                           (eidleinfersel2_w                                                    ),//output [2 : 0]        eidleinfersel2,
      .eidle_infer_sel3_ext                                           (eidleinfersel3_w                                                    ),//output [2 : 0]        eidleinfersel3,
      .eidle_infer_sel4_ext                                           (eidleinfersel4_w                                                    ),//output [2 : 0]        eidleinfersel4,
      .eidle_infer_sel5_ext                                           (eidleinfersel5_w                                                    ),//output [2 : 0]        eidleinfersel5,
      .eidle_infer_sel6_ext                                           (eidleinfersel6_w                                                    ),//output [2 : 0]        eidleinfersel6,
      .eidle_infer_sel7_ext                                           (eidleinfersel7_w                                                    ),//output [2 : 0]        eidleinfersel7,
      .powerdown0_ext                                                 (powerdown0_w                                                        ),//output [1 : 0]        powerdown0,
      .powerdown1_ext                                                 (powerdown1_w                                                        ),//output [1 : 0]        powerdown1,
      .powerdown2_ext                                                 (powerdown2_w                                                        ),//output [1 : 0]        powerdown2,
      .powerdown3_ext                                                 (powerdown3_w                                                        ),//output [1 : 0]        powerdown3,
      .powerdown4_ext                                                 (powerdown4_w                                                        ),//output [1 : 0]        powerdown4,
      .powerdown5_ext                                                 (powerdown5_w                                                        ),//output [1 : 0]        powerdown5,
      .powerdown6_ext                                                 (powerdown6_w                                                        ),//output [1 : 0]        powerdown6,
      .powerdown7_ext                                                 (powerdown7_w                                                        ),//output [1 : 0]        powerdown7,
      .rxpolarity0_ext                                                (rxpolarity0_w                                                       ),//output                rxpolarity0,
      .rxpolarity1_ext                                                (rxpolarity1_w                                                       ),//output                rxpolarity1,
      .rxpolarity2_ext                                                (rxpolarity2_w                                                       ),//output                rxpolarity2,
      .rxpolarity3_ext                                                (rxpolarity3_w                                                       ),//output                rxpolarity3,
      .rxpolarity4_ext                                                (rxpolarity4_w                                                       ),//output                rxpolarity4,
      .rxpolarity5_ext                                                (rxpolarity5_w                                                       ),//output                rxpolarity5,
      .rxpolarity6_ext                                                (rxpolarity6_w                                                       ),//output                rxpolarity6,
      .rxpolarity7_ext                                                (rxpolarity7_w                                                       ),//output                rxpolarity7,
      .txcompl0_ext                                                   (txcompl0_w                                                          ),//output                txcompl0,
      .txcompl1_ext                                                   (txcompl1_w                                                          ),//output                txcompl1,
      .txcompl2_ext                                                   (txcompl2_w                                                          ),//output                txcompl2,
      .txcompl3_ext                                                   (txcompl3_w                                                          ),//output                txcompl3,
      .txcompl4_ext                                                   (txcompl4_w                                                          ),//output                txcompl4,
      .txcompl5_ext                                                   (txcompl5_w                                                          ),//output                txcompl5,
      .txcompl6_ext                                                   (txcompl6_w                                                          ),//output                txcompl6,
      .txcompl7_ext                                                   (txcompl7_w                                                          ),//output                txcompl7,
      .txdata0_ext                                                    (txdata0_w                                                           ),//output [7 : 0]        txdata0,
      .txdata1_ext                                                    (txdata1_w                                                           ),//output [7 : 0]        txdata1,
      .txdata2_ext                                                    (txdata2_w                                                           ),//output [7 : 0]        txdata2,
      .txdata3_ext                                                    (txdata3_w                                                           ),//output [7 : 0]        txdata3,
      .txdata4_ext                                                    (txdata4_w                                                           ),//output [7 : 0]        txdata4,
      .txdata5_ext                                                    (txdata5_w                                                           ),//output [7 : 0]        txdata5,
      .txdata6_ext                                                    (txdata6_w                                                           ),//output [7 : 0]        txdata6,
      .txdata7_ext                                                    (txdata7_w                                                           ),//output [7 : 0]        txdata7,
      .txdatak0_ext                                                   (txdatak0_w                                                          ),//output                txdatak0,
      .txdatak1_ext                                                   (txdatak1_w                                                          ),//output                txdatak1,
      .txdatak2_ext                                                   (txdatak2_w                                                          ),//output                txdatak2,
      .txdatak3_ext                                                   (txdatak3_w                                                          ),//output                txdatak3,
      .txdatak4_ext                                                   (txdatak4_w                                                          ),//output                txdatak4,
      .txdatak5_ext                                                   (txdatak5_w                                                          ),//output                txdatak5,
      .txdatak6_ext                                                   (txdatak6_w                                                          ),//output                txdatak6,
      .txdatak7_ext                                                   (txdatak7_w                                                          ),//output                txdatak7,
      .txdetectrx0_ext                                                (txdetectrx0_w                                                       ),//output                txdetectrx0,
      .txdetectrx1_ext                                                (txdetectrx1_w                                                       ),//output                txdetectrx1,
      .txdetectrx2_ext                                                (txdetectrx2_w                                                       ),//output                txdetectrx2,
      .txdetectrx3_ext                                                (txdetectrx3_w                                                       ),//output                txdetectrx3,
      .txdetectrx4_ext                                                (txdetectrx4_w                                                       ),//output                txdetectrx4,
      .txdetectrx5_ext                                                (txdetectrx5_w                                                       ),//output                txdetectrx5,
      .txdetectrx6_ext                                                (txdetectrx6_w                                                       ),//output                txdetectrx6,
      .txdetectrx7_ext                                                (txdetectrx7_w                                                       ),//output                txdetectrx7,
      .txelecidle0_ext                                                (txelecidle0_w                                                       ),//output                txelecidle0,
      .txelecidle1_ext                                                (txelecidle1_w                                                       ),//output                txelecidle1,
      .txelecidle2_ext                                                (txelecidle2_w                                                       ),//output                txelecidle2,
      .txelecidle3_ext                                                (txelecidle3_w                                                       ),//output                txelecidle3,
      .txelecidle4_ext                                                (txelecidle4_w                                                       ),//output                txelecidle4,
      .txelecidle5_ext                                                (txelecidle5_w                                                       ),//output                txelecidle5,
      .txelecidle6_ext                                                (txelecidle6_w                                                       ),//output                txelecidle6,
      .txelecidle7_ext                                                (txelecidle7_w                                                       ),//output                txelecidle7,
      .tx_margin0_ext                                                 (txmargin0_w                                                         ),//output [2 : 0]        txmargin0,
      .tx_margin1_ext                                                 (txmargin1_w                                                         ),//output [2 : 0]        txmargin1,
      .tx_margin2_ext                                                 (txmargin2_w                                                         ),//output [2 : 0]        txmargin2,
      .tx_margin3_ext                                                 (txmargin3_w                                                         ),//output [2 : 0]        txmargin3,
      .tx_margin4_ext                                                 (txmargin4_w                                                         ),//output [2 : 0]        txmargin4,
      .tx_margin5_ext                                                 (txmargin5_w                                                         ),//output [2 : 0]        txmargin5,
      .tx_margin6_ext                                                 (txmargin6_w                                                         ),//output [2 : 0]        txmargin6,
      .tx_margin7_ext                                                 (txmargin7_w                                                         ),//output [2 : 0]        txmargin7,
      .tx_deemph0_ext                                                 (txdeemph0_w                                                         ),//output                txdeemph0,
      .tx_deemph1_ext                                                 (txdeemph1_w                                                         ),//output                txdeemph1,
      .tx_deemph2_ext                                                 (txdeemph2_w                                                         ),//output                txdeemph2,
      .tx_deemph3_ext                                                 (txdeemph3_w                                                         ),//output                txdeemph3,
      .tx_deemph4_ext                                                 (txdeemph4_w                                                         ),//output                txdeemph4,
      .tx_deemph5_ext                                                 (txdeemph5_w                                                         ),//output                txdeemph5,
      .tx_deemph6_ext                                                 (txdeemph6_w                                                         ),//output                txdeemph6,
      .tx_deemph7_ext                                                 (txdeemph7_w                                                         ),//output                txdeemph7,
      .txswing0_ext                                                   (txswing0_w                                                          ),//output                txswing0,
      .txswing1_ext                                                   (txswing1_w                                                          ),//output                txswing1,
      .txswing2_ext                                                   (txswing2_w                                                          ),//output                txswing2,
      .txswing3_ext                                                   (txswing3_w                                                          ),//output                txswing3,
      .txswing4_ext                                                   (txswing4_w                                                          ),//output                txswing4,
      .txswing5_ext                                                   (txswing5_w                                                          ),//output                txswing5,
      .txswing6_ext                                                   (txswing6_w                                                          ),//output                txswing6,
      .txswing7_ext                                                   (txswing7_w                                                          ),//output                txswing7,
      .rate0_ext                                                      (rate0_w                                                             ),//output                rate0,
      .rate1_ext                                                      (rate1_w                                                             ),//output                rate1,
      .rate2_ext                                                      (rate2_w                                                             ),//output                rate2,
      .rate3_ext                                                      (rate3_w                                                             ),//output                rate3,
      .rate4_ext                                                      (rate4_w                                                             ),//output                rate4,
      .rate5_ext                                                      (rate5_w                                                             ),//output                rate5,
      .rate6_ext                                                      (rate6_w                                                             ),//output                rate6,
      .rate7_ext                                                      (rate7_w                                                             ),//output                rate7,
      .txdataskip0_ext                                                (txdataskip0_w                                                       ),//output                txdataskip0,
      .txdataskip1_ext                                                (txdataskip1_w                                                       ),//output                txdataskip1,
      .txdataskip2_ext                                                (txdataskip2_w                                                       ),//output                txdataskip2,
      .txdataskip3_ext                                                (txdataskip3_w                                                       ),//output                txdataskip3,
      .txdataskip4_ext                                                (txdataskip4_w                                                       ),//output                txdataskip4,
      .txdataskip5_ext                                                (txdataskip5_w                                                       ),//output                txdataskip5,
      .txdataskip6_ext                                                (txdataskip6_w                                                       ),//output                txdataskip6,
      .txdataskip7_ext                                                (txdataskip7_w                                                       ),//output                txdataskip7,
      .txblkst0_ext                                                   (txblkst0_w                                                          ),//output                txblkst0,
      .txblkst1_ext                                                   (txblkst1_w                                                          ),//output                txblkst1,
      .txblkst2_ext                                                   (txblkst2_w                                                          ),//output                txblkst2,
      .txblkst3_ext                                                   (txblkst3_w                                                          ),//output                txblkst3,
      .txblkst4_ext                                                   (txblkst4_w                                                          ),//output                txblkst4,
      .txblkst5_ext                                                   (txblkst5_w                                                          ),//output                txblkst5,
      .txblkst6_ext                                                   (txblkst6_w                                                          ),//output                txblkst6,
      .txblkst7_ext                                                   (txblkst7_w                                                          ),//output                txblkst7,
      .txsynchd0_ext                                                  (txsynchd0_w                                                         ),//output [1 : 0]        txsynchd0,
      .txsynchd1_ext                                                  (txsynchd1_w                                                         ),//output [1 : 0]        txsynchd1,
      .txsynchd2_ext                                                  (txsynchd2_w                                                         ),//output [1 : 0]        txsynchd2,
      .txsynchd3_ext                                                  (txsynchd3_w                                                         ),//output [1 : 0]        txsynchd3,
      .txsynchd4_ext                                                  (txsynchd4_w                                                         ),//output [1 : 0]        txsynchd4,
      .txsynchd5_ext                                                  (txsynchd5_w                                                         ),//output [1 : 0]        txsynchd5,
      .txsynchd6_ext                                                  (txsynchd6_w                                                         ),//output [1 : 0]        txsynchd6,
      .txsynchd7_ext                                                  (txsynchd7_w                                                         ),//output [1 : 0]        txsynchd7,
      .current_coeff0_ext                                             (currentcoeff0_w                                                     ),//output [17 : 0]       currentcoeff0,
      .current_coeff1_ext                                             (currentcoeff1_w                                                     ),//output [17 : 0]       currentcoeff1,
      .current_coeff2_ext                                             (currentcoeff2_w                                                     ),//output [17 : 0]       currentcoeff2,
      .current_coeff3_ext                                             (currentcoeff3_w                                                     ),//output [17 : 0]       currentcoeff3,
      .current_coeff4_ext                                             (currentcoeff4_w                                                     ),//output [17 : 0]       currentcoeff4,
      .current_coeff5_ext                                             (currentcoeff5_w                                                     ),//output [17 : 0]       currentcoeff5,
      .current_coeff6_ext                                             (currentcoeff6_w                                                     ),//output [17 : 0]       currentcoeff6,
      .current_coeff7_ext                                             (currentcoeff7_w                                                     ),//output [17 : 0]       currentcoeff7,
      .current_rxpreset0_ext                                          (currentrxpreset0_w                                                  ),//output [2 : 0]        currentrxpreset0,
      .current_rxpreset1_ext                                          (currentrxpreset1_w                                                  ),//output [2 : 0]        currentrxpreset1,
      .current_rxpreset2_ext                                          (currentrxpreset2_w                                                  ),//output [2 : 0]        currentrxpreset2,
      .current_rxpreset3_ext                                          (currentrxpreset3_w                                                  ),//output [2 : 0]        currentrxpreset3,
      .current_rxpreset4_ext                                          (currentrxpreset4_w                                                  ),//output [2 : 0]        currentrxpreset4,
      .current_rxpreset5_ext                                          (currentrxpreset5_w                                                  ),//output [2 : 0]        currentrxpreset5,
      .current_rxpreset6_ext                                          (currentrxpreset6_w                                                  ),//output [2 : 0]        currentrxpreset6,
      .current_rxpreset7_ext                                          (currentrxpreset7_w                                                  ),//output [2 : 0]        currentrxpreset7,
      .coreclkout                                                     (coreclkout                                                          ),//output
      .currentspeed                                                   (currentspeed                                                        ),//output [1 : 0]
      .derr_cor_ext_rcv                                               (derr_cor_ext_rcv                                                    ),//output
      .derr_cor_ext_rpl                                               (derr_cor_ext_rpl                                                    ),//output
      .derr_rpl                                                       (derr_rpl                                                            ),//output
      .rx_par_err                                                     (rx_par_err                                                          ),
      .tx_par_err                                                     (tx_par_err                                                          ),
      .rxfc_cplbuf_ovf                                                (rxfc_cplbuf_ovf                                                     ),
      .cfg_par_err                                                    (cfg_par_err                                                         ),
      .dlup                                                           (dlup                                                                ),//output
      .dlup_exit                                                      (dlup_exit                                                           ),//output
      .ev128ns                                                        (ev128ns                                                             ),//output
      .ev1us                                                          (ev1us                                                               ),//output
      .hotrst_exit                                                    (hotrst_exit                                                         ),//output
      .int_status                                                     (int_status                                                          ),//output [3 : 0]
      .l2_exit                                                        (l2_exit                                                             ),//output
      .lane_act                                                       (lane_act                                                            ),//output [3 : 0]
      .ltssmstate                                                     (ltssmstate                                                          ),//output [4 : 0]
      .test_out                                                       (testout                                                             ),//output [255 : 0]
      .app_int_ack                                                    (hip_app_int_ack                                                     ),//output
      .app_msi_ack                                                    (hip_app_msi_ack                                                     ),//output
      .lmi_ack                                                        (lmi_ack_hip                                                         ),//output
      .lmi_dout                                                       (lmi_dout_hip                                                        ),//output [31 : 0]
      .pme_to_sr                                                      (pme_to_sr                                                           ),//output
      .rx_st_bardec1                                                  (rx_st_bardec1                                                       ),//output [7 : 0]
      .rx_st_bardec2                                                  (rx_st_bardec2                                                       ),//output [7 : 0]
      .rx_st_be                                                       (rx_st_be_int                                                        ),//output [31 : 0]
      .rx_st_data                                                     (rx_st_data_int                                                      ),//output [255 : 0]
      .rx_st_empty                                                    (rx_st_empty_int                                                     ),//output [1 : 0]
      .rx_st_eop                                                      (rx_st_eop_int                                                       ),//output [3 : 0]
      .rx_st_err                                                      (rx_st_err_int                                                       ),//output [3 : 0]
      .rx_st_parity                                                   (rx_st_parity_int                                                    ),//output [31 : 0]
      .rx_st_sop                                                      (rx_st_sop_int                                                       ),//output [3 : 0]
      .rx_st_valid                                                    (rx_st_valid_int                                                     ),//output [3 : 0]
      .serr_out                                                       (serr_out                                                            ),//output
      .tl_cfg_add                                                     (tl_cfg_add                                                          ),//output [3 : 0]
      .tl_cfg_ctl                                                     (tl_cfg_ctl                                                          ),//output [31 : 0]
      .tl_cfg_sts                                                     (tl_cfg_sts                                                          ),//output [52 : 0]
      .tx_cred_data_fc                                                (tx_cred_data_fc                                                     ),//output [11 : 0]
      .tx_cred_fc_hip_cons                                            (tx_cred_fc_hip_cons_int                                             ),//output [5 : 0]
      .tx_cred_fc_infinite                                            (tx_cred_fc_infinite                                                 ),//output [5 : 0]
      .tx_cred_hdr_fc                                                 (tx_cred_hdr_fc                                                      ),//output [7 : 0]
      .tx_cred_fc_sel                                                 (tx_cred_fcsel_mux                                                   ),
      .tx_cred_cons_select                                            (tx_cons_cred_sel_mux                                                ),
      .tx_st_ready                                                    (tx_st_ready_hip                                                     ),//output
      .rx_in0                                                         (rx_in0                                                              ),//input
      .rx_in1                                                         (rx_in1                                                              ),//input
      .rx_in2                                                         (rx_in2                                                              ),//input
      .rx_in3                                                         (rx_in3                                                              ),//input
      .rx_in4                                                         (rx_in4                                                              ),//input
      .rx_in5                                                         (rx_in5                                                              ),//input
      .rx_in6                                                         (rx_in6                                                              ),//input
      .rx_in7                                                         (rx_in7                                                              ),//input
      .tx_out0                                                        (tx_out0                                                             ),//output
      .tx_out1                                                        (tx_out1                                                             ),//output
      .tx_out2                                                        (tx_out2                                                             ),//output
      .tx_out3                                                        (tx_out3                                                             ),//output
      .tx_out4                                                        (tx_out4                                                             ),//output
      .tx_out5                                                        (tx_out5                                                             ),//output
      .tx_out6                                                        (tx_out6                                                             ),//output
      .tx_out7                                                        (tx_out7                                                             ),//output
      .csebaddr                                                       (cseb_addr                                                           ),//output [32 : 0]
      .csebaddrparity                                                 (cseb_addr_parity                                                    ),//output [4 : 0]
      .csebbe                                                         (cseb_be                                                             ),//output [3 : 0]
      .csebisshadow                                                   (cseb_is_shadow                                                      ),//output
      .csebrden                                                       (cseb_rden                                                           ),//output
      .csebwrdata                                                     (cseb_wrdata                                                         ),//output [31 : 0]
      .csebwrdataparity                                               (cseb_wrdata_parity                                                  ),//output [3 : 0]
      .csebwren                                                       (cseb_wren                                                           ),//output
      .csebwrrespreq                                                  (cseb_wrresp_req                                                     ),//output
      .wakeoen                                                        (open_wakeoen                                                        ),//output
      .skp_os                                                         (skp_os                                                              )
      );

assign synth_mode =  (ALTPCIE_A10_HIP_AST_HWTCL_SIM_ONLY == 0)? 1'b1 : 1'b0;

altpcie_grounder #(.WIDTH(3)) eidleinfersel0_gnd          (.grounded(synth_mode) ,    .in_sig(eidleinfersel0_w)       ,  .out_sig     (eidleinfersel0)  );
altpcie_grounder #(.WIDTH(3)) eidleinfersel1_gnd          (.grounded(synth_mode) ,    .in_sig(eidleinfersel1_w)       ,  .out_sig     (eidleinfersel1)  );
altpcie_grounder #(.WIDTH(3)) eidleinfersel2_gnd          (.grounded(synth_mode) ,    .in_sig(eidleinfersel2_w)       ,  .out_sig     (eidleinfersel2)  );
altpcie_grounder #(.WIDTH(3)) eidleinfersel3_gnd          (.grounded(synth_mode) ,    .in_sig(eidleinfersel3_w)       ,  .out_sig     (eidleinfersel3)  );
altpcie_grounder #(.WIDTH(3)) eidleinfersel4_gnd          (.grounded(synth_mode) ,    .in_sig(eidleinfersel4_w)       ,  .out_sig     (eidleinfersel4)  );
altpcie_grounder #(.WIDTH(3)) eidleinfersel5_gnd          (.grounded(synth_mode) ,    .in_sig(eidleinfersel5_w)       ,  .out_sig     (eidleinfersel5)  );
altpcie_grounder #(.WIDTH(3)) eidleinfersel6_gnd          (.grounded(synth_mode) ,    .in_sig(eidleinfersel6_w)       ,  .out_sig     (eidleinfersel6)  );
altpcie_grounder #(.WIDTH(3)) eidleinfersel7_gnd          (.grounded(synth_mode) ,    .in_sig(eidleinfersel7_w)       ,  .out_sig     (eidleinfersel7)  );

altpcie_grounder #(.WIDTH(2)) powerdown0_gnd          (.grounded(synth_mode) ,    .in_sig(powerdown0_w)       ,  .out_sig     (powerdown0)  );
altpcie_grounder #(.WIDTH(2)) powerdown1_gnd          (.grounded(synth_mode) ,    .in_sig(powerdown1_w)       ,  .out_sig     (powerdown1)  );
altpcie_grounder #(.WIDTH(2)) powerdown2_gnd          (.grounded(synth_mode) ,    .in_sig(powerdown2_w)       ,  .out_sig     (powerdown2)  );
altpcie_grounder #(.WIDTH(2)) powerdown3_gnd          (.grounded(synth_mode) ,    .in_sig(powerdown3_w)       ,  .out_sig     (powerdown3)  );
altpcie_grounder #(.WIDTH(2)) powerdown4_gnd          (.grounded(synth_mode) ,    .in_sig(powerdown4_w)       ,  .out_sig     (powerdown4)  );
altpcie_grounder #(.WIDTH(2)) powerdown5_gnd          (.grounded(synth_mode) ,    .in_sig(powerdown5_w)       ,  .out_sig     (powerdown5)  );
altpcie_grounder #(.WIDTH(2)) powerdown6_gnd          (.grounded(synth_mode) ,    .in_sig(powerdown6_w)       ,  .out_sig     (powerdown6)  );
altpcie_grounder #(.WIDTH(2)) powerdown7_gnd          (.grounded(synth_mode) ,    .in_sig(powerdown7_w)       ,  .out_sig     (powerdown7)  );

altpcie_grounder #(.WIDTH(1))  rxpolarity0_gnd           (.grounded(synth_mode),.in_sig(rxpolarity0_w      ), .out_sig(rxpolarity0 ));
altpcie_grounder #(.WIDTH(1))  rxpolarity1_gnd           (.grounded(synth_mode),.in_sig(rxpolarity1_w      ), .out_sig(rxpolarity1 ));
altpcie_grounder #(.WIDTH(1))  rxpolarity2_gnd           (.grounded(synth_mode),.in_sig(rxpolarity2_w      ), .out_sig(rxpolarity2 ));
altpcie_grounder #(.WIDTH(1))  rxpolarity3_gnd           (.grounded(synth_mode),.in_sig(rxpolarity3_w      ), .out_sig(rxpolarity3 ));
altpcie_grounder #(.WIDTH(1))  rxpolarity4_gnd           (.grounded(synth_mode),.in_sig(rxpolarity4_w      ), .out_sig(rxpolarity4 ));
altpcie_grounder #(.WIDTH(1))  rxpolarity5_gnd           (.grounded(synth_mode),.in_sig(rxpolarity5_w      ), .out_sig(rxpolarity5 ));
altpcie_grounder #(.WIDTH(1))  rxpolarity6_gnd           (.grounded(synth_mode),.in_sig(rxpolarity6_w      ), .out_sig(rxpolarity6 ));
altpcie_grounder #(.WIDTH(1))  rxpolarity7_gnd           (.grounded(synth_mode),.in_sig(rxpolarity7_w      ), .out_sig(rxpolarity7 ));


altpcie_grounder #(.WIDTH(1))  txcompl00_gnd           (.grounded(synth_mode),.in_sig(txcompl0_w      ), .out_sig(txcompl0  ));
altpcie_grounder #(.WIDTH(1))  txcompl10_gnd           (.grounded(synth_mode),.in_sig(txcompl1_w      ), .out_sig(txcompl1  ));
altpcie_grounder #(.WIDTH(1))  txcompl20_gnd           (.grounded(synth_mode),.in_sig(txcompl2_w      ), .out_sig(txcompl2  ));
altpcie_grounder #(.WIDTH(1))  txcompl30_gnd           (.grounded(synth_mode),.in_sig(txcompl3_w      ), .out_sig(txcompl3  ));
altpcie_grounder #(.WIDTH(1))  txcompl40_gnd           (.grounded(synth_mode),.in_sig(txcompl4_w      ), .out_sig(txcompl4  ));
altpcie_grounder #(.WIDTH(1))  txcompl50_gnd           (.grounded(synth_mode),.in_sig(txcompl5_w      ), .out_sig(txcompl5  ));
altpcie_grounder #(.WIDTH(1))  txcompl60_gnd           (.grounded(synth_mode),.in_sig(txcompl6_w      ), .out_sig(txcompl6  ));
altpcie_grounder #(.WIDTH(1))  txcompl70_gnd           (.grounded(synth_mode),.in_sig(txcompl7_w      ), .out_sig(txcompl7  ));


altpcie_grounder #(.WIDTH(32))  txdata0_gnd         (.grounded(synth_mode),.in_sig(txdata0_w), .out_sig(txdata0));
altpcie_grounder #(.WIDTH(32))  txdata1_gnd         (.grounded(synth_mode),.in_sig(txdata1_w), .out_sig(txdata1));
altpcie_grounder #(.WIDTH(32))  txdata2_gnd         (.grounded(synth_mode),.in_sig(txdata2_w), .out_sig(txdata2));
altpcie_grounder #(.WIDTH(32))  txdata3_gnd         (.grounded(synth_mode),.in_sig(txdata3_w), .out_sig(txdata3));
altpcie_grounder #(.WIDTH(32))  txdata4_gnd         (.grounded(synth_mode),.in_sig(txdata4_w), .out_sig(txdata4));
altpcie_grounder #(.WIDTH(32))  txdata5_gnd         (.grounded(synth_mode),.in_sig(txdata5_w), .out_sig(txdata5));
altpcie_grounder #(.WIDTH(32))  txdata6_gnd         (.grounded(synth_mode),.in_sig(txdata6_w), .out_sig(txdata6));
altpcie_grounder #(.WIDTH(32))  txdata7_gnd         (.grounded(synth_mode),.in_sig(txdata7_w), .out_sig(txdata7));


altpcie_grounder #(.WIDTH(4))  txdatak0_gnd         (.grounded(synth_mode),.in_sig(txdatak0_w), .out_sig(txdatak0));
altpcie_grounder #(.WIDTH(4))  txdatak1_gnd         (.grounded(synth_mode),.in_sig(txdatak1_w), .out_sig(txdatak1));
altpcie_grounder #(.WIDTH(4))  txdatak2_gnd         (.grounded(synth_mode),.in_sig(txdatak2_w), .out_sig(txdatak2));
altpcie_grounder #(.WIDTH(4))  txdatak3_gnd         (.grounded(synth_mode),.in_sig(txdatak3_w), .out_sig(txdatak3));
altpcie_grounder #(.WIDTH(4))  txdatak4_gnd         (.grounded(synth_mode),.in_sig(txdatak4_w), .out_sig(txdatak4));
altpcie_grounder #(.WIDTH(4))  txdatak5_gnd         (.grounded(synth_mode),.in_sig(txdatak5_w), .out_sig(txdatak5));
altpcie_grounder #(.WIDTH(4))  txdatak6_gnd         (.grounded(synth_mode),.in_sig(txdatak6_w), .out_sig(txdatak6));
altpcie_grounder #(.WIDTH(4))  txdatak7_gnd         (.grounded(synth_mode),.in_sig(txdatak7_w), .out_sig(txdatak7));


altpcie_grounder #(.WIDTH(1))  txdetectrx0_gnd           (.grounded(synth_mode),.in_sig(txdetectrx0_w      ), .out_sig(txdetectrx0    ));
altpcie_grounder #(.WIDTH(1))  txdetectrx1_gnd           (.grounded(synth_mode),.in_sig(txdetectrx1_w      ), .out_sig(txdetectrx1    ));
altpcie_grounder #(.WIDTH(1))  txdetectrx2_gnd           (.grounded(synth_mode),.in_sig(txdetectrx2_w      ), .out_sig(txdetectrx2    ));
altpcie_grounder #(.WIDTH(1))  txdetectrx3_gnd           (.grounded(synth_mode),.in_sig(txdetectrx3_w      ), .out_sig(txdetectrx3    ));
altpcie_grounder #(.WIDTH(1))  txdetectrx4_gnd           (.grounded(synth_mode),.in_sig(txdetectrx4_w      ), .out_sig(txdetectrx4    ));
altpcie_grounder #(.WIDTH(1))  txdetectrx5_gnd           (.grounded(synth_mode),.in_sig(txdetectrx5_w      ), .out_sig(txdetectrx5    ));
altpcie_grounder #(.WIDTH(1))  txdetectrx6_gnd           (.grounded(synth_mode),.in_sig(txdetectrx6_w      ), .out_sig(txdetectrx6    ));
altpcie_grounder #(.WIDTH(1))  txdetectrx7_gnd           (.grounded(synth_mode),.in_sig(txdetectrx7_w      ), .out_sig(txdetectrx7    ));
altpcie_grounder #(.WIDTH(1))  txelecidle0_gnd           (.grounded(synth_mode),.in_sig(txelecidle0_w      ), .out_sig(txelecidle0    ));
altpcie_grounder #(.WIDTH(1))  txelecidle1_gnd           (.grounded(synth_mode),.in_sig(txelecidle1_w      ), .out_sig(txelecidle1    ));
altpcie_grounder #(.WIDTH(1))  txelecidle2_gnd           (.grounded(synth_mode),.in_sig(txelecidle2_w      ), .out_sig(txelecidle2    ));
altpcie_grounder #(.WIDTH(1))  txelecidle3_gnd           (.grounded(synth_mode),.in_sig(txelecidle3_w      ), .out_sig(txelecidle3    ));
altpcie_grounder #(.WIDTH(1))  txelecidle4_gnd           (.grounded(synth_mode),.in_sig(txelecidle4_w      ), .out_sig(txelecidle4    ));
altpcie_grounder #(.WIDTH(1))  txelecidle5_gnd           (.grounded(synth_mode),.in_sig(txelecidle5_w      ), .out_sig(txelecidle5    ));
altpcie_grounder #(.WIDTH(1))  txelecidle6_gnd           (.grounded(synth_mode),.in_sig(txelecidle6_w      ), .out_sig(txelecidle6    ));
altpcie_grounder #(.WIDTH(1))  txelecidle7_gnd           (.grounded(synth_mode),.in_sig(txelecidle7_w      ), .out_sig(txelecidle7    ));
altpcie_grounder #(.WIDTH(1))  txdataskip0_gnd           (.grounded(synth_mode),.in_sig(txdataskip0_w      ), .out_sig(txdataskip0    ));
altpcie_grounder #(.WIDTH(1))  txdataskip1_gnd           (.grounded(synth_mode),.in_sig(txdataskip1_w      ), .out_sig(txdataskip1    ));
altpcie_grounder #(.WIDTH(1))  txdataskip2_gnd           (.grounded(synth_mode),.in_sig(txdataskip2_w      ), .out_sig(txdataskip2    ));
altpcie_grounder #(.WIDTH(1))  txdataskip3_gnd           (.grounded(synth_mode),.in_sig(txdataskip3_w      ), .out_sig(txdataskip3    ));
altpcie_grounder #(.WIDTH(1))  txdataskip4_gnd           (.grounded(synth_mode),.in_sig(txdataskip4_w      ), .out_sig(txdataskip4    ));
altpcie_grounder #(.WIDTH(1))  txdataskip5_gnd           (.grounded(synth_mode),.in_sig(txdataskip5_w      ), .out_sig(txdataskip5    ));
altpcie_grounder #(.WIDTH(1))  txdataskip6_gnd           (.grounded(synth_mode),.in_sig(txdataskip6_w      ), .out_sig(txdataskip6    ));
altpcie_grounder #(.WIDTH(1))  txdataskip7_gnd           (.grounded(synth_mode),.in_sig(txdataskip7_w      ), .out_sig(txdataskip7    ));
altpcie_grounder #(.WIDTH(1))  txblkst0_gnd              (.grounded(synth_mode),.in_sig(txblkst0_w         ), .out_sig(txblkst0       ));
altpcie_grounder #(.WIDTH(1))  txblkst1_gnd              (.grounded(synth_mode),.in_sig(txblkst1_w         ), .out_sig(txblkst1       ));
altpcie_grounder #(.WIDTH(1))  txblkst2_gnd              (.grounded(synth_mode),.in_sig(txblkst2_w         ), .out_sig(txblkst2       ));
altpcie_grounder #(.WIDTH(1))  txblkst3_gnd              (.grounded(synth_mode),.in_sig(txblkst3_w         ), .out_sig(txblkst3       ));
altpcie_grounder #(.WIDTH(1))  txblkst4_gnd              (.grounded(synth_mode),.in_sig(txblkst4_w         ), .out_sig(txblkst4       ));
altpcie_grounder #(.WIDTH(1))  txblkst5_gnd              (.grounded(synth_mode),.in_sig(txblkst5_w         ), .out_sig(txblkst5       ));
altpcie_grounder #(.WIDTH(1))  txblkst6_gnd              (.grounded(synth_mode),.in_sig(txblkst6_w         ), .out_sig(txblkst6       ));
altpcie_grounder #(.WIDTH(1))  txblkst7_gnd              (.grounded(synth_mode),.in_sig(txblkst7_w         ), .out_sig(txblkst7       ));
altpcie_grounder #(.WIDTH(1))  txdeemph0_gnd             (.grounded(synth_mode),.in_sig(txdeemph0_w        ), .out_sig(txdeemph0      ));
altpcie_grounder #(.WIDTH(1))  txdeemph1_gnd             (.grounded(synth_mode),.in_sig(txdeemph1_w        ), .out_sig(txdeemph1      ));
altpcie_grounder #(.WIDTH(1))  txdeemph2_gnd             (.grounded(synth_mode),.in_sig(txdeemph2_w        ), .out_sig(txdeemph2      ));
altpcie_grounder #(.WIDTH(1))  txdeemph3_gnd             (.grounded(synth_mode),.in_sig(txdeemph3_w        ), .out_sig(txdeemph3      ));
altpcie_grounder #(.WIDTH(1))  txdeemph4_gnd             (.grounded(synth_mode),.in_sig(txdeemph4_w        ), .out_sig(txdeemph4      ));
altpcie_grounder #(.WIDTH(1))  txdeemph5_gnd             (.grounded(synth_mode),.in_sig(txdeemph5_w        ), .out_sig(txdeemph5      ));
altpcie_grounder #(.WIDTH(1))  txdeemph6_gnd             (.grounded(synth_mode),.in_sig(txdeemph6_w        ), .out_sig(txdeemph6      ));
altpcie_grounder #(.WIDTH(1))  txdeemph7_gnd             (.grounded(synth_mode),.in_sig(txdeemph7_w        ), .out_sig(txdeemph7      ));
altpcie_grounder #(.WIDTH(1))  txswing0_gnd              (.grounded(synth_mode),.in_sig(txswing0_w         ), .out_sig(txswing0       ));
altpcie_grounder #(.WIDTH(1))  txswing1_gnd              (.grounded(synth_mode),.in_sig(txswing1_w         ), .out_sig(txswing1       ));
altpcie_grounder #(.WIDTH(1))  txswing2_gnd              (.grounded(synth_mode),.in_sig(txswing2_w         ), .out_sig(txswing2       ));
altpcie_grounder #(.WIDTH(1))  txswing3_gnd              (.grounded(synth_mode),.in_sig(txswing3_w         ), .out_sig(txswing3       ));
altpcie_grounder #(.WIDTH(1))  txswing4_gnd              (.grounded(synth_mode),.in_sig(txswing4_w         ), .out_sig(txswing4       ));
altpcie_grounder #(.WIDTH(1))  txswing5_gnd              (.grounded(synth_mode),.in_sig(txswing5_w         ), .out_sig(txswing5       ));
altpcie_grounder #(.WIDTH(1))  txswing6_gnd              (.grounded(synth_mode),.in_sig(txswing6_w         ), .out_sig(txswing6       ));
altpcie_grounder #(.WIDTH(1))  txswing7_gnd              (.grounded(synth_mode),.in_sig(txswing7_w         ), .out_sig(txswing7       ));


altpcie_grounder #(.WIDTH(3)) txmargin0_gnd          (.grounded(synth_mode) ,    .in_sig(txmargin0_w)       ,  .out_sig     (txmargin0)         );
altpcie_grounder #(.WIDTH(3)) txmargin1_gnd          (.grounded(synth_mode) ,    .in_sig(txmargin1_w)       ,  .out_sig     (txmargin1)         );
altpcie_grounder #(.WIDTH(3)) txmargin2_gnd          (.grounded(synth_mode) ,    .in_sig(txmargin2_w)       ,  .out_sig     (txmargin2)         );
altpcie_grounder #(.WIDTH(3)) txmargin3_gnd          (.grounded(synth_mode) ,    .in_sig(txmargin3_w)       ,  .out_sig     (txmargin3)         );
altpcie_grounder #(.WIDTH(3)) txmargin4_gnd          (.grounded(synth_mode) ,    .in_sig(txmargin4_w)       ,  .out_sig     (txmargin4)         );
altpcie_grounder #(.WIDTH(3)) txmargin5_gnd          (.grounded(synth_mode) ,    .in_sig(txmargin5_w)       ,  .out_sig     (txmargin5)         );
altpcie_grounder #(.WIDTH(3)) txmargin6_gnd          (.grounded(synth_mode) ,    .in_sig(txmargin6_w)       ,  .out_sig     (txmargin6)         );
altpcie_grounder #(.WIDTH(3)) txmargin7_gnd          (.grounded(synth_mode) ,    .in_sig(txmargin7_w)       ,  .out_sig     (txmargin7)         );
altpcie_grounder #(.WIDTH(3)) currentrxpreset0_gnd   (.grounded(synth_mode) ,    .in_sig(currentrxpreset0_w),  .out_sig     (currentrxpreset0)  );
altpcie_grounder #(.WIDTH(3)) currentrxpreset1_gnd   (.grounded(synth_mode) ,    .in_sig(currentrxpreset1_w),  .out_sig     (currentrxpreset1)  );
altpcie_grounder #(.WIDTH(3)) currentrxpreset2_gnd   (.grounded(synth_mode) ,    .in_sig(currentrxpreset2_w),  .out_sig     (currentrxpreset2)  );
altpcie_grounder #(.WIDTH(3)) currentrxpreset3_gnd   (.grounded(synth_mode) ,    .in_sig(currentrxpreset3_w),  .out_sig     (currentrxpreset3)  );
altpcie_grounder #(.WIDTH(3)) currentrxpreset4_gnd   (.grounded(synth_mode) ,    .in_sig(currentrxpreset4_w),  .out_sig     (currentrxpreset4)  );
altpcie_grounder #(.WIDTH(3)) currentrxpreset5_gnd   (.grounded(synth_mode) ,    .in_sig(currentrxpreset5_w),  .out_sig     (currentrxpreset5)  );
altpcie_grounder #(.WIDTH(3)) currentrxpreset6_gnd   (.grounded(synth_mode) ,    .in_sig(currentrxpreset6_w),  .out_sig     (currentrxpreset6)  );
altpcie_grounder #(.WIDTH(3)) currentrxpreset7_gnd   (.grounded(synth_mode) ,    .in_sig(currentrxpreset7_w),  .out_sig     (currentrxpreset7)  );

altpcie_grounder #(.WIDTH(2))  txsynchd0_gnd   (.grounded(synth_mode),     .in_sig(txsynchd0_w),        .out_sig  (  txsynchd0) );
altpcie_grounder #(.WIDTH(2))  txsynchd1_gnd   (.grounded(synth_mode),     .in_sig(txsynchd1_w),        .out_sig  (  txsynchd1) );
altpcie_grounder #(.WIDTH(2))  txsynchd2_gnd   (.grounded(synth_mode),     .in_sig(txsynchd2_w),        .out_sig  (  txsynchd2) );
altpcie_grounder #(.WIDTH(2))  txsynchd3_gnd   (.grounded(synth_mode),     .in_sig(txsynchd3_w),        .out_sig  (  txsynchd3) );
altpcie_grounder #(.WIDTH(2))  txsynchd4_gnd   (.grounded(synth_mode),     .in_sig(txsynchd4_w),        .out_sig  (  txsynchd4) );
altpcie_grounder #(.WIDTH(2))  txsynchd5_gnd   (.grounded(synth_mode),     .in_sig(txsynchd5_w),        .out_sig  (  txsynchd5) );
altpcie_grounder #(.WIDTH(2))  txsynchd6_gnd   (.grounded(synth_mode),     .in_sig(txsynchd6_w),        .out_sig  (  txsynchd6) );
altpcie_grounder #(.WIDTH(2))  txsynchd7_gnd   (.grounded(synth_mode),     .in_sig(txsynchd7_w),        .out_sig  (  txsynchd7) );
altpcie_grounder #(.WIDTH(2))  rate0_gnd       (.grounded(synth_mode),     .in_sig(rate0_w),            .out_sig  (  rate0    ) );
altpcie_grounder #(.WIDTH(2))  rate1_gnd       (.grounded(synth_mode),     .in_sig(rate1_w),            .out_sig  (  rate1    ) );
altpcie_grounder #(.WIDTH(2))  rate2_gnd       (.grounded(synth_mode),     .in_sig(rate2_w),            .out_sig  (  rate2    ) );
altpcie_grounder #(.WIDTH(2))  rate3_gnd       (.grounded(synth_mode),     .in_sig(rate3_w),            .out_sig  (  rate3    ) );
altpcie_grounder #(.WIDTH(2))  rate4_gnd       (.grounded(synth_mode),     .in_sig(rate4_w),            .out_sig  (  rate4    ) );
altpcie_grounder #(.WIDTH(2))  rate5_gnd       (.grounded(synth_mode),     .in_sig(rate5_w),            .out_sig  (  rate5    ) );
altpcie_grounder #(.WIDTH(2))  rate6_gnd       (.grounded(synth_mode),     .in_sig(rate6_w),            .out_sig  (  rate6    ) );
altpcie_grounder #(.WIDTH(2))  rate7_gnd       (.grounded(synth_mode),     .in_sig(rate7_w),            .out_sig  (  rate7    ) );


altpcie_grounder #(.WIDTH(18))  currentcoeff0_gnd   (.grounded(synth_mode),     .in_sig(currentcoeff0_w),        .out_sig  (  currentcoeff0) );
altpcie_grounder #(.WIDTH(18))  currentcoeff1_gnd   (.grounded(synth_mode),     .in_sig(currentcoeff1_w),        .out_sig  (  currentcoeff1) );
altpcie_grounder #(.WIDTH(18))  currentcoeff2_gnd   (.grounded(synth_mode),     .in_sig(currentcoeff2_w),        .out_sig  (  currentcoeff2) );
altpcie_grounder #(.WIDTH(18))  currentcoeff3_gnd   (.grounded(synth_mode),     .in_sig(currentcoeff3_w),        .out_sig  (  currentcoeff3) );
altpcie_grounder #(.WIDTH(18))  currentcoeff4_gnd   (.grounded(synth_mode),     .in_sig(currentcoeff4_w),        .out_sig  (  currentcoeff4) );
altpcie_grounder #(.WIDTH(18))  currentcoeff5_gnd   (.grounded(synth_mode),     .in_sig(currentcoeff5_w),        .out_sig  (  currentcoeff5) );
altpcie_grounder #(.WIDTH(18))  currentcoeff6_gnd   (.grounded(synth_mode),     .in_sig(currentcoeff6_w),        .out_sig  (  currentcoeff6) );
altpcie_grounder #(.WIDTH(18))  currentcoeff7_gnd   (.grounded(synth_mode),     .in_sig(currentcoeff7_w),        .out_sig  (  currentcoeff7) );



//synthesis translate_off
assign coreclkout_hip = coreclkout;
//synthesis translate_on

//synthesis read_comments_as_HDL on
//`ifdef ALTERA_RESERVED_QHD
//    altera_global u_global_buffer_coreclkout (.in(coreclkout), .out(coreclkout_hip));
//`else
//    global u_global_buffer_coreclkout (.in(coreclkout), .out(coreclkout_hip));
//`endif
//synthesis read_comments_as_HDL off


//////////////////////////////////////////////////////////////////////////////////////////////
/////               AVMM Application 64-bit                                             //////
//////////////////////////////////////////////////////////////////////////////////////////////
generate begin : g_tx_data_avmm
   if (data_width_integer_hwtcl==256) begin : tx256
      assign tx_st_data_avmm[255:0]       = tx_st_data_avmm_int[255:0] ;
   end
   else if (data_width_integer_hwtcl==128) begin : tx128
      assign tx_st_data_avmm[255:0]       = {128'h0,tx_st_data_avmm_int[127:0]};
   end
   else begin : tx64
      assign tx_st_data_avmm[255:0]       = {192'h0,tx_st_data_avmm_int[63:0]};
   end
end
endgenerate

assign tx_st_sop_avmm_int = {3'b000, tx_st_sop_avmm};
assign tx_st_eop_avmm_int = {3'b000, tx_st_eop_avmm};
assign tx_cred_fcsel_avmm = 2'b01;   /// NP
assign intx_ack_o         = app_int_ack;

generate begin : g_avmm
   if (interface_type_integer_hwtcl == 1 & include_dma_hwtcl==0 & data_width_integer_hwtcl==64 & !(cb_pcie_mode_hwtcl == 1 && cb_pcie_rx_lite_hwtcl_local   == 1)) begin : g_avmm
      altpciexpav_stif_app # (
         .INTENDED_DEVICE_FAMILY               ("Stratix V"                           ),
         .CG_AVALON_S_ADDR_WIDTH               (txs_addr_width_integer_hwtcl          ),
         .CG_COMMON_CLOCK_MODE                 (1                                     ),
         .CG_IMPL_CRA_AV_SLAVE_PORT            (cg_impl_cra_av_slave_port_hwtcl       ),
         .CB_PCIE_MODE                         (cb_pcie_mode_hwtcl                    ),
         .CB_PCIE_RX_LITE                      (cb_pcie_rx_lite_hwtcl_local           ),
         .CB_RXM_DATA_WIDTH                    (data_width_integer_hwtcl              ),
         .CB_A2P_ADDR_MAP_IS_FIXED             (0                                     ),
         .CB_A2P_ADDR_MAP_FIXED_TABLE          (0                                     ),
         .CB_A2P_ADDR_MAP_NUM_ENTRIES          (cg_a2p_addr_map_num_entries_hwtcl     ),
         .CB_A2P_ADDR_MAP_PASS_THRU_BITS       ((avmm_addr_width_hwtcl==32)?cg_a2p_addr_map_pass_thru_bits_hwtcl:12  ),
         .CB_P2A_AVALON_ADDR_B0                (0                                     ),
         .CB_P2A_AVALON_ADDR_B1                (0                                     ),
         .CB_P2A_AVALON_ADDR_B2                (0                                     ),
         .CB_P2A_AVALON_ADDR_B3                (0                                     ),
         .CB_P2A_AVALON_ADDR_B4                (0                                     ),
         .CB_P2A_AVALON_ADDR_B5                (0                                     ),
         .CB_P2A_AVALON_ADDR_B6                (0                                     ),
         .bar_io_window_size                   ("NONE"                                ),
         .bar_prefetchable                     (0                                     ),
         .expansion_base_address_register      (0                                     ),
         .EXTERNAL_A2P_TRANS                   (0                                     ),
         .CG_ENABLE_A2P_INTERRUPT              (cg_enable_a2p_interrupt_hwtcl         ),
         .CG_ENABLE_ADVANCED_INTERRUPT         (cg_enable_advanced_interrupt_hwtcl    ),
         .CG_RXM_IRQ_NUM                       (16                                    ),
         .port_type_hwtcl                      (port_type_avmm                        ),
         .AVALON_ADDR_WIDTH                    (avmm_addr_width_hwtcl                 ),
         .BYPASSS_A2P_TRANSLATION              (0                                     ),
         .bar0_64bit_mem_space                 (bar0_64bit_mem_space                  ),
         .bar0_size_mask                       (avmm_bar0_size_mask                   ),
         .bar1_size_mask                       (avmm_bar1_size_mask                   ),
         .bar2_size_mask                       (avmm_bar2_size_mask                   ),
         .bar3_size_mask                       (avmm_bar3_size_mask                   ),
         .bar4_size_mask                       (avmm_bar4_size_mask                   ),
         .bar5_size_mask                       (avmm_bar5_size_mask                   )
      ) avalon_bridge (
         // system inputs
         .AvlClk_i            (coreclkout_hip            ),
         .Rstn_i              (app_rstn[1]                  ),
         .RxStReady_o         (rx_st_ready_avmm          ),
         .RxStMask_o          (rx_st_mask_avmm           ),
         .RxStData_i          (rx_st_data                ),
         .RxStParity_i        (                          ),
         .RxStBe_i            (rx_st_be_int              ),
         .RxStEmpty_i         (rx_st_empty_int           ),
         .RxStErr_i           (rx_st_err                 ),
         .RxStSop_i           (rx_st_sop                 ),
         .RxStEop_i           (rx_st_eop                 ),
         .RxStValid_i         (rx_st_valid               ),
         .RxStBarDec1_i       (rx_st_bar                 ),
         .RxStBarDec2_i       (8'h0                      ),
         .TxStReady_i         (tx_st_ready               ),
         .TxStData_o          (tx_st_data_avmm_int       ),
         .TxStErr_o           (tx_st_err_avmm_int        ),
         .TxStSop_o           (tx_st_sop_avmm            ),
         .TxStEop_o           (tx_st_eop_avmm            ),
         .TxStEmpty_o         (tx_st_empty_avmm          ),
         .TxStValid_o         (tx_st_valid_avmm          ),
         .TxAdapterFifoEmpty_i(1'b0                      ),
         .CplPending_o        (cpl_pending_avmm          ),
         .TxCredPDataLimit_i  (12'h0                     ),
         .TxCredNpDataLimit_i (12'h0                     ),
         .TxCredCplDataLimit_i(12'h0                     ),
         .TxCredHipCons_i     (tx_cred_fc_hip_cons       ),
         .TxCredInfinit_i     (tx_cred_fc_infinite       ),
         .TxCredPHdrLimit_i   (8'h0                      ),
         .TxCredNpHdrLimit_i  (tx_cred_hdr_fc            ),
         .TxCredCplHdrLimit_i (8'h0                      ),
         .ko_cpl_spc_header   (ko_cpl_spc_header         ),
         .ko_cpl_spc_data     (ko_cpl_spc_data           ),
         .CfgCtlWr_i          (1'b0                      ),
         .CfgAddr_i           (tl_cfg_add                ),
         .CfgCtl_i            (tl_cfg_ctl                ),
         .MsiReq_o            (app_msi_req_avmm          ),
         .MsiAck_i            (app_msi_ack               ),
         .MsiTc_o             (app_msi_tc_avmm           ),
         .MsiNum_o            (app_msi_num_avmm          ),
         .IntxReq_o           (app_int_sts_avmm          ),
         .IntxAck_i           (app_int_ack               ),
         .TxsClk_i            (coreclkout_hip            ),
         .TxsRstn_i           (app_rstn[2]                  ),
         .TxsChipSelect_i     (txs_chipselect_i          ),
         .TxsRead_i           (txs_read_i                ),
         .TxsWrite_i          (txs_write_i               ),
         .TxsWriteData_i      (txs_writedata_i           ),
         .TxsBurstCount_i     (txs_burstcount_i          ),
         .TxsAddress_i        (txs_address_i             ),
         .TxsByteEnable_i     (txs_byteenable_i          ),
         .TxsReadDataValid_o  (txs_readdatavalid_o       ),
         .TxsReadData_o       (txs_readdata_o            ),
         .TxsWaitRequest_o    (txs_waitrequest_o         ),
         .RxmWrite_0_o        (rxm_bar0_write_o          ),
         .RxmAddress_0_o      (rxm_bar0_address_o        ),
         .RxmWriteData_0_o    (rxm_bar0_writedata_o      ),
         .RxmByteEnable_0_o   (rxm_bar0_byteenable_o     ),
         .RxmBurstCount_0_o   (rxm_bar0_burstcount_o     ),
         .RxmWaitRequest_0_i  (rxm_bar0_waitrequest_i    ),
         .RxmRead_0_o         (rxm_bar0_read_o           ),
         .RxmReadData_0_i     (rxm_bar0_readdata_i       ),
         .RxmReadDataValid_0_i(rxm_bar0_readdatavalid_i  ),
         .RxmWrite_1_o        (rxm_bar1_write_o          ),
         .RxmAddress_1_o      (rxm_bar1_address_o        ),
         .RxmWriteData_1_o    (rxm_bar1_writedata_o      ),
         .RxmByteEnable_1_o   (rxm_bar1_byteenable_o     ),
         .RxmBurstCount_1_o   (rxm_bar1_burstcount_o     ),
         .RxmWaitRequest_1_i  (rxm_bar1_waitrequest_i    ),
         .RxmRead_1_o         (rxm_bar1_read_o           ),
         .RxmReadData_1_i     (rxm_bar1_readdata_i       ),
         .RxmReadDataValid_1_i(rxm_bar1_readdatavalid_i  ),
         .RxmWrite_2_o        (rxm_bar2_write_o          ),
         .RxmAddress_2_o      (rxm_bar2_address_o        ),
         .RxmWriteData_2_o    (rxm_bar2_writedata_o      ),
         .RxmByteEnable_2_o   (rxm_bar2_byteenable_o     ),
         .RxmBurstCount_2_o   (rxm_bar2_burstcount_o     ),
         .RxmWaitRequest_2_i  (rxm_bar2_waitrequest_i    ),
         .RxmRead_2_o         (rxm_bar2_read_o           ),
         .RxmReadData_2_i     (rxm_bar2_readdata_i       ),
         .RxmReadDataValid_2_i(rxm_bar2_readdatavalid_i  ),
         .RxmWrite_3_o        (rxm_bar3_write_o          ),
         .RxmAddress_3_o      (rxm_bar3_address_o        ),
         .RxmWriteData_3_o    (rxm_bar3_writedata_o      ),
         .RxmByteEnable_3_o   (rxm_bar3_byteenable_o     ),
         .RxmBurstCount_3_o   (rxm_bar3_burstcount_o     ),
         .RxmWaitRequest_3_i  (rxm_bar3_waitrequest_i    ),
         .RxmRead_3_o         (rxm_bar3_read_o           ),
         .RxmReadData_3_i     (rxm_bar3_readdata_i       ),
         .RxmReadDataValid_3_i(rxm_bar3_readdatavalid_i  ),
         .RxmWrite_4_o        (rxm_bar4_write_o          ),
         .RxmAddress_4_o      (rxm_bar4_address_o        ),
         .RxmWriteData_4_o    (rxm_bar4_writedata_o      ),
         .RxmByteEnable_4_o   (rxm_bar4_byteenable_o     ),
         .RxmBurstCount_4_o   (rxm_bar4_burstcount_o     ),
         .RxmWaitRequest_4_i  (rxm_bar4_waitrequest_i    ),
         .RxmRead_4_o         (rxm_bar4_read_o           ),
         .RxmReadData_4_i     (rxm_bar4_readdata_i       ),
         .RxmReadDataValid_4_i(rxm_bar4_readdatavalid_i  ),
         .RxmWrite_5_o        (rxm_bar5_write_o          ),
         .RxmAddress_5_o      (rxm_bar5_address_o        ),
         .RxmWriteData_5_o    (rxm_bar5_writedata_o      ),
         .RxmByteEnable_5_o   (rxm_bar5_byteenable_o     ),
         .RxmBurstCount_5_o   (rxm_bar5_burstcount_o     ),
         .RxmWaitRequest_5_i  (rxm_bar5_waitrequest_i    ),
         .RxmRead_5_o         (rxm_bar5_read_o           ),
         .RxmReadData_5_i     (rxm_bar5_readdata_i       ),
         .RxmReadDataValid_5_i(rxm_bar5_readdatavalid_i  ),
         .RxmIrq_i            (rxm_irq_i                 ),
         .CraClk_i            (coreclkout_hip            ),
         .CraRstn_i           (app_rstn[3]                  ),
         .CraChipSelect_i     (cra_chipselect_i          ),
         .CraRead             (cra_read_i                ),
         .CraWrite            (cra_write_i               ),
         .CraWriteData_i      (cra_writedata_i           ),
         .CraAddress_i        (cra_address_i[13:2]       ),
         .CraByteEnable_i     (cra_byteenable_i          ),
         .CraReadData_o       (cra_readdata_o            ),      // This comes from Rx Completion to be returned to Avalon master
         .CraWaitRequest_o    (cra_waitrequest_o         ),
         .CraIrq_o            (cra_irq_o                 ),
         .MsiIntfc_o          (msi_intfc_o               ),
         .MsiControl_o        (msi_control_o             ),
         .MsixIntfc_o         (msix_intfc_o              ),
         .RxIntStatus_i       (int_status                ),
         .pld_clk_inuse       (pld_clk_inuse             ),
         .tx_cons_cred_sel    (tx_cons_cred_sel_avmm     ),
         .ltssm_state         (ltssmstate_reg            ),
         .current_speed       (currentspeed              ),
         .lane_act            (lane_act                  )
         );
   end
end
endgenerate

generate begin : g_avmm_lite
   if (interface_type_integer_hwtcl == 1 && include_dma_hwtcl==0 && (cb_pcie_mode_hwtcl == 1 && cb_pcie_rx_lite_hwtcl_local   == 1)) begin : avmm_lite
      altpciexpav_lite_app # (
         .CB_P2A_AVALON_ADDR_B0( 0                                 ),
         .CB_P2A_AVALON_ADDR_B1(0                                  ),
         .CB_P2A_AVALON_ADDR_B2(0                                  ),
         .CB_P2A_AVALON_ADDR_B3(0                                  ),
         .CB_P2A_AVALON_ADDR_B4(0                                  ),
         .CB_P2A_AVALON_ADDR_B5(0                                  ),
         .CB_P2A_AVALON_ADDR_B6(0                                  ),
         .bar0_64bit_mem_space             (bar0_64bit_mem_space   ),
         .bar0_io_space                    (bar0_io_space          ),
         .bar0_prefetchable                (bar0_prefetchable      ),
         .bar0_size_mask                   (avmm_bar0_size_mask    ),
         .bar1_64bit_mem_space             (bar1_64bit_mem_space   ),
         .bar1_io_space                    (bar1_io_space          ),
         .bar1_prefetchable                (bar1_prefetchable      ),
         .bar1_size_mask                   (avmm_bar1_size_mask    ),
         .bar2_64bit_mem_space             (bar2_64bit_mem_space   ),
         .bar2_io_space                    (bar2_io_space          ),
         .bar2_prefetchable                (bar2_prefetchable      ),
         .bar2_size_mask                   (avmm_bar2_size_mask    ),
         .bar3_64bit_mem_space             (bar3_64bit_mem_space   ),
         .bar3_io_space                    (bar3_io_space          ),
         .bar3_prefetchable                (bar3_prefetchable      ),
         .bar3_size_mask                   (avmm_bar3_size_mask    ),
         .bar4_64bit_mem_space             (bar4_64bit_mem_space   ),
         .bar4_io_space                    (bar4_io_space          ),
         .bar4_prefetchable                ( bar4_prefetchable     ),
         .bar4_size_mask                   (avmm_bar4_size_mask    ),
         .bar5_64bit_mem_space             (bar5_64bit_mem_space   ),
         .bar5_io_space                    (bar5_io_space          ),
         .bar5_prefetchable                ( bar5_prefetchable     ),
         .bar5_size_mask                   (avmm_bar5_size_mask    ),
         .bar_io_window_size               ("NONE"                 ),
         .bar_prefetchable                 (0                      ),
         .expansion_base_address_register  (0                      ),
         .CB_RXM_DATA_WIDTH                (32                     ),
         .CG_RXM_IRQ_NUM                   (16                     )
      ) avalon_bridge (
         .Clk_i                 (coreclkout_hip             ),
         .Rstn_i                (app_rstn[1]                   ),
         .RxStEmpty_i           (rx_st_empty_int            ),
         .RxStMask_o            (rx_st_mask_avmm            ),
         .RxStSop_i             (rx_st_sop                  ),
         .RxStEop_i             (rx_st_eop                  ),
         .RxStData_i            (rx_st_data                 ),
         .RxStValid_i           (rx_st_valid                ),
         .RxStReady_o           (rx_st_ready_avmm           ),
         .RxStBarDec_i          (rx_st_bar                  ),
         .TxStReady_i           (tx_st_ready                ),
         .TxStSop_o             (tx_st_sop_avmm             ),
         .TxStEop_o             (tx_st_eop_avmm             ),
         .TxStData_o            (tx_st_data_avmm_int        ),
         .TxStValid_o           (tx_st_valid_avmm           ),
         .RxmWrite_0_o          (rxm_bar0_write_o           ),
         .RxmAddress_0_o        (rxm_bar0_address_o         ),
         .RxmWriteData_0_o      (rxm_bar0_writedata_o       ),
         .RxmByteEnable_0_o     (rxm_bar0_byteenable_o      ),
         .RxmWaitRequest_0_i    (rxm_bar0_waitrequest_i     ),
         .RxmRead_0_o           (rxm_bar0_read_o            ),
         .RxmReadData_0_i       (rxm_bar0_readdata_i        ),
         .RxmReadDataValid_0_i  (rxm_bar0_readdatavalid_i   ),
         .RxmWrite_1_o          (rxm_bar1_write_o           ),
         .RxmAddress_1_o        (rxm_bar1_address_o         ),
         .RxmWriteData_1_o      (rxm_bar1_writedata_o       ),
         .RxmByteEnable_1_o     (rxm_bar1_byteenable_o      ),
         .RxmWaitRequest_1_i    (rxm_bar1_waitrequest_i     ),
         .RxmRead_1_o           (rxm_bar1_read_o            ),
         .RxmReadData_1_i       (rxm_bar1_readdata_i        ),
         .RxmReadDataValid_1_i  (rxm_bar1_readdatavalid_i   ),
         .RxmWrite_2_o          (rxm_bar2_write_o           ),
         .RxmAddress_2_o        (rxm_bar2_address_o         ),
         .RxmWriteData_2_o      (rxm_bar2_writedata_o       ),
         .RxmByteEnable_2_o     (rxm_bar2_byteenable_o      ),
         .RxmWaitRequest_2_i    (rxm_bar2_waitrequest_i     ),
         .RxmRead_2_o           (rxm_bar2_read_o            ),
         .RxmReadData_2_i       (rxm_bar2_readdata_i        ),
         .RxmReadDataValid_2_i  (rxm_bar2_readdatavalid_i   ),
         .RxmWrite_3_o          (rxm_bar3_write_o           ),
         .RxmAddress_3_o        (rxm_bar3_address_o         ),
         .RxmWriteData_3_o      (rxm_bar3_writedata_o       ),
         .RxmByteEnable_3_o     (rxm_bar3_byteenable_o      ),
         .RxmWaitRequest_3_i    (rxm_bar3_waitrequest_i     ),
         .RxmRead_3_o           (rxm_bar3_read_o            ),
         .RxmReadData_3_i       (rxm_bar3_readdata_i        ),
         .RxmReadDataValid_3_i  (rxm_bar3_readdatavalid_i   ),
         .RxmWrite_4_o          (rxm_bar4_write_o           ),
         .RxmAddress_4_o        (rxm_bar4_address_o         ),
         .RxmWriteData_4_o      (rxm_bar4_writedata_o       ),
         .RxmByteEnable_4_o     (rxm_bar4_byteenable_o      ),
         .RxmWaitRequest_4_i    (rxm_bar4_waitrequest_i     ),
         .RxmRead_4_o           (rxm_bar4_read_o            ),
         .RxmReadData_4_i       (rxm_bar4_readdata_i        ),
         .RxmReadDataValid_4_i  (rxm_bar4_readdatavalid_i   ),
         .RxmWrite_5_o          (rxm_bar5_write_o           ),
         .RxmAddress_5_o        (rxm_bar5_address_o         ),
         .RxmWriteData_5_o      (rxm_bar5_writedata_o       ),
         .RxmByteEnable_5_o     (rxm_bar5_byteenable_o      ),
         .RxmWaitRequest_5_i    (rxm_bar5_waitrequest_i     ),
         .RxmRead_5_o           (rxm_bar5_read_o            ),
         .RxmReadData_5_i       ( rxm_bar5_readdata_i       ),
         .RxmReadDataValid_5_i  (rxm_bar5_readdatavalid_i   ),
         .RxmIrq_i              ( rxm_irq_i                 ),
         .CfgCtlWr_i            ( 1'b0                      ),
         .CfgAddr_i             (tl_cfg_add                 ),
         .CfgCtl_i              ( tl_cfg_ctl                ),
         .AppIntSts_o           (app_int_sts_avmm           ),
         .MsiReq_o              (app_msi_req_avmm           ),
         .MsiAck_i              (app_msi_ack                ),
         .MsiTc_o               (app_msi_tc_avmm            ),
         .MsiNum_o              (app_msi_num_avmm           )
  );


  assign tx_cons_cred_sel_avmm = 1'b0;
  assign cpl_pending_avmm = 1'b0;
   end
end
endgenerate

generate begin: g_avmm_128
   if (interface_type_integer_hwtcl == 1 & include_dma_hwtcl==0 & data_width_integer_hwtcl==128 & !(cb_pcie_mode_hwtcl == 1 && cb_pcie_rx_lite_hwtcl_local   == 1)) begin : avmm_128
      altpciexpav128_app # (
            .INTENDED_DEVICE_FAMILY               ("Stratix V"                           ),
            .CG_AVALON_S_ADDR_WIDTH               (txs_addr_width_integer_hwtcl          ),
            .CG_COMMON_CLOCK_MODE                 (1                                     ),
            .CG_IMPL_CRA_AV_SLAVE_PORT            (cg_impl_cra_av_slave_port_hwtcl       ),
            .CB_PCIE_MODE                         (cb_pcie_mode_hwtcl                    ),
            .CB_PCIE_RX_LITE                      (cb_pcie_rx_lite_hwtcl_local           ),
            .CB_RXM_DATA_WIDTH                    (data_width_integer_hwtcl              ),
            .CB_A2P_ADDR_MAP_IS_FIXED             (0                                     ),
            .CB_A2P_ADDR_MAP_FIXED_TABLE          (0                                     ),
            .CB_A2P_ADDR_MAP_NUM_ENTRIES          (cg_a2p_addr_map_num_entries_hwtcl     ),
            .CB_A2P_ADDR_MAP_PASS_THRU_BITS       ((avmm_addr_width_hwtcl==32)?cg_a2p_addr_map_pass_thru_bits_hwtcl:12),
            .CB_P2A_AVALON_ADDR_B0                (0                                     ),
            .CB_P2A_AVALON_ADDR_B1                (0                                     ),
            .CB_P2A_AVALON_ADDR_B2                (0                                     ),
            .CB_P2A_AVALON_ADDR_B3                (0                                     ),
            .CB_P2A_AVALON_ADDR_B4                (0                                     ),
            .CB_P2A_AVALON_ADDR_B5                (0                                     ),
            .CB_P2A_AVALON_ADDR_B6                (0                                     ),
            .EXTERNAL_A2P_TRANS                   (0                                     ),
            .CG_ENABLE_A2P_INTERRUPT              (cg_enable_a2p_interrupt_hwtcl         ),
            .CG_ENABLE_ADVANCED_INTERRUPT         (cg_enable_advanced_interrupt_hwtcl    ),
            .CG_RXM_IRQ_NUM                       (16                                    ),
            .port_type_hwtcl                      (port_type_avmm                        ),
            .AVALON_ADDR_WIDTH                    (avmm_addr_width_hwtcl                 ),
            .BYPASSS_A2P_TRANSLATION              (0                                     ),
            .bar0_64bit_mem_space                 (bar0_64bit_mem_space                  ),
            .bar0_size_mask                       (avmm_bar0_size_mask                   ),
            .bar1_size_mask                       (avmm_bar1_size_mask                   ),
            .bar2_size_mask                       (avmm_bar2_size_mask                   ),
            .bar3_size_mask                       (avmm_bar3_size_mask                   ),
            .bar4_size_mask                       (avmm_bar4_size_mask                   ),
            .bar5_size_mask                       (avmm_bar5_size_mask                   )
      ) avalon_bridge (    // 128
            .AvlClk_i                             (coreclkout_hip                   ),
            .Rstn_i                               (app_rstn[1]                         ),
            .RxStReady_o                          (rx_st_ready_avmm                 ),
            .RxStMask_o                           (rx_st_mask_avmm                  ),
            .RxStData_i                           (rx_st_data                       ),
            .RxStBe_i                             (rx_st_be_int                     ),
            .RxStEmpty_i                          (rx_st_empty_int                  ),
            .RxStErr_i                            (rx_st_err                        ),
            .RxStSop_i                            (rx_st_sop                        ),
            .RxStEop_i                            (rx_st_eop                        ),
            .RxStValid_i                          (rx_st_valid                      ),
            .RxStBarDec1_i                        (rx_st_bar                        ),
            .RxStBarDec2_i                        (8'h0                             ),
            .TxStReady_i                          (tx_st_ready                      ),
            .TxStData_o                           (tx_st_data_avmm_int              ),
            .TxStSop_o                            (tx_st_sop_avmm                   ),
            .TxStEop_o                            (tx_st_eop_avmm                   ),
            .TxStEmpty_o                          (tx_st_empty_avmm                 ),
            .TxStValid_o                          (tx_st_valid_avmm                 ),
            .TxAdapterFifoEmpty_i                 (1'b0                             ),
            .TxCredPDataLimit_i                   (12'h0                            ),
            .TxCredNpDataLimit_i                  (12'h0                            ),
            .TxCredCplDataLimit_i                 (12'h0                            ),
            .TxCredHipCons_i                      (tx_cred_fc_hip_cons              ),
            .TxCredInfinit_i                      (tx_cred_fc_infinite              ),
            .TxCredPHdrLimit_i                    (8'h0                             ),
            .TxCredNpHdrLimit_i                   (tx_cred_hdr_fc                   ),
            .TxCredCplHdrLimit_i                  (8'h0                             ),
            .ko_cpl_spc_header                    (ko_cpl_spc_header                ),
            .ko_cpl_spc_data                      (ko_cpl_spc_data                  ),
            .CfgCtlWr_i                           (1'b0                             ),
            .CfgAddr_i                            (tl_cfg_add                       ),
            .CfgCtl_i                             (tl_cfg_ctl                       ),
            .MsiReq_o                             (app_msi_req_avmm                 ),
            .MsiAck_i                             (app_msi_ack                      ),
            .MsiTc_o                              (app_msi_tc_avmm                  ),
            .MsiNum_o                             (app_msi_num_avmm                 ),
            .IntxReq_o                            (app_int_sts_avmm                 ),
            .IntxAck_i                            (app_int_ack                      ),
            .TxsClk_i                             (coreclkout_hip                   ),
            .TxsRstn_i                            (app_rstn[2]                      ),
            .TxsChipSelect_i                      (txs_chipselect_i                 ),
            .TxsRead_i                            (txs_read_i                       ),
            .TxsWrite_i                           (txs_write_i                      ),
            .TxsWriteData_i                       (txs_writedata_i                  ),
            .TxsBurstCount_i                      (txs_burstcount_i                 ),
            .TxsAddress_i                         (txs_address_i                    ),
            .TxsByteEnable_i                      (txs_byteenable_i                 ),
            .TxsReadDataValid_o                   (txs_readdatavalid_o              ),
            .TxsReadData_o                        (txs_readdata_o                   ),
            .TxsWaitRequest_o                     (txs_waitrequest_o                ),
            .RxmWrite_0_o                         (rxm_bar0_write_o                 ),
            .RxmAddress_0_o                       (rxm_bar0_address_o               ),
            .RxmWriteData_0_o                     (rxm_bar0_writedata_o             ),
            .RxmByteEnable_0_o                    (rxm_bar0_byteenable_o            ),
            .RxmBurstCount_0_o                    (rxm_bar0_burstcount_o            ),
            .RxmWaitRequest_0_i                   (rxm_bar0_waitrequest_i           ),
            .RxmRead_0_o                          (rxm_bar0_read_o                  ),
            .RxmReadData_0_i                      (rxm_bar0_readdata_i              ),
            .RxmReadDataValid_0_i                 (rxm_bar0_readdatavalid_i         ),
            .RxmWrite_1_o                         (rxm_bar1_write_o                 ),
            .RxmAddress_1_o                       (rxm_bar1_address_o               ),
            .RxmWriteData_1_o                     (rxm_bar1_writedata_o             ),
            .RxmByteEnable_1_o                    (rxm_bar1_byteenable_o            ),
            .RxmBurstCount_1_o                    (rxm_bar1_burstcount_o            ),
            .RxmWaitRequest_1_i                   (rxm_bar1_waitrequest_i           ),
            .RxmRead_1_o                          (rxm_bar1_read_o                  ),
            .RxmReadData_1_i                      (rxm_bar1_readdata_i              ),
            .RxmReadDataValid_1_i                 (rxm_bar1_readdatavalid_i         ),
            .RxmWrite_2_o                         (rxm_bar2_write_o                 ),
            .RxmAddress_2_o                       (rxm_bar2_address_o               ),
            .RxmWriteData_2_o                     (rxm_bar2_writedata_o             ),
            .RxmByteEnable_2_o                    (rxm_bar2_byteenable_o            ),
            .RxmBurstCount_2_o                    (rxm_bar2_burstcount_o            ),
            .RxmWaitRequest_2_i                   (rxm_bar2_waitrequest_i           ),
            .RxmRead_2_o                          (rxm_bar2_read_o                  ),
            .RxmReadData_2_i                      (rxm_bar2_readdata_i              ),
            .RxmReadDataValid_2_i                 (rxm_bar2_readdatavalid_i         ),
            .RxmWrite_3_o                         (rxm_bar3_write_o                 ),
            .RxmAddress_3_o                       (rxm_bar3_address_o               ),
            .RxmWriteData_3_o                     (rxm_bar3_writedata_o             ),
            .RxmByteEnable_3_o                    (rxm_bar3_byteenable_o            ),
            .RxmBurstCount_3_o                    (rxm_bar3_burstcount_o            ),
            .RxmWaitRequest_3_i                   (rxm_bar3_waitrequest_i           ),
            .RxmRead_3_o                          (rxm_bar3_read_o                  ),
            .RxmReadData_3_i                      (rxm_bar3_readdata_i              ),
            .RxmReadDataValid_3_i                 (rxm_bar3_readdatavalid_i         ),
            .RxmWrite_4_o                         (rxm_bar4_write_o                 ),
            .RxmAddress_4_o                       (rxm_bar4_address_o               ),
            .RxmWriteData_4_o                     (rxm_bar4_writedata_o             ),
            .RxmByteEnable_4_o                    (rxm_bar4_byteenable_o            ),
            .RxmBurstCount_4_o                    (rxm_bar4_burstcount_o            ),
            .RxmWaitRequest_4_i                   (rxm_bar4_waitrequest_i           ),
            .RxmRead_4_o                          (rxm_bar4_read_o                  ),
            .RxmReadData_4_i                      (rxm_bar4_readdata_i              ),
            .RxmReadDataValid_4_i                 (rxm_bar4_readdatavalid_i         ),
            .RxmWrite_5_o                         (rxm_bar5_write_o                 ),
            .RxmAddress_5_o                       (rxm_bar5_address_o               ),
            .RxmWriteData_5_o                     (rxm_bar5_writedata_o             ),
            .RxmByteEnable_5_o                    (rxm_bar5_byteenable_o            ),
            .RxmBurstCount_5_o                    (rxm_bar5_burstcount_o            ),
            .RxmWaitRequest_5_i                   (rxm_bar5_waitrequest_i           ),
            .RxmRead_5_o                          (rxm_bar5_read_o                  ),
            .RxmReadData_5_i                      (rxm_bar5_readdata_i              ),
            .RxmReadDataValid_5_i                 (rxm_bar5_readdatavalid_i         ),
            .RxmIrq_i                             (rxm_irq_i                        ),
            .CraClk_i                             (coreclkout_hip                   ),
            .CraRstn_i                            (app_rstn[3]                         ),
            .CraChipSelect_i                      (cra_chipselect_i                 ),
            .CraRead                              (cra_read_i                       ),
            .CraWrite                             (cra_write_i                      ),
            .CraWriteData_i                       (cra_writedata_i                  ),
            .CraAddress_i                         (cra_address_i[13:2]              ),
            .CraByteEnable_i                      (cra_byteenable_i                 ),
            .CraReadData_o                        (cra_readdata_o                   ),
            .CraWaitRequest_o                     (cra_waitrequest_o                ),
            .CraIrq_o                             (cra_irq_o                        ),
            .CplPending_o                         (cpl_pending_avmm                 ),
            .MsiIntfc_o                           (msi_intfc_o                      ),
            .MsiControl_o                         (msi_control_o                    ),
            .MsixIntfc_o                          (msix_intfc_o                     ),
            .RxIntStatus_i                        (int_status                       ),
            .pld_clk_inuse                        (pld_clk_inuse                    ),
            .tx_cons_cred_sel                     (tx_cons_cred_sel_avmm            ),
            .ltssm_state                          (ltssmstate_reg                       ),
            .current_speed                        (currentspeed                     ),
            .lane_act                             (lane_act                         )
          );
    end
  end
endgenerate

generate begin: g_avmm_256
   if (interface_type_integer_hwtcl == 1 & include_dma_hwtcl==0 & data_width_integer_hwtcl==256 & !(cb_pcie_mode_hwtcl == 1 && cb_pcie_rx_lite_hwtcl_local   == 1)) begin : avmm_256
      altpcieav_256_rp_app                # (
         .DEVICE_FAMILY                  ("Arria 10"                                 ),
         .DMA_WIDTH                      (dma_width_hwtcl                            ),
         .DMA_BE_WIDTH                   (dma_be_width_hwtcl                         ),
         .DMA_BRST_CNT_W                 (dma_brst_cnt_w_hwtcl                       ),
         .TX_S_ADDR_WIDTH                (txs_addr_width_integer_hwtcl               ),
         .enable_cra_hwtcl               (cg_impl_cra_av_slave_port_hwtcl            ),
         .enable_tx_slave                (1),
         .port_type_hwtcl                (port_type_avmm                             ),
         .dma_use_scfifo_ext             (dma_use_scfifo_ext_hwtcl                   ),
         .BAR_NUMBER                     (0),
         .BAR0_SIZE_MASK                 (avmm_bar0_size_mask                        ),
         .BAR0_TYPE                      (avmm_bar0_type                             )
      ) altpcieav_256_rp_app (
         .Clk_i                          (coreclkout_hip                             ),
         .Rstn_i                         (app_rstn[9:0]                                ),
         .HipRxStReady_o                 (rx_st_ready_avmm                           ),
         .HipRxStMask_o                  (rx_st_mask_avmm                            ),
         .HipRxStData_i                  (rx_st_data                                 ),
         .HipRxStBe_i                    (rx_st_be_int                               ),
         .HipRxStEmpty_i                 (rx_st_empty_int                            ),
         .HipRxStErr_i                   (rx_st_err                                  ),
         .HipRxStSop_i                   (rx_st_sop                                  ),
         .HipRxStEop_i                   (rx_st_eop                                  ),
         .HipRxStValid_i                 (rx_st_valid                                ),
         .HipRxStBarDec1_i               (rx_st_bar                                  ),
         .HipTxStReady_i                 (tx_st_ready                                ),
         .HipTxStData_o                  (tx_st_data_avmm_int                        ),
         .HipTxStSop_o                   (tx_st_sop_avmm                             ),
         .HipTxStEop_o                   (tx_st_eop_avmm                             ),
         .HipTxStEmpty_o                 (tx_st_empty_avmm                           ),
         .HipTxStValid_o                 (tx_st_valid_avmm                           ),
         .HipCplPending_o                (cpl_pending_avmm                           ),
         .AvRxmWrite_0_o                 (rxm_bar0_write_o                           ),
         .AvRxmAddress_0_o               (rxm_bar0_address_o                         ),
         .AvRxmWriteData_0_o             (rxm_bar0_writedata_o                       ),
         .AvRxmByteEnable_0_o            (rxm_bar0_byteenable_o                      ),
         .AvRxmBurstCount_0_o            (rxm_bar0_burstcount_o                      ),
         .AvRxmWaitRequest_0_i           (rxm_bar0_waitrequest_i                     ),
         .AvRxmRead_0_o                  (rxm_bar0_read_o                            ),
         .AvRxmReadData_0_i              (rxm_bar0_readdata_i                        ),
         .AvRxmReadDataValid_0_i         (rxm_bar0_readdatavalid_i                   ),
         .AvTxsWrite_i                   (txs_write_i                                ),
         .AvTxsAddress_i                 (txs_address_i                              ),
         .AvTxsWriteData_i               (txs_writedata_i                            ),
         .AvTxsByteEnable_i              (txs_byteenable_i                           ),
         .AvTxsWaitRequest_o             (txs_waitrequest_o                          ),
         .AvTxsRead_i                    (txs_read_i                                 ),
         .AvTxsReadData_o                (txs_readdata_o                             ),
         .AvTxsReadDataValid_o           (txs_readdatavalid_o                        ),
         .AvTxsChipSelect_i              (txs_chipselect_i                           ),
         .AvCraChipSelect_i              (cra_chipselect_i                           ),
         .AvCraRead_i                    (cra_read_i                                 ),
         .AvCraWrite_i                   (cra_write_i                                ),
         .AvCraWriteData_i               (cra_writedata_i                            ),
         .AvCraAddress_i                 (cra_address_i[13:0]                        ),
         .AvCraByteEnable_i              (cra_byteenable_i                           ),
         .AvCraReadData_o                (cra_readdata_o                             ),
         .AvCraWaitRequest_o             (cra_waitrequest_o                          ),
         .AvCraIrq_o                     (cra_irq_o                                  ), 
         .AvMsiIntfc_o                   (msi_intfc_o                                ),
         .AvMsixIntfc_o                  (msix_intfc_o                               ),
         .RxIntStatus_i                  (int_status                                 ),
         .HipCfgAddr_i                   (tl_cfg_add                                 ),
         .HipCfgCtl_i                    (tl_cfg_ctl                                 ),
         .TLCfgSts_i                     (tl_cfg_sts[46:31]                          ),
         .Ltssm_i                        ( ltssmstate_reg   ),
         .CurrentSpeed_i                 ( currentspeed ),
         .LaneAct_i                      ( lane_act     )
      );

      assign tx_cons_cred_sel_avmm = 1'b0;
    end
  end
endgenerate

// 256-bit DMA

wire dma_control_0_wrdcs_slave_0_chipselect;
wire dma_control_0_rddcs_slave_0_chipselect;
wire dma_control_0_wrdcs_slave_0_waitrequest;
wire dma_control_0_rddcs_slave_0_waitrequest;
wire [31:0] dma_control_0_wrdcs_slave_0_readdata;
wire [31:0] dma_control_0_rddcs_slave_0_readdata;
wire dma_control_0_wrdcs_slave_0_readdatavalid;
wire dma_control_0_rddcs_slave_0_readdatavalid;
wire dma_control_0_dcs_slave_0_write;
wire dma_control_0_dcs_slave_0_read;
wire dma_control_0_dcs_slave_0_readdatavalid;
wire [31:0] dma_control_0_dcs_slave_0_readdata;
wire [avmm_addr_width_hwtcl-1:0]dma_control_0_dcs_slave_0_address;
wire [31:0]                     dma_control_0_dcs_slave_0_writedata;
wire [(avmm_addr_width_hwtcl/8)-1:0] dma_control_0_dcs_slave_0_byteenable;
wire dma_control_0_dcs_slave_0_waitrequest;

wire [159:0] dma_control_0_rddma_tx_data;
wire dma_control_0_rddma_tx_valid;
wire dma_control_0_rddma_tx_ready;
wire [31:0] dut_rd_ast_tx_data;
wire dut_rd_ast_tx_valid;

wire [159:0] dma_control_0_wrdma_tx_data;
wire dma_control_0_wrdma_tx_valid;
wire dma_control_0_wrdma_tx_ready;
wire [31:0] dut_wr_ast_tx_data;
wire dut_wr_ast_tx_valid;

generate begin : g_dmacontrol
   if (internal_controller_hwtcl == 1 && interface_type_integer_hwtcl == 1 && include_dma_hwtcl == 1 && enable_ast_trs_hwtcl==0) begin : dmacontrol
      altpcie_rxm_2_dma_controller_decode # (
         .bar_type_hwtcl                    (avmm_addr_width_hwtcl)
      ) altpcie_rxm_2_dma_controller_decode (
         .rxm_address_i                     (dma_control_0_dcs_slave_0_address),
         .rxm_read_data_wr_ctrl_i           (dma_control_0_wrdcs_slave_0_readdata),
         .rxm_read_data_valid_wr_ctrl_i     (dma_control_0_wrdcs_slave_0_readdatavalid),
         .rxm_read_data_rd_ctrl_i           (dma_control_0_rddcs_slave_0_readdata),
         .rxm_read_data_valid_rd_ctrl_i     (dma_control_0_rddcs_slave_0_readdatavalid),
         .rxm_read_data_valid_o             (dma_control_0_dcs_slave_0_readdatavalid),
         .rxm_read_data_o                   (dma_control_0_dcs_slave_0_readdata),
         .rxm_wait_request_rd_ctrl_i        (dma_control_0_rddcs_slave_0_waitrequest),
         .rxm_wait_request_wr_ctrl_i        (dma_control_0_wrdcs_slave_0_waitrequest),
         .chip_select_rdctrl_o              (dma_control_0_rddcs_slave_0_chipselect),
         .chip_select_wrctrl_o              (dma_control_0_wrdcs_slave_0_chipselect),
         .rxm_wait_request_o                (dma_control_0_dcs_slave_0_waitrequest)
      );

      assign dma_control_0_wrdcs_slave_0_readdatavalid = ~dma_control_0_wrdcs_slave_0_waitrequest & dma_control_0_dcs_slave_0_read;
      assign dma_control_0_rddcs_slave_0_readdatavalid = ~dma_control_0_rddcs_slave_0_waitrequest & dma_control_0_dcs_slave_0_read;

      dma_control            # (
         .dma_use_scfifo_ext   (dma_use_scfifo_ext_hwtcl                   ),
         .DMA_WIDTH            (dma_width_hwtcl)
      ) dma_control_0          (
         //
         .Clk_i                (coreclkout_hip                           ),                              //        clock.clk
         .Rstn_i               (app_rstn[9]                              ),                              //       Resetn.reset_n
         .RdDCSChipSelect_i    (dma_control_0_rddcs_slave_0_chipselect   ),                              //  RdDCS_slave.chipsele
         .RdDCSWrite_i         (dma_control_0_dcs_slave_0_write          ),                              //             .write
         .RdDCSAddress_i       (dma_control_0_dcs_slave_0_address        ),                              //             .address
         .RdDCSWriteData_i     (dma_control_0_dcs_slave_0_writedata      ),                              //             .writedata
         .RdDCSByteEnable_i    (dma_control_0_dcs_slave_0_byteenable     ),                              //             .byteenable
         .RdDCSWaitRequest_o   (dma_control_0_rddcs_slave_0_waitrequest  ),                              //             .waitrequest
         .RdDCSReadData_o      (dma_control_0_rddcs_slave_0_readdata     ),                              //             .readdata
         .RdDCSRead_i          (dma_control_0_dcs_slave_0_read           ),
         //
         .RdDTSChipSelect_i    (rd_dts_chip_select_i                     ),                              //  RdDTS_slave.chipselect
         .RdDTSWrite_i         (rd_dts_write_i                           ),                              //             .write
         .RdDTSBurstCount_i    (rd_dts_burst_count_i                     ),                              //             .burstcount
         .RdDTSAddress_i       (rd_dts_address_i                         ),                              //             .address
         .RdDTSWriteData_i     (rd_dts_write_data_i                      ),                              //             .writedata
         .RdDTSWaitRequest_o   (rd_dts_wait_request_o                    ),                              //             .waitrequest
         //
         .RdDmaTxData_o        (dma_control_0_rddma_tx_data              ),                              //     RdDMA_Tx.data
         .RdDmaTxValid_o       (dma_control_0_rddma_tx_valid             ),                              //             .valid
         .RdDmaTxReady_i       (dma_control_0_rddma_tx_ready             ),                              //             .ready
         .RdDmaRxData_i        (dut_rd_ast_tx_data                       ),                              //     RdDMA_Rx.data
         .RdDmaRxValid_i       (dut_rd_ast_tx_valid                      ),                              //             .valid
         //
         .RdDCMAddress_o       (rd_dcm_address_o                         ),                              // RdDCM_Master.address
         .RdDCMWrite_o         (rd_dcm_write_o                           ),                              //             .write
         .RdDCMWriteData_o     (rd_dcm_writedata_o                       ),                              //             .writedata
         .RdDCMRead_o          (rd_dcm_read_o                            ),                              //             .read
         .RdDCMByteEnable_o    (rd_dcm_byte_enable_o                     ),                              //             .byteenable
         .RdDCMWaitRequest_i   (rd_dcm_wait_request_i                    ),                              //             .waitrequest
         .RdDCMReadData_i      (rd_dcm_read_data_i                       ),                              //             .readdata
         .RdDCMReadDataValid_i (rd_dcm_read_data_valid_i                 ),                              //             .readdatavalid
         //
         .WrDCSChipSelect_i    (dma_control_0_wrdcs_slave_0_chipselect   ),                              //  WrDCS_slave.chipselect
         .WrDCSWrite_i         (dma_control_0_dcs_slave_0_write          ),                              //             .write
         .WrDCSAddress_i       (dma_control_0_dcs_slave_0_address        ),                              //             .address
         .WrDCSWriteData_i     (dma_control_0_dcs_slave_0_writedata      ),                              //             .writedata
         .WrDCSByteEnable_i    (dma_control_0_dcs_slave_0_byteenable     ),                              //             .byteenable
         .WrDCSWaitRequest_o   (dma_control_0_wrdcs_slave_0_waitrequest  ),                              //             .waitrequest
         .WrDCSReadData_o      (dma_control_0_wrdcs_slave_0_readdata     ),                              //             .readdata
         .WrDCSRead_i          (dma_control_0_dcs_slave_0_read           ),
         //
         .WrDTSChipSelect_i    (wr_dts_chip_select_i                     ),                              //  WrDTS_slave.chipselect
         .WrDTSWrite_i         (wr_dts_write_i                           ),                              //             .write
         .WrDTSBurstCount_i    (wr_dts_burst_count_i                     ),                              //             .burstcount
         .WrDTSAddress_i       (wr_dts_address_i                         ),                              //             .address
         .WrDTSWriteData_i     (wr_dts_write_data_i                      ),                              //             .writedata
         .WrDTSWaitRequest_o   (wr_dts_wait_request_o                    ),                              //             .waitrequest
         //
         .WrDmaTxData_o        (dma_control_0_wrdma_tx_data              ),                              //     WrDMA_Tx.data
         .WrDmaTxValid_o       (dma_control_0_wrdma_tx_valid             ),                              //             .valid
         .WrDmaTxReady_i       (dma_control_0_wrdma_tx_ready             ),                              //             .ready
         .WrDmaRxData_i        (dut_wr_ast_tx_data                       ),                              //     WrDMA_Rx.data
         .WrDmaRxValid_i       (dut_wr_ast_tx_valid                      ),                              //             .valid
         //
         .WrDCMAddress_o       (wr_dcm_address_o                         ),                              // WrDCM_Master.address
         .WrDCMWrite_o         (wr_dcm_write_o                           ),                              //             .write
         .WrDCMWriteData_o     (wr_dcm_writedata_o                       ),                              //             .writedata
         .WrDCMRead_o          (wr_dcm_read_o                            ),                              //             .read
         .WrDCMByteEnable_o    (wr_dcm_byte_enable_o                     ),                              //             .byteenable
         .WrDCMWaitRequest_i   (wr_dcm_wait_request_i                    ),                              //             .waitrequest
         .WrDCMReadData_i      (wr_dcm_read_data_i                       ),                              //             .readdata
         .WrDCMReadDataValid_i (wr_dcm_read_data_valid_i                 ),                              //             .readdatavalid
         .MsiInterface_i       (msi_intfc_o                              )
      );
   end
end
endgenerate

generate begin: g_avmm_256_dma
   if (enable_ast_trs_hwtcl==0 && interface_type_integer_hwtcl == 1 & include_dma_hwtcl==1 & !(cb_pcie_mode_hwtcl == 1 && cb_pcie_rx_lite_hwtcl_local   == 1) ) begin : avmm_256_dma
         altpcieav_256_app                # (
            .DEVICE_FAMILY                  ("Arria 10"                                 ),
            .DMA_WIDTH                      (dma_width_hwtcl                            ),
            .DMA_BE_WIDTH                   (dma_be_width_hwtcl                         ),
            .DMA_BRST_CNT_W                 (dma_brst_cnt_w_hwtcl                       ),
            .RDDMA_AVL_ADDR_WIDTH           (64                                         ),
            .WRDMA_AVL_ADDR_WIDTH           (64                                         ),
            .BAR0_SIZE_MASK                 (avmm_bar0_size_mask                        ),
            .BAR1_SIZE_MASK                 (avmm_bar1_size_mask                        ),
            .BAR2_SIZE_MASK                 (avmm_bar2_size_mask                        ),
            .BAR3_SIZE_MASK                 (avmm_bar3_size_mask                        ),
            .BAR4_SIZE_MASK                 (avmm_bar4_size_mask                        ),
            .BAR5_SIZE_MASK                 (avmm_bar5_size_mask                        ),
            .BAR0_TYPE                      (avmm_bar0_type                             ),
            .BAR1_TYPE                      (avmm_bar1_type                             ),
            .BAR2_TYPE                      (avmm_bar2_type                             ),
            .BAR3_TYPE                      (avmm_bar3_type                             ),
            .BAR4_TYPE                      (avmm_bar4_type                             ),
            .BAR5_TYPE                      (avmm_bar5_type                             ),
            .TX_S_ADDR_WIDTH                (txs_addr_width_integer_hwtcl               ),
            .dma_use_scfifo_ext             (dma_use_scfifo_ext_hwtcl                   ),
            .WRDMA_VERSION_2                ((dma_width_hwtcl == 256)? 1 : 0            ),
            .EXTENDED_TAG_ENABLE            ((extended_tag_support_hwtcl== 1)? 1 : 0    ),
            .enable_rxm_burst_hwtcl         (enable_rxm_burst_hwtcl                     )
         ) altpcieav_256_app (
            .Clk_i                          (coreclkout_hip                             ),
            .Rstn_i                         (app_rstn[9:0]                                ),
            .HipRxStReady_o                 (rx_st_ready_avmm                           ),
            .HipRxStMask_o                  (rx_st_mask_avmm                            ),
            .HipRxStData_i                  (rx_st_data                                 ),
            .HipRxStBe_i                    (rx_st_be_int                               ),
            .HipRxStEmpty_i                 (rx_st_empty_int                            ),
            .HipRxStErr_i                   (rx_st_err                                  ),
            .HipRxStSop_i                   (rx_st_sop                                  ),
            .HipRxStEop_i                   (rx_st_eop                                  ),
            .HipRxStValid_i                 (rx_st_valid                                ),
            .HipRxStBarDec1_i               (rx_st_bar                                  ),
            .HipTxStReady_i                 (tx_st_ready                                ),
            .HipTxStData_o                  (tx_st_data_avmm_int                        ),
            .HipTxStSop_o                   (tx_st_sop_avmm                             ),
            .HipTxStEop_o                   (tx_st_eop_avmm                             ),
            .HipTxStEmpty_o                 (tx_st_empty_avmm                           ),
            .HipTxStValid_o                 (tx_st_valid_avmm                           ),
            .HipCplPending_o                (cpl_pending_avmm                           ),
            .AvWrDmaRead_o                  (wr_dma_read_o                              ),
            .AvWrDmaAddress_o               (wr_dma_address_o                           ),
            .AvWrDmaBurstCount_o            (wr_dma_burst_count_o                       ),
            .AvWrDmaWaitRequest_i           (wr_dma_wait_request_i                      ),
            .AvWrDmaReadDataValid_i         (wr_dma_read_data_valid_i                   ),
            .AvWrDmaReadData_i              (wr_dma_read_data_i                         ),
            .AvRdDmaWrite_o                 (rd_dma_write_o                             ),
            .AvRdDmaAddress_o               (rd_dma_address_o                           ),
            .AvRdDmaWriteData_o             (rd_dma_write_data_o                        ),
            .AvRdDmaBurstCount_o            (rd_dma_burst_count_o                       ),
            .AvRdDmaWriteEnable_o           (rd_dma_byte_enable_o                       ),
            .AvRdDmaWaitRequest_i           (rd_dma_wait_request_i                      ),
            .AvRxmWrite_0_o                 (dma_control_0_dcs_slave_0_write            ),
            .AvRxmAddress_0_o               (dma_control_0_dcs_slave_0_address          ),
            .AvRxmWriteData_0_o             (dma_control_0_dcs_slave_0_writedata        ),
            .AvRxmByteEnable_0_o            (dma_control_0_dcs_slave_0_byteenable       ),
            .AvRxmWaitRequest_0_i           (dma_control_0_dcs_slave_0_waitrequest      ),
            .AvRxmRead_0_o                  (dma_control_0_dcs_slave_0_read             ),
            .AvRxmReadData_0_i              (dma_control_0_dcs_slave_0_readdata         ),
            .AvRxmReadDataValid_0_i         (dma_control_0_dcs_slave_0_readdatavalid    ),
            .AvRxmWrite_1_o                 (rxm_bar1_write_o                           ),
            .AvRxmAddress_1_o               (rxm_bar1_address_o                         ),
            .AvRxmWriteData_1_o             (rxm_bar1_writedata_o                       ),
            .AvRxmByteEnable_1_o            (rxm_bar1_byteenable_o                      ),
            .AvRxmWaitRequest_1_i           (rxm_bar1_waitrequest_i                     ),
            .AvRxmRead_1_o                  (rxm_bar1_read_o                            ),
            .AvRxmReadData_1_i              (rxm_bar1_readdata_i                        ),
            .AvRxmReadDataValid_1_i         (rxm_bar1_readdatavalid_i                   ),
            .AvRxmWrite_2_o                 (rxm_bar2_write_o                           ),
            .AvRxmAddress_2_o               (rxm_bar2_address_o                         ),
            .AvRxmWriteData_2_o             (rxm_bar2_writedata_o                       ),
            .AvRxmByteEnable_2_o            (rxm_bar2_byteenable_o                      ),
            .AvRxmWaitRequest_2_i           (rxm_bar2_waitrequest_i                     ),
            .AvRxmRead_2_o                  (rxm_bar2_read_o                            ),
            .AvRxmReadData_2_i              (rxm_bar2_readdata_i                        ),
            .AvRxmReadDataValid_2_i         (rxm_bar2_readdatavalid_i                   ),
            .AvRxmWrite_3_o                 (rxm_bar3_write_o                           ),
            .AvRxmAddress_3_o               (rxm_bar3_address_o                         ),
            .AvRxmWriteData_3_o             (rxm_bar3_writedata_o                       ),
            .AvRxmByteEnable_3_o            (rxm_bar3_byteenable_o                      ),
            .AvRxmWaitRequest_3_i           (rxm_bar3_waitrequest_i                     ),
            .AvRxmRead_3_o                  (rxm_bar3_read_o                            ),
            .AvRxmReadData_3_i              (rxm_bar3_readdata_i                        ),
            .AvRxmReadDataValid_3_i         (rxm_bar3_readdatavalid_i                   ),
            .AvRxmWrite_4_o                 (rxm_bar4_write_o                           ),
            .AvRxmAddress_4_o               (rxm_bar4_address_o                         ),
            .AvRxmWriteData_4_o             (rxm_bar4_writedata_o                       ),
            .AvRxmByteEnable_4_o            (rxm_bar4_byteenable_o                      ),
            .AvRxmWaitRequest_4_i           (rxm_bar4_waitrequest_i                     ),
            .AvRxmRead_4_o                  (rxm_bar4_read_o                            ),
            .AvRxmReadData_4_i              (rxm_bar4_readdata_i                        ),
            .AvRxmReadDataValid_4_i         (rxm_bar4_readdatavalid_i                   ),
            .AvRxmWrite_5_o                 (rxm_bar5_write_o                           ),
            .AvRxmAddress_5_o               (rxm_bar5_address_o                         ),
            .AvRxmWriteData_5_o             (rxm_bar5_writedata_o                       ),
            .AvRxmByteEnable_5_o            (rxm_bar5_byteenable_o                      ),
            .AvRxmWaitRequest_5_i           (rxm_bar5_waitrequest_i                     ),
            .AvRxmRead_5_o                  (rxm_bar5_read_o                            ),
            .AvRxmReadData_5_i              (rxm_bar5_readdata_i                        ),
            .AvRxmReadDataValid_5_i         (rxm_bar5_readdatavalid_i                   ),
            .AvHPRxmWrite_o                 (hprxm_write_o                              ),
            .AvHPRxmAddress_o               (hprxm_address_o                            ),
            .AvHPRxmWriteData_o             (hprxm_writedata_o                          ),
            .AvHPRxmByteEnable_o            (hprxm_byteenable_o                         ),
            .AvHPRxmBurstCount_o            (hprxm_burstcount_o                         ),
            .AvHPRxmWaitRequest_i           (hprxm_waitrequest_i                        ),
            .AvHPRxmRead_o                  (hprxm_read_o                               ),
            .AvHPRxmReadData_i              (hprxm_readdata_i                           ),
            .AvHPRxmReadDataValid_i         (hprxm_readdatavalid_i                      ),
            .AvTxsWrite_i                   (txs_write_i                                ),
            .AvTxsAddress_i                 (txs_address_i                              ),
            .AvTxsWriteData_i               (txs_writedata_i                            ),
            .AvTxsByteEnable_i              (txs_byteenable_i                           ),
            .AvTxsWaitRequest_o             (txs_waitrequest_o                          ),
            .AvTxsRead_i                    (txs_read_i                                 ),
            .AvTxsReadData_o                (txs_readdata_o                             ),
            .AvTxsReadDataValid_o           (txs_readdatavalid_o                        ),
            .AvTxsChipSelect_i              (txs_chipselect_i                           ),
            .AvCraChipSelect_i              (cra_chipselect_i                           ),
            .AvCraRead_i                    (cra_read_i                                 ),
            .AvCraWrite_i                   (cra_write_i                                ),
            .AvCraWriteData_i               (cra_writedata_i                            ),
            .AvCraAddress_i                 (cra_address_i[9:0]                         ),
            .AvCraByteEnable_i              (cra_byteenable_i                           ),
            .AvCraReadData_o                (cra_readdata_o                             ),
            .AvCraWaitRequest_o             (cra_waitrequest_o                          ),
            .AvRdDmaRxReady_o               (dma_control_0_rddma_tx_ready               ),
            .AvRdDmaRxData_i                (dma_control_0_rddma_tx_data                ),
            .AvRdDmaRxValid_i               (dma_control_0_rddma_tx_valid               ),
            .AvRdDmaTxData_o                (dut_rd_ast_tx_data                         ),
            .AvRdDmaTxValid_o               (dut_rd_ast_tx_valid                        ),
            .AvWrDmaRxReady_o               (dma_control_0_wrdma_tx_ready               ),
            .AvWrDmaRxData_i                (dma_control_0_wrdma_tx_data                ),
            .AvWrDmaRxValid_i               (dma_control_0_wrdma_tx_valid               ),
            .AvWrDmaTxData_o                (dut_wr_ast_tx_data                         ),
            .AvWrDmaTxValid_o               (dut_wr_ast_tx_valid                        ),
            .AvMsiIntfc_o                   (msi_intfc_o                                ),
            .AvMsixIntfc_o                  (msix_intfc_o                               ),
            .Msi_control_o                  (msi_control_o                              ),
            .HipCfgAddr_i                   (tl_cfg_add                                 ),
            .HipCfgCtl_i                    (tl_cfg_ctl                                 ),
            .TLCfgSts_i                     (tl_cfg_sts[46:31]                          ),
            .Ltssm_i                        ( ltssmstate_reg   ),
            .CurrentSpeed_i                 ( currentspeed ),
            .LaneAct_i                      ( lane_act     ),
            .ko_cpl_spc_header              (ko_cpl_spc_header),
            .ko_cpl_spc_data                (ko_cpl_spc_data)

         );
         assign tx_cons_cred_sel_avmm = 1'b0;
    end
  end
endgenerate

generate begin: g_ast_trans
   if (enable_ast_trs_hwtcl == 1 & interface_type_integer_hwtcl==1 & !(cb_pcie_mode_hwtcl == 1 && cb_pcie_rx_lite_hwtcl_local   == 1) ) begin : tlp_trans
         altpcie_a10_hip_ast_translator     # (
            .DEVICE_FAMILY                  ("Arria 10"                                 ),
            .DMA_WIDTH                      (dma_width_hwtcl                            ),
            .DMA_BE_WIDTH                   (dma_be_width_hwtcl                         ),
            .DMA_BRST_CNT_W                 (dma_brst_cnt_w_hwtcl                       ),
            .RDDMA_AVL_ADDR_WIDTH           (64                                         ),
            .WRDMA_AVL_ADDR_WIDTH           (64                                         ),
            .BAR0_SIZE_MASK                 (avmm_bar0_size_mask                        ),
            .BAR1_SIZE_MASK                 (avmm_bar1_size_mask                        ),
            .BAR2_SIZE_MASK                 (avmm_bar2_size_mask                        ),
            .BAR3_SIZE_MASK                 (avmm_bar3_size_mask                        ),
            .BAR4_SIZE_MASK                 (avmm_bar4_size_mask                        ),
            .BAR5_SIZE_MASK                 (avmm_bar5_size_mask                        ),
            .BAR0_TYPE                      (avmm_bar0_type                             ),
            .BAR1_TYPE                      (avmm_bar1_type                             ),
            .BAR2_TYPE                      (avmm_bar2_type                             ),
            .BAR3_TYPE                      (avmm_bar3_type                             ),
            .BAR4_TYPE                      (avmm_bar4_type                             ),
            .BAR5_TYPE                      (avmm_bar5_type                             ),
            .TX_S_ADDR_WIDTH                (txs_addr_width_integer_hwtcl               ),
            .NUM_DESC                       (ast_trs_num_desc_hwtcl      ),
            .TXDATA_WIDTH                   (ast_trs_txdata_width_hwtcl  ),
            .TXDESC_WIDTH                   (ast_trs_txdesc_width_hwtcl  ),
            .TXSTATUS_WIDTH                 (ast_trs_txstatus_width_hwtcl),
            .RXDATA_WIDTH                   (ast_trs_rxdata_width_hwtcl  ),
            .RXDESC_WIDTH                   (ast_trs_rxdesc_width_hwtcl  ),
            .TXMTY_WIDTH                    (ast_trs_txmty_width_hwtcl   ),
            .RXMTY_WIDTH                    (ast_trs_rxmty_width_hwtcl   ),
            .dma_use_scfifo_ext             (dma_use_scfifo_ext_hwtcl                   ),
            .enable_rxm_burst_hwtcl         (enable_rxm_burst_hwtcl                     )
         ) altpcie_a10_hip_ast_translator (
            .Clk_i                          (coreclkout_hip                             ),
            .Rstn_i                         (app_rstn[9:0]                              ),
            .HipRxStReady_o                 (rx_st_ready_avmm                           ),
            .HipRxStMask_o                  (rx_st_mask_avmm                            ),
            .HipRxStData_i                  (rx_st_data                                 ),
            .HipRxStBe_i                    (rx_st_be_int                               ),
            .HipRxStEmpty_i                 (rx_st_empty_int                            ),
            .HipRxStErr_i                   (rx_st_err                                  ),
            .HipRxStSop_i                   (rx_st_sop                                  ),
            .HipRxStEop_i                   (rx_st_eop                                  ),
            .HipRxStValid_i                 (rx_st_valid                                ),
            .HipRxStBarDec1_i               (rx_st_bar                                  ),
            .HipTxStReady_i                 (tx_st_ready                                ),
            .HipTxStData_o                  (tx_st_data_avmm_int                        ),
            .HipTxStSop_o                   (tx_st_sop_avmm                             ),
            .HipTxStEop_o                   (tx_st_eop_avmm                             ),
            .HipTxStEmpty_o                 (tx_st_empty_avmm                           ),
            .HipTxStValid_o                 (tx_st_valid_avmm                           ),
            .HipCplPending_o                (cpl_pending_avmm                           ),
            .AvRxmWrite_0_o                 (dma_control_0_dcs_slave_0_write            ),
            .AvRxmAddress_0_o               (dma_control_0_dcs_slave_0_address          ),
            .AvRxmWriteData_0_o             (dma_control_0_dcs_slave_0_writedata        ),
            .AvRxmByteEnable_0_o            (dma_control_0_dcs_slave_0_byteenable       ),
            .AvRxmWaitRequest_0_i           (dma_control_0_dcs_slave_0_waitrequest      ),
            .AvRxmRead_0_o                  (dma_control_0_dcs_slave_0_read             ),
            .AvRxmReadData_0_i              (dma_control_0_dcs_slave_0_readdata         ),
            .AvRxmReadDataValid_0_i         (dma_control_0_dcs_slave_0_readdatavalid    ),
            .AvRxmWrite_1_o                 (rxm_bar1_write_o                           ),
            .AvRxmAddress_1_o               (rxm_bar1_address_o                         ),
            .AvRxmWriteData_1_o             (rxm_bar1_writedata_o                       ),
            .AvRxmByteEnable_1_o            (rxm_bar1_byteenable_o                      ),
            .AvRxmWaitRequest_1_i           (rxm_bar1_waitrequest_i                     ),
            .AvRxmRead_1_o                  (rxm_bar1_read_o                            ),
            .AvRxmReadData_1_i              (rxm_bar1_readdata_i                        ),
            .AvRxmReadDataValid_1_i         (rxm_bar1_readdatavalid_i                   ),
            .AvRxmWrite_2_o                 (rxm_bar2_write_o                           ),
            .AvRxmAddress_2_o               (rxm_bar2_address_o                         ),
            .AvRxmWriteData_2_o             (rxm_bar2_writedata_o                       ),
            .AvRxmByteEnable_2_o            (rxm_bar2_byteenable_o                      ),
            .AvRxmWaitRequest_2_i           (rxm_bar2_waitrequest_i                     ),
            .AvRxmRead_2_o                  (rxm_bar2_read_o                            ),
            .AvRxmReadData_2_i              (rxm_bar2_readdata_i                        ),
            .AvRxmReadDataValid_2_i         (rxm_bar2_readdatavalid_i                   ),
            .AvRxmWrite_3_o                 (rxm_bar3_write_o                           ),
            .AvRxmAddress_3_o               (rxm_bar3_address_o                         ),
            .AvRxmWriteData_3_o             (rxm_bar3_writedata_o                       ),
            .AvRxmByteEnable_3_o            (rxm_bar3_byteenable_o                      ),
            .AvRxmWaitRequest_3_i           (rxm_bar3_waitrequest_i                     ),
            .AvRxmRead_3_o                  (rxm_bar3_read_o                            ),
            .AvRxmReadData_3_i              (rxm_bar3_readdata_i                        ),
            .AvRxmReadDataValid_3_i         (rxm_bar3_readdatavalid_i                   ),
            .AvRxmWrite_4_o                 (rxm_bar4_write_o                           ),
            .AvRxmAddress_4_o               (rxm_bar4_address_o                         ),
            .AvRxmWriteData_4_o             (rxm_bar4_writedata_o                       ),
            .AvRxmByteEnable_4_o            (rxm_bar4_byteenable_o                      ),
            .AvRxmWaitRequest_4_i           (rxm_bar4_waitrequest_i                     ),
            .AvRxmRead_4_o                  (rxm_bar4_read_o                            ),
            .AvRxmReadData_4_i              (rxm_bar4_readdata_i                        ),
            .AvRxmReadDataValid_4_i         (rxm_bar4_readdatavalid_i                   ),
            .AvRxmWrite_5_o                 (rxm_bar5_write_o                           ),
            .AvRxmAddress_5_o               (rxm_bar5_address_o                         ),
            .AvRxmWriteData_5_o             (rxm_bar5_writedata_o                       ),
            .AvRxmByteEnable_5_o            (rxm_bar5_byteenable_o                      ),
            .AvRxmWaitRequest_5_i           (rxm_bar5_waitrequest_i                     ),
            .AvRxmRead_5_o                  (rxm_bar5_read_o                            ),
            .AvRxmReadData_5_i              (rxm_bar5_readdata_i                        ),
            .AvRxmReadDataValid_5_i         (rxm_bar5_readdatavalid_i                   ),
            .AvTxsWrite_i                   (txs_write_i                                ),
            .AvTxsAddress_i                 (txs_address_i                              ),
            .AvTxsWriteData_i               (txs_writedata_i                            ),
            .AvTxsByteEnable_i              (txs_byteenable_i                           ),
            .AvTxsWaitRequest_o             (txs_waitrequest_o                          ),
            .AvTxsRead_i                    (txs_read_i                                 ),
            .AvTxsReadData_o                (txs_readdata_o                             ),
            .AvTxsReadDataValid_o           (txs_readdatavalid_o                        ),
            .AvTxsChipSelect_i              (txs_chipselect_i                           ),
            .AvCraChipSelect_i              (cra_chipselect_i                           ),
            .AvCraRead_i                    (cra_read_i                                 ),
            .AvCraWrite_i                   (cra_write_i                                ),
            .AvCraWriteData_i               (cra_writedata_i                            ),
            .AvCraAddress_i                 (cra_address_i[9:0]                         ),
            .AvCraByteEnable_i              (cra_byteenable_i                           ),
            .AvCraReadData_o                (cra_readdata_o                             ),
            .AvCraWaitRequest_o             (cra_waitrequest_o                          ),
            .AvMsiIntfc_o                   (msi_intfc_o                                ),
            .AvMsixIntfc_o                  (msix_intfc_o                               ),
            .HipCfgAddr_i                   (tl_cfg_add                                 ),
            .HipCfgCtl_i                    (tl_cfg_ctl                                 ),
            .TLCfgSts_i                     (tl_cfg_sts[46:31]                          ),
            .TxData_rdy_o                   (TxData_rdy_o                               ),
            .TxData_val_i                   (TxData_val_i                               ),
            .TxData_sop_i                   (TxData_sop_i                               ),
            .TxData_eop_i                   (TxData_eop_i                               ),
            .TxData_err_i                   (TxData_err_i                               ),
            .TxData_dat_i                   (TxData_dat_i                               ),
            .TxData_sty_i                   (TxData_sty_i                               ),
            .TxData_mty_i                   (TxData_mty_i                               ),
            .TxData_dsc_i                   (TxData_dsc_i                               ),
            .TxStatus_val_o                 (TxStatus_val_o                             ),
            .TxStatus_dat_o                 (TxStatus_dat_o                             ),
            .RxData_rdy_i                   (RxData_rdy_i                               ),
            .RxData_val_o                   (RxData_val_o                               ),
            .RxData_sop_o                   (RxData_sop_o                               ),
            .RxData_eop_o                   (RxData_eop_o                               ),
            .RxData_err_o                   (RxData_err_o                               ),
            .RxData_dat_o                   (RxData_dat_o                               ),
            .RxData_sty_o                   (RxData_sty_o                               ),
            .RxData_mty_o                   (RxData_mty_o                               ),
            .RxData_dsc_o                   (RxData_dsc_o                               ),
            .Ltssm_i                        ( ltssmstate_reg   ),
            .CurrentSpeed_i                 ( currentspeed ),
            .LaneAct_i                      ( lane_act     )
         );
         assign wr_dma_burst_count_o                 = ZEROS[burst_count_integer_hwtcl-1:0]                         ;
         assign rd_dma_write_o                       = ZEROS[0]                                                     ;
         assign rd_dma_write_data_o                  = ZEROS[data_width_integer_hwtcl-1:0]                          ;
         assign rd_dma_burst_count_o                 = ZEROS[burst_count_integer_hwtcl-1:0]                         ;
         assign rd_dma_byte_enable_o                 = ZEROS[data_byte_width_integer_hwtcl-1:0]                     ;
         assign wr_dma_address_o                     = ZEROS[avmm_addr_width_hwtcl-1:0]                             ;
         assign wr_dma_read_o                        = ZEROS[0]                                                     ;
         assign hprxm_write_o                        = ZEROS[0]                                                     ;
         assign hprxm_address_o                      = ZEROS[avmm_addr_width_hwtcl-1:0]                             ;
         assign hprxm_writedata_o                    = ZEROS[data_width_integer_hwtcl-1:0]                          ;
         assign hprxm_byteenable_o                   = ZEROS[(data_width_integer_hwtcl/8)-1:0]                      ;
         assign hprxm_burstcount_o                   = ZEROS[burst_count_integer_hwtcl-1:0]                         ;
         assign hprxm_read_o                         = ZEROS[0]                                                     ;
         assign tx_cons_cred_sel_avmm                = 1'b0;
    end
  end
endgenerate

generate begin : g_avmm_rs_hip
   if (interface_type_integer_hwtcl == 1) begin : avmm_rs_hip

       always @(posedge coreclkout_hip or negedge app_rstn[1])
       begin
          if (~app_rstn[1]) begin
             ltssmstate_reg0 <= 2'b00;
             ltssmstate_reg1 <= 2'b00;
             ltssmstate_reg2 <= 2'b00;
             ltssmstate_reg3 <= 2'b00;
             ltssmstate_reg4 <= 2'b00;
          end
          else begin
             ltssmstate_reg0[0] <= ltssmstate[0];
             ltssmstate_reg0[1] <= ltssmstate_reg0[0];

             ltssmstate_reg1[0] <= ltssmstate[1];
             ltssmstate_reg1[1] <= ltssmstate_reg1[0];

             ltssmstate_reg2[0] <= ltssmstate[2];
             ltssmstate_reg2[1] <= ltssmstate_reg2[0];

             ltssmstate_reg3[0] <= ltssmstate[3];
             ltssmstate_reg3[1] <= ltssmstate_reg3[0];

             ltssmstate_reg4[0] <= ltssmstate[4];
             ltssmstate_reg4[1] <= ltssmstate_reg4[0];
          end
       end

       assign ltssmstate_reg[4:0] = {ltssmstate_reg4[1], ltssmstate_reg3[1], ltssmstate_reg2[1], ltssmstate_reg1[1], ltssmstate_reg0[1]};

      assign app_nreset_status = app_rstn[0];
    end
  end
endgenerate

//=====================================
// SR-IOV Instance
//=====================================
// Derived local parameters which do not change
localparam msi_64bit_addressing_capable_hwtcl      = (msi_64bit_addressing_capable == "true");
localparam max_payload_size_hwtcl                  = (max_payload_size == "payload_128")  ? 128  :
                                                     (max_payload_size == "payload_256")  ? 256  :
                                                     (max_payload_size == "payload_512")  ? 512  :
                                                     (max_payload_size == "payload_1024") ? 1024 :
                                                     (max_payload_size == "payload_2048") ? 2048 : 128;

localparam use_ast_parity                          = (rx_ast_parity == "enable")  || (tx_ast_parity =="enable");
localparam lane_rate_sriov2                        = (lane_rate == "gen3") ? "Gen3" : (lane_rate == "gen2") ? "Gen2" : "Gen1";

generate begin: g_sriov

  if (include_sriov_hwtcl==1 && sriov2_en==0) begin : sriov
      altera_pcie_sriov_bridge                #(
         .port_width_data_hwtcl                (data_width_integer_hwtcl                     ),
         .port_width_be_hwtcl                  (data_byte_width_integer_hwtcl                ),
         .multiple_packets_per_cycle_hwtcl     (1'b0                                         ),
         .gen123_lane_rate_mode_hwtcl          (lane_rate_hwtcl                              ),
         .lane_mask_hwtcl                      (link_width                                   ),
         .pll_refclk_freq_hwtcl                (pll_refclk_freq                              ),
         .use_ast_parity                       (use_ast_parity                               ),
         .ARI_SUPPORT                          (ari_support_hwtcl                            ),
         .SR_IOV_SUPPORT                       (sr_iov_support_hwtcl                         ),
         .TOTAL_PF_COUNT                       (total_pf_count_hwtcl                         ),
         .TOTAL_VF_COUNT                       (total_vf_count_hwtcl                         ),
         .PF0_VF_COUNT                         (pf0_vf_count_hwtcl                           ),
         .PF1_VF_COUNT                         (pf1_vf_count_hwtcl                           ),
         .SIG_TEST_EN                          (1'b1                                         ),
         .DROP_POISONED_REQ                    (drop_poisoned_req_hwtcl                      ),
         .DROP_POISONED_COMPL                  (drop_poisoned_compl_hwtcl                    ),
         .slotclkcfg_hwtcl                     (slot_clock_cfg_hwtcl                         ),
         .pf0_vendor_id_hwtcl                  (vendor_id                                    ),
         .pf1_vendor_id_hwtcl                  (pf1_vendor_id_hwtcl                          ),
         .pf0_device_id_hwtcl                  (device_id                                    ),
         .pf1_device_id_hwtcl                  (pf1_device_id_hwtcl                          ),
         .pf0_revision_id_hwtcl                (revision_id                                  ),
         .pf1_revision_id_hwtcl                (pf1_revision_id_hwtcl                        ),
         .pf0_class_code_hwtcl                 (class_code                                   ),
         .pf1_class_code_hwtcl                 (pf1_class_code_hwtcl                         ),
         .pf0_subsystem_vendor_id_hwtcl        (subsystem_vendor_id                          ),
         .pf1_subsystem_vendor_id_hwtcl        (pf1_subsystem_vendor_id_hwtcl                ),
         .pf0_subsystem_device_id_hwtcl        (subsystem_device_id                          ),
         .pf1_subsystem_device_id_hwtcl        (pf1_subsystem_device_id_hwtcl                ),
         .no_soft_reset_hwtcl                  (no_soft_reset                                ),
         .use_aer_hwtcl                        (1'b1                                         ),
         .max_payload_size_hwtcl               (max_payload_size_hwtcl                       ),
         .surprise_down_error_support_hwtcl    (surprise_down_error_support_hwtcl            ),
         .extend_tag_field_hwtcl               (extend_tag_field                             ),
         .endpoint_l0_latency_hwtcl            (endpoint_l0_latency                          ),
         .endpoint_l1_latency_hwtcl            (endpoint_l1_latency                          ),
         .enable_l0s_aspm_hwtcl                (enable_l0s_aspm                              ),
         .enable_l1_aspm_hwtcl                 (enable_l1_aspm                               ),
         .l1_exit_latency_sameclock_hwtcl      (l1_exit_latency_sameclock                    ),
         .completion_timeout_hwtcl             (completion_timeout                           ),
         .enable_completion_timeout_disable_hwtcl (enable_completion_timeout_disable_hwtcl   ),
         .pf0_msi_multi_message_capable_hwtcl  (pf0_msi_multi_message_capable_hwtcl          ),
         .pf1_msi_multi_message_capable_hwtcl  (pf1_msi_multi_message_capable_hwtcl          ),
         .msi_64bit_addressing_capable_hwtcl   (msi_64bit_addressing_capable_hwtcl           ),
         .msi_support_hwtcl                    (pf_msi_support_hwtcl                         ),
         .pf0_interrupt_pin_hwtcl              (pf0_interrupt_pin_hwtcl                      ),
         .pf1_interrupt_pin_hwtcl              (pf1_interrupt_pin_hwtcl                      ),
         .enable_function_msix_support_hwtcl   (pf_enable_function_msix_support_hwtcl        ),
         .pf0_msix_table_size_hwtcl            (pf0_msix_table_size_hwtcl                    ),
         .pf1_msix_table_size_hwtcl            (pf1_msix_table_size_hwtcl                    ),
         .pf0_msix_table_bir_hwtcl             (pf0_msix_table_bir_hwtcl                     ),
         .pf1_msix_table_bir_hwtcl             (pf1_msix_table_bir_hwtcl                     ),
         .pf0_msix_table_offset_hwtcl          (pf0_msix_table_offset_hwtcl                  ),
         .pf1_msix_table_offset_hwtcl          (pf1_msix_table_offset_hwtcl                  ),
         .pf0_msix_pba_bir_hwtcl               (pf0_msix_pba_bir_hwtcl                       ),
         .pf1_msix_pba_bir_hwtcl               (pf1_msix_pba_bir_hwtcl                       ),
         .pf0_msix_pba_offset_hwtcl            (pf0_msix_pba_offset_hwtcl                    ),
         .pf1_msix_pba_offset_hwtcl            (pf1_msix_pba_offset_hwtcl                    ),
         .l0_exit_latency_sameclock_hwtcl      (l0_exit_latency_sameclock                    ),
         .flr_capability_hwtcl                 (flr_capability_hwtcl                         ),
         .PF0_SUBCLASS_CODE                    (pf0_subclass_code_hwtcl                      ),
         .PF1_SUBCLASS_CODE                    (pf1_subclass_code_hwtcl                      ),
         .PF0_PCI_PROG_INTFC_BYTE              (pf0_pci_prog_intfc_byte_hwtcl                ),
         .PF1_PCI_PROG_INTFC_BYTE              (pf1_pci_prog_intfc_byte_hwtcl                ),
         .PF0_VF_DEVICE_ID                     (pf0_vf_device_id_hwtcl                       ),
         .PF1_VF_DEVICE_ID                     (pf1_vf_device_id_hwtcl                       ),
         .VF_MSIX_CAP_PRESENT                  (vf_msix_cap_present_hwtcl                    ),
         .PF0_VF_MSIX_TBL_SIZE                 (pf0_vf_msix_tbl_size_hwtcl                   ),
         .PF0_VF_MSIX_TBL_OFFSET               (pf0_vf_msix_tbl_offset_hwtcl                 ),
         .PF0_VF_MSIX_TBL_BIR                  (pf0_vf_msix_tbl_bir_hwtcl                    ),
         .PF0_VF_MSIX_PBA_OFFSET               (pf0_vf_msix_pba_offset_hwtcl                 ),
         .PF0_VF_MSIX_PBA_BIR                  (pf0_vf_msix_pba_bir_hwtcl                    ),
         .PF1_VF_MSIX_TBL_SIZE                 (pf1_vf_msix_tbl_size_hwtcl                   ),
         .PF1_VF_MSIX_TBL_OFFSET               (pf1_vf_msix_tbl_offset_hwtcl                 ),
         .PF1_VF_MSIX_TBL_BIR                  (pf1_vf_msix_tbl_bir_hwtcl                    ),
         .PF1_VF_MSIX_PBA_OFFSET               (pf1_vf_msix_pba_offset_hwtcl                 ),
         .PF1_VF_MSIX_PBA_BIR                  (pf1_vf_msix_pba_bir_hwtcl                    ),
         .RELAXED_ORDER_SUPPORT                (relaxed_order_support_hwtcl                  ),
         .SYSTEM_PAGE_SIZES_SUPPORTED          (system_page_sizes_supported_hwtcl            ),
         .LOG_VF_ERRORS_IN_PF                  (log_vf_errors_in_pf_hwtcl                    ),
         .PF0_INTR_LINE                        (pf0_intr_line_hwtcl                          ),
         .PF1_INTR_LINE                        (pf1_intr_line_hwtcl                          ),
         // PF bar_hwtcl parameters
         .PF0_BAR0_PRESENT                    (pf0_bar0_present_hwtcl                       ),
         .PF1_BAR0_PRESENT                    (pf1_bar0_present_hwtcl                       ),
         .PF0_BAR1_PRESENT                    (pf0_bar1_present_hwtcl                       ),
         .PF1_BAR1_PRESENT                    (pf1_bar1_present_hwtcl                       ),
         .PF0_BAR2_PRESENT                    (pf0_bar2_present_hwtcl                       ),
         .PF1_BAR2_PRESENT                    (pf1_bar2_present_hwtcl                       ),
         .PF0_BAR3_PRESENT                    (pf0_bar3_present_hwtcl                       ),
         .PF1_BAR3_PRESENT                    (pf1_bar3_present_hwtcl                       ),
         .PF0_BAR4_PRESENT                    (pf0_bar4_present_hwtcl                       ),
         .PF1_BAR4_PRESENT                    (pf1_bar4_present_hwtcl                       ),
         .PF0_BAR5_PRESENT                    (pf0_bar5_present_hwtcl                       ),
         .PF1_BAR5_PRESENT                    (pf1_bar5_present_hwtcl                       ),
         .PF0_BAR0_TYPE                       (pf0_bar0_type_hwtcl                          ),
         .PF1_BAR0_TYPE                       (pf1_bar0_type_hwtcl                          ),
         .PF0_BAR2_TYPE                       (pf0_bar2_type_hwtcl                          ),
         .PF1_BAR2_TYPE                       (pf1_bar2_type_hwtcl                          ),
         .PF0_BAR4_TYPE                       (pf0_bar4_type_hwtcl                          ),
         .PF1_BAR4_TYPE                       (pf1_bar4_type_hwtcl                          ),
         .PF0_BAR0_PREFETCHABLE               (pf0_bar0_prefetchable_hwtcl                  ),
         .PF1_BAR0_PREFETCHABLE               (pf1_bar0_prefetchable_hwtcl                  ),
         .PF0_BAR1_PREFETCHABLE               (pf0_bar1_prefetchable_hwtcl                  ),
         .PF1_BAR1_PREFETCHABLE               (pf1_bar1_prefetchable_hwtcl                  ),
         .PF0_BAR2_PREFETCHABLE               (pf0_bar2_prefetchable_hwtcl                  ),
         .PF1_BAR2_PREFETCHABLE               (pf1_bar2_prefetchable_hwtcl                  ),
         .PF0_BAR3_PREFETCHABLE               (pf0_bar3_prefetchable_hwtcl                  ),
         .PF1_BAR3_PREFETCHABLE               (pf1_bar3_prefetchable_hwtcl                  ),
         .PF0_BAR4_PREFETCHABLE               (pf0_bar4_prefetchable_hwtcl                  ),
         .PF1_BAR4_PREFETCHABLE               (pf1_bar4_prefetchable_hwtcl                  ),
         .PF0_BAR5_PREFETCHABLE               (pf0_bar5_prefetchable_hwtcl                  ),
         .PF1_BAR5_PREFETCHABLE               (pf1_bar5_prefetchable_hwtcl                  ),
         .PF0_BAR0_SIZE                       (pf0_bar0_size_hwtcl                          ),
         .PF1_BAR0_SIZE                       (pf1_bar0_size_hwtcl                          ),
         .PF0_BAR1_SIZE                       (pf0_bar1_size_hwtcl                          ),
         .PF1_BAR1_SIZE                       (pf1_bar1_size_hwtcl                          ),
         .PF0_BAR2_SIZE                       (pf0_bar2_size_hwtcl                          ),
         .PF1_BAR2_SIZE                       (pf1_bar2_size_hwtcl                          ),
         .PF0_BAR3_SIZE                       (pf0_bar3_size_hwtcl                          ),
         .PF1_BAR3_SIZE                       (pf1_bar3_size_hwtcl                          ),
         .PF0_BAR4_SIZE                       (pf0_bar4_size_hwtcl                          ),
         .PF1_BAR4_SIZE                       (pf1_bar4_size_hwtcl                          ),
         .PF0_BAR5_SIZE                       (pf0_bar5_size_hwtcl                          ),
         .PF1_BAR5_SIZE                       (pf1_bar5_size_hwtcl                          ),
         // VF bar_hwtcl parameters
         .PF0_VF_BAR0_PRESENT                 (pf0_vf_bar0_present_hwtcl                    ),
         .PF1_VF_BAR0_PRESENT                 (pf1_vf_bar0_present_hwtcl                    ),
         .PF0_VF_BAR1_PRESENT                 (pf0_vf_bar1_present_hwtcl                    ),
         .PF1_VF_BAR1_PRESENT                 (pf1_vf_bar1_present_hwtcl                    ),
         .PF0_VF_BAR2_PRESENT                 (pf0_vf_bar2_present_hwtcl                    ),
         .PF1_VF_BAR2_PRESENT                 (pf1_vf_bar2_present_hwtcl                    ),
         .PF0_VF_BAR3_PRESENT                 (pf0_vf_bar3_present_hwtcl                    ),
         .PF1_VF_BAR3_PRESENT                 (pf1_vf_bar3_present_hwtcl                    ),
         .PF0_VF_BAR4_PRESENT                 (pf0_vf_bar4_present_hwtcl                    ),
         .PF1_VF_BAR4_PRESENT                 (pf1_vf_bar4_present_hwtcl                    ),
         .PF0_VF_BAR5_PRESENT                 (pf0_vf_bar5_present_hwtcl                    ),
         .PF1_VF_BAR5_PRESENT                 (pf1_vf_bar5_present_hwtcl                    ),
         .PF0_VF_BAR0_TYPE                    (pf0_vf_bar0_type_hwtcl                       ),
         .PF1_VF_BAR0_TYPE                    (pf1_vf_bar0_type_hwtcl                       ),
         .PF0_VF_BAR2_TYPE                    (pf0_vf_bar2_type_hwtcl                       ),
         .PF1_VF_BAR2_TYPE                    (pf1_vf_bar2_type_hwtcl                       ),
         .PF0_VF_BAR4_TYPE                    (pf0_vf_bar4_type_hwtcl                       ),
         .PF1_VF_BAR4_TYPE                    (pf1_vf_bar4_type_hwtcl                       ),
         .PF0_VF_BAR0_PREFETCHABLE            (pf0_vf_bar0_prefetchable_hwtcl               ),
         .PF1_VF_BAR0_PREFETCHABLE            (pf1_vf_bar0_prefetchable_hwtcl               ),
         .PF0_VF_BAR1_PREFETCHABLE            (pf0_vf_bar1_prefetchable_hwtcl               ),
         .PF1_VF_BAR1_PREFETCHABLE            (pf1_vf_bar1_prefetchable_hwtcl               ),
         .PF0_VF_BAR2_PREFETCHABLE            (pf0_vf_bar2_prefetchable_hwtcl               ),
         .PF1_VF_BAR2_PREFETCHABLE            (pf1_vf_bar2_prefetchable_hwtcl               ),
         .PF0_VF_BAR3_PREFETCHABLE            (pf0_vf_bar3_prefetchable_hwtcl               ),
         .PF1_VF_BAR3_PREFETCHABLE            (pf1_vf_bar3_prefetchable_hwtcl               ),
         .PF0_VF_BAR4_PREFETCHABLE            (pf0_vf_bar4_prefetchable_hwtcl               ),
         .PF1_VF_BAR4_PREFETCHABLE            (pf1_vf_bar4_prefetchable_hwtcl               ),
         .PF0_VF_BAR5_PREFETCHABLE            (pf0_vf_bar5_prefetchable_hwtcl               ),
         .PF1_VF_BAR5_PREFETCHABLE            (pf1_vf_bar5_prefetchable_hwtcl               ),
         .PF0_VF_BAR0_SIZE                    (pf0_vf_bar0_size_hwtcl                       ),
         .PF1_VF_BAR0_SIZE                    (pf1_vf_bar0_size_hwtcl                       ),
         .PF0_VF_BAR1_SIZE                    (pf0_vf_bar1_size_hwtcl                       ),
         .PF1_VF_BAR1_SIZE                    (pf1_vf_bar1_size_hwtcl                       ),
         .PF0_VF_BAR2_SIZE                    (pf0_vf_bar2_size_hwtcl                       ),
         .PF1_VF_BAR2_SIZE                    (pf1_vf_bar2_size_hwtcl                       ),
         .PF0_VF_BAR3_SIZE                    (pf0_vf_bar3_size_hwtcl                       ),
         .PF1_VF_BAR3_SIZE                    (pf1_vf_bar3_size_hwtcl                       ),
         .PF0_VF_BAR4_SIZE                    (pf0_vf_bar4_size_hwtcl                       ),
         .PF1_VF_BAR4_SIZE                    (pf1_vf_bar4_size_hwtcl                       ),
         .PF0_VF_BAR5_SIZE                    (pf0_vf_bar5_size_hwtcl                       ),
         .PF1_VF_BAR5_SIZE                    (pf1_vf_bar5_size_hwtcl                       )
      ) sriov_bridge (
         .pld_clk                    (pld_clk_source                                        ),
         .power_on_reset_n           (app_rstn[0]                                           ),
         .testin_zero                (testin_zero                                           ),
         .reset_status               (~app_rstn[3]                                          ),
         .pld_clk_inuse              (pld_clk_inuse                                         ),
         .rx_st_sop_hip              (rx_st_sop_hip                                         ),
         .rx_st_eop_hip              (rx_st_eop_hip                                         ),
         .rx_st_err_hip              (rx_st_error_hip                                       ),
         .rx_st_valid_hip            (rx_st_valid_hip                                       ),
         .rx_st_empty_hip            (rx_st_empty_hip                                       ),
         .rx_st_ready_hip            (rx_st_ready_hip                                       ),
         .rx_st_data_hip             (rx_st_data_hip                                        ),
         .rx_st_parity_hip           (rx_st_parity_hip                                      ),
         .rx_st_mask_hip             (rx_st_mask_hip                                        ),
         .rxfc_cplbuf_ovf_hip        (rxfc_cplbuf_ovf                                       ),
         .rx_st_sop_app              (rx_st_sop_app                                         ),
         .rx_st_eop_app              (rx_st_eop_app                                         ),
         .rx_st_err_app              (rx_st_err_app                                         ),
         .rx_st_valid_app            (rx_st_valid_app                                       ),
         .rx_st_empty_app            (rx_st_empty_app                                       ),
         .rx_st_ready_app            (rx_st_ready                                           ),
         .rx_st_data_app             (rx_st_data_app                                        ),
         .rx_st_parity_app           (rx_st_parity_app                                      ),
         .rx_st_mask_app             (rx_st_mask                                            ),
         .rx_st_bar_hit_tlp0         (rx_st_bar_hit_tlp0                                    ),
         .rx_st_bar_hit_fn_tlp0      (rx_st_bar_hit_fn_tlp0                                 ),
         .rx_st_bar_hit_tlp1         (rx_st_bar_hit_tlp1                                    ),
         .rx_st_bar_hit_fn_tlp1      (rx_st_bar_hit_fn_tlp1                                 ),
         .tx_st_sop_hip              (tx_st_sop_hip                                         ),
         .tx_st_eop_hip              (tx_st_eop_hip                                         ),
         .tx_st_err_hip              (tx_st_error_hip                                       ),
         .tx_st_valid_hip            (tx_st_valid_hip                                       ),
         .tx_st_empty_hip            (tx_st_empty_hip                                       ),
         .tx_st_ready_hip            (tx_st_ready_hip                                       ),
         .tx_st_data_hip             (tx_st_data_hip                                        ),
         .tx_st_parity_hip           (tx_st_parity_hip                                      ),
         .tx_st_sop_app              (tx_st_sop                                             ),
         .tx_st_eop_app              (tx_st_eop                                             ),
         .tx_st_err_app              (tx_st_err                                             ),
         .tx_st_valid_app            (tx_st_valid                                           ),
         .tx_st_empty_app            (tx_st_empty_app                                       ),
         .tx_st_ready_app            (tx_st_ready_app                                       ),
         .tx_st_data_app             (tx_st_data                                            ),
         .tx_st_parity_app           (tx_st_parity                                          ),
         //LMI interface
         .lmi_addr_hip               (lmi_addr_pld                                          ),
         .lmi_din_hip                (lmi_din_pld                                           ),
         .lmi_rden_hip               (lmi_rden_pld                                          ),
         .lmi_wren_hip               (lmi_wren_pld                                          ),
         .lmi_ack_hip                (lmi_ack_pld                                           ),
         .lmi_dout_hip               (lmi_dout_pld                                          ),
         .lmi_addr_app               (lmi_addr                                              ),
         .lmi_func_app               (lmi_func                                              ),
         .lmi_din_app                (lmi_din                                               ),
         .lmi_rden_app               (lmi_rden                                              ),
         .lmi_wren_app               (lmi_wren                                              ),
         .lmi_ack_app                (lmi_ack_app                                           ),
         .lmi_dout_app               (lmi_dout_app                                          ),
         // status from HIP
         .derr_cor_ext_rcv           (derr_cor_ext_rcv                                      ), //           hip_status.derr_cor_ext_rcv
         .derr_cor_ext_rpl           (derr_cor_ext_rpl                                      ), //                     .derr_cor_ext_rpl
         .derr_rpl                   (derr_rpl                                              ), //                     .derr_rpl
         .dlup_exit                  (dlup_exit                                             ), //                     .dlup_exit
         .ev128ns                    (ev128ns                                               ), //                     .ev128ns
         .ev1us                      (ev1us                                                 ), //                     .ev1us
         .hotrst_exit                (hotrst_exit                                           ), //                     .hotrst_exit
         .int_status                 (int_status                                            ), //                     .int_status
         .l2_exit                    (l2_exit                                               ), //                     .l2_exit
         .lane_act                   (lane_act                                              ), //                     .lane_act
         .ltssmstate                 (ltssmstate                                            ), //                     .ltssmstate
         .dlup                       (dlup                                                  ), //                     .dlup
         .rx_par_err                 (rx_par_err                                            ), //                     .rx_par_err
         .tx_par_err                 (tx_par_err                                            ), //                     .tx_par_err
         .cfg_par_err                (cfg_par_err                                           ), //                     .cfg_par_err
         .ko_cpl_spc_header          (ko_cpl_spc_header                                     ), //                     .ko_cpl_spc_header
         .ko_cpl_spc_data            (ko_cpl_spc_data                                       ), //                     .ko_cpl_spc_data
         //ouptuts
         .derr_cor_ext_rcv_drv       (                                                      ), // UNUSED BRIDGE STATUS OUTPUTS
         .derr_cor_ext_rpl_drv       (                                                      ), // UNUSED BRIDGE STATUS OUTPUTS
         .derr_rpl_drv               (                                                      ), // UNUSED BRIDGE STATUS OUTPUTS
         .dlup_exit_drv              (                                                      ), // UNUSED BRIDGE STATUS OUTPUTS
         .ev128ns_drv                (                                                      ), // UNUSED BRIDGE STATUS OUTPUTS
         .ev1us_drv                  (                                                      ), // UNUSED BRIDGE STATUS OUTPUTS
         .hotrst_exit_drv            (                                                      ), // UNUSED BRIDGE STATUS OUTPUTS
         .int_status_drv             (                                                      ), // UNUSED BRIDGE STATUS OUTPUTS
         .l2_exit_drv                (                                                      ), // UNUSED BRIDGE STATUS OUTPUTS
         .lane_act_drv               (                                                      ), // UNUSED BRIDGE STATUS OUTPUTS
         .ltssmstate_drv             (                                                      ), // UNUSED BRIDGE STATUS OUTPUTS
         .dlup_drv                   (                                                      ), // UNUSED BRIDGE STATUS OUTPUTS
         .rx_par_err_drv             (                                                      ), // UNUSED BRIDGE STATUS OUTPUTS
         .tx_par_err_drv             (                                                      ), // UNUSED BRIDGE STATUS OUTPUTS
         .cfg_par_err_drv            (                                                      ), // UNUSED BRIDGE STATUS OUTPUTS
         .ko_cpl_spc_header_drv      (                                                      ), // UNUSED BRIDGE STATUS OUTPUTS
         .ko_cpl_spc_data_drv        (                                                      ), // UNUSED BRIDGE STATUS OUTPUTS
         .rxfc_cplbuf_ovf_app        (                                                      ), // UNUSED BRIDGE STATUS OUTPUTS

         .cpl_err                    (cpl_err                                               ),
         .cpl_err_fn                 (cpl_err_fn                                            ),
         .cpl_pending_pf             (cpl_pending_pf                                        ),
         .cpl_pending_vf             (cpl_pending_vf                                        ),
         .log_hdr                    (log_hdr                                               ),
         .flr_active_pf              (flr_active_pf                                         ),
         .flr_active_vf              (flr_active_vf                                         ),
         .flr_completed_pf           (flr_completed_pf                                      ),
         .flr_completed_vf           (flr_completed_vf                                      ),
         .bus_num_f0                 (bus_num_f0                                            ),
         .device_num_f0              (device_num_f0                                         ),
         .bus_num_f1                 (bus_num_f1                                            ),
         .device_num_f1              (device_num_f1                                         ),
         .mem_space_en_pf            (mem_space_en_pf                                       ),
         .bus_master_en_pf           (bus_master_en_pf                                      ),
         .mem_space_en_vf            (mem_space_en_vf                                       ),
         .bus_master_en_vf           (bus_master_en_vf                                      ),
         .pf0_num_vfs                (pf0_num_vfs                                           ),
         .pf1_num_vfs                (pf1_num_vfs                                           ),
         .max_payload_size           (pf_max_payload_size                                   ),
         .rd_req_size                (pf_rd_req_size                                        ),
         .app_int_sts_a              (app_int_sts_a                                         ),
         .app_int_sts_b              (app_int_sts_b                                         ),
         .app_int_sts_c              (app_int_sts_c                                         ),
         .app_int_sts_d              (app_int_sts_d                                         ),
         .app_int_sts_fn             ({2'h0, app_int_sts_fn}                                ),
         .app_int_ack                (sriov_app_int_ack                                     ),
         .app_msi_req                ((include_sriov_hwtcl==1)?            app_msi_req : 1'b0),
         .app_msi_status             (app_msi_status                                        ),
         .app_msi_ack                (sriov_app_msi_ack                                     ),
         .app_msi_req_fn             (app_msi_req_fn                                        ),
         .app_msi_num                (app_msi_num                                           ),
         .app_msi_tc                 (app_msi_tc                                            ),
         .app_msix_req               (app_msix_req                                          ),
         .app_msix_ack               (app_msix_ack                                          ),
         .app_msix_err               (app_msix_err                                          ),
         .app_msix_addr              (app_msix_addr                                         ),
         .app_msix_data              (app_msix_data                                         ),
         .app_int_pend_status        (app_int_pend_status                                   ),
         .app_msi_pending_bit_write_en   (app_msi_pending_bit_write_en                      ),
         .app_msi_pending_bit_write_data (app_msi_pending_bit_write_data                    ),
         .app_intx_disable           ( app_intx_disable                                     ),
         .app_msi_addr_pf            ( app_msi_addr_pf                                      ),
         .app_msi_data_pf            ( app_msi_data_pf                                      ),
         .app_msi_mask_pf            ( app_msi_mask_pf                                      ),
         .app_msi_pending_pf         ( app_msi_pending_pf                                   ),
         .app_msi_enable_pf          ( app_msi_enable_pf                                    ),
         .app_msi_multi_msg_enable_pf( app_msi_multi_msg_enable_pf                          ),
         .app_msix_en_pf             ( app_msix_en_pf                                       ),
         .app_msix_fn_mask_pf        ( app_msix_fn_mask_pf                                  ),
         .app_msix_en_vf             ( app_msix_en_vf                                       ),
         .app_msix_fn_mask_vf        ( app_msix_fn_mask_vf                                  ),
         .cfgbp_link2csr             (sriov_cfgbp_link2csr                                  ),
         .cfgbp_comclk_reg           (sriov_cfgbp_comclk_reg                                ),
         .cfgbp_extsy_reg            (sriov_cfgbp_extsy_reg                                 ),
         .cfgbp_max_pload            (sriov_cfgbp_max_pload                                 ),
         .cfgbp_tx_ecrcgen           (sriov_cfgbp_tx_ecrcgen                                ),
         .cfgbp_rx_ecrchk            (sriov_cfgbp_rx_ecrchk                                 ),
         .cfgbp_secbus               (sriov_cfgbp_secbus                                    ),
         .cfgbp_linkcsr_bit0         (sriov_cfgbp_linkcsr_bit0                              ),
         .cfgbp_tx_req_pm            (sriov_cfgbp_tx_req_pm                                 ),
         .cfgbp_tx_typ_pm            (sriov_cfgbp_tx_typ_pm                                 ),
         .cfgbp_req_phypm            (sriov_cfgbp_req_phypm                                 ),
         .cfgbp_req_phycfg           (sriov_cfgbp_req_phycfg                                ),
         .cfgbp_vc0_tcmap_pld        (sriov_cfgbp_vc0_tcmap_pld                             ),
         .cfgbp_inh_dllp             (sriov_cfgbp_inh_dllp                                  ),
         .cfgbp_inh_tx_tlp           (sriov_cfgbp_inh_tx_tlp                                ),
         .cfgbp_req_wake             (sriov_cfgbp_req_wake                                  ),
         .cfgbp_link3_ctl            (sriov_cfgbp_link3_ctl                                 ),
         .cfgbp_lane_err             (cfgbp_lane_err                                        ),
         .cfgbp_link_equlz_req       (cfgbp_link_equlz_req                                  ),
         .cfgbp_equiz_complete       (cfgbp_equiz_complete                                  ),
         .cfgbp_phase_3_successful   (cfgbp_phase_3_successful                              ),
         .cfgbp_phase_2_successful   (cfgbp_phase_2_successful                              ),
         .cfgbp_phase_1_successful   (cfgbp_phase_1_successful                              ),
         .cfgbp_current_deemph       (cfgbp_current_deemph                                  ),
         .cfgbp_current_speed        (cfgbp_current_speed                                   ),
         .cfgbp_link_up              (cfgbp_link_up                                         ),
         .cfgbp_link_train           (cfgbp_link_train                                      ),
         .cfgbp_10state              (cfgbp_10state                                         ),
         .cfgbp_10sstate             (cfgbp_10sstate                                        ),
         .cfgbp_rx_val_pm            (cfgbp_rx_val_pm                                       ),
         .cfgbp_rx_typ_pm            (cfgbp_rx_typ_pm                                       ),
         .cfgbp_tx_ack_pm            (cfgbp_tx_ack_pm                                       ),
         .cfgbp_ack_phypm            (cfgbp_ack_phypm                                       ),
         .cfgbp_vc_status            (cfgbp_vc_status                                       ),
         .cfgbp_rxfc_max             (cfgbp_rxfc_max                                        ),
         .cfgbp_txfc_max             (cfgbp_txfc_max                                        ),
         .cfgbp_txbuf_emp            (cfgbp_txbuf_emp                                       ),
         .cfgbp_cfgbuf_emp           (cfgbp_cfgbuf_emp                                      ),
         .cfgbp_rpbuf_emp            (cfgbp_rpbuf_emp                                       ),
         .cfgbp_dll_req              (cfgbp_dll_req                                         ),
         .cfgbp_link_auto_bdw_status (cfgbp_link_auto_bdw_status                            ),
         .cfgbp_link_bdw_mng_status  (cfgbp_link_bdw_mng_status                             ),
         .cfgbp_rst_tx_margin_field  (cfgbp_rst_tx_margin_field                             ),
         .cfgbp_rst_enter_comp_bit   (cfgbp_rst_enter_comp_bit                              ),
         .cfgbp_rx_st_ecrcerr        (cfgbp_rx_st_ecrcerr                                   ),
         .cfgbp_err_uncorr_internal  (cfgbp_err_uncorr_internal                             ),
         .cfgbp_rx_corr_internal     (cfgbp_rx_corr_internal                                ),
         .cfgbp_err_tlrcvovf         (cfgbp_err_tlrcvovf                                    ),
         .cfgbp_txfc_err             (cfgbp_txfc_err                                        ),
         .cfgbp_err_tlmalf           (cfgbp_err_tlmalf                                      ),
         .cfgbp_err_surpdwn_dll      (cfgbp_err_surpdwn_dll                                 ),
         .cfgbp_err_dllrev           (cfgbp_err_dllrev                                      ),
         .cfgbp_err_dll_repnum       (cfgbp_err_dll_repnum                                  ),
         .cfgbp_err_dllreptim        (cfgbp_err_dllreptim                                   ),
         .cfgbp_err_dllp_baddllp     (cfgbp_err_dllp_baddllp                                ),
         .cfgbp_err_dll_badtlp       (cfgbp_err_dll_badtlp                                  ),
         .cfgbp_err_phy_tng          (cfgbp_err_phy_tng                                     ),
         .cfgbp_err_phy_rcv          (cfgbp_err_phy_rcv                                     ),
         .cfgbp_root_err_reg_sts     (cfgbp_root_err_reg_sts                                ),
         .cfgbp_corr_err_reg_sts     (cfgbp_corr_err_reg_sts                                ),
         .cfgbp_unc_err_reg_sts      (cfgbp_unc_err_reg_sts                                 )
   );

   altpcie_a10_lmi_burst_intf lmi_burst_intf (
     .clk               (pld_clk_source   ),
     .srst              (~app_rstn[1]),
     .rstn              (app_rstn[1]),
     .pld_lmi_rden_i    (lmi_rden_pld),
     .pld_lmi_wren_i    (lmi_wren_pld),
     .pld_lmi_addr_i    (lmi_addr_pld),
     .pld_lmi_wrdata_i  (lmi_din_pld ),
     .pld_lmi_rddata_o  (lmi_dout_pld),
     .pld_lmi_ack_o     (lmi_ack_pld ),

     .hip_lmi_rden_o    (lmi_rden_hip),
     .hip_lmi_wren_o    (lmi_wren_hip),
     .hip_lmi_addr_o    (lmi_addr_hip),
     .hip_lmi_wrdata_o  (lmi_din_hip ),
     .hip_lmi_rddata_i  (lmi_dout_hip),
     .hip_lmi_ack_i     (lmi_ack_hip )
   );

   end
end
endgenerate

generate begin: g_sriov_2

  if (include_sriov_hwtcl==1 && sriov2_en==1) begin : sriov2

      altera_pcie_sriov2_bridge                #(
         .MAX_LINK_SPEED                           (lane_rate_sriov2                          ),
         .LINK_WIDTH                               (link_width_integer                        ),
         .DATA_WIDTH                               (data_width_integer_hwtcl                  ),
         .CLK_FREQUENCY                            (pll_refclk_freq                           ),
         .PARITY_SUPPORT                           (use_ast_parity                            ),
         .ARI_SUPPORT                              (ari_support_hwtcl                         ),
         .ENABLE_ALTERNATE_LINK_LIST               (enable_alternate_link_list_hwtcl          ),
         .TOTAL_PF_COUNT                           (total_pf_count_hwtcl                      ),
         .TOTAL_PF_COUNT_WIDTH                     (total_pf_count_width_hwtcl                ),
         .FLR_SUPPORT                              (flr_capability_hwtcl                      ),
         .RELAXED_ORDER_SUPPORT                    (relaxed_order_support_hwtcl               ),
         .EXTENDED_TAG_SUPPORT                     (extend_tag_field                          ),
         .MAX_PAYLOAD_SIZE                         (max_payload_size_hwtcl                    ),
         .NO_SOFT_RESET                            (no_soft_reset                             ),
         .DROP_POISONED_REQ                        (drop_poisoned_req_hwtcl                   ),
         .DROP_POISONED_COMPL                      (drop_poisoned_compl_hwtcl                 ),
         .SIG_TEST_EN                              (1'b1                                      ),
         .PF0_VENDOR_ID                            (vendor_id                                 ),
         .PF1_VENDOR_ID                            (pf1_vendor_id_hwtcl                       ),
         .PF2_VENDOR_ID                            (pf2_vendor_id_hwtcl                       ),
         .PF3_VENDOR_ID                            (pf3_vendor_id_hwtcl                       ),
         .PF4_VENDOR_ID                            (pf4_vendor_id_hwtcl                       ),
         .PF5_VENDOR_ID                            (pf5_vendor_id_hwtcl                       ),
         .PF6_VENDOR_ID                            (pf6_vendor_id_hwtcl                       ),
         .PF7_VENDOR_ID                            (pf7_vendor_id_hwtcl                       ),
         .PF0_DEVICE_ID                            (device_id                                 ),
         .PF1_DEVICE_ID                            (pf1_device_id_hwtcl                       ),
         .PF2_DEVICE_ID                            (pf2_device_id_hwtcl                       ),
         .PF3_DEVICE_ID                            (pf3_device_id_hwtcl                       ),
         .PF4_DEVICE_ID                            (pf4_device_id_hwtcl                       ),
         .PF5_DEVICE_ID                            (pf5_device_id_hwtcl                       ),
         .PF6_DEVICE_ID                            (pf6_device_id_hwtcl                       ),
         .PF7_DEVICE_ID                            (pf7_device_id_hwtcl                       ),
         .PF0_SUBVENDOR_ID                         (subsystem_vendor_id                       ),
         .PF1_SUBVENDOR_ID                         (pf1_subsystem_vendor_id_hwtcl             ),
         .PF2_SUBVENDOR_ID                         (pf2_subsystem_vendor_id_hwtcl             ),
         .PF3_SUBVENDOR_ID                         (pf3_subsystem_vendor_id_hwtcl             ),
         .PF4_SUBVENDOR_ID                         (pf4_subsystem_vendor_id_hwtcl             ),
         .PF5_SUBVENDOR_ID                         (pf5_subsystem_vendor_id_hwtcl             ),
         .PF6_SUBVENDOR_ID                         (pf6_subsystem_vendor_id_hwtcl             ),
         .PF7_SUBVENDOR_ID                         (pf7_subsystem_vendor_id_hwtcl             ),
         .PF0_SUBSYS_ID                            (subsystem_device_id                       ),
         .PF1_SUBSYS_ID                            (pf1_subsystem_device_id_hwtcl             ),
         .PF2_SUBSYS_ID                            (pf2_subsystem_device_id_hwtcl             ),
         .PF3_SUBSYS_ID                            (pf3_subsystem_device_id_hwtcl             ),
         .PF4_SUBSYS_ID                            (pf4_subsystem_device_id_hwtcl             ),
         .PF5_SUBSYS_ID                            (pf5_subsystem_device_id_hwtcl             ),
         .PF6_SUBSYS_ID                            (pf6_subsystem_device_id_hwtcl             ),
         .PF7_SUBSYS_ID                            (pf7_subsystem_device_id_hwtcl             ),
         .PF0_VF_SUBSYS_ID                         (pf0_vf_subsystem_device_id_hwtcl          ),
         .PF1_VF_SUBSYS_ID                         (pf1_vf_subsystem_device_id_hwtcl          ),
         .PF2_VF_SUBSYS_ID                         (pf2_vf_subsystem_device_id_hwtcl          ),
         .PF3_VF_SUBSYS_ID                         (pf3_vf_subsystem_device_id_hwtcl          ),
         .PF0_CLASS_CODE                           (class_code                                ),
         .PF1_CLASS_CODE                           (pf1_class_code_hwtcl                      ),
         .PF2_CLASS_CODE                           (pf2_class_code_hwtcl                      ),
         .PF3_CLASS_CODE                           (pf3_class_code_hwtcl                      ),
         .PF4_CLASS_CODE                           (pf4_class_code_hwtcl                      ),
         .PF5_CLASS_CODE                           (pf5_class_code_hwtcl                      ),
         .PF6_CLASS_CODE                           (pf6_class_code_hwtcl                      ),
         .PF7_CLASS_CODE                           (pf7_class_code_hwtcl                      ),
         .PF0_SUBCLASS_CODE                        (pf0_subclass_code_hwtcl                   ),
         .PF1_SUBCLASS_CODE                        (pf1_subclass_code_hwtcl                   ),
         .PF2_SUBCLASS_CODE                        (pf2_subclass_code_hwtcl                   ),
         .PF3_SUBCLASS_CODE                        (pf3_subclass_code_hwtcl                   ),
         .PF4_SUBCLASS_CODE                        (pf4_subclass_code_hwtcl                   ),
         .PF5_SUBCLASS_CODE                        (pf5_subclass_code_hwtcl                   ),
         .PF6_SUBCLASS_CODE                        (pf6_subclass_code_hwtcl                   ),
         .PF7_SUBCLASS_CODE                        (pf7_subclass_code_hwtcl                   ),
         .PF0_PCI_PROG_INTFC_BYTE                  (pf0_pci_prog_intfc_byte_hwtcl             ),
         .PF1_PCI_PROG_INTFC_BYTE                  (pf1_pci_prog_intfc_byte_hwtcl             ),
         .PF2_PCI_PROG_INTFC_BYTE                  (pf2_pci_prog_intfc_byte_hwtcl             ),
         .PF3_PCI_PROG_INTFC_BYTE                  (pf3_pci_prog_intfc_byte_hwtcl             ),
         .PF4_PCI_PROG_INTFC_BYTE                  (pf4_pci_prog_intfc_byte_hwtcl             ),
         .PF5_PCI_PROG_INTFC_BYTE                  (pf5_pci_prog_intfc_byte_hwtcl             ),
         .PF6_PCI_PROG_INTFC_BYTE                  (pf6_pci_prog_intfc_byte_hwtcl             ),
         .PF7_PCI_PROG_INTFC_BYTE                  (pf7_pci_prog_intfc_byte_hwtcl             ),
         .PF0_REVISION_ID                          (revision_id                               ),
         .PF1_REVISION_ID                          (pf1_revision_id_hwtcl                     ),
         .PF2_REVISION_ID                          (pf2_revision_id_hwtcl                     ),
         .PF3_REVISION_ID                          (pf3_revision_id_hwtcl                     ),
         .PF4_REVISION_ID                          (pf4_revision_id_hwtcl                     ),
         .PF5_REVISION_ID                          (pf5_revision_id_hwtcl                     ),
         .PF6_REVISION_ID                          (pf6_revision_id_hwtcl                     ),
         .PF7_REVISION_ID                          (pf7_revision_id_hwtcl                     ),
         .PF0_INTR_PIN                             (pf0_interrupt_pin_hwtcl                   ),
         .PF1_INTR_PIN                             (pf1_interrupt_pin_hwtcl                   ),
         .PF2_INTR_PIN                             (pf2_interrupt_pin_hwtcl                   ),
         .PF3_INTR_PIN                             (pf3_interrupt_pin_hwtcl                   ),
         .PF4_INTR_PIN                             (pf4_interrupt_pin_hwtcl                   ),
         .PF5_INTR_PIN                             (pf5_interrupt_pin_hwtcl                   ),
         .PF6_INTR_PIN                             (pf6_interrupt_pin_hwtcl                   ),
         .PF7_INTR_PIN                             (pf7_interrupt_pin_hwtcl                   ),
         .PF0_INTR_LINE                            (pf0_intr_line_hwtcl                       ),
         .PF1_INTR_LINE                            (pf1_intr_line_hwtcl                       ),
         .PF2_INTR_LINE                            (pf2_intr_line_hwtcl                       ),
         .PF3_INTR_LINE                            (pf3_intr_line_hwtcl                       ),
         .PF4_INTR_LINE                            (pf4_intr_line_hwtcl                       ),
         .PF5_INTR_LINE                            (pf5_intr_line_hwtcl                       ),
         .PF6_INTR_LINE                            (pf6_intr_line_hwtcl                       ),
         .PF7_INTR_LINE                            (pf7_intr_line_hwtcl                       ),
         .SLOT_CLK_CFG                             (slot_clock_cfg_hwtcl                      ),
         .EP_L0S_ACCEPTABLE_LATENCY                (endpoint_l0_latency                       ),
         .EP_L1_ACCEPTABLE_LATENCY                 (endpoint_l1_latency                       ),
         .ASPM_L0S_SUPPORT                         (0                                         ),
         .ASPM_L1_SUPPORT                          (0                                         ),
         .L0S_EXIT_LATENCY                         (l0_exit_latency_sameclock                 ),
         .L1_EXIT_LATENCY                          (l1_exit_latency_sameclock                 ),
         .COMPL_TIMEOUT_DISABLE_SUPPORT            (enable_completion_timeout_disable_hwtcl   ),
         .COMPL_TIMEOUT_RANGES                     (completion_timeout                        ),
         .ECRC_GEN_CAPABLE                         (1'b0                                      ),
         .ECRC_CHECK_CAPABLE                       (1'b0                                      ),
         .SR_IOV_SUPPORT                           (sr_iov_support_hwtcl                      ),
         .TOTAL_VF_COUNT                           (total_vf_count_hwtcl                      ),
         .TOTAL_VF_COUNT_WIDTH                     (total_vf_count_width_hwtcl                ),
         .PF0_VF_COUNT                             (pf0_vf_count_hwtcl                        ),
         .PF1_VF_COUNT                             (pf1_vf_count_hwtcl                        ),
         .PF2_VF_COUNT                             (pf2_vf_count_hwtcl                        ),
         .PF3_VF_COUNT                             (pf3_vf_count_hwtcl                        ),
         .PF0_VF_DEVICE_ID                         (pf0_vf_device_id_hwtcl                    ),
         .PF1_VF_DEVICE_ID                         (pf1_vf_device_id_hwtcl                    ),
         .PF2_VF_DEVICE_ID                         (pf2_vf_device_id_hwtcl                    ),
         .PF3_VF_DEVICE_ID                         (pf3_vf_device_id_hwtcl                    ),
         .SYSTEM_PAGE_SIZES_SUPPORTED              (system_page_sizes_supported_hwtcl         ),
         .MSI_SUPPORT                              (pf_msi_support_hwtcl                      ),
         .MSI_64BIT_CAPABLE                        (msi_64bit_addressing_capable_hwtcl        ),
         .PF0_MSI_MULTI_MSG_CAPABLE                (pf0_msi_multi_message_capable_hwtcl       ),
         .PF1_MSI_MULTI_MSG_CAPABLE                (pf1_msi_multi_message_capable_hwtcl       ),
         .PF2_MSI_MULTI_MSG_CAPABLE                (pf2_msi_multi_message_capable_hwtcl       ),
         .PF3_MSI_MULTI_MSG_CAPABLE                (pf3_msi_multi_message_capable_hwtcl       ),
         .PF4_MSI_MULTI_MSG_CAPABLE                (pf4_msi_multi_message_capable_hwtcl       ),
         .PF5_MSI_MULTI_MSG_CAPABLE                (pf5_msi_multi_message_capable_hwtcl       ),
         .PF6_MSI_MULTI_MSG_CAPABLE                (pf6_msi_multi_message_capable_hwtcl       ),
         .PF7_MSI_MULTI_MSG_CAPABLE                (pf7_msi_multi_message_capable_hwtcl       ),
         .MSIX_SUPPORT                             (pf_enable_function_msix_support_hwtcl     ),
         .PF0_MSIX_TBL_SIZE                        (pf0_msix_table_size_hwtcl                 ),
         .PF1_MSIX_TBL_SIZE                        (pf1_msix_table_size_hwtcl                 ),
         .PF2_MSIX_TBL_SIZE                        (pf2_msix_table_size_hwtcl                 ),
         .PF3_MSIX_TBL_SIZE                        (pf3_msix_table_size_hwtcl                 ),
         .PF4_MSIX_TBL_SIZE                        (pf4_msix_table_size_hwtcl                 ),
         .PF5_MSIX_TBL_SIZE                        (pf5_msix_table_size_hwtcl                 ),
         .PF6_MSIX_TBL_SIZE                        (pf6_msix_table_size_hwtcl                 ),
         .PF7_MSIX_TBL_SIZE                        (pf7_msix_table_size_hwtcl                 ),
         .PF0_MSIX_TBL_OFFSET                      (pf0_msix_table_offset_hwtcl               ),
         .PF1_MSIX_TBL_OFFSET                      (pf1_msix_table_offset_hwtcl               ),
         .PF2_MSIX_TBL_OFFSET                      (pf2_msix_table_offset_hwtcl               ),
         .PF3_MSIX_TBL_OFFSET                      (pf3_msix_table_offset_hwtcl               ),
         .PF4_MSIX_TBL_OFFSET                      (pf4_msix_table_offset_hwtcl               ),
         .PF5_MSIX_TBL_OFFSET                      (pf5_msix_table_offset_hwtcl               ),
         .PF6_MSIX_TBL_OFFSET                      (pf6_msix_table_offset_hwtcl               ),
         .PF7_MSIX_TBL_OFFSET                      (pf7_msix_table_offset_hwtcl               ),
         .PF0_MSIX_TBL_BIR                         (pf0_msix_table_bir_hwtcl                  ),
         .PF1_MSIX_TBL_BIR                         (pf1_msix_table_bir_hwtcl                  ),
         .PF2_MSIX_TBL_BIR                         (pf2_msix_table_bir_hwtcl                  ),
         .PF3_MSIX_TBL_BIR                         (pf3_msix_table_bir_hwtcl                  ),
         .PF4_MSIX_TBL_BIR                         (pf4_msix_table_bir_hwtcl                  ),
         .PF5_MSIX_TBL_BIR                         (pf5_msix_table_bir_hwtcl                  ),
         .PF6_MSIX_TBL_BIR                         (pf6_msix_table_bir_hwtcl                  ),
         .PF7_MSIX_TBL_BIR                         (pf7_msix_table_bir_hwtcl                  ),
         .PF0_MSIX_PBA_OFFSET                      (pf0_msix_pba_offset_hwtcl                 ),
         .PF1_MSIX_PBA_OFFSET                      (pf1_msix_pba_offset_hwtcl                 ),
         .PF2_MSIX_PBA_OFFSET                      (pf2_msix_pba_offset_hwtcl                 ),
         .PF3_MSIX_PBA_OFFSET                      (pf3_msix_pba_offset_hwtcl                 ),
         .PF4_MSIX_PBA_OFFSET                      (pf4_msix_pba_offset_hwtcl                 ),
         .PF5_MSIX_PBA_OFFSET                      (pf5_msix_pba_offset_hwtcl                 ),
         .PF6_MSIX_PBA_OFFSET                      (pf6_msix_pba_offset_hwtcl                 ),
         .PF7_MSIX_PBA_OFFSET                      (pf7_msix_pba_offset_hwtcl                 ),
         .PF0_MSIX_PBA_BIR                         (pf0_msix_pba_bir_hwtcl                    ),
         .PF1_MSIX_PBA_BIR                         (pf1_msix_pba_bir_hwtcl                    ),
         .PF2_MSIX_PBA_BIR                         (pf2_msix_pba_bir_hwtcl                    ),
         .PF3_MSIX_PBA_BIR                         (pf3_msix_pba_bir_hwtcl                    ),
         .PF4_MSIX_PBA_BIR                         (pf4_msix_pba_bir_hwtcl                    ),
         .PF5_MSIX_PBA_BIR                         (pf5_msix_pba_bir_hwtcl                    ),
         .PF6_MSIX_PBA_BIR                         (pf6_msix_pba_bir_hwtcl                    ),
         .PF7_MSIX_PBA_BIR                         (pf7_msix_pba_bir_hwtcl                    ),
         .VF_MSIX_SUPPORT                          (vf_msix_cap_present_hwtcl                 ),
         .PF0_VF_MSIX_TBL_SIZE                     (pf0_vf_msix_tbl_size_hwtcl                ),
         .PF1_VF_MSIX_TBL_SIZE                     (pf1_vf_msix_tbl_size_hwtcl                ),
         .PF2_VF_MSIX_TBL_SIZE                     (pf2_vf_msix_tbl_size_hwtcl                ),
         .PF3_VF_MSIX_TBL_SIZE                     (pf3_vf_msix_tbl_size_hwtcl                ),
         .PF0_VF_MSIX_TBL_OFFSET                   (pf0_vf_msix_tbl_offset_hwtcl              ),
         .PF1_VF_MSIX_TBL_OFFSET                   (pf1_vf_msix_tbl_offset_hwtcl              ),
         .PF2_VF_MSIX_TBL_OFFSET                   (pf2_vf_msix_tbl_offset_hwtcl              ),
         .PF3_VF_MSIX_TBL_OFFSET                   (pf3_vf_msix_tbl_offset_hwtcl              ),
         .PF0_VF_MSIX_TBL_BIR                      (pf0_vf_msix_tbl_bir_hwtcl                 ),
         .PF1_VF_MSIX_TBL_BIR                      (pf1_vf_msix_tbl_bir_hwtcl                 ),
         .PF2_VF_MSIX_TBL_BIR                      (pf2_vf_msix_tbl_bir_hwtcl                 ),
         .PF3_VF_MSIX_TBL_BIR                      (pf3_vf_msix_tbl_bir_hwtcl                 ),
         .PF0_VF_MSIX_PBA_OFFSET                   (pf0_vf_msix_pba_offset_hwtcl              ),
         .PF1_VF_MSIX_PBA_OFFSET                   (pf1_vf_msix_pba_offset_hwtcl              ),
         .PF2_VF_MSIX_PBA_OFFSET                   (pf2_vf_msix_pba_offset_hwtcl              ),
         .PF3_VF_MSIX_PBA_OFFSET                   (pf3_vf_msix_pba_offset_hwtcl              ),
         .PF0_VF_MSIX_PBA_BIR                      (pf0_vf_msix_pba_bir_hwtcl                 ),
         .PF1_VF_MSIX_PBA_BIR                      (pf1_vf_msix_pba_bir_hwtcl                 ),
         .PF2_VF_MSIX_PBA_BIR                      (pf2_vf_msix_pba_bir_hwtcl                 ),
         .PF3_VF_MSIX_PBA_BIR                      (pf3_vf_msix_pba_bir_hwtcl                 ),

         .PF0_BAR0_PRESENT                         (pf0_bar0_present_hwtcl                    ),
         .PF1_BAR0_PRESENT                         (pf1_bar0_present_hwtcl                    ),
         .PF0_BAR1_PRESENT                         (pf0_bar1_present_hwtcl                    ),
         .PF1_BAR1_PRESENT                         (pf1_bar1_present_hwtcl                    ),
         .PF0_BAR2_PRESENT                         (pf0_bar2_present_hwtcl                    ),
         .PF1_BAR2_PRESENT                         (pf1_bar2_present_hwtcl                    ),
         .PF0_BAR3_PRESENT                         (pf0_bar3_present_hwtcl                    ),
         .PF1_BAR3_PRESENT                         (pf1_bar3_present_hwtcl                    ),
         .PF0_BAR4_PRESENT                         (pf0_bar4_present_hwtcl                    ),
         .PF1_BAR4_PRESENT                         (pf1_bar4_present_hwtcl                    ),
         .PF0_BAR5_PRESENT                         (pf0_bar5_present_hwtcl                    ),
         .PF1_BAR5_PRESENT                         (pf1_bar5_present_hwtcl                    ),
         .PF0_BAR0_TYPE                            (pf0_bar0_type_hwtcl                       ),
         .PF1_BAR0_TYPE                            (pf1_bar0_type_hwtcl                       ),
         .PF0_BAR2_TYPE                            (pf0_bar2_type_hwtcl                       ),
         .PF1_BAR2_TYPE                            (pf1_bar2_type_hwtcl                       ),
         .PF0_BAR4_TYPE                            (pf0_bar4_type_hwtcl                       ),
         .PF1_BAR4_TYPE                            (pf1_bar4_type_hwtcl                       ),
         .PF0_BAR0_PREFETCHABLE                    (pf0_bar0_prefetchable_hwtcl               ),
         .PF1_BAR0_PREFETCHABLE                    (pf1_bar0_prefetchable_hwtcl               ),
         .PF0_BAR1_PREFETCHABLE                    (pf0_bar1_prefetchable_hwtcl               ),
         .PF1_BAR1_PREFETCHABLE                    (pf1_bar1_prefetchable_hwtcl               ),
         .PF0_BAR2_PREFETCHABLE                    (pf0_bar2_prefetchable_hwtcl               ),
         .PF1_BAR2_PREFETCHABLE                    (pf1_bar2_prefetchable_hwtcl               ),
         .PF0_BAR3_PREFETCHABLE                    (pf0_bar3_prefetchable_hwtcl               ),
         .PF1_BAR3_PREFETCHABLE                    (pf1_bar3_prefetchable_hwtcl               ),
         .PF0_BAR4_PREFETCHABLE                    (pf0_bar4_prefetchable_hwtcl               ),
         .PF1_BAR4_PREFETCHABLE                    (pf1_bar4_prefetchable_hwtcl               ),
         .PF0_BAR5_PREFETCHABLE                    (pf0_bar5_prefetchable_hwtcl               ),
         .PF1_BAR5_PREFETCHABLE                    (pf1_bar5_prefetchable_hwtcl               ),
         .PF0_BAR0_SIZE                            (pf0_bar0_size_hwtcl                       ),
         .PF1_BAR0_SIZE                            (pf1_bar0_size_hwtcl                       ),
         .PF0_BAR1_SIZE                            (pf0_bar1_size_hwtcl                       ),
         .PF1_BAR1_SIZE                            (pf1_bar1_size_hwtcl                       ),
         .PF0_BAR2_SIZE                            (pf0_bar2_size_hwtcl                       ),
         .PF1_BAR2_SIZE                            (pf1_bar2_size_hwtcl                       ),
         .PF0_BAR3_SIZE                            (pf0_bar3_size_hwtcl                       ),
         .PF1_BAR3_SIZE                            (pf1_bar3_size_hwtcl                       ),
         .PF0_BAR4_SIZE                            (pf0_bar4_size_hwtcl                       ),
         .PF1_BAR4_SIZE                            (pf1_bar4_size_hwtcl                       ),
         .PF0_BAR5_SIZE                            (pf0_bar5_size_hwtcl                       ),
         .PF1_BAR5_SIZE                            (pf1_bar5_size_hwtcl                       ),

         .PF2_BAR0_PRESENT                         (pf2_bar0_present_hwtcl                    ),
         .PF3_BAR0_PRESENT                         (pf3_bar0_present_hwtcl                    ),
         .PF2_BAR1_PRESENT                         (pf2_bar1_present_hwtcl                    ),
         .PF3_BAR1_PRESENT                         (pf3_bar1_present_hwtcl                    ),
         .PF2_BAR2_PRESENT                         (pf2_bar2_present_hwtcl                    ),
         .PF3_BAR2_PRESENT                         (pf3_bar2_present_hwtcl                    ),
         .PF2_BAR3_PRESENT                         (pf2_bar3_present_hwtcl                    ),
         .PF3_BAR3_PRESENT                         (pf3_bar3_present_hwtcl                    ),
         .PF2_BAR4_PRESENT                         (pf2_bar4_present_hwtcl                    ),
         .PF3_BAR4_PRESENT                         (pf3_bar4_present_hwtcl                    ),
         .PF2_BAR5_PRESENT                         (pf2_bar5_present_hwtcl                    ),
         .PF3_BAR5_PRESENT                         (pf3_bar5_present_hwtcl                    ),
         .PF0_EXPROM_BAR_PRESENT                   (pf0_exprom_bar_present_hwtcl              ),
         .PF1_EXPROM_BAR_PRESENT                   (pf1_exprom_bar_present_hwtcl              ),
         .PF2_EXPROM_BAR_PRESENT                   (pf2_exprom_bar_present_hwtcl              ),
         .PF3_EXPROM_BAR_PRESENT                   (pf3_exprom_bar_present_hwtcl              ),
         .PF2_BAR0_TYPE                            (pf2_bar0_type_hwtcl                       ),
         .PF3_BAR0_TYPE                            (pf3_bar0_type_hwtcl                       ),
         .PF2_BAR2_TYPE                            (pf2_bar2_type_hwtcl                       ),
         .PF3_BAR2_TYPE                            (pf3_bar2_type_hwtcl                       ),
         .PF2_BAR4_TYPE                            (pf2_bar4_type_hwtcl                       ),
         .PF3_BAR4_TYPE                            (pf3_bar4_type_hwtcl                       ),
         .PF2_BAR0_PREFETCHABLE                    (pf2_bar0_prefetchable_hwtcl               ),
         .PF3_BAR0_PREFETCHABLE                    (pf3_bar0_prefetchable_hwtcl               ),
         .PF2_BAR1_PREFETCHABLE                    (pf2_bar1_prefetchable_hwtcl               ),
         .PF3_BAR1_PREFETCHABLE                    (pf3_bar1_prefetchable_hwtcl               ),
         .PF2_BAR2_PREFETCHABLE                    (pf2_bar2_prefetchable_hwtcl               ),
         .PF3_BAR2_PREFETCHABLE                    (pf3_bar2_prefetchable_hwtcl               ),
         .PF2_BAR3_PREFETCHABLE                    (pf2_bar3_prefetchable_hwtcl               ),
         .PF3_BAR3_PREFETCHABLE                    (pf3_bar3_prefetchable_hwtcl               ),
         .PF2_BAR4_PREFETCHABLE                    (pf2_bar4_prefetchable_hwtcl               ),
         .PF3_BAR4_PREFETCHABLE                    (pf3_bar4_prefetchable_hwtcl               ),
         .PF2_BAR5_PREFETCHABLE                    (pf2_bar5_prefetchable_hwtcl               ),
         .PF3_BAR5_PREFETCHABLE                    (pf3_bar5_prefetchable_hwtcl               ),
         .PF2_BAR0_SIZE                            (pf2_bar0_size_hwtcl                       ),
         .PF3_BAR0_SIZE                            (pf3_bar0_size_hwtcl                       ),
         .PF2_BAR1_SIZE                            (pf2_bar1_size_hwtcl                       ),
         .PF3_BAR1_SIZE                            (pf3_bar1_size_hwtcl                       ),
         .PF2_BAR2_SIZE                            (pf2_bar2_size_hwtcl                       ),
         .PF3_BAR2_SIZE                            (pf3_bar2_size_hwtcl                       ),
         .PF2_BAR3_SIZE                            (pf2_bar3_size_hwtcl                       ),
         .PF3_BAR3_SIZE                            (pf3_bar3_size_hwtcl                       ),
         .PF2_BAR4_SIZE                            (pf2_bar4_size_hwtcl                       ),
         .PF3_BAR4_SIZE                            (pf3_bar4_size_hwtcl                       ),
         .PF2_BAR5_SIZE                            (pf2_bar5_size_hwtcl                       ),
         .PF3_BAR5_SIZE                            (pf3_bar5_size_hwtcl                       ),
         .PF0_EXPROM_BAR_SIZE                      (pf0_exprom_bar_size_hwtcl                 ),
         .PF1_EXPROM_BAR_SIZE                      (pf1_exprom_bar_size_hwtcl                 ),
         .PF2_EXPROM_BAR_SIZE                      (pf2_exprom_bar_size_hwtcl                 ),
         .PF3_EXPROM_BAR_SIZE                      (pf3_exprom_bar_size_hwtcl                 ),         

         .PF4_BAR0_PRESENT                         (pf4_bar0_present_hwtcl                    ),
         .PF5_BAR0_PRESENT                         (pf5_bar0_present_hwtcl                    ),
         .PF4_BAR1_PRESENT                         (pf4_bar1_present_hwtcl                    ),
         .PF5_BAR1_PRESENT                         (pf5_bar1_present_hwtcl                    ),
         .PF4_BAR2_PRESENT                         (pf4_bar2_present_hwtcl                    ),
         .PF5_BAR2_PRESENT                         (pf5_bar2_present_hwtcl                    ),
         .PF4_BAR3_PRESENT                         (pf4_bar3_present_hwtcl                    ),
         .PF5_BAR3_PRESENT                         (pf5_bar3_present_hwtcl                    ),
         .PF4_BAR4_PRESENT                         (pf4_bar4_present_hwtcl                    ),
         .PF5_BAR4_PRESENT                         (pf5_bar4_present_hwtcl                    ),
         .PF4_BAR5_PRESENT                         (pf4_bar5_present_hwtcl                    ),
         .PF5_BAR5_PRESENT                         (pf5_bar5_present_hwtcl                    ),
         .PF4_BAR0_TYPE                            (pf4_bar0_type_hwtcl                       ),
         .PF5_BAR0_TYPE                            (pf5_bar0_type_hwtcl                       ),
         .PF4_BAR2_TYPE                            (pf4_bar2_type_hwtcl                       ),
         .PF5_BAR2_TYPE                            (pf5_bar2_type_hwtcl                       ),
         .PF4_BAR4_TYPE                            (pf4_bar4_type_hwtcl                       ),
         .PF5_BAR4_TYPE                            (pf5_bar4_type_hwtcl                       ),
         .PF4_BAR0_PREFETCHABLE                    (pf4_bar0_prefetchable_hwtcl               ),
         .PF5_BAR0_PREFETCHABLE                    (pf5_bar0_prefetchable_hwtcl               ),
         .PF4_BAR1_PREFETCHABLE                    (pf4_bar1_prefetchable_hwtcl               ),
         .PF5_BAR1_PREFETCHABLE                    (pf5_bar1_prefetchable_hwtcl               ),
         .PF4_BAR2_PREFETCHABLE                    (pf4_bar2_prefetchable_hwtcl               ),
         .PF5_BAR2_PREFETCHABLE                    (pf5_bar2_prefetchable_hwtcl               ),
         .PF4_BAR3_PREFETCHABLE                    (pf4_bar3_prefetchable_hwtcl               ),
         .PF5_BAR3_PREFETCHABLE                    (pf5_bar3_prefetchable_hwtcl               ),
         .PF4_BAR4_PREFETCHABLE                    (pf4_bar4_prefetchable_hwtcl               ),
         .PF5_BAR4_PREFETCHABLE                    (pf5_bar4_prefetchable_hwtcl               ),
         .PF4_BAR5_PREFETCHABLE                    (pf4_bar5_prefetchable_hwtcl               ),
         .PF5_BAR5_PREFETCHABLE                    (pf5_bar5_prefetchable_hwtcl               ),
         .PF4_BAR0_SIZE                            (pf4_bar0_size_hwtcl                       ),
         .PF5_BAR0_SIZE                            (pf5_bar0_size_hwtcl                       ),
         .PF4_BAR1_SIZE                            (pf4_bar1_size_hwtcl                       ),
         .PF5_BAR1_SIZE                            (pf5_bar1_size_hwtcl                       ),
         .PF4_BAR2_SIZE                            (pf4_bar2_size_hwtcl                       ),
         .PF5_BAR2_SIZE                            (pf5_bar2_size_hwtcl                       ),
         .PF4_BAR3_SIZE                            (pf4_bar3_size_hwtcl                       ),
         .PF5_BAR3_SIZE                            (pf5_bar3_size_hwtcl                       ),
         .PF4_BAR4_SIZE                            (pf4_bar4_size_hwtcl                       ),
         .PF5_BAR4_SIZE                            (pf5_bar4_size_hwtcl                       ),
         .PF4_BAR5_SIZE                            (pf4_bar5_size_hwtcl                       ),
         .PF5_BAR5_SIZE                            (pf5_bar5_size_hwtcl                       ),

         .PF6_BAR0_PRESENT                         (pf6_bar0_present_hwtcl                    ),
         .PF7_BAR0_PRESENT                         (pf7_bar0_present_hwtcl                    ),
         .PF6_BAR1_PRESENT                         (pf6_bar1_present_hwtcl                    ),
         .PF7_BAR1_PRESENT                         (pf7_bar1_present_hwtcl                    ),
         .PF6_BAR2_PRESENT                         (pf6_bar2_present_hwtcl                    ),
         .PF7_BAR2_PRESENT                         (pf7_bar2_present_hwtcl                    ),
         .PF6_BAR3_PRESENT                         (pf6_bar3_present_hwtcl                    ),
         .PF7_BAR3_PRESENT                         (pf7_bar3_present_hwtcl                    ),
         .PF6_BAR4_PRESENT                         (pf6_bar4_present_hwtcl                    ),
         .PF7_BAR4_PRESENT                         (pf7_bar4_present_hwtcl                    ),
         .PF6_BAR5_PRESENT                         (pf6_bar5_present_hwtcl                    ),
         .PF7_BAR5_PRESENT                         (pf7_bar5_present_hwtcl                    ),
         .PF4_EXPROM_BAR_PRESENT                   (pf4_exprom_bar_present_hwtcl              ),
         .PF5_EXPROM_BAR_PRESENT                   (pf5_exprom_bar_present_hwtcl              ),
         .PF6_EXPROM_BAR_PRESENT                   (pf6_exprom_bar_present_hwtcl              ),
         .PF7_EXPROM_BAR_PRESENT                   (pf7_exprom_bar_present_hwtcl              ),
         .PF6_BAR0_TYPE                            (pf6_bar0_type_hwtcl                       ),
         .PF7_BAR0_TYPE                            (pf7_bar0_type_hwtcl                       ),
         .PF6_BAR2_TYPE                            (pf6_bar2_type_hwtcl                       ),
         .PF7_BAR2_TYPE                            (pf7_bar2_type_hwtcl                       ),
         .PF6_BAR4_TYPE                            (pf6_bar4_type_hwtcl                       ),
         .PF7_BAR4_TYPE                            (pf7_bar4_type_hwtcl                       ),
         .PF6_BAR0_PREFETCHABLE                    (pf6_bar0_prefetchable_hwtcl               ),
         .PF7_BAR0_PREFETCHABLE                    (pf7_bar0_prefetchable_hwtcl               ),
         .PF6_BAR1_PREFETCHABLE                    (pf6_bar1_prefetchable_hwtcl               ),
         .PF7_BAR1_PREFETCHABLE                    (pf7_bar1_prefetchable_hwtcl               ),
         .PF6_BAR2_PREFETCHABLE                    (pf6_bar2_prefetchable_hwtcl               ),
         .PF7_BAR2_PREFETCHABLE                    (pf7_bar2_prefetchable_hwtcl               ),
         .PF6_BAR3_PREFETCHABLE                    (pf6_bar3_prefetchable_hwtcl               ),
         .PF7_BAR3_PREFETCHABLE                    (pf7_bar3_prefetchable_hwtcl               ),
         .PF6_BAR4_PREFETCHABLE                    (pf6_bar4_prefetchable_hwtcl               ),
         .PF7_BAR4_PREFETCHABLE                    (pf7_bar4_prefetchable_hwtcl               ),
         .PF6_BAR5_PREFETCHABLE                    (pf6_bar5_prefetchable_hwtcl               ),
         .PF7_BAR5_PREFETCHABLE                    (pf7_bar5_prefetchable_hwtcl               ),
         .PF6_BAR0_SIZE                            (pf6_bar0_size_hwtcl                       ),
         .PF7_BAR0_SIZE                            (pf7_bar0_size_hwtcl                       ),
         .PF6_BAR1_SIZE                            (pf6_bar1_size_hwtcl                       ),
         .PF7_BAR1_SIZE                            (pf7_bar1_size_hwtcl                       ),
         .PF6_BAR2_SIZE                            (pf6_bar2_size_hwtcl                       ),
         .PF7_BAR2_SIZE                            (pf7_bar2_size_hwtcl                       ),
         .PF6_BAR3_SIZE                            (pf6_bar3_size_hwtcl                       ),
         .PF7_BAR3_SIZE                            (pf7_bar3_size_hwtcl                       ),
         .PF6_BAR4_SIZE                            (pf6_bar4_size_hwtcl                       ),
         .PF7_BAR4_SIZE                            (pf7_bar4_size_hwtcl                       ),
         .PF6_BAR5_SIZE                            (pf6_bar5_size_hwtcl                       ),
         .PF7_BAR5_SIZE                            (pf7_bar5_size_hwtcl                       ),
         .PF4_EXPROM_BAR_SIZE                      (pf4_exprom_bar_size_hwtcl                 ),
         .PF5_EXPROM_BAR_SIZE                      (pf5_exprom_bar_size_hwtcl                 ),
         .PF6_EXPROM_BAR_SIZE                      (pf6_exprom_bar_size_hwtcl                 ),
         .PF7_EXPROM_BAR_SIZE                      (pf7_exprom_bar_size_hwtcl                 ),         

         .PF0_VF_BAR0_PRESENT                      (pf0_vf_bar0_present_hwtcl                 ),
         .PF1_VF_BAR0_PRESENT                      (pf1_vf_bar0_present_hwtcl                 ),
         .PF0_VF_BAR1_PRESENT                      (pf0_vf_bar1_present_hwtcl                 ),
         .PF1_VF_BAR1_PRESENT                      (pf1_vf_bar1_present_hwtcl                 ),
         .PF0_VF_BAR2_PRESENT                      (pf0_vf_bar2_present_hwtcl                 ),
         .PF1_VF_BAR2_PRESENT                      (pf1_vf_bar2_present_hwtcl                 ),
         .PF0_VF_BAR3_PRESENT                      (pf0_vf_bar3_present_hwtcl                 ),
         .PF1_VF_BAR3_PRESENT                      (pf1_vf_bar3_present_hwtcl                 ),
         .PF0_VF_BAR4_PRESENT                      (pf0_vf_bar4_present_hwtcl                 ),
         .PF1_VF_BAR4_PRESENT                      (pf1_vf_bar4_present_hwtcl                 ),
         .PF0_VF_BAR5_PRESENT                      (pf0_vf_bar5_present_hwtcl                 ),
         .PF1_VF_BAR5_PRESENT                      (pf1_vf_bar5_present_hwtcl                 ),
         .PF0_VF_BAR0_TYPE                         (pf0_vf_bar0_type_hwtcl                    ),
         .PF1_VF_BAR0_TYPE                         (pf1_vf_bar0_type_hwtcl                    ),
         .PF0_VF_BAR2_TYPE                         (pf0_vf_bar2_type_hwtcl                    ),
         .PF1_VF_BAR2_TYPE                         (pf1_vf_bar2_type_hwtcl                    ),
         .PF0_VF_BAR4_TYPE                         (pf0_vf_bar4_type_hwtcl                    ),
         .PF1_VF_BAR4_TYPE                         (pf1_vf_bar4_type_hwtcl                    ),
         .PF0_VF_BAR0_PREFETCHABLE                 (pf0_vf_bar0_prefetchable_hwtcl            ),
         .PF1_VF_BAR0_PREFETCHABLE                 (pf1_vf_bar0_prefetchable_hwtcl            ),
         .PF0_VF_BAR1_PREFETCHABLE                 (pf0_vf_bar1_prefetchable_hwtcl            ),
         .PF1_VF_BAR1_PREFETCHABLE                 (pf1_vf_bar1_prefetchable_hwtcl            ),
         .PF0_VF_BAR2_PREFETCHABLE                 (pf0_vf_bar2_prefetchable_hwtcl            ),
         .PF1_VF_BAR2_PREFETCHABLE                 (pf1_vf_bar2_prefetchable_hwtcl            ),
         .PF0_VF_BAR3_PREFETCHABLE                 (pf0_vf_bar3_prefetchable_hwtcl            ),
         .PF1_VF_BAR3_PREFETCHABLE                 (pf1_vf_bar3_prefetchable_hwtcl            ),
         .PF0_VF_BAR4_PREFETCHABLE                 (pf0_vf_bar4_prefetchable_hwtcl            ),
         .PF1_VF_BAR4_PREFETCHABLE                 (pf1_vf_bar4_prefetchable_hwtcl            ),
         .PF0_VF_BAR5_PREFETCHABLE                 (pf0_vf_bar5_prefetchable_hwtcl            ),
         .PF1_VF_BAR5_PREFETCHABLE                 (pf1_vf_bar5_prefetchable_hwtcl            ),
         .PF0_VF_BAR0_SIZE                         (pf0_vf_bar0_size_hwtcl                    ),
         .PF1_VF_BAR0_SIZE                         (pf1_vf_bar0_size_hwtcl                    ),
         .PF0_VF_BAR1_SIZE                         (pf0_vf_bar1_size_hwtcl                    ),
         .PF1_VF_BAR1_SIZE                         (pf1_vf_bar1_size_hwtcl                    ),
         .PF0_VF_BAR2_SIZE                         (pf0_vf_bar2_size_hwtcl                    ),
         .PF1_VF_BAR2_SIZE                         (pf1_vf_bar2_size_hwtcl                    ),
         .PF0_VF_BAR3_SIZE                         (pf0_vf_bar3_size_hwtcl                    ),
         .PF1_VF_BAR3_SIZE                         (pf1_vf_bar3_size_hwtcl                    ),
         .PF0_VF_BAR4_SIZE                         (pf0_vf_bar4_size_hwtcl                    ),
         .PF1_VF_BAR4_SIZE                         (pf1_vf_bar4_size_hwtcl                    ),
         .PF0_VF_BAR5_SIZE                         (pf0_vf_bar5_size_hwtcl                    ),
         .PF1_VF_BAR5_SIZE                         (pf1_vf_bar5_size_hwtcl                    ),
         .PF2_VF_BAR0_PRESENT                      (pf2_vf_bar0_present_hwtcl                 ),
         .PF3_VF_BAR0_PRESENT                      (pf3_vf_bar0_present_hwtcl                 ),
         .PF2_VF_BAR1_PRESENT                      (pf2_vf_bar1_present_hwtcl                 ),
         .PF3_VF_BAR1_PRESENT                      (pf3_vf_bar1_present_hwtcl                 ),
         .PF2_VF_BAR2_PRESENT                      (pf2_vf_bar2_present_hwtcl                 ),
         .PF3_VF_BAR2_PRESENT                      (pf3_vf_bar2_present_hwtcl                 ),
         .PF2_VF_BAR3_PRESENT                      (pf2_vf_bar3_present_hwtcl                 ),
         .PF3_VF_BAR3_PRESENT                      (pf3_vf_bar3_present_hwtcl                 ),
         .PF2_VF_BAR4_PRESENT                      (pf2_vf_bar4_present_hwtcl                 ),
         .PF3_VF_BAR4_PRESENT                      (pf3_vf_bar4_present_hwtcl                 ),
         .PF2_VF_BAR5_PRESENT                      (pf2_vf_bar5_present_hwtcl                 ),
         .PF3_VF_BAR5_PRESENT                      (pf3_vf_bar5_present_hwtcl                 ),
         .PF2_VF_BAR0_TYPE                         (pf2_vf_bar0_type_hwtcl                    ),
         .PF3_VF_BAR0_TYPE                         (pf3_vf_bar0_type_hwtcl                    ),
         .PF2_VF_BAR2_TYPE                         (pf2_vf_bar2_type_hwtcl                    ),
         .PF3_VF_BAR2_TYPE                         (pf3_vf_bar2_type_hwtcl                    ),
         .PF2_VF_BAR4_TYPE                         (pf2_vf_bar4_type_hwtcl                    ),
         .PF3_VF_BAR4_TYPE                         (pf3_vf_bar4_type_hwtcl                    ),
         .PF2_VF_BAR0_PREFETCHABLE                 (pf2_vf_bar0_prefetchable_hwtcl            ),
         .PF3_VF_BAR0_PREFETCHABLE                 (pf3_vf_bar0_prefetchable_hwtcl            ),
         .PF2_VF_BAR1_PREFETCHABLE                 (pf2_vf_bar1_prefetchable_hwtcl            ),
         .PF3_VF_BAR1_PREFETCHABLE                 (pf3_vf_bar1_prefetchable_hwtcl            ),
         .PF2_VF_BAR2_PREFETCHABLE                 (pf2_vf_bar2_prefetchable_hwtcl            ),
         .PF3_VF_BAR2_PREFETCHABLE                 (pf3_vf_bar2_prefetchable_hwtcl            ),
         .PF2_VF_BAR3_PREFETCHABLE                 (pf2_vf_bar3_prefetchable_hwtcl            ),
         .PF3_VF_BAR3_PREFETCHABLE                 (pf3_vf_bar3_prefetchable_hwtcl            ),
         .PF2_VF_BAR4_PREFETCHABLE                 (pf2_vf_bar4_prefetchable_hwtcl            ),
         .PF3_VF_BAR4_PREFETCHABLE                 (pf3_vf_bar4_prefetchable_hwtcl            ),
         .PF2_VF_BAR5_PREFETCHABLE                 (pf2_vf_bar5_prefetchable_hwtcl            ),
         .PF3_VF_BAR5_PREFETCHABLE                 (pf3_vf_bar5_prefetchable_hwtcl            ),
         .PF2_VF_BAR0_SIZE                         (pf2_vf_bar0_size_hwtcl                    ),
         .PF3_VF_BAR0_SIZE                         (pf3_vf_bar0_size_hwtcl                    ),
         .PF2_VF_BAR1_SIZE                         (pf2_vf_bar1_size_hwtcl                    ),
         .PF3_VF_BAR1_SIZE                         (pf3_vf_bar1_size_hwtcl                    ),
         .PF2_VF_BAR2_SIZE                         (pf2_vf_bar2_size_hwtcl                    ),
         .PF3_VF_BAR2_SIZE                         (pf3_vf_bar2_size_hwtcl                    ),
         .PF2_VF_BAR3_SIZE                         (pf2_vf_bar3_size_hwtcl                    ),
         .PF3_VF_BAR3_SIZE                         (pf3_vf_bar3_size_hwtcl                    ),
         .PF2_VF_BAR4_SIZE                         (pf2_vf_bar4_size_hwtcl                    ),
         .PF3_VF_BAR4_SIZE                         (pf3_vf_bar4_size_hwtcl                    ),
         .PF2_VF_BAR5_SIZE                         (pf2_vf_bar5_size_hwtcl                    ),
         .PF3_VF_BAR5_SIZE                         (pf3_vf_bar5_size_hwtcl                    ),
         .PF_TPH_SUPPORT                           (pf_tph_support_hwtcl                      ),
         .PF0_TPH_INT_MODE_SUPPORT                 (pf0_tph_int_mode_support_hwtcl            ),
         .PF1_TPH_INT_MODE_SUPPORT                 (pf1_tph_int_mode_support_hwtcl            ),
         .PF2_TPH_INT_MODE_SUPPORT                 (pf2_tph_int_mode_support_hwtcl            ),
         .PF3_TPH_INT_MODE_SUPPORT                 (pf3_tph_int_mode_support_hwtcl            ),
         .PF0_TPH_DEV_SPECIFIC_MODE_SUPPORT        (pf0_tph_dev_specific_mode_support_hwtcl   ),
         .PF1_TPH_DEV_SPECIFIC_MODE_SUPPORT        (pf1_tph_dev_specific_mode_support_hwtcl   ),
         .PF2_TPH_DEV_SPECIFIC_MODE_SUPPORT        (pf2_tph_dev_specific_mode_support_hwtcl   ),
         .PF3_TPH_DEV_SPECIFIC_MODE_SUPPORT        (pf3_tph_dev_specific_mode_support_hwtcl   ),
         .PF0_TPH_ST_TABLE_LOCATION                (pf0_tph_st_table_location_hwtcl           ),
         .PF1_TPH_ST_TABLE_LOCATION                (pf1_tph_st_table_location_hwtcl           ),
         .PF2_TPH_ST_TABLE_LOCATION                (pf2_tph_st_table_location_hwtcl           ),
         .PF3_TPH_ST_TABLE_LOCATION                (pf3_tph_st_table_location_hwtcl           ),
         .PF0_TPH_ST_TABLE_SIZE                    (pf0_tph_st_table_size_hwtcl               ),
         .PF1_TPH_ST_TABLE_SIZE                    (pf1_tph_st_table_size_hwtcl               ),
         .PF2_TPH_ST_TABLE_SIZE                    (pf2_tph_st_table_size_hwtcl               ),
         .PF3_TPH_ST_TABLE_SIZE                    (pf3_tph_st_table_size_hwtcl               ),
         .VF_TPH_SUPPORT                           (vf_tph_support_hwtcl                      ),
         .PF0_VF_TPH_INT_MODE_SUPPORT              (pf0_vf_tph_int_mode_support_hwtcl         ),
         .PF1_VF_TPH_INT_MODE_SUPPORT              (pf1_vf_tph_int_mode_support_hwtcl         ),
         .PF2_VF_TPH_INT_MODE_SUPPORT              (pf2_vf_tph_int_mode_support_hwtcl         ),
         .PF3_VF_TPH_INT_MODE_SUPPORT              (pf3_vf_tph_int_mode_support_hwtcl         ),
         .PF0_VF_TPH_DEV_SPECIFIC_MODE_SUPPORT     (pf0_vf_tph_dev_specific_mode_support_hwtcl),
         .PF1_VF_TPH_DEV_SPECIFIC_MODE_SUPPORT     (pf1_vf_tph_dev_specific_mode_support_hwtcl),
         .PF2_VF_TPH_DEV_SPECIFIC_MODE_SUPPORT     (pf2_vf_tph_dev_specific_mode_support_hwtcl),
         .PF3_VF_TPH_DEV_SPECIFIC_MODE_SUPPORT     (pf3_vf_tph_dev_specific_mode_support_hwtcl),
         .PF0_VF_TPH_ST_TABLE_LOCATION             (pf0_vf_tph_st_table_location_hwtcl        ),
         .PF1_VF_TPH_ST_TABLE_LOCATION             (pf1_vf_tph_st_table_location_hwtcl        ),
         .PF2_VF_TPH_ST_TABLE_LOCATION             (pf2_vf_tph_st_table_location_hwtcl        ),
         .PF3_VF_TPH_ST_TABLE_LOCATION             (pf3_vf_tph_st_table_location_hwtcl        ),
         .PF0_VF_TPH_ST_TABLE_SIZE                 (pf0_vf_tph_st_table_size_hwtcl            ),
         .PF1_VF_TPH_ST_TABLE_SIZE                 (pf1_vf_tph_st_table_size_hwtcl            ),
         .PF2_VF_TPH_ST_TABLE_SIZE                 (pf2_vf_tph_st_table_size_hwtcl            ),
         .PF3_VF_TPH_ST_TABLE_SIZE                 (pf3_vf_tph_st_table_size_hwtcl            ),
         .PF_ATS_SUPPORT                           (pf_ats_support_hwtcl                      ),
         .PF0_ATS_INVALIDATE_QUEUE_DEPTH           (pf0_ats_invalidate_queue_depth_hwtcl      ),
         .PF1_ATS_INVALIDATE_QUEUE_DEPTH           (pf1_ats_invalidate_queue_depth_hwtcl      ),
         .PF2_ATS_INVALIDATE_QUEUE_DEPTH           (pf2_ats_invalidate_queue_depth_hwtcl      ),
         .PF3_ATS_INVALIDATE_QUEUE_DEPTH           (pf3_ats_invalidate_queue_depth_hwtcl      ),
         .VF_ATS_SUPPORT                           (vf_ats_support_hwtcl                      ),
         // VirtIO Specific Parameters PF0
         .PF0_VIRTIO_CAPABILITY_PRESENT                 (pf0_virtio_capability_present_hwtcl                ),
         .PF0_VIRTIO_DEVICE_SPECIFIC_CAP_PRESENT        (pf0_virtio_device_specific_cap_present_hwtcl       ),                                                         
         .PF0_VIRTIO_CMN_CONFIG_BAR_INDICATOR           (pf0_virtio_cmn_config_bar_indicator_hwtcl          ),
         .PF0_VIRTIO_NOTIFICATION_BAR_INDICATOR         (pf0_virtio_notification_bar_indicator_hwtcl        ),
         .PF0_VIRTIO_ISRSTATUS_BAR_INDICATOR            (pf0_virtio_isrstatus_bar_indicator_hwtcl           ),
         .PF0_VIRTIO_PCICONFIG_ACCESS_BAR_INDICATOR     (pf0_virtio_pciconfig_access_bar_indicator_hwtcl    ),
         .PF0_VIRTIO_DEVSPECIFIC_BAR_INDICATOR          (pf0_virtio_devspecific_bar_indicator_hwtcl         ),                                                                                                          
         .PF0_VIRTIO_CMN_CONFIG_BAR_OFFSET              (pf0_virtio_cmn_config_bar_offset_hwtcl             ),
         .PF0_VIRTIO_NOTIFICATION_BAR_OFFSET            (pf0_virtio_notification_bar_offset_hwtcl           ),
         .PF0_VIRTIO_ISRSTATUS_BAR_OFFSET               (pf0_virtio_isrstatus_bar_offset_hwtcl              ),
         .PF0_VIRTIO_PCICONFIG_ACCESS_BAR_OFFSET        (pf0_virtio_pciconfig_access_bar_offset_hwtcl       ),
         .PF0_VIRTIO_DEVSPECIFIC_BAR_OFFSET             (pf0_virtio_devspecific_bar_offset_hwtcl            ),                                                                                                          
         .PF0_VIRTIO_CMN_CONFIG_STRUCTURE_LENGTH        (pf0_virtio_cmn_config_structure_length_hwtcl       ),
         .PF0_VIRTIO_NOTIFICATION_STRUCTURE_LENGTH      (pf0_virtio_notification_structure_length_hwtcl     ),
         .PF0_VIRTIO_ISRSTATUS_STRUCTURE_LENGTH         (pf0_virtio_isrstatus_structure_length_hwtcl        ),
         .PF0_VIRTIO_PCICONFIG_ACCESS_STRUCTURE_LENGTH  (pf0_virtio_pciconfig_access_structure_length_hwtcl ),
         .PF0_VIRTIO_DEVSPECIFIC_STRUCTURE_LENGTH       (pf0_virtio_devspecific_structure_length_hwtcl      ),         
         .PF0_VIRTIO_NOTIFY_OFF_MULTIPLIER              (pf0_virtio_notify_off_multiplier_hwtcl             ), 
      // VirtIO Specific Parameters PF1
         .PF1_VIRTIO_CAPABILITY_PRESENT                 (pf1_virtio_capability_present_hwtcl                ),
         .PF1_VIRTIO_DEVICE_SPECIFIC_CAP_PRESENT        (pf1_virtio_device_specific_cap_present_hwtcl       ),                                                         
         .PF1_VIRTIO_CMN_CONFIG_BAR_INDICATOR           (pf1_virtio_cmn_config_bar_indicator_hwtcl          ),
         .PF1_VIRTIO_NOTIFICATION_BAR_INDICATOR         (pf1_virtio_notification_bar_indicator_hwtcl        ),
         .PF1_VIRTIO_ISRSTATUS_BAR_INDICATOR            (pf1_virtio_isrstatus_bar_indicator_hwtcl           ),
         .PF1_VIRTIO_PCICONFIG_ACCESS_BAR_INDICATOR     (pf1_virtio_pciconfig_access_bar_indicator_hwtcl    ),
         .PF1_VIRTIO_DEVSPECIFIC_BAR_INDICATOR          (pf1_virtio_devspecific_bar_indicator_hwtcl         ),                                                                                                          
         .PF1_VIRTIO_CMN_CONFIG_BAR_OFFSET              (pf1_virtio_cmn_config_bar_offset_hwtcl             ),
         .PF1_VIRTIO_NOTIFICATION_BAR_OFFSET            (pf1_virtio_notification_bar_offset_hwtcl           ),
         .PF1_VIRTIO_ISRSTATUS_BAR_OFFSET               (pf1_virtio_isrstatus_bar_offset_hwtcl              ),
         .PF1_VIRTIO_PCICONFIG_ACCESS_BAR_OFFSET        (pf1_virtio_pciconfig_access_bar_offset_hwtcl       ),
         .PF1_VIRTIO_DEVSPECIFIC_BAR_OFFSET             (pf1_virtio_devspecific_bar_offset_hwtcl            ),                                                                                                          
         .PF1_VIRTIO_CMN_CONFIG_STRUCTURE_LENGTH        (pf1_virtio_cmn_config_structure_length_hwtcl       ),
         .PF1_VIRTIO_NOTIFICATION_STRUCTURE_LENGTH      (pf1_virtio_notification_structure_length_hwtcl     ),
         .PF1_VIRTIO_ISRSTATUS_STRUCTURE_LENGTH         (pf1_virtio_isrstatus_structure_length_hwtcl        ),
         .PF1_VIRTIO_PCICONFIG_ACCESS_STRUCTURE_LENGTH  (pf1_virtio_pciconfig_access_structure_length_hwtcl ),
         .PF1_VIRTIO_DEVSPECIFIC_STRUCTURE_LENGTH       (pf1_virtio_devspecific_structure_length_hwtcl      ),
         .PF1_VIRTIO_NOTIFY_OFF_MULTIPLIER              (pf1_virtio_notify_off_multiplier_hwtcl             ),
      // VirtIO Specific Parameters PF2
         .PF2_VIRTIO_CAPABILITY_PRESENT                 (pf2_virtio_capability_present_hwtcl                ),
         .PF2_VIRTIO_DEVICE_SPECIFIC_CAP_PRESENT        (pf2_virtio_device_specific_cap_present_hwtcl       ),                                                         
         .PF2_VIRTIO_CMN_CONFIG_BAR_INDICATOR           (pf2_virtio_cmn_config_bar_indicator_hwtcl          ),
         .PF2_VIRTIO_NOTIFICATION_BAR_INDICATOR         (pf2_virtio_notification_bar_indicator_hwtcl        ),
         .PF2_VIRTIO_ISRSTATUS_BAR_INDICATOR            (pf2_virtio_isrstatus_bar_indicator_hwtcl           ),
         .PF2_VIRTIO_PCICONFIG_ACCESS_BAR_INDICATOR     (pf2_virtio_pciconfig_access_bar_indicator_hwtcl    ),
         .PF2_VIRTIO_DEVSPECIFIC_BAR_INDICATOR          (pf2_virtio_devspecific_bar_indicator_hwtcl         ),                                                                                                          
         .PF2_VIRTIO_CMN_CONFIG_BAR_OFFSET              (pf2_virtio_cmn_config_bar_offset_hwtcl             ),
         .PF2_VIRTIO_NOTIFICATION_BAR_OFFSET            (pf2_virtio_notification_bar_offset_hwtcl           ),
         .PF2_VIRTIO_ISRSTATUS_BAR_OFFSET               (pf2_virtio_isrstatus_bar_offset_hwtcl              ),
         .PF2_VIRTIO_PCICONFIG_ACCESS_BAR_OFFSET        (pf2_virtio_pciconfig_access_bar_offset_hwtcl       ),
         .PF2_VIRTIO_DEVSPECIFIC_BAR_OFFSET             (pf2_virtio_devspecific_bar_offset_hwtcl            ),                                                                                                          
         .PF2_VIRTIO_CMN_CONFIG_STRUCTURE_LENGTH        (pf2_virtio_cmn_config_structure_length_hwtcl       ),
         .PF2_VIRTIO_NOTIFICATION_STRUCTURE_LENGTH      (pf2_virtio_notification_structure_length_hwtcl     ),
         .PF2_VIRTIO_ISRSTATUS_STRUCTURE_LENGTH         (pf2_virtio_isrstatus_structure_length_hwtcl        ),
         .PF2_VIRTIO_PCICONFIG_ACCESS_STRUCTURE_LENGTH  (pf2_virtio_pciconfig_access_structure_length_hwtcl ),
         .PF2_VIRTIO_DEVSPECIFIC_STRUCTURE_LENGTH       (pf2_virtio_devspecific_structure_length_hwtcl      ),         
         .PF2_VIRTIO_NOTIFY_OFF_MULTIPLIER              (pf2_virtio_notify_off_multiplier_hwtcl             ),
      // VirtIO Specific Parameters PF3
         .PF3_VIRTIO_CAPABILITY_PRESENT                 (pf3_virtio_capability_present_hwtcl                ),
         .PF3_VIRTIO_DEVICE_SPECIFIC_CAP_PRESENT        (pf3_virtio_device_specific_cap_present_hwtcl       ),                                                         
         .PF3_VIRTIO_CMN_CONFIG_BAR_INDICATOR           (pf3_virtio_cmn_config_bar_indicator_hwtcl          ),
         .PF3_VIRTIO_NOTIFICATION_BAR_INDICATOR         (pf3_virtio_notification_bar_indicator_hwtcl        ),
         .PF3_VIRTIO_ISRSTATUS_BAR_INDICATOR            (pf3_virtio_isrstatus_bar_indicator_hwtcl           ),
         .PF3_VIRTIO_PCICONFIG_ACCESS_BAR_INDICATOR     (pf3_virtio_pciconfig_access_bar_indicator_hwtcl    ),
         .PF3_VIRTIO_DEVSPECIFIC_BAR_INDICATOR          (pf3_virtio_devspecific_bar_indicator_hwtcl         ),                                                                                                          
         .PF3_VIRTIO_CMN_CONFIG_BAR_OFFSET              (pf3_virtio_cmn_config_bar_offset_hwtcl             ),
         .PF3_VIRTIO_NOTIFICATION_BAR_OFFSET            (pf3_virtio_notification_bar_offset_hwtcl           ),
         .PF3_VIRTIO_ISRSTATUS_BAR_OFFSET               (pf3_virtio_isrstatus_bar_offset_hwtcl              ),
         .PF3_VIRTIO_PCICONFIG_ACCESS_BAR_OFFSET        (pf3_virtio_pciconfig_access_bar_offset_hwtcl       ),
         .PF3_VIRTIO_DEVSPECIFIC_BAR_OFFSET             (pf3_virtio_devspecific_bar_offset_hwtcl            ),                                                                                                          
         .PF3_VIRTIO_CMN_CONFIG_STRUCTURE_LENGTH        (pf3_virtio_cmn_config_structure_length_hwtcl       ),
         .PF3_VIRTIO_NOTIFICATION_STRUCTURE_LENGTH      (pf3_virtio_notification_structure_length_hwtcl     ),
         .PF3_VIRTIO_ISRSTATUS_STRUCTURE_LENGTH         (pf3_virtio_isrstatus_structure_length_hwtcl        ),
         .PF3_VIRTIO_PCICONFIG_ACCESS_STRUCTURE_LENGTH  (pf3_virtio_pciconfig_access_structure_length_hwtcl ),
         .PF3_VIRTIO_DEVSPECIFIC_STRUCTURE_LENGTH       (pf3_virtio_devspecific_structure_length_hwtcl      ),
         .PF3_VIRTIO_NOTIFY_OFF_MULTIPLIER              (pf3_virtio_notify_off_multiplier_hwtcl             ),
      // VirtIO Specific Parameters PF4
         .PF4_VIRTIO_CAPABILITY_PRESENT                 (pf4_virtio_capability_present_hwtcl                ),
         .PF4_VIRTIO_DEVICE_SPECIFIC_CAP_PRESENT        (pf4_virtio_device_specific_cap_present_hwtcl       ),                                                         
         .PF4_VIRTIO_CMN_CONFIG_BAR_INDICATOR           (pf4_virtio_cmn_config_bar_indicator_hwtcl          ),
         .PF4_VIRTIO_NOTIFICATION_BAR_INDICATOR         (pf4_virtio_notification_bar_indicator_hwtcl        ),
         .PF4_VIRTIO_ISRSTATUS_BAR_INDICATOR            (pf4_virtio_isrstatus_bar_indicator_hwtcl           ),
         .PF4_VIRTIO_PCICONFIG_ACCESS_BAR_INDICATOR     (pf4_virtio_pciconfig_access_bar_indicator_hwtcl    ),
         .PF4_VIRTIO_DEVSPECIFIC_BAR_INDICATOR          (pf4_virtio_devspecific_bar_indicator_hwtcl         ),                                                                                                          
         .PF4_VIRTIO_CMN_CONFIG_BAR_OFFSET              (pf4_virtio_cmn_config_bar_offset_hwtcl             ),
         .PF4_VIRTIO_NOTIFICATION_BAR_OFFSET            (pf4_virtio_notification_bar_offset_hwtcl           ),
         .PF4_VIRTIO_ISRSTATUS_BAR_OFFSET               (pf4_virtio_isrstatus_bar_offset_hwtcl              ),
         .PF4_VIRTIO_PCICONFIG_ACCESS_BAR_OFFSET        (pf4_virtio_pciconfig_access_bar_offset_hwtcl       ),
         .PF4_VIRTIO_DEVSPECIFIC_BAR_OFFSET             (pf4_virtio_devspecific_bar_offset_hwtcl            ),                                                                                                          
         .PF4_VIRTIO_CMN_CONFIG_STRUCTURE_LENGTH        (pf4_virtio_cmn_config_structure_length_hwtcl       ),
         .PF4_VIRTIO_NOTIFICATION_STRUCTURE_LENGTH      (pf4_virtio_notification_structure_length_hwtcl     ),
         .PF4_VIRTIO_ISRSTATUS_STRUCTURE_LENGTH         (pf4_virtio_isrstatus_structure_length_hwtcl        ),
         .PF4_VIRTIO_PCICONFIG_ACCESS_STRUCTURE_LENGTH  (pf4_virtio_pciconfig_access_structure_length_hwtcl ),
         .PF4_VIRTIO_DEVSPECIFIC_STRUCTURE_LENGTH       (pf4_virtio_devspecific_structure_length_hwtcl      ),
         .PF4_VIRTIO_NOTIFY_OFF_MULTIPLIER              (pf4_virtio_notify_off_multiplier_hwtcl             ),
      // VirtIO Specific Parameters PF5
         .PF5_VIRTIO_CAPABILITY_PRESENT                 (pf5_virtio_capability_present_hwtcl                ),
         .PF5_VIRTIO_DEVICE_SPECIFIC_CAP_PRESENT        (pf5_virtio_device_specific_cap_present_hwtcl       ),                                                         
         .PF5_VIRTIO_CMN_CONFIG_BAR_INDICATOR           (pf5_virtio_cmn_config_bar_indicator_hwtcl          ),
         .PF5_VIRTIO_NOTIFICATION_BAR_INDICATOR         (pf5_virtio_notification_bar_indicator_hwtcl        ),
         .PF5_VIRTIO_ISRSTATUS_BAR_INDICATOR            (pf5_virtio_isrstatus_bar_indicator_hwtcl           ),
         .PF5_VIRTIO_PCICONFIG_ACCESS_BAR_INDICATOR     (pf5_virtio_pciconfig_access_bar_indicator_hwtcl    ),
         .PF5_VIRTIO_DEVSPECIFIC_BAR_INDICATOR          (pf5_virtio_devspecific_bar_indicator_hwtcl         ),                                                                                                          
         .PF5_VIRTIO_CMN_CONFIG_BAR_OFFSET              (pf5_virtio_cmn_config_bar_offset_hwtcl             ),
         .PF5_VIRTIO_NOTIFICATION_BAR_OFFSET            (pf5_virtio_notification_bar_offset_hwtcl           ),
         .PF5_VIRTIO_ISRSTATUS_BAR_OFFSET               (pf5_virtio_isrstatus_bar_offset_hwtcl              ),
         .PF5_VIRTIO_PCICONFIG_ACCESS_BAR_OFFSET        (pf5_virtio_pciconfig_access_bar_offset_hwtcl       ),
         .PF5_VIRTIO_DEVSPECIFIC_BAR_OFFSET             (pf5_virtio_devspecific_bar_offset_hwtcl            ),                                                                                                          
         .PF5_VIRTIO_CMN_CONFIG_STRUCTURE_LENGTH        (pf5_virtio_cmn_config_structure_length_hwtcl       ),
         .PF5_VIRTIO_NOTIFICATION_STRUCTURE_LENGTH      (pf5_virtio_notification_structure_length_hwtcl     ),
         .PF5_VIRTIO_ISRSTATUS_STRUCTURE_LENGTH         (pf5_virtio_isrstatus_structure_length_hwtcl        ),
         .PF5_VIRTIO_PCICONFIG_ACCESS_STRUCTURE_LENGTH  (pf5_virtio_pciconfig_access_structure_length_hwtcl ),
         .PF5_VIRTIO_DEVSPECIFIC_STRUCTURE_LENGTH       (pf5_virtio_devspecific_structure_length_hwtcl      ),
         .PF5_VIRTIO_NOTIFY_OFF_MULTIPLIER              (pf5_virtio_notify_off_multiplier_hwtcl             ),
      // VirtIO Specific Parameters PF6
         .PF6_VIRTIO_CAPABILITY_PRESENT                 (pf6_virtio_capability_present_hwtcl                ),
         .PF6_VIRTIO_DEVICE_SPECIFIC_CAP_PRESENT        (pf6_virtio_device_specific_cap_present_hwtcl       ),                                                         
         .PF6_VIRTIO_CMN_CONFIG_BAR_INDICATOR           (pf6_virtio_cmn_config_bar_indicator_hwtcl          ),
         .PF6_VIRTIO_NOTIFICATION_BAR_INDICATOR         (pf6_virtio_notification_bar_indicator_hwtcl        ),
         .PF6_VIRTIO_ISRSTATUS_BAR_INDICATOR            (pf6_virtio_isrstatus_bar_indicator_hwtcl           ),
         .PF6_VIRTIO_PCICONFIG_ACCESS_BAR_INDICATOR     (pf6_virtio_pciconfig_access_bar_indicator_hwtcl    ),
         .PF6_VIRTIO_DEVSPECIFIC_BAR_INDICATOR          (pf6_virtio_devspecific_bar_indicator_hwtcl         ),                                                                                                          
         .PF6_VIRTIO_CMN_CONFIG_BAR_OFFSET              (pf6_virtio_cmn_config_bar_offset_hwtcl             ),
         .PF6_VIRTIO_NOTIFICATION_BAR_OFFSET            (pf6_virtio_notification_bar_offset_hwtcl           ),
         .PF6_VIRTIO_ISRSTATUS_BAR_OFFSET               (pf6_virtio_isrstatus_bar_offset_hwtcl              ),
         .PF6_VIRTIO_PCICONFIG_ACCESS_BAR_OFFSET        (pf6_virtio_pciconfig_access_bar_offset_hwtcl       ),
         .PF6_VIRTIO_DEVSPECIFIC_BAR_OFFSET             (pf6_virtio_devspecific_bar_offset_hwtcl            ),                                                                                                          
         .PF6_VIRTIO_CMN_CONFIG_STRUCTURE_LENGTH        (pf6_virtio_cmn_config_structure_length_hwtcl       ),
         .PF6_VIRTIO_NOTIFICATION_STRUCTURE_LENGTH      (pf6_virtio_notification_structure_length_hwtcl     ),
         .PF6_VIRTIO_ISRSTATUS_STRUCTURE_LENGTH         (pf6_virtio_isrstatus_structure_length_hwtcl        ),
         .PF6_VIRTIO_PCICONFIG_ACCESS_STRUCTURE_LENGTH  (pf6_virtio_pciconfig_access_structure_length_hwtcl ),
         .PF6_VIRTIO_DEVSPECIFIC_STRUCTURE_LENGTH       (pf6_virtio_devspecific_structure_length_hwtcl      ),
         .PF6_VIRTIO_NOTIFY_OFF_MULTIPLIER              (pf6_virtio_notify_off_multiplier_hwtcl             ),
      // VirtIO Specific Parameters PF7
         .PF7_VIRTIO_CAPABILITY_PRESENT                 (pf7_virtio_capability_present_hwtcl                ),
         .PF7_VIRTIO_DEVICE_SPECIFIC_CAP_PRESENT        (pf7_virtio_device_specific_cap_present_hwtcl       ),                                                         
         .PF7_VIRTIO_CMN_CONFIG_BAR_INDICATOR           (pf7_virtio_cmn_config_bar_indicator_hwtcl          ),
         .PF7_VIRTIO_NOTIFICATION_BAR_INDICATOR         (pf7_virtio_notification_bar_indicator_hwtcl        ),
         .PF7_VIRTIO_ISRSTATUS_BAR_INDICATOR            (pf7_virtio_isrstatus_bar_indicator_hwtcl           ),
         .PF7_VIRTIO_PCICONFIG_ACCESS_BAR_INDICATOR     (pf7_virtio_pciconfig_access_bar_indicator_hwtcl    ),
         .PF7_VIRTIO_DEVSPECIFIC_BAR_INDICATOR          (pf7_virtio_devspecific_bar_indicator_hwtcl         ),                                                                                                          
         .PF7_VIRTIO_CMN_CONFIG_BAR_OFFSET              (pf7_virtio_cmn_config_bar_offset_hwtcl             ),
         .PF7_VIRTIO_NOTIFICATION_BAR_OFFSET            (pf7_virtio_notification_bar_offset_hwtcl           ),
         .PF7_VIRTIO_ISRSTATUS_BAR_OFFSET               (pf7_virtio_isrstatus_bar_offset_hwtcl              ),
         .PF7_VIRTIO_PCICONFIG_ACCESS_BAR_OFFSET        (pf7_virtio_pciconfig_access_bar_offset_hwtcl       ),
         .PF7_VIRTIO_DEVSPECIFIC_BAR_OFFSET             (pf7_virtio_devspecific_bar_offset_hwtcl            ),                                                                                                          
         .PF7_VIRTIO_CMN_CONFIG_STRUCTURE_LENGTH        (pf7_virtio_cmn_config_structure_length_hwtcl       ),
         .PF7_VIRTIO_NOTIFICATION_STRUCTURE_LENGTH      (pf7_virtio_notification_structure_length_hwtcl     ),
         .PF7_VIRTIO_ISRSTATUS_STRUCTURE_LENGTH         (pf7_virtio_isrstatus_structure_length_hwtcl        ),
         .PF7_VIRTIO_PCICONFIG_ACCESS_STRUCTURE_LENGTH  (pf7_virtio_pciconfig_access_structure_length_hwtcl ),
         .PF7_VIRTIO_DEVSPECIFIC_STRUCTURE_LENGTH       (pf7_virtio_devspecific_structure_length_hwtcl      ),
         .PF7_VIRTIO_NOTIFY_OFF_MULTIPLIER              (pf7_virtio_notify_off_multiplier_hwtcl             ),
      // VirtIO Specific Parameters PF0 VFs
         .PF0VF_VIRTIO_CAPABILITY_PRESENT               (pf0vf_virtio_capability_present_hwtcl                ),
         .PF0VF_VIRTIO_DEVICE_SPECIFIC_CAP_PRESENT      (pf0vf_virtio_device_specific_cap_present_hwtcl       ),                                                         
         .PF0VF_VIRTIO_CMN_CONFIG_BAR_INDICATOR         (pf0vf_virtio_cmn_config_bar_indicator_hwtcl          ),
         .PF0VF_VIRTIO_NOTIFICATION_BAR_INDICATOR       (pf0vf_virtio_notification_bar_indicator_hwtcl        ),
         .PF0VF_VIRTIO_ISRSTATUS_BAR_INDICATOR          (pf0vf_virtio_isrstatus_bar_indicator_hwtcl           ),
         .PF0VF_VIRTIO_PCICONFIG_ACCESS_BAR_INDICATOR   (pf0vf_virtio_pciconfig_access_bar_indicator_hwtcl    ),
         .PF0VF_VIRTIO_DEVSPECIFIC_BAR_INDICATOR        (pf0vf_virtio_devspecific_bar_indicator_hwtcl         ),                                                                                                          
         .PF0VF_VIRTIO_CMN_CONFIG_BAR_OFFSET            (pf0vf_virtio_cmn_config_bar_offset_hwtcl             ),
         .PF0VF_VIRTIO_NOTIFICATION_BAR_OFFSET          (pf0vf_virtio_notification_bar_offset_hwtcl           ),
         .PF0VF_VIRTIO_ISRSTATUS_BAR_OFFSET             (pf0vf_virtio_isrstatus_bar_offset_hwtcl              ),
         .PF0VF_VIRTIO_PCICONFIG_ACCESS_BAR_OFFSET      (pf0vf_virtio_pciconfig_access_bar_offset_hwtcl       ),
         .PF0VF_VIRTIO_DEVSPECIFIC_BAR_OFFSET           (pf0vf_virtio_devspecific_bar_offset_hwtcl            ),                                                                                                          
         .PF0VF_VIRTIO_CMN_CONFIG_STRUCTURE_LENGTH      (pf0vf_virtio_cmn_config_structure_length_hwtcl       ),
         .PF0VF_VIRTIO_NOTIFICATION_STRUCTURE_LENGTH    (pf0vf_virtio_notification_structure_length_hwtcl     ),
         .PF0VF_VIRTIO_ISRSTATUS_STRUCTURE_LENGTH       (pf0vf_virtio_isrstatus_structure_length_hwtcl        ),
         .PF0VF_VIRTIO_PCICONFIG_ACCESS_STRUCTURE_LENGTH(pf0vf_virtio_pciconfig_access_structure_length_hwtcl ),
         .PF0VF_VIRTIO_DEVSPECIFIC_STRUCTURE_LENGTH     (pf0vf_virtio_devspecific_structure_length_hwtcl      ),         
         .PF0VF_VIRTIO_NOTIFY_OFF_MULTIPLIER            (pf0vf_virtio_notify_off_multiplier_hwtcl             ), 
      // VirtIO Specific Parameters PF1 VFs
         .PF1VF_VIRTIO_CAPABILITY_PRESENT               (pf1vf_virtio_capability_present_hwtcl                ),
         .PF1VF_VIRTIO_DEVICE_SPECIFIC_CAP_PRESENT      (pf1vf_virtio_device_specific_cap_present_hwtcl       ),                                                         
         .PF1VF_VIRTIO_CMN_CONFIG_BAR_INDICATOR         (pf1vf_virtio_cmn_config_bar_indicator_hwtcl          ),
         .PF1VF_VIRTIO_NOTIFICATION_BAR_INDICATOR       (pf1vf_virtio_notification_bar_indicator_hwtcl        ),
         .PF1VF_VIRTIO_ISRSTATUS_BAR_INDICATOR          (pf1vf_virtio_isrstatus_bar_indicator_hwtcl           ),
         .PF1VF_VIRTIO_PCICONFIG_ACCESS_BAR_INDICATOR   (pf1vf_virtio_pciconfig_access_bar_indicator_hwtcl    ),
         .PF1VF_VIRTIO_DEVSPECIFIC_BAR_INDICATOR        (pf1vf_virtio_devspecific_bar_indicator_hwtcl         ),                                                                                                          
         .PF1VF_VIRTIO_CMN_CONFIG_BAR_OFFSET            (pf1vf_virtio_cmn_config_bar_offset_hwtcl             ),
         .PF1VF_VIRTIO_NOTIFICATION_BAR_OFFSET          (pf1vf_virtio_notification_bar_offset_hwtcl           ),
         .PF1VF_VIRTIO_ISRSTATUS_BAR_OFFSET             (pf1vf_virtio_isrstatus_bar_offset_hwtcl              ),
         .PF1VF_VIRTIO_PCICONFIG_ACCESS_BAR_OFFSET      (pf1vf_virtio_pciconfig_access_bar_offset_hwtcl       ),
         .PF1VF_VIRTIO_DEVSPECIFIC_BAR_OFFSET           (pf1vf_virtio_devspecific_bar_offset_hwtcl            ),                                                                                                          
         .PF1VF_VIRTIO_CMN_CONFIG_STRUCTURE_LENGTH      (pf1vf_virtio_cmn_config_structure_length_hwtcl       ),
         .PF1VF_VIRTIO_NOTIFICATION_STRUCTURE_LENGTH    (pf1vf_virtio_notification_structure_length_hwtcl     ),
         .PF1VF_VIRTIO_ISRSTATUS_STRUCTURE_LENGTH       (pf1vf_virtio_isrstatus_structure_length_hwtcl        ),
         .PF1VF_VIRTIO_PCICONFIG_ACCESS_STRUCTURE_LENGTH(pf1vf_virtio_pciconfig_access_structure_length_hwtcl ),
         .PF1VF_VIRTIO_DEVSPECIFIC_STRUCTURE_LENGTH     (pf1vf_virtio_devspecific_structure_length_hwtcl      ),
         .PF1VF_VIRTIO_NOTIFY_OFF_MULTIPLIER            (pf1vf_virtio_notify_off_multiplier_hwtcl             ),
      // VirtIO Specific Parameters PF2 VFs
         .PF2VF_VIRTIO_CAPABILITY_PRESENT               (pf2vf_virtio_capability_present_hwtcl                ),
         .PF2VF_VIRTIO_DEVICE_SPECIFIC_CAP_PRESENT      (pf2vf_virtio_device_specific_cap_present_hwtcl       ),                                                         
         .PF2VF_VIRTIO_CMN_CONFIG_BAR_INDICATOR         (pf2vf_virtio_cmn_config_bar_indicator_hwtcl          ),
         .PF2VF_VIRTIO_NOTIFICATION_BAR_INDICATOR       (pf2vf_virtio_notification_bar_indicator_hwtcl        ),
         .PF2VF_VIRTIO_ISRSTATUS_BAR_INDICATOR          (pf2vf_virtio_isrstatus_bar_indicator_hwtcl           ),
         .PF2VF_VIRTIO_PCICONFIG_ACCESS_BAR_INDICATOR   (pf2vf_virtio_pciconfig_access_bar_indicator_hwtcl    ),
         .PF2VF_VIRTIO_DEVSPECIFIC_BAR_INDICATOR        (pf2vf_virtio_devspecific_bar_indicator_hwtcl         ),                                                                                                          
         .PF2VF_VIRTIO_CMN_CONFIG_BAR_OFFSET            (pf2vf_virtio_cmn_config_bar_offset_hwtcl             ),
         .PF2VF_VIRTIO_NOTIFICATION_BAR_OFFSET          (pf2vf_virtio_notification_bar_offset_hwtcl           ),
         .PF2VF_VIRTIO_ISRSTATUS_BAR_OFFSET             (pf2vf_virtio_isrstatus_bar_offset_hwtcl              ),
         .PF2VF_VIRTIO_PCICONFIG_ACCESS_BAR_OFFSET      (pf2vf_virtio_pciconfig_access_bar_offset_hwtcl       ),
         .PF2VF_VIRTIO_DEVSPECIFIC_BAR_OFFSET           (pf2vf_virtio_devspecific_bar_offset_hwtcl            ),                                                                                                          
         .PF2VF_VIRTIO_CMN_CONFIG_STRUCTURE_LENGTH      (pf2vf_virtio_cmn_config_structure_length_hwtcl       ),
         .PF2VF_VIRTIO_NOTIFICATION_STRUCTURE_LENGTH    (pf2vf_virtio_notification_structure_length_hwtcl     ),
         .PF2VF_VIRTIO_ISRSTATUS_STRUCTURE_LENGTH       (pf2vf_virtio_isrstatus_structure_length_hwtcl        ),
         .PF2VF_VIRTIO_PCICONFIG_ACCESS_STRUCTURE_LENGTH(pf2vf_virtio_pciconfig_access_structure_length_hwtcl ),
         .PF2VF_VIRTIO_DEVSPECIFIC_STRUCTURE_LENGTH     (pf2vf_virtio_devspecific_structure_length_hwtcl      ),         
         .PF2VF_VIRTIO_NOTIFY_OFF_MULTIPLIER            (pf2vf_virtio_notify_off_multiplier_hwtcl             ),
      // VirtIO Specific Parameters PF3 VFs
         .PF3VF_VIRTIO_CAPABILITY_PRESENT               (pf3vf_virtio_capability_present_hwtcl                ),
         .PF3VF_VIRTIO_DEVICE_SPECIFIC_CAP_PRESENT      (pf3vf_virtio_device_specific_cap_present_hwtcl       ),                                                         
         .PF3VF_VIRTIO_CMN_CONFIG_BAR_INDICATOR         (pf3vf_virtio_cmn_config_bar_indicator_hwtcl          ),
         .PF3VF_VIRTIO_NOTIFICATION_BAR_INDICATOR       (pf3vf_virtio_notification_bar_indicator_hwtcl        ),
         .PF3VF_VIRTIO_ISRSTATUS_BAR_INDICATOR          (pf3vf_virtio_isrstatus_bar_indicator_hwtcl           ),
         .PF3VF_VIRTIO_PCICONFIG_ACCESS_BAR_INDICATOR   (pf3vf_virtio_pciconfig_access_bar_indicator_hwtcl    ),
         .PF3VF_VIRTIO_DEVSPECIFIC_BAR_INDICATOR        (pf3vf_virtio_devspecific_bar_indicator_hwtcl         ),                                                                                                          
         .PF3VF_VIRTIO_CMN_CONFIG_BAR_OFFSET            (pf3vf_virtio_cmn_config_bar_offset_hwtcl             ),
         .PF3VF_VIRTIO_NOTIFICATION_BAR_OFFSET          (pf3vf_virtio_notification_bar_offset_hwtcl           ),
         .PF3VF_VIRTIO_ISRSTATUS_BAR_OFFSET             (pf3vf_virtio_isrstatus_bar_offset_hwtcl              ),
         .PF3VF_VIRTIO_PCICONFIG_ACCESS_BAR_OFFSET      (pf3vf_virtio_pciconfig_access_bar_offset_hwtcl       ),
         .PF3VF_VIRTIO_DEVSPECIFIC_BAR_OFFSET           (pf3vf_virtio_devspecific_bar_offset_hwtcl            ),                                                                                                          
         .PF3VF_VIRTIO_CMN_CONFIG_STRUCTURE_LENGTH      (pf3vf_virtio_cmn_config_structure_length_hwtcl       ),
         .PF3VF_VIRTIO_NOTIFICATION_STRUCTURE_LENGTH    (pf3vf_virtio_notification_structure_length_hwtcl     ),
         .PF3VF_VIRTIO_ISRSTATUS_STRUCTURE_LENGTH       (pf3vf_virtio_isrstatus_structure_length_hwtcl        ),
         .PF3VF_VIRTIO_PCICONFIG_ACCESS_STRUCTURE_LENGTH(pf3vf_virtio_pciconfig_access_structure_length_hwtcl ),
         .PF3VF_VIRTIO_DEVSPECIFIC_STRUCTURE_LENGTH     (pf3vf_virtio_devspecific_structure_length_hwtcl      ),
         .PF3VF_VIRTIO_NOTIFY_OFF_MULTIPLIER            (pf3vf_virtio_notify_off_multiplier_hwtcl             ),
      
         .PF0_EXTRA_BAR_PRESENT                    (pf0_extra_bar_present_hwtcl               ),
         .PF0_EXTRA_BAR_SIZE                       (pf0_extra_bar_size_hwtcl                  ),
         .DEVHIDE_SUPPORT                          (devhide_support_hwtcl                     ),
         .DEVICE_EMBEDDED_EP_SUPPORT               (device_embedded_ep_support_hwtcl          )

      ) sriov_bridge (
         .pld_clk                                  (pld_clk_source                            ),
         .power_on_reset_n                         (npor                                      ),
         .testin_zero                              (testin_zero                               ),
         .reset_status                             (~app_rstn[3]                              ),
         .pld_clk_inuse                            (pld_clk_inuse                             ),

         .rx_st_sop_hip                            (rx_st_sop_hip                             ),
         .rx_st_eop_hip                            (rx_st_eop_hip                             ),
         .rx_st_err_hip                            (rx_st_error_hip                           ),
         .rx_st_valid_hip                          (rx_st_valid_hip                           ),
         .rx_st_empty_hip                          (rx_st_empty_hip                           ),
         .rx_st_ready_hip                          (rx_st_ready_hip                           ),
         .rx_st_data_hip                           (rx_st_data_hip                            ),
         .rx_st_parity_hip                         (rx_st_parity_hip                          ),
         .rx_st_mask_hip                           (rx_st_mask_hip                            ),
         .rxfc_cplbuf_ovf_hip                      (rxfc_cplbuf_ovf                           ),

         .rx_st_sop_app                            (rx_st_sop_app                             ),
         .rx_st_eop_app                            (rx_st_eop_app                             ),
         .rx_st_err_app                            (rx_st_err_app                             ),
         .rx_st_valid_app                          (rx_st_valid_app                           ),
         .rx_st_empty_app                          (rx_st_empty_app                           ),
         .rx_st_ready_app                          (rx_st_ready                               ),
         .rx_st_data_app                           (rx_st_data_app                            ),
         .rx_st_parity_app                         (rx_st_parity_app                          ),
         .rx_st_mask_app                           (rx_st_mask                                ),

         .rx_st_bar_range                          (rx_st_bar_range                           ),
         .rx_st_pf_num                             (rx_st_pf_num                              ),
         .rx_st_vf_num                             (rx_st_vf_num                              ),
         .rx_st_vf_active                          (rx_st_vf_active                           ),
         .rx_st_pf_exprom_bar_hit                  (rx_st_pf_exprom_bar_hit                   ), 

         .tx_st_sop_hip                            (tx_st_sop_hip                             ),
         .tx_st_eop_hip                            (tx_st_eop_hip                             ),
         .tx_st_err_hip                            (tx_st_error_hip                           ),
         .tx_st_valid_hip                          (tx_st_valid_hip                           ),
         .tx_st_empty_hip                          (tx_st_empty_hip                           ),
         .tx_st_ready_hip                          (tx_st_ready_hip                           ),
         .tx_st_data_hip                           (tx_st_data_hip                            ),
         .tx_st_parity_hip                         (tx_st_parity_hip                          ),

         .tx_st_sop_app                            (tx_st_sop                                 ),
         .tx_st_eop_app                            (tx_st_eop                                 ),
         .tx_st_err_app                            (tx_st_err                                 ),
         .tx_st_valid_app                          (tx_st_valid                               ),
         .tx_st_empty_app                          (tx_st_empty_app                           ),
         .tx_st_ready_app                          (tx_st_ready_app                           ),
         .tx_st_data_app                           (tx_st_data                                ),
         .tx_st_parity_app                         (tx_st_parity                              ),
         .tx_cred_fc_hip_cons_o                    (txcredit_consumed_sriov                   ),  //One clock cycle pulse indicating tx credit consumed by SRIOV core
         .tx_st_pf_num                             (tx_st_pf_num                              ),
         .tx_st_vf_num                             (tx_st_vf_num                              ),
         .tx_st_vf_active                          (tx_st_vf_active                           ),
          // Interrupt Interface
         .app_int_sts                              (app_int_pf_sts                            ),
         .app_intx_disable                         (app_intx_disable                          ),
         .app_msi_req                              (app_msi_req                               ),
         .app_msi_req_fn                           (app_msi_req_fn                            ),
         .app_msi_num                              (app_msi_num                               ),
         .app_msi_tc                               (app_msi_tc                                ),
         .app_msi_ack                              (sriov_app_msi_ack                         ),
         .app_msi_status                           (app_msi_status                            ),
         .app_msix_req                             (app_msix_req                              ),
         .app_msix_tc                              (app_msix_tc                               ),
         .app_msix_ack                             (app_msix_ack                              ),
         .app_msix_err                             (app_msix_err                              ),
         .app_msix_addr                            (app_msix_addr                             ),
         .app_msix_data                            (app_msix_data                             ),
         .app_msix_pf_num                          (app_msix_pf_num                           ),
         .app_msix_vf_num                          (app_msix_vf_num                           ),
         .app_msix_vf_active                       (app_msix_vf_active                        ),
         .app_msi_pending_bit_write_en             (app_msi_pending_bit_write_en              ),
         .app_msi_pending_bit_write_data           (app_msi_pending_bit_write_data            ),
         .app_msi_addr_pf                          (app_msi_addr_pf                           ),
         .app_msi_data_pf                          (app_msi_data_pf                           ),
         .app_msi_mask_pf                          (app_msi_mask_pf                           ),
         .app_msi_pending_pf                       (app_msi_pending_pf                        ),
         .app_msi_enable_pf                        (app_msi_enable_pf                         ),
         .app_msi_multi_msg_enable_pf              (app_msi_multi_msg_enable_pf               ),
         .app_msix_en_pf                           (app_msix_en_pf                            ),
         .app_msix_fn_mask_pf                      (app_msix_fn_mask_pf                       ),
         // Configuration and status
         .bus_num_f0                               (bus_num_f0                                ),
         .device_num_f0                            (device_num_f0                             ),
         .bus_num_f1                               (bus_num_f1                                ),
         .device_num_f1                            (device_num_f1                             ),
         .bus_num_f2                               (bus_num_f2                                ),
         .device_num_f2                            (device_num_f2                             ),
         .bus_num_f3                               (bus_num_f3                                ),
         .device_num_f3                            (device_num_f3                             ),
         .bus_num_f4                               (bus_num_f4                                ),
         .device_num_f4                            (device_num_f4                             ),
         .bus_num_f5                               (bus_num_f5                                ),
         .device_num_f5                            (device_num_f5                             ),
         .bus_num_f6                               (bus_num_f6                                ),
         .device_num_f6                            (device_num_f6                             ),
         .bus_num_f7                               (bus_num_f7                                ),
         .device_num_f7                            (device_num_f7                             ),
         .mem_space_en_pf                          (mem_space_en_pf                           ),
         .bus_master_en_pf                         (bus_master_en_pf                          ),
         .mem_space_en_vf                          (mem_space_en_vf                           ),
         .exprom_en_pf                             (exprom_en_pf                              ), 
         .pf0_num_vfs                              (pf0_num_vfs                               ),
         .pf1_num_vfs                              (pf1_num_vfs                               ),
         .pf2_num_vfs                              (pf2_num_vfs                               ),
         .pf3_num_vfs                              (pf3_num_vfs                               ),
         .max_payload_size                         (pf_max_payload_size                       ),
         .rd_req_size                              (pf_rd_req_size                            ),
         .compl_timeout_disable_pf                 (compl_timeout_disable_pf                  ),
         .atomic_op_requester_en_pf                (atomic_op_requester_en_pf                 ),
         .extended_tag_en_pf                       (extended_tag_en_pf                        ),
         .tph_st_mode_pf                           (tph_st_mode_pf                            ),
         .tph_requester_en_pf                      (tph_requester_en_pf                       ),
         .ats_stu_pf                               (ats_stu_pf                                ),
         .ats_en_pf                                (ats_en_pf                                 ),
         //Control Shadow Interface
         .ctl_shdw_update                          (ctl_shdw_update                           ),
         .ctl_shdw_pf_num                          (ctl_shdw_pf_num                           ),
         .ctl_shdw_vf_num                          (ctl_shdw_vf_num                           ),
         .ctl_shdw_vf_active                       (ctl_shdw_vf_active                        ),
         .ctl_shdw_cfg                             (ctl_shdw_cfg                              ),
         .ctl_shdw_req_all                         (ctl_shdw_req_all                          ),
         //LMI interface
         .lmi_addr_hip                             (lmi_addr_pld                              ),
         .lmi_din_hip                              (lmi_din_pld                               ),
         .lmi_rden_hip                             (lmi_rden_pld                              ),
         .lmi_wren_hip                             (lmi_wren_pld                              ),
         .lmi_ack_hip                              (lmi_ack_pld                               ),
         .lmi_dout_hip                             (lmi_dout_pld                              ),

         .lmi_addr_app                             (lmi_addr                                  ),
         .lmi_pf_num_app                           (lmi_pf_num_app                            ),
         .lmi_vf_num_app                           (lmi_vf_num_app                            ),
         .lmi_vf_active_app                        (lmi_vf_active_app                         ),
         .lmi_din_app                              (lmi_din                                   ),
         .lmi_rden_app                             (lmi_rden                                  ),
         .lmi_wren_app                             (lmi_wren                                  ),
         .lmi_ack_app                              (lmi_ack_app                               ),
         .lmi_dout_app                             (lmi_dout_app                              ),
         // status from HIP
         .derr_cor_ext_rcv                         (derr_cor_ext_rcv                          ),
         .derr_cor_ext_rpl                         (derr_cor_ext_rpl                          ),
         .derr_rpl                                 (derr_rpl                                  ),
         .dlup_exit                                (dlup_exit                                 ),
         .ev128ns                                  (ev128ns                                   ),
         .ev1us                                    (ev1us                                     ),
         .hotrst_exit                              (hotrst_exit                               ),
         .int_status                               (int_status                                ),
         .l2_exit                                  (l2_exit                                   ),
         .lane_act                                 (lane_act                                  ),
         .ltssmstate                               (ltssmstate                                ),
         .dlup                                     (dlup                                      ),
         .rx_par_err                               (rx_par_err                                ),
         .tx_par_err                               (tx_par_err                                ),
         .cfg_par_err                              (cfg_par_err                               ),
         .ko_cpl_spc_header                        (ko_cpl_spc_header                         ),
         .ko_cpl_spc_data                          (ko_cpl_spc_data                           ),
         //status to APP
         .derr_cor_ext_rcv_drv                     (                                          ), // UNUSED BRIDGE STATUS OUTPUTS
         .derr_cor_ext_rpl_drv                     (                                          ), // UNUSED BRIDGE STATUS OUTPUTS
         .derr_rpl_drv                             (                                          ), // UNUSED BRIDGE STATUS OUTPUTS
         .dlup_exit_drv                            (                                          ), // UNUSED BRIDGE STATUS OUTPUTS
         .ev128ns_drv                              (                                          ), // UNUSED BRIDGE STATUS OUTPUTS
         .ev1us_drv                                (                                          ), // UNUSED BRIDGE STATUS OUTPUTS
         .hotrst_exit_drv                          (                                          ), // UNUSED BRIDGE STATUS OUTPUTS
         .int_status_drv                           (                                          ), // UNUSED BRIDGE STATUS OUTPUTS
         .l2_exit_drv                              (                                          ), // UNUSED BRIDGE STATUS OUTPUTS
         .lane_act_drv                             (                                          ), // UNUSED BRIDGE STATUS OUTPUTS
         .ltssmstate_drv                           (                                          ), // UNUSED BRIDGE STATUS OUTPUTS
         .dlup_drv                                 (                                          ), // UNUSED BRIDGE STATUS OUTPUTS
         .rx_par_err_drv                           (                                          ), // UNUSED BRIDGE STATUS OUTPUTS
         .tx_par_err_drv                           (                                          ), // UNUSED BRIDGE STATUS OUTPUTS
         .cfg_par_err_drv                          (                                          ), // UNUSED BRIDGE STATUS OUTPUTS
         .ko_cpl_spc_header_drv                    (                                          ), // UNUSED BRIDGE STATUS OUTPUTS
         .ko_cpl_spc_data_drv                      (                                          ), // UNUSED BRIDGE STATUS OUTPUTS
         .rxfc_cplbuf_ovf_app                      (                                          ), // UNUSED BRIDGE STATUS OUTPUTS
         //Completion Interface
         .cpl_err                                  (cpl_err                                   ),
         .cpl_err_pf_num                           (cpl_err_pf_num                            ),
         .cpl_err_vf_num                           (cpl_err_vf_num                            ),
         .cpl_err_vf_active                        (cpl_err_vf_active                         ),
         .cpl_pending_pf                           (cpl_pending_pf                            ),
         .log_hdr                                  (log_hdr                                   ),
         .vf_compl_status_update                   (vf_compl_status_update                    ),
         .vf_compl_status                          (vf_compl_status                           ),
         .vf_compl_status_pf_num                   (vf_compl_status_pf_num                    ),
         .vf_compl_status_vf_num                   (vf_compl_status_vf_num                    ),
         .vf_compl_status_update_ack               (vf_compl_status_update_ack                ),
         //FLR Interface
         .flr_active_pf                            (flr_active_pf                             ),
         .flr_completed_pf                         (flr_completed_pf                          ),
         .flr_rcvd_vf                              (flr_rcvd_vf                               ),
         .flr_rcvd_pf_num                          (flr_rcvd_pf_num                           ),
         .flr_rcvd_vf_num                          (flr_rcvd_vf_num                           ),
         .flr_completed_vf                         (flr_completed_vf                          ),
         .flr_completed_pf_num                     (flr_completed_pf_num                      ),
         .flr_completed_vf_num                     (flr_completed_vf_num                      ),
         //Config Bypass
         .cfgbp_lane_err                           (cfgbp_lane_err                            ),
         .cfgbp_link_equlz_req                     (cfgbp_link_equlz_req                      ),
         .cfgbp_equiz_complete                     (cfgbp_equiz_complete                      ),
         .cfgbp_phase_3_successful                 (cfgbp_phase_3_successful                  ),
         .cfgbp_phase_2_successful                 (cfgbp_phase_2_successful                  ),
         .cfgbp_phase_1_successful                 (cfgbp_phase_1_successful                  ),
         .cfgbp_current_deemph                     (cfgbp_current_deemph                      ),
         .cfgbp_current_speed                      (cfgbp_current_speed                       ),
         .cfgbp_link_up                            (cfgbp_link_up                             ),
         .cfgbp_link_train                         (cfgbp_link_train                          ),
         .cfgbp_10state                            (cfgbp_10state                             ),
         .cfgbp_10sstate                           (cfgbp_10sstate                            ),
         .cfgbp_rx_val_pm                          (cfgbp_rx_val_pm                           ),
         .cfgbp_rx_typ_pm                          (cfgbp_rx_typ_pm                           ),
         .cfgbp_tx_ack_pm                          (cfgbp_tx_ack_pm                           ),
         .cfgbp_ack_phypm                          (cfgbp_ack_phypm                           ),
         .cfgbp_vc_status                          (cfgbp_vc_status                           ),
         .cfgbp_rxfc_max                           (cfgbp_rxfc_max                            ),
         .cfgbp_txfc_max                           (cfgbp_txfc_max                            ),
         .cfgbp_txbuf_emp                          (cfgbp_txbuf_emp                           ),
         .cfgbp_cfgbuf_emp                         (cfgbp_cfgbuf_emp                          ),
         .cfgbp_rpbuf_emp                          (cfgbp_rpbuf_emp                           ),
         .cfgbp_dll_req                            (cfgbp_dll_req                             ),
         .cfgbp_link_auto_bdw_status               (cfgbp_link_auto_bdw_status                ),
         .cfgbp_link_bdw_mng_status                (cfgbp_link_bdw_mng_status                 ),
         .cfgbp_rst_tx_margin_field                (cfgbp_rst_tx_margin_field                 ),
         .cfgbp_rst_enter_comp_bit                 (cfgbp_rst_enter_comp_bit                  ),
         .cfgbp_rx_st_ecrcerr                      (cfgbp_rx_st_ecrcerr                       ),
         .cfgbp_err_uncorr_internal                (cfgbp_err_uncorr_internal                 ),
         .cfgbp_rx_corr_internal                   (cfgbp_rx_corr_internal                    ),
         .cfgbp_err_tlrcvovf                       (cfgbp_err_tlrcvovf                        ),
         .cfgbp_txfc_err                           (cfgbp_txfc_err                            ),
         .cfgbp_err_tlmalf                         (cfgbp_err_tlmalf                          ),
         .cfgbp_err_surpdwn_dll                    (cfgbp_err_surpdwn_dll                     ),
         .cfgbp_err_dllrev                         (cfgbp_err_dllrev                          ),
         .cfgbp_err_dll_repnum                     (cfgbp_err_dll_repnum                      ),
         .cfgbp_err_dllreptim                      (cfgbp_err_dllreptim                       ),
         .cfgbp_err_dllp_baddllp                   (cfgbp_err_dllp_baddllp                    ),
         .cfgbp_err_dll_badtlp                     (cfgbp_err_dll_badtlp                      ),
         .cfgbp_err_phy_tng                        (cfgbp_err_phy_tng                         ),
         .cfgbp_err_phy_rcv                        (cfgbp_err_phy_rcv                         ),
         .cfgbp_root_err_reg_sts                   (cfgbp_root_err_reg_sts                    ),
         .cfgbp_corr_err_reg_sts                   (cfgbp_corr_err_reg_sts                    ),
         .cfgbp_unc_err_reg_sts                    (cfgbp_unc_err_reg_sts                     ),
         .cfgbp_link2csr                           (sriov_cfgbp_link2csr                      ),
         .cfgbp_comclk_reg                         (sriov_cfgbp_comclk_reg                    ),
         .cfgbp_extsy_reg                          (sriov_cfgbp_extsy_reg                     ),
         .cfgbp_max_pload                          (sriov_cfgbp_max_pload                     ),
         .cfgbp_tx_ecrcgen                         (sriov_cfgbp_tx_ecrcgen                    ),
         .cfgbp_rx_ecrchk                          (sriov_cfgbp_rx_ecrchk                     ),
         .cfgbp_secbus                             (sriov_cfgbp_secbus                        ),
         .cfgbp_linkcsr_bit0                       (sriov_cfgbp_linkcsr_bit0                  ),
         .cfgbp_tx_req_pm                          (sriov_cfgbp_tx_req_pm                     ),
         .cfgbp_tx_typ_pm                          (sriov_cfgbp_tx_typ_pm                     ),
         .cfgbp_req_phypm                          (sriov_cfgbp_req_phypm                     ),
         .cfgbp_req_phycfg                         (sriov_cfgbp_req_phycfg                    ),
         .cfgbp_vc0_tcmap_pld                      (sriov_cfgbp_vc0_tcmap_pld                 ),
         .cfgbp_inh_dllp                           (sriov_cfgbp_inh_dllp                      ),
         .cfgbp_inh_tx_tlp                         (sriov_cfgbp_inh_tx_tlp                    ),
         .cfgbp_req_wake                           (sriov_cfgbp_req_wake                      ),
         .cfgbp_link3_ctl                          (sriov_cfgbp_link3_ctl                     ),
         .f0_virtio_pcicfg_bar_o                   (f0_virtio_pcicfg_bar_o                    ),
         .f0_virtio_pcicfg_length_o                (f0_virtio_pcicfg_length_o                 ),
         .f0_virtio_pcicfg_baroffset_o             (f0_virtio_pcicfg_baroffset_o              ),
         .f0_virtio_pcicfg_cfgdata_o               (f0_virtio_pcicfg_cfgdata_o                ),
         .f0_virtio_pcicfg_cfgwr_o                 (f0_virtio_pcicfg_cfgwr_o                  ),
         .f0_virtio_pcicfg_cfgrd_o                 (f0_virtio_pcicfg_cfgrd_o                  ),
         .f0_virtio_pcicfg_rdack_i                 (f0_virtio_pcicfg_rdack_i                  ),//Application Read Data Ack to store config data
         .f0_virtio_pcicfg_rdbe_i                  (f0_virtio_pcicfg_rdbe_i                   ),//Application indicates which byte to store
         .f0_virtio_pcicfg_data_i                  (f0_virtio_pcicfg_data_i                   ),//Data to be stored in config data register
         .f1_virtio_pcicfg_bar_o                   (f1_virtio_pcicfg_bar_o                    ),
         .f1_virtio_pcicfg_length_o                (f1_virtio_pcicfg_length_o                 ),
         .f1_virtio_pcicfg_baroffset_o             (f1_virtio_pcicfg_baroffset_o              ),
         .f1_virtio_pcicfg_cfgdata_o               (f1_virtio_pcicfg_cfgdata_o                ),
         .f1_virtio_pcicfg_cfgwr_o                 (f1_virtio_pcicfg_cfgwr_o                  ),
         .f1_virtio_pcicfg_cfgrd_o                 (f1_virtio_pcicfg_cfgrd_o                  ),
         .f1_virtio_pcicfg_rdack_i                 (f1_virtio_pcicfg_rdack_i                  ),//Application Read Data Ack to store config data
         .f1_virtio_pcicfg_rdbe_i                  (f1_virtio_pcicfg_rdbe_i                   ),//Application indicates which byte to store
         .f1_virtio_pcicfg_data_i                  (f1_virtio_pcicfg_data_i                   ),//Data to be stored in config data register
         .f2_virtio_pcicfg_bar_o                   (f2_virtio_pcicfg_bar_o                    ),
         .f2_virtio_pcicfg_length_o                (f2_virtio_pcicfg_length_o                 ),
         .f2_virtio_pcicfg_baroffset_o             (f2_virtio_pcicfg_baroffset_o              ),
         .f2_virtio_pcicfg_cfgdata_o               (f2_virtio_pcicfg_cfgdata_o                ),
         .f2_virtio_pcicfg_cfgwr_o                 (f2_virtio_pcicfg_cfgwr_o                  ),
         .f2_virtio_pcicfg_cfgrd_o                 (f2_virtio_pcicfg_cfgrd_o                  ),
         .f2_virtio_pcicfg_rdack_i                 (f2_virtio_pcicfg_rdack_i                  ),//Application Read Data Ack to store config data
         .f2_virtio_pcicfg_rdbe_i                  (f2_virtio_pcicfg_rdbe_i                   ),//Application indicates which byte to store
         .f2_virtio_pcicfg_data_i                  (f2_virtio_pcicfg_data_i                   ),//Data to be stored in config data register
         .f3_virtio_pcicfg_bar_o                   (f3_virtio_pcicfg_bar_o                    ),
         .f3_virtio_pcicfg_length_o                (f3_virtio_pcicfg_length_o                 ),
         .f3_virtio_pcicfg_baroffset_o             (f3_virtio_pcicfg_baroffset_o              ),
         .f3_virtio_pcicfg_cfgdata_o               (f3_virtio_pcicfg_cfgdata_o                ),
         .f3_virtio_pcicfg_cfgwr_o                 (f3_virtio_pcicfg_cfgwr_o                  ),
         .f3_virtio_pcicfg_cfgrd_o                 (f3_virtio_pcicfg_cfgrd_o                  ),
         .f3_virtio_pcicfg_rdack_i                 (f3_virtio_pcicfg_rdack_i                  ),//Application Read Data Ack to store config data
         .f3_virtio_pcicfg_rdbe_i                  (f3_virtio_pcicfg_rdbe_i                   ),//Application indicates which byte to store
         .f3_virtio_pcicfg_data_i                  (f3_virtio_pcicfg_data_i                   ),//Data to be stored in config data register
         .f4_virtio_pcicfg_bar_o                   (f4_virtio_pcicfg_bar_o                    ),
         .f4_virtio_pcicfg_length_o                (f4_virtio_pcicfg_length_o                 ),
         .f4_virtio_pcicfg_baroffset_o             (f4_virtio_pcicfg_baroffset_o              ),
         .f4_virtio_pcicfg_cfgdata_o               (f4_virtio_pcicfg_cfgdata_o                ),
         .f4_virtio_pcicfg_cfgwr_o                 (f4_virtio_pcicfg_cfgwr_o                  ),
         .f4_virtio_pcicfg_cfgrd_o                 (f4_virtio_pcicfg_cfgrd_o                  ),
         .f4_virtio_pcicfg_rdack_i                 (f4_virtio_pcicfg_rdack_i                  ),//Application Read Data Ack to store config data
         .f4_virtio_pcicfg_rdbe_i                  (f4_virtio_pcicfg_rdbe_i                   ),//Application indicates which byte to store
         .f4_virtio_pcicfg_data_i                  (f4_virtio_pcicfg_data_i                   ),//Data to be stored in config data register
         .f5_virtio_pcicfg_bar_o                   (f5_virtio_pcicfg_bar_o                    ),
         .f5_virtio_pcicfg_length_o                (f5_virtio_pcicfg_length_o                 ),
         .f5_virtio_pcicfg_baroffset_o             (f5_virtio_pcicfg_baroffset_o              ),
         .f5_virtio_pcicfg_cfgdata_o               (f5_virtio_pcicfg_cfgdata_o                ),
         .f5_virtio_pcicfg_cfgwr_o                 (f5_virtio_pcicfg_cfgwr_o                  ),
         .f5_virtio_pcicfg_cfgrd_o                 (f5_virtio_pcicfg_cfgrd_o                  ),
         .f5_virtio_pcicfg_rdack_i                 (f5_virtio_pcicfg_rdack_i                  ),//Application Read Data Ack to store config data
         .f5_virtio_pcicfg_rdbe_i                  (f5_virtio_pcicfg_rdbe_i                   ),//Application indicates which byte to store
         .f5_virtio_pcicfg_data_i                  (f5_virtio_pcicfg_data_i                   ),//Data to be stored in config data register
         .f6_virtio_pcicfg_bar_o                   (f6_virtio_pcicfg_bar_o                    ),
         .f6_virtio_pcicfg_length_o                (f6_virtio_pcicfg_length_o                 ),
         .f6_virtio_pcicfg_baroffset_o             (f6_virtio_pcicfg_baroffset_o              ),
         .f6_virtio_pcicfg_cfgdata_o               (f6_virtio_pcicfg_cfgdata_o                ),
         .f6_virtio_pcicfg_cfgwr_o                 (f6_virtio_pcicfg_cfgwr_o                  ),
         .f6_virtio_pcicfg_cfgrd_o                 (f6_virtio_pcicfg_cfgrd_o                  ),
         .f6_virtio_pcicfg_rdack_i                 (f6_virtio_pcicfg_rdack_i                  ),//Application Read Data Ack to store config data
         .f6_virtio_pcicfg_rdbe_i                  (f6_virtio_pcicfg_rdbe_i                   ),//Application indicates which byte to store
         .f6_virtio_pcicfg_data_i                  (f6_virtio_pcicfg_data_i                   ),//Data to be stored in config data register
         .f7_virtio_pcicfg_bar_o                   (f7_virtio_pcicfg_bar_o                    ),
         .f7_virtio_pcicfg_length_o                (f7_virtio_pcicfg_length_o                 ),
         .f7_virtio_pcicfg_baroffset_o             (f7_virtio_pcicfg_baroffset_o              ),
         .f7_virtio_pcicfg_cfgdata_o               (f7_virtio_pcicfg_cfgdata_o                ),
         .f7_virtio_pcicfg_cfgwr_o                 (f7_virtio_pcicfg_cfgwr_o                  ),
         .f7_virtio_pcicfg_cfgrd_o                 (f7_virtio_pcicfg_cfgrd_o                  ),
         .f7_virtio_pcicfg_rdack_i                 (f7_virtio_pcicfg_rdack_i                  ),//Application Read Data Ack to store config data
         .f7_virtio_pcicfg_rdbe_i                  (f7_virtio_pcicfg_rdbe_i                   ),//Application indicates which byte to store
         .f7_virtio_pcicfg_data_i                  (f7_virtio_pcicfg_data_i                   ),//Data to be stored in config data register
         // VirtIO for VFs
         .f0vf_virtio_pcicfg_bar_o                 (f0vf_virtio_pcicfg_bar_o                  ),
         .f0vf_virtio_pcicfg_length_o              (f0vf_virtio_pcicfg_length_o               ),
         .f0vf_virtio_pcicfg_baroffset_o           (f0vf_virtio_pcicfg_baroffset_o            ),
         .f0vf_virtio_pcicfg_cfgdata_o             (f0vf_virtio_pcicfg_cfgdata_o              ),
         .f0vf_virtio_pcicfg_cfgwr_o               (f0vf_virtio_pcicfg_cfgwr_o                ),
         .f0vf_virtio_pcicfg_cfgrd_o               (f0vf_virtio_pcicfg_cfgrd_o                ),
         .f0vf_virtio_pcicfg_vfnum_o               (f0vf_virtio_pcicfg_vfnum_o                ),
         .f0vf_virtio_pcicfg_rdack_i               (f0vf_virtio_pcicfg_rdack_i                ),//Application Read Data Ack to store config data
         .f0vf_virtio_pcicfg_rdbe_i                (f0vf_virtio_pcicfg_rdbe_i                 ),//Application indicates which byte to store
         .f0vf_virtio_pcicfg_data_i                (f0vf_virtio_pcicfg_data_i                 ),//Data to be stored in config data register
         .f0vf_virtio_pcicfg_appvfnum_i            (f0vf_virtio_pcicfg_appvfnum_i             ),
         .f1vf_virtio_pcicfg_bar_o                 (f1vf_virtio_pcicfg_bar_o                  ),
         .f1vf_virtio_pcicfg_length_o              (f1vf_virtio_pcicfg_length_o               ),
         .f1vf_virtio_pcicfg_baroffset_o           (f1vf_virtio_pcicfg_baroffset_o            ),
         .f1vf_virtio_pcicfg_cfgdata_o             (f1vf_virtio_pcicfg_cfgdata_o              ),
         .f1vf_virtio_pcicfg_cfgwr_o               (f1vf_virtio_pcicfg_cfgwr_o                ),
         .f1vf_virtio_pcicfg_cfgrd_o               (f1vf_virtio_pcicfg_cfgrd_o                ),
         .f1vf_virtio_pcicfg_vfnum_o               (f1vf_virtio_pcicfg_vfnum_o                ),
         .f1vf_virtio_pcicfg_rdack_i               (f1vf_virtio_pcicfg_rdack_i                ),//Application Read Data Ack to store config data
         .f1vf_virtio_pcicfg_rdbe_i                (f1vf_virtio_pcicfg_rdbe_i                 ),//Application indicates which byte to store
         .f1vf_virtio_pcicfg_data_i                (f1vf_virtio_pcicfg_data_i                 ),//Data to be stored in config data register
         .f1vf_virtio_pcicfg_appvfnum_i            (f1vf_virtio_pcicfg_appvfnum_i             ),
         .f2vf_virtio_pcicfg_bar_o                 (f2vf_virtio_pcicfg_bar_o                  ),
         .f2vf_virtio_pcicfg_length_o              (f2vf_virtio_pcicfg_length_o               ),
         .f2vf_virtio_pcicfg_baroffset_o           (f2vf_virtio_pcicfg_baroffset_o            ),
         .f2vf_virtio_pcicfg_cfgdata_o             (f2vf_virtio_pcicfg_cfgdata_o              ),
         .f2vf_virtio_pcicfg_cfgwr_o               (f2vf_virtio_pcicfg_cfgwr_o                ),
         .f2vf_virtio_pcicfg_cfgrd_o               (f2vf_virtio_pcicfg_cfgrd_o                ),
         .f2vf_virtio_pcicfg_vfnum_o               (f2vf_virtio_pcicfg_vfnum_o                ),
         .f2vf_virtio_pcicfg_rdack_i               (f2vf_virtio_pcicfg_rdack_i                ),//Application Read Data Ack to store config data
         .f2vf_virtio_pcicfg_rdbe_i                (f2vf_virtio_pcicfg_rdbe_i                 ),//Application indicates which byte to store
         .f2vf_virtio_pcicfg_data_i                (f2vf_virtio_pcicfg_data_i                 ),//Data to be stored in config data register
         .f2vf_virtio_pcicfg_appvfnum_i            (f2vf_virtio_pcicfg_appvfnum_i             ),
         .f3vf_virtio_pcicfg_bar_o                 (f3vf_virtio_pcicfg_bar_o                  ),
         .f3vf_virtio_pcicfg_length_o              (f3vf_virtio_pcicfg_length_o               ),
         .f3vf_virtio_pcicfg_baroffset_o           (f3vf_virtio_pcicfg_baroffset_o            ),
         .f3vf_virtio_pcicfg_cfgdata_o             (f3vf_virtio_pcicfg_cfgdata_o              ),
         .f3vf_virtio_pcicfg_cfgwr_o               (f3vf_virtio_pcicfg_cfgwr_o                ),
         .f3vf_virtio_pcicfg_cfgrd_o               (f3vf_virtio_pcicfg_cfgrd_o                ),
         .f3vf_virtio_pcicfg_vfnum_o               (f3vf_virtio_pcicfg_vfnum_o                ),
         .f3vf_virtio_pcicfg_rdack_i               (f3vf_virtio_pcicfg_rdack_i                ),//Application Read Data Ack to store config data
         .f3vf_virtio_pcicfg_rdbe_i                (f3vf_virtio_pcicfg_rdbe_i                 ),//Application indicates which byte to store
         .f3vf_virtio_pcicfg_data_i                (f3vf_virtio_pcicfg_data_i                 ),//Data to be stored in config data register
         .f3vf_virtio_pcicfg_appvfnum_i            (f3vf_virtio_pcicfg_appvfnum_i             ),
         .extraBAR_lock                            (extraBAR_lock_int                         ),
         .devhide_pf                               (devhide_pf_int                            ),
         .device_rciep                             (device_rciep_int                          ),
         .extraBAR_hit                             (extraBAR_hit                              )


   );

   altpcie_a10_lmi_burst_intf lmi_burst_intf (
     .clk               (pld_clk_source   ),
     .srst              (~app_rstn[1]),
     .rstn              (app_rstn[1]),
     .pld_lmi_rden_i    (lmi_rden_pld),
     .pld_lmi_wren_i    (lmi_wren_pld),
     .pld_lmi_addr_i    (lmi_addr_pld),
     .pld_lmi_wrdata_i  (lmi_din_pld ),
     .pld_lmi_rddata_o  (lmi_dout_pld),
     .pld_lmi_ack_o     (lmi_ack_pld ),

     .hip_lmi_rden_o    (lmi_rden_hip),
     .hip_lmi_wren_o    (lmi_wren_hip),
     .hip_lmi_addr_o    (lmi_addr_hip),
     .hip_lmi_wrdata_o  (lmi_din_hip ),
     .hip_lmi_rddata_i  (lmi_dout_hip),
     .hip_lmi_ack_i     (lmi_ack_hip )
   );
     assign  sriov_app_int_ack                 = 1'b0;
         assign  sriov_cfgbp_link2csr[15:13]       = {3{1'b0}};
   end
end
endgenerate

assign testin        = (enable_devkit_conduit_hwtcl==1)?devkit_ctrl[63:0]:{32'h0,test_in};


//==========================================================================
// DEVKIT Conduit connection
assign devkit_status[1:0]    = currentspeed          [1 : 0]  ;
assign devkit_status[2]      = derr_cor_ext_rcv               ;
assign devkit_status[3]      = derr_cor_ext_rpl               ;
assign devkit_status[4]      = derr_rpl                       ;
assign devkit_status[5]      = rx_par_err                     ;
assign devkit_status[7:6]    = tx_par_err            [1:0]    ;
assign devkit_status[8]      = cfg_par_err                    ;
assign devkit_status[9]      = dlup                           ;
assign devkit_status[10]     = dlup_exit                      ;
assign devkit_status[11]     = ev128ns                        ;
assign devkit_status[12]     = ev1us                          ;
assign devkit_status[13]     = hotrst_exit                    ;
assign devkit_status[17:14]  = int_status            [3 : 0]  ;
assign devkit_status[18]     = l2_exit                        ;
assign devkit_status[22:19]  = lane_act              [3 : 0]  ;
assign devkit_status[27:23]  = ltssmstate            [4 : 0]  ;
assign devkit_status[35:28]  = ko_cpl_spc_header     [7 :0]   ;
assign devkit_status[47:36]  = ko_cpl_spc_data       [11 :0]  ;
assign devkit_status[48]     = rxfc_cplbuf_ovf                ;
assign devkit_status[49]     = reset_status                   ;
assign devkit_status[255:50] = ZEROS[255:50]                  ;

//==========================================================================
// TLP Inspector Thn Master
assign avmm_thinmaster_reset = (tlp_inspector_use_thin_rx_master==1)?reset_status:1'b0;
assign clr_st                = ((enable_avst_reset_hwtcl==1)&&(interface_type_integer_hwtcl==0))?reset_status:1'b0;


//==========================================================================
// SECTION NO
//
//
//==========================================================================
// Non-SR-IOV: Tied off all unused signals when SR-IOV is unused
generate begin: g_no_sriov
   if (include_sriov_hwtcl==0) begin : no_sriov
      // Ok
      assign rx_st_sop_app    = {(multiple_packets_per_cycle_hwtcl+1){1'b0}};
      assign rx_st_eop_app    = {(multiple_packets_per_cycle_hwtcl+1){1'b0}};
      assign rx_st_valid_app  = {(multiple_packets_per_cycle_hwtcl+1){1'b0}};
      assign rx_st_err_app    = {(multiple_packets_per_cycle_hwtcl+1){1'b0}};
      assign rx_st_data_app   = {data_width_integer_hwtcl{1'b0}}      ;
      assign rx_st_empty_app  = {empty_integer_hwtcl{1'b0}}           ;
      assign rx_st_parity_app = {data_byte_width_integer_hwtcl{1'b0}} ;

      assign tx_st_sop_hip    = {(multiple_packets_per_cycle_hwtcl+1){1'b0}} ;
      assign tx_st_eop_hip    = {(multiple_packets_per_cycle_hwtcl+1){1'b0}} ;
      assign tx_st_error_hip  = {(multiple_packets_per_cycle_hwtcl+1){1'b0}} ;
      assign tx_st_valid_hip  = {(multiple_packets_per_cycle_hwtcl+1){1'b0}} ;
      assign tx_st_empty_hip  =  2'h0 ;
      assign tx_st_data_hip   = {data_width_integer_hwtcl{1'b0}};
      assign tx_st_parity_hip = {data_byte_width_integer_hwtcl{1'b0}};

      assign tx_st_ready_app  = 1'b0;
      assign tx_st_empty_app  = 2'h0;

      assign lmi_addr_hip  = 12'h0 ;
      assign lmi_din_hip   = 32'h0;
      assign lmi_wren_hip  = 1'b0;
      assign lmi_rden_hip  = 1'b0;
      assign lmi_ack_app   = 1'b0;
      assign lmi_dout_app  = 32'h0;

      assign lmi_addr_pld  = 12'h0 ;
      assign lmi_din_pld   = 32'h0;
      assign lmi_wren_pld  = 1'b0;
      assign lmi_rden_pld  = 1'b0;
      assign lmi_ack_pld   = 1'b0;
      assign lmi_dout_pld  = 32'h0;

      assign sriov_cfgbp_link2csr      = {link2csr_width_hwtcl{1'b0}};
      assign sriov_cfgbp_comclk_reg    = 1'b0;
      assign sriov_cfgbp_extsy_reg     = 1'b0;
      assign sriov_cfgbp_max_pload     = 3'h0;
      assign sriov_cfgbp_tx_ecrcgen    = 1'b0;
      assign sriov_cfgbp_rx_ecrchk     = 1'b0;
      assign sriov_cfgbp_secbus        = 8'h0;
      assign sriov_cfgbp_linkcsr_bit0  = 1'b0;
      assign sriov_cfgbp_tx_req_pm     = 1'b0;
      assign sriov_cfgbp_tx_typ_pm     = 3'h0;
      assign sriov_cfgbp_req_phypm     = 4'h0;
      assign sriov_cfgbp_req_phycfg    = 4'h0;
      assign sriov_cfgbp_vc0_tcmap_pld = 7'h0;
      assign sriov_cfgbp_inh_dllp      = 1'b0;
      assign sriov_cfgbp_inh_tx_tlp    = 1'b0;
      assign sriov_cfgbp_req_wake      = 1'b0;
      assign sriov_cfgbp_link3_ctl     = 2'h0;

   end
end
endgenerate


//==========================================================================
// Non-DMA   : Tied off all unused signals when AVMM DMA is unused or TLP
// converter is used
generate begin : g_nodma
   if ((include_dma_hwtcl == 0) || (enable_ast_trs_hwtcl==1)) begin : nodma
      assign dma_control_0_wrdcs_slave_0_chipselect    = 1'b0                                ;
      assign dma_control_0_rddcs_slave_0_chipselect    = 1'b0                                ;
      assign dma_control_0_wrdcs_slave_0_waitrequest   = 1'b0                                ;
      assign dma_control_0_rddcs_slave_0_waitrequest   = 1'b0                                ;
      assign dma_control_0_wrdcs_slave_0_readdata      = ZEROS[31:0]                         ;
      assign dma_control_0_rddcs_slave_0_readdata      = ZEROS[31:0]                         ;
      assign dma_control_0_wrdcs_slave_0_readdatavalid = 1'b0                                ;
      assign dma_control_0_rddcs_slave_0_readdatavalid = 1'b0                                ;
      assign dma_control_0_dcs_slave_0_write           = 1'b0                                ;
      assign dma_control_0_dcs_slave_0_read            = 1'b0                                ;
      assign dma_control_0_dcs_slave_0_readdatavalid   = 1'b0                                ;
      assign dma_control_0_dcs_slave_0_readdata        = ZEROS[31:0]                         ;
      assign dma_control_0_dcs_slave_0_address         = ZEROS[avmm_addr_width_hwtcl-1:0]    ;
      assign dma_control_0_dcs_slave_0_writedata       = ZEROS[31:0]                         ;
      assign dma_control_0_dcs_slave_0_byteenable      = ZEROS[(avmm_addr_width_hwtcl/8)-1:0];
      assign dma_control_0_dcs_slave_0_waitrequest     = 1'b0                                ;
      assign dma_control_0_rddma_tx_data               = ZEROS[159:0]                        ;
      assign dma_control_0_rddma_tx_valid              = 1'b0                                ;
      assign dma_control_0_rddma_tx_ready              = 1'b0                                ;
      assign dut_rd_ast_tx_data                        = ZEROS[31:0]                         ;
      assign dut_rd_ast_tx_valid                       = 1'b0                                ;
      assign dma_control_0_wrdma_tx_data               = ZEROS[159:0]                        ;
      assign dma_control_0_wrdma_tx_valid              = 1'b0                                ;
      assign dma_control_0_wrdma_tx_ready              = 1'b0                                ;
      assign dut_wr_ast_tx_data                        = ZEROS[31:0]                         ;
      assign dut_wr_ast_tx_valid                       = 1'b0                                ;
   end
end
endgenerate

//==========================================================================
// Non-AVMM  : Tied off all unused signals when AVMM DMA is used but no legacy bridge
generate begin : g_noavmm_dma
   if ((include_dma_hwtcl == 1)&&(interface_type_integer_hwtcl == 1)) begin : noavmm_dma
      assign app_msi_req_avmm                          = ZEROS[0]                            ;
      assign app_msi_tc_avmm                           = ZEROS[2:0]                          ;
      assign app_msi_num_avmm                          = ZEROS[4:0]                          ;
      assign app_int_sts_avmm                          = ZEROS[0]                            ;
   end
end
endgenerate

//==========================================================================
// External-DMA Controller   : Tied AVMM DMA Controller when it is used
generate begin : g_ext_dma_ctrl
   if (internal_controller_hwtcl == 0 && interface_type_integer_hwtcl == 1 && include_dma_hwtcl == 1 && enable_ast_trs_hwtcl==0) begin : ext_dma_ctrl
      assign rxm_bar0_write_o                           = dma_control_0_dcs_slave_0_write;
      assign rxm_bar0_read_o                            = dma_control_0_dcs_slave_0_read;
      assign dma_control_0_dcs_slave_0_readdatavalid    = rxm_bar0_readdatavalid_i;
      assign dma_control_0_dcs_slave_0_readdata         = rxm_bar0_readdata_i;
      assign rxm_bar0_address_o                         = dma_control_0_dcs_slave_0_address;
      assign rxm_bar0_writedata_o                       = dma_control_0_dcs_slave_0_writedata;
      assign rxm_bar0_byteenable_o                      = dma_control_0_dcs_slave_0_byteenable;
      assign dma_control_0_dcs_slave_0_waitrequest      = rxm_bar0_waitrequest_i;
      assign rd_ast_rx_ready_o                          = dma_control_0_rddma_tx_ready;
      assign dma_control_0_rddma_tx_data                = rd_ast_rx_data_i;
      assign dma_control_0_rddma_tx_valid               = rd_ast_rx_valid_i;
      assign rd_ast_tx_data_o                           = dut_rd_ast_tx_data;
      assign rd_ast_tx_valid_o                          = dut_rd_ast_tx_valid;
      assign wr_ast_rx_ready_o                          = dma_control_0_wrdma_tx_ready;
      assign dma_control_0_wrdma_tx_data                = wr_ast_rx_data_i;
      assign dma_control_0_wrdma_tx_valid               = wr_ast_rx_valid_i;
      assign wr_ast_tx_data_o                           = dut_wr_ast_tx_data;
      assign wr_ast_tx_valid_o                          = dut_wr_ast_tx_valid;
   end
end
endgenerate


//==========================================================================
// Non-AVMM    : Tied off all unused signals when AVMM is unused
generate begin : g_no_avmm
   // Grounding unused signals when using AST interface
   if (interface_type_integer_hwtcl==0) begin : no_avmm
      assign txs_readdatavalid_o                  = ZEROS[0]                                                     ;
      assign txs_readdata_o                       = ZEROS[data_width_integer_rxm_txs_hwtcl-1:0]                  ;
      assign txs_waitrequest_o                    = ZEROS[0]                                                     ;
      assign rxm_bar0_write_o                     = ZEROS[0]                                                    ;
      assign rxm_bar0_address_o                   = ZEROS[avmm_addr_width_hwtcl-1:0]                             ;
      assign rxm_bar0_writedata_o                 = ZEROS[data_width_integer_rxm_txs_hwtcl-1:0]                  ;
      assign rxm_bar0_byteenable_o                = ZEROS[(data_width_integer_rxm_txs_hwtcl/8)-1:0]              ;
      assign rxm_bar0_burstcount_o                = ZEROS[burst_count_integer_hwtcl-1:0]                         ;
      assign rxm_bar0_read_o                      = ZEROS[0]                                                     ;
      assign rxm_bar1_write_o                     = ZEROS[0]                                                     ;
      assign rxm_bar1_address_o                   = ZEROS[avmm_addr_width_hwtcl-1:0]                             ;
      assign rxm_bar1_writedata_o                 = ZEROS[data_width_integer_rxm_txs_hwtcl-1:0]                  ;
      assign rxm_bar1_byteenable_o                = ZEROS[(data_width_integer_rxm_txs_hwtcl/8)-1:0]              ;
      assign rxm_bar1_burstcount_o                = ZEROS[burst_count_integer_hwtcl-1:0]                         ;
      assign rxm_bar1_read_o                      = ZEROS[0]                                                     ;
      assign rxm_bar2_write_o                     = ZEROS[0]                                                     ;
      assign rxm_bar2_address_o                   = ZEROS[avmm_addr_width_hwtcl-1:0]                             ;
      assign rxm_bar2_writedata_o                 = ZEROS[data_width_integer_rxm_txs_hwtcl-1:0]                  ;
      assign rxm_bar2_byteenable_o                = ZEROS[(data_width_integer_rxm_txs_hwtcl/8)-1:0]              ;
      assign rxm_bar2_burstcount_o                = ZEROS[burst_count_integer_hwtcl-1:0]                         ;
      assign rxm_bar2_read_o                      = ZEROS[0]                                                     ;
      assign rxm_bar3_write_o                     = ZEROS[0]                                                     ;
      assign rxm_bar3_address_o                   = ZEROS[avmm_addr_width_hwtcl-1:0]                             ;
      assign rxm_bar3_writedata_o                 = ZEROS[data_width_integer_rxm_txs_hwtcl-1:0]                  ;
      assign rxm_bar3_byteenable_o                = ZEROS[(data_width_integer_rxm_txs_hwtcl/8)-1:0]              ;
      assign rxm_bar3_burstcount_o                = ZEROS[burst_count_integer_hwtcl-1:0]                         ;
      assign rxm_bar3_read_o                      = ZEROS[0]                                                     ;
      assign rxm_bar4_write_o                     = ZEROS[0]                                                     ;
      assign rxm_bar4_address_o                   = ZEROS[avmm_addr_width_hwtcl-1:0]                             ;
      assign rxm_bar4_writedata_o                 = ZEROS[data_width_integer_rxm_txs_hwtcl-1:0]                  ;
      assign rxm_bar4_byteenable_o                = ZEROS[(data_width_integer_rxm_txs_hwtcl/8)-1:0]              ;
      assign rxm_bar4_burstcount_o                = ZEROS[burst_count_integer_hwtcl-1:0]                         ;
      assign rxm_bar4_read_o                      = ZEROS[0]                                                     ;
      assign rxm_bar5_write_o                     = ZEROS[0]                                                     ;
      assign rxm_bar5_address_o                   = ZEROS[avmm_addr_width_hwtcl-1:0]                             ;
      assign rxm_bar5_writedata_o                 = ZEROS[data_width_integer_rxm_txs_hwtcl-1:0]                  ;
      assign rxm_bar5_byteenable_o                = ZEROS[(data_width_integer_rxm_txs_hwtcl/8)-1:0]              ;
      assign rxm_bar5_burstcount_o                = ZEROS[burst_count_integer_hwtcl-1:0]                         ;
      assign rxm_bar5_read_o                      = ZEROS[0]                                                     ;
      assign hprxm_write_o                        = ZEROS[0]                                                     ;
      assign hprxm_address_o                      = ZEROS[avmm_addr_width_hwtcl-1:0]                             ;
      assign hprxm_writedata_o                    = ZEROS[data_width_integer_hwtcl-1:0]                          ;
      assign hprxm_byteenable_o                   = ZEROS[(data_width_integer_hwtcl/8)-1:0]                      ;
      assign hprxm_burstcount_o                   = ZEROS[burst_count_integer_hwtcl-1:0]                         ;
      assign hprxm_read_o                         = ZEROS[0]                                                     ;
      assign cra_readdata_o                       = ZEROS[31:0]                                                  ;
      assign cra_waitrequest_o                    = ZEROS[0]                                                     ;
      assign cra_irq_o                            = ZEROS[0]                                                     ;
      assign msi_intfc_o                          = ZEROS[81:0]                                                  ;
      assign msi_control_o                        = ZEROS[15:0]                                                  ;
      assign msix_intfc_o                         = ZEROS[15:0]                                                  ;
      assign rd_ast_rx_ready_o                    = ZEROS[0]                                                     ;
      assign rd_ast_tx_valid_o                    = ZEROS[0]                                                     ;
      assign rd_ast_tx_data_o                     = ZEROS[31:0]                                                  ;
      assign wr_ast_rx_ready_o                    = ZEROS[0]                                                     ;
      assign wr_ast_tx_valid_o                    = ZEROS[0]                                                     ;
      assign wr_ast_tx_data_o                     = ZEROS[31:0]                                                  ;
      assign rd_dma_address_o                     = ZEROS[avmm_addr_width_hwtcl-1:0]                             ;
      assign rd_dma_write_o                       = ZEROS[0]                                                     ;
      assign rd_dma_write_data_o                  = ZEROS[data_width_integer_hwtcl-1:0]                          ;
      assign rd_dma_burst_count_o                 = ZEROS[burst_count_integer_hwtcl-1:0]                         ;
      assign rd_dma_byte_enable_o                 = ZEROS[data_byte_width_integer_hwtcl-1:0]                     ;
      assign wr_dma_address_o                     = ZEROS[avmm_addr_width_hwtcl-1:0]                             ;
      assign wr_dma_read_o                        = ZEROS[0]                                                     ;
      assign wr_dma_burst_count_o                 = ZEROS[burst_count_integer_hwtcl-1:0]                         ;
      assign rd_dts_wait_request_o                = ZEROS[0]                                                     ;
      assign wr_dts_wait_request_o                = ZEROS[0]                                                     ;
      assign rd_dcm_address_o                     = ZEROS[63:0]                                                  ;
      assign rd_dcm_write_o                       = ZEROS[0]                                                     ;
      assign rd_dcm_writedata_o                   = ZEROS[31:0]                                                  ;
      assign rd_dcm_read_o                        = ZEROS[0]                                                     ;
      assign rd_dcm_byte_enable_o                 = ZEROS[3:0]                                                   ;
      assign wr_dcm_address_o                     = ZEROS[63:0]                                                  ;
      assign wr_dcm_write_o                       = ZEROS[0]                                                     ;
      assign wr_dcm_writedata_o                   = ZEROS[31:0]                                                  ;
      assign wr_dcm_read_o                        = ZEROS[0]                                                     ;
      assign wr_dcm_byte_enable_o                 = ZEROS[3:0]                                                   ;
      assign app_nreset_status                    = ZEROS[0]                                                     ;
      assign cpl_pending_avmm                     = ZEROS[0]                                                     ;
      assign app_msi_req_avmm                     = ZEROS[0]                                                     ;
      assign app_msi_tc_avmm                      = ZEROS[2:0]                                                   ;
      assign app_msi_num_avmm                     = ZEROS[4:0]                                                   ;
      assign app_int_sts_avmm                     = ZEROS[0]                                                     ;
      assign tx_cons_cred_sel_avmm                = ZEROS[0]                                                     ;
   end
end
endgenerate

//==========================================================================
// Non-Translator    : Tied off all unused signals when TLP translator is unused
generate begin : g_no_translator
   // Grounding unused signals when disabling AST translator
   if (enable_ast_trs_hwtcl==0) begin : no_trans
      assign TxData_rdy_o   = ZEROS[0];
      assign TxStatus_val_o = ZEROS[0];
      assign TxStatus_dat_o = ZEROS[ast_trs_txstatus_width_hwtcl-1:0];
      assign RxData_val_o   = ZEROS[0];
      assign RxData_sop_o   = ZEROS[0];
      assign RxData_eop_o   = ZEROS[0];
      assign RxData_err_o   = ZEROS[0];
      assign RxData_dat_o   = ZEROS[ast_trs_rxdata_width_hwtcl-1:0];
      assign RxData_sty_o   = ZEROS[ast_trs_rxmty_width_hwtcl-1 :0];
      assign RxData_mty_o   = ZEROS[ast_trs_rxmty_width_hwtcl-1 :0];
      assign RxData_dsc_o   = ZEROS[ast_trs_rxdesc_width_hwtcl-1:0];
   end
end
endgenerate

endmodule

// altera message_on  10036 10034 10230 10764


