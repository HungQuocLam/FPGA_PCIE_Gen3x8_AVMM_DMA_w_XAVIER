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


`timescale 1 ps/1 ps 



module top_DUT_altera_xcvr_native_a10_191_o3savxa
  #(
    //---------------------
    // Common parameters
    //---------------------
    parameter device_revision     = "20nm5es",      // (20nm5es, 20nm5es2, 20nm4, 20nm3, 20nm4qor,20nm2, 20nm1)

    parameter duplex_mode         = "duplex",       // (tx,rx,duplex)
    parameter channels            = 1,              // legal values 1+

    parameter enable_calibration  = 1,              // (0,1)
                                                    // 0 - Disable transceiver calibration
                                                    // 1 - Enable transceiver calibration
    
    parameter enable_analog_resets        = 1,      // (0,1)
                                                    // 0 - Disable tx_analog and rx_analog reset input connections. Still allows soft register override
                                                    // 1 - Enable tx_analog and rx_analog reset input connections
    
    parameter enable_reset_sequence       = 1,      // (0,1) 
                                                    // 0 - Disable reset sequencing 
                                                    // 1 - Enable reset sequencing 

    // TX PMA
    parameter bonded_mode         = "not_bonded",   // (not_bonded,pma_only,pma_pcs) not_bonded-Disable bonding,
                                                    //  pma_only - Enable PMA only bonding
                                                    //  pma_pcs - Enable PMA and PCS bonding
    parameter pcs_bonding_master  = 0,              // (0:channels-1), Specifies PCS bonding master
    parameter plls                = 1,              // (1,2,3,4)
    parameter number_physical_bonding_clocks = 1,   // (1,2,3,4)
    parameter cdr_refclk_cnt      = 1,              // (1,2,3,4,5)   
    parameter enable_hip          = 0,              // (0,1) 0 - Not PCIe HIP, 1 - PCIe HIP

    //----------------------
    // Reconfiguration options
    //----------------------
    parameter rcfg_enable         = 0,              // (0,1)
                                                    // 0 - Disable the AVMM reconfiguration interface.
                                                    // 1 - Enable the AVMM reconfiguration interface.

    parameter rcfg_shared         = 0,              // (0,1)
                                                    // 0 - Present separate AVMM interface for each channel,
                                                    // 1 - Present shared AVMM interface for all channels using address decoding.
                                                    //      Bits [n:10] of "reconfig_address" select the channel to address.
                                                    //      Bit  [9] selects between soft registers (1) and HSSI channel registers (0)
                                                    //      Bits [8:0] of "reconfig_address" provide the register offset within soft or hard register space.

    parameter rcfg_jtag_enable    = 0,              // (0,1)
                                                    // 0 - Disable embedded debug master
                                                    // 1 - Enable embedded JTAG master. Requires "rcfg_shared==1".

    parameter rcfg_separate_avmm_busy = 0,          // (0,1)
                                                    // 0 - AVMM busy is reflected on the waitrequest
                                                    // 1 - AVMM busy must be read from a soft CSR
    // Atom parameters
    parameter dbg_embedded_debug_enable   = 0,      // enables embedded debug blocks
    parameter dbg_capability_reg_enable   = 0,      // enables capability registers to describe the debug endpoint
    parameter dbg_user_identifier         = 0,      // user-assigned value to either define phy_ip or to link associated ip
    parameter dbg_stat_soft_logic_enable  = 0,      // enables soft logic to read status signals through avmm
    parameter dbg_ctrl_soft_logic_enable  = 0,      // enables soft logic to write control signals through avmm
    parameter dbg_prbs_soft_logic_enable  = 0,      // enables soft logic for prbs err accumulation
    parameter dbg_odi_soft_logic_enable   = 0,

     parameter rcfg_emb_strm_enable       = 0,      // (0,1)
                                                    // 0 - Disable embedded reconfiguration streamer
                                                    // 1 - Enable embedded reconfiguration streamer

    parameter rcfg_profile_cnt            = 2,      //Number of configuration profiles for embedded reconfiguration streamer

    // ADME Parameters
    parameter adme_prot_mode              = "basic_tx",
    parameter adme_pma_mode               = "basic_enh",
    parameter adme_tx_power_mode          = "low_power",
    parameter adme_data_rate              = "5000000000",

    // Parameters for the PCIe DFE IP
    parameter enable_pcie_dfe_ip          = 0,
    parameter sim_reduced_counters        = 0,
    parameter disable_continuous_dfe      = 0,

    parameter         hssi_rx_pld_pcs_interface_hd_chnl_hip_en                                  = "disable"                            ,//disable enable
    parameter         hssi_rx_pld_pcs_interface_hd_chnl_hrdrstctl_en                            = "disable"                            ,//disable enable
    parameter         hssi_rx_pld_pcs_interface_hd_chnl_prot_mode_rx                            = "disabled_prot_mode_rx"              ,//basic_10gpcs_krfec_rx basic_10gpcs_rx basic_8gpcs_rm_disable_rx basic_8gpcs_rm_enable_rx cpri_8b10b_rx disabled_prot_mode_rx fortyg_basekr_krfec_rx gige_1588_rx gige_rx interlaken_rx pcie_g1_capable_rx pcie_g2_capable_rx pcie_g3_capable_rx pcs_direct_rx prbs_rx prp_krfec_rx prp_rx sfis_rx teng_1588_basekr_krfec_rx teng_1588_baser_rx teng_basekr_krfec_rx teng_baser_rx teng_sdi_rx
    parameter         hssi_rx_pld_pcs_interface_hd_chnl_ctrl_plane_bonding_rx                   = "individual_rx"                      ,//ctrl_master_rx ctrl_slave_abv_rx ctrl_slave_blw_rx individual_rx
    parameter         hssi_rx_pld_pcs_interface_hd_chnl_pma_dw_rx                               = "pma_8b_rx"                          ,//pcie_g3_dyn_dw_rx pma_10b_rx pma_16b_rx pma_20b_rx pma_32b_rx pma_40b_rx pma_64b_rx pma_8b_rx
    parameter         hssi_rx_pld_pcs_interface_hd_chnl_pld_fifo_mode_rx                        = "fifo_rx"                            ,//fifo_rx reg_rx
    parameter         hssi_rx_pld_pcs_interface_hd_chnl_shared_fifo_width_rx                    = "single_rx"                          ,//double_rx single_rx
    parameter         hssi_rx_pld_pcs_interface_hd_chnl_low_latency_en_rx                       = "disable"                            ,//disable enable
    parameter         hssi_rx_pld_pcs_interface_hd_chnl_func_mode                               = "disable"                            ,//disable enable
    parameter         hssi_rx_pld_pcs_interface_hd_chnl_channel_operation_mode                  = "tx_rx_pair_enabled"                 ,//tx_rx_independent tx_rx_pair_enabled
    parameter         hssi_rx_pld_pcs_interface_hd_chnl_lpbk_en                                 = "disable"                            ,//disable enable
    parameter         hssi_rx_pld_pcs_interface_hd_chnl_frequency_rules_en                      = "disable"                            ,//disable enable
    parameter [29:0]  hssi_rx_pld_pcs_interface_hd_chnl_pma_rx_clk_hz                           = 30'd0                                ,//0:1073741823
    parameter [29:0]  hssi_rx_pld_pcs_interface_hd_chnl_pld_rx_clk_hz                           = 30'd0                                ,//0:1073741823
    parameter [29:0]  hssi_rx_pld_pcs_interface_hd_chnl_fref_clk_hz                             = 30'd0                                ,//0:1073741823
    parameter [29:0]  hssi_rx_pld_pcs_interface_hd_chnl_clklow_clk_hz                           = 30'd0                                ,//0:1073741823
    parameter         hssi_rx_pld_pcs_interface_hd_fifo_channel_operation_mode                  = "tx_rx_pair_enabled"                 ,//tx_rx_independent tx_rx_pair_enabled
    parameter         hssi_rx_pld_pcs_interface_hd_fifo_prot_mode_rx                            = "teng_mode_rx"                       ,//non_teng_mode_rx teng_mode_rx
    parameter         hssi_rx_pld_pcs_interface_hd_fifo_shared_fifo_width_rx                    = "single_rx"                          ,//double_rx single_rx
    parameter         hssi_rx_pld_pcs_interface_hd_10g_channel_operation_mode                   = "tx_rx_pair_enabled"                 ,//tx_rx_independent tx_rx_pair_enabled
    parameter         hssi_rx_pld_pcs_interface_hd_10g_lpbk_en                                  = "disable"                            ,//disable enable
    parameter         hssi_rx_pld_pcs_interface_hd_10g_pma_dw_rx                                = "pma_64b_rx"                         ,//pma_32b_rx pma_40b_rx pma_64b_rx
    parameter         hssi_rx_pld_pcs_interface_hd_10g_fifo_mode_rx                             = "fifo_rx"                            ,//fifo_rx reg_rx
    parameter         hssi_rx_pld_pcs_interface_hd_10g_prot_mode_rx                             = "disabled_prot_mode_rx"              ,//basic_krfec_mode_rx basic_mode_rx disabled_prot_mode_rx interlaken_mode_rx sfis_mode_rx teng_1588_krfec_mode_rx teng_1588_mode_rx teng_baser_krfec_mode_rx teng_baser_mode_rx teng_sdi_mode_rx test_prp_krfec_mode_rx test_prp_mode_rx
    parameter         hssi_rx_pld_pcs_interface_hd_10g_low_latency_en_rx                        = "enable"                             ,//disable enable
    parameter         hssi_rx_pld_pcs_interface_hd_10g_shared_fifo_width_rx                     = "single_rx"                          ,//double_rx single_rx
    parameter         hssi_rx_pld_pcs_interface_hd_10g_test_bus_mode                            = "tx"                                 ,//rx tx
    parameter         hssi_rx_pld_pcs_interface_hd_8g_channel_operation_mode                    = "tx_rx_pair_enabled"                 ,//tx_rx_independent tx_rx_pair_enabled
    parameter         hssi_rx_pld_pcs_interface_hd_8g_lpbk_en                                   = "disable"                            ,//disable enable
    parameter         hssi_rx_pld_pcs_interface_hd_8g_prot_mode_rx                              = "disabled_prot_mode_rx"              ,//basic_rm_disable_rx basic_rm_enable_rx cpri_rx cpri_rx_tx_rx disabled_prot_mode_rx gige_1588_rx gige_rx pipe_g1_rx pipe_g2_rx pipe_g3_rx
    parameter         hssi_rx_pld_pcs_interface_hd_8g_hip_mode                                  = "disable"                            ,//disable enable
    parameter         hssi_rx_pld_pcs_interface_hd_8g_pma_dw_rx                                 = "pma_8b_rx"                          ,//pma_10b_rx pma_16b_rx pma_20b_rx pma_8b_rx
    parameter         hssi_rx_pld_pcs_interface_hd_8g_fifo_mode_rx                              = "fifo_rx"                            ,//fifo_rx reg_rx
    parameter         hssi_rx_pld_pcs_interface_hd_g3_prot_mode                                 = "disabled_prot_mode"                 ,//disabled_prot_mode pipe_g1 pipe_g2 pipe_g3
    parameter         hssi_rx_pld_pcs_interface_hd_krfec_channel_operation_mode                 = "tx_rx_pair_enabled"                 ,//tx_rx_independent tx_rx_pair_enabled
    parameter         hssi_rx_pld_pcs_interface_hd_krfec_lpbk_en                                = "disable"                            ,//disable enable
    parameter         hssi_rx_pld_pcs_interface_hd_krfec_prot_mode_rx                           = "disabled_prot_mode_rx"              ,//basic_mode_rx disabled_prot_mode_rx fortyg_basekr_mode_rx teng_1588_basekr_mode_rx teng_basekr_mode_rx
    parameter         hssi_rx_pld_pcs_interface_hd_krfec_low_latency_en_rx                      = "disable"                            ,//disable enable
    parameter         hssi_rx_pld_pcs_interface_hd_krfec_test_bus_mode                          = "tx"                                 ,//rx tx
    parameter         hssi_rx_pld_pcs_interface_hd_pmaif_lpbk_en                                = "disable"                            ,//disable enable
    parameter         hssi_rx_pld_pcs_interface_hd_pmaif_channel_operation_mode                 = "tx_rx_pair_enabled"                 ,//tx_rx_independent tx_rx_pair_enabled
    parameter         hssi_rx_pld_pcs_interface_hd_pmaif_sim_mode                               = "disable"                            ,//disable enable
    parameter         hssi_rx_pld_pcs_interface_hd_pmaif_prot_mode_rx                           = "disabled_prot_mode_rx"              ,//disabled_prot_mode_rx eightg_basic_mode_rx eightg_g3_pcie_g3_hip_mode_rx eightg_g3_pcie_g3_pld_mode_rx eightg_only_pld_mode_rx eightg_pcie_g12_hip_mode_rx eightg_pcie_g12_pld_mode_rx pcs_direct_mode_rx prbs_mode_rx teng_basic_mode_rx teng_krfec_mode_rx teng_sfis_sdi_mode_rx
    parameter         hssi_rx_pld_pcs_interface_hd_pmaif_pma_dw_rx                              = "pma_8b_rx"                          ,//pcie_g3_dyn_dw_rx pma_10b_rx pma_16b_rx pma_20b_rx pma_32b_rx pma_40b_rx pma_64b_rx pma_8b_rx
    parameter         hssi_rx_pld_pcs_interface_hd_pldif_prot_mode_rx                           = "disabled_prot_mode_rx"              ,//disabled_prot_mode_rx eightg_and_g3_pld_fifo_mode_rx eightg_and_g3_reg_mode_hip_rx eightg_and_g3_reg_mode_rx pcs_direct_reg_mode_rx teng_and_krfec_pld_fifo_mode_rx teng_and_krfec_reg_mode_rx teng_pld_fifo_mode_rx teng_reg_mode_rx
    parameter         hssi_rx_pld_pcs_interface_hd_pldif_hrdrstctl_en                           = "disable"                            ,//disable enable
    parameter         hssi_rx_pld_pcs_interface_pcs_rx_block_sel                                = "pcs_direct"                         ,//eightg pcs_direct teng
    parameter         hssi_rx_pld_pcs_interface_pcs_rx_clk_sel                                  = "pld_rx_clk"                         ,//pcs_rx_clk pld_rx_clk
    parameter         hssi_rx_pld_pcs_interface_pcs_rx_hip_clk_en                               = "hip_rx_enable"                      ,//hip_rx_disable hip_rx_enable
    parameter         hssi_rx_pld_pcs_interface_pcs_rx_output_sel                               = "teng_output"                        ,//krfec_output teng_output
    parameter         hssi_rx_pld_pcs_interface_pcs_rx_clk_out_sel                              = "teng_clk_out"                       ,//eightg_clk_out pma_rx_clk pma_rx_clk_user teng_clk_out
    parameter         hssi_tx_pld_pcs_interface_hd_chnl_hip_en                                  = "disable"                            ,//disable enable
    parameter         hssi_tx_pld_pcs_interface_hd_chnl_hrdrstctl_en                            = "disable"                            ,//disable enable
    parameter         hssi_tx_pld_pcs_interface_hd_chnl_prot_mode_tx                            = "disabled_prot_mode_tx"              ,//basic_10gpcs_krfec_tx basic_10gpcs_tx basic_8gpcs_tx cpri_8b10b_tx disabled_prot_mode_tx fortyg_basekr_krfec_tx gige_1588_tx gige_tx interlaken_tx pcie_g1_capable_tx pcie_g2_capable_tx pcie_g3_capable_tx pcs_direct_tx prbs_tx prp_krfec_tx prp_tx sfis_tx sqwave_tx teng_1588_basekr_krfec_tx teng_1588_baser_tx teng_basekr_krfec_tx teng_baser_tx teng_sdi_tx uhsif_tx
    parameter         hssi_tx_pld_pcs_interface_hd_chnl_ctrl_plane_bonding_tx                   = "individual_tx"                      ,//ctrl_master_tx ctrl_slave_abv_tx ctrl_slave_blw_tx individual_tx
    parameter         hssi_tx_pld_pcs_interface_hd_chnl_pma_dw_tx                               = "pma_8b_tx"                          ,//pcie_g3_dyn_dw_tx pma_10b_tx pma_16b_tx pma_20b_tx pma_32b_tx pma_40b_tx pma_64b_tx pma_8b_tx
    parameter         hssi_tx_pld_pcs_interface_hd_chnl_pld_fifo_mode_tx                        = "fifo_tx"                            ,//fastreg_tx fifo_tx reg_tx
    parameter         hssi_tx_pld_pcs_interface_hd_chnl_shared_fifo_width_tx                    = "single_tx"                          ,//double_tx single_tx
    parameter         hssi_tx_pld_pcs_interface_hd_chnl_low_latency_en_tx                       = "disable"                            ,//disable enable
    parameter         hssi_tx_pld_pcs_interface_hd_chnl_func_mode                               = "disable"                            ,//disable enable
    parameter         hssi_tx_pld_pcs_interface_hd_chnl_channel_operation_mode                  = "tx_rx_pair_enabled"                 ,//tx_rx_independent tx_rx_pair_enabled
    parameter         hssi_tx_pld_pcs_interface_hd_chnl_lpbk_en                                 = "disable"                            ,//disable enable
    parameter         hssi_tx_pld_pcs_interface_hd_chnl_frequency_rules_en                      = "disable"                            ,//disable enable
    parameter [29:0]  hssi_tx_pld_pcs_interface_hd_chnl_pma_tx_clk_hz                           = 30'd0                                ,//0:1073741823
    parameter [29:0]  hssi_tx_pld_pcs_interface_hd_chnl_pld_tx_clk_hz                           = 30'd0                                ,//0:1073741823
    parameter [29:0]  hssi_tx_pld_pcs_interface_hd_chnl_pld_uhsif_tx_clk_hz                     = 30'd0                                ,//0:1073741823
    parameter         hssi_tx_pld_pcs_interface_hd_fifo_channel_operation_mode                  = "tx_rx_pair_enabled"                 ,//tx_rx_independent tx_rx_pair_enabled
    parameter         hssi_tx_pld_pcs_interface_hd_fifo_prot_mode_tx                            = "teng_mode_tx"                       ,//non_teng_mode_tx teng_mode_tx
    parameter         hssi_tx_pld_pcs_interface_hd_fifo_shared_fifo_width_tx                    = "single_tx"                          ,//double_tx single_tx
    parameter         hssi_tx_pld_pcs_interface_hd_10g_channel_operation_mode                   = "tx_rx_pair_enabled"                 ,//tx_rx_independent tx_rx_pair_enabled
    parameter         hssi_tx_pld_pcs_interface_hd_10g_lpbk_en                                  = "disable"                            ,//disable enable
    parameter         hssi_tx_pld_pcs_interface_hd_10g_pma_dw_tx                                = "pma_64b_tx"                         ,//pma_32b_tx pma_40b_tx pma_64b_tx
    parameter         hssi_tx_pld_pcs_interface_hd_10g_fifo_mode_tx                             = "fifo_tx"                            ,//fastreg_tx fifo_tx reg_tx
    parameter         hssi_tx_pld_pcs_interface_hd_10g_prot_mode_tx                             = "disabled_prot_mode_tx"              ,//basic_krfec_mode_tx basic_mode_tx disabled_prot_mode_tx interlaken_mode_tx sfis_mode_tx teng_1588_krfec_mode_tx teng_1588_mode_tx teng_baser_krfec_mode_tx teng_baser_mode_tx teng_sdi_mode_tx test_prp_krfec_mode_tx test_prp_mode_tx
    parameter         hssi_tx_pld_pcs_interface_hd_10g_low_latency_en_tx                        = "enable"                             ,//disable enable
    parameter         hssi_tx_pld_pcs_interface_hd_10g_shared_fifo_width_tx                     = "single_tx"                          ,//double_tx single_tx
    parameter         hssi_tx_pld_pcs_interface_hd_8g_channel_operation_mode                    = "tx_rx_pair_enabled"                 ,//tx_rx_independent tx_rx_pair_enabled
    parameter         hssi_tx_pld_pcs_interface_hd_8g_lpbk_en                                   = "disable"                            ,//disable enable
    parameter         hssi_tx_pld_pcs_interface_hd_8g_prot_mode_tx                              = "disabled_prot_mode_tx"              ,//basic_tx cpri_rx_tx_tx cpri_tx disabled_prot_mode_tx gige_1588_tx gige_tx pipe_g1_tx pipe_g2_tx pipe_g3_tx
    parameter         hssi_tx_pld_pcs_interface_hd_8g_hip_mode                                  = "disable"                            ,//disable enable
    parameter         hssi_tx_pld_pcs_interface_hd_8g_pma_dw_tx                                 = "pma_8b_tx"                          ,//pma_10b_tx pma_16b_tx pma_20b_tx pma_8b_tx
    parameter         hssi_tx_pld_pcs_interface_hd_8g_fifo_mode_tx                              = "fifo_tx"                            ,//fastreg_tx fifo_tx reg_tx
    parameter         hssi_tx_pld_pcs_interface_hd_g3_prot_mode                                 = "disabled_prot_mode"                 ,//disabled_prot_mode pipe_g1 pipe_g2 pipe_g3
    parameter         hssi_tx_pld_pcs_interface_hd_krfec_channel_operation_mode                 = "tx_rx_pair_enabled"                 ,//tx_rx_independent tx_rx_pair_enabled
    parameter         hssi_tx_pld_pcs_interface_hd_krfec_lpbk_en                                = "disable"                            ,//disable enable
    parameter         hssi_tx_pld_pcs_interface_hd_krfec_prot_mode_tx                           = "disabled_prot_mode_tx"              ,//basic_mode_tx disabled_prot_mode_tx fortyg_basekr_mode_tx teng_1588_basekr_mode_tx teng_basekr_mode_tx
    parameter         hssi_tx_pld_pcs_interface_hd_krfec_low_latency_en_tx                      = "disable"                            ,//disable enable
    parameter         hssi_tx_pld_pcs_interface_hd_pmaif_lpbk_en                                = "disable"                            ,//disable enable
    parameter         hssi_tx_pld_pcs_interface_hd_pmaif_channel_operation_mode                 = "tx_rx_pair_enabled"                 ,//tx_rx_independent tx_rx_pair_enabled
    parameter         hssi_tx_pld_pcs_interface_hd_pmaif_sim_mode                               = "disable"                            ,//disable enable
    parameter         hssi_tx_pld_pcs_interface_hd_pmaif_prot_mode_tx                           = "disabled_prot_mode_tx"              ,//disabled_prot_mode_tx eightg_basic_mode_tx eightg_g3_pcie_g3_hip_mode_tx eightg_g3_pcie_g3_pld_mode_tx eightg_only_pld_mode_tx eightg_pcie_g12_hip_mode_tx eightg_pcie_g12_pld_mode_tx pcs_direct_mode_tx prbs_mode_tx sqwave_mode_tx teng_basic_mode_tx teng_krfec_mode_tx teng_sfis_sdi_mode_tx uhsif_direct_mode_tx uhsif_reg_mode_tx
    parameter         hssi_tx_pld_pcs_interface_hd_pmaif_pma_dw_tx                              = "pma_8b_tx"                          ,//pcie_g3_dyn_dw_tx pma_10b_tx pma_16b_tx pma_20b_tx pma_32b_tx pma_40b_tx pma_64b_tx pma_8b_tx
    parameter         hssi_tx_pld_pcs_interface_hd_pldif_prot_mode_tx                           = "disabled_prot_mode_tx"              ,//disabled_prot_mode_tx eightg_and_g3_fastreg_mode_tx eightg_and_g3_pld_fifo_mode_tx eightg_and_g3_reg_mode_hip_tx eightg_and_g3_reg_mode_tx pcs_direct_fastreg_mode_tx teng_and_krfec_fastreg_mode_tx teng_and_krfec_pld_fifo_mode_tx teng_and_krfec_reg_mode_tx teng_fastreg_mode_tx teng_pld_fifo_mode_tx teng_reg_mode_tx uhsif_mode_tx
    parameter         hssi_tx_pld_pcs_interface_hd_pldif_hrdrstctl_en                           = "disable"                            ,//disable enable
    parameter         hssi_tx_pld_pcs_interface_pcs_tx_clk_source                               = "teng"                               ,//eightg pma_clk teng
    parameter         hssi_tx_pld_pcs_interface_pcs_tx_data_source                              = "hip_disable"                        ,//hip_disable hip_enable
    parameter         hssi_tx_pld_pcs_interface_pcs_tx_delay1_clk_en                            = "delay1_clk_disable"                 ,//delay1_clk_disable delay1_clk_enable
    parameter         hssi_tx_pld_pcs_interface_pcs_tx_delay1_clk_sel                           = "pld_tx_clk"                         ,//pcs_tx_clk pld_tx_clk
    parameter         hssi_tx_pld_pcs_interface_pcs_tx_delay1_ctrl                              = "delay1_path0"                       ,//delay1_path0 delay1_path1 delay1_path2 delay1_path3 delay1_path4
    parameter         hssi_tx_pld_pcs_interface_pcs_tx_delay1_data_sel                          = "one_ff_delay"                       ,//one_ff_delay two_ff_delay
    parameter         hssi_tx_pld_pcs_interface_pcs_tx_delay2_clk_en                            = "delay2_clk_disable"                 ,//delay2_clk_disable delay2_clk_enable
    parameter         hssi_tx_pld_pcs_interface_pcs_tx_delay2_ctrl                              = "delay2_path0"                       ,//delay2_path0 delay2_path1 delay2_path2 delay2_path3 delay2_path4
    parameter         hssi_tx_pld_pcs_interface_pcs_tx_output_sel                               = "teng_output"                        ,//krfec_output teng_output
    parameter         hssi_tx_pld_pcs_interface_pcs_tx_clk_out_sel                              = "teng_clk_out"                       ,//eightg_clk_out pma_tx_clk pma_tx_clk_user teng_clk_out
    parameter         hssi_krfec_tx_pcs_burst_err                                               = "burst_err_dis"                      ,//burst_err_dis burst_err_en
    parameter         hssi_krfec_tx_pcs_burst_err_len                                           = "burst_err_len1"                     ,//burst_err_len1 burst_err_len10 burst_err_len11 burst_err_len12 burst_err_len13 burst_err_len14 burst_err_len15 burst_err_len16 burst_err_len2 burst_err_len3 burst_err_len4 burst_err_len5 burst_err_len6 burst_err_len7 burst_err_len8 burst_err_len9
    parameter         hssi_krfec_tx_pcs_ctrl_bit_reverse                                        = "ctrl_bit_reverse_dis"               ,//ctrl_bit_reverse_dis ctrl_bit_reverse_en
    parameter         hssi_krfec_tx_pcs_data_bit_reverse                                        = "data_bit_reverse_dis"               ,//data_bit_reverse_dis data_bit_reverse_en
    parameter         hssi_krfec_tx_pcs_enc_frame_query                                         = "enc_query_dis"                      ,//enc_query_dis enc_query_en
    parameter         hssi_krfec_tx_pcs_low_latency_en                                          = "disable"                            ,//disable enable
    parameter         hssi_krfec_tx_pcs_pipeln_encoder                                          = "enable"                             ,//disable enable
    parameter         hssi_krfec_tx_pcs_pipeln_scrambler                                        = "enable"                             ,//disable enable
    parameter         hssi_krfec_tx_pcs_prot_mode                                               = "disable_mode"                       ,//basic_mode disable_mode fortyg_basekr_mode teng_1588_basekr_mode teng_basekr_mode
    parameter         hssi_krfec_tx_pcs_sup_mode                                                = "user_mode"                          ,//engineering_mode user_mode
    parameter         hssi_krfec_tx_pcs_transcode_err                                           = "trans_err_dis"                      ,//trans_err_dis trans_err_en
    parameter         hssi_krfec_tx_pcs_transmit_order                                          = "transmit_lsb"                       ,//transmit_lsb transmit_msb
    parameter         hssi_krfec_tx_pcs_tx_testbus_sel                                          = "overall"                            ,//encoder1 encoder2 gearbox overall scramble1 scramble2 scramble3
    parameter         hssi_10g_rx_pcs_align_del                                                 = "align_del_en"                       ,//align_del_dis align_del_en
    parameter         hssi_10g_rx_pcs_ber_bit_err_total_cnt                                     = "bit_err_total_cnt_10g"              ,//bit_err_total_cnt_10g
    parameter         hssi_10g_rx_pcs_ber_clken                                                 = "ber_clk_dis"                        ,//ber_clk_dis ber_clk_en
    parameter [20:0]  hssi_10g_rx_pcs_ber_xus_timer_window                                      = 21'd19530                            ,//0:2097151
    parameter         hssi_10g_rx_pcs_bitslip_mode                                              = "bitslip_dis"                        ,//bitslip_dis bitslip_en
    parameter         hssi_10g_rx_pcs_blksync_bitslip_type                                      = "bitslip_comb"                       ,//bitslip_comb bitslip_reg
    parameter [2:0]   hssi_10g_rx_pcs_blksync_bitslip_wait_cnt                                  = 3'd1                                 ,//0:7
    parameter         hssi_10g_rx_pcs_blksync_bitslip_wait_type                                 = "bitslip_match"                      ,//bitslip_cnt bitslip_match
    parameter         hssi_10g_rx_pcs_blksync_bypass                                            = "blksync_bypass_dis"                 ,//blksync_bypass_dis blksync_bypass_en
    parameter         hssi_10g_rx_pcs_blksync_clken                                             = "blksync_clk_dis"                    ,//blksync_clk_dis blksync_clk_en
    parameter         hssi_10g_rx_pcs_blksync_enum_invalid_sh_cnt                               = "enum_invalid_sh_cnt_10g"            ,//enum_invalid_sh_cnt_10g
    parameter         hssi_10g_rx_pcs_blksync_knum_sh_cnt_postlock                              = "knum_sh_cnt_postlock_10g"           ,//knum_sh_cnt_postlock_10g
    parameter         hssi_10g_rx_pcs_blksync_knum_sh_cnt_prelock                               = "knum_sh_cnt_prelock_10g"            ,//knum_sh_cnt_prelock_10g
    parameter         hssi_10g_rx_pcs_blksync_pipeln                                            = "blksync_pipeln_dis"                 ,//blksync_pipeln_dis blksync_pipeln_en
    parameter         hssi_10g_rx_pcs_clr_errblk_cnt_en                                         = "disable"                            ,//disable enable
    parameter         hssi_10g_rx_pcs_control_del                                               = "control_del_all"                    ,//control_del_all control_del_none
    parameter         hssi_10g_rx_pcs_crcchk_bypass                                             = "crcchk_bypass_dis"                  ,//crcchk_bypass_dis crcchk_bypass_en
    parameter         hssi_10g_rx_pcs_crcchk_clken                                              = "crcchk_clk_dis"                     ,//crcchk_clk_dis crcchk_clk_en
    parameter         hssi_10g_rx_pcs_crcchk_inv                                                = "crcchk_inv_dis"                     ,//crcchk_inv_dis crcchk_inv_en
    parameter         hssi_10g_rx_pcs_crcchk_pipeln                                             = "crcchk_pipeln_dis"                  ,//crcchk_pipeln_dis crcchk_pipeln_en
    parameter         hssi_10g_rx_pcs_crcflag_pipeln                                            = "crcflag_pipeln_dis"                 ,//crcflag_pipeln_dis crcflag_pipeln_en
    parameter         hssi_10g_rx_pcs_ctrl_bit_reverse                                          = "ctrl_bit_reverse_dis"               ,//ctrl_bit_reverse_dis ctrl_bit_reverse_en
    parameter         hssi_10g_rx_pcs_data_bit_reverse                                          = "data_bit_reverse_dis"               ,//data_bit_reverse_dis data_bit_reverse_en
    parameter         hssi_10g_rx_pcs_dec_64b66b_rxsm_bypass                                    = "dec_64b66b_rxsm_bypass_dis"         ,//dec_64b66b_rxsm_bypass_dis dec_64b66b_rxsm_bypass_en
    parameter         hssi_10g_rx_pcs_dec64b66b_clken                                           = "dec64b66b_clk_dis"                  ,//dec64b66b_clk_dis dec64b66b_clk_en
    parameter         hssi_10g_rx_pcs_descrm_bypass                                             = "descrm_bypass_en"                   ,//descrm_bypass_dis descrm_bypass_en
    parameter         hssi_10g_rx_pcs_descrm_clken                                              = "descrm_clk_dis"                     ,//descrm_clk_dis descrm_clk_en
    parameter         hssi_10g_rx_pcs_descrm_mode                                               = "async"                              ,//async sync
    parameter         hssi_10g_rx_pcs_descrm_pipeln                                             = "enable"                             ,//disable enable
    parameter         hssi_10g_rx_pcs_dft_clk_out_sel                                           = "rx_master_clk"                      ,//rx_64b66bdec_clk rx_ber_clk rx_blksync_clk rx_crcchk_clk rx_descrm_clk rx_fec_clk rx_frmsync_clk rx_gbexp_clk rx_master_clk rx_rand_clk rx_rdfifo_clk rx_wrfifo_clk
    parameter         hssi_10g_rx_pcs_dis_signal_ok                                             = "dis_signal_ok_dis"                  ,//dis_signal_ok_dis dis_signal_ok_en
    parameter         hssi_10g_rx_pcs_dispchk_bypass                                            = "dispchk_bypass_dis"                 ,//dispchk_bypass_dis dispchk_bypass_en
    parameter         hssi_10g_rx_pcs_empty_flag_type                                           = "empty_rd_side"                      ,//empty_rd_side empty_wr_side
    parameter         hssi_10g_rx_pcs_fast_path                                                 = "fast_path_dis"                      ,//fast_path_dis fast_path_en
    parameter         hssi_10g_rx_pcs_fec_clken                                                 = "fec_clk_dis"                        ,//fec_clk_dis fec_clk_en
    parameter         hssi_10g_rx_pcs_fec_enable                                                = "fec_dis"                            ,//fec_dis fec_en
    parameter         hssi_10g_rx_pcs_fifo_double_read                                          = "fifo_double_read_dis"               ,//fifo_double_read_dis fifo_double_read_en
    parameter         hssi_10g_rx_pcs_fifo_stop_rd                                              = "n_rd_empty"                         ,//n_rd_empty rd_empty
    parameter         hssi_10g_rx_pcs_fifo_stop_wr                                              = "n_wr_full"                          ,//n_wr_full wr_full
    parameter         hssi_10g_rx_pcs_force_align                                               = "force_align_dis"                    ,//force_align_dis force_align_en
    parameter         hssi_10g_rx_pcs_frmsync_bypass                                            = "frmsync_bypass_dis"                 ,//frmsync_bypass_dis frmsync_bypass_en
    parameter         hssi_10g_rx_pcs_frmsync_clken                                             = "frmsync_clk_dis"                    ,//frmsync_clk_dis frmsync_clk_en
    parameter         hssi_10g_rx_pcs_frmsync_enum_scrm                                         = "enum_scrm_default"                  ,//enum_scrm_default
    parameter         hssi_10g_rx_pcs_frmsync_enum_sync                                         = "enum_sync_default"                  ,//enum_sync_default
    parameter         hssi_10g_rx_pcs_frmsync_flag_type                                         = "all_framing_words"                  ,//all_framing_words location_only
    parameter         hssi_10g_rx_pcs_frmsync_knum_sync                                         = "knum_sync_default"                  ,//knum_sync_default
    parameter [15:0]  hssi_10g_rx_pcs_frmsync_mfrm_length                                       = 16'd2048                             ,//0:65535
    parameter         hssi_10g_rx_pcs_frmsync_pipeln                                            = "frmsync_pipeln_dis"                 ,//frmsync_pipeln_dis frmsync_pipeln_en
    parameter         hssi_10g_rx_pcs_full_flag_type                                            = "full_wr_side"                       ,//full_rd_side full_wr_side
    parameter         hssi_10g_rx_pcs_gb_rx_idwidth                                             = "width_32"                           ,//width_32 width_40 width_64
    parameter         hssi_10g_rx_pcs_gb_rx_odwidth                                             = "width_66"                           ,//width_32 width_40 width_50 width_64 width_66 width_67
    parameter         hssi_10g_rx_pcs_gbexp_clken                                               = "gbexp_clk_dis"                      ,//gbexp_clk_dis gbexp_clk_en
    parameter         hssi_10g_rx_pcs_low_latency_en                                            = "enable"                             ,//disable enable
    parameter         hssi_10g_rx_pcs_lpbk_mode                                                 = "lpbk_dis"                           ,//lpbk_dis lpbk_en
    parameter         hssi_10g_rx_pcs_master_clk_sel                                            = "master_rx_pma_clk"                  ,//master_refclk_dig master_rx_pma_clk master_tx_pma_clk
    parameter         hssi_10g_rx_pcs_pempty_flag_type                                          = "pempty_rd_side"                     ,//pempty_rd_side pempty_wr_side
    parameter         hssi_10g_rx_pcs_pfull_flag_type                                           = "pfull_wr_side"                      ,//pfull_rd_side pfull_wr_side
    parameter         hssi_10g_rx_pcs_phcomp_rd_del                                             = "phcomp_rd_del2"                     ,//phcomp_rd_del2 phcomp_rd_del3 phcomp_rd_del4
    parameter         hssi_10g_rx_pcs_pld_if_type                                               = "fifo"                               ,//fifo reg
    parameter         hssi_10g_rx_pcs_prot_mode                                                 = "disable_mode"                       ,//basic_krfec_mode basic_mode disable_mode interlaken_mode sfis_mode teng_1588_krfec_mode teng_1588_mode teng_baser_krfec_mode teng_baser_mode teng_sdi_mode test_prp_krfec_mode test_prp_mode
    parameter         hssi_10g_rx_pcs_rand_clken                                                = "rand_clk_dis"                       ,//rand_clk_dis rand_clk_en
    parameter         hssi_10g_rx_pcs_rd_clk_sel                                                = "rd_rx_pma_clk"                      ,//rd_refclk_dig rd_rx_pld_clk rd_rx_pma_clk
    parameter         hssi_10g_rx_pcs_rdfifo_clken                                              = "rdfifo_clk_dis"                     ,//rdfifo_clk_dis rdfifo_clk_en
    parameter         hssi_10g_rx_pcs_rx_fifo_write_ctrl                                        = "blklock_stops"                      ,//blklock_ignore blklock_stops
    parameter         hssi_10g_rx_pcs_rx_scrm_width                                             = "bit64"                              ,//bit64 bit66 bit67
    parameter         hssi_10g_rx_pcs_rx_sh_location                                            = "lsb"                                ,//lsb msb
    parameter         hssi_10g_rx_pcs_rx_signal_ok_sel                                          = "synchronized_ver"                   ,//nonsync_ver synchronized_ver
    parameter         hssi_10g_rx_pcs_rx_sm_bypass                                              = "rx_sm_bypass_dis"                   ,//rx_sm_bypass_dis rx_sm_bypass_en
    parameter         hssi_10g_rx_pcs_rx_sm_hiber                                               = "rx_sm_hiber_en"                     ,//rx_sm_hiber_dis rx_sm_hiber_en
    parameter         hssi_10g_rx_pcs_rx_sm_pipeln                                              = "rx_sm_pipeln_dis"                   ,//rx_sm_pipeln_dis rx_sm_pipeln_en
    parameter         hssi_10g_rx_pcs_rx_testbus_sel                                            = "crc32_chk_testbus1"                 ,//ber_testbus blank_testbus blksync_testbus1 blksync_testbus2 crc32_chk_testbus1 crc32_chk_testbus2 dec64b66b_testbus descramble_testbus frame_sync_testbus1 frame_sync_testbus2 gearbox_exp_testbus random_ver_testbus rxsm_testbus rx_fifo_testbus1 rx_fifo_testbus2
    parameter         hssi_10g_rx_pcs_rx_true_b2b                                               = "b2b"                                ,//b2b single
    parameter         hssi_10g_rx_pcs_rxfifo_empty                                              = "empty_default"                      ,//empty_default
    parameter         hssi_10g_rx_pcs_rxfifo_full                                               = "full_default"                       ,//full_default
    parameter         hssi_10g_rx_pcs_rxfifo_mode                                               = "phase_comp"                         ,//clk_comp_10g generic_basic generic_interlaken phase_comp phase_comp_dv register_mode
    parameter [4:0]   hssi_10g_rx_pcs_rxfifo_pempty                                             = 5'd2                                 ,//0:31
    parameter [4:0]   hssi_10g_rx_pcs_rxfifo_pfull                                              = 5'd23                                ,//0:31
    parameter         hssi_10g_rx_pcs_stretch_num_stages                                        = "zero_stage"                         ,//one_stage three_stage two_stage zero_stage
    parameter         hssi_10g_rx_pcs_sup_mode                                                  = "user_mode"                          ,//engineering_mode user_mode
    parameter         hssi_10g_rx_pcs_test_mode                                                 = "test_off"                           ,//pseudo_random test_off
    parameter         hssi_10g_rx_pcs_wrfifo_clken                                              = "wrfifo_clk_dis"                     ,//wrfifo_clk_dis wrfifo_clk_en
    parameter         hssi_10g_tx_pcs_bitslip_en                                                = "bitslip_dis"                        ,//bitslip_dis bitslip_en
    parameter         hssi_10g_tx_pcs_bonding_dft_en                                            = "dft_dis"                            ,//dft_dis dft_en
    parameter         hssi_10g_tx_pcs_bonding_dft_val                                           = "dft_0"                              ,//dft_0 dft_1
    parameter         hssi_10g_tx_pcs_crcgen_bypass                                             = "crcgen_bypass_dis"                  ,//crcgen_bypass_dis crcgen_bypass_en
    parameter         hssi_10g_tx_pcs_crcgen_clken                                              = "crcgen_clk_dis"                     ,//crcgen_clk_dis crcgen_clk_en
    parameter         hssi_10g_tx_pcs_crcgen_err                                                = "crcgen_err_dis"                     ,//crcgen_err_dis crcgen_err_en
    parameter         hssi_10g_tx_pcs_crcgen_inv                                                = "crcgen_inv_dis"                     ,//crcgen_inv_dis crcgen_inv_en
    parameter         hssi_10g_tx_pcs_ctrl_bit_reverse                                          = "ctrl_bit_reverse_dis"               ,//ctrl_bit_reverse_dis ctrl_bit_reverse_en
    parameter         hssi_10g_tx_pcs_data_bit_reverse                                          = "data_bit_reverse_dis"               ,//data_bit_reverse_dis data_bit_reverse_en
    parameter         hssi_10g_tx_pcs_dft_clk_out_sel                                           = "tx_master_clk"                      ,//tx_64b66benc_txsm_clk tx_crcgen_clk tx_dispgen_clk tx_fec_clk tx_frmgen_clk tx_gbred_clk tx_master_clk tx_rdfifo_clk tx_scrm_clk tx_wrfifo_clk
    parameter         hssi_10g_tx_pcs_dispgen_bypass                                            = "dispgen_bypass_dis"                 ,//dispgen_bypass_dis dispgen_bypass_en
    parameter         hssi_10g_tx_pcs_dispgen_clken                                             = "dispgen_clk_dis"                    ,//dispgen_clk_dis dispgen_clk_en
    parameter         hssi_10g_tx_pcs_dispgen_err                                               = "dispgen_err_dis"                    ,//dispgen_err_dis dispgen_err_en
    parameter         hssi_10g_tx_pcs_dispgen_pipeln                                            = "dispgen_pipeln_dis"                 ,//dispgen_pipeln_dis dispgen_pipeln_en
    parameter         hssi_10g_tx_pcs_empty_flag_type                                           = "empty_rd_side"                      ,//empty_rd_side empty_wr_side
    parameter         hssi_10g_tx_pcs_enc_64b66b_txsm_bypass                                    = "enc_64b66b_txsm_bypass_dis"         ,//enc_64b66b_txsm_bypass_dis enc_64b66b_txsm_bypass_en
    parameter         hssi_10g_tx_pcs_enc64b66b_txsm_clken                                      = "enc64b66b_txsm_clk_dis"             ,//enc64b66b_txsm_clk_dis enc64b66b_txsm_clk_en
    parameter         hssi_10g_tx_pcs_fastpath                                                  = "fastpath_dis"                       ,//fastpath_dis fastpath_en
    parameter         hssi_10g_tx_pcs_fec_clken                                                 = "fec_clk_dis"                        ,//fec_clk_dis fec_clk_en
    parameter         hssi_10g_tx_pcs_fec_enable                                                = "fec_dis"                            ,//fec_dis fec_en
    parameter         hssi_10g_tx_pcs_fifo_double_write                                         = "fifo_double_write_dis"              ,//fifo_double_write_dis fifo_double_write_en
    parameter         hssi_10g_tx_pcs_fifo_reg_fast                                             = "fifo_reg_fast_dis"                  ,//fifo_reg_fast_dis fifo_reg_fast_en
    parameter         hssi_10g_tx_pcs_fifo_stop_rd                                              = "n_rd_empty"                         ,//n_rd_empty rd_empty
    parameter         hssi_10g_tx_pcs_fifo_stop_wr                                              = "n_wr_full"                          ,//n_wr_full wr_full
    parameter         hssi_10g_tx_pcs_frmgen_burst                                              = "frmgen_burst_dis"                   ,//frmgen_burst_dis frmgen_burst_en
    parameter         hssi_10g_tx_pcs_frmgen_bypass                                             = "frmgen_bypass_dis"                  ,//frmgen_bypass_dis frmgen_bypass_en
    parameter         hssi_10g_tx_pcs_frmgen_clken                                              = "frmgen_clk_dis"                     ,//frmgen_clk_dis frmgen_clk_en
    parameter [15:0]  hssi_10g_tx_pcs_frmgen_mfrm_length                                        = 16'd2048                             ,//0:65535
    parameter         hssi_10g_tx_pcs_frmgen_pipeln                                             = "frmgen_pipeln_dis"                  ,//frmgen_pipeln_dis frmgen_pipeln_en
    parameter         hssi_10g_tx_pcs_frmgen_pyld_ins                                           = "frmgen_pyld_ins_dis"                ,//frmgen_pyld_ins_dis frmgen_pyld_ins_en
    parameter         hssi_10g_tx_pcs_frmgen_wordslip                                           = "frmgen_wordslip_dis"                ,//frmgen_wordslip_dis frmgen_wordslip_en
    parameter         hssi_10g_tx_pcs_full_flag_type                                            = "full_wr_side"                       ,//full_rd_side full_wr_side
    parameter         hssi_10g_tx_pcs_gb_pipeln_bypass                                          = "enable"                             ,//disable enable
    parameter         hssi_10g_tx_pcs_gb_tx_idwidth                                             = "width_50"                           ,//width_32 width_40 width_50 width_64 width_66 width_67
    parameter         hssi_10g_tx_pcs_gb_tx_odwidth                                             = "width_32"                           ,//width_32 width_40 width_64
    parameter         hssi_10g_tx_pcs_gbred_clken                                               = "gbred_clk_dis"                      ,//gbred_clk_dis gbred_clk_en
    parameter         hssi_10g_tx_pcs_low_latency_en                                            = "enable"                             ,//disable enable
    parameter         hssi_10g_tx_pcs_master_clk_sel                                            = "master_tx_pma_clk"                  ,//master_refclk_dig master_tx_pma_clk
    parameter         hssi_10g_tx_pcs_pempty_flag_type                                          = "pempty_rd_side"                     ,//pempty_rd_side pempty_wr_side
    parameter         hssi_10g_tx_pcs_pfull_flag_type                                           = "pfull_wr_side"                      ,//pfull_rd_side pfull_wr_side
    parameter         hssi_10g_tx_pcs_phcomp_rd_del                                             = "phcomp_rd_del2"                     ,//phcomp_rd_del2 phcomp_rd_del3 phcomp_rd_del4
    parameter         hssi_10g_tx_pcs_pld_if_type                                               = "fifo"                               ,//fastreg fifo reg
    parameter         hssi_10g_tx_pcs_prot_mode                                                 = "disable_mode"                       ,//basic_krfec_mode basic_mode disable_mode interlaken_mode sfis_mode teng_1588_krfec_mode teng_1588_mode teng_baser_krfec_mode teng_baser_mode teng_sdi_mode test_prp_krfec_mode test_prp_mode
    parameter         hssi_10g_tx_pcs_pseudo_random                                             = "all_0"                              ,//all_0 two_lf
    parameter         hssi_10g_tx_pcs_pseudo_seed_a                                             = "288230376151711743"                 ,//NOVAL
    parameter         hssi_10g_tx_pcs_pseudo_seed_b                                             = "288230376151711743"                 ,//NOVAL
    parameter         hssi_10g_tx_pcs_random_disp                                               = "disable"                            ,//disable enable
    parameter         hssi_10g_tx_pcs_rdfifo_clken                                              = "rdfifo_clk_dis"                     ,//rdfifo_clk_dis rdfifo_clk_en
    parameter         hssi_10g_tx_pcs_scrm_bypass                                               = "scrm_bypass_dis"                    ,//scrm_bypass_dis scrm_bypass_en
    parameter         hssi_10g_tx_pcs_scrm_clken                                                = "scrm_clk_dis"                       ,//scrm_clk_dis scrm_clk_en
    parameter         hssi_10g_tx_pcs_scrm_mode                                                 = "async"                              ,//async sync
    parameter         hssi_10g_tx_pcs_scrm_pipeln                                               = "enable"                             ,//disable enable
    parameter         hssi_10g_tx_pcs_sh_err                                                    = "sh_err_dis"                         ,//sh_err_dis sh_err_en
    parameter         hssi_10g_tx_pcs_sop_mark                                                  = "sop_mark_dis"                       ,//sop_mark_dis sop_mark_en
    parameter         hssi_10g_tx_pcs_stretch_num_stages                                        = "zero_stage"                         ,//one_stage three_stage two_stage zero_stage
    parameter         hssi_10g_tx_pcs_sup_mode                                                  = "user_mode"                          ,//engineering_mode user_mode
    parameter         hssi_10g_tx_pcs_test_mode                                                 = "test_off"                           ,//pseudo_random test_off
    parameter         hssi_10g_tx_pcs_tx_scrm_err                                               = "scrm_err_dis"                       ,//scrm_err_dis scrm_err_en
    parameter         hssi_10g_tx_pcs_tx_scrm_width                                             = "bit64"                              ,//bit64 bit66 bit67
    parameter         hssi_10g_tx_pcs_tx_sh_location                                            = "lsb"                                ,//lsb msb
    parameter         hssi_10g_tx_pcs_tx_sm_bypass                                              = "tx_sm_bypass_dis"                   ,//tx_sm_bypass_dis tx_sm_bypass_en
    parameter         hssi_10g_tx_pcs_tx_sm_pipeln                                              = "tx_sm_pipeln_dis"                   ,//tx_sm_pipeln_dis tx_sm_pipeln_en
    parameter         hssi_10g_tx_pcs_tx_testbus_sel                                            = "crc32_gen_testbus1"                 ,//blank_testbus crc32_gen_testbus1 crc32_gen_testbus2 disp_gen_testbus1 disp_gen_testbus2 enc64b66b_testbus frame_gen_testbus1 frame_gen_testbus2 gearbox_red_testbus scramble_testbus txsm_testbus tx_cp_bond_testbus tx_fifo_testbus1 tx_fifo_testbus2
    parameter         hssi_10g_tx_pcs_txfifo_empty                                              = "empty_default"                      ,//empty_default
    parameter         hssi_10g_tx_pcs_txfifo_full                                               = "full_default"                       ,//full_default
    parameter         hssi_10g_tx_pcs_txfifo_mode                                               = "phase_comp"                         ,//basic_generic interlaken_generic phase_comp register_mode
    parameter [3:0]   hssi_10g_tx_pcs_txfifo_pempty                                             = 4'd2                                 ,//0:15
    parameter [3:0]   hssi_10g_tx_pcs_txfifo_pfull                                              = 4'd11                                ,//0:15
    parameter         hssi_10g_tx_pcs_wr_clk_sel                                                = "wr_tx_pma_clk"                      ,//wr_refclk_dig wr_tx_pld_clk wr_tx_pma_clk
    parameter         hssi_10g_tx_pcs_wrfifo_clken                                              = "wrfifo_clk_dis"                     ,//wrfifo_clk_dis wrfifo_clk_en
    parameter         hssi_8g_rx_pcs_auto_error_replacement                                     = "dis_err_replace"                    ,//dis_err_replace en_err_replace
    parameter         hssi_8g_rx_pcs_bit_reversal                                               = "dis_bit_reversal"                   ,//dis_bit_reversal en_bit_reversal
    parameter         hssi_8g_rx_pcs_bonding_dft_en                                             = "dft_dis"                            ,//dft_dis dft_en
    parameter         hssi_8g_rx_pcs_bonding_dft_val                                            = "dft_0"                              ,//dft_0 dft_1
    parameter         hssi_8g_rx_pcs_bypass_pipeline_reg                                        = "dis_bypass_pipeline"                ,//dis_bypass_pipeline en_bypass_pipeline
    parameter         hssi_8g_rx_pcs_byte_deserializer                                          = "dis_bds"                            ,//dis_bds en_bds_by_2 en_bds_by_2_det en_bds_by_4
    parameter         hssi_8g_rx_pcs_cdr_ctrl_rxvalid_mask                                      = "dis_rxvalid_mask"                   ,//dis_rxvalid_mask en_rxvalid_mask
    parameter [19:0]  hssi_8g_rx_pcs_clkcmp_pattern_n                                           = 20'd0                                ,//0:1048575
    parameter [19:0]  hssi_8g_rx_pcs_clkcmp_pattern_p                                           = 20'd0                                ,//0:1048575
    parameter         hssi_8g_rx_pcs_clock_gate_bds_dec_asn                                     = "dis_bds_dec_asn_clk_gating"         ,//dis_bds_dec_asn_clk_gating en_bds_dec_asn_clk_gating
    parameter         hssi_8g_rx_pcs_clock_gate_cdr_eidle                                       = "dis_cdr_eidle_clk_gating"           ,//dis_cdr_eidle_clk_gating en_cdr_eidle_clk_gating
    parameter         hssi_8g_rx_pcs_clock_gate_dw_pc_wrclk                                     = "dis_dw_pc_wrclk_gating"             ,//dis_dw_pc_wrclk_gating en_dw_pc_wrclk_gating
    parameter         hssi_8g_rx_pcs_clock_gate_dw_rm_rd                                        = "dis_dw_rm_rdclk_gating"             ,//dis_dw_rm_rdclk_gating en_dw_rm_rdclk_gating
    parameter         hssi_8g_rx_pcs_clock_gate_dw_rm_wr                                        = "dis_dw_rm_wrclk_gating"             ,//dis_dw_rm_wrclk_gating en_dw_rm_wrclk_gating
    parameter         hssi_8g_rx_pcs_clock_gate_dw_wa                                           = "dis_dw_wa_clk_gating"               ,//dis_dw_wa_clk_gating en_dw_wa_clk_gating
    parameter         hssi_8g_rx_pcs_clock_gate_pc_rdclk                                        = "dis_pc_rdclk_gating"                ,//dis_pc_rdclk_gating en_pc_rdclk_gating
    parameter         hssi_8g_rx_pcs_clock_gate_sw_pc_wrclk                                     = "dis_sw_pc_wrclk_gating"             ,//dis_sw_pc_wrclk_gating en_sw_pc_wrclk_gating
    parameter         hssi_8g_rx_pcs_clock_gate_sw_rm_rd                                        = "dis_sw_rm_rdclk_gating"             ,//dis_sw_rm_rdclk_gating en_sw_rm_rdclk_gating
    parameter         hssi_8g_rx_pcs_clock_gate_sw_rm_wr                                        = "dis_sw_rm_wrclk_gating"             ,//dis_sw_rm_wrclk_gating en_sw_rm_wrclk_gating
    parameter         hssi_8g_rx_pcs_clock_gate_sw_wa                                           = "dis_sw_wa_clk_gating"               ,//dis_sw_wa_clk_gating en_sw_wa_clk_gating
    parameter         hssi_8g_rx_pcs_clock_observation_in_pld_core                              = "internal_sw_wa_clk"                 ,//internal_cdr_eidle_clk internal_clk_2_b internal_dw_rm_rd_clk internal_dw_rm_wr_clk internal_dw_rx_wr_clk internal_dw_wa_clk internal_rx_pma_clk_gen3 internal_rx_rcvd_clk_gen3 internal_rx_rd_clk internal_sm_rm_wr_clk internal_sw_rm_rd_clk internal_sw_rx_wr_clk internal_sw_wa_clk
    parameter         hssi_8g_rx_pcs_eidle_entry_eios                                           = "dis_eidle_eios"                     ,//dis_eidle_eios en_eidle_eios
    parameter         hssi_8g_rx_pcs_eidle_entry_iei                                            = "dis_eidle_iei"                      ,//dis_eidle_iei en_eidle_iei
    parameter         hssi_8g_rx_pcs_eidle_entry_sd                                             = "dis_eidle_sd"                       ,//dis_eidle_sd en_eidle_sd
    parameter         hssi_8g_rx_pcs_eightb_tenb_decoder                                        = "dis_8b10b"                          ,//dis_8b10b en_8b10b_ibm en_8b10b_sgx
    parameter         hssi_8g_rx_pcs_err_flags_sel                                              = "err_flags_wa"                       ,//err_flags_8b10b err_flags_wa
    parameter         hssi_8g_rx_pcs_fixed_pat_det                                              = "dis_fixed_patdet"                   ,//dis_fixed_patdet en_fixed_patdet
    parameter [3:0]   hssi_8g_rx_pcs_fixed_pat_num                                              = 4'd15                                ,//0:15
    parameter         hssi_8g_rx_pcs_force_signal_detect                                        = "en_force_signal_detect"             ,//dis_force_signal_detect en_force_signal_detect
    parameter         hssi_8g_rx_pcs_gen3_clk_en                                                = "disable_clk"                        ,//disable_clk enable_clk
    parameter         hssi_8g_rx_pcs_gen3_rx_clk_sel                                            = "rcvd_clk"                           ,//en_dig_clk1_8g rcvd_clk
    parameter         hssi_8g_rx_pcs_gen3_tx_clk_sel                                            = "tx_pma_clk"                         ,//en_dig_clk2_8g tx_pma_clk
    parameter         hssi_8g_rx_pcs_hip_mode                                                   = "dis_hip"                            ,//dis_hip en_hip
    parameter         hssi_8g_rx_pcs_ibm_invalid_code                                           = "dis_ibm_invalid_code"               ,//dis_ibm_invalid_code en_ibm_invalid_code
    parameter         hssi_8g_rx_pcs_invalid_code_flag_only                                     = "dis_invalid_code_only"              ,//dis_invalid_code_only en_invalid_code_only
    parameter         hssi_8g_rx_pcs_pad_or_edb_error_replace                                   = "replace_edb"                        ,//replace_edb replace_edb_dynamic replace_pad
    parameter         hssi_8g_rx_pcs_pcs_bypass                                                 = "dis_pcs_bypass"                     ,//dis_pcs_bypass en_pcs_bypass
    parameter         hssi_8g_rx_pcs_phase_comp_rdptr                                           = "enable_rdptr"                       ,//disable_rdptr enable_rdptr
    parameter         hssi_8g_rx_pcs_phase_compensation_fifo                                    = "low_latency"                        ,//low_latency normal_latency pld_ctrl_low_latency pld_ctrl_normal_latency register_fifo
    parameter         hssi_8g_rx_pcs_pipe_if_enable                                             = "dis_pipe_rx"                        ,//dis_pipe_rx en_pipe3_rx en_pipe_rx
    parameter         hssi_8g_rx_pcs_pma_dw                                                     = "eight_bit"                          ,//eight_bit sixteen_bit ten_bit twenty_bit
    parameter         hssi_8g_rx_pcs_polinv_8b10b_dec                                           = "dis_polinv_8b10b_dec"               ,//dis_polinv_8b10b_dec en_polinv_8b10b_dec
    parameter         hssi_8g_rx_pcs_prot_mode                                                  = "gige"                               ,//basic_rm_disable basic_rm_enable cpri cpri_rx_tx disabled_prot_mode gige gige_1588 pipe_g1 pipe_g2 pipe_g3
    parameter         hssi_8g_rx_pcs_rate_match                                                 = "dis_rm"                             ,//dis_rm dw_basic_rm gige_rm pipe_rm pipe_rm_0ppm sw_basic_rm
    parameter         hssi_8g_rx_pcs_rate_match_del_thres                                       = "dis_rm_del_thres"                   ,//dis_rm_del_thres dw_basic_rm_del_thres gige_rm_del_thres pipe_rm_0ppm_del_thres pipe_rm_del_thres sw_basic_rm_del_thres
    parameter         hssi_8g_rx_pcs_rate_match_empty_thres                                     = "dis_rm_empty_thres"                 ,//dis_rm_empty_thres dw_basic_rm_empty_thres gige_rm_empty_thres pipe_rm_0ppm_empty_thres pipe_rm_empty_thres sw_basic_rm_empty_thres
    parameter         hssi_8g_rx_pcs_rate_match_full_thres                                      = "dis_rm_full_thres"                  ,//dis_rm_full_thres dw_basic_rm_full_thres gige_rm_full_thres pipe_rm_0ppm_full_thres pipe_rm_full_thres sw_basic_rm_full_thres
    parameter         hssi_8g_rx_pcs_rate_match_ins_thres                                       = "dis_rm_ins_thres"                   ,//dis_rm_ins_thres dw_basic_rm_ins_thres gige_rm_ins_thres pipe_rm_0ppm_ins_thres pipe_rm_ins_thres sw_basic_rm_ins_thres
    parameter         hssi_8g_rx_pcs_rate_match_start_thres                                     = "dis_rm_start_thres"                 ,//dis_rm_start_thres dw_basic_rm_start_thres gige_rm_start_thres pipe_rm_0ppm_start_thres pipe_rm_start_thres sw_basic_rm_start_thres
    parameter         hssi_8g_rx_pcs_rx_clk_free_running                                        = "en_rx_clk_free_run"                 ,//dis_rx_clk_free_run en_rx_clk_free_run
    parameter         hssi_8g_rx_pcs_rx_clk2                                                    = "rcvd_clk_clk2"                      ,//rcvd_clk_clk2 refclk_dig2_clk2 tx_pma_clock_clk2
    parameter         hssi_8g_rx_pcs_rx_pcs_urst                                                = "en_rx_pcs_urst"                     ,//dis_rx_pcs_urst en_rx_pcs_urst
    parameter         hssi_8g_rx_pcs_rx_rcvd_clk                                                = "rcvd_clk_rcvd_clk"                  ,//rcvd_clk_rcvd_clk tx_pma_clock_rcvd_clk
    parameter         hssi_8g_rx_pcs_rx_rd_clk                                                  = "pld_rx_clk"                         ,//pld_rx_clk rx_clk
    parameter         hssi_8g_rx_pcs_rx_refclk                                                  = "dis_refclk_sel"                     ,//dis_refclk_sel en_refclk_sel
    parameter         hssi_8g_rx_pcs_rx_wr_clk                                                  = "rx_clk2_div_1_2_4"                  ,//rx_clk2_div_1_2_4 txfifo_rd_clk
    parameter         hssi_8g_rx_pcs_sup_mode                                                   = "user_mode"                          ,//engineering_mode user_mode
    parameter         hssi_8g_rx_pcs_symbol_swap                                                = "dis_symbol_swap"                    ,//dis_symbol_swap en_symbol_swap
    parameter         hssi_8g_rx_pcs_sync_sm_idle_eios                                          = "dis_syncsm_idle"                    ,//dis_syncsm_idle en_syncsm_idle
    parameter         hssi_8g_rx_pcs_test_bus_sel                                               = "tx_testbus"                         ,//pcie_ctrl_testbus rm_testbus rx_ctrl_plane_testbus rx_ctrl_testbus tx_ctrl_plane_testbus tx_testbus wa_testbus
    parameter         hssi_8g_rx_pcs_tx_rx_parallel_loopback                                    = "dis_plpbk"                          ,//dis_plpbk en_plpbk
    parameter         hssi_8g_rx_pcs_wa_boundary_lock_ctrl                                      = "bit_slip"                           ,//auto_align_pld_ctrl bit_slip deterministic_latency sync_sm
    parameter [9:0]   hssi_8g_rx_pcs_wa_clk_slip_spacing                                        = 10'd16                               ,//0:1023
    parameter         hssi_8g_rx_pcs_wa_det_latency_sync_status_beh                             = "assert_sync_status_non_imm"         ,//assert_sync_status_imm assert_sync_status_non_imm dont_care_assert_sync
    parameter         hssi_8g_rx_pcs_wa_disp_err_flag                                           = "dis_disp_err_flag"                  ,//dis_disp_err_flag en_disp_err_flag
    parameter         hssi_8g_rx_pcs_wa_kchar                                                   = "dis_kchar"                          ,//dis_kchar en_kchar
    parameter         hssi_8g_rx_pcs_wa_pd                                                      = "wa_pd_10"                           ,//wa_pd_10 wa_pd_16_dw wa_pd_16_sw wa_pd_20 wa_pd_32 wa_pd_40 wa_pd_7 wa_pd_8_dw wa_pd_8_sw
    parameter         hssi_8g_rx_pcs_wa_pd_data                                                 = "0"                                  ,//NOVAL
    parameter         hssi_8g_rx_pcs_wa_pd_polarity                                             = "dis_pd_both_pol"                    ,//dis_pd_both_pol dont_care_both_pol en_pd_both_pol
    parameter         hssi_8g_rx_pcs_wa_pld_controlled                                          = "dis_pld_ctrl"                       ,//dis_pld_ctrl level_sensitive_dw pld_ctrl_sw rising_edge_sensitive_dw
    parameter [5:0]   hssi_8g_rx_pcs_wa_renumber_data                                           = 6'd0                                 ,//0:63
    parameter [7:0]   hssi_8g_rx_pcs_wa_rgnumber_data                                           = 8'd0                                 ,//0:255
    parameter [7:0]   hssi_8g_rx_pcs_wa_rknumber_data                                           = 8'd0                                 ,//0:255
    parameter [1:0]   hssi_8g_rx_pcs_wa_rosnumber_data                                          = 2'd0                                 ,//0:3
    parameter [12:0]  hssi_8g_rx_pcs_wa_rvnumber_data                                           = 13'd0                                ,//0:8191
    parameter         hssi_8g_rx_pcs_wa_sync_sm_ctrl                                            = "gige_sync_sm"                       ,//dw_basic_sync_sm fibre_channel_sync_sm gige_sync_sm pipe_sync_sm sw_basic_sync_sm
    parameter [11:0]  hssi_8g_rx_pcs_wait_cnt                                                   = 12'd0                                ,//0:4095
    parameter         hssi_8g_tx_pcs_bit_reversal                                               = "dis_bit_reversal"                   ,//dis_bit_reversal en_bit_reversal
    parameter         hssi_8g_tx_pcs_bonding_dft_en                                             = "dft_dis"                            ,//dft_dis dft_en
    parameter         hssi_8g_tx_pcs_bonding_dft_val                                            = "dft_0"                              ,//dft_0 dft_1
    parameter         hssi_8g_tx_pcs_bypass_pipeline_reg                                        = "dis_bypass_pipeline"                ,//dis_bypass_pipeline en_bypass_pipeline
    parameter         hssi_8g_tx_pcs_byte_serializer                                            = "dis_bs"                             ,//dis_bs en_bs_by_2 en_bs_by_4
    parameter         hssi_8g_tx_pcs_clock_gate_bs_enc                                          = "dis_bs_enc_clk_gating"              ,//dis_bs_enc_clk_gating en_bs_enc_clk_gating
    parameter         hssi_8g_tx_pcs_clock_gate_dw_fifowr                                       = "dis_dw_fifowr_clk_gating"           ,//dis_dw_fifowr_clk_gating en_dw_fifowr_clk_gating
    parameter         hssi_8g_tx_pcs_clock_gate_fiford                                          = "dis_fiford_clk_gating"              ,//dis_fiford_clk_gating en_fiford_clk_gating
    parameter         hssi_8g_tx_pcs_clock_gate_sw_fifowr                                       = "dis_sw_fifowr_clk_gating"           ,//dis_sw_fifowr_clk_gating en_sw_fifowr_clk_gating
    parameter         hssi_8g_tx_pcs_clock_observation_in_pld_core                              = "internal_refclk_b"                  ,//internal_dw_fifo_wr_clk internal_fifo_rd_clk internal_pipe_tx_clk_out_gen3 internal_refclk_b internal_sw_fifo_wr_clk internal_tx_clk_out_gen3
    parameter         hssi_8g_tx_pcs_data_selection_8b10b_encoder_input                         = "normal_data_path"                   ,//gige_idle_conversion normal_data_path
    parameter         hssi_8g_tx_pcs_dynamic_clk_switch                                         = "dis_dyn_clk_switch"                 ,//dis_dyn_clk_switch en_dyn_clk_switch
    parameter         hssi_8g_tx_pcs_eightb_tenb_disp_ctrl                                      = "dis_disp_ctrl"                      ,//dis_disp_ctrl en_disp_ctrl en_ib_disp_ctrl
    parameter         hssi_8g_tx_pcs_eightb_tenb_encoder                                        = "dis_8b10b"                          ,//dis_8b10b en_8b10b_ibm en_8b10b_sgx
    parameter         hssi_8g_tx_pcs_force_echar                                                = "dis_force_echar"                    ,//dis_force_echar en_force_echar
    parameter         hssi_8g_tx_pcs_force_kchar                                                = "dis_force_kchar"                    ,//dis_force_kchar en_force_kchar
    parameter         hssi_8g_tx_pcs_gen3_tx_clk_sel                                            = "tx_pma_clk"                         ,//dis_tx_clk tx_pma_clk
    parameter         hssi_8g_tx_pcs_gen3_tx_pipe_clk_sel                                       = "func_clk"                           ,//dis_tx_pipe_clk func_clk
    parameter         hssi_8g_tx_pcs_hip_mode                                                   = "dis_hip"                            ,//dis_hip en_hip
    parameter         hssi_8g_tx_pcs_pcs_bypass                                                 = "dis_pcs_bypass"                     ,//dis_pcs_bypass en_pcs_bypass
    parameter         hssi_8g_tx_pcs_phase_comp_rdptr                                           = "enable_rdptr"                       ,//disable_rdptr enable_rdptr
    parameter         hssi_8g_tx_pcs_phase_compensation_fifo                                    = "low_latency"                        ,//low_latency normal_latency pld_ctrl_low_latency pld_ctrl_normal_latency register_fifo
    parameter         hssi_8g_tx_pcs_phfifo_write_clk_sel                                       = "pld_tx_clk"                         ,//pld_tx_clk tx_clk
    parameter         hssi_8g_tx_pcs_pma_dw                                                     = "eight_bit"                          ,//eight_bit sixteen_bit ten_bit twenty_bit
    parameter         hssi_8g_tx_pcs_prot_mode                                                  = "basic"                              ,//basic cpri cpri_rx_tx disabled_prot_mode gige gige_1588 pipe_g1 pipe_g2 pipe_g3
    parameter         hssi_8g_tx_pcs_refclk_b_clk_sel                                           = "tx_pma_clock"                       ,//refclk_dig tx_pma_clock
    parameter         hssi_8g_tx_pcs_revloop_back_rm                                            = "dis_rev_loopback_rx_rm"             ,//dis_rev_loopback_rx_rm en_rev_loopback_rx_rm
    parameter         hssi_8g_tx_pcs_sup_mode                                                   = "user_mode"                          ,//engineering_mode user_mode
    parameter         hssi_8g_tx_pcs_symbol_swap                                                = "dis_symbol_swap"                    ,//dis_symbol_swap en_symbol_swap
    parameter         hssi_8g_tx_pcs_tx_bitslip                                                 = "dis_tx_bitslip"                     ,//dis_tx_bitslip en_tx_bitslip
    parameter         hssi_8g_tx_pcs_tx_compliance_controlled_disparity                         = "dis_txcompliance"                   ,//dis_txcompliance en_txcompliance_pipe2p0 en_txcompliance_pipe3p0
    parameter         hssi_8g_tx_pcs_tx_fast_pld_reg                                            = "dis_tx_fast_pld_reg"                ,//dis_tx_fast_pld_reg en_tx_fast_pld_reg
    parameter         hssi_8g_tx_pcs_txclk_freerun                                              = "dis_freerun_tx"                     ,//dis_freerun_tx en_freerun_tx
    parameter         hssi_8g_tx_pcs_txpcs_urst                                                 = "en_txpcs_urst"                      ,//dis_txpcs_urst en_txpcs_urst
    parameter         cdr_pll_pma_width                                                         = 8                                    ,//8 10 16 20 32 40 64
    parameter         cdr_pll_cgb_div                                                           = 1                                    ,//1:2 4 8
    parameter         cdr_pll_is_cascaded_pll                                                   = "false"                              ,//false true
    parameter         cdr_pll_datarate                                                          = "0 bps"                              ,//NOVAL
    parameter [4:0]   cdr_pll_lpd_counter                                                       = 5'd1                                 ,//0:31
    parameter [4:0]   cdr_pll_lpfd_counter                                                      = 5'd1                                 ,//0:31
    parameter [5:0]   cdr_pll_n_counter_scratch                                                 = 6'd1                                 ,//0:63
    parameter         cdr_pll_output_clock_frequency                                            = "0 hz"                               ,//NOVAL
    parameter         cdr_pll_reference_clock_frequency                                         = "0 hz"                               ,//NOVAL
    parameter [4:0]   cdr_pll_set_cdr_vco_speed                                                 = 5'd1                                 ,//0:31
    parameter [7:0]   cdr_pll_set_cdr_vco_speed_fix                                             = 8'd0                                 ,//0:255
    parameter         cdr_pll_vco_freq                                                          = "0 hz"                               ,//NOVAL
    parameter         cdr_pll_atb_select_control                                                = "atb_off"                            ,//atb_off atb_select_tp_1 atb_select_tp_10 atb_select_tp_11 atb_select_tp_12 atb_select_tp_13 atb_select_tp_14 atb_select_tp_15 atb_select_tp_2 atb_select_tp_3 atb_select_tp_4 atb_select_tp_5 atb_select_tp_6 atb_select_tp_7 atb_select_tp_8 atb_select_tp_9
    parameter         cdr_pll_auto_reset_on                                                     = "auto_reset_on"                      ,//auto_reset_off auto_reset_on
    parameter         cdr_pll_bbpd_data_pattern_filter_select                                   = "bbpd_data_pat_off"                  ,//bbpd_data_pat_1 bbpd_data_pat_2 bbpd_data_pat_3 bbpd_data_pat_off
    parameter         cdr_pll_bw_sel                                                            = "low"                                ,//high low medium
    parameter         cdr_pll_cdr_odi_select                                                    = "sel_cdr"                            ,//sel_cdr sel_odi
    parameter         cdr_pll_cdr_phaselock_mode                                                = "no_ignore_lock"                     ,//ignore_lock no_ignore_lock
    parameter         cdr_pll_cdr_powerdown_mode                                                = "power_down"                         ,//power_down power_up
    parameter         cdr_pll_chgpmp_current_pd                                                 = "cp_current_pd_setting0"             ,//cp_current_pd_setting0 cp_current_pd_setting1 cp_current_pd_setting2 cp_current_pd_setting3 cp_current_pd_setting4
    parameter         cdr_pll_chgpmp_current_pfd                                                = "cp_current_pfd_setting0"            ,//cp_current_pfd_setting0 cp_current_pfd_setting1 cp_current_pfd_setting2 cp_current_pfd_setting3 cp_current_pfd_setting4
    parameter         cdr_pll_chgpmp_replicate                                                  = "true"                               ,//false true
    parameter         cdr_pll_chgpmp_testmode                                                   = "cp_test_disable"                    ,//cp_test_disable cp_test_dn cp_test_up cp_tristate
    parameter         cdr_pll_clklow_mux_select                                                 = "clklow_mux_cdr_fbclk"               ,//clklow_mux_cdr_fbclk clklow_mux_dfe_test clklow_mux_fpll_test1 clklow_mux_reserved_1 clklow_mux_reserved_2 clklow_mux_reserved_3 clklow_mux_reserved_4 clklow_mux_rx_deser_pclk_test
    parameter         cdr_pll_diag_loopback_enable                                              = "false"                              ,//false true
    parameter         cdr_pll_disable_up_dn                                                     = "true"                               ,//false true
    parameter         cdr_pll_fref_clklow_div                                                   = 1                                    ,//1:2 4 8
    parameter         cdr_pll_fref_mux_select                                                   = "fref_mux_cdr_refclk"                ,//fref_mux_cdr_refclk fref_mux_fpll_test0 fref_mux_reserved_1 fref_mux_reserved_2 fref_mux_reserved_3 fref_mux_reserved_4 fref_mux_reserved_5 fref_mux_tx_ser_pclk_test
    parameter         cdr_pll_gpon_lck2ref_control                                              = "gpon_lck2ref_off"                   ,//gpon_lck2ref_off gpon_lck2ref_on
    parameter         cdr_pll_initial_settings                                                  = "false"                              ,//false true
    parameter         cdr_pll_lck2ref_delay_control                                             = "lck2ref_delay_off"                  ,//lck2ref_delay_1 lck2ref_delay_2 lck2ref_delay_3 lck2ref_delay_4 lck2ref_delay_5 lck2ref_delay_6 lck2ref_delay_7 lck2ref_delay_off
    parameter         cdr_pll_lf_resistor_pd                                                    = "lf_pd_setting0"                     ,//lf_pd_setting0 lf_pd_setting1 lf_pd_setting2 lf_pd_setting3
    parameter         cdr_pll_lf_resistor_pfd                                                   = "lf_pfd_setting0"                    ,//lf_pfd_setting0 lf_pfd_setting1 lf_pfd_setting2 lf_pfd_setting3
    parameter         cdr_pll_lf_ripple_cap                                                     = "lf_no_ripple"                       ,//lf_no_ripple lf_ripple_cap1
    parameter         cdr_pll_loop_filter_bias_select                                           = "lpflt_bias_off"                     ,//lpflt_bias_1 lpflt_bias_2 lpflt_bias_3 lpflt_bias_4 lpflt_bias_5 lpflt_bias_6 lpflt_bias_7 lpflt_bias_off
    parameter         cdr_pll_loopback_mode                                                     = "loopback_disabled"                  ,//loopback_disabled loopback_received_data loopback_recovered_data
    parameter         cdr_pll_ltd_ltr_micro_controller_select                                   = "ltd_ltr_pcs"                        ,//ltd_ltr_pcs ltd_ucontroller ltr_ucontroller
    parameter         cdr_pll_m_counter                                                         = 1                                    ,//1:6 8:10 12 15:16 18 20 24:25 30 32:33 36 40 48 50 60 64 80 100
    parameter         cdr_pll_n_counter                                                         = 1                                    ,//1:2 4 8
    parameter         cdr_pll_pd_fastlock_mode                                                  = "false"                              ,//false true
    parameter         cdr_pll_pd_l_counter                                                      = 1                                    ,//0:2 4 8 16
    parameter         cdr_pll_pfd_l_counter                                                     = 1                                    ,//0:2 4 8 16 100
    parameter         cdr_pll_primary_use                                                       = "cmu"                                ,//cdr cmu
    parameter         cdr_pll_prot_mode                                                         = "basic_rx"                           ,//basic_kr_rx basic_rx cpri_rx gpon_rx pcie_gen1_rx pcie_gen2_rx pcie_gen3_rx pcie_gen4_rx qpi_rx sata_rx unused
    parameter         cdr_pll_requires_gt_capable_channel                                       = "false"                              ,//false true
    parameter         cdr_pll_reverse_serial_loopback                                           = "no_loopback"                        ,//loopback_data_0_1 loopback_data_no_posttap loopback_data_with_posttap no_loopback
    parameter         cdr_pll_set_cdr_v2i_enable                                                = "true"                               ,//false true
    parameter         cdr_pll_set_cdr_vco_reset                                                 = "false"                              ,//false true
    parameter         cdr_pll_set_cdr_vco_speed_pciegen3                                        = "cdr_vco_max_speedbin_pciegen3"      ,//cdr_vco_max_speedbin_pciegen3 cdr_vco_min_speedbin_pciegen3
    parameter         cdr_pll_sup_mode                                                          = "user_mode"                          ,//engineering_mode user_mode
    parameter         cdr_pll_tx_pll_prot_mode                                                  = "txpll_unused"                       ,//txpll_enable txpll_enable_pcie txpll_unused
    parameter         cdr_pll_txpll_hclk_driver_enable                                          = "false"                              ,//false true
    parameter         cdr_pll_vco_overrange_voltage                                             = "vco_overrange_off"                  ,// new
    parameter         cdr_pll_vco_underrange_voltage                                            = "vco_underrange_off"                 ,// new
    parameter         cdr_pll_fb_select                                                         = "direct_fb"                          ,//direct_fb iqtxrxclk_fb
    parameter         cdr_pll_uc_ro_cal                                                         = "uc_ro_cal_off"                      ,//uc_ro_cal_off uc_ro_cal_on
    parameter         cdr_pll_iqclk_mux_sel                                                     = "power_down"                         ,//iqtxrxclk0 iqtxrxclk1 iqtxrxclk2 iqtxrxclk3 iqtxrxclk4 iqtxrxclk5 power_down
    parameter         cdr_pll_pcie_gen                                                          = "non_pcie"                           ,//non_pcie pcie_gen1_100mhzref pcie_gen1_125mhzref pcie_gen2_100mhzref pcie_gen2_125mhzref pcie_gen3_100mhzref pcie_gen3_125mhzref
    parameter [7:0]   cdr_pll_set_cdr_input_freq_range                                          = 8'b11111111                          ,
    parameter         cdr_pll_chgpmp_current_dn_trim                                            = "cp_current_trimming_dn_setting0"    ,
    parameter         cdr_pll_chgpmp_up_pd_trim_double                                          = "normal_up_trim_current"             ,
    parameter         cdr_pll_chgpmp_current_up_pd                                              = "cp_current_pd_up_setting0"          ,
    parameter         cdr_pll_chgpmp_current_up_trim                                            = "cp_current_trimming_up_setting0"    ,
    parameter         cdr_pll_chgpmp_dn_pd_trim_double                                          = "normal_dn_trim_current"             ,
    parameter         cdr_pll_cal_vco_count_length                                              = "sel_8b_count"                       ,// new
    parameter         cdr_pll_chgpmp_current_dn_pd                                              = "cp_current_pd_dn_setting0"          ,
    parameter         pma_rx_odi_datarate                                                       = "0 bps"                              ,//NOVAL
    parameter         pma_rx_odi_sup_mode                                                       = "user_mode"                          ,//engineering_mode user_mode
    parameter         pma_rx_odi_prot_mode                                                      = "basic_rx"                           ,//basic_kr_rx basic_rx cpri_rx gpon_rx pcie_gen1_rx pcie_gen2_rx pcie_gen3_rx pcie_gen4_rx qpi_rx sata_rx unused
    parameter         pma_rx_buf_bypass_eqz_stages_234                                          = "bypass_off"                         ,//bypass_off byypass_stages_234
    parameter         pma_rx_buf_datarate                                                       = "0 bps"                              ,//NOVAL
    parameter         pma_rx_buf_diag_lp_en                                                     = "dlp_off"                            ,//dlp_off dlp_on
    parameter         pma_rx_buf_prot_mode                                                      = "basic_rx"                           ,//basic_kr_rx basic_rx cpri_rx gpon_rx pcie_gen1_rx pcie_gen2_rx pcie_gen3_rx pcie_gen4_rx qpi_rx sata_rx unused
    parameter         pma_rx_buf_qpi_enable                                                     = "non_qpi_mode"                       ,//non_qpi_mode qpi_mode
    parameter         pma_rx_buf_rx_refclk_divider                                              = "bypass_divider"                     ,//bypass_divider divide_by_2
    parameter         pma_rx_buf_sup_mode                                                       = "user_mode"                          ,//engineering_mode user_mode
    parameter         pma_rx_buf_loopback_modes                                                 = "lpbk_disable"                       ,//lpbk_disable post_cdr pre_cdr
    parameter         pma_rx_buf_refclk_en                                                      = "disable"                            ,//disable enable
    parameter         pma_rx_buf_pm_tx_rx_pcie_gen                                              = "non_pcie"                           ,//non_pcie pcie_gen1_100mhzref pcie_gen1_125mhzref pcie_gen2_100mhzref pcie_gen2_125mhzref pcie_gen3_100mhzref pcie_gen3_125mhzref
    parameter         pma_rx_buf_pm_tx_rx_pcie_gen_bitwidth                                     = "pcie_gen3_32b"                      ,//pcie_gen3_16b pcie_gen3_32b
    parameter         pma_rx_buf_pm_tx_rx_cvp_mode                                              = "cvp_off"                            ,//cvp_off cvp_on
    parameter         pma_rx_buf_xrx_path_uc_cal_enable                                         = "rx_cal_off"                         ,//rx_cal_off rx_cal_on
    parameter         pma_rx_buf_xrx_path_sup_mode                                              = "user_mode"                          ,//engineering_mode user_mode
    parameter         pma_rx_buf_xrx_path_prot_mode                                             = "unused"                             ,//basic_kr_rx basic_rx cpri_rx gpon_rx pcie_gen1_rx pcie_gen2_rx pcie_gen3_rx pcie_gen4_rx qpi_rx sata_rx unused
    parameter         pma_rx_buf_xrx_path_datarate                                              = "0 bps"                              ,//NOVAL
    parameter [7:0]   pma_rx_buf_xrx_path_datawidth                                             = 8'd0                                 ,//0:255
    parameter         pma_rx_buf_xrx_path_pma_rx_divclk_hz                                      = "0"                                  ,//NOVAL
    parameter         pma_tx_buf_datarate                                                       = "0 bps"                              ,//NOVAL
    parameter         pma_tx_buf_prot_mode                                                      = "basic_tx"                           ,//basic_kr_tx basic_tx cei_tx cpri_tx fc_tx gige_tx gpon_tx higig_tx obsai_tx pcie_gen1_tx pcie_gen2_tx pcie_gen3_tx pcie_gen4_tx qpi_tx sata_tx sdi_tx sfi_tx sfp_tx sonet_tx srio_tx unused xaui_tx xfp_tx
    parameter         pma_tx_buf_rx_det                                                         = "mode_0"                             ,//mode_0 mode_1 mode_10 mode_11 mode_12 mode_13 mode_14 mode_15 mode_2 mode_3 mode_4 mode_5 mode_6 mode_7 mode_8 mode_9
    parameter         pma_tx_buf_rx_det_output_sel                                              = "rx_det_pcie_out"                    ,//rx_det_pcie_out rx_det_qpi_out
    parameter         pma_tx_buf_rx_det_pdb                                                     = "rx_det_off"                         ,//rx_det_off rx_det_on
    parameter         pma_tx_buf_sup_mode                                                       = "user_mode"                          ,//engineering_mode user_mode
    parameter         pma_tx_buf_user_fir_coeff_ctrl_sel                                        = "ram_ctl"                            ,//dynamic_ctl ram_ctl
    parameter         pma_tx_buf_xtx_path_prot_mode                                             = "basic_tx"                           ,//basic_kr_tx basic_tx cei_tx cpri_tx fc_tx gige_tx gpon_tx higig_tx obsai_tx pcie_gen1_tx pcie_gen2_tx pcie_gen3_tx pcie_gen4_tx qpi_tx sata_tx sdi_tx sfi_tx sfp_tx sonet_tx srio_tx unused xaui_tx xfp_tx
    parameter         pma_tx_buf_xtx_path_datarate                                              = "0 bps"                              ,//NOVAL
    parameter [7:0]   pma_tx_buf_xtx_path_datawidth                                             = 8'd0                                 ,//0:255
    parameter [3:0]   pma_tx_buf_xtx_path_clock_divider_ratio                                   = 4'd0                                 ,//0:15
    parameter         pma_tx_buf_xtx_path_pma_tx_divclk_hz                                      = "0"                                  ,//NOVAL
    parameter         pma_tx_buf_xtx_path_tx_pll_clk_hz                                         = "0 hz"                               ,//NOVAL
    parameter         pma_tx_buf_xtx_path_sup_mode                                              = "user_mode"                          ,//engineering_mode user_mode
    parameter         pma_adapt_datarate                                                        = "0 bps"                              ,//NOVAL
    parameter         pma_adapt_prot_mode                                                       = "basic_rx"                           ,//basic_kr_rx basic_rx cpri_rx gpon_rx pcie_gen1_rx pcie_gen2_rx pcie_gen3_rx pcie_gen4_rx qpi_rx sata_rx unused
    parameter         pma_adapt_sup_mode                                                        = "user_mode"                          ,//engineering_mode user_mode
    parameter         pma_adapt_adapt_mode                                                      = "dfe_vga"                            ,//ctle ctle_vga ctle_vga_dfe dfe_vga manual
    parameter         pma_cdr_refclk_powerdown_mode                                             = "powerdown"                          ,//powerdown powerup
    parameter         pma_cdr_refclk_receiver_detect_src                                        = "core_refclk_src"                    ,//core_refclk_src iqclk_src
    parameter         pma_cdr_refclk_refclk_select                                              = "ref_iqclk0"                         ,//adj_pll_clk coreclk fixed_clk iqtxrxclk0 iqtxrxclk1 iqtxrxclk2 iqtxrxclk3 iqtxrxclk4 iqtxrxclk5 lvpecl power_down ref_iqclk0 ref_iqclk1 ref_iqclk10 ref_iqclk11 ref_iqclk2 ref_iqclk3 ref_iqclk4 ref_iqclk5 ref_iqclk6 ref_iqclk7 ref_iqclk8 ref_iqclk9    
    parameter         pma_rx_deser_clkdiv_source                                                = "vco_bypass_normal"                  ,//clklow_to_clkdivrx fref_to_clkdivrx vco_bypass_normal
    parameter         pma_rx_deser_clkdivrx_user_mode                                           = "clkdivrx_user_disabled"             ,//clkdivrx_user_disabled clkdivrx_user_clkdiv clkdivrx_user_clkdiv_div2 clkdivrx_user_div33 clkdivrx_user_div40 clkdivrx_user_div66
    parameter         pma_rx_deser_pcie_gen                                                     = "non_pcie"                           ,// pcie_gen1_100mhzref|pcie_gen2_100mhzref|pcie_gen3_100mhzref|pcie_gen1_125mhzref|pcie_gen2_125mhzref|pcie_gen3_125mhzref|non_pcie
    parameter         pma_rx_deser_pcie_gen_bitwidth                                            = "pcie_gen3_32b"                      ,// pcie_gen3_32b|pcie_gen3_16b

    parameter         pma_rx_deser_datarate                                                     = "0 bps"                              ,//NOVAL
    parameter         pma_rx_deser_deser_factor                                                 = 8                                    ,//8 10 16 20 32 40 64
    parameter         pma_rx_deser_force_clkdiv_for_testing                                     = "normal_clkdiv"                      ,//forced_0 forced_1 normal_clkdiv
    parameter         pma_rx_deser_sdclk_enable                                                 = "false"                              ,//false true
    parameter         pma_rx_deser_sup_mode                                                     = "user_mode"                          ,//engineering_mode user_mode
    parameter         pma_rx_deser_rst_n_adapt_odi                                              = "no_rst_adapt_odi"                   ,//no_rst_adapt_odi yes_rst_adapt_odi
    parameter         pma_rx_deser_bitslip_bypass                                               = "bs_bypass_no"                       ,//bs_bypass_no bs_bypass_yes
    parameter         pma_rx_deser_prot_mode                                                    = "basic_rx"                           ,//basic_kr_rx basic_rx cpri_rx gpon_rx pcie_gen1_rx pcie_gen2_rx pcie_gen3_rx pcie_gen4_rx qpi_rx sata_rx unused
    parameter         pma_cgb_bitslip_enable                                                    = "enable_bitslip"                     ,//disable_bitslip enable_bitslip
    parameter         pma_cgb_bonding_reset_enable                                              = "allow_bonding_reset"                ,//allow_bonding_reset disallow_bonding_reset
    parameter         pma_cgb_datarate                                                          = "0 bps"                              ,//NOVAL
    parameter         pma_cgb_pcie_gen3_bitwidth                                                = "pciegen3_wide"                      ,//pciegen3_narrow pciegen3_wide
    parameter         pma_cgb_prot_mode                                                         = "basic_tx"                           ,//basic_kr_tx basic_tx cei_tx cpri_tx fc_tx gige_tx gpon_tx higig_tx obsai_tx pcie_gen1_tx pcie_gen2_tx pcie_gen3_tx pcie_gen4_tx qpi_tx sata_tx sdi_tx sfi_tx sfp_tx sonet_tx srio_tx unused xaui_tx xfp_tx
    parameter         pma_cgb_ser_mode                                                          = "eight_bit"                          ,//eight_bit forty_bit sixteen_bit sixty_four_bit ten_bit thirty_two_bit twenty_bit
    parameter         pma_cgb_sup_mode                                                          = "user_mode"                          ,//engineering_mode user_mode
    parameter         pma_cgb_x1_div_m_sel                                                      = "divbypass"                          ,//divby2 divby4 divby8 divbypass
    parameter         pma_cgb_input_select_x1                                                   = "unused"                             ,//cdr_txpll_b cdr_txpll_t fpll_bot fpll_top hfclk_x6_dn hfclk_x6_up hfclk_xn_dn hfclk_xn_up lcpll_bot lcpll_hs lcpll_top same_ch_txpll unused
    parameter         pma_cgb_input_select_gen3                                                 = "unused"                             ,//cdr_txpll_b cdr_txpll_t fpll_bot fpll_top hfclk_x6_dn hfclk_x6_up hfclk_xn_dn hfclk_xn_up lcpll_bot lcpll_hs lcpll_top same_ch_txpll unused
    parameter         pma_cgb_input_select_xn                                                   = "unused"                             ,//sel_cgb_loc sel_x6_dn sel_x6_up sel_xn_dn sel_xn_up unused
    parameter         pma_cgb_tx_ucontrol_en                                                    = "disable"                            ,//disable enable
    parameter         pma_rx_dfe_datarate                                                       = "0 bps"                              ,//NOVAL
    parameter         pma_rx_dfe_pdb                                                            = "dfe_enable"                         ,//dfe_enable dfe_powerdown dfe_reset
    parameter         pma_rx_dfe_pdb_fixedtap                                                   = "fixtap_dfe_powerdown"               ,//fixtap_dfe_enable fixtap_dfe_powerdown
    parameter         pma_rx_dfe_pdb_floattap                                                   = "floattap_dfe_powerdown"             ,//floattap_dfe_enable floattap_dfe_powerdown
    parameter         pma_rx_dfe_pdb_fxtap4t7                                                   = "fxtap4t7_powerdown"                 ,//fxtap4t7_enable fxtap4t7_powerdown
    parameter         pma_rx_dfe_sup_mode                                                       = "user_mode"                          ,//engineering_mode user_mode
    parameter         pma_rx_dfe_prot_mode                                                      = "basic_rx"                           ,//basic_kr_rx basic_rx cpri_rx gpon_rx pcie_gen1_rx pcie_gen2_rx pcie_gen3_rx pcie_gen4_rx qpi_rx sata_rx unused
    parameter         pma_rx_sd_prot_mode                                                       = "basic_rx"                           ,//basic_kr_rx basic_rx cpri_rx gpon_rx pcie_gen1_rx pcie_gen2_rx pcie_gen3_rx pcie_gen4_rx qpi_rx sata_rx unused
    parameter         pma_rx_sd_sd_output_off                                                   = 1                                    ,//0:28
    parameter         pma_rx_sd_sd_output_on                                                    = 1                                    ,//0:15
    parameter         pma_rx_sd_sd_pdb                                                          = "sd_off"                             ,//sd_off sd_on
    parameter         pma_rx_sd_sd_threshold                                                    = 3                                    ,//0:15
    parameter         pma_rx_sd_sup_mode                                                        = "user_mode"                          ,//engineering_mode user_mode
    parameter         pma_tx_ser_ser_clk_divtx_user_sel                                         = "divtx_user_33"                      ,//divtx_user_1 divtx_user_2 divtx_user_33 divtx_user_40 divtx_user_66 divtx_user_off
    parameter         pma_tx_ser_sup_mode                                                       = "user_mode"                          ,//engineering_mode user_mode
    parameter         pma_tx_ser_prot_mode                                                      = "basic_tx"                           ,//basic_kr_tx basic_tx cei_tx cpri_tx fc_tx gige_tx gpon_tx higig_tx obsai_tx pcie_gen1_tx pcie_gen2_tx pcie_gen3_tx pcie_gen4_tx qpi_tx sata_tx sdi_tx sfi_tx sfp_tx sonet_tx srio_tx unused xaui_tx xfp_tx
    parameter [2:0]   hssi_pipe_gen1_2_elec_idle_delay_val                                      = 3'd0                                 ,//0:7
    parameter         hssi_pipe_gen1_2_error_replace_pad                                        = "replace_edb"                        ,//replace_edb replace_pad
    parameter         hssi_pipe_gen1_2_hip_mode                                                 = "dis_hip"                            ,//dis_hip en_hip
    parameter         hssi_pipe_gen1_2_ind_error_reporting                                      = "dis_ind_error_reporting"            ,//dis_ind_error_reporting en_ind_error_reporting
    parameter [2:0]   hssi_pipe_gen1_2_phystatus_delay_val                                      = 3'd0                                 ,//0:7
    parameter         hssi_pipe_gen1_2_phystatus_rst_toggle                                     = "dis_phystatus_rst_toggle"           ,//dis_phystatus_rst_toggle en_phystatus_rst_toggle
    parameter         hssi_pipe_gen1_2_pipe_byte_de_serializer_en                               = "dont_care_bds"                      ,//dis_bds dont_care_bds en_bds_by_2
    parameter         hssi_pipe_gen1_2_prot_mode                                                = "pipe_g1"                            ,//basic disabled_prot_mode pipe_g1 pipe_g2 pipe_g3
    parameter         hssi_pipe_gen1_2_rx_pipe_enable                                           = "dis_pipe_rx"                        ,//dis_pipe_rx en_pipe3_rx en_pipe_rx
    parameter         hssi_pipe_gen1_2_rxdetect_bypass                                          = "dis_rxdetect_bypass"                ,//dis_rxdetect_bypass en_rxdetect_bypass
    parameter         hssi_pipe_gen1_2_sup_mode                                                 = "user_mode"                          ,//engineering_mode user_mode
    parameter         hssi_pipe_gen1_2_tx_pipe_enable                                           = "dis_pipe_tx"                        ,//dis_pipe_tx en_pipe3_tx en_pipe_tx
    parameter         hssi_pipe_gen1_2_txswing                                                  = "dis_txswing"                        ,//dis_txswing en_txswing
    parameter         hssi_common_pld_pcs_interface_dft_clk_out_en                              = "dft_clk_out_disable"                ,//dft_clk_out_disable dft_clk_out_enable
    parameter         hssi_common_pld_pcs_interface_dft_clk_out_sel                             = "teng_rx_dft_clk"                    ,//eightg_rx_dft_clk eightg_tx_dft_clk pmaif_dft_clk teng_rx_dft_clk teng_tx_dft_clk
    parameter         hssi_common_pld_pcs_interface_hrdrstctrl_en                               = "hrst_dis"                           ,//hrst_dis hrst_en
    parameter         hssi_common_pld_pcs_interface_pcs_testbus_block_sel                       = "eightg"                             ,//eightg g3pcs krfec pma_if teng
    parameter         hssi_common_pcs_pma_interface_asn_clk_enable                              = "false"                              ,//false true
    parameter         hssi_common_pcs_pma_interface_asn_enable                                  = "dis_asn"                            ,//dis_asn en_asn
    parameter         hssi_common_pcs_pma_interface_block_sel                                   = "eight_g_pcs"                        ,//eight_g_pcs pcie_gen3
    parameter         hssi_common_pcs_pma_interface_bypass_early_eios                           = "false"                              ,//false true
    parameter         hssi_common_pcs_pma_interface_bypass_pcie_switch                          = "false"                              ,//false true
    parameter         hssi_common_pcs_pma_interface_bypass_pma_ltr                              = "false"                              ,//false true
    parameter         hssi_common_pcs_pma_interface_bypass_pma_sw_done                          = "false"                              ,//false true
    parameter         hssi_common_pcs_pma_interface_bypass_ppm_lock                             = "false"                              ,//false true
    parameter         hssi_common_pcs_pma_interface_bypass_send_syncp_fbkp                      = "false"                              ,//false true
    parameter         hssi_common_pcs_pma_interface_bypass_txdetectrx                           = "false"                              ,//false true
    parameter         hssi_common_pcs_pma_interface_cdr_control                                 = "en_cdr_ctrl"                        ,//dis_cdr_ctrl en_cdr_ctrl
    parameter         hssi_common_pcs_pma_interface_cid_enable                                  = "en_cid_mode"                        ,//dis_cid_mode en_cid_mode
    parameter [15:0]  hssi_common_pcs_pma_interface_data_mask_count                             = 16'd2500                             ,//0:65535
    parameter [2:0]   hssi_common_pcs_pma_interface_data_mask_count_multi                       = 3'd1                                 ,//0:7
    parameter         hssi_common_pcs_pma_interface_dft_observation_clock_selection             = "dft_clk_obsrv_tx0"                  ,//dft_clk_obsrv_asn0 dft_clk_obsrv_asn1 dft_clk_obsrv_clklow dft_clk_obsrv_fref dft_clk_obsrv_hclk dft_clk_obsrv_rx dft_clk_obsrv_tx0 dft_clk_obsrv_tx1 dft_clk_obsrv_tx2 dft_clk_obsrv_tx3 dft_clk_obsrv_tx4
    parameter [7:0]   hssi_common_pcs_pma_interface_early_eios_counter                          = 8'd50                                ,//0:255
    parameter         hssi_common_pcs_pma_interface_force_freqdet                               = "force_freqdet_dis"                  ,//force0_freqdet_en force1_freqdet_en force_freqdet_dis
    parameter         hssi_common_pcs_pma_interface_free_run_clk_enable                         = "true"                               ,//false true
    parameter         hssi_common_pcs_pma_interface_ignore_sigdet_g23                           = "false"                              ,//false true
    parameter [6:0]   hssi_common_pcs_pma_interface_pc_en_counter                               = 7'd55                                ,//0:127
    parameter [4:0]   hssi_common_pcs_pma_interface_pc_rst_counter                              = 5'd23                                ,//0:31
    parameter         hssi_common_pcs_pma_interface_pcie_hip_mode                               = "hip_disable"                        ,//hip_disable hip_enable
    parameter         hssi_common_pcs_pma_interface_ph_fifo_reg_mode                            = "phfifo_reg_mode_dis"                ,//phfifo_reg_mode_dis phfifo_reg_mode_en
    parameter [5:0]   hssi_common_pcs_pma_interface_phfifo_flush_wait                           = 6'd36                                ,//0:63
    parameter         hssi_common_pcs_pma_interface_pipe_if_g3pcs                               = "pipe_if_8gpcs"                      ,//pipe_if_8gpcs pipe_if_g3pcs
    parameter [17:0]  hssi_common_pcs_pma_interface_pma_done_counter                            = 18'd175000                           ,//0:262143
    parameter         hssi_common_pcs_pma_interface_pma_if_dft_en                               = "dft_dis"                            ,//dft_dis dft_en
    parameter         hssi_common_pcs_pma_interface_pma_if_dft_val                              = "dft_0"                              ,//dft_0 dft_1
    parameter         hssi_common_pcs_pma_interface_ppm_cnt_rst                                 = "ppm_cnt_rst_dis"                    ,//ppm_cnt_rst_dis ppm_cnt_rst_en
    parameter         hssi_common_pcs_pma_interface_ppm_deassert_early                          = "deassert_early_dis"                 ,//deassert_early_dis deassert_early_en
    parameter         hssi_common_pcs_pma_interface_ppm_gen1_2_cnt                              = "cnt_32k"                            ,//cnt_32k cnt_64k
    parameter         hssi_common_pcs_pma_interface_ppm_post_eidle_delay                        = "cnt_200_cycles"                     ,//cnt_200_cycles cnt_400_cycles
    parameter         hssi_common_pcs_pma_interface_ppmsel                                      = "ppmsel_300"                         ,//ppmsel_100 ppmsel_1000 ppmsel_125 ppmsel_200 ppmsel_250 ppmsel_2500 ppmsel_300 ppmsel_500 ppmsel_5000 ppmsel_62p5 ppmsel_disable ppm_other
    parameter         hssi_common_pcs_pma_interface_prot_mode                                   = "disable_prot_mode"                  ,//disable_prot_mode other_protocols pipe_g12 pipe_g3
    parameter         hssi_common_pcs_pma_interface_rxvalid_mask                                = "rxvalid_mask_en"                    ,//rxvalid_mask_dis rxvalid_mask_en
    parameter [11:0]  hssi_common_pcs_pma_interface_sigdet_wait_counter                         = 12'd2500                             ,//0:4095
    parameter [2:0]   hssi_common_pcs_pma_interface_sigdet_wait_counter_multi                   = 3'd1                                 ,//0:7
    parameter         hssi_common_pcs_pma_interface_sim_mode                                    = "disable"                            ,//disable enable
    parameter         hssi_common_pcs_pma_interface_spd_chg_rst_wait_cnt_en                     = "true"                               ,//false true
    parameter         hssi_common_pcs_pma_interface_sup_mode                                    = "user_mode"                          ,//engineering_mode user_mode
    parameter         hssi_common_pcs_pma_interface_testout_sel                                 = "ppm_det_test"                       ,//asn_test pma_pll_test ppm_det_test prbs_gen_test prbs_ver_test rxpmaif_test uhsif_1_test uhsif_2_test uhsif_3_test
    parameter [3:0]   hssi_common_pcs_pma_interface_wait_clk_on_off_timer                       = 4'd4                                 ,//0:15
    parameter [4:0]   hssi_common_pcs_pma_interface_wait_pipe_synchronizing                     = 5'd23                                ,//0:31
    parameter [10:0]  hssi_common_pcs_pma_interface_wait_send_syncp_fbkp                        = 11'd250                              ,//0:2047
    parameter         hssi_common_pcs_pma_interface_ppm_det_buckets                             = "ppm_100_bucket"                     ,//disable_prot ppm_100_bucket ppm_300_100_bucket ppm_300_bucket
    parameter         hssi_tx_pcs_pma_interface_bypass_pma_txelecidle                           = "false"                              ,//false true
    parameter         hssi_tx_pcs_pma_interface_channel_operation_mode                          = "tx_rx_pair_enabled"                 ,//tx_rx_independent tx_rx_pair_enabled
    parameter         hssi_tx_pcs_pma_interface_lpbk_en                                         = "disable"                            ,//disable enable
    parameter         hssi_tx_pcs_pma_interface_master_clk_sel                                  = "master_tx_pma_clk"                  ,//master_refclk_dig master_tx_pma_clk
    parameter         hssi_tx_pcs_pma_interface_pcie_sub_prot_mode_tx                           = "other_prot_mode"                    ,//other_prot_mode pipe_g12 pipe_g3
    parameter         hssi_tx_pcs_pma_interface_pldif_datawidth_mode                            = "pldif_data_10bit"                   ,//pldif_data_10bit pldif_data_8bit
    parameter         hssi_tx_pcs_pma_interface_pma_dw_tx                                       = "pma_8b_tx"                          ,//pcie_g3_dyn_dw_tx pma_10b_tx pma_16b_tx pma_20b_tx pma_32b_tx pma_40b_tx pma_64b_tx pma_8b_tx
    parameter         hssi_tx_pcs_pma_interface_pma_if_dft_en                                   = "dft_dis"                            ,//dft_dis dft_en
    parameter         hssi_tx_pcs_pma_interface_pmagate_en                                      = "pmagate_dis"                        ,//pmagate_dis pmagate_en
    parameter         hssi_tx_pcs_pma_interface_prbs_clken                                      = "prbs_clk_dis"                       ,//prbs_clk_dis prbs_clk_en
    parameter         hssi_tx_pcs_pma_interface_prbs_gen_pat                                    = "prbs_gen_dis"                       ,//prbs_15 prbs_23 prbs_31 prbs_9 prbs_gen_dis
    parameter         hssi_tx_pcs_pma_interface_prbs9_dwidth                                    = "prbs9_64b"                          ,//prbs9_10b prbs9_64b
    parameter         hssi_tx_pcs_pma_interface_prot_mode_tx                                    = "disabled_prot_mode_tx"              ,//disabled_prot_mode_tx eightg_basic_mode_tx eightg_g3_pcie_g3_hip_mode_tx eightg_g3_pcie_g3_pld_mode_tx eightg_only_pld_mode_tx eightg_pcie_g12_hip_mode_tx eightg_pcie_g12_pld_mode_tx pcs_direct_mode_tx prbs_mode_tx sqwave_mode_tx teng_basic_mode_tx teng_krfec_mode_tx teng_sfis_sdi_mode_tx uhsif_direct_mode_tx uhsif_reg_mode_tx
    parameter         hssi_tx_pcs_pma_interface_sq_wave_num                                     = "sq_wave_4"                          ,//sq_wave_1 sq_wave_4 sq_wave_6 sq_wave_8 sq_wave_default
    parameter         hssi_tx_pcs_pma_interface_sqwgen_clken                                    = "sqwgen_clk_dis"                     ,//sqwgen_clk_dis sqwgen_clk_en
    parameter         hssi_tx_pcs_pma_interface_sup_mode                                        = "user_mode"                          ,//engineering_mode user_mode
    parameter         hssi_tx_pcs_pma_interface_tx_dyn_polarity_inversion                       = "tx_dyn_polinv_dis"                  ,//tx_dyn_polinv_dis tx_dyn_polinv_en
    parameter         hssi_tx_pcs_pma_interface_tx_pma_data_sel                                 = "pld_dir"                            ,//block_sel_default directed_uhsif_dat eight_g_pcs pcie_gen3 pld_dir prbs_pat registered_uhsif_dat sq_wave_pat ten_g_pcs
    parameter         hssi_tx_pcs_pma_interface_tx_static_polarity_inversion                    = "tx_stat_polinv_dis"                 ,//tx_stat_polinv_dis tx_stat_polinv_en
    parameter         hssi_tx_pcs_pma_interface_uhsif_cnt_step_filt_before_lock                 = "uhsif_filt_stepsz_b4lock_4"         ,//uhsif_filt_stepsz_b4lock_2 uhsif_filt_stepsz_b4lock_4 uhsif_filt_stepsz_b4lock_6 uhsif_filt_stepsz_b4lock_8
    parameter [3:0]   hssi_tx_pcs_pma_interface_uhsif_cnt_thresh_filt_after_lock_value          = 4'd11                                ,//0:15
    parameter         hssi_tx_pcs_pma_interface_uhsif_cnt_thresh_filt_before_lock               = "uhsif_filt_cntthr_b4lock_16"        ,//uhsif_filt_cntthr_b4lock_16 uhsif_filt_cntthr_b4lock_24 uhsif_filt_cntthr_b4lock_32 uhsif_filt_cntthr_b4lock_8
    parameter         hssi_tx_pcs_pma_interface_uhsif_dcn_test_update_period                    = "uhsif_dcn_test_period_4"            ,//uhsif_dcn_test_period_12 uhsif_dcn_test_period_16 uhsif_dcn_test_period_4 uhsif_dcn_test_period_8
    parameter         hssi_tx_pcs_pma_interface_uhsif_dcn_testmode_enable                       = "uhsif_dcn_test_mode_disable"        ,//uhsif_dcn_test_mode_disable uhsif_dcn_test_mode_enable
    parameter         hssi_tx_pcs_pma_interface_uhsif_dead_zone_count_thresh                    = "uhsif_dzt_cnt_thr_4"                ,//uhsif_dzt_cnt_thr_2 uhsif_dzt_cnt_thr_4 uhsif_dzt_cnt_thr_6 uhsif_dzt_cnt_thr_8
    parameter         hssi_tx_pcs_pma_interface_uhsif_dead_zone_detection_enable                = "uhsif_dzt_enable"                   ,//uhsif_dzt_disable uhsif_dzt_enable
    parameter         hssi_tx_pcs_pma_interface_uhsif_dead_zone_obser_window                    = "uhsif_dzt_obr_win_32"               ,//uhsif_dzt_obr_win_16 uhsif_dzt_obr_win_32 uhsif_dzt_obr_win_48 uhsif_dzt_obr_win_64
    parameter         hssi_tx_pcs_pma_interface_uhsif_dead_zone_skip_size                       = "uhsif_dzt_skipsz_8"                 ,//uhsif_dzt_skipsz_12 uhsif_dzt_skipsz_16 uhsif_dzt_skipsz_4 uhsif_dzt_skipsz_8
    parameter         hssi_tx_pcs_pma_interface_uhsif_delay_cell_index_sel                      = "uhsif_index_internal"               ,//uhsif_index_cram uhsif_index_internal
    parameter         hssi_tx_pcs_pma_interface_uhsif_delay_cell_margin                         = "uhsif_dcn_margin_4"                 ,//uhsif_dcn_margin_2 uhsif_dcn_margin_3 uhsif_dcn_margin_4 uhsif_dcn_margin_5
    parameter [7:0]   hssi_tx_pcs_pma_interface_uhsif_delay_cell_static_index_value             = 8'd128                               ,//0:255
    parameter         hssi_tx_pcs_pma_interface_uhsif_dft_dead_zone_control                     = "uhsif_dft_dz_det_val_0"             ,//uhsif_dft_dz_det_val_0 uhsif_dft_dz_det_val_1
    parameter         hssi_tx_pcs_pma_interface_uhsif_dft_up_filt_control                       = "uhsif_dft_up_val_0"                 ,//uhsif_dft_up_val_0 uhsif_dft_up_val_1
    parameter         hssi_tx_pcs_pma_interface_uhsif_enable                                    = "uhsif_disable"                      ,//uhsif_disable uhsif_enable
    parameter         hssi_tx_pcs_pma_interface_uhsif_lock_det_segsz_after_lock                 = "uhsif_lkd_segsz_aflock_2048"        ,//uhsif_lkd_segsz_aflock_1024 uhsif_lkd_segsz_aflock_2048 uhsif_lkd_segsz_aflock_4096 uhsif_lkd_segsz_aflock_512
    parameter         hssi_tx_pcs_pma_interface_uhsif_lock_det_segsz_before_lock                = "uhsif_lkd_segsz_b4lock_32"          ,//uhsif_lkd_segsz_b4lock_128 uhsif_lkd_segsz_b4lock_16 uhsif_lkd_segsz_b4lock_32 uhsif_lkd_segsz_b4lock_64
    parameter [3:0]   hssi_tx_pcs_pma_interface_uhsif_lock_det_thresh_cnt_after_lock_value      = 4'd8                                 ,//0:15
    parameter [3:0]   hssi_tx_pcs_pma_interface_uhsif_lock_det_thresh_cnt_before_lock_value     = 4'd8                                 ,//0:15
    parameter [3:0]   hssi_tx_pcs_pma_interface_uhsif_lock_det_thresh_diff_after_lock_value     = 4'd3                                 ,//0:15
    parameter [3:0]   hssi_tx_pcs_pma_interface_uhsif_lock_det_thresh_diff_before_lock_value    = 4'd3                                 ,//0:15
    parameter         hssi_rx_pcs_pma_interface_block_sel                                       = "eight_g_pcs"                        ,//direct_pld eight_g_pcs ten_g_pcs
    parameter         hssi_rx_pcs_pma_interface_channel_operation_mode                          = "tx_rx_pair_enabled"                 ,//tx_rx_independent tx_rx_pair_enabled
    parameter         hssi_rx_pcs_pma_interface_clkslip_sel                                     = "pld"                                ,//pld slip_eight_g_pcs
    parameter         hssi_rx_pcs_pma_interface_lpbk_en                                         = "disable"                            ,//disable enable
    parameter         hssi_rx_pcs_pma_interface_master_clk_sel                                  = "master_rx_pma_clk"                  ,//master_refclk_dig master_rx_pma_clk master_tx_pma_clk
    parameter         hssi_rx_pcs_pma_interface_pldif_datawidth_mode                            = "pldif_data_10bit"                   ,//pldif_data_10bit pldif_data_8bit
    parameter         hssi_rx_pcs_pma_interface_pma_dw_rx                                       = "pma_8b_rx"                          ,//pcie_g3_dyn_dw_rx pma_10b_rx pma_16b_rx pma_20b_rx pma_32b_rx pma_40b_rx pma_64b_rx pma_8b_rx
    parameter         hssi_rx_pcs_pma_interface_pma_if_dft_en                                   = "dft_dis"                            ,//dft_dis dft_en
    parameter         hssi_rx_pcs_pma_interface_pma_if_dft_val                                  = "dft_0"                              ,//dft_0 dft_1
    parameter         hssi_rx_pcs_pma_interface_prbs_clken                                      = "prbs_clk_dis"                       ,//prbs_clk_dis prbs_clk_en
    parameter         hssi_rx_pcs_pma_interface_prbs_ver                                        = "prbs_off"                           ,//prbs_15 prbs_23 prbs_31 prbs_9 prbs_off
    parameter         hssi_rx_pcs_pma_interface_prbs9_dwidth                                    = "prbs9_64b"                          ,//prbs9_10b prbs9_64b
    parameter         hssi_rx_pcs_pma_interface_prot_mode_rx                                    = "disabled_prot_mode_rx"              ,//disabled_prot_mode_rx eightg_basic_mode_rx eightg_g3_pcie_g3_hip_mode_rx eightg_g3_pcie_g3_pld_mode_rx eightg_only_pld_mode_rx eightg_pcie_g12_hip_mode_rx eightg_pcie_g12_pld_mode_rx pcs_direct_mode_rx prbs_mode_rx teng_basic_mode_rx teng_krfec_mode_rx teng_sfis_sdi_mode_rx
    parameter         hssi_rx_pcs_pma_interface_rx_dyn_polarity_inversion                       = "rx_dyn_polinv_dis"                  ,//rx_dyn_polinv_dis rx_dyn_polinv_en
    parameter         hssi_rx_pcs_pma_interface_rx_lpbk_en                                      = "lpbk_dis"                           ,//lpbk_dis lpbk_en
    parameter         hssi_rx_pcs_pma_interface_rx_prbs_force_signal_ok                         = "unforce_sig_ok"                     ,//force_sig_ok unforce_sig_ok
    parameter         hssi_rx_pcs_pma_interface_rx_prbs_mask                                    = "prbsmask128"                        ,//prbsmask1024 prbsmask128 prbsmask256 prbsmask512
    parameter         hssi_rx_pcs_pma_interface_rx_prbs_mode                                    = "teng_mode"                          ,//eightg_mode teng_mode
    parameter         hssi_rx_pcs_pma_interface_rx_signalok_signaldet_sel                       = "sel_sig_det"                        ,//sel_sig_det sel_sig_ok
    parameter         hssi_rx_pcs_pma_interface_rx_static_polarity_inversion                    = "rx_stat_polinv_dis"                 ,//rx_stat_polinv_dis rx_stat_polinv_en
    parameter         hssi_rx_pcs_pma_interface_rx_uhsif_lpbk_en                                = "uhsif_lpbk_dis"                     ,//uhsif_lpbk_dis uhsif_lpbk_en
    parameter         hssi_rx_pcs_pma_interface_sup_mode                                        = "user_mode"                          ,//engineering_mode user_mode
    parameter         hssi_fifo_tx_pcs_double_write_mode                                        = "double_write_dis"                   ,//double_write_dis double_write_en
    parameter         hssi_fifo_tx_pcs_prot_mode                                                = "teng_mode"                          ,//non_teng_mode teng_mode
    parameter         hssi_fifo_rx_pcs_double_read_mode                                         = "double_read_dis"                    ,//double_read_dis double_read_en
    parameter         hssi_fifo_rx_pcs_prot_mode                                                = "teng_mode"                          ,//non_teng_mode teng_mode
    parameter         hssi_krfec_rx_pcs_blksync_cor_en                                          = "detect"                             ,//correct detect
    parameter         hssi_krfec_rx_pcs_bypass_gb                                               = "bypass_dis"                         ,//bypass_dis bypass_en
    parameter         hssi_krfec_rx_pcs_clr_ctrl                                                = "both_enabled"                       ,//both_enabled corr_cnt_only uncorr_cnt_only
    parameter         hssi_krfec_rx_pcs_ctrl_bit_reverse                                        = "ctrl_bit_reverse_dis"               ,//ctrl_bit_reverse_dis ctrl_bit_reverse_en
    parameter         hssi_krfec_rx_pcs_data_bit_reverse                                        = "data_bit_reverse_dis"               ,//data_bit_reverse_dis data_bit_reverse_en
    parameter         hssi_krfec_rx_pcs_dv_start                                                = "with_blklock"                       ,//with_blklock with_blksync
    parameter         hssi_krfec_rx_pcs_err_mark_type                                           = "err_mark_10g"                       ,//err_mark_10g err_mark_40g
    parameter         hssi_krfec_rx_pcs_error_marking_en                                        = "err_mark_dis"                       ,//err_mark_dis err_mark_en
    parameter         hssi_krfec_rx_pcs_low_latency_en                                          = "disable"                            ,//disable enable
    parameter         hssi_krfec_rx_pcs_lpbk_mode                                               = "lpbk_dis"                           ,//lpbk_dis lpbk_en
    parameter [7:0]   hssi_krfec_rx_pcs_parity_invalid_enum                                     = 8'd8                                 ,//0:255
    parameter [3:0]   hssi_krfec_rx_pcs_parity_valid_num                                        = 4'd4                                 ,//0:15
    parameter         hssi_krfec_rx_pcs_pipeln_blksync                                          = "enable"                             ,//disable enable
    parameter         hssi_krfec_rx_pcs_pipeln_descrm                                           = "enable"                             ,//disable enable
    parameter         hssi_krfec_rx_pcs_pipeln_errcorrect                                       = "enable"                             ,//disable enable
    parameter         hssi_krfec_rx_pcs_pipeln_errtrap_ind                                      = "enable"                             ,//disable enable
    parameter         hssi_krfec_rx_pcs_pipeln_errtrap_lfsr                                     = "enable"                             ,//disable enable
    parameter         hssi_krfec_rx_pcs_pipeln_errtrap_loc                                      = "enable"                             ,//disable enable
    parameter         hssi_krfec_rx_pcs_pipeln_errtrap_pat                                      = "enable"                             ,//disable enable
    parameter         hssi_krfec_rx_pcs_pipeln_gearbox                                          = "enable"                             ,//disable enable
    parameter         hssi_krfec_rx_pcs_pipeln_syndrm                                           = "enable"                             ,//disable enable
    parameter         hssi_krfec_rx_pcs_pipeln_trans_dec                                        = "enable"                             ,//disable enable
    parameter         hssi_krfec_rx_pcs_prot_mode                                               = "disable_mode"                       ,//basic_mode disable_mode fortyg_basekr_mode teng_1588_basekr_mode teng_basekr_mode
    parameter         hssi_krfec_rx_pcs_receive_order                                           = "receive_lsb"                        ,//receive_lsb receive_msb
    parameter         hssi_krfec_rx_pcs_rx_testbus_sel                                          = "overall"                            ,//blksync blksync_cntrs decoder_master_sm decoder_master_sm_cntrs decoder_rd_sm errtrap_ind1 errtrap_ind2 errtrap_ind3 errtrap_ind4 errtrap_ind5 errtrap_loc errtrap_pat1 errtrap_pat2 errtrap_pat3 errtrap_pat4 errtrap_sm fast_search fast_search_cntrs gb_and_trans overall syndrm1 syndrm2 syndrm_sm
    parameter         hssi_krfec_rx_pcs_signal_ok_en                                            = "sig_ok_dis"                         ,//sig_ok_dis sig_ok_en
    parameter         hssi_krfec_rx_pcs_sup_mode                                                = "user_mode"                          ,//engineering_mode user_mode
    parameter         hssi_pipe_gen3_bypass_rx_detection_enable                                 = "false"                              ,//false true
    parameter [2:0]   hssi_pipe_gen3_bypass_rx_preset                                           = 3'd0                                 ,//0:7
    parameter         hssi_pipe_gen3_bypass_rx_preset_enable                                    = "false"                              ,//false true
    parameter [17:0]  hssi_pipe_gen3_bypass_tx_coefficent                                       = 18'd0                                ,//0:262143
    parameter         hssi_pipe_gen3_bypass_tx_coefficent_enable                                = "false"                              ,//false true
    parameter [2:0]   hssi_pipe_gen3_elecidle_delay_g3                                          = 3'd6                                 ,//0:7
    parameter         hssi_pipe_gen3_ind_error_reporting                                        = "dis_ind_error_reporting"            ,//dis_ind_error_reporting en_ind_error_reporting
    parameter         hssi_pipe_gen3_mode                                                       = "pipe_g1"                            ,//disable_pcs pipe_g1 pipe_g2 pipe_g3
    parameter [2:0]   hssi_pipe_gen3_phy_status_delay_g12                                       = 3'd5                                 ,//0:7
    parameter [2:0]   hssi_pipe_gen3_phy_status_delay_g3                                        = 3'd5                                 ,//0:7
    parameter         hssi_pipe_gen3_phystatus_rst_toggle_g12                                   = "dis_phystatus_rst_toggle"           ,//dis_phystatus_rst_toggle en_phystatus_rst_toggle
    parameter         hssi_pipe_gen3_phystatus_rst_toggle_g3                                    = "dis_phystatus_rst_toggle_g3"        ,//dis_phystatus_rst_toggle_g3 en_phystatus_rst_toggle_g3
    parameter         hssi_pipe_gen3_rate_match_pad_insertion                                   = "dis_rm_fifo_pad_ins"                ,//dis_rm_fifo_pad_ins en_rm_fifo_pad_ins
    parameter         hssi_pipe_gen3_sup_mode                                                   = "user_mode"                          ,//engineering_mode user_mode
    parameter         hssi_pipe_gen3_test_out_sel                                               = "disable_test_out"                   ,//disable_test_out pipe_ctrl_test_out pipe_test_out1 pipe_test_out2 pipe_test_out3 rx_test_out tx_test_out
    parameter         hssi_gen3_tx_pcs_mode                                                     = "gen3_func"                          ,//disable_pcs gen3_func
    parameter         hssi_gen3_tx_pcs_reverse_lpbk                                             = "rev_lpbk_en"                        ,//rev_lpbk_dis rev_lpbk_en
    parameter         hssi_gen3_tx_pcs_sup_mode                                                 = "user_mode"                          ,//engineering_mode user_mode
    parameter [4:0]   hssi_gen3_tx_pcs_tx_bitslip                                               = 5'd0                                 ,//0:31
    parameter         hssi_gen3_tx_pcs_tx_gbox_byp                                              = "bypass_gbox"                        ,//bypass_gbox enable_gbox
    parameter         hssi_gen3_rx_pcs_block_sync                                               = "enable_block_sync"                  ,//bypass_block_sync enable_block_sync
    parameter         hssi_gen3_rx_pcs_block_sync_sm                                            = "enable_blk_sync_sm"                 ,//disable_blk_sync_sm enable_blk_sync_sm
    parameter         hssi_gen3_rx_pcs_cdr_ctrl_force_unalgn                                    = "enable"                             ,//disable enable
    parameter         hssi_gen3_rx_pcs_lpbk_force                                               = "lpbk_frce_dis"                      ,//lpbk_frce_dis lpbk_frce_en
    parameter         hssi_gen3_rx_pcs_mode                                                     = "gen3_func"                          ,//disable_pcs gen3_func
    parameter         hssi_gen3_rx_pcs_rate_match_fifo                                          = "enable_rm_fifo_600ppm"              ,//bypass_rm_fifo enable_rm_fifo_0ppm enable_rm_fifo_600ppm
    parameter         hssi_gen3_rx_pcs_rate_match_fifo_latency                                  = "regular_latency"                    ,//low_latency regular_latency
    parameter         hssi_gen3_rx_pcs_reverse_lpbk                                             = "rev_lpbk_en"                        ,//rev_lpbk_dis rev_lpbk_en
    parameter         hssi_gen3_rx_pcs_rx_b4gb_par_lpbk                                         = "b4gb_par_lpbk_dis"                  ,//b4gb_par_lpbk_dis b4gb_par_lpbk_en
    parameter         hssi_gen3_rx_pcs_rx_force_balign                                          = "en_force_balign"                    ,//dis_force_balign en_force_balign
    parameter         hssi_gen3_rx_pcs_rx_ins_del_one_skip                                      = "ins_del_one_skip_en"                ,//ins_del_one_skip_dis ins_del_one_skip_en
    parameter [3:0]   hssi_gen3_rx_pcs_rx_num_fixed_pat                                         = 4'd8                                 ,//0:15
    parameter         hssi_gen3_rx_pcs_rx_test_out_sel                                          = "rx_test_out0"                       ,//rx_test_out0 rx_test_out1
    parameter         hssi_gen3_rx_pcs_sup_mode                                                 = "user_mode"                          ,//engineering_mode user_mode
    parameter         hssi_10g_rx_pcs_advanced_user_mode                                        = "disable"                            ,//disable enable
    parameter         hssi_10g_tx_pcs_advanced_user_mode                                        = "disable"                            ,//disable enable
    parameter         hssi_rx_pld_pcs_interface_hd_10g_advanced_user_mode_rx                    = "disable"                            ,//disable enable
    parameter         hssi_rx_pld_pcs_interface_hd_chnl_transparent_pcs_rx                      = "disable"                            ,//disable enable
    parameter         hssi_tx_pld_pcs_interface_hd_10g_advanced_user_mode_tx                    = "disable"                            ,//disable enable
    parameter         pma_adapt_adp_1s_ctle_bypass                                              = "radp_1s_ctle_bypass_0"              ,//radp_1s_ctle_bypass_0|radp_1s_ctle_bypass_1
    parameter         pma_adapt_adp_4s_ctle_bypass                                              = "radp_4s_ctle_bypass_0"              ,//radp_4s_ctle_bypass_0|radp_4s_ctle_bypass_1
    parameter         pma_adapt_adp_ctle_adapt_cycle_window                                     = "radp_ctle_adapt_cycle_window_6"     ,//radp_ctle_adapt_cycle_window_0|radp_ctle_adapt_cycle_window_1|radp_ctle_adapt_cycle_window_2|radp_ctle_adapt_cycle_window_3|radp_ctle_adapt_cycle_window_4|radp_ctle_adapt_cycle_window_5|radp_ctle_adapt_cycle_window_6|radp_ctle_adapt_cycle_window_7
    parameter         pma_adapt_adp_ctle_en                                                     = "radp_ctle_disable"                  ,//radp_ctle_disable|radp_ctle_enable
    parameter         pma_adapt_adp_dfe_fltap_bypass                                            = "radp_dfe_fltap_bypass_0"            ,//radp_dfe_fltap_bypass_0|radp_dfe_fltap_bypass_1
    parameter         pma_adapt_adp_dfe_fltap_en                                                = "radp_dfe_fltap_disable"             ,//radp_dfe_fltap_disable|radp_dfe_fltap_enable
    parameter         pma_adapt_adp_dfe_fxtap_bypass                                            = "radp_dfe_fxtap_bypass_0"            ,//radp_dfe_fxtap_bypass_0|radp_dfe_fxtap_bypass_1
    parameter         pma_adapt_adp_dfe_fxtap_en                                                = "radp_dfe_fxtap_disable"             ,//radp_dfe_fxtap_disable|radp_dfe_fxtap_enable
    parameter         pma_adapt_adp_dfe_fxtap_hold_en                                           = "radp_dfe_fxtap_not_held"            ,//radp_dfe_fxtap_not_held|radp_dfe_fxtap_hold
    parameter         pma_adapt_adp_dfe_mode                                                    = "radp_dfe_mode_0"                    ,//radp_dfe_mode_0|radp_dfe_mode_1|radp_dfe_mode_2|radp_dfe_mode_3|radp_dfe_mode_4|radp_dfe_mode_5|radp_dfe_mode_6|radp_dfe_mode_7
    parameter         pma_adapt_adp_mode                                                        = "radp_mode_0"                        ,//radp_mode_0|radp_mode_1|radp_mode_2|radp_mode_3|radp_mode_4|radp_mode_5|radp_mode_6|radp_mode_7|radp_mode_8|radp_mode_9|radp_mode_10|radp_mode_11|radp_mode_12|radp_mode_13|radp_mode_14|radp_mode_15
    parameter         pma_adapt_adp_onetime_dfe                                                 = "radp_onetime_dfe_0"                 ,//radp_onetime_dfe_0|radp_onetime_dfe_1
    parameter         pma_adapt_adp_vga_bypass                                                  = "radp_vga_bypass_0"                  ,//radp_vga_bypass_0|radp_vga_bypass_1
    parameter         pma_adapt_adp_vga_en                                                      = "radp_vga_disable"                   ,//radp_vga_disable|radp_vga_enable
    parameter         pma_adapt_adp_vref_bypass                                                 = "radp_vref_bypass_0"                 ,//radp_vref_bypass_0|radp_vref_bypass_1
    parameter         pma_adapt_adp_vref_en                                                     = "radp_vref_disable"                  ,//radp_vref_disable|radp_vref_enable
    parameter         pma_adapt_odi_dfe_spec_en                                                 = "rodi_dfe_spec_en_0"                 ,//rodi_dfe_spec_en_0|rodi_dfe_spec_en_1
    parameter         pma_rx_dfe_dft_en                                                         = "dft_disable"                        ,//dft_disable|dft_enalbe
    parameter         pma_rx_odi_step_ctrl_sel                                                  = "feedback_mode"                      ,//dprio_mode|feedback_mode|jm_mode
 
    parameter         hip_cal_en                                                                = "disable"                             //Indicates whether HIP is enabled or not. Valid values: disable, enable
  ) (
  //------------------------
  // Common Ports
  //------------------------
  // Resets
  input   wire  [channels-1:0]    tx_analogreset,   // TX PMA reset
  input   wire  [channels-1:0]    tx_digitalreset,  // TX PCS reset
  input   wire  [channels-1:0]    rx_analogreset,   // RX PMA reset
  input   wire  [channels-1:0]    rx_digitalreset,  // RX PCS reset

  output  wire  [channels-1:0]    tx_cal_busy,      // TX calibration in progress
  output  wire  [channels-1:0]    rx_cal_busy,      // RX calibration in progress
  output  wire  [channels-1:0]    avmm_busy,

  // TX serial clocks
  input   wire  [channels-1:0]    tx_serial_clk0,  // clkout from external PLL
  input   wire  [channels-1:0]    tx_serial_clk1,  // clkout from external PLL
  input   wire  [channels-1:0]    tx_serial_clk2,  // clkout from external PLL
  input   wire  [channels-1:0]    tx_serial_clk3,  // clkout from external PLL
  // Bonding clocks
  input   wire  [channels*6-1:0]  tx_bonding_clocks,  // Bonding clock bundle from Master CGB
  input   wire  [channels*6-1:0]  tx_bonding_clocks1,  // Bonding clock bundle from Master CGB
  input   wire  [channels*6-1:0]  tx_bonding_clocks2,  // Bonding clock bundle from Master CGB
  input   wire  [channels*6-1:0]  tx_bonding_clocks3,  // Bonding clock bundle from Master CGB
  // CDR reference clocks
  input   wire                    rx_cdr_refclk0,   // RX PLL reference clock 0
  input   wire                    rx_cdr_refclk1,   // RX PLL reference clock 1
  input   wire                    rx_cdr_refclk2,   // RX PLL reference clock 2
  input   wire                    rx_cdr_refclk3,   // RX PLL reference clock 3
  input   wire                    rx_cdr_refclk4,   // RX PLL reference clock 4
  // TX and RX serial ports
  output  wire  [channels-1:0]    tx_serial_data,   // TX serial data output to HSSI pin
  input   wire  [channels-1:0]    rx_serial_data,   // RX serial data input from HSSI pin
  // PMA control ports
  input   wire  [channels-1:0]    rx_pma_clkslip,   // Slip RX PMA by one clock cycle
  input   wire  [channels-1:0]    rx_seriallpbken,  // Enable TX-to-RX loopback
  input   wire  [channels-1:0]    rx_set_locktodata,// Set CDR to manual lock to data mode
  input   wire  [channels-1:0]    rx_set_locktoref, // Set CDR to manual lock to reference mode
  // PMA status ports
  output  wire  [channels-1:0]    rx_is_lockedtoref,        // CDR is in lock to reference mode
  output  wire  [channels-1:0]    rx_is_lockedtodata,  // CDR is in lock to data mode

  // QPI specific ports
  input   wire  [channels-1:0]    rx_pma_qpipulldn, 
  input   wire  [channels-1:0]    tx_pma_qpipulldn, 
  input   wire  [channels-1:0]    tx_pma_qpipullup, 
  input   wire  [channels-1:0]    tx_pma_txdetectrx, 
  input   wire  [channels-1:0]    tx_pma_elecidle,    // TX electrical idle
  output  wire  [channels-1:0]    tx_pma_rxfound,

  // Common ports
  //PPM detector clocks
  output  wire  [channels-1:0]    rx_clklow,    // RX Low freq recovered clock, PPM detector specific
  output  wire  [channels-1:0]    rx_fref,      // RX PFD reference clock, PPM detector specific

  //-------------------------
  // Common datapath ports
  //-------------------------
  // Clock ports
  input   wire  [channels-1:0]      tx_coreclkin,       // TX parallel clock input
  input   wire  [channels-1:0]      rx_coreclkin,       // RX parallel clock input
  output  wire  [channels-1:0]      tx_clkout,          // TX Parallel clock output
  output  wire  [channels-1:0]      rx_clkout,          // RX parallel clock output
  output  wire  [channels-1:0]      tx_pma_clkout,      // TX clock output from PMA
  output  wire  [channels-1:0]      rx_pma_clkout,      // RX clock output from PMA
  output  wire  [channels-1:0]      tx_pma_div_clkout,  // TX clock output from PMA (programmable divider)
  output  wire  [channels-1:0]      rx_pma_div_clkout,  // RX clock output from PMA (programmable divider)
  output  wire  [channels-1:0]      tx_pma_iqtxrx_clkout, // TX clock output from PMA to iqtxrx lines (for cascading)
  output  wire  [channels-1:0]      rx_pma_iqtxrx_clkout, // RX clock output from PMA to iqtxrx lines (for cascading)
  // parallel data ports
  input   wire  [channels*128-1:0]  tx_parallel_data,   // PCS TX parallel data interface
  output  wire  [channels*128-1:0]  rx_parallel_data,   // PCS RX parallel data interface
  input   wire  [channels*18-1:0]   tx_control,         // PCS TX control data
  output  wire  [channels*20-1:0]   rx_control,         // PCS RX control data
  // Polarity inversion
  input   wire  [channels-1:0]      tx_polinv,          // TX polarity inversion
  input   wire  [channels-1:0]      rx_polinv,          // RX polarity inversion
  // Bitslip
  input   wire  [channels-1:0]      rx_bitslip,         // RX bitslip (Standard and Enhanced PCS). Asynchronous. Rising edge triggers single bit slip.
  // Adaptation
  input   wire  [channels-1:0]      rx_adapt_reset,     // For adaptation engine control: user needs to apply reset first
  input   wire  [channels-1:0]      rx_adapt_start,     // For adaptation engine control: user, after releasing reset, needs to apply start
  // PRBS
  input   wire  [channels-1:0]      rx_prbs_err_clr,
  output  wire  [channels-1:0]      rx_prbs_done,
  output  wire  [channels-1:0]      rx_prbs_err,
  // Ultra high-speed interface
  input   wire  [channels-1:0]      tx_uhsif_clk,       // Ultra high-speed interface clock input
  output  wire  [channels-1:0]      tx_uhsif_clkout,    // Ultra high-speed interface clock output
  output  wire  [channels-1:0]      tx_uhsif_lock,      // Ultra high-speed interface status

  //-------------------------
  // Standard datapath ports
  //-------------------------
  // Phase compensation FIFOs
  output  wire  [channels-1:0]      tx_std_pcfifo_full,  //Phase comp. FIFO full   
  output  wire  [channels-1:0]      tx_std_pcfifo_empty, //Phase comp. FIFO empty
  output  wire  [channels-1:0]      rx_std_pcfifo_full,  //Phase comp. FIFO full
  output  wire  [channels-1:0]      rx_std_pcfifo_empty, //Phase comp. FIFO empty
  // Bit reversal
  input   wire  [channels-1:0]      rx_std_bitrev_ena,
  // Byte (de)serializer 
  input   wire  [channels-1:0]      rx_std_byterev_ena,
  // Bit slip
  input   wire  [channels*5-1:0]    tx_std_bitslipboundarysel,
  output  wire  [channels*5-1:0]    rx_std_bitslipboundarysel,
  // Word align/Deterministic SM
  input   wire  [channels-1:0]      rx_std_wa_patternalign,
  input   wire  [channels-1:0]      rx_std_wa_a1a2size,
  // Rate Match FIFO
  output  wire  [channels-1:0]      rx_std_rmfifo_full,  //Rate Match FIFO full
  output  wire  [channels-1:0]      rx_std_rmfifo_empty, //Rate Match FIFO empty
  // PCIe
  output  wire  [channels-1:0]      rx_std_signaldetect,    

  //-------------------------
  // Enhanced datapath ports
  //-------------------------
  // TxFIFO/RxFIFO
  input   wire  [channels-1:0]      tx_enh_data_valid,
//input   wire  [channels-1:0]      tx_enh_wordslip, // Engg mode feature so not enabled
  output  wire  [channels-1:0]      tx_enh_fifo_full,
  output  wire  [channels-1:0]      tx_enh_fifo_pfull,
  output  wire  [channels-1:0]      tx_enh_fifo_empty,
  output  wire  [channels-1:0]      tx_enh_fifo_pempty,
  output  wire  [channels*4-1:0]    tx_enh_fifo_cnt,
  
  input   wire  [channels-1:0]      rx_enh_fifo_rd_en, 
  output  wire  [channels-1:0]      rx_enh_data_valid,
  output  wire  [channels-1:0]      rx_enh_fifo_full,
  output  wire  [channels-1:0]      rx_enh_fifo_pfull,
  output  wire  [channels-1:0]      rx_enh_fifo_empty,
  output  wire  [channels-1:0]      rx_enh_fifo_pempty,
  output  wire  [channels-1:0]      rx_enh_fifo_del,
  output  wire  [channels-1:0]      rx_enh_fifo_insert,
  output  wire  [channels*5-1:0]    rx_enh_fifo_cnt,
  output  wire  [channels-1:0]      rx_enh_fifo_align_val,
  input   wire  [channels-1:0]      rx_enh_fifo_align_clr, // Active high. User Align clear signal for RX FIFO when it's used as a deskew FIFO in Interlaken mode. When it asserts, FIFO is reset and it looks for new alignment pattern. It's don't care for non-Interlaken mode

  // Frame generator/sync
  output  wire  [channels-1:0]      tx_enh_frame,
  input   wire  [channels-1:0]      tx_enh_frame_burst_en,
  input   wire  [channels*2-1:0]    tx_enh_frame_diag_status,

  output  wire  [channels-1:0]      rx_enh_frame,
  output  wire  [channels-1:0]      rx_enh_frame_lock,
  output  wire  [channels*2-1:0]    rx_enh_frame_diag_status,

  // CRC chk
  output  wire  [channels-1:0]      rx_enh_crc32_err,

  // BER
  output  wire  [channels-1:0]      rx_enh_highber,
  input   wire  [channels-1:0]      rx_enh_highber_clr_cnt,

  // 64B/66B specific 10GBASER signal
  input   wire  [channels-1:0]      rx_enh_clr_errblk_count,

  // Block sync
  output  wire  [channels-1:0]      rx_enh_blk_lock,

  // Bit slip
  input   wire  [channels*7-1:0]    tx_enh_bitslip,

  //-------------------------
  // HIP ports
  //-------------------------
  input   wire  [channels*64-1:0] tx_hip_data,
  output  wire  [channels*51-1:0] rx_hip_data,
  output  wire                    hip_pipe_pclk,
  output  wire                    hip_fixedclk,
  output  wire  [channels   -1:0] hip_frefclk,
  output  wire  [channels*8 -1:0] hip_ctrl,
  output  wire  [channels   -1:0] hip_cal_done,

  //-----
  // PCIe/PIPE
  //-----
  input   wire                    ltssm_detect_quiet,
  input   wire                    ltssm_detect_active,
  input   wire                    ltssm_rcvr_equalization,
  input   wire                    hip_reduce_counters,
  input   wire  [1:0]             pcie_rate,
  input   wire  [(enable_hip?channels*2:2)-1:0] pipe_rate,
  input   wire  [1:0]             pipe_sw_done,
  output  wire  [1:0]             pipe_sw,
  input   wire                    pipe_hclk_in,
  output  wire                    pipe_hclk_out,
  input   wire  [channels*18-1:0] pipe_g3_txdeemph,
  input   wire  [channels*3 -1:0] pipe_g3_rxpresethint,
  input   wire  [channels*3 -1:0] pipe_rx_eidleinfersel,
  output  wire  [channels   -1:0] pipe_rx_elecidle,
  input   wire  [channels   -1:0] pipe_rx_polarity,
  
  // ----- 
  // optional reset ack 
  // -----
  output  reg [channels - 1:0]   tx_analogreset_ack,  
  output  reg [channels - 1:0]   rx_analogreset_ack,

  //--------------------------
  // Reconfiguration interface
  //--------------------------
  input   wire  [(rcfg_enable&&rcfg_shared ? 1 : channels)-1:0]    reconfig_clk,
  input   wire  [(rcfg_enable&&rcfg_shared ? 1 : channels)-1:0]    reconfig_reset,
  input   wire  [(rcfg_enable&&rcfg_shared ? 1 : channels)-1:0]    reconfig_write,
  input   wire  [(rcfg_enable&&rcfg_shared ? 1 : channels)-1:0]    reconfig_read,
  input   wire  [(rcfg_enable&&rcfg_shared ? (10+altera_xcvr_native_a10_functions_h::clogb2_alt_xcvr_native_a10(channels-1)) : (10*channels))-1:0] reconfig_address,
  input   wire  [(rcfg_enable&&rcfg_shared ? 1 : channels)*32-1:0] reconfig_writedata,
  output  wire  [(rcfg_enable&&rcfg_shared ? 1 : channels)*32-1:0] reconfig_readdata,
  output  wire  [(rcfg_enable&&rcfg_shared ? 1 : channels)-1:0]    reconfig_waitrequest
);

localparam  RCFG_ADDR_BITS  = 10;

localparam  xcvr_native_mode  = (duplex_mode == "duplex") ? "mode_duplex"
                                    : (duplex_mode == "tx") ? "mode_tx_only"
                                      : "mode_rx_only";
localparam  calibration_en    = enable_calibration ? "enable" : "disable";
localparam  arbiter_ctrl      = enable_calibration ? "uc" : "pld";
localparam  cal_done          = enable_calibration ? "cal_done_deassert" : "cal_done_assert";
localparam  avmm_busy_en      = rcfg_separate_avmm_busy ? "enable" : "disable";

localparam  enable_pcs_bonding = (bonded_mode == "pma_pcs") ? 1 : 0;
localparam  lcl_pcs_bonding_master = enable_pcs_bonding ? pcs_bonding_master : channels / 2;
localparam  lcl_adme_assgn_map = {" assignments {dataRate ",adme_data_rate," protMode ",adme_prot_mode," pmaMode ",adme_pma_mode," txPowerMode ",adme_tx_power_mode," device_revision ",device_revision,"}"};


// Use model 
// 1. By default, PHY will connect analog resets and enable sequencing 
//    lcl_enable_analog_resets = 1; lcl_enable_reset_sequence = 1
// 2. Users have to use option in the GUI to disconnect analog resets for a PHY configuration or 
//    Users have to use ALTERA_XCVR_A10_DISCONNECT_ANALOG_RESETS to disconnect resets for the entire design
//    lcl_enable_analog_resets = enable_analog_resets (0); lcl_enable_reset_sequence = enable_reset_sequence (0)
// 3. Users have to use ALTERA_XCVR_A10_ENABLE_ANALOG_RESETS to restore old behavior of resets 
//    lcl_enable_analog_resets = 1; lcl_enable_reset_sequence = 0 

localparam  lcl_enable_analog_resets = 
`ifdef ALTERA_RESERVED_QIS
  `ifdef ALTERA_XCVR_A10_ENABLE_ANALOG_RESETS
    1;  // MACRO override for quartus synthesis. Connect resets
  `else
     `ifdef ALTERA_XCVR_A10_DISCONNECT_ANALOG_RESETS
        0; 
     `else
        enable_analog_resets; 
     `endif
  `endif
