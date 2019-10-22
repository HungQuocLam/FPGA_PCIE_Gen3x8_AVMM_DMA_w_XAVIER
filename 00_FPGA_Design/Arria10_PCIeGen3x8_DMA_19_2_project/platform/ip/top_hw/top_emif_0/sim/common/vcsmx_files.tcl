
namespace eval top_emif_0 {
  proc get_design_libraries {} {
    set libraries [dict create]
    dict set libraries altera_emif_arch_nf_191               1
    dict set libraries altera_avalon_mm_bridge_191           1
    dict set libraries altera_jtag_dc_streaming_191          1
    dict set libraries timing_adapter_191                    1
    dict set libraries altera_avalon_sc_fifo_191             1
    dict set libraries altera_avalon_st_bytes_to_packets_191 1
    dict set libraries altera_avalon_st_packets_to_bytes_191 1
    dict set libraries altera_avalon_packets_to_master_191   1
    dict set libraries channel_adapter_191                   1
    dict set libraries altera_reset_controller_191           1
    dict set libraries alt_mem_if_jtag_master_191            1
    dict set libraries altera_merlin_master_translator_191   1
    dict set libraries altera_merlin_slave_translator_191    1
    dict set libraries altera_mm_interconnect_191            1
    dict set libraries altera_ip_col_if_191                  1
    dict set libraries altera_avalon_onchip_memory2_191      1
    dict set libraries altera_emif_cal_slave_nf_191          1
    dict set libraries altera_emif_1910                      1
    dict set libraries top_emif_0                            1
    return $libraries
  }
  
  proc get_memory_files {QSYS_SIMDIR} {
    set memory_files [list]
    lappend memory_files "$QSYS_SIMDIR/../altera_emif_arch_nf_191/sim/top_emif_0_altera_emif_arch_nf_191_bclhany_seq_params_sim.hex"
    lappend memory_files "$QSYS_SIMDIR/../altera_emif_arch_nf_191/sim/top_emif_0_altera_emif_arch_nf_191_bclhany_seq_params_synth.hex"
    lappend memory_files "$QSYS_SIMDIR/../altera_emif_arch_nf_191/sim/top_emif_0_altera_emif_arch_nf_191_bclhany_seq_cal.hex"
    lappend memory_files "$QSYS_SIMDIR/../altera_avalon_onchip_memory2_191/sim/seq_cal_soft_m20k.hex"
    return $memory_files
  }
  
  proc get_common_design_files {USER_DEFINED_COMPILE_OPTIONS USER_DEFINED_VERILOG_COMPILE_OPTIONS USER_DEFINED_VHDL_COMPILE_OPTIONS QSYS_SIMDIR} {
    set design_files [dict create]
    return $design_files
  }
  