`else
  1; // not synthesis. Connect resets
`endif  // (NOT ALTERA_RESERVED_QIS)

localparam lcl_enable_reset_sequence = 
`ifdef ALTERA_RESERVED_QIS
  `ifdef ALTERA_XCVR_A10_ENABLE_ANALOG_RESETS
    0; // MACRO override for quartus synthesis 
  `else
    `ifdef ALTERA_XCVR_A10_DISCONNECT_ANALOG_RESETS
        0;
     `else
        enable_reset_sequence; 
     `endif
  `endif 
`else 
  0; // not synthesis 
`endif // (NOT ALTERA_RESERVED_QIS)

localparam lcl_disable_pipe_rate_retry =
`ifdef ALTERA_XCVR_A10_PIPE_RATE_RETRY_BYPASS
  1 ; //MACRO override to disable the retry circuit
`else
  0 ; //default, enable retry
`endif

// AVMM reconfiguration interface signals
wire  [channels-1:0]    avmm_clk;
wire  [channels-1:0]    avmm_reset;
wire  [channels-1:0]    avmm_write;
wire  [channels-1:0]    avmm_read;
wire  [channels*RCFG_ADDR_BITS-1:0] avmm_address;
wire  [channels*8-1:0]  avmm_writedata;
wire  [channels*8-1:0]  avmm_readdata;
wire  [channels-1:0]    avmm_waitrequest;

// wires for control signals from embedded debug
wire [channels-1:0]     int_rx_prbs_err_clr;
wire [channels-1:0]     int_rx_set_locktoref;
wire [channels-1:0]     int_rx_set_locktodata;
wire [channels-1:0]     int_rx_seriallpbken;
wire [channels-1:0]     int_tx_analogreset;
wire [channels-1:0]     tx_analogreset_to_pma;
wire [channels-1:0]     int_tx_digitalreset;
wire [channels-1:0]     int_rx_analogreset;
wire [channels-1:0]     rx_analogreset_to_pma;
wire [channels-1:0]     int_rx_digitalreset;

// Wires for disconnecting tx_analogreset and rx_analogreset
wire  [channels-1:0]    tx_analogreset_input;
wire  [channels-1:0]    rx_analogreset_input;

wire  [channels-1:0]    int_tx_cal_busy_mask;      // TX calibration in progress
wire  [channels-1:0]    int_rx_cal_busy_mask;      // RX calibration in progress

wire  [channels-1:0]    pld_cal_done;

wire [1:0]              int_pcie_rate_sw;

assign  tx_cal_busy = ~pld_cal_done & int_tx_cal_busy_mask;
assign  rx_cal_busy = ~pld_cal_done & int_rx_cal_busy_mask;
assign  int_pcie_rate_sw = (enable_hip) ? pcie_rate : pipe_rate;