  proc get_design_files {USER_DEFINED_COMPILE_OPTIONS USER_DEFINED_VERILOG_COMPILE_OPTIONS USER_DEFINED_VHDL_COMPILE_OPTIONS QSYS_SIMDIR} {
    set design_files [list]
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_emif_arch_nf_191/sim/top_emif_0_altera_emif_arch_nf_191_bclhany_top.sv\"  -work altera_emif_arch_nf_191"                                
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_emif_arch_nf_191/sim/top_emif_0_altera_emif_arch_nf_191_bclhany_io_aux.sv\"  -work altera_emif_arch_nf_191"                             
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_emif_arch_nf_191/sim/altera_emif_arch_nf_oct.sv\"  -work altera_emif_arch_nf_191"                                                       
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_emif_arch_nf_191/sim/altera_emif_arch_nf_buf_udir_df_o.sv\"  -work altera_emif_arch_nf_191"                                             
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_emif_arch_nf_191/sim/altera_emif_arch_nf_buf_bdir_df.sv\"  -work altera_emif_arch_nf_191"                                               
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_emif_arch_nf_191/sim/altera_emif_arch_nf_buf_bdir_se.sv\"  -work altera_emif_arch_nf_191"                                               
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_emif_arch_nf_191/sim/altera_emif_arch_nf_buf_udir_cp_i.sv\"  -work altera_emif_arch_nf_191"                                             
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_emif_arch_nf_191/sim/altera_emif_arch_nf_buf_udir_df_i.sv\"  -work altera_emif_arch_nf_191"                                             
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_emif_arch_nf_191/sim/altera_emif_arch_nf_buf_udir_se_i.sv\"  -work altera_emif_arch_nf_191"                                             
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_emif_arch_nf_191/sim/altera_emif_arch_nf_buf_udir_se_o.sv\"  -work altera_emif_arch_nf_191"                                             
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_emif_arch_nf_191/sim/altera_emif_arch_nf_core_clks_rsts.sv\"  -work altera_emif_arch_nf_191"                                            
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_emif_arch_nf_191/sim/altera_emif_arch_nf_io_tiles.sv\"  -work altera_emif_arch_nf_191"                                                  
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_emif_arch_nf_191/sim/altera_emif_arch_nf_io_tiles_abphy.sv\"  -work altera_emif_arch_nf_191"                                            
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_emif_arch_nf_191/sim/altera_emif_arch_nf_pll.sv\"  -work altera_emif_arch_nf_191"                                                       
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_emif_arch_nf_191/sim/twentynm_io_12_lane_abphy.sv\"  -work altera_emif_arch_nf_191"                                                     
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_emif_arch_nf_191/sim/twentynm_io_12_lane_encrypted_abphy.sv\"  -work altera_emif_arch_nf_191"                                           
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_emif_arch_nf_191/sim/twentynm_io_12_lane_nf5es_encrypted_abphy.sv\"  -work altera_emif_arch_nf_191"                                     
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_emif_arch_nf_191/sim/altera_emif_arch_nf_bufs.sv\"  -work altera_emif_arch_nf_191"                                                      
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_emif_arch_nf_191/sim/altera_emif_arch_nf_buf_unused.sv\"  -work altera_emif_arch_nf_191"                                                
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_emif_arch_nf_191/sim/altera_emif_arch_nf_cal_counter.sv\"  -work altera_emif_arch_nf_191"                                               
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_emif_arch_nf_191/sim/altera_emif_arch_nf_pll_fast_sim.sv\"  -work altera_emif_arch_nf_191"                                              
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_emif_arch_nf_191/sim/altera_emif_arch_nf_pll_extra_clks.sv\"  -work altera_emif_arch_nf_191"                                            
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_emif_arch_nf_191/sim/altera_emif_arch_nf_hps_clks_rsts.sv\"  -work altera_emif_arch_nf_191"                                             
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_emif_arch_nf_191/sim/altera_emif_arch_nf_io_tiles_wrap.sv\"  -work altera_emif_arch_nf_191"                                             
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_emif_arch_nf_191/sim/altera_emif_arch_nf_abphy_mux.sv\"  -work altera_emif_arch_nf_191"                                                 
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_emif_arch_nf_191/sim/altera_emif_arch_nf_hmc_avl_if.sv\"  -work altera_emif_arch_nf_191"                                                
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_emif_arch_nf_191/sim/altera_emif_arch_nf_hmc_sideband_if.sv\"  -work altera_emif_arch_nf_191"                                           
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_emif_arch_nf_191/sim/altera_emif_arch_nf_hmc_mmr_if.sv\"  -work altera_emif_arch_nf_191"                                                
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_emif_arch_nf_191/sim/altera_emif_arch_nf_hmc_amm_data_if.sv\"  -work altera_emif_arch_nf_191"                                           
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_emif_arch_nf_191/sim/altera_emif_arch_nf_hmc_ast_data_if.sv\"  -work altera_emif_arch_nf_191"                                           
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_emif_arch_nf_191/sim/altera_emif_arch_nf_afi_if.sv\"  -work altera_emif_arch_nf_191"                                                    
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_emif_arch_nf_191/sim/altera_emif_arch_nf_seq_if.sv\"  -work altera_emif_arch_nf_191"                                                    
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_emif_arch_nf_191/sim/altera_emif_arch_nf_regs.sv\"  -work altera_emif_arch_nf_191"                                                      
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_emif_arch_nf_191/sim/altera_oct.sv\"  -work altera_emif_arch_nf_191"                                                                    
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_emif_arch_nf_191/sim/altera_oct_um_fsm.sv\"  -work altera_emif_arch_nf_191"                                                             
    lappend design_files "vlogan +v2k $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_emif_arch_nf_191/sim/altera_std_synchronizer_nocut.v\"  -work altera_emif_arch_nf_191"                                                            
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_emif_arch_nf_191/sim/mem_array_abphy.sv\"  -work altera_emif_arch_nf_191"                                                               
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_emif_arch_nf_191/sim/io_12_lane_bcm__nf5es_abphy.sv\"  -work altera_emif_arch_nf_191"                                                   
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_emif_arch_nf_191/sim/io_12_lane__nf5es_abphy.sv\"  -work altera_emif_arch_nf_191"                                                       
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_emif_arch_nf_191/sim/top_emif_0_altera_emif_arch_nf_191_bclhany.sv\"  -work altera_emif_arch_nf_191"                                    
    lappend design_files "vlogan +v2k $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_avalon_mm_bridge_191/sim/top_emif_0_altera_avalon_mm_bridge_191_x6qdesi.v\"  -work altera_avalon_mm_bridge_191"                                   
    lappend design_files "vlogan +v2k $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_jtag_dc_streaming_191/sim/altera_avalon_st_jtag_interface.v\"  -work altera_jtag_dc_streaming_191"                                                
    lappend design_files "vlogan +v2k $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_jtag_dc_streaming_191/sim/altera_jtag_dc_streaming.v\"  -work altera_jtag_dc_streaming_191"                                                       
    lappend design_files "vlogan +v2k $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_jtag_dc_streaming_191/sim/altera_jtag_sld_node.v\"  -work altera_jtag_dc_streaming_191"                                                           
    lappend design_files "vlogan +v2k $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_jtag_dc_streaming_191/sim/altera_jtag_streaming.v\"  -work altera_jtag_dc_streaming_191"                                                          
    lappend design_files "vlogan +v2k $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_jtag_dc_streaming_191/sim/altera_avalon_st_clock_crosser.v\"  -work altera_jtag_dc_streaming_191"                                                 
    lappend design_files "vlogan +v2k $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_jtag_dc_streaming_191/sim/altera_std_synchronizer_nocut.v\"  -work altera_jtag_dc_streaming_191"                                                  
    lappend design_files "vlogan +v2k $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_jtag_dc_streaming_191/sim/altera_avalon_st_pipeline_base.v\"  -work altera_jtag_dc_streaming_191"                                                 
    lappend design_files "vlogan +v2k $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_jtag_dc_streaming_191/sim/altera_avalon_st_idle_remover.v\"  -work altera_jtag_dc_streaming_191"                                                  
    lappend design_files "vlogan +v2k $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_jtag_dc_streaming_191/sim/altera_avalon_st_idle_inserter.v\"  -work altera_jtag_dc_streaming_191"                                                 
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_jtag_dc_streaming_191/sim/altera_avalon_st_pipeline_stage.sv\"  -work altera_jtag_dc_streaming_191"                                     
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../timing_adapter_191/sim/top_emif_0_timing_adapter_191_rrgemwi.sv\"  -work timing_adapter_191"                                                   
    lappend design_files "vlogan +v2k $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_avalon_sc_fifo_191/sim/top_emif_0_altera_avalon_sc_fifo_191_e5eqkcq.v\"  -work altera_avalon_sc_fifo_191"                                         
    lappend design_files "vlogan +v2k $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_avalon_st_bytes_to_packets_191/sim/altera_avalon_st_bytes_to_packets.v\"  -work altera_avalon_st_bytes_to_packets_191"                            
    lappend design_files "vlogan +v2k $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_avalon_st_packets_to_bytes_191/sim/altera_avalon_st_packets_to_bytes.v\"  -work altera_avalon_st_packets_to_bytes_191"                            
    lappend design_files "vlogan +v2k $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_avalon_packets_to_master_191/sim/altera_avalon_packets_to_master.v\"  -work altera_avalon_packets_to_master_191"                                  
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../channel_adapter_191/sim/top_emif_0_channel_adapter_191_uc27kqq.sv\"  -work channel_adapter_191"                                                
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../channel_adapter_191/sim/top_emif_0_channel_adapter_191_cco4x3a.sv\"  -work channel_adapter_191"                                                
    lappend design_files "vlogan +v2k $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_reset_controller_191/sim/altera_reset_controller.v\"  -work altera_reset_controller_191"                                                          
    lappend design_files "vlogan +v2k $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_reset_controller_191/sim/altera_reset_synchronizer.v\"  -work altera_reset_controller_191"                                                        
    lappend design_files "vlogan +v2k $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../alt_mem_if_jtag_master_191/sim/top_emif_0_alt_mem_if_jtag_master_191_rksoe3i.v\"  -work alt_mem_if_jtag_master_191"                                      
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_merlin_master_translator_191/sim/top_emif_0_altera_merlin_master_translator_191_g7h47bq.sv\"  -work altera_merlin_master_translator_191"
    lappend design_files "vlogan +v2k -sverilog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_merlin_slave_translator_191/sim/top_emif_0_altera_merlin_slave_translator_191_x56fcki.sv\"  -work altera_merlin_slave_translator_191"   
    lappend design_files "vlogan +v2k $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_mm_interconnect_191/sim/top_emif_0_altera_mm_interconnect_191_3yb4cia.v\"  -work altera_mm_interconnect_191"                                      
    lappend design_files "vlogan +v2k $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_ip_col_if_191/sim/top_emif_0_altera_ip_col_if_191_ksrpnai.v\"  -work altera_ip_col_if_191"                                                        
    lappend design_files "vlogan +v2k $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_avalon_onchip_memory2_191/sim/top_emif_0_altera_avalon_onchip_memory2_191_qdw5d3q.v\"  -work altera_avalon_onchip_memory2_191"                    
    lappend design_files "vlogan +v2k $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_mm_interconnect_191/sim/top_emif_0_altera_mm_interconnect_191_dexdb4a.v\"  -work altera_mm_interconnect_191"                                      
    lappend design_files "vlogan +v2k $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_emif_cal_slave_nf_191/sim/top_emif_0_altera_emif_cal_slave_nf_191_rmzieji.v\"  -work altera_emif_cal_slave_nf_191"                                
    lappend design_files "vlogan +v2k $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_mm_interconnect_191/sim/top_emif_0_altera_mm_interconnect_191_monheay.v\"  -work altera_mm_interconnect_191"                                      
    lappend design_files "vlogan +v2k $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_emif_1910/sim/top_emif_0_altera_emif_1910_d3ribzq.v\"  -work altera_emif_1910"                                                                    
    lappend design_files "vlogan +v2k $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/top_emif_0.v\"  -work top_emif_0"                                                                                                                           
    return $design_files
  }
  
  proc get_elab_options {SIMULATOR_TOOL_BITNESS} {
    set ELAB_OPTIONS ""
    if ![ string match "bit_64" $SIMULATOR_TOOL_BITNESS ] {
    } else {
    }
    return $ELAB_OPTIONS
  }
  
  
  proc get_sim_options {SIMULATOR_TOOL_BITNESS} {
    set SIM_OPTIONS ""
    if ![ string match "bit_64" $SIMULATOR_TOOL_BITNESS ] {
    } else {
    }
    return $SIM_OPTIONS
  }
  
  
  proc get_env_variables {SIMULATOR_TOOL_BITNESS} {
    set ENV_VARIABLES [dict create]
    set LD_LIBRARY_PATH [dict create]
    dict set ENV_VARIABLES "LD_LIBRARY_PATH" $LD_LIBRARY_PATH
    if ![ string match "bit_64" $SIMULATOR_TOOL_BITNESS ] {
    } else {
    }
    return $ENV_VARIABLES
  }
  
  
}