//***************************************************************************
//************* Embedded JTAG, AVMM and Embedded Streamer Expansion *********
alt_xcvr_native_rcfg_opt_logic_o3savxa #(
  .dbg_user_identifier                            ( dbg_user_identifier                 ),
  .duplex_mode                                    ( duplex_mode                         ),
  .dbg_embedded_debug_enable                      ( dbg_embedded_debug_enable           ),
  .dbg_capability_reg_enable                      ( dbg_capability_reg_enable           ),
  .dbg_prbs_soft_logic_enable                     ( dbg_prbs_soft_logic_enable          ),
  .dbg_odi_soft_logic_enable                      ( dbg_odi_soft_logic_enable           ),
  .dbg_stat_soft_logic_enable                     ( dbg_stat_soft_logic_enable          ),
  .dbg_ctrl_soft_logic_enable                     ( dbg_ctrl_soft_logic_enable          ),
  .enable_pcie_dfe_ip                             ( enable_pcie_dfe_ip                  ),
  .disable_continuous_dfe                         ( disable_continuous_dfe              ),
  .sim_reduced_counters                           ( sim_reduced_counters                ),
  .enable_hip                                     ( enable_hip                          ),
  .CHANNELS                                       ( channels                            ),
  .ADDR_BITS                                      ( RCFG_ADDR_BITS                      ),
  .ADME_SLAVE_MAP                                 ( "altera_xcvr_native_a10"            ),
  .ADME_ASSGN_MAP                                 ( lcl_adme_assgn_map                  ),
  .RECONFIG_SHARED                                ( rcfg_enable && rcfg_shared          ),
  .JTAG_ENABLED                                   ( rcfg_enable && rcfg_jtag_enable     ),
  .RCFG_EMB_STRM_ENABLED                          ( rcfg_enable && rcfg_emb_strm_enable ),
  .RCFG_PROFILE_CNT                               ( rcfg_profile_cnt                    )
) alt_xcvr_native_optional_rcfg_logic (
  // User reconfig interface ports
  .reconfig_clk                                   ( reconfig_clk                        ),
  .reconfig_reset                                 ( reconfig_reset                      ),
  .reconfig_write                                 ( reconfig_write                      ),
  .reconfig_read                                  ( reconfig_read                       ),
  .reconfig_address                               ( reconfig_address                    ),
  .reconfig_writedata                             ( reconfig_writedata                  ),
  .reconfig_readdata                              ( reconfig_readdata                   ),
  .reconfig_waitrequest                           ( reconfig_waitrequest                ),
  
  // AVMM ports to transceiver                    
  .avmm_clk                                       ( avmm_clk                            ),
  .avmm_reset                                     ( avmm_reset                          ),
  .avmm_write                                     ( avmm_write                          ),
  .avmm_read                                      ( avmm_read                           ),
  .avmm_address                                   ( avmm_address                        ),
  .avmm_writedata                                 ( avmm_writedata                      ),
  .avmm_readdata                                  ( avmm_readdata                       ),
  .avmm_waitrequest                               ( avmm_waitrequest                    ),
  
  // input signals for PCIe DFE IP
  .ltssm_detect_quiet                             (  ltssm_detect_quiet                 ),
  .ltssm_detect_active                            (  ltssm_detect_active                ),
  .ltssm_rcvr_equalization                        (  ltssm_rcvr_equalization            ),
  .pcie_rate                                      (  int_pcie_rate_sw                   ),
  .hip_reduce_counters                            (  hip_reduce_counters                ),

  // input signals from the PHYfor PRBS error accumulation
  .prbs_err_signal                                ( rx_prbs_err                         ),
  .prbs_done_signal                               ( rx_prbs_done                        ),

  // input rx_clkout for PRBS
  .in_rx_clkout                                   ( rx_clkout                           ),

  // input status signals from the transceiver
  .in_rx_is_lockedtoref                           ( rx_is_lockedtoref                   ),
  .in_rx_is_lockedtodata                          ( rx_is_lockedtodata                  ),
  .in_tx_cal_busy                                 ( tx_cal_busy                         ),
  .in_rx_cal_busy                                 ( rx_cal_busy                         ),
  .in_avmm_busy                                   ( avmm_busy                           ),

  // input control signals from the core
  .in_rx_prbs_err_clr                             ( rx_prbs_err_clr                     ),
  .in_set_rx_locktoref                            ( rx_set_locktoref                    ),
  .in_set_rx_locktodata                           ( rx_set_locktodata                   ),
  .in_en_serial_lpbk                              ( rx_seriallpbken                     ),
  .in_rx_analogreset                              ( rx_analogreset_input                ),
  .in_rx_digitalreset                             ( rx_digitalreset                     ),
  .in_tx_analogreset                              ( tx_analogreset_input                ),
  .in_tx_digitalreset                             ( tx_digitalreset                     ),

  // output control signals to the phy
  .out_prbs_err_clr                               ( int_rx_prbs_err_clr                 ),
  .out_set_rx_locktoref                           ( int_rx_set_locktoref                ),
  .out_set_rx_locktodata                          ( int_rx_set_locktodata               ),
  .out_en_serial_lpbk                             ( int_rx_seriallpbken                 ),
  .out_rx_analogreset                             ( int_rx_analogreset                  ),
  .out_rx_digitalreset                            ( int_rx_digitalreset                 ),
  .out_tx_analogreset                             ( int_tx_analogreset                  ),
  .out_tx_digitalreset                            ( int_tx_digitalreset                 ),
  .out_tx_cal_busy_mask                           ( int_tx_cal_busy_mask                ),
  .out_rx_cal_busy_mask                           ( int_rx_cal_busy_mask                )
);

//***************** End Embedded JTAG and AVMM Expansion ********************
//***************************************************************************


// Bonding wires
wire  [4:0]   bond_pcs10g_in_bot [channels-1:0];
wire  [4:0]   bond_pcs10g_in_top [channels-1:0];
wire  [4:0]   bond_pcs10g_out_bot [channels-1:0];
wire  [4:0]   bond_pcs10g_out_top [channels-1:0];

wire  [12:0]  bond_pcs8g_in_bot [channels-1:0];
wire  [12:0]  bond_pcs8g_in_top [channels-1:0];
wire  [12:0]  bond_pcs8g_out_bot [channels-1:0];
wire  [12:0]  bond_pcs8g_out_top [channels-1:0];

wire  [11:0]  bond_pmaif_in_bot [channels-1:0];
wire  [11:0]  bond_pmaif_in_top [channels-1:0];
wire  [11:0]  bond_pmaif_out_bot [channels-1:0];
wire  [11:0]  bond_pmaif_out_top [channels-1:0];

wire  [channels*20-1:0]  pld_testbus_for_rate;
genvar ig;

generate
  for(ig=0;ig<channels;ig=ig+1) begin : g_xcvr_native_insts
    wire  [1:0] int_pipe_sw_done;
    wire  [1:0] int_pipe_sw;
    wire        int_pipe_hclk_out;
    wire        int_hip_pipe_pclk;
    wire        int_hip_fixedclk;
    wire  [1:0] int_pipe_rate;

    wire        int_in_pld_8g_g3_rx_pld_rst_n;
    wire        int_in_pld_8g_g3_tx_pld_rst_n;
    wire        int_in_pld_10g_krfec_rx_pld_rst_n;
    wire        int_in_pld_10g_krfec_tx_pld_rst_n;
    wire        int_in_pld_pmaif_rx_pld_rst_n;
    wire        int_in_pld_pmaif_tx_pld_rst_n;
    
    assign  int_in_pld_8g_g3_rx_pld_rst_n = ~int_rx_digitalreset[ig];
    assign  int_in_pld_8g_g3_tx_pld_rst_n = ~int_tx_digitalreset[ig];

    // If we are in HIP
    if(enable_hip) begin
      assign  int_pipe_rate                     = pipe_rate[ig*2+:2];
      assign  int_in_pld_10g_krfec_rx_pld_rst_n = 1'b0;
      assign  int_in_pld_10g_krfec_tx_pld_rst_n = 1'b0;
      assign  int_in_pld_pmaif_rx_pld_rst_n     = 1'b0;
      assign  int_in_pld_pmaif_tx_pld_rst_n     = 1'b0;
    end else begin


      // If its the master channel, assign the pld_rate
      if(ig == lcl_pcs_bonding_master) begin: g_pipe_pld_rate_master_channel

        // Use a macro to bypass the retry circuit
        if(hssi_tx_pld_pcs_interface_hd_8g_prot_mode_tx == "pipe_g2_tx" && lcl_disable_pipe_rate_retry == 0) begin: g_alt_xcvr_native_pipe_retry_g2

          alt_xcvr_native_pipe_retry alt_xcvr_native_pipe_retry_inst (
          /*input               */  .pipe_pclk                       (tx_coreclkin[ig]),
          /*input               */  .tx_digitalreset                 (tx_digitalreset[ig]),
          /*input      [1:0]    */  .pld_rate                        (pipe_rate),
          /*input      [19:0]   */  .pld_testbus                     (pld_testbus_for_rate[20*ig+:20]),
          /*output reg [1:0]    */  .rate_retry                      (int_pipe_rate)
          );

        end else if (hssi_tx_pld_pcs_interface_hd_8g_prot_mode_tx == "pipe_g3_tx") begin: g_pipe_rate_g3

          (* altera_attribute = " -name MAX_WIRES_FOR_CORE_PERIPHERY_TRANSFER 2; -name GLOBAL_SIGNAL OFF -from \"twentynm_xcvr_native:g_xcvr_native_insts[3].twentynm_xcvr_native_inst|twentynm_xcvr_native_rev_20nm5:twentynm_xcvr_native_inst|twentynm_pcs_rev_20nm5:inst_twentynm_pcs|w_hssi_tx_pld_pcs_interface_pld_pcs_tx_clk_out\" " *)
          reg [1:0]   int_pipe_rate_reg = 2'b0;

          (* altera_attribute = " -name GLOBAL_SIGNAL OFF -from \"twentynm_xcvr_native:g_xcvr_native_insts[3].twentynm_xcvr_native_inst|twentynm_xcvr_native_rev_20nm5:twentynm_xcvr_native_inst|twentynm_pcs_rev_20nm5:inst_twentynm_pcs|w_hssi_tx_pld_pcs_interface_pld_pcs_tx_clk_out\" " *)
          reg [7:0]   int_pipe_rate_sync = 8'b0;

          (* altera_attribute = " -name GLOBAL_SIGNAL OFF -from \"twentynm_xcvr_native:g_xcvr_native_insts[3].twentynm_xcvr_native_inst|twentynm_xcvr_native_rev_20nm5:twentynm_xcvr_native_inst|twentynm_pcs_rev_20nm5:inst_twentynm_pcs|w_hssi_tx_pld_pcs_interface_pld_pcs_tx_clk_out\" " *)
          reg [2:0]   int_pipe_rate_delay = 3'b0;

          assign  int_pipe_rate = int_pipe_rate_reg;
          always@(posedge tx_clkout[ig]) begin
            // shift register to set a synchronizer
            int_pipe_rate_sync[5:0] <=  {int_pipe_rate_sync[3:0], pipe_rate};

            // if the last stage of the synchronizer is not the same as the
            // one before it, run a counter then udpate the final register stage
            if(int_pipe_rate_sync[7:6] == int_pipe_rate_sync[5:4]) begin
              int_pipe_rate_delay   <=  3'b0;
            end else begin

              // if the counter is full (7-bit count) update the final stage
              if(&int_pipe_rate_delay) begin
                int_pipe_rate_sync[7:6] <=  int_pipe_rate_sync[5:4];
              end else begin
                int_pipe_rate_delay   <=  int_pipe_rate_delay + 3'b1;
              end
            end  

            int_pipe_rate_reg  <=  int_pipe_rate_sync[7:6];
          end
        end else begin: g_no_pipe_rate
          assign int_pipe_rate  = pipe_rate;
        end

      end else begin: g_pipe_pld_rate_non_master
        assign int_pipe_rate = 2'b0;
      end

      assign  int_in_pld_10g_krfec_rx_pld_rst_n = ~int_rx_digitalreset[ig];
      assign  int_in_pld_10g_krfec_tx_pld_rst_n = ~int_tx_digitalreset[ig];
      assign  int_in_pld_pmaif_rx_pld_rst_n     = ~int_rx_digitalreset[ig];
      assign  int_in_pld_pmaif_tx_pld_rst_n     = ~int_tx_digitalreset[ig];
    end
    
    // Option 1: enable reset sequencing and analog resets, insert reset endpoint for TX and RX 
    if(lcl_enable_analog_resets == 1 && lcl_enable_reset_sequence == 1 && !enable_hip) begin: g_analog_resets_default
      // connect resets 
      assign tx_analogreset_input[ig] = tx_analogreset[ig];
      assign rx_analogreset_input[ig] = rx_analogreset[ig];

      if(duplex_mode == "duplex" || duplex_mode == "tx") begin: g_tre_tx_endpoint
        altera_transceiver_reset_endpoint reset_endpoint_tx (
          .tre_reset_req(int_tx_analogreset[ig]),
          .tre_reset_in(tx_analogreset_to_pma[ig])
        );
        
        always @(*) begin 
          tx_analogreset_ack[ig] = tx_analogreset_to_pma[ig]; 
        end

      end else begin: g_tre_tx_no_endpoint
        assign tx_analogreset_to_pma[ig] = 1'b0; 
        
        always @(*) begin 
          tx_analogreset_ack[ig] = 1'b0; 
        end

      end 
      
      if(duplex_mode == "duplex" || duplex_mode == "rx") begin: g_tre_rx_endpoint
        altera_transceiver_reset_endpoint reset_endpoint_rx (
          .tre_reset_req(int_rx_analogreset[ig]),
          .tre_reset_in(rx_analogreset_to_pma[ig])
        );
        
        always @(*) begin
          rx_analogreset_ack[ig] = rx_analogreset_to_pma[ig];
        end

      end else begin: g_tre_rx_no_end_point
        assign rx_analogreset_to_pma[ig] = 1'b0;
        
        always @(*) begin 
          rx_analogreset_ack[ig] = 1'b0; 
        end
        
      end 

    end else if(lcl_enable_analog_resets == 0 && lcl_enable_reset_sequence == 0 && !enable_hip) begin: g_analog_resets_disconnect // Option 2: disconnect analog resets 
      assign tx_analogreset_input[ig]   = 1'b0;
      assign rx_analogreset_input[ig]   = 1'b0;
      assign tx_analogreset_to_pma[ig]  = int_tx_analogreset[ig]; 
      assign rx_analogreset_to_pma[ig]  = int_rx_analogreset[ig];  
      
      always @(*) begin 
        tx_analogreset_ack[ig]    = 1'b0;         
        rx_analogreset_ack[ig]    = 1'b0;         
      end 

    end else begin: g_analog_resets_connect // Option 3: restore old style reset connection
      assign tx_analogreset_input[ig]   = tx_analogreset[ig];
      assign rx_analogreset_input[ig]   = rx_analogreset[ig];
      assign tx_analogreset_to_pma[ig]  = int_tx_analogreset[ig]; 
      assign rx_analogreset_to_pma[ig]  = int_rx_analogreset[ig]; 

      `ifdef ALTERA_RESERVED_QIS
        always @(*) begin 
          tx_analogreset_ack[ig]  = tx_analogreset_to_pma[ig];         
          rx_analogreset_ack[ig]  = rx_analogreset_to_pma[ig];         
        end
      `else 
        initial begin 
          tx_analogreset_ack[ig] = 1'b0; 
          rx_analogreset_ack[ig] = 1'b0; 
        end
        
        always @(*) begin 
        #70000; 
          tx_analogreset_ack[ig]  = tx_analogreset_to_pma[ig];         
          rx_analogreset_ack[ig]  = rx_analogreset_to_pma[ig];         
        end
      `endif
    end

    // PCIe HIP clock selections
    if((ig == 0 && enable_hip && channels == 2) ||
       (ig == 3 && enable_hip && (channels == 4 || channels == 8)) ||
       (ig == 0 && (!enable_hip || channels == 1))) begin
                              assign  hip_pipe_pclk     = int_hip_pipe_pclk;
                              assign  hip_fixedclk      = int_hip_fixedclk;
    end
                            
    // PCIe rate switch signals
    if(ig == lcl_pcs_bonding_master) begin
                              assign  int_pipe_sw_done  = pipe_sw_done;
                              assign  pipe_sw           = int_pipe_sw;
                              assign  pipe_hclk_out     = int_pipe_hclk_out;
    end else begin
                              assign  int_pipe_sw_done  = 2'b00;
    end
    // Bonding connections
    if(enable_pcs_bonding) begin : g_bonding_connections
      if(ig == (channels-1)) begin
                              assign  bond_pcs10g_in_top[ig]  = 5'd0;
                              assign  bond_pcs8g_in_top[ig]   = 13'd0;
                              assign  bond_pmaif_in_top[ig]   = 12'd0;
      end else begin          
                              assign  bond_pcs10g_in_top[ig]  = bond_pcs10g_out_bot[ig+1];
                              assign  bond_pcs8g_in_top[ig]   = bond_pcs8g_out_bot[ig+1];
                              assign  bond_pmaif_in_top[ig]   = bond_pmaif_out_bot[ig+1];
      end

      if(ig == 0) begin
                              assign  bond_pcs10g_in_bot[ig]  = 5'd0;
                              assign  bond_pcs8g_in_bot[ig]   = 13'd0;
                              assign  bond_pmaif_in_bot[ig]   = 12'd0;
      end else begin
                              assign  bond_pcs10g_in_bot[ig]  = bond_pcs10g_out_top[ig-1];
                              assign  bond_pcs8g_in_bot[ig]   = bond_pcs8g_out_top[ig-1];
                              assign  bond_pmaif_in_bot[ig]   = bond_pmaif_out_top[ig-1];
      end
    end else begin : g_no_bonding_connections
                              assign  bond_pcs10g_in_top[ig]  = 5'd0;
                              assign  bond_pcs10g_in_bot[ig]  = 5'd0;
                              assign  bond_pcs8g_in_top[ig]   = 13'd0;
                              assign  bond_pcs8g_in_bot[ig]   = 13'd0;
                              assign  bond_pmaif_in_top[ig]   = 12'd0;
                              assign  bond_pmaif_in_bot[ig]   = 12'd0;
    end
    // End bonding connections

    localparam  [3:0] lcl_pma_tx_buf_mcgb_location_for_pcie = altera_xcvr_native_a10_functions_h::get_mcgb_location_alt_xcvr_native_a10(lcl_pcs_bonding_master, ig);

    // Channel level bonding parameters
    localparam  lcl_hssi_tx_pld_pcs_interface_hd_chnl_ctrl_plane_bonding_tx = 
                  (hssi_tx_pld_pcs_interface_hd_chnl_ctrl_plane_bonding_tx == "individual_tx") ? "individual_tx"
                    : (ig < lcl_pcs_bonding_master) ? "ctrl_slave_blw_tx"
                    : (ig > lcl_pcs_bonding_master) ? "ctrl_slave_abv_tx"
                    : "ctrl_master_tx";

    localparam  lcl_hssi_rx_pld_pcs_interface_hd_chnl_ctrl_plane_bonding_rx = 
                  (hssi_rx_pld_pcs_interface_hd_chnl_ctrl_plane_bonding_rx == "individual_rx") ? "individual_rx"
                    : (ig < lcl_pcs_bonding_master) ? "ctrl_slave_blw_rx"
                    : (ig > lcl_pcs_bonding_master) ? "ctrl_slave_abv_rx"
                    : "ctrl_master_rx";

    localparam  lcl_hssi_tx_pld_pcs_interface_hd_pmaif_ctrl_plane_bonding =
                  (hssi_tx_pld_pcs_interface_hd_chnl_prot_mode_tx != "pcie_g1_capable_tx" && hssi_tx_pld_pcs_interface_hd_chnl_prot_mode_tx != "pcie_g2_capable_tx" && hssi_tx_pld_pcs_interface_hd_chnl_prot_mode_tx != "pcie_g3_capable_tx") ? "individual"
                    : (hssi_tx_pld_pcs_interface_hd_chnl_ctrl_plane_bonding_tx == "individual_tx") ? "individual"
                    : (ig < lcl_pcs_bonding_master) ? "ctrl_slave_blw"
                    : (ig > lcl_pcs_bonding_master) ? "ctrl_slave_abv"
                    : "ctrl_master";
    localparam  lcl_hssi_common_pcs_pma_interface_bypass_pma_sw_done = 
                    (hssi_tx_pld_pcs_interface_hd_chnl_prot_mode_tx == "pcie_g1_capable_tx" || hssi_tx_pld_pcs_interface_hd_chnl_prot_mode_tx == "pcie_g2_capable_tx" || hssi_tx_pld_pcs_interface_hd_chnl_prot_mode_tx == "pcie_g3_capable_tx") ?
                    ((lcl_hssi_tx_pld_pcs_interface_hd_pmaif_ctrl_plane_bonding == "ctrl_slave_blw" || lcl_hssi_tx_pld_pcs_interface_hd_pmaif_ctrl_plane_bonding == "ctrl_slave_abv") ? "true" 
                    : "false") : "false"; 
 
    // PCS level bonding parameters
    localparam  lcl_hssi_tx_pld_pcs_interface_hd_10g_ctrl_plane_bonding_tx  = lcl_hssi_tx_pld_pcs_interface_hd_chnl_ctrl_plane_bonding_tx;
    localparam  lcl_hssi_rx_pld_pcs_interface_hd_10g_ctrl_plane_bonding_rx  = lcl_hssi_rx_pld_pcs_interface_hd_chnl_ctrl_plane_bonding_rx;
    localparam  lcl_hssi_tx_pld_pcs_interface_hd_8g_ctrl_plane_bonding_tx   = lcl_hssi_tx_pld_pcs_interface_hd_chnl_ctrl_plane_bonding_tx;
    localparam  lcl_hssi_rx_pld_pcs_interface_hd_8g_ctrl_plane_bonding_rx   = lcl_hssi_rx_pld_pcs_interface_hd_chnl_ctrl_plane_bonding_rx;
    localparam  lcl_hssi_common_pcs_pma_interface_ctrl_plane_bonding = lcl_hssi_tx_pld_pcs_interface_hd_pmaif_ctrl_plane_bonding;


    localparam  lcl_hssi_8g_tx_pcs_ctrl_plane_bonding_consumption = enable_pcs_bonding ?
                                                        (ig < lcl_pcs_bonding_master) ? "bundled_slave_below"
                                                          : (ig > lcl_pcs_bonding_master) ? "bundled_slave_above"
                                                            : "bundled_master"
                                                        : "individual";
    localparam  lcl_hssi_8g_rx_pcs_ctrl_plane_bonding_consumption = (lcl_hssi_rx_pld_pcs_interface_hd_chnl_ctrl_plane_bonding_rx == "individual_rx")? "individual" 
                                                        : (ig < lcl_pcs_bonding_master) ? "bundled_slave_below"
                                                          : (ig > lcl_pcs_bonding_master) ? "bundled_slave_above"
                                                            : "bundled_master";

    localparam  lcl_hssi_10g_tx_pcs_ctrl_plane_bonding = enable_pcs_bonding ? 
                                                      (ig < lcl_pcs_bonding_master) ? "ctrl_slave_blw"
                                                        : (ig > lcl_pcs_bonding_master) ? "ctrl_slave_abv"
                                                          : "ctrl_master"
                                                      : "individual";
    localparam  [7:0] lcl_hssi_10g_tx_pcs_comp_cnt = enable_pcs_bonding ? altera_xcvr_native_a10_functions_h::get_comp_cnt_alt_xcvr_native_a10(channels, lcl_pcs_bonding_master, ig)
                                            : 8'd0;

    localparam  lcl_pma_cgb_select_done_master_or_slave = enable_pcs_bonding ? "choose_master_pcie_sw_done" : "choose_slave_pcie_sw_done";

    // following parameters were assigned auto_single before wrapper files were removed
    localparam lcl_hssi_8g_rx_pcs_ctrl_plane_bonding_compensation = (hssi_8g_rx_pcs_byte_deserializer=="en_bds_by_4") ? "en_compensation" : "dis_compensation";
    localparam lcl_hssi_8g_tx_pcs_ctrl_plane_bonding_distribution = (lcl_hssi_8g_tx_pcs_ctrl_plane_bonding_consumption=="bundled_master") ? "master_chnl_distr" : "not_master_chnl_distr";
    localparam lcl_hssi_8g_rx_pcs_ctrl_plane_bonding_distribution = (lcl_hssi_8g_rx_pcs_ctrl_plane_bonding_consumption=="bundled_master") ? "master_chnl_distr" : "not_master_chnl_distr";
    localparam lcl_hssi_8g_rx_pcs_auto_speed_nego                 = (((hssi_8g_rx_pcs_prot_mode=="pipe_g3")&&((lcl_hssi_8g_rx_pcs_ctrl_plane_bonding_consumption=="individual")||(lcl_hssi_8g_rx_pcs_ctrl_plane_bonding_consumption=="bundled_master")))) ?
                                                                       "en_asn_g2_freq_scal" :
                                                                    (((hssi_8g_rx_pcs_prot_mode=="pipe_g2")&&((lcl_hssi_8g_rx_pcs_ctrl_plane_bonding_consumption=="individual")||(lcl_hssi_8g_rx_pcs_ctrl_plane_bonding_consumption=="bundled_master")))) ?
                                                                       "en_asn_g2_freq_scal" :
                                                                       "dis_asn";

    localparam lcl_hssi_8g_tx_pcs_ctrl_plane_bonding_compensation = ((hssi_8g_tx_pcs_byte_serializer=="en_bs_by_4")) ? "en_compensation" : "dis_compensation";
    localparam lcl_hssi_8g_tx_pcs_auto_speed_nego_gen2            = (((hssi_8g_tx_pcs_prot_mode=="pipe_g2")&&((lcl_hssi_8g_tx_pcs_ctrl_plane_bonding_consumption=="individual")||(lcl_hssi_8g_tx_pcs_ctrl_plane_bonding_consumption=="bundled_master")))) ?
                                                                       "en_asn_g2_freq_scal" :
                                                                       "dis_asn_g2";

    localparam lcl_hssi_10g_tx_pcs_compin_sel     = ((lcl_hssi_10g_tx_pcs_ctrl_plane_bonding=="individual")||(lcl_hssi_10g_tx_pcs_ctrl_plane_bonding=="ctrl_master")) ?
                                                       "compin_master" :
                                                    ((lcl_hssi_10g_tx_pcs_ctrl_plane_bonding=="ctrl_slave_blw")) ?
                                                       "compin_slave_bot" :
                                                    ((lcl_hssi_10g_tx_pcs_ctrl_plane_bonding=="ctrl_slave_abv")) ?
                                                       "compin_slave_top" :
                                                       "compin_default";
    localparam lcl_hssi_10g_tx_pcs_distdwn_master = ((lcl_hssi_10g_tx_pcs_ctrl_plane_bonding=="individual")||(lcl_hssi_10g_tx_pcs_ctrl_plane_bonding=="ctrl_master")) ?
                                                       "distdwn_master_en" :
                                                    ((lcl_hssi_10g_tx_pcs_ctrl_plane_bonding=="ctrl_slave_blw")||(lcl_hssi_10g_tx_pcs_ctrl_plane_bonding=="ctrl_slave_abv")) ?
                                                       "distdwn_master_dis" :
                                                       "distdwn_master_dis";
    localparam lcl_hssi_10g_tx_pcs_distup_master  = ((lcl_hssi_10g_tx_pcs_ctrl_plane_bonding=="individual")||(lcl_hssi_10g_tx_pcs_ctrl_plane_bonding=="ctrl_master")) ?
                                                       "distup_master_en" :
                                                    ((lcl_hssi_10g_tx_pcs_ctrl_plane_bonding=="ctrl_slave_blw")||(lcl_hssi_10g_tx_pcs_ctrl_plane_bonding=="ctrl_slave_abv")) ?
                                                       "distup_master_dis" :
                                                       "distup_master_dis";
    localparam lcl_hssi_10g_tx_pcs_indv           = ((lcl_hssi_10g_tx_pcs_ctrl_plane_bonding=="individual")) ?
                                                       "indv_en" :
                                                    ((lcl_hssi_10g_tx_pcs_ctrl_plane_bonding=="ctrl_slave_blw")||(lcl_hssi_10g_tx_pcs_ctrl_plane_bonding=="ctrl_master")||(lcl_hssi_10g_tx_pcs_ctrl_plane_bonding=="ctrl_slave_abv")) ?
                                                       "indv_dis" :
                                                       "indv_dis";
    localparam lcl_hssi_10g_tx_pcs_dv_bond        = ((lcl_hssi_10g_tx_pcs_indv=="indv_dis")) ? "dv_bond_en" : "dv_bond_dis";

    localparam lcl_hssi_common_pcs_pma_interface_cp_cons_sel = ((lcl_hssi_common_pcs_pma_interface_ctrl_plane_bonding=="individual")||(lcl_hssi_common_pcs_pma_interface_ctrl_plane_bonding=="ctrl_master")) ?
                                                                  "cp_cons_master" :
                                                               ((lcl_hssi_common_pcs_pma_interface_ctrl_plane_bonding=="ctrl_slave_blw")) ?
                                                                  "cp_cons_slave_blw" :
                                                               ((lcl_hssi_common_pcs_pma_interface_ctrl_plane_bonding=="ctrl_slave_abv")) ?
                                                                  "cp_cons_slave_abv" :
                                                                  "cp_cons_default";
    localparam lcl_hssi_common_pcs_pma_interface_cp_dwn_mstr = ((lcl_hssi_common_pcs_pma_interface_ctrl_plane_bonding=="individual")||(lcl_hssi_common_pcs_pma_interface_ctrl_plane_bonding=="ctrl_master")) ?
                                                                  "true" :
                                                               ((lcl_hssi_common_pcs_pma_interface_ctrl_plane_bonding=="ctrl_slave_blw")||(lcl_hssi_common_pcs_pma_interface_ctrl_plane_bonding=="ctrl_slave_abv")) ?
                                                                  "false" :
                                                                  "true";
    localparam lcl_hssi_common_pcs_pma_interface_cp_up_mstr  = ((lcl_hssi_common_pcs_pma_interface_ctrl_plane_bonding=="individual")||(lcl_hssi_common_pcs_pma_interface_ctrl_plane_bonding=="ctrl_master")) ?
                                                                  "true" :
                                                               ((lcl_hssi_common_pcs_pma_interface_ctrl_plane_bonding=="ctrl_slave_blw")||(lcl_hssi_common_pcs_pma_interface_ctrl_plane_bonding=="ctrl_slave_abv")) ?
                                                                  "false" :
                                                                  "true";

    // String to binary conversions
    localparam  [127:0] temp_lcl_hssi_10g_tx_pcs_pseudo_seed_a        = altera_xcvr_native_a10_functions_h::str_2_bin_alt_xcvr_native_a10(hssi_10g_tx_pcs_pseudo_seed_a);
    localparam  [127:0] temp_lcl_hssi_10g_tx_pcs_pseudo_seed_b        = altera_xcvr_native_a10_functions_h::str_2_bin_alt_xcvr_native_a10(hssi_10g_tx_pcs_pseudo_seed_b);
    localparam  [127:0] temp_lcl_hssi_8g_rx_pcs_wa_pd_data            = altera_xcvr_native_a10_functions_h::str_2_bin_alt_xcvr_native_a10(hssi_8g_rx_pcs_wa_pd_data);
    localparam  [127:0] temp_lcl_pma_tx_buf_xtx_path_pma_tx_divclk_hz = altera_xcvr_native_a10_functions_h::str_2_bin_alt_xcvr_native_a10(pma_tx_buf_xtx_path_pma_tx_divclk_hz);
    localparam  [127:0] temp_lcl_pma_rx_buf_xrx_path_pma_rx_divclk_hz = altera_xcvr_native_a10_functions_h::str_2_bin_alt_xcvr_native_a10(pma_rx_buf_xrx_path_pma_rx_divclk_hz);
    localparam  [127:0] temp_lcl_pma_tx_buf_xtx_path_tx_pll_clk_hz    = altera_xcvr_native_a10_functions_h::str_2_bin_alt_xcvr_native_a10(pma_tx_buf_xtx_path_tx_pll_clk_hz);
    localparam  [57:0] lcl_hssi_10g_tx_pcs_pseudo_seed_a        = altera_xcvr_native_a10_functions_h::set_10g_scrm_seed_user_alt_xcvr_native_a10(hssi_10g_tx_pcs_prot_mode,temp_lcl_hssi_10g_tx_pcs_pseudo_seed_a [57:0],ig); // randomization per channel for interlaken
    localparam  [57:0] lcl_hssi_10g_tx_pcs_pseudo_seed_b        = temp_lcl_hssi_10g_tx_pcs_pseudo_seed_b [57:0]; 
    localparam  [39:0] lcl_hssi_8g_rx_pcs_wa_pd_data            = temp_lcl_hssi_8g_rx_pcs_wa_pd_data [39:0];
    localparam  [31:0] lcl_pma_tx_buf_xtx_path_pma_tx_divclk_hz = temp_lcl_pma_tx_buf_xtx_path_pma_tx_divclk_hz[31:0];
    localparam  [31:0] lcl_pma_rx_buf_xrx_path_pma_rx_divclk_hz = temp_lcl_pma_rx_buf_xrx_path_pma_rx_divclk_hz[31:0];
    localparam  [31:0] lcl_pma_tx_buf_xtx_path_tx_pll_clk_hz    = temp_lcl_pma_tx_buf_xtx_path_tx_pll_clk_hz[31:0];


    twentynm_xcvr_native #(

        .device_revision(device_revision),

    // nf_pcs parameters
        .xcvr_native_mode               (xcvr_native_mode),
        .bonding_master_ch              (0),
        .bonded_lanes                   (1),
    // nf_xcvr_avmm parameters
        .avmm_interfaces                (1),
        .rcfg_enable                    (rcfg_enable),
        .enable_avmm                    (1),
        .arbiter_ctrl                   (arbiter_ctrl),
        .calibration_en                 (calibration_en),
        .avmm_busy_en                   (avmm_busy_en),
        .hip_cal_en                     (hip_cal_en),
        .cal_done                       (cal_done),


    // Overridden parameters for pcie
        .pma_tx_buf_mcgb_location_for_pcie(lcl_pma_tx_buf_mcgb_location_for_pcie),

    // Overridden bonding parameters
        .hssi_tx_pld_pcs_interface_hd_chnl_ctrl_plane_bonding_tx(lcl_hssi_tx_pld_pcs_interface_hd_chnl_ctrl_plane_bonding_tx),
        .hssi_rx_pld_pcs_interface_hd_chnl_ctrl_plane_bonding_rx(lcl_hssi_rx_pld_pcs_interface_hd_chnl_ctrl_plane_bonding_rx),
        .hssi_tx_pld_pcs_interface_hd_pmaif_ctrl_plane_bonding  (lcl_hssi_tx_pld_pcs_interface_hd_pmaif_ctrl_plane_bonding  ),
        .hssi_tx_pld_pcs_interface_hd_10g_ctrl_plane_bonding_tx (lcl_hssi_tx_pld_pcs_interface_hd_10g_ctrl_plane_bonding_tx ),
        .hssi_rx_pld_pcs_interface_hd_10g_ctrl_plane_bonding_rx (lcl_hssi_rx_pld_pcs_interface_hd_10g_ctrl_plane_bonding_rx ),
        .hssi_tx_pld_pcs_interface_hd_8g_ctrl_plane_bonding_tx  (lcl_hssi_tx_pld_pcs_interface_hd_8g_ctrl_plane_bonding_tx  ),
        .hssi_rx_pld_pcs_interface_hd_8g_ctrl_plane_bonding_rx  (lcl_hssi_rx_pld_pcs_interface_hd_8g_ctrl_plane_bonding_rx  ),

        .hssi_8g_rx_pcs_ctrl_plane_bonding_compensation (lcl_hssi_8g_rx_pcs_ctrl_plane_bonding_compensation),
        .hssi_8g_rx_pcs_ctrl_plane_bonding_consumption  (lcl_hssi_8g_rx_pcs_ctrl_plane_bonding_consumption ),
        .hssi_8g_rx_pcs_ctrl_plane_bonding_distribution (lcl_hssi_8g_rx_pcs_ctrl_plane_bonding_distribution),
        .hssi_8g_rx_pcs_auto_speed_nego                 (lcl_hssi_8g_rx_pcs_auto_speed_nego                ),

        .hssi_8g_tx_pcs_ctrl_plane_bonding_compensation (lcl_hssi_8g_tx_pcs_ctrl_plane_bonding_compensation),
        .hssi_8g_tx_pcs_ctrl_plane_bonding_consumption  (lcl_hssi_8g_tx_pcs_ctrl_plane_bonding_consumption ),
        .hssi_8g_tx_pcs_ctrl_plane_bonding_distribution (lcl_hssi_8g_tx_pcs_ctrl_plane_bonding_distribution),
        .hssi_8g_tx_pcs_auto_speed_nego_gen2            (lcl_hssi_8g_tx_pcs_auto_speed_nego_gen2           ),

        .hssi_10g_tx_pcs_ctrl_plane_bonding             (lcl_hssi_10g_tx_pcs_ctrl_plane_bonding),
        .hssi_10g_tx_pcs_comp_cnt                       (lcl_hssi_10g_tx_pcs_comp_cnt          ),
        .hssi_10g_tx_pcs_compin_sel                     (lcl_hssi_10g_tx_pcs_compin_sel        ),
        .hssi_10g_tx_pcs_distdwn_bypass_pipeln          ("distdwn_bypass_pipeln_dis"           ),
        .hssi_10g_tx_pcs_distdwn_master                 (lcl_hssi_10g_tx_pcs_distdwn_master    ),
        .hssi_10g_tx_pcs_distup_bypass_pipeln           ("distup_bypass_pipeln_dis"            ),
        .hssi_10g_tx_pcs_distup_master                  (lcl_hssi_10g_tx_pcs_distup_master     ),
        .hssi_10g_tx_pcs_dv_bond                        (lcl_hssi_10g_tx_pcs_dv_bond           ),
        .hssi_10g_tx_pcs_indv                           (lcl_hssi_10g_tx_pcs_indv              ),

        .hssi_common_pcs_pma_interface_ctrl_plane_bonding (lcl_hssi_common_pcs_pma_interface_ctrl_plane_bonding),
        .hssi_common_pcs_pma_interface_cp_cons_sel        (lcl_hssi_common_pcs_pma_interface_cp_cons_sel       ),
        .hssi_common_pcs_pma_interface_cp_dwn_mstr        (lcl_hssi_common_pcs_pma_interface_cp_dwn_mstr       ),
        .hssi_common_pcs_pma_interface_cp_up_mstr         (lcl_hssi_common_pcs_pma_interface_cp_up_mstr        ),

    // Overridden parameters for twentynm_hssi_pma_cdr_refclk_select_mux
        .pma_cdr_refclk_inclk0_logical_to_physical_mapping (              "ref_iqclk0"               ),
        .pma_cdr_refclk_inclk1_logical_to_physical_mapping ( (cdr_refclk_cnt > 1) ? "ref_iqclk1" : "power_down"),
        .pma_cdr_refclk_inclk2_logical_to_physical_mapping ( (cdr_refclk_cnt > 2) ? "ref_iqclk2" : "power_down"),
        .pma_cdr_refclk_inclk3_logical_to_physical_mapping ( (cdr_refclk_cnt > 3) ? "ref_iqclk3" : "power_down"),
        .pma_cdr_refclk_inclk4_logical_to_physical_mapping ( (cdr_refclk_cnt > 4) ? "ref_iqclk4" : "power_down"),
        .pma_cgb_scratch0_x1_clock_src( (bonded_mode == "not_bonded")                ? "fpll_bot"  : "unused"),
        .pma_cgb_scratch1_x1_clock_src(((bonded_mode == "not_bonded") && (plls > 1)) ? "lcpll_bot" : "unused"),
        .pma_cgb_scratch2_x1_clock_src(((bonded_mode == "not_bonded") && (plls > 2)) ? "fpll_top"  : "unused"),
        .pma_cgb_scratch3_x1_clock_src(((bonded_mode == "not_bonded") && (plls > 3)) ? "lcpll_top" : "unused"),
        //.pma_cgb_scratch0_bonded_clock_src( ((bonded_mode == "pma_only") || (bonded_mode == "pma_pcs"))? 
	//   "fpll_bot"  : "unused"),
        //.pma_cgb_scratch1_bonded_clock_src((((bonded_mode == "pma_only") || (bonded_mode == "pma_pcs")) && (number_physical_bonding_clocks > 1)) ? 
	//   "lcpll_bot" : "unused"),
        //.pma_cgb_scratch2_bonded_clock_src((((bonded_mode == "pma_only") || (bonded_mode == "pma_pcs")) && (number_physical_bonding_clocks > 2)) ? 
        //   "fpll_top"  : "unused"),
        //.pma_cgb_scratch3_bonded_clock_src((((bonded_mode == "pma_only") || (bonded_mode == "pma_pcs")) && (number_physical_bonding_clocks > 3)) ? 
        //   "lcpll_top" : "unused"),

    // parameters for twentynm_hssi_pma_adaptation
    // parameters for twentynm_hssi_pma_cdr_refclk_select_mux
        //.pma_cdr_refclk_receiver_detect_src (pma_cdr_refclk_receiver_detect_src),
        .pma_cdr_refclk_refclk_select (pma_cdr_refclk_refclk_select),        
        .pma_cdr_refclk_powerdown_mode (pma_cdr_refclk_powerdown_mode),
    // parameters for twentynm_hssi_pma_channel_pll
        .cdr_pll_atb_select_control (cdr_pll_atb_select_control),
        .cdr_pll_bbpd_data_pattern_filter_select (cdr_pll_bbpd_data_pattern_filter_select),
        .cdr_pll_bw_sel (cdr_pll_bw_sel),
        .cdr_pll_cdr_odi_select (cdr_pll_cdr_odi_select),
        .cdr_pll_cgb_div (cdr_pll_cgb_div),
        .cdr_pll_chgpmp_current_pd (cdr_pll_chgpmp_current_pd),
        .cdr_pll_chgpmp_current_pfd (cdr_pll_chgpmp_current_pfd),
        .cdr_pll_chgpmp_replicate (cdr_pll_chgpmp_replicate),
        .cdr_pll_chgpmp_testmode (cdr_pll_chgpmp_testmode),
        .cdr_pll_clklow_mux_select (cdr_pll_clklow_mux_select),
        .cdr_pll_diag_loopback_enable (cdr_pll_diag_loopback_enable),
        .cdr_pll_disable_up_dn (cdr_pll_disable_up_dn),
        .cdr_pll_fb_select (cdr_pll_fb_select),
        .cdr_pll_fref_clklow_div (cdr_pll_fref_clklow_div),
        .cdr_pll_fref_mux_select (cdr_pll_fref_mux_select),
        .cdr_pll_gpon_lck2ref_control (cdr_pll_gpon_lck2ref_control),
        .cdr_pll_iqclk_mux_sel (cdr_pll_iqclk_mux_sel),
        .cdr_pll_is_cascaded_pll (cdr_pll_is_cascaded_pll),
        .cdr_pll_lck2ref_delay_control (cdr_pll_lck2ref_delay_control),
        .cdr_pll_lpd_counter (cdr_pll_lpd_counter),
        .cdr_pll_lpfd_counter (cdr_pll_lpfd_counter),
        .cdr_pll_lf_resistor_pd (cdr_pll_lf_resistor_pd),
        .cdr_pll_lf_resistor_pfd (cdr_pll_lf_resistor_pfd),
        .cdr_pll_lf_ripple_cap (cdr_pll_lf_ripple_cap),
        .cdr_pll_loop_filter_bias_select (cdr_pll_loop_filter_bias_select),
        .cdr_pll_loopback_mode (cdr_pll_loopback_mode),
        .cdr_pll_ltd_ltr_micro_controller_select (cdr_pll_ltd_ltr_micro_controller_select),
        .cdr_pll_m_counter (cdr_pll_m_counter),
        .cdr_pll_n_counter (cdr_pll_n_counter),
	.cdr_pll_n_counter_scratch (cdr_pll_n_counter_scratch),
        .cdr_pll_output_clock_frequency (cdr_pll_output_clock_frequency),
        .cdr_pll_pcie_gen (cdr_pll_pcie_gen),
        .cdr_pll_set_cdr_input_freq_range (cdr_pll_set_cdr_input_freq_range),
        .cdr_pll_chgpmp_current_dn_trim (cdr_pll_chgpmp_current_dn_trim),
        .cdr_pll_chgpmp_up_pd_trim_double (cdr_pll_chgpmp_up_pd_trim_double),
        .cdr_pll_chgpmp_current_up_pd (cdr_pll_chgpmp_current_up_pd),
        .cdr_pll_chgpmp_current_up_trim (cdr_pll_chgpmp_current_up_trim),
        .cdr_pll_chgpmp_dn_pd_trim_double (cdr_pll_chgpmp_dn_pd_trim_double),
        .cdr_pll_cal_vco_count_length (cdr_pll_cal_vco_count_length),
        .cdr_pll_chgpmp_current_dn_pd (cdr_pll_chgpmp_current_dn_pd),
        .cdr_pll_pd_fastlock_mode (cdr_pll_pd_fastlock_mode),
        .cdr_pll_pd_l_counter (cdr_pll_pd_l_counter),
        .cdr_pll_pfd_l_counter (cdr_pll_pfd_l_counter),
        .cdr_pll_pma_width (cdr_pll_pma_width),
        .cdr_pll_primary_use (cdr_pll_primary_use),
        .cdr_pll_reference_clock_frequency (cdr_pll_reference_clock_frequency),
//        .cdr_pll_requires_gt_capable_channel (cdr_pll_requires_gt_capable_channel ),
        .cdr_pll_reverse_serial_loopback (cdr_pll_reverse_serial_loopback),
        .cdr_pll_set_cdr_vco_reset (cdr_pll_set_cdr_vco_reset),
        .cdr_pll_set_cdr_vco_speed (cdr_pll_set_cdr_vco_speed),
        .cdr_pll_set_cdr_vco_speed_pciegen3 (cdr_pll_set_cdr_vco_speed_pciegen3),
        .cdr_pll_set_cdr_v2i_enable (cdr_pll_set_cdr_v2i_enable),
        .cdr_pll_txpll_hclk_driver_enable (cdr_pll_txpll_hclk_driver_enable),
        .cdr_pll_vco_overrange_voltage (cdr_pll_vco_overrange_voltage),
        .cdr_pll_vco_underrange_voltage (cdr_pll_vco_underrange_voltage),
        .cdr_pll_uc_ro_cal (cdr_pll_uc_ro_cal),
        .cdr_pll_vco_freq (cdr_pll_vco_freq),
        .cdr_pll_set_cdr_vco_speed_fix (cdr_pll_set_cdr_vco_speed_fix),
        .cdr_pll_auto_reset_on (cdr_pll_auto_reset_on),
        .cdr_pll_cdr_phaselock_mode (cdr_pll_cdr_phaselock_mode),
        .cdr_pll_cdr_powerdown_mode (cdr_pll_cdr_powerdown_mode),
        .cdr_pll_initial_settings (cdr_pll_initial_settings),
    // parameters for pma_adapt
        .pma_adapt_adapt_mode (pma_adapt_adapt_mode),
        .pma_adapt_adp_1s_ctle_bypass (pma_adapt_adp_1s_ctle_bypass),
        .pma_adapt_adp_4s_ctle_bypass (pma_adapt_adp_4s_ctle_bypass),
        .pma_adapt_adp_ctle_adapt_cycle_window (pma_adapt_adp_ctle_adapt_cycle_window),
        .pma_adapt_adp_ctle_en (pma_adapt_adp_ctle_en),
        .pma_adapt_adp_dfe_fltap_bypass (pma_adapt_adp_dfe_fltap_bypass),
        .pma_adapt_adp_dfe_fltap_en (pma_adapt_adp_dfe_fltap_en),
        .pma_adapt_adp_dfe_fxtap_bypass (pma_adapt_adp_dfe_fxtap_bypass),
        .pma_adapt_adp_dfe_fxtap_en (pma_adapt_adp_dfe_fxtap_en),
        .pma_adapt_adp_dfe_fxtap_hold_en (pma_adapt_adp_dfe_fxtap_hold_en),
        .pma_adapt_adp_dfe_mode (pma_adapt_adp_dfe_mode),
        .pma_adapt_adp_mode (pma_adapt_adp_mode),
        .pma_adapt_adp_onetime_dfe (pma_adapt_adp_onetime_dfe),
        .pma_adapt_adp_vga_bypass (pma_adapt_adp_vga_bypass),
        .pma_adapt_adp_vga_en (pma_adapt_adp_vga_en),
        .pma_adapt_adp_vref_bypass (pma_adapt_adp_vref_bypass),
        .pma_adapt_adp_vref_en (pma_adapt_adp_vref_en),
        .pma_adapt_odi_dfe_spec_en (pma_adapt_odi_dfe_spec_en),
    // parameters for twentynm_hssi_pma_rx_buf
        .pma_rx_buf_bypass_eqz_stages_234 (pma_rx_buf_bypass_eqz_stages_234),
        .pma_rx_buf_diag_lp_en (pma_rx_buf_diag_lp_en),
        .pma_rx_buf_qpi_enable (pma_rx_buf_qpi_enable),
        .pma_rx_buf_rx_refclk_divider (pma_rx_buf_rx_refclk_divider),
        .pma_rx_buf_loopback_modes (pma_rx_buf_loopback_modes),
        .pma_rx_buf_refclk_en (pma_rx_buf_refclk_en),
        .pma_rx_buf_pm_tx_rx_pcie_gen (pma_rx_buf_pm_tx_rx_pcie_gen),
        .pma_rx_buf_pm_tx_rx_pcie_gen_bitwidth (pma_rx_buf_pm_tx_rx_pcie_gen_bitwidth),
        .pma_rx_buf_pm_tx_rx_cvp_mode (pma_rx_buf_pm_tx_rx_cvp_mode),
        .pma_rx_buf_xrx_path_uc_cal_enable (pma_rx_buf_xrx_path_uc_cal_enable),
        .pma_rx_buf_xrx_path_datawidth (pma_rx_buf_xrx_path_datawidth),
        .pma_rx_buf_xrx_path_pma_rx_divclk_hz (lcl_pma_rx_buf_xrx_path_pma_rx_divclk_hz),  // String to bin conversion
    // parameters for twentynm_hssi_pma_rx_deser
        .pma_rx_deser_clkdivrx_user_mode (pma_rx_deser_clkdivrx_user_mode),
        .pma_rx_deser_pcie_gen (pma_rx_deser_pcie_gen),
        .pma_rx_deser_pcie_gen_bitwidth (pma_rx_deser_pcie_gen_bitwidth),
        .pma_rx_deser_deser_factor (pma_rx_deser_deser_factor),
        .pma_rx_deser_sdclk_enable (pma_rx_deser_sdclk_enable),
        .pma_rx_deser_clkdiv_source (pma_rx_deser_clkdiv_source),
        .pma_rx_deser_force_clkdiv_for_testing (pma_rx_deser_force_clkdiv_for_testing),
        .pma_rx_deser_rst_n_adapt_odi (pma_rx_deser_rst_n_adapt_odi),
        .pma_rx_deser_bitslip_bypass (pma_rx_deser_bitslip_bypass),
    // parameters for twentynm_hssi_pma_rx_dfe
        .pma_rx_dfe_pdb (pma_rx_dfe_pdb),
        .pma_rx_dfe_pdb_fixedtap (pma_rx_dfe_pdb_fixedtap),
        .pma_rx_dfe_pdb_floattap (pma_rx_dfe_pdb_floattap),
        .pma_rx_dfe_pdb_fxtap4t7 (pma_rx_dfe_pdb_fxtap4t7),
        .pma_rx_dfe_dft_en (pma_rx_dfe_dft_en),
    // parameters for twentynm_hssi_pma_rx_odi
        .pma_rx_odi_step_ctrl_sel (pma_rx_odi_step_ctrl_sel),
    // parameters for twentynm_hssi_pma_rx_sd
        .pma_rx_sd_sd_output_off (pma_rx_sd_sd_output_off),
        .pma_rx_sd_sd_output_on (pma_rx_sd_sd_output_on),
        .pma_rx_sd_sd_pdb (pma_rx_sd_sd_pdb),
        //.pma_rx_sd_sd_threshold (pma_rx_sd_sd_threshold),
    // parameters for twentynm_hssi_pma_tx_buf
        .pma_tx_buf_rx_det (pma_tx_buf_rx_det),
        .pma_tx_buf_rx_det_output_sel (pma_tx_buf_rx_det_output_sel),
        .pma_tx_buf_rx_det_pdb (pma_tx_buf_rx_det_pdb),
        .pma_tx_buf_user_fir_coeff_ctrl_sel (pma_tx_buf_user_fir_coeff_ctrl_sel),
        .pma_tx_buf_xtx_path_datawidth (pma_tx_buf_xtx_path_datawidth),
        .pma_tx_buf_xtx_path_clock_divider_ratio (pma_tx_buf_xtx_path_clock_divider_ratio),
        .pma_tx_buf_xtx_path_pma_tx_divclk_hz (lcl_pma_tx_buf_xtx_path_pma_tx_divclk_hz),  // String to bin conversion
        //.pma_tx_buf_xtx_path_tx_pll_clk_hz (lcl_pma_tx_buf_xtx_path_tx_pll_clk_hz),  // String to bin conversion
        .pma_tx_buf_xtx_path_tx_pll_clk_hz (pma_tx_buf_xtx_path_tx_pll_clk_hz),
    // parameters for twentynm_hssi_pma_tx_cgb
        .pma_cgb_bitslip_enable (pma_cgb_bitslip_enable),
        .pma_cgb_bonding_reset_enable (pma_cgb_bonding_reset_enable),
        .pma_cgb_input_select_xn (pma_cgb_input_select_xn),
        .pma_cgb_input_select_gen3 (pma_cgb_input_select_gen3),
        .pma_cgb_input_select_x1 (pma_cgb_input_select_x1),
        .pma_cgb_pcie_gen3_bitwidth (pma_cgb_pcie_gen3_bitwidth),
        .pma_cgb_select_done_master_or_slave (lcl_pma_cgb_select_done_master_or_slave),
        .pma_cgb_ser_mode (pma_cgb_ser_mode),
        .pma_cgb_x1_div_m_sel (pma_cgb_x1_div_m_sel),
        .pma_cgb_tx_ucontrol_en (pma_cgb_tx_ucontrol_en),
    // parameters for twentynm_hssi_pma_tx_ser
        .pma_tx_ser_ser_clk_divtx_user_sel (pma_tx_ser_ser_clk_divtx_user_sel),
    
    // reconfig_settings
        .hssi_10g_rx_pcs_reconfig_settings("./top_DUT/altera_xcvr_native_a10_191/synth/rcfg_timing_db/top_DUT_hssi_10g_rx_pcs_rcfg_settings_o3savxa.json"),
        .hssi_10g_tx_pcs_reconfig_settings("./top_DUT/altera_xcvr_native_a10_191/synth/rcfg_timing_db/top_DUT_hssi_10g_tx_pcs_rcfg_settings_o3savxa.json"),
        .hssi_8g_rx_pcs_reconfig_settings("./top_DUT/altera_xcvr_native_a10_191/synth/rcfg_timing_db/top_DUT_hssi_8g_rx_pcs_rcfg_settings_o3savxa.json"),
        .hssi_8g_tx_pcs_reconfig_settings("./top_DUT/altera_xcvr_native_a10_191/synth/rcfg_timing_db/top_DUT_hssi_8g_tx_pcs_rcfg_settings_o3savxa.json"),
        .hssi_common_pcs_pma_interface_reconfig_settings("./top_DUT/altera_xcvr_native_a10_191/synth/rcfg_timing_db/top_DUT_hssi_common_pcs_pma_interface_rcfg_settings_o3savxa.json"),
        .hssi_common_pld_pcs_interface_reconfig_settings("./top_DUT/altera_xcvr_native_a10_191/synth/rcfg_timing_db/top_DUT_hssi_common_pld_pcs_interface_rcfg_settings_o3savxa.json"),
        .hssi_gen3_rx_pcs_reconfig_settings("./top_DUT/altera_xcvr_native_a10_191/synth/rcfg_timing_db/top_DUT_hssi_gen3_rx_pcs_rcfg_settings_o3savxa.json"),
        .hssi_krfec_rx_pcs_reconfig_settings("./top_DUT/altera_xcvr_native_a10_191/synth/rcfg_timing_db/top_DUT_hssi_krfec_rx_pcs_rcfg_settings_o3savxa.json"),
        .hssi_pipe_gen1_2_reconfig_settings("./top_DUT/altera_xcvr_native_a10_191/synth/rcfg_timing_db/top_DUT_hssi_pipe_gen1_2_rcfg_settings_o3savxa.json"),
        .hssi_rx_pcs_pma_interface_reconfig_settings("./top_DUT/altera_xcvr_native_a10_191/synth/rcfg_timing_db/top_DUT_hssi_rx_pcs_pma_interface_rcfg_settings_o3savxa.json"),
        .hssi_rx_pld_pcs_interface_reconfig_settings("./top_DUT/altera_xcvr_native_a10_191/synth/rcfg_timing_db/top_DUT_hssi_rx_pld_pcs_interface_rcfg_settings_o3savxa.json"),
        .hssi_tx_pcs_pma_interface_reconfig_settings("./top_DUT/altera_xcvr_native_a10_191/synth/rcfg_timing_db/top_DUT_hssi_tx_pcs_pma_interface_rcfg_settings_o3savxa.json"),
        .hssi_tx_pld_pcs_interface_reconfig_settings("./top_DUT/altera_xcvr_native_a10_191/synth/rcfg_timing_db/top_DUT_hssi_tx_pld_pcs_interface_rcfg_settings_o3savxa.json"),
    // twentynm_pcs parameters
    // parameters for twentynm_hssi_10g_rx_pcs
        .hssi_10g_rx_pcs_advanced_user_mode (hssi_10g_rx_pcs_advanced_user_mode),
        .hssi_10g_rx_pcs_align_del (hssi_10g_rx_pcs_align_del),
        .hssi_10g_rx_pcs_ber_bit_err_total_cnt (hssi_10g_rx_pcs_ber_bit_err_total_cnt),
        .hssi_10g_rx_pcs_ber_clken (hssi_10g_rx_pcs_ber_clken),
        .hssi_10g_rx_pcs_ber_xus_timer_window (hssi_10g_rx_pcs_ber_xus_timer_window),
        .hssi_10g_rx_pcs_bitslip_mode (hssi_10g_rx_pcs_bitslip_mode),
        .hssi_10g_rx_pcs_blksync_bitslip_type (hssi_10g_rx_pcs_blksync_bitslip_type),
        .hssi_10g_rx_pcs_blksync_bitslip_wait_cnt (hssi_10g_rx_pcs_blksync_bitslip_wait_cnt),
        .hssi_10g_rx_pcs_blksync_bitslip_wait_type (hssi_10g_rx_pcs_blksync_bitslip_wait_type),
        .hssi_10g_rx_pcs_blksync_bypass (hssi_10g_rx_pcs_blksync_bypass),
        .hssi_10g_rx_pcs_blksync_clken (hssi_10g_rx_pcs_blksync_clken),
        .hssi_10g_rx_pcs_blksync_enum_invalid_sh_cnt (hssi_10g_rx_pcs_blksync_enum_invalid_sh_cnt),
        .hssi_10g_rx_pcs_blksync_knum_sh_cnt_postlock (hssi_10g_rx_pcs_blksync_knum_sh_cnt_postlock),
        .hssi_10g_rx_pcs_blksync_knum_sh_cnt_prelock (hssi_10g_rx_pcs_blksync_knum_sh_cnt_prelock),
        .hssi_10g_rx_pcs_blksync_pipeln (hssi_10g_rx_pcs_blksync_pipeln),
        .hssi_10g_rx_pcs_clr_errblk_cnt_en (hssi_10g_rx_pcs_clr_errblk_cnt_en),
        .hssi_10g_rx_pcs_control_del (hssi_10g_rx_pcs_control_del),
        .hssi_10g_rx_pcs_crcchk_bypass (hssi_10g_rx_pcs_crcchk_bypass),
        .hssi_10g_rx_pcs_crcchk_clken (hssi_10g_rx_pcs_crcchk_clken),
        .hssi_10g_rx_pcs_crcchk_inv (hssi_10g_rx_pcs_crcchk_inv),
        .hssi_10g_rx_pcs_crcchk_pipeln (hssi_10g_rx_pcs_crcchk_pipeln),
        .hssi_10g_rx_pcs_crcflag_pipeln (hssi_10g_rx_pcs_crcflag_pipeln),
        .hssi_10g_rx_pcs_ctrl_bit_reverse (hssi_10g_rx_pcs_ctrl_bit_reverse),
        .hssi_10g_rx_pcs_data_bit_reverse (hssi_10g_rx_pcs_data_bit_reverse),
        .hssi_10g_rx_pcs_dec64b66b_clken (hssi_10g_rx_pcs_dec64b66b_clken),
        .hssi_10g_rx_pcs_dec_64b66b_rxsm_bypass (hssi_10g_rx_pcs_dec_64b66b_rxsm_bypass),
        .hssi_10g_rx_pcs_descrm_bypass (hssi_10g_rx_pcs_descrm_bypass),
        .hssi_10g_rx_pcs_descrm_clken (hssi_10g_rx_pcs_descrm_clken),
        .hssi_10g_rx_pcs_descrm_mode (hssi_10g_rx_pcs_descrm_mode),
        .hssi_10g_rx_pcs_descrm_pipeln (hssi_10g_rx_pcs_descrm_pipeln),
        .hssi_10g_rx_pcs_dft_clk_out_sel (hssi_10g_rx_pcs_dft_clk_out_sel),
        .hssi_10g_rx_pcs_dis_signal_ok (hssi_10g_rx_pcs_dis_signal_ok),
        .hssi_10g_rx_pcs_dispchk_bypass (hssi_10g_rx_pcs_dispchk_bypass),
        .hssi_10g_rx_pcs_empty_flag_type (hssi_10g_rx_pcs_empty_flag_type),
        .hssi_10g_rx_pcs_fast_path (hssi_10g_rx_pcs_fast_path),
        .hssi_10g_rx_pcs_fec_clken (hssi_10g_rx_pcs_fec_clken),
        .hssi_10g_rx_pcs_fec_enable (hssi_10g_rx_pcs_fec_enable),
        .hssi_10g_rx_pcs_fifo_double_read (hssi_10g_rx_pcs_fifo_double_read),
        .hssi_10g_rx_pcs_fifo_stop_rd (hssi_10g_rx_pcs_fifo_stop_rd),
        .hssi_10g_rx_pcs_fifo_stop_wr (hssi_10g_rx_pcs_fifo_stop_wr),
        .hssi_10g_rx_pcs_force_align (hssi_10g_rx_pcs_force_align),
        .hssi_10g_rx_pcs_frmsync_bypass (hssi_10g_rx_pcs_frmsync_bypass),
        .hssi_10g_rx_pcs_frmsync_clken (hssi_10g_rx_pcs_frmsync_clken),
        .hssi_10g_rx_pcs_frmsync_enum_scrm (hssi_10g_rx_pcs_frmsync_enum_scrm),
        .hssi_10g_rx_pcs_frmsync_enum_sync (hssi_10g_rx_pcs_frmsync_enum_sync),
        .hssi_10g_rx_pcs_frmsync_flag_type (hssi_10g_rx_pcs_frmsync_flag_type),
        .hssi_10g_rx_pcs_frmsync_knum_sync (hssi_10g_rx_pcs_frmsync_knum_sync),
        .hssi_10g_rx_pcs_frmsync_mfrm_length (hssi_10g_rx_pcs_frmsync_mfrm_length),
        .hssi_10g_rx_pcs_frmsync_pipeln (hssi_10g_rx_pcs_frmsync_pipeln),
        .hssi_10g_rx_pcs_full_flag_type (hssi_10g_rx_pcs_full_flag_type),
        .hssi_10g_rx_pcs_gb_rx_idwidth (hssi_10g_rx_pcs_gb_rx_idwidth),
        .hssi_10g_rx_pcs_gb_rx_odwidth (hssi_10g_rx_pcs_gb_rx_odwidth),
        .hssi_10g_rx_pcs_gbexp_clken (hssi_10g_rx_pcs_gbexp_clken),
        .hssi_10g_rx_pcs_low_latency_en (hssi_10g_rx_pcs_low_latency_en),
        .hssi_10g_rx_pcs_lpbk_mode (hssi_10g_rx_pcs_lpbk_mode),
        .hssi_10g_rx_pcs_master_clk_sel (hssi_10g_rx_pcs_master_clk_sel),
        .hssi_10g_rx_pcs_pempty_flag_type (hssi_10g_rx_pcs_pempty_flag_type),
        .hssi_10g_rx_pcs_pfull_flag_type (hssi_10g_rx_pcs_pfull_flag_type),
        .hssi_10g_rx_pcs_phcomp_rd_del (hssi_10g_rx_pcs_phcomp_rd_del),
        .hssi_10g_rx_pcs_pld_if_type (hssi_10g_rx_pcs_pld_if_type),
        .hssi_10g_rx_pcs_rand_clken (hssi_10g_rx_pcs_rand_clken),
        .hssi_10g_rx_pcs_rd_clk_sel (hssi_10g_rx_pcs_rd_clk_sel),
        .hssi_10g_rx_pcs_rdfifo_clken (hssi_10g_rx_pcs_rdfifo_clken),
        .hssi_10g_rx_pcs_rx_fifo_write_ctrl (hssi_10g_rx_pcs_rx_fifo_write_ctrl),
        .hssi_10g_rx_pcs_rx_scrm_width (hssi_10g_rx_pcs_rx_scrm_width),
        .hssi_10g_rx_pcs_rx_sh_location (hssi_10g_rx_pcs_rx_sh_location),
        .hssi_10g_rx_pcs_rx_signal_ok_sel (hssi_10g_rx_pcs_rx_signal_ok_sel),
        .hssi_10g_rx_pcs_rx_sm_bypass (hssi_10g_rx_pcs_rx_sm_bypass),
        .hssi_10g_rx_pcs_rx_sm_hiber (hssi_10g_rx_pcs_rx_sm_hiber),
        .hssi_10g_rx_pcs_rx_sm_pipeln (hssi_10g_rx_pcs_rx_sm_pipeln),
        .hssi_10g_rx_pcs_rx_testbus_sel (hssi_10g_rx_pcs_rx_testbus_sel),
        .hssi_10g_rx_pcs_rx_true_b2b (hssi_10g_rx_pcs_rx_true_b2b),
        .hssi_10g_rx_pcs_rxfifo_empty (hssi_10g_rx_pcs_rxfifo_empty),
        .hssi_10g_rx_pcs_rxfifo_full (hssi_10g_rx_pcs_rxfifo_full),
        .hssi_10g_rx_pcs_rxfifo_mode (hssi_10g_rx_pcs_rxfifo_mode),
        .hssi_10g_rx_pcs_rxfifo_pempty (hssi_10g_rx_pcs_rxfifo_pempty),
        .hssi_10g_rx_pcs_rxfifo_pfull (hssi_10g_rx_pcs_rxfifo_pfull),
        .hssi_10g_rx_pcs_stretch_num_stages (hssi_10g_rx_pcs_stretch_num_stages),
        .hssi_10g_rx_pcs_test_mode (hssi_10g_rx_pcs_test_mode),
        .hssi_10g_rx_pcs_wrfifo_clken (hssi_10g_rx_pcs_wrfifo_clken),
    // parameters for twentynm_hssi_10g_tx_pcs
        .hssi_10g_tx_pcs_advanced_user_mode (hssi_10g_tx_pcs_advanced_user_mode),
        .hssi_10g_tx_pcs_bitslip_en (hssi_10g_tx_pcs_bitslip_en),
        .hssi_10g_tx_pcs_bonding_dft_en (hssi_10g_tx_pcs_bonding_dft_en),
        .hssi_10g_tx_pcs_bonding_dft_val (hssi_10g_tx_pcs_bonding_dft_val),
        .hssi_10g_tx_pcs_crcgen_bypass (hssi_10g_tx_pcs_crcgen_bypass),
        .hssi_10g_tx_pcs_crcgen_clken (hssi_10g_tx_pcs_crcgen_clken),
        .hssi_10g_tx_pcs_crcgen_err (hssi_10g_tx_pcs_crcgen_err),
        .hssi_10g_tx_pcs_crcgen_inv (hssi_10g_tx_pcs_crcgen_inv),
        .hssi_10g_tx_pcs_ctrl_bit_reverse (hssi_10g_tx_pcs_ctrl_bit_reverse),
        .hssi_10g_tx_pcs_data_bit_reverse (hssi_10g_tx_pcs_data_bit_reverse),
        .hssi_10g_tx_pcs_dft_clk_out_sel (hssi_10g_tx_pcs_dft_clk_out_sel),
        .hssi_10g_tx_pcs_dispgen_bypass (hssi_10g_tx_pcs_dispgen_bypass),
        .hssi_10g_tx_pcs_dispgen_clken (hssi_10g_tx_pcs_dispgen_clken),
        .hssi_10g_tx_pcs_dispgen_err (hssi_10g_tx_pcs_dispgen_err),
        .hssi_10g_tx_pcs_dispgen_pipeln (hssi_10g_tx_pcs_dispgen_pipeln),
        .hssi_10g_tx_pcs_empty_flag_type (hssi_10g_tx_pcs_empty_flag_type),
        .hssi_10g_tx_pcs_enc64b66b_txsm_clken (hssi_10g_tx_pcs_enc64b66b_txsm_clken),
        .hssi_10g_tx_pcs_enc_64b66b_txsm_bypass (hssi_10g_tx_pcs_enc_64b66b_txsm_bypass),
        .hssi_10g_tx_pcs_fastpath (hssi_10g_tx_pcs_fastpath),
        .hssi_10g_tx_pcs_fec_clken (hssi_10g_tx_pcs_fec_clken),
        .hssi_10g_tx_pcs_fec_enable (hssi_10g_tx_pcs_fec_enable),
        .hssi_10g_tx_pcs_fifo_double_write (hssi_10g_tx_pcs_fifo_double_write),
        .hssi_10g_tx_pcs_fifo_reg_fast (hssi_10g_tx_pcs_fifo_reg_fast),
        .hssi_10g_tx_pcs_fifo_stop_rd (hssi_10g_tx_pcs_fifo_stop_rd),
        .hssi_10g_tx_pcs_fifo_stop_wr (hssi_10g_tx_pcs_fifo_stop_wr),
        .hssi_10g_tx_pcs_frmgen_burst (hssi_10g_tx_pcs_frmgen_burst),
        .hssi_10g_tx_pcs_frmgen_bypass (hssi_10g_tx_pcs_frmgen_bypass),
        .hssi_10g_tx_pcs_frmgen_clken (hssi_10g_tx_pcs_frmgen_clken),
        .hssi_10g_tx_pcs_frmgen_mfrm_length (hssi_10g_tx_pcs_frmgen_mfrm_length),
        .hssi_10g_tx_pcs_frmgen_pipeln (hssi_10g_tx_pcs_frmgen_pipeln),
        .hssi_10g_tx_pcs_frmgen_pyld_ins (hssi_10g_tx_pcs_frmgen_pyld_ins),
        .hssi_10g_tx_pcs_frmgen_wordslip (hssi_10g_tx_pcs_frmgen_wordslip),
        .hssi_10g_tx_pcs_full_flag_type (hssi_10g_tx_pcs_full_flag_type),
        .hssi_10g_tx_pcs_gb_pipeln_bypass (hssi_10g_tx_pcs_gb_pipeln_bypass),
        .hssi_10g_tx_pcs_gb_tx_idwidth (hssi_10g_tx_pcs_gb_tx_idwidth),
        .hssi_10g_tx_pcs_gb_tx_odwidth (hssi_10g_tx_pcs_gb_tx_odwidth),
        .hssi_10g_tx_pcs_gbred_clken (hssi_10g_tx_pcs_gbred_clken),
        .hssi_10g_tx_pcs_low_latency_en (hssi_10g_tx_pcs_low_latency_en),
        .hssi_10g_tx_pcs_master_clk_sel (hssi_10g_tx_pcs_master_clk_sel),
        .hssi_10g_tx_pcs_pempty_flag_type (hssi_10g_tx_pcs_pempty_flag_type),
        .hssi_10g_tx_pcs_pfull_flag_type (hssi_10g_tx_pcs_pfull_flag_type),
        .hssi_10g_tx_pcs_phcomp_rd_del (hssi_10g_tx_pcs_phcomp_rd_del),
        .hssi_10g_tx_pcs_pld_if_type (hssi_10g_tx_pcs_pld_if_type),
        .hssi_10g_tx_pcs_pseudo_random (hssi_10g_tx_pcs_pseudo_random),
        .hssi_10g_tx_pcs_pseudo_seed_a (lcl_hssi_10g_tx_pcs_pseudo_seed_a),  // String to bin conversion
        .hssi_10g_tx_pcs_pseudo_seed_b (lcl_hssi_10g_tx_pcs_pseudo_seed_b),  // String to bin conversion
        .hssi_10g_tx_pcs_random_disp (hssi_10g_tx_pcs_random_disp),
        .hssi_10g_tx_pcs_rdfifo_clken (hssi_10g_tx_pcs_rdfifo_clken),
        .hssi_10g_tx_pcs_scrm_bypass (hssi_10g_tx_pcs_scrm_bypass),
        .hssi_10g_tx_pcs_scrm_clken (hssi_10g_tx_pcs_scrm_clken),
        .hssi_10g_tx_pcs_scrm_mode (hssi_10g_tx_pcs_scrm_mode),
        .hssi_10g_tx_pcs_scrm_pipeln (hssi_10g_tx_pcs_scrm_pipeln),
        .hssi_10g_tx_pcs_sh_err (hssi_10g_tx_pcs_sh_err),
        .hssi_10g_tx_pcs_sop_mark (hssi_10g_tx_pcs_sop_mark),
        .hssi_10g_tx_pcs_stretch_num_stages (hssi_10g_tx_pcs_stretch_num_stages),
        .hssi_10g_tx_pcs_test_mode (hssi_10g_tx_pcs_test_mode),
        .hssi_10g_tx_pcs_tx_scrm_err (hssi_10g_tx_pcs_tx_scrm_err),
        .hssi_10g_tx_pcs_tx_scrm_width (hssi_10g_tx_pcs_tx_scrm_width),
        .hssi_10g_tx_pcs_tx_sh_location (hssi_10g_tx_pcs_tx_sh_location),
        .hssi_10g_tx_pcs_tx_sm_bypass (hssi_10g_tx_pcs_tx_sm_bypass),
        .hssi_10g_tx_pcs_tx_sm_pipeln (hssi_10g_tx_pcs_tx_sm_pipeln),
        .hssi_10g_tx_pcs_tx_testbus_sel (hssi_10g_tx_pcs_tx_testbus_sel),
        .hssi_10g_tx_pcs_txfifo_empty (hssi_10g_tx_pcs_txfifo_empty),
        .hssi_10g_tx_pcs_txfifo_full (hssi_10g_tx_pcs_txfifo_full),
        .hssi_10g_tx_pcs_txfifo_mode (hssi_10g_tx_pcs_txfifo_mode),
        .hssi_10g_tx_pcs_txfifo_pempty (hssi_10g_tx_pcs_txfifo_pempty),
        .hssi_10g_tx_pcs_txfifo_pfull (hssi_10g_tx_pcs_txfifo_pfull),
        .hssi_10g_tx_pcs_wr_clk_sel (hssi_10g_tx_pcs_wr_clk_sel),
        .hssi_10g_tx_pcs_wrfifo_clken (hssi_10g_tx_pcs_wrfifo_clken),
    // parameters for twentynm_hssi_8g_rx_pcs
        .hssi_8g_rx_pcs_auto_error_replacement (hssi_8g_rx_pcs_auto_error_replacement),
        .hssi_8g_rx_pcs_bit_reversal (hssi_8g_rx_pcs_bit_reversal),
        .hssi_8g_rx_pcs_bonding_dft_en (hssi_8g_rx_pcs_bonding_dft_en),
        .hssi_8g_rx_pcs_bonding_dft_val (hssi_8g_rx_pcs_bonding_dft_val),
        .hssi_8g_rx_pcs_bypass_pipeline_reg (hssi_8g_rx_pcs_bypass_pipeline_reg),
        .hssi_8g_rx_pcs_byte_deserializer (hssi_8g_rx_pcs_byte_deserializer),
        .hssi_8g_rx_pcs_cdr_ctrl_rxvalid_mask (hssi_8g_rx_pcs_cdr_ctrl_rxvalid_mask),
        .hssi_8g_rx_pcs_clkcmp_pattern_n (hssi_8g_rx_pcs_clkcmp_pattern_n),
        .hssi_8g_rx_pcs_clkcmp_pattern_p (hssi_8g_rx_pcs_clkcmp_pattern_p),
        .hssi_8g_rx_pcs_clock_gate_bds_dec_asn (hssi_8g_rx_pcs_clock_gate_bds_dec_asn),
        .hssi_8g_rx_pcs_clock_gate_cdr_eidle (hssi_8g_rx_pcs_clock_gate_cdr_eidle),
        .hssi_8g_rx_pcs_clock_gate_dw_pc_wrclk (hssi_8g_rx_pcs_clock_gate_dw_pc_wrclk),
        .hssi_8g_rx_pcs_clock_gate_dw_rm_rd (hssi_8g_rx_pcs_clock_gate_dw_rm_rd),
        .hssi_8g_rx_pcs_clock_gate_dw_rm_wr (hssi_8g_rx_pcs_clock_gate_dw_rm_wr),
        .hssi_8g_rx_pcs_clock_gate_dw_wa (hssi_8g_rx_pcs_clock_gate_dw_wa),
        .hssi_8g_rx_pcs_clock_gate_pc_rdclk (hssi_8g_rx_pcs_clock_gate_pc_rdclk),
        .hssi_8g_rx_pcs_clock_gate_sw_pc_wrclk (hssi_8g_rx_pcs_clock_gate_sw_pc_wrclk),
        .hssi_8g_rx_pcs_clock_gate_sw_rm_rd (hssi_8g_rx_pcs_clock_gate_sw_rm_rd),
        .hssi_8g_rx_pcs_clock_gate_sw_rm_wr (hssi_8g_rx_pcs_clock_gate_sw_rm_wr),
        .hssi_8g_rx_pcs_clock_gate_sw_wa (hssi_8g_rx_pcs_clock_gate_sw_wa),
        .hssi_8g_rx_pcs_clock_observation_in_pld_core (hssi_8g_rx_pcs_clock_observation_in_pld_core),
        .hssi_8g_rx_pcs_eidle_entry_eios (hssi_8g_rx_pcs_eidle_entry_eios),
        .hssi_8g_rx_pcs_eidle_entry_iei (hssi_8g_rx_pcs_eidle_entry_iei),
        .hssi_8g_rx_pcs_eidle_entry_sd (hssi_8g_rx_pcs_eidle_entry_sd),
        .hssi_8g_rx_pcs_eightb_tenb_decoder (hssi_8g_rx_pcs_eightb_tenb_decoder),
        .hssi_8g_rx_pcs_err_flags_sel (hssi_8g_rx_pcs_err_flags_sel),
        .hssi_8g_rx_pcs_fixed_pat_det (hssi_8g_rx_pcs_fixed_pat_det),
        .hssi_8g_rx_pcs_fixed_pat_num (hssi_8g_rx_pcs_fixed_pat_num),
        .hssi_8g_rx_pcs_force_signal_detect (hssi_8g_rx_pcs_force_signal_detect),
        .hssi_8g_rx_pcs_gen3_clk_en (hssi_8g_rx_pcs_gen3_clk_en),
        .hssi_8g_rx_pcs_gen3_rx_clk_sel (hssi_8g_rx_pcs_gen3_rx_clk_sel),
        .hssi_8g_rx_pcs_gen3_tx_clk_sel (hssi_8g_rx_pcs_gen3_tx_clk_sel),
        .hssi_8g_rx_pcs_hip_mode (hssi_8g_rx_pcs_hip_mode),
        .hssi_8g_rx_pcs_ibm_invalid_code (hssi_8g_rx_pcs_ibm_invalid_code),
        .hssi_8g_rx_pcs_invalid_code_flag_only (hssi_8g_rx_pcs_invalid_code_flag_only),
        .hssi_8g_rx_pcs_pad_or_edb_error_replace (hssi_8g_rx_pcs_pad_or_edb_error_replace),
        .hssi_8g_rx_pcs_pcs_bypass (hssi_8g_rx_pcs_pcs_bypass),
        .hssi_8g_rx_pcs_phase_comp_rdptr (hssi_8g_rx_pcs_phase_comp_rdptr),
        .hssi_8g_rx_pcs_phase_compensation_fifo (hssi_8g_rx_pcs_phase_compensation_fifo),
        .hssi_8g_rx_pcs_pipe_if_enable (hssi_8g_rx_pcs_pipe_if_enable),
        .hssi_8g_rx_pcs_pma_dw (hssi_8g_rx_pcs_pma_dw),
        .hssi_8g_rx_pcs_polinv_8b10b_dec (hssi_8g_rx_pcs_polinv_8b10b_dec),
        .hssi_8g_rx_pcs_rate_match (hssi_8g_rx_pcs_rate_match),
        .hssi_8g_rx_pcs_rate_match_del_thres (hssi_8g_rx_pcs_rate_match_del_thres),
        .hssi_8g_rx_pcs_rate_match_empty_thres (hssi_8g_rx_pcs_rate_match_empty_thres),
        .hssi_8g_rx_pcs_rate_match_full_thres (hssi_8g_rx_pcs_rate_match_full_thres),
        .hssi_8g_rx_pcs_rate_match_ins_thres (hssi_8g_rx_pcs_rate_match_ins_thres),
        .hssi_8g_rx_pcs_rate_match_start_thres (hssi_8g_rx_pcs_rate_match_start_thres),
        .hssi_8g_rx_pcs_rx_clk2 (hssi_8g_rx_pcs_rx_clk2),
        .hssi_8g_rx_pcs_rx_clk_free_running (hssi_8g_rx_pcs_rx_clk_free_running),
        .hssi_8g_rx_pcs_rx_pcs_urst (hssi_8g_rx_pcs_rx_pcs_urst),
        .hssi_8g_rx_pcs_rx_rcvd_clk (hssi_8g_rx_pcs_rx_rcvd_clk),
        .hssi_8g_rx_pcs_rx_rd_clk (hssi_8g_rx_pcs_rx_rd_clk),
        .hssi_8g_rx_pcs_rx_refclk (hssi_8g_rx_pcs_rx_refclk),
        .hssi_8g_rx_pcs_rx_wr_clk (hssi_8g_rx_pcs_rx_wr_clk),
        .hssi_8g_rx_pcs_symbol_swap (hssi_8g_rx_pcs_symbol_swap),
        .hssi_8g_rx_pcs_sync_sm_idle_eios (hssi_8g_rx_pcs_sync_sm_idle_eios),
        .hssi_8g_rx_pcs_test_bus_sel (hssi_8g_rx_pcs_test_bus_sel),
        .hssi_8g_rx_pcs_tx_rx_parallel_loopback (hssi_8g_rx_pcs_tx_rx_parallel_loopback),
        .hssi_8g_rx_pcs_wa_boundary_lock_ctrl (hssi_8g_rx_pcs_wa_boundary_lock_ctrl),
        .hssi_8g_rx_pcs_wa_clk_slip_spacing (hssi_8g_rx_pcs_wa_clk_slip_spacing),
        .hssi_8g_rx_pcs_wa_det_latency_sync_status_beh (hssi_8g_rx_pcs_wa_det_latency_sync_status_beh),
        .hssi_8g_rx_pcs_wa_disp_err_flag (hssi_8g_rx_pcs_wa_disp_err_flag),
        .hssi_8g_rx_pcs_wa_kchar (hssi_8g_rx_pcs_wa_kchar),
        .hssi_8g_rx_pcs_wa_pd (hssi_8g_rx_pcs_wa_pd),
        .hssi_8g_rx_pcs_wa_pd_data (lcl_hssi_8g_rx_pcs_wa_pd_data),
        .hssi_8g_rx_pcs_wa_pd_polarity (hssi_8g_rx_pcs_wa_pd_polarity),
        .hssi_8g_rx_pcs_wa_pld_controlled (hssi_8g_rx_pcs_wa_pld_controlled),
        .hssi_8g_rx_pcs_wa_renumber_data (hssi_8g_rx_pcs_wa_renumber_data),
        .hssi_8g_rx_pcs_wa_rgnumber_data (hssi_8g_rx_pcs_wa_rgnumber_data),
        .hssi_8g_rx_pcs_wa_rknumber_data (hssi_8g_rx_pcs_wa_rknumber_data),
        .hssi_8g_rx_pcs_wa_rosnumber_data (hssi_8g_rx_pcs_wa_rosnumber_data),
        .hssi_8g_rx_pcs_wa_rvnumber_data (hssi_8g_rx_pcs_wa_rvnumber_data),
        .hssi_8g_rx_pcs_wa_sync_sm_ctrl (hssi_8g_rx_pcs_wa_sync_sm_ctrl),
        .hssi_8g_rx_pcs_wait_cnt (hssi_8g_rx_pcs_wait_cnt),
    // parameters for twentynm_hssi_8g_tx_pcs
        .hssi_8g_tx_pcs_bit_reversal (hssi_8g_tx_pcs_bit_reversal),
        .hssi_8g_tx_pcs_bonding_dft_en (hssi_8g_tx_pcs_bonding_dft_en),
        .hssi_8g_tx_pcs_bonding_dft_val (hssi_8g_tx_pcs_bonding_dft_val),
        .hssi_8g_tx_pcs_bypass_pipeline_reg (hssi_8g_tx_pcs_bypass_pipeline_reg),
        .hssi_8g_tx_pcs_byte_serializer (hssi_8g_tx_pcs_byte_serializer),
        .hssi_8g_tx_pcs_clock_gate_bs_enc (hssi_8g_tx_pcs_clock_gate_bs_enc),
        .hssi_8g_tx_pcs_clock_gate_dw_fifowr (hssi_8g_tx_pcs_clock_gate_dw_fifowr),
        .hssi_8g_tx_pcs_clock_gate_fiford (hssi_8g_tx_pcs_clock_gate_fiford),
        .hssi_8g_tx_pcs_clock_gate_sw_fifowr (hssi_8g_tx_pcs_clock_gate_sw_fifowr),
        .hssi_8g_tx_pcs_clock_observation_in_pld_core (hssi_8g_tx_pcs_clock_observation_in_pld_core),
        .hssi_8g_tx_pcs_data_selection_8b10b_encoder_input (hssi_8g_tx_pcs_data_selection_8b10b_encoder_input),
        .hssi_8g_tx_pcs_dynamic_clk_switch (hssi_8g_tx_pcs_dynamic_clk_switch),
        .hssi_8g_tx_pcs_eightb_tenb_disp_ctrl (hssi_8g_tx_pcs_eightb_tenb_disp_ctrl),
        .hssi_8g_tx_pcs_eightb_tenb_encoder (hssi_8g_tx_pcs_eightb_tenb_encoder),
        .hssi_8g_tx_pcs_force_echar (hssi_8g_tx_pcs_force_echar),
        .hssi_8g_tx_pcs_force_kchar (hssi_8g_tx_pcs_force_kchar),
        .hssi_8g_tx_pcs_gen3_tx_clk_sel (hssi_8g_tx_pcs_gen3_tx_clk_sel),
        .hssi_8g_tx_pcs_gen3_tx_pipe_clk_sel (hssi_8g_tx_pcs_gen3_tx_pipe_clk_sel),
        .hssi_8g_tx_pcs_hip_mode (hssi_8g_tx_pcs_hip_mode),
        .hssi_8g_tx_pcs_pcs_bypass (hssi_8g_tx_pcs_pcs_bypass),
        .hssi_8g_tx_pcs_phase_comp_rdptr (hssi_8g_tx_pcs_phase_comp_rdptr),
        .hssi_8g_tx_pcs_phase_compensation_fifo (hssi_8g_tx_pcs_phase_compensation_fifo),
        .hssi_8g_tx_pcs_phfifo_write_clk_sel (hssi_8g_tx_pcs_phfifo_write_clk_sel),
        .hssi_8g_tx_pcs_pma_dw (hssi_8g_tx_pcs_pma_dw),
        .hssi_8g_tx_pcs_refclk_b_clk_sel (hssi_8g_tx_pcs_refclk_b_clk_sel),
        .hssi_8g_tx_pcs_revloop_back_rm (hssi_8g_tx_pcs_revloop_back_rm),
        .hssi_8g_tx_pcs_symbol_swap (hssi_8g_tx_pcs_symbol_swap),
        .hssi_8g_tx_pcs_tx_bitslip (hssi_8g_tx_pcs_tx_bitslip),
        .hssi_8g_tx_pcs_tx_compliance_controlled_disparity (hssi_8g_tx_pcs_tx_compliance_controlled_disparity),
        .hssi_8g_tx_pcs_tx_fast_pld_reg (hssi_8g_tx_pcs_tx_fast_pld_reg),
        .hssi_8g_tx_pcs_txclk_freerun (hssi_8g_tx_pcs_txclk_freerun),
        .hssi_8g_tx_pcs_txpcs_urst (hssi_8g_tx_pcs_txpcs_urst),
    // parameters for twentynm_hssi_common_pcs_pma_interface
        .hssi_common_pcs_pma_interface_asn_clk_enable (hssi_common_pcs_pma_interface_asn_clk_enable),
        .hssi_common_pcs_pma_interface_asn_enable (hssi_common_pcs_pma_interface_asn_enable),
        .hssi_common_pcs_pma_interface_block_sel (hssi_common_pcs_pma_interface_block_sel),
        .hssi_common_pcs_pma_interface_bypass_early_eios (hssi_common_pcs_pma_interface_bypass_early_eios),
        .hssi_common_pcs_pma_interface_bypass_pcie_switch (hssi_common_pcs_pma_interface_bypass_pcie_switch),
        .hssi_common_pcs_pma_interface_bypass_pma_ltr (hssi_common_pcs_pma_interface_bypass_pma_ltr),
        .hssi_common_pcs_pma_interface_bypass_pma_sw_done (lcl_hssi_common_pcs_pma_interface_bypass_pma_sw_done),
        .hssi_common_pcs_pma_interface_bypass_ppm_lock (hssi_common_pcs_pma_interface_bypass_ppm_lock),
        .hssi_common_pcs_pma_interface_bypass_send_syncp_fbkp (hssi_common_pcs_pma_interface_bypass_send_syncp_fbkp),
        .hssi_common_pcs_pma_interface_bypass_txdetectrx (hssi_common_pcs_pma_interface_bypass_txdetectrx),
        .hssi_common_pcs_pma_interface_cdr_control (hssi_common_pcs_pma_interface_cdr_control),
        .hssi_common_pcs_pma_interface_cid_enable (hssi_common_pcs_pma_interface_cid_enable),
        .hssi_common_pcs_pma_interface_data_mask_count (hssi_common_pcs_pma_interface_data_mask_count),
        .hssi_common_pcs_pma_interface_data_mask_count_multi (hssi_common_pcs_pma_interface_data_mask_count_multi),
        .hssi_common_pcs_pma_interface_dft_observation_clock_selection (hssi_common_pcs_pma_interface_dft_observation_clock_selection),
        .hssi_common_pcs_pma_interface_early_eios_counter (hssi_common_pcs_pma_interface_early_eios_counter),
        .hssi_common_pcs_pma_interface_force_freqdet (hssi_common_pcs_pma_interface_force_freqdet),
        .hssi_common_pcs_pma_interface_free_run_clk_enable (hssi_common_pcs_pma_interface_free_run_clk_enable),
        .hssi_common_pcs_pma_interface_ignore_sigdet_g23 (hssi_common_pcs_pma_interface_ignore_sigdet_g23),
        .hssi_common_pcs_pma_interface_pc_en_counter (hssi_common_pcs_pma_interface_pc_en_counter),
        .hssi_common_pcs_pma_interface_pc_rst_counter (hssi_common_pcs_pma_interface_pc_rst_counter),
        .hssi_common_pcs_pma_interface_pcie_hip_mode (hssi_common_pcs_pma_interface_pcie_hip_mode),
        .hssi_common_pcs_pma_interface_ph_fifo_reg_mode (hssi_common_pcs_pma_interface_ph_fifo_reg_mode),
        .hssi_common_pcs_pma_interface_phfifo_flush_wait (hssi_common_pcs_pma_interface_phfifo_flush_wait),
        .hssi_common_pcs_pma_interface_pipe_if_g3pcs (hssi_common_pcs_pma_interface_pipe_if_g3pcs),
        .hssi_common_pcs_pma_interface_pma_done_counter (hssi_common_pcs_pma_interface_pma_done_counter),
        .hssi_common_pcs_pma_interface_pma_if_dft_en (hssi_common_pcs_pma_interface_pma_if_dft_en),
        .hssi_common_pcs_pma_interface_pma_if_dft_val (hssi_common_pcs_pma_interface_pma_if_dft_val),
        .hssi_common_pcs_pma_interface_ppm_cnt_rst (hssi_common_pcs_pma_interface_ppm_cnt_rst),
        .hssi_common_pcs_pma_interface_ppm_deassert_early (hssi_common_pcs_pma_interface_ppm_deassert_early),
        .hssi_common_pcs_pma_interface_ppm_gen1_2_cnt (hssi_common_pcs_pma_interface_ppm_gen1_2_cnt),
        .hssi_common_pcs_pma_interface_ppm_post_eidle_delay (hssi_common_pcs_pma_interface_ppm_post_eidle_delay),
        .hssi_common_pcs_pma_interface_ppmsel (hssi_common_pcs_pma_interface_ppmsel),
        .hssi_common_pcs_pma_interface_rxvalid_mask (hssi_common_pcs_pma_interface_rxvalid_mask),
        .hssi_common_pcs_pma_interface_sigdet_wait_counter (hssi_common_pcs_pma_interface_sigdet_wait_counter),
        .hssi_common_pcs_pma_interface_sigdet_wait_counter_multi (hssi_common_pcs_pma_interface_sigdet_wait_counter_multi),
        .hssi_common_pcs_pma_interface_sim_mode (hssi_common_pcs_pma_interface_sim_mode),
        .hssi_common_pcs_pma_interface_spd_chg_rst_wait_cnt_en (hssi_common_pcs_pma_interface_spd_chg_rst_wait_cnt_en),
        .hssi_common_pcs_pma_interface_testout_sel (hssi_common_pcs_pma_interface_testout_sel),
        .hssi_common_pcs_pma_interface_wait_clk_on_off_timer (hssi_common_pcs_pma_interface_wait_clk_on_off_timer),
        .hssi_common_pcs_pma_interface_wait_pipe_synchronizing (hssi_common_pcs_pma_interface_wait_pipe_synchronizing),
        .hssi_common_pcs_pma_interface_wait_send_syncp_fbkp (hssi_common_pcs_pma_interface_wait_send_syncp_fbkp),
        .hssi_common_pcs_pma_interface_ppm_det_buckets(hssi_common_pcs_pma_interface_ppm_det_buckets),
    // parameters for twentynm_hssi_common_pld_pcs_interface
        .hssi_common_pld_pcs_interface_dft_clk_out_en (hssi_common_pld_pcs_interface_dft_clk_out_en),
        .hssi_common_pld_pcs_interface_dft_clk_out_sel (hssi_common_pld_pcs_interface_dft_clk_out_sel),
        .hssi_common_pld_pcs_interface_hrdrstctrl_en (hssi_common_pld_pcs_interface_hrdrstctrl_en),
        .hssi_common_pld_pcs_interface_pcs_testbus_block_sel (hssi_common_pld_pcs_interface_pcs_testbus_block_sel),
    // parameters for twentynm_hssi_fifo_rx_pcs
        .hssi_fifo_rx_pcs_double_read_mode (hssi_fifo_rx_pcs_double_read_mode),
    // parameters for twentynm_hssi_fifo_tx_pcs
        .hssi_fifo_tx_pcs_double_write_mode (hssi_fifo_tx_pcs_double_write_mode),
    // parameters for twentynm_hssi_gen3_rx_pcs
        .hssi_gen3_rx_pcs_block_sync (hssi_gen3_rx_pcs_block_sync),
        .hssi_gen3_rx_pcs_block_sync_sm (hssi_gen3_rx_pcs_block_sync_sm),
        .hssi_gen3_rx_pcs_cdr_ctrl_force_unalgn (hssi_gen3_rx_pcs_cdr_ctrl_force_unalgn),
        .hssi_gen3_rx_pcs_lpbk_force (hssi_gen3_rx_pcs_lpbk_force),
        .hssi_gen3_rx_pcs_mode (hssi_gen3_rx_pcs_mode),
        .hssi_gen3_rx_pcs_rate_match_fifo (hssi_gen3_rx_pcs_rate_match_fifo),
        .hssi_gen3_rx_pcs_rate_match_fifo_latency (hssi_gen3_rx_pcs_rate_match_fifo_latency),
        .hssi_gen3_rx_pcs_reverse_lpbk (hssi_gen3_rx_pcs_reverse_lpbk),
        .hssi_gen3_rx_pcs_rx_b4gb_par_lpbk (hssi_gen3_rx_pcs_rx_b4gb_par_lpbk),
        .hssi_gen3_rx_pcs_rx_force_balign (hssi_gen3_rx_pcs_rx_force_balign),
        .hssi_gen3_rx_pcs_rx_ins_del_one_skip (hssi_gen3_rx_pcs_rx_ins_del_one_skip),
        .hssi_gen3_rx_pcs_rx_num_fixed_pat (hssi_gen3_rx_pcs_rx_num_fixed_pat),
        .hssi_gen3_rx_pcs_rx_test_out_sel (hssi_gen3_rx_pcs_rx_test_out_sel),
    // parameters for twentynm_hssi_gen3_tx_pcs
        .hssi_gen3_tx_pcs_mode (hssi_gen3_tx_pcs_mode),
        .hssi_gen3_tx_pcs_reverse_lpbk (hssi_gen3_tx_pcs_reverse_lpbk),
        .hssi_gen3_tx_pcs_tx_bitslip (hssi_gen3_tx_pcs_tx_bitslip),
        .hssi_gen3_tx_pcs_tx_gbox_byp (hssi_gen3_tx_pcs_tx_gbox_byp),
    // parameters for twentynm_hssi_krfec_rx_pcs
        .hssi_krfec_rx_pcs_blksync_cor_en (hssi_krfec_rx_pcs_blksync_cor_en),
        .hssi_krfec_rx_pcs_bypass_gb (hssi_krfec_rx_pcs_bypass_gb),
        .hssi_krfec_rx_pcs_clr_ctrl (hssi_krfec_rx_pcs_clr_ctrl),
        .hssi_krfec_rx_pcs_ctrl_bit_reverse (hssi_krfec_rx_pcs_ctrl_bit_reverse),
        .hssi_krfec_rx_pcs_data_bit_reverse (hssi_krfec_rx_pcs_data_bit_reverse),
        .hssi_krfec_rx_pcs_dv_start (hssi_krfec_rx_pcs_dv_start),
        .hssi_krfec_rx_pcs_err_mark_type (hssi_krfec_rx_pcs_err_mark_type),
        .hssi_krfec_rx_pcs_error_marking_en (hssi_krfec_rx_pcs_error_marking_en),
        .hssi_krfec_rx_pcs_low_latency_en (hssi_krfec_rx_pcs_low_latency_en),
        .hssi_krfec_rx_pcs_lpbk_mode (hssi_krfec_rx_pcs_lpbk_mode),
        .hssi_krfec_rx_pcs_parity_invalid_enum (hssi_krfec_rx_pcs_parity_invalid_enum),
        .hssi_krfec_rx_pcs_parity_valid_num (hssi_krfec_rx_pcs_parity_valid_num),
        .hssi_krfec_rx_pcs_pipeln_blksync (hssi_krfec_rx_pcs_pipeln_blksync),
        .hssi_krfec_rx_pcs_pipeln_descrm (hssi_krfec_rx_pcs_pipeln_descrm),
        .hssi_krfec_rx_pcs_pipeln_errcorrect (hssi_krfec_rx_pcs_pipeln_errcorrect),
        .hssi_krfec_rx_pcs_pipeln_errtrap_ind (hssi_krfec_rx_pcs_pipeln_errtrap_ind),
        .hssi_krfec_rx_pcs_pipeln_errtrap_lfsr (hssi_krfec_rx_pcs_pipeln_errtrap_lfsr),
        .hssi_krfec_rx_pcs_pipeln_errtrap_loc (hssi_krfec_rx_pcs_pipeln_errtrap_loc),
        .hssi_krfec_rx_pcs_pipeln_errtrap_pat (hssi_krfec_rx_pcs_pipeln_errtrap_pat),
        .hssi_krfec_rx_pcs_pipeln_gearbox (hssi_krfec_rx_pcs_pipeln_gearbox),
        .hssi_krfec_rx_pcs_pipeln_syndrm (hssi_krfec_rx_pcs_pipeln_syndrm),
        .hssi_krfec_rx_pcs_pipeln_trans_dec (hssi_krfec_rx_pcs_pipeln_trans_dec),
        .hssi_krfec_rx_pcs_receive_order (hssi_krfec_rx_pcs_receive_order),
        .hssi_krfec_rx_pcs_rx_testbus_sel (hssi_krfec_rx_pcs_rx_testbus_sel),
        .hssi_krfec_rx_pcs_signal_ok_en (hssi_krfec_rx_pcs_signal_ok_en),
    // parameters for twentynm_hssi_krfec_tx_pcs
        .hssi_krfec_tx_pcs_burst_err (hssi_krfec_tx_pcs_burst_err),
        .hssi_krfec_tx_pcs_burst_err_len (hssi_krfec_tx_pcs_burst_err_len),
        .hssi_krfec_tx_pcs_ctrl_bit_reverse (hssi_krfec_tx_pcs_ctrl_bit_reverse),
        .hssi_krfec_tx_pcs_data_bit_reverse (hssi_krfec_tx_pcs_data_bit_reverse),
        .hssi_krfec_tx_pcs_enc_frame_query (hssi_krfec_tx_pcs_enc_frame_query),
        .hssi_krfec_tx_pcs_low_latency_en (hssi_krfec_tx_pcs_low_latency_en),
        .hssi_krfec_tx_pcs_pipeln_encoder (hssi_krfec_tx_pcs_pipeln_encoder),
        .hssi_krfec_tx_pcs_pipeln_scrambler (hssi_krfec_tx_pcs_pipeln_scrambler),
        .hssi_krfec_tx_pcs_transcode_err (hssi_krfec_tx_pcs_transcode_err),
        .hssi_krfec_tx_pcs_transmit_order (hssi_krfec_tx_pcs_transmit_order),
        .hssi_krfec_tx_pcs_tx_testbus_sel (hssi_krfec_tx_pcs_tx_testbus_sel),
    // parameters for twentynm_hssi_pipe_gen1_2
        .hssi_pipe_gen1_2_elec_idle_delay_val (hssi_pipe_gen1_2_elec_idle_delay_val),
        .hssi_pipe_gen1_2_error_replace_pad (hssi_pipe_gen1_2_error_replace_pad),
        .hssi_pipe_gen1_2_hip_mode (hssi_pipe_gen1_2_hip_mode),
        .hssi_pipe_gen1_2_ind_error_reporting (hssi_pipe_gen1_2_ind_error_reporting),
        .hssi_pipe_gen1_2_phystatus_delay_val (hssi_pipe_gen1_2_phystatus_delay_val),
        .hssi_pipe_gen1_2_phystatus_rst_toggle (hssi_pipe_gen1_2_phystatus_rst_toggle),
        .hssi_pipe_gen1_2_pipe_byte_de_serializer_en (hssi_pipe_gen1_2_pipe_byte_de_serializer_en),
        .hssi_pipe_gen1_2_rx_pipe_enable (hssi_pipe_gen1_2_rx_pipe_enable),
        .hssi_pipe_gen1_2_rxdetect_bypass (hssi_pipe_gen1_2_rxdetect_bypass),
        .hssi_pipe_gen1_2_tx_pipe_enable (hssi_pipe_gen1_2_tx_pipe_enable),
        .hssi_pipe_gen1_2_txswing (hssi_pipe_gen1_2_txswing),
    // parameters for twentynm_hssi_pipe_gen3
        .hssi_pipe_gen3_bypass_rx_detection_enable (hssi_pipe_gen3_bypass_rx_detection_enable),
        .hssi_pipe_gen3_bypass_rx_preset (hssi_pipe_gen3_bypass_rx_preset),
        .hssi_pipe_gen3_bypass_rx_preset_enable (hssi_pipe_gen3_bypass_rx_preset_enable),
        .hssi_pipe_gen3_bypass_tx_coefficent (hssi_pipe_gen3_bypass_tx_coefficent),
        .hssi_pipe_gen3_bypass_tx_coefficent_enable (hssi_pipe_gen3_bypass_tx_coefficent_enable),
        .hssi_pipe_gen3_elecidle_delay_g3 (hssi_pipe_gen3_elecidle_delay_g3),
        .hssi_pipe_gen3_ind_error_reporting (hssi_pipe_gen3_ind_error_reporting),
        .hssi_pipe_gen3_mode (hssi_pipe_gen3_mode),
        .hssi_pipe_gen3_phy_status_delay_g12 (hssi_pipe_gen3_phy_status_delay_g12),
        .hssi_pipe_gen3_phy_status_delay_g3 (hssi_pipe_gen3_phy_status_delay_g3),
        .hssi_pipe_gen3_phystatus_rst_toggle_g12 (hssi_pipe_gen3_phystatus_rst_toggle_g12),
        .hssi_pipe_gen3_phystatus_rst_toggle_g3 (hssi_pipe_gen3_phystatus_rst_toggle_g3),
        .hssi_pipe_gen3_rate_match_pad_insertion (hssi_pipe_gen3_rate_match_pad_insertion),
        .hssi_pipe_gen3_test_out_sel (hssi_pipe_gen3_test_out_sel),
    // parameters for twentynm_hssi_rx_pcs_pma_interface
        .hssi_rx_pcs_pma_interface_block_sel (hssi_rx_pcs_pma_interface_block_sel),
        .hssi_rx_pcs_pma_interface_channel_operation_mode (hssi_rx_pcs_pma_interface_channel_operation_mode),
        .hssi_rx_pcs_pma_interface_clkslip_sel (hssi_rx_pcs_pma_interface_clkslip_sel),
        .hssi_rx_pcs_pma_interface_lpbk_en (hssi_rx_pcs_pma_interface_lpbk_en),
        .hssi_rx_pcs_pma_interface_master_clk_sel (hssi_rx_pcs_pma_interface_master_clk_sel),
        .hssi_rx_pcs_pma_interface_pldif_datawidth_mode (hssi_rx_pcs_pma_interface_pldif_datawidth_mode),
        .hssi_rx_pcs_pma_interface_pma_dw_rx (hssi_rx_pcs_pma_interface_pma_dw_rx),
        .hssi_rx_pcs_pma_interface_pma_if_dft_en (hssi_rx_pcs_pma_interface_pma_if_dft_en),
        .hssi_rx_pcs_pma_interface_pma_if_dft_val (hssi_rx_pcs_pma_interface_pma_if_dft_val),
        .hssi_rx_pcs_pma_interface_prbs9_dwidth (hssi_rx_pcs_pma_interface_prbs9_dwidth),
        .hssi_rx_pcs_pma_interface_prbs_clken (hssi_rx_pcs_pma_interface_prbs_clken),
        .hssi_rx_pcs_pma_interface_prbs_ver (hssi_rx_pcs_pma_interface_prbs_ver),
        .hssi_rx_pcs_pma_interface_rx_dyn_polarity_inversion (hssi_rx_pcs_pma_interface_rx_dyn_polarity_inversion),
        .hssi_rx_pcs_pma_interface_rx_lpbk_en (hssi_rx_pcs_pma_interface_rx_lpbk_en),
        .hssi_rx_pcs_pma_interface_rx_prbs_force_signal_ok (hssi_rx_pcs_pma_interface_rx_prbs_force_signal_ok),
        .hssi_rx_pcs_pma_interface_rx_prbs_mask (hssi_rx_pcs_pma_interface_rx_prbs_mask),
        .hssi_rx_pcs_pma_interface_rx_prbs_mode (hssi_rx_pcs_pma_interface_rx_prbs_mode),
        .hssi_rx_pcs_pma_interface_rx_signalok_signaldet_sel (hssi_rx_pcs_pma_interface_rx_signalok_signaldet_sel),
        .hssi_rx_pcs_pma_interface_rx_static_polarity_inversion (hssi_rx_pcs_pma_interface_rx_static_polarity_inversion),
        .hssi_rx_pcs_pma_interface_rx_uhsif_lpbk_en (hssi_rx_pcs_pma_interface_rx_uhsif_lpbk_en),
    // parameters for twentynm_hssi_rx_pld_pcs_interface
        .hssi_rx_pld_pcs_interface_pcs_rx_block_sel (hssi_rx_pld_pcs_interface_pcs_rx_block_sel),
        .hssi_rx_pld_pcs_interface_pcs_rx_clk_sel (hssi_rx_pld_pcs_interface_pcs_rx_clk_sel),
        .hssi_rx_pld_pcs_interface_pcs_rx_hip_clk_en (hssi_rx_pld_pcs_interface_pcs_rx_hip_clk_en),
        .hssi_rx_pld_pcs_interface_pcs_rx_output_sel (hssi_rx_pld_pcs_interface_pcs_rx_output_sel),
        .hssi_rx_pld_pcs_interface_pcs_rx_clk_out_sel (hssi_rx_pld_pcs_interface_pcs_rx_clk_out_sel),
    // parameters for twentynm_hssi_tx_pcs_pma_interface
        .hssi_tx_pcs_pma_interface_bypass_pma_txelecidle (hssi_tx_pcs_pma_interface_bypass_pma_txelecidle),
        .hssi_tx_pcs_pma_interface_channel_operation_mode (hssi_tx_pcs_pma_interface_channel_operation_mode),
        .hssi_tx_pcs_pma_interface_lpbk_en (hssi_tx_pcs_pma_interface_lpbk_en),
        .hssi_tx_pcs_pma_interface_master_clk_sel (hssi_tx_pcs_pma_interface_master_clk_sel),
        .hssi_tx_pcs_pma_interface_pldif_datawidth_mode (hssi_tx_pcs_pma_interface_pldif_datawidth_mode),
        .hssi_tx_pcs_pma_interface_pma_dw_tx (hssi_tx_pcs_pma_interface_pma_dw_tx),
        .hssi_tx_pcs_pma_interface_pmagate_en (hssi_tx_pcs_pma_interface_pmagate_en),
        .hssi_tx_pcs_pma_interface_prbs9_dwidth (hssi_tx_pcs_pma_interface_prbs9_dwidth),
        .hssi_tx_pcs_pma_interface_prbs_clken (hssi_tx_pcs_pma_interface_prbs_clken),
        .hssi_tx_pcs_pma_interface_prbs_gen_pat (hssi_tx_pcs_pma_interface_prbs_gen_pat),
        .hssi_tx_pcs_pma_interface_sq_wave_num (hssi_tx_pcs_pma_interface_sq_wave_num),
        .hssi_tx_pcs_pma_interface_sqwgen_clken (hssi_tx_pcs_pma_interface_sqwgen_clken),
        .hssi_tx_pcs_pma_interface_tx_dyn_polarity_inversion (hssi_tx_pcs_pma_interface_tx_dyn_polarity_inversion),
        .hssi_tx_pcs_pma_interface_tx_pma_data_sel (hssi_tx_pcs_pma_interface_tx_pma_data_sel),
        .hssi_tx_pcs_pma_interface_tx_static_polarity_inversion (hssi_tx_pcs_pma_interface_tx_static_polarity_inversion),
        .hssi_tx_pcs_pma_interface_pma_if_dft_en (hssi_tx_pcs_pma_interface_pma_if_dft_en),
        .hssi_tx_pcs_pma_interface_uhsif_cnt_step_filt_before_lock (hssi_tx_pcs_pma_interface_uhsif_cnt_step_filt_before_lock),
        .hssi_tx_pcs_pma_interface_uhsif_cnt_thresh_filt_after_lock_value (hssi_tx_pcs_pma_interface_uhsif_cnt_thresh_filt_after_lock_value),
        .hssi_tx_pcs_pma_interface_uhsif_cnt_thresh_filt_before_lock (hssi_tx_pcs_pma_interface_uhsif_cnt_thresh_filt_before_lock),
        .hssi_tx_pcs_pma_interface_uhsif_dcn_test_update_period (hssi_tx_pcs_pma_interface_uhsif_dcn_test_update_period),
        .hssi_tx_pcs_pma_interface_uhsif_dcn_testmode_enable (hssi_tx_pcs_pma_interface_uhsif_dcn_testmode_enable),
        .hssi_tx_pcs_pma_interface_uhsif_dead_zone_count_thresh (hssi_tx_pcs_pma_interface_uhsif_dead_zone_count_thresh),
        .hssi_tx_pcs_pma_interface_uhsif_dead_zone_detection_enable (hssi_tx_pcs_pma_interface_uhsif_dead_zone_detection_enable),
        .hssi_tx_pcs_pma_interface_uhsif_dead_zone_obser_window (hssi_tx_pcs_pma_interface_uhsif_dead_zone_obser_window),
        .hssi_tx_pcs_pma_interface_uhsif_dead_zone_skip_size (hssi_tx_pcs_pma_interface_uhsif_dead_zone_skip_size),
        .hssi_tx_pcs_pma_interface_uhsif_delay_cell_index_sel (hssi_tx_pcs_pma_interface_uhsif_delay_cell_index_sel),
        .hssi_tx_pcs_pma_interface_uhsif_delay_cell_margin (hssi_tx_pcs_pma_interface_uhsif_delay_cell_margin),
        .hssi_tx_pcs_pma_interface_uhsif_delay_cell_static_index_value (hssi_tx_pcs_pma_interface_uhsif_delay_cell_static_index_value),
        .hssi_tx_pcs_pma_interface_uhsif_dft_dead_zone_control (hssi_tx_pcs_pma_interface_uhsif_dft_dead_zone_control),
        .hssi_tx_pcs_pma_interface_uhsif_dft_up_filt_control (hssi_tx_pcs_pma_interface_uhsif_dft_up_filt_control),
        .hssi_tx_pcs_pma_interface_uhsif_enable (hssi_tx_pcs_pma_interface_uhsif_enable),
        .hssi_tx_pcs_pma_interface_uhsif_lock_det_segsz_after_lock (hssi_tx_pcs_pma_interface_uhsif_lock_det_segsz_after_lock),
        .hssi_tx_pcs_pma_interface_uhsif_lock_det_segsz_before_lock (hssi_tx_pcs_pma_interface_uhsif_lock_det_segsz_before_lock),
        .hssi_tx_pcs_pma_interface_uhsif_lock_det_thresh_cnt_after_lock_value (hssi_tx_pcs_pma_interface_uhsif_lock_det_thresh_cnt_after_lock_value),
        .hssi_tx_pcs_pma_interface_uhsif_lock_det_thresh_cnt_before_lock_value (hssi_tx_pcs_pma_interface_uhsif_lock_det_thresh_cnt_before_lock_value),
        .hssi_tx_pcs_pma_interface_uhsif_lock_det_thresh_diff_after_lock_value (hssi_tx_pcs_pma_interface_uhsif_lock_det_thresh_diff_after_lock_value),
        .hssi_tx_pcs_pma_interface_uhsif_lock_det_thresh_diff_before_lock_value (hssi_tx_pcs_pma_interface_uhsif_lock_det_thresh_diff_before_lock_value),
    // parameters for twentynm_hssi_tx_pld_pcs_interface
        .hssi_tx_pld_pcs_interface_hd_10g_advanced_user_mode_tx (hssi_tx_pld_pcs_interface_hd_10g_advanced_user_mode_tx),
        .hssi_rx_pld_pcs_interface_hd_10g_advanced_user_mode_rx (hssi_rx_pld_pcs_interface_hd_10g_advanced_user_mode_rx),
        .hssi_rx_pld_pcs_interface_hd_chnl_transparent_pcs_rx (hssi_rx_pld_pcs_interface_hd_chnl_transparent_pcs_rx),
        .hssi_tx_pld_pcs_interface_pcs_tx_clk_out_sel (hssi_tx_pld_pcs_interface_pcs_tx_clk_out_sel),
        .hssi_tx_pld_pcs_interface_pcs_tx_clk_source (hssi_tx_pld_pcs_interface_pcs_tx_clk_source),
        .hssi_tx_pld_pcs_interface_pcs_tx_data_source (hssi_tx_pld_pcs_interface_pcs_tx_data_source),
        .hssi_tx_pld_pcs_interface_pcs_tx_delay1_clk_en (hssi_tx_pld_pcs_interface_pcs_tx_delay1_clk_en),
        .hssi_tx_pld_pcs_interface_pcs_tx_delay1_clk_sel (hssi_tx_pld_pcs_interface_pcs_tx_delay1_clk_sel),
        .hssi_tx_pld_pcs_interface_pcs_tx_delay1_ctrl (hssi_tx_pld_pcs_interface_pcs_tx_delay1_ctrl),
        .hssi_tx_pld_pcs_interface_pcs_tx_delay1_data_sel (hssi_tx_pld_pcs_interface_pcs_tx_delay1_data_sel),
        .hssi_tx_pld_pcs_interface_pcs_tx_delay2_clk_en (hssi_tx_pld_pcs_interface_pcs_tx_delay2_clk_en),
        .hssi_tx_pld_pcs_interface_pcs_tx_delay2_ctrl (hssi_tx_pld_pcs_interface_pcs_tx_delay2_ctrl),
        .hssi_tx_pld_pcs_interface_pcs_tx_output_sel (hssi_tx_pld_pcs_interface_pcs_tx_output_sel),
        .hssi_rx_pld_pcs_interface_hd_10g_lpbk_en (hssi_rx_pld_pcs_interface_hd_10g_lpbk_en),
        .hssi_rx_pld_pcs_interface_hd_chnl_frequency_rules_en (hssi_rx_pld_pcs_interface_hd_chnl_frequency_rules_en),
        .hssi_tx_pld_pcs_interface_hd_chnl_pma_tx_clk_hz (hssi_tx_pld_pcs_interface_hd_chnl_pma_tx_clk_hz),
        .hssi_tx_pld_pcs_interface_hd_chnl_shared_fifo_width_tx (hssi_tx_pld_pcs_interface_hd_chnl_shared_fifo_width_tx),
        .hssi_rx_pld_pcs_interface_hd_10g_pma_dw_rx (hssi_rx_pld_pcs_interface_hd_10g_pma_dw_rx),
        .hssi_tx_pld_pcs_interface_hd_fifo_channel_operation_mode (hssi_tx_pld_pcs_interface_hd_fifo_channel_operation_mode),
        .hssi_rx_pld_pcs_interface_hd_8g_lpbk_en (hssi_rx_pld_pcs_interface_hd_8g_lpbk_en),
        .hssi_rx_pld_pcs_interface_hd_chnl_func_mode (hssi_rx_pld_pcs_interface_hd_chnl_func_mode),
        .hssi_rx_pld_pcs_interface_hd_krfec_low_latency_en_rx (hssi_rx_pld_pcs_interface_hd_krfec_low_latency_en_rx),
        .hssi_tx_pld_pcs_interface_hd_krfec_low_latency_en_tx (hssi_tx_pld_pcs_interface_hd_krfec_low_latency_en_tx),
        .hssi_rx_pld_pcs_interface_hd_pldif_hrdrstctl_en (hssi_rx_pld_pcs_interface_hd_pldif_hrdrstctl_en),
        .hssi_tx_pld_pcs_interface_hd_pmaif_channel_operation_mode (hssi_tx_pld_pcs_interface_hd_pmaif_channel_operation_mode),
        .hssi_rx_pld_pcs_interface_hd_krfec_lpbk_en (hssi_rx_pld_pcs_interface_hd_krfec_lpbk_en),
        .hssi_tx_pld_pcs_interface_hd_8g_fifo_mode_tx (hssi_tx_pld_pcs_interface_hd_8g_fifo_mode_tx),
        .hssi_tx_pld_pcs_interface_hd_krfec_lpbk_en (hssi_tx_pld_pcs_interface_hd_krfec_lpbk_en),
        .hssi_tx_pld_pcs_interface_hd_pmaif_lpbk_en (hssi_tx_pld_pcs_interface_hd_pmaif_lpbk_en),
        .hssi_tx_pld_pcs_interface_hd_chnl_frequency_rules_en (hssi_tx_pld_pcs_interface_hd_chnl_frequency_rules_en),
        .hssi_tx_pld_pcs_interface_hd_chnl_lpbk_en (hssi_tx_pld_pcs_interface_hd_chnl_lpbk_en),
        .hssi_rx_pld_pcs_interface_hd_pmaif_sim_mode (hssi_rx_pld_pcs_interface_hd_pmaif_sim_mode),
        .hssi_rx_pld_pcs_interface_hd_chnl_pma_rx_clk_hz (hssi_rx_pld_pcs_interface_hd_chnl_pma_rx_clk_hz),
        .hssi_rx_pld_pcs_interface_hd_fifo_shared_fifo_width_rx (hssi_rx_pld_pcs_interface_hd_fifo_shared_fifo_width_rx),
        .hssi_tx_pld_pcs_interface_hd_chnl_channel_operation_mode (hssi_tx_pld_pcs_interface_hd_chnl_channel_operation_mode),
        .hssi_rx_pld_pcs_interface_hd_8g_pma_dw_rx (hssi_rx_pld_pcs_interface_hd_8g_pma_dw_rx),
        .hssi_rx_pld_pcs_interface_hd_chnl_pld_fifo_mode_rx (hssi_rx_pld_pcs_interface_hd_chnl_pld_fifo_mode_rx),
        .hssi_tx_pld_pcs_interface_hd_chnl_func_mode (hssi_tx_pld_pcs_interface_hd_chnl_func_mode),
        .hssi_rx_pld_pcs_interface_hd_krfec_test_bus_mode (hssi_rx_pld_pcs_interface_hd_krfec_test_bus_mode),
        .hssi_rx_pld_pcs_interface_hd_chnl_shared_fifo_width_rx (hssi_rx_pld_pcs_interface_hd_chnl_shared_fifo_width_rx),
        .hssi_rx_pld_pcs_interface_hd_krfec_channel_operation_mode (hssi_rx_pld_pcs_interface_hd_krfec_channel_operation_mode),
        .hssi_rx_pld_pcs_interface_hd_pmaif_pma_dw_rx (hssi_rx_pld_pcs_interface_hd_pmaif_pma_dw_rx),
        .hssi_tx_pld_pcs_interface_hd_10g_shared_fifo_width_tx (hssi_tx_pld_pcs_interface_hd_10g_shared_fifo_width_tx),
        .hssi_tx_pld_pcs_interface_hd_10g_fifo_mode_tx (hssi_tx_pld_pcs_interface_hd_10g_fifo_mode_tx),
        .hssi_tx_pld_pcs_interface_hd_pmaif_pma_dw_tx (hssi_tx_pld_pcs_interface_hd_pmaif_pma_dw_tx),
        .hssi_rx_pld_pcs_interface_hd_10g_test_bus_mode (hssi_rx_pld_pcs_interface_hd_10g_test_bus_mode),
        .hssi_rx_pld_pcs_interface_hd_10g_low_latency_en_rx (hssi_rx_pld_pcs_interface_hd_10g_low_latency_en_rx),
        .hssi_rx_pld_pcs_interface_hd_chnl_clklow_clk_hz (hssi_rx_pld_pcs_interface_hd_chnl_clklow_clk_hz),
        .hssi_tx_pld_pcs_interface_hd_pldif_hrdrstctl_en (hssi_tx_pld_pcs_interface_hd_pldif_hrdrstctl_en),
        .hssi_rx_pld_pcs_interface_hd_pmaif_lpbk_en (hssi_rx_pld_pcs_interface_hd_pmaif_lpbk_en),
        .hssi_tx_pld_pcs_interface_hd_pmaif_sim_mode (hssi_tx_pld_pcs_interface_hd_pmaif_sim_mode),
        .hssi_tx_pld_pcs_interface_hd_chnl_pld_uhsif_tx_clk_hz (hssi_tx_pld_pcs_interface_hd_chnl_pld_uhsif_tx_clk_hz),
        .hssi_rx_pld_pcs_interface_hd_8g_channel_operation_mode (hssi_rx_pld_pcs_interface_hd_8g_channel_operation_mode),
        .hssi_rx_pld_pcs_interface_hd_chnl_hrdrstctl_en (hssi_rx_pld_pcs_interface_hd_chnl_hrdrstctl_en),
        .hssi_rx_pld_pcs_interface_hd_chnl_fref_clk_hz (hssi_rx_pld_pcs_interface_hd_chnl_fref_clk_hz),
        .hssi_tx_pld_pcs_interface_hd_fifo_shared_fifo_width_tx (hssi_tx_pld_pcs_interface_hd_fifo_shared_fifo_width_tx),
        .hssi_tx_pld_pcs_interface_hd_chnl_pma_dw_tx (hssi_tx_pld_pcs_interface_hd_chnl_pma_dw_tx),
        .hssi_tx_pld_pcs_interface_hd_8g_hip_mode (hssi_tx_pld_pcs_interface_hd_8g_hip_mode),
        .hssi_tx_pld_pcs_interface_hd_8g_lpbk_en (hssi_tx_pld_pcs_interface_hd_8g_lpbk_en),
        .hssi_rx_pld_pcs_interface_hd_chnl_low_latency_en_rx (hssi_rx_pld_pcs_interface_hd_chnl_low_latency_en_rx),
        .hssi_tx_pld_pcs_interface_hd_chnl_pld_tx_clk_hz (hssi_tx_pld_pcs_interface_hd_chnl_pld_tx_clk_hz),
        .hssi_rx_pld_pcs_interface_hd_chnl_pld_rx_clk_hz (hssi_rx_pld_pcs_interface_hd_chnl_pld_rx_clk_hz),
        .hssi_tx_pld_pcs_interface_hd_10g_lpbk_en (hssi_tx_pld_pcs_interface_hd_10g_lpbk_en),
        .hssi_rx_pld_pcs_interface_hd_8g_fifo_mode_rx (hssi_rx_pld_pcs_interface_hd_8g_fifo_mode_rx),
        .hssi_tx_pld_pcs_interface_hd_10g_pma_dw_tx (hssi_tx_pld_pcs_interface_hd_10g_pma_dw_tx),
        .hssi_rx_pld_pcs_interface_hd_chnl_pma_dw_rx (hssi_rx_pld_pcs_interface_hd_chnl_pma_dw_rx),
        .hssi_tx_pld_pcs_interface_hd_chnl_pld_fifo_mode_tx (hssi_tx_pld_pcs_interface_hd_chnl_pld_fifo_mode_tx),
        .hssi_tx_pld_pcs_interface_hd_chnl_hrdrstctl_en (hssi_tx_pld_pcs_interface_hd_chnl_hrdrstctl_en),
        .hssi_rx_pld_pcs_interface_hd_10g_fifo_mode_rx (hssi_rx_pld_pcs_interface_hd_10g_fifo_mode_rx),
        .hssi_rx_pld_pcs_interface_hd_8g_hip_mode (hssi_rx_pld_pcs_interface_hd_8g_hip_mode),
        .hssi_tx_pld_pcs_interface_hd_chnl_low_latency_en_tx (hssi_tx_pld_pcs_interface_hd_chnl_low_latency_en_tx),
        .hssi_rx_pld_pcs_interface_hd_10g_channel_operation_mode (hssi_rx_pld_pcs_interface_hd_10g_channel_operation_mode),
        .hssi_tx_pld_pcs_interface_hd_chnl_hip_en (hssi_tx_pld_pcs_interface_hd_chnl_hip_en),
        .hssi_rx_pld_pcs_interface_hd_fifo_channel_operation_mode (hssi_rx_pld_pcs_interface_hd_fifo_channel_operation_mode),
        .hssi_tx_pld_pcs_interface_hd_8g_channel_operation_mode (hssi_tx_pld_pcs_interface_hd_8g_channel_operation_mode),
        .hssi_tx_pld_pcs_interface_hd_8g_pma_dw_tx (hssi_tx_pld_pcs_interface_hd_8g_pma_dw_tx),
        .hssi_rx_pld_pcs_interface_hd_chnl_lpbk_en (hssi_rx_pld_pcs_interface_hd_chnl_lpbk_en),
        .hssi_rx_pld_pcs_interface_hd_pmaif_channel_operation_mode (hssi_rx_pld_pcs_interface_hd_pmaif_channel_operation_mode),
        .hssi_tx_pld_pcs_interface_hd_krfec_channel_operation_mode (hssi_tx_pld_pcs_interface_hd_krfec_channel_operation_mode),
        .hssi_tx_pld_pcs_interface_hd_10g_channel_operation_mode (hssi_tx_pld_pcs_interface_hd_10g_channel_operation_mode),
        .hssi_rx_pld_pcs_interface_hd_10g_shared_fifo_width_rx (hssi_rx_pld_pcs_interface_hd_10g_shared_fifo_width_rx),
        .hssi_rx_pld_pcs_interface_hd_chnl_channel_operation_mode (hssi_rx_pld_pcs_interface_hd_chnl_channel_operation_mode),
        .hssi_tx_pld_pcs_interface_hd_10g_low_latency_en_tx (hssi_tx_pld_pcs_interface_hd_10g_low_latency_en_tx),
        .hssi_rx_pld_pcs_interface_hd_chnl_hip_en (hssi_rx_pld_pcs_interface_hd_chnl_hip_en),

    // prot_mode
        .cdr_pll_prot_mode (cdr_pll_prot_mode),
        .cdr_pll_tx_pll_prot_mode (cdr_pll_tx_pll_prot_mode),
        .pma_adapt_prot_mode (pma_adapt_prot_mode),
        .pma_rx_odi_prot_mode (pma_rx_odi_prot_mode),
        .pma_rx_buf_prot_mode (pma_rx_buf_prot_mode),
        .pma_rx_buf_xrx_path_prot_mode (pma_rx_buf_xrx_path_prot_mode),
        .pma_rx_dfe_prot_mode (pma_rx_dfe_prot_mode),
        .pma_rx_deser_prot_mode (pma_rx_deser_prot_mode),
        .pma_rx_sd_prot_mode (pma_rx_sd_prot_mode),
        .pma_tx_buf_prot_mode (pma_tx_buf_prot_mode),
        .pma_tx_buf_xtx_path_prot_mode (pma_tx_buf_xtx_path_prot_mode),
        .pma_tx_ser_prot_mode (pma_tx_ser_prot_mode),
        .pma_cgb_prot_mode (pma_cgb_prot_mode),
        .hssi_rx_pld_pcs_interface_hd_8g_prot_mode_rx (hssi_rx_pld_pcs_interface_hd_8g_prot_mode_rx),
        .hssi_rx_pld_pcs_interface_hd_g3_prot_mode (hssi_rx_pld_pcs_interface_hd_g3_prot_mode),
        .hssi_rx_pld_pcs_interface_hd_krfec_prot_mode_rx (hssi_rx_pld_pcs_interface_hd_krfec_prot_mode_rx),
        .hssi_tx_pld_pcs_interface_hd_fifo_prot_mode_tx (hssi_tx_pld_pcs_interface_hd_fifo_prot_mode_tx),
        .hssi_rx_pld_pcs_interface_hd_pldif_prot_mode_rx (hssi_rx_pld_pcs_interface_hd_pldif_prot_mode_rx),
        .hssi_tx_pld_pcs_interface_hd_8g_prot_mode_tx (hssi_tx_pld_pcs_interface_hd_8g_prot_mode_tx),
        .hssi_rx_pld_pcs_interface_hd_fifo_prot_mode_rx (hssi_rx_pld_pcs_interface_hd_fifo_prot_mode_rx),
        .hssi_rx_pld_pcs_interface_hd_pmaif_prot_mode_rx (hssi_rx_pld_pcs_interface_hd_pmaif_prot_mode_rx),
        .hssi_tx_pld_pcs_interface_hd_10g_prot_mode_tx (hssi_tx_pld_pcs_interface_hd_10g_prot_mode_tx),
        .hssi_tx_pcs_pma_interface_prot_mode_tx (hssi_tx_pcs_pma_interface_prot_mode_tx),
        .hssi_tx_pld_pcs_interface_hd_pldif_prot_mode_tx (hssi_tx_pld_pcs_interface_hd_pldif_prot_mode_tx),
        .hssi_tx_pld_pcs_interface_hd_krfec_prot_mode_tx (hssi_tx_pld_pcs_interface_hd_krfec_prot_mode_tx),
        .hssi_rx_pld_pcs_interface_hd_chnl_prot_mode_rx (hssi_rx_pld_pcs_interface_hd_chnl_prot_mode_rx),
        .hssi_tx_pld_pcs_interface_hd_pmaif_prot_mode_tx (hssi_tx_pld_pcs_interface_hd_pmaif_prot_mode_tx),
        .hssi_tx_pld_pcs_interface_hd_g3_prot_mode (hssi_tx_pld_pcs_interface_hd_g3_prot_mode),
        .hssi_tx_pld_pcs_interface_hd_chnl_prot_mode_tx (hssi_tx_pld_pcs_interface_hd_chnl_prot_mode_tx),
        .hssi_rx_pld_pcs_interface_hd_10g_prot_mode_rx (hssi_rx_pld_pcs_interface_hd_10g_prot_mode_rx),
        .hssi_10g_rx_pcs_prot_mode (hssi_10g_rx_pcs_prot_mode),
        .hssi_10g_tx_pcs_prot_mode (hssi_10g_tx_pcs_prot_mode),
        .hssi_8g_rx_pcs_prot_mode (hssi_8g_rx_pcs_prot_mode),
        .hssi_8g_tx_pcs_prot_mode (hssi_8g_tx_pcs_prot_mode),
        .hssi_common_pcs_pma_interface_prot_mode (hssi_common_pcs_pma_interface_prot_mode),
        .hssi_fifo_rx_pcs_prot_mode (hssi_fifo_rx_pcs_prot_mode),
        .hssi_fifo_tx_pcs_prot_mode (hssi_fifo_tx_pcs_prot_mode),
        .hssi_krfec_rx_pcs_prot_mode (hssi_krfec_rx_pcs_prot_mode),
        .hssi_krfec_tx_pcs_prot_mode (hssi_krfec_tx_pcs_prot_mode),
        .hssi_pipe_gen1_2_prot_mode (hssi_pipe_gen1_2_prot_mode),
        .hssi_rx_pcs_pma_interface_prot_mode_rx (hssi_rx_pcs_pma_interface_prot_mode_rx),
        .hssi_tx_pcs_pma_interface_pcie_sub_prot_mode_tx (hssi_tx_pcs_pma_interface_pcie_sub_prot_mode_tx),
    // datarate
        .cdr_pll_datarate (cdr_pll_datarate),
        .pma_adapt_datarate (pma_adapt_datarate),
        .pma_rx_buf_datarate (pma_rx_buf_datarate),
        .pma_rx_buf_xrx_path_datarate (pma_rx_buf_xrx_path_datarate),
        .pma_rx_deser_datarate (pma_rx_deser_datarate),
        .pma_rx_dfe_datarate (pma_rx_dfe_datarate),
        .pma_rx_odi_datarate (pma_rx_odi_datarate),
        .pma_tx_buf_datarate (pma_tx_buf_datarate),
        .pma_tx_buf_xtx_path_datarate(pma_tx_buf_xtx_path_datarate),
        .pma_cgb_datarate (pma_cgb_datarate),
    // sup_mode
        .cdr_pll_sup_mode (cdr_pll_sup_mode),
        .hssi_8g_rx_pcs_sup_mode (hssi_8g_rx_pcs_sup_mode),
        .hssi_8g_tx_pcs_sup_mode (hssi_8g_tx_pcs_sup_mode),
        .hssi_10g_rx_pcs_sup_mode (hssi_10g_rx_pcs_sup_mode),
        .hssi_10g_tx_pcs_sup_mode (hssi_10g_tx_pcs_sup_mode),
        .hssi_common_pcs_pma_interface_sup_mode (hssi_common_pcs_pma_interface_sup_mode),
        .hssi_gen3_rx_pcs_sup_mode (hssi_gen3_rx_pcs_sup_mode),
        .hssi_gen3_tx_pcs_sup_mode (hssi_gen3_tx_pcs_sup_mode),
        .hssi_krfec_rx_pcs_sup_mode (hssi_krfec_rx_pcs_sup_mode),
        .hssi_krfec_tx_pcs_sup_mode (hssi_krfec_tx_pcs_sup_mode),
        .hssi_pipe_gen1_2_sup_mode (hssi_pipe_gen1_2_sup_mode),
        .hssi_pipe_gen3_sup_mode (hssi_pipe_gen3_sup_mode),
        .hssi_rx_pcs_pma_interface_sup_mode (hssi_rx_pcs_pma_interface_sup_mode),
        .hssi_tx_pcs_pma_interface_sup_mode (hssi_tx_pcs_pma_interface_sup_mode),
        .pma_adapt_sup_mode (pma_adapt_sup_mode),
        .pma_cgb_sup_mode (pma_cgb_sup_mode),
        .pma_rx_buf_sup_mode (pma_rx_buf_sup_mode),
        .pma_rx_buf_xrx_path_sup_mode (pma_rx_buf_xrx_path_sup_mode),
        .pma_rx_deser_sup_mode (pma_rx_deser_sup_mode),
        .pma_rx_dfe_sup_mode (pma_rx_dfe_sup_mode),
        .pma_rx_odi_sup_mode (pma_rx_odi_sup_mode),
        .pma_rx_sd_sup_mode (pma_rx_sd_sup_mode),
        .pma_tx_buf_sup_mode (pma_tx_buf_sup_mode),
        .pma_tx_buf_xtx_path_sup_mode (pma_tx_buf_xtx_path_sup_mode),
        .pma_tx_ser_sup_mode (pma_tx_ser_sup_mode)
  ) twentynm_xcvr_native_inst (
      // nf_pma ports
      /*input   [bonded_lanes - 1:0]          */.in_clk_cdr_b         (1'b0),
      /*input   [bonded_lanes - 1:0]          */.in_clk_cdr_t         (1'b0),
      /*input   [bonded_lanes - 1:0]          */.in_clk_fpll_b        (tx_serial_clk0[ig]),
      /*input   [bonded_lanes - 1:0]          */.in_clk_fpll_t        (tx_serial_clk2[ig]),
      /*input   [bonded_lanes - 1:0]          */.in_clk_lc_b          (tx_serial_clk1[ig]),
      /*input   [bonded_lanes - 1:0]          */.in_clk_lc_hs         (1'b0),
      /*input   [bonded_lanes - 1:0]          */.in_clk_lc_t          (tx_serial_clk3[ig]),
      /*input   [bonded_lanes - 1:0]          */.in_clkb_cdr_b        (1'b0),
      /*input   [bonded_lanes - 1:0]          */.in_clkb_cdr_t        (1'b0),
`ifndef ALTERA_RESERVED_QIS
      /*input   [bonded_lanes - 1:0]          */.in_clkb_fpll_b       (~tx_serial_clk0[ig]),
      /*input   [bonded_lanes - 1:0]          */.in_clkb_fpll_t       (~tx_serial_clk2[ig]),
      /*input   [bonded_lanes - 1:0]          */.in_clkb_lc_b         (~tx_serial_clk1[ig]),
      /*input   [bonded_lanes - 1:0]          */.in_clkb_lc_t         (~tx_serial_clk3[ig]),
`else
      /*input   [bonded_lanes - 1:0]          */.in_clkb_fpll_b       (1'b0),
      /*input   [bonded_lanes - 1:0]          */.in_clkb_fpll_t       (1'b0),
      /*input   [bonded_lanes - 1:0]          */.in_clkb_lc_b         (1'b0),
      /*input   [bonded_lanes - 1:0]          */.in_clkb_lc_t         (1'b0),
`endif
      /*input   [bonded_lanes - 1:0]          */.in_clkb_lc_hs        (1'b0),
      /*input   [bonded_lanes * 6 - 1 : 0]    */.in_cpulse_x6_dn_bus  (tx_bonding_clocks[ig*6+:6]),
      /*input   [bonded_lanes * 6 - 1 : 0]    */.in_cpulse_x6_up_bus  (tx_bonding_clocks1[ig*6+:6]),
      /*input   [bonded_lanes * 6 - 1 : 0]    */.in_cpulse_xn_dn_bus  (tx_bonding_clocks2[ig*6+:6]),
      /*input   [bonded_lanes * 6 - 1 : 0]    */.in_cpulse_xn_up_bus  (tx_bonding_clocks3[ig*6+:6]),
`ifndef ALTERA_RESERVED_QIS
      /*input   [bonded_lanes - 1:0]          */.in_rx_n              (~rx_serial_data[ig]),
`else
      /*input   [bonded_lanes - 1:0]          */.in_rx_n              (1'b0),
`endif
      /*input   [bonded_lanes - 1:0]          */.in_rx_p              (rx_serial_data[ig]),
      /*output  [bonded_lanes - 1:0]          */.out_tx_n             (/*unused*/        ),
      /*output  [bonded_lanes - 1:0]          */.out_tx_p             (tx_serial_data[ig]),
      /*input   [bonded_lanes * 12 - 1 : 0]   */.in_ref_iqclk         ({7'd0,rx_cdr_refclk4,rx_cdr_refclk3,rx_cdr_refclk2,rx_cdr_refclk1,rx_cdr_refclk0}),

      // nf_pcs ports
      // HIP
      /*input   [bonded_lanes * 64 - 1 : 0]   */.in_hip_tx_data       (tx_hip_data    [ig*64+:64] ),
      /*output  [bonded_lanes * 51 - 1 : 0]   */.out_hip_rx_data      (rx_hip_data    [ig*51+:51] ),
      /*output  [bonded_lanes * 3 - 1 : 0]    */.out_hip_clk_out      ({hip_frefclk[ig],int_hip_fixedclk,int_hip_pipe_pclk}),
      /*output  [bonded_lanes * 8 - 1 : 0]    */.out_hip_ctrl_out     (hip_ctrl       [ig*8+:8]   ),
              

      // Standard datapath inputs
      /*input   [bonded_lanes - 1:0]          */.in_pld_8g_a1a2_size          (rx_std_wa_a1a2size       [ig]  ),
      /*input   [bonded_lanes - 1:0]          */.in_pld_8g_bitloc_rev_en      (rx_std_bitrev_ena        [ig]  ),
      /*input   [bonded_lanes - 1:0]          */.in_pld_8g_byte_rev_en        (rx_std_byterev_ena       [ig]  ),
      /*input   [bonded_lanes * 3 - 1 : 0]    */.in_pld_8g_eidleinfersel      (pipe_rx_eidleinfersel    [ig*3+:3]),
      /*input   [bonded_lanes - 1:0]          */.in_pld_8g_encdt              (rx_std_wa_patternalign   [ig]  ),
      /*input   [bonded_lanes - 1:0]          */.in_pld_8g_g3_rx_pld_rst_n    (int_in_pld_8g_g3_rx_pld_rst_n  ),
      /*input   [bonded_lanes - 1:0]          */.in_pld_8g_g3_tx_pld_rst_n    (int_in_pld_8g_g3_tx_pld_rst_n  ),
      /*input   [bonded_lanes - 1:0]          */.in_pld_8g_rddisable_tx       (1'b0),
      /*input   [bonded_lanes - 1:0]          */.in_pld_8g_rdenable_rx        (1'b0),
      /*input   [bonded_lanes - 1:0]          */.in_pld_8g_refclk_dig2        (1'b0), //TODO
      /*input   [bonded_lanes - 1:0]          */.in_pld_8g_rxpolarity         (pipe_rx_polarity         [ig]  ),
      /*input   [bonded_lanes * 5 - 1 : 0]    */.in_pld_8g_tx_boundary_sel    (tx_std_bitslipboundarysel[ig*5+:5]),
      /*input   [bonded_lanes - 1:0]          */.in_pld_8g_wrdisable_rx       (1'b0), // unused in Si
      /*input   [bonded_lanes - 1:0]          */.in_pld_8g_wrenable_tx        (1'b0), // unused in Si

      // Standard datapath outputs
      /*output  [bonded_lanes * 4 - 1 : 0]    */.out_pld_8g_a1a2_k1k2_flag    (/*TODO*/),

      /*output  [bonded_lanes - 1:0]          */.out_pld_8g_empty_rmf         (rx_std_rmfifo_empty      [ig]  ),
      /*output  [bonded_lanes - 1:0]          */.out_pld_8g_empty_rx          (rx_std_pcfifo_empty      [ig]  ),
      /*output  [bonded_lanes - 1:0]          */.out_pld_8g_empty_tx          (tx_std_pcfifo_empty      [ig]  ),
      /*output  [bonded_lanes - 1:0]          */.out_pld_8g_full_rmf          (rx_std_rmfifo_full       [ig]  ),
      /*output  [bonded_lanes - 1:0]          */.out_pld_8g_full_rx           (rx_std_pcfifo_full       [ig]  ),
      /*output  [bonded_lanes - 1:0]          */.out_pld_8g_full_tx           (tx_std_pcfifo_full       [ig]  ),
      /*output  [bonded_lanes - 1:0]          */.out_pld_8g_rxelecidle        (pipe_rx_elecidle         [ig]  ),
      /*output  [bonded_lanes - 1:0]          */.out_pld_8g_signal_detect_out (rx_std_signaldetect      [ig]  ),
      /*output  [bonded_lanes * 5 - 1 : 0]    */.out_pld_8g_wa_boundary       (rx_std_bitslipboundarysel[ig*5+:5]),

      // Enhanced datapath bonding
      /*input   [bonded_lanes * 5 - 1 : 0]    */.in_bond_pcs10g_in_bot        (bond_pcs10g_in_bot       [ig]  ),
      /*input   [bonded_lanes * 5 - 1 : 0]    */.in_bond_pcs10g_in_top        (bond_pcs10g_in_top       [ig]  ),
      /*input   [bonded_lanes * 13 - 1 : 0]   */.in_bond_pcs8g_in_bot         (bond_pcs8g_in_bot        [ig]  ),
      /*input   [bonded_lanes * 13 - 1 : 0]   */.in_bond_pcs8g_in_top         (bond_pcs8g_in_top        [ig]  ),
      /*input   [bonded_lanes * 12 - 1 : 0]   */.in_bond_pmaif_in_bot         (bond_pmaif_in_bot        [ig]  ),
      /*input   [bonded_lanes * 12 - 1 : 0]   */.in_bond_pmaif_in_top         (bond_pmaif_in_top        [ig]  ),

      /*output  [bonded_lanes * 5 - 1 : 0]    */.out_bond_pcs10g_out_bot      (bond_pcs10g_out_bot      [ig]  ),
      /*output  [bonded_lanes * 5 - 1 : 0]    */.out_bond_pcs10g_out_top      (bond_pcs10g_out_top      [ig]  ),
      /*output  [bonded_lanes * 13 - 1 : 0]   */.out_bond_pcs8g_out_bot       (bond_pcs8g_out_bot       [ig]  ),
      /*output  [bonded_lanes * 13 - 1 : 0]   */.out_bond_pcs8g_out_top       (bond_pcs8g_out_top       [ig]  ),
      /*output  [bonded_lanes * 12 - 1 : 0]   */.out_bond_pmaif_out_bot       (bond_pmaif_out_bot       [ig]  ),
      /*output  [bonded_lanes * 12 - 1 : 0]   */.out_bond_pmaif_out_top       (bond_pmaif_out_top       [ig]  ),

      // Enhanced datapath inputs
      /*input   [bonded_lanes - 1:0]          */.in_pld_10g_krfec_rx_pld_rst_n      (int_in_pld_10g_krfec_rx_pld_rst_n),
      /*input   [bonded_lanes - 1:0]          */.in_pld_10g_krfec_tx_pld_rst_n      (int_in_pld_10g_krfec_tx_pld_rst_n),
      /*input   [bonded_lanes - 1:0]          */.in_pld_10g_rx_align_clr            (rx_enh_fifo_align_clr    [ig]  ),
      /*input   [bonded_lanes - 1:0]          */.in_pld_10g_rx_clr_ber_count        (rx_enh_highber_clr_cnt   [ig]  ),
      /*input   [bonded_lanes - 1:0]          */.in_pld_10g_krfec_rx_clr_errblk_cnt (rx_enh_clr_errblk_count  [ig]  ),
      /*input   [bonded_lanes - 1:0]          */.in_pld_10g_rx_rd_en                (rx_enh_fifo_rd_en        [ig]  ),
      /*input   [bonded_lanes * 7 - 1 : 0]    */.in_pld_10g_tx_bitslip              (tx_enh_bitslip           [ig*7+:7]),
      /*input   [bonded_lanes - 1:0]          */.in_pld_10g_tx_burst_en             (tx_enh_frame_burst_en    [ig]  ),
      /*input   [bonded_lanes - 1:0]          */.in_pld_10g_tx_data_valid           (tx_enh_data_valid        [ig]  ),
      /*input   [bonded_lanes * 2 - 1 : 0]    */.in_pld_10g_tx_diag_status          (tx_enh_frame_diag_status [ig*2+:2]),
      /*input   [bonded_lanes - 1:0]          */.in_pld_10g_tx_wordslip             (1'b0), // engineering mode only
      // Enhanced datapath outputs
      /*output  [bonded_lanes - 1:0]          */.out_pld_10g_rx_align_val               (rx_enh_fifo_align_val[ig]),
      /*output  [bonded_lanes - 1:0]          */.out_pld_10g_krfec_rx_blk_lock          (rx_enh_blk_lock      [ig]),
      /*output  [bonded_lanes - 1:0]          */.out_pld_10g_rx_crc32_err               (rx_enh_crc32_err     [ig]),
      /*output  [bonded_lanes - 1:0]          */.out_pld_10g_rx_data_valid              (rx_enh_data_valid    [ig]),
      /*output  [bonded_lanes * 2 - 1 : 0]    */.out_pld_10g_krfec_rx_diag_data_status  (rx_enh_frame_diag_status[ig*2+:2]),
      /*output  [bonded_lanes - 1:0]          */.out_pld_10g_rx_empty                   (rx_enh_fifo_empty    [ig]),
      /*output  [bonded_lanes - 1:0]          */.out_pld_10g_rx_fifo_del                (rx_enh_fifo_del      [ig]),
      /*output  [bonded_lanes - 1:0]          */.out_pld_10g_rx_fifo_insert             (rx_enh_fifo_insert   [ig]),
      /*output  [bonded_lanes * 5 - 1 : 0]    */.out_pld_10g_rx_fifo_num                (rx_enh_fifo_cnt      [ig*5+:5]),
      /*output  [bonded_lanes - 1:0]          */.out_pld_10g_rx_frame_lock              (rx_enh_frame_lock    [ig]),
      /*output  [bonded_lanes - 1:0]          */.out_pld_10g_rx_hi_ber                  (rx_enh_highber       [ig]),
      /*output  [bonded_lanes - 1:0]          */.out_pld_10g_rx_oflw_err                (rx_enh_fifo_full     [ig]),
      /*output  [bonded_lanes - 1:0]          */.out_pld_10g_rx_pempty                  (rx_enh_fifo_pempty   [ig]),
      /*output  [bonded_lanes - 1:0]          */.out_pld_10g_rx_pfull                   (rx_enh_fifo_pfull    [ig]),
      /*output  [bonded_lanes - 1:0]          */.out_pld_10g_krfec_rx_frame             (rx_enh_frame         [ig]),
      /*output  [bonded_lanes - 1:0]          */.out_pld_10g_tx_burst_en_exe            (/*TODO*/),
      /*output  [bonded_lanes - 1:0]          */.out_pld_10g_tx_empty                   (tx_enh_fifo_empty    [ig]),
      /*output  [bonded_lanes * 4 - 1 : 0]    */.out_pld_10g_tx_fifo_num                (tx_enh_fifo_cnt      [ig*4+:4]),
      /*output  [bonded_lanes - 1:0]          */.out_pld_10g_krfec_tx_frame             (tx_enh_frame         [ig]),
      /*output  [bonded_lanes - 1:0]          */.out_pld_10g_tx_full                    (tx_enh_fifo_full     [ig]),
      /*output  [bonded_lanes - 1:0]          */.out_pld_10g_tx_pempty                  (tx_enh_fifo_pempty   [ig]),
      /*output  [bonded_lanes - 1:0]          */.out_pld_10g_tx_pfull                   (tx_enh_fifo_pfull    [ig]),
      /*output  [bonded_lanes - 1:0]          */.out_pld_10g_tx_wordslip_exe            (/*unused*/               ), // engineering mode only

      // Common interface inputs
      /*input   [bonded_lanes - 1:0]          */.in_pld_bitslip               (rx_bitslip         [ig]),
      /*input   [bonded_lanes - 1:0]          */.in_pld_polinv_rx             (rx_polinv          [ig]),
      /*input   [bonded_lanes - 1:0]          */.in_pld_polinv_tx             (tx_polinv          [ig]),


      /*input   [bonded_lanes * 2 - 1 : 0]    */.in_pld_rate                  (int_pipe_rate                    ),
      /*input   [bonded_lanes * 10 - 1 : 0]   */.in_pld_reserved_in           (10'd0),
      /*input   [bonded_lanes - 1:0]          */.in_pld_rx_clk                (rx_coreclkin       [ig]          ),
      /*input   [bonded_lanes - 1:0]          */.in_pld_rx_prbs_err_clr       (int_rx_prbs_err_clr[ig]          ),
      /*input   [bonded_lanes - 1:0]          */.in_pld_syncsm_en             (1'b1),
      /*input   [bonded_lanes - 1:0]          */.in_pld_tx_clk                (tx_coreclkin       [ig]          ),
      /*input   [bonded_lanes * 18 - 1 : 0]   */.in_pld_tx_control            (tx_control         [ig*18+:18]   ),
      /*input   [bonded_lanes * 128 - 1 : 0]  */.in_pld_tx_data               (tx_parallel_data   [ig*128+:128] ),
      /*input   [bonded_lanes - 1:0]          */.in_pld_txelecidle            (tx_pma_elecidle    [ig]          ),
      /*output  [bonded_lanes * 20 - 1 : 0]   */.out_pld_rx_control           (rx_control         [ig*20+:20]   ),
      /*output  [bonded_lanes * 128 - 1 : 0]  */.out_pld_rx_data              (rx_parallel_data   [ig*128+:128] ),
      /*output  [bonded_lanes - 1:0]          */.out_pld_rx_prbs_done         (rx_prbs_done       [ig]          ),
      /*output  [bonded_lanes - 1:0]          */.out_pld_rx_prbs_err          (rx_prbs_err        [ig]          ),
      // Ultra high-speed interface
      /*input   [bonded_lanes - 1:0]          */.in_pld_uhsif_tx_clk          (tx_uhsif_clk       [ig]          ),
      /*output  [bonded_lanes - 1:0]          */.out_pld_uhsif_lock           (tx_uhsif_lock      [ig]          ),
      /*output  [bonded_lanes - 1:0]          */.out_pld_uhsif_tx_clk_out     (tx_uhsif_clkout    [ig]          ),
      // KRFEC
      /*input   [bonded_lanes - 1:0]          */.in_pld_mem_krfec_atpg_rst_n  (1'b1),
      /*input   [bonded_lanes - 1:0]          */.in_pld_atpg_los_en_n         (1'b1),
      /*output  [bonded_lanes - 1:0]          */.out_pld_krfec_tx_alignment   (/*unused*/), // engineering mode only
      // Gen 3 PCIe datapath
      /*input   [bonded_lanes * 18 - 1 : 0]   */.in_pld_g3_current_coeff      (pipe_g3_txdeemph [ig*18+:18]     ),
      /*input   [bonded_lanes * 3 - 1 : 0]    */.in_pld_g3_current_rxpreset   (pipe_g3_rxpresethint[ig*3+:3]    ),


      /*input   [bonded_lanes - 1:0]          */.in_pld_ltr                   (int_rx_set_locktoref [ig]),
      /*input   [bonded_lanes - 1:0]          */.in_pld_partial_reconfig      (1'b1),
      /*input   [bonded_lanes - 1:0]          */.in_pld_pcs_refclk_dig        (1'b0),
      /*input   [bonded_lanes - 1:0]          */.in_pld_pma_adapt_start       (rx_adapt_start [ig]),
      /*input   [bonded_lanes - 1:0]          */.in_pld_pma_early_eios        (1'b0),
      /*input   [bonded_lanes * 6 - 1 : 0]    */.in_pld_pma_eye_monitor       (/*TODO*/),
      /*input   [bonded_lanes - 1:0]          */.in_pld_pma_ltd_b             (~int_rx_set_locktodata [ig]),
      /*input   [bonded_lanes - 1:0]          */.in_pld_pma_ppm_lock          (1'b1), //TODO - Temporary until PPM detector enabled
      /*input   [bonded_lanes * 5 - 1 : 0]    */.in_pld_pma_reserved_out      ({~rx_adapt_reset[ig],4'd0}),
      /*input   [bonded_lanes - 1:0]          */.in_pld_pma_rs_lpbk_b         (~int_rx_seriallpbken   [ig]),
      /*input   [bonded_lanes - 1:0]          */.in_pld_pma_rx_qpi_pullup     (~rx_pma_qpipulldn   [ig]),
      /*input   [bonded_lanes - 1:0]          */.in_pld_pma_rxpma_rstb        (~rx_analogreset_to_pma[ig]),
      /*input   [bonded_lanes - 1:0]          */.in_pld_pma_tx_bonding_rstb   (1'b0), // x1 bonding reset unused
      /*input   [bonded_lanes - 1:0]          */.in_pld_pma_tx_qpi_pulldn     (~tx_pma_qpipulldn   [ig]),
      /*input   [bonded_lanes - 1:0]          */.in_pld_pma_tx_qpi_pullup     (~tx_pma_qpipullup   [ig]),
      /*input   [bonded_lanes - 1:0]          */.in_pld_pma_txdetectrx        (tx_pma_txdetectrx  [ig]),
      /*input   [bonded_lanes - 1:0]          */.in_pld_pma_txpma_rstb        (~tx_analogreset_to_pma[ig]),
      /*input   [bonded_lanes - 1:0]          */.in_pld_pma_tx_bitslip        (1'b0), // TODO - deprecated
      /*input   [bonded_lanes * 2 - 1 : 0]    */.in_pld_pma_pcie_switch       (2'd0),
      /*input   [bonded_lanes - 1:0]          */.in_pld_pmaif_rxclkslip       (rx_pma_clkslip     [ig]),
      /*input   [bonded_lanes - 1:0]          */.in_pld_pmaif_rx_pld_rst_n    (int_in_pld_pmaif_rx_pld_rst_n),
      /*input   [bonded_lanes - 1:0]          */.in_pld_pmaif_tx_pld_rst_n    (int_in_pld_pmaif_tx_pld_rst_n),
      /*input   [bonded_lanes - 1:0]          */.in_pma_hclk                  (pipe_hclk_in           ),
      /*output  [bonded_lanes - 1:0]          */.out_pld_pma_clklow           (rx_clklow          [ig]),
      /*output  [bonded_lanes - 1:0]          */.out_pld_pma_fref             (rx_fref            [ig]),
      /*output  [bonded_lanes - 1:0]          */.out_pld_pcs_rx_clk_out       (rx_clkout          [ig]),
      /*output  [bonded_lanes - 1:0]          */.out_pld_pcs_tx_clk_out       (tx_clkout          [ig]),
      /*output  [bonded_lanes - 1:0]          */.out_pld_pma_adapt_done       (/*unused*/),
      /*output  [bonded_lanes - 1:0]          */.out_pld_pma_clkdiv_rx_user   (rx_pma_div_clkout  [ig]),
      /*output  [bonded_lanes - 1:0]          */.out_pld_pma_clkdiv_tx_user   (tx_pma_div_clkout  [ig]),
      /*output  [bonded_lanes - 1:0]          */.out_clk_divtx_iqtxrx         (tx_pma_iqtxrx_clkout [ig]), // Needed for cascading
      /*output  [bonded_lanes - 1:0]          */.out_clk_divrx_iqtxrx         (rx_pma_iqtxrx_clkout [ig]), // Needed for cascading
      /*output  [bonded_lanes - 1:0]          */.out_pld_pma_hclk             (int_pipe_hclk_out      ),

      /*output  [bonded_lanes * 2 - 1 : 0]    */.out_pld_pma_pcie_sw_done     (/*unused*/),
      /*output  [bonded_lanes - 1:0]          */.out_pld_pma_pfdmode_lock     (rx_is_lockedtoref  [ig]),
      /*output  [bonded_lanes - 1:0]          */.out_pld_pma_rx_clk_out       (rx_pma_clkout      [ig]),
      /*output  [bonded_lanes - 1:0]          */.out_pld_pma_rx_detect_valid  (/*TODO*/),
      /*output  [bonded_lanes - 1:0]          */.out_pld_pma_rx_found         (tx_pma_rxfound     [ig]),
      /*output  [bonded_lanes - 1:0]          */.out_pld_pma_rxpll_lock       (rx_is_lockedtodata [ig]),
      /*output  [bonded_lanes - 1:0]          */.out_pld_pma_signal_ok        (/*TODO*/),
      /*output  [bonded_lanes * 8 - 1 : 0]    */.out_pld_pma_testbus          (/*unused*/),
      /*output  [bonded_lanes - 1:0]          */.out_pld_pma_tx_clk_out       (tx_pma_clkout      [ig]),
      /*output  [bonded_lanes - 1:0]          */.out_pld_pmaif_mask_tx_pll    (/*unused*/),
      /*output  [bonded_lanes * 10 - 1 : 0]   */.out_pld_reserved_out         (/*unused*/),
      /*output  [bonded_lanes * 20 - 1 : 0]   */.out_pld_test_data            (pld_testbus_for_rate[ig*20+:20]),
      // PCIe
      /*input   [bonded_lanes * 2 - 1 : 0]    */.in_pcie_sw_done_master_in    (int_pipe_sw_done       ),
      /*output  [bonded_lanes * 2 - 1 : 0]    */.out_pcie_sw_master           (int_pipe_sw            ),

      // TODO
      /*input   [bonded_lanes * 3 - 1 : 0]    */.in_i_rxpreset  (3'd0),
      /*input   [bonded_lanes - 1:0]          */.in_adapt_start (1'b0),



      // nf_xcvr_avmm ports
      // AVMM slave interface signals (user)
      /*input   wire  [avmm_interfaces-1     :0]      */.avmm_clk         (avmm_clk         [ig]      ),
      /*input   wire  [avmm_interfaces-1     :0]      */.avmm_reset       (avmm_reset       [ig]      ),
      /*input   wire  [avmm_interfaces*32-1  :0]      */.avmm_writedata   (avmm_writedata   [ig*8+:8] ),
      /*input   wire  [avmm_interfaces*9-1   :0]      */.avmm_address     (avmm_address     [ig*RCFG_ADDR_BITS+:9]),  // Only lowest 9 bits drive hardware
      /*input   wire  [avmm_interfaces-1     :0]      */.avmm_write       (avmm_write       [ig]      ),
      /*input   wire  [avmm_interfaces-1     :0]      */.avmm_read        (avmm_read        [ig]      ),
      /*output  wire  [avmm_interfaces*32-1  :0]      */.avmm_readdata    (avmm_readdata    [ig*8+:8] ),
      /*output  wire  [avmm_interfaces-1     :0]      */.avmm_waitrequest (avmm_waitrequest [ig]      ),
      /*output  wire  [avmm_interfaces-1     :0]      */.avmm_busy        (avmm_busy        [ig]      ),
      /*output  wire  [avmm_interfaces-1     :0]      */.pld_cal_done     (pld_cal_done     [ig]      ),
      /*output  wire  [avmm_interfaces-1     :0]      */.hip_cal_done     (hip_cal_done     [ig]      ),

// TO BE REMOVED
  .out_hip_npor()
  );



end
endgenerate

endmodule // altera_xcvr_native_a10

