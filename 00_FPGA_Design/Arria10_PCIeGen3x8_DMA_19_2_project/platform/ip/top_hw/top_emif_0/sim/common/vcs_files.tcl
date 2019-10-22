
namespace eval top_emif_0 {
  proc get_memory_files {QSYS_SIMDIR} {
    set memory_files [list]
    lappend memory_files "$QSYS_SIMDIR/../altera_emif_arch_nf_191/sim/top_emif_0_altera_emif_arch_nf_191_bclhany_seq_params_sim.hex"
    lappend memory_files "$QSYS_SIMDIR/../altera_emif_arch_nf_191/sim/top_emif_0_altera_emif_arch_nf_191_bclhany_seq_params_synth.hex"
    lappend memory_files "$QSYS_SIMDIR/../altera_emif_arch_nf_191/sim/top_emif_0_altera_emif_arch_nf_191_bclhany_seq_cal.hex"
    lappend memory_files "$QSYS_SIMDIR/../altera_avalon_onchip_memory2_191/sim/seq_cal_soft_m20k.hex"
    return $memory_files
  }
  
  proc get_common_design_files {QSYS_SIMDIR} {
    set design_files [dict create]
    return $design_files
  }
  
  proc get_design_files {QSYS_SIMDIR} {
    set design_files [dict create]
    dict set design_files "top_emif_0_altera_emif_arch_nf_191_bclhany_top.sv"         "$QSYS_SIMDIR/../altera_emif_arch_nf_191/sim/top_emif_0_altera_emif_arch_nf_191_bclhany_top.sv"                    
    dict set design_files "top_emif_0_altera_emif_arch_nf_191_bclhany_io_aux.sv"      "$QSYS_SIMDIR/../altera_emif_arch_nf_191/sim/top_emif_0_altera_emif_arch_nf_191_bclhany_io_aux.sv"                 
    dict set design_files "altera_emif_arch_nf_oct.sv"                                "$QSYS_SIMDIR/../altera_emif_arch_nf_191/sim/altera_emif_arch_nf_oct.sv"                                           
    dict set design_files "altera_emif_arch_nf_buf_udir_df_o.sv"                      "$QSYS_SIMDIR/../altera_emif_arch_nf_191/sim/altera_emif_arch_nf_buf_udir_df_o.sv"                                 
    dict set design_files "altera_emif_arch_nf_buf_bdir_df.sv"                        "$QSYS_SIMDIR/../altera_emif_arch_nf_191/sim/altera_emif_arch_nf_buf_bdir_df.sv"                                   
    dict set design_files "altera_emif_arch_nf_buf_bdir_se.sv"                        "$QSYS_SIMDIR/../altera_emif_arch_nf_191/sim/altera_emif_arch_nf_buf_bdir_se.sv"                                   
    dict set design_files "altera_emif_arch_nf_buf_udir_cp_i.sv"                      "$QSYS_SIMDIR/../altera_emif_arch_nf_191/sim/altera_emif_arch_nf_buf_udir_cp_i.sv"                                 
    dict set design_files "altera_emif_arch_nf_buf_udir_df_i.sv"                      "$QSYS_SIMDIR/../altera_emif_arch_nf_191/sim/altera_emif_arch_nf_buf_udir_df_i.sv"                                 
    dict set design_files "altera_emif_arch_nf_buf_udir_se_i.sv"                      "$QSYS_SIMDIR/../altera_emif_arch_nf_191/sim/altera_emif_arch_nf_buf_udir_se_i.sv"                                 
    dict set design_files "altera_emif_arch_nf_buf_udir_se_o.sv"                      "$QSYS_SIMDIR/../altera_emif_arch_nf_191/sim/altera_emif_arch_nf_buf_udir_se_o.sv"                                 
    dict set design_files "altera_emif_arch_nf_core_clks_rsts.sv"                     "$QSYS_SIMDIR/../altera_emif_arch_nf_191/sim/altera_emif_arch_nf_core_clks_rsts.sv"                                
    dict set design_files "altera_emif_arch_nf_io_tiles.sv"                           "$QSYS_SIMDIR/../altera_emif_arch_nf_191/sim/altera_emif_arch_nf_io_tiles.sv"                                      
    dict set design_files "altera_emif_arch_nf_io_tiles_abphy.sv"                     "$QSYS_SIMDIR/../altera_emif_arch_nf_191/sim/altera_emif_arch_nf_io_tiles_abphy.sv"                                
    dict set design_files "altera_emif_arch_nf_pll.sv"                                "$QSYS_SIMDIR/../altera_emif_arch_nf_191/sim/altera_emif_arch_nf_pll.sv"                                           
    dict set design_files "twentynm_io_12_lane_abphy.sv"                              "$QSYS_SIMDIR/../altera_emif_arch_nf_191/sim/twentynm_io_12_lane_abphy.sv"                                         
    dict set design_files "twentynm_io_12_lane_encrypted_abphy.sv"                    "$QSYS_SIMDIR/../altera_emif_arch_nf_191/sim/twentynm_io_12_lane_encrypted_abphy.sv"                               
    dict set design_files "twentynm_io_12_lane_nf5es_encrypted_abphy.sv"              "$QSYS_SIMDIR/../altera_emif_arch_nf_191/sim/twentynm_io_12_lane_nf5es_encrypted_abphy.sv"                         
    dict set design_files "altera_emif_arch_nf_bufs.sv"                               "$QSYS_SIMDIR/../altera_emif_arch_nf_191/sim/altera_emif_arch_nf_bufs.sv"                                          
    dict set design_files "altera_emif_arch_nf_buf_unused.sv"                         "$QSYS_SIMDIR/../altera_emif_arch_nf_191/sim/altera_emif_arch_nf_buf_unused.sv"                                    
    dict set design_files "altera_emif_arch_nf_cal_counter.sv"                        "$QSYS_SIMDIR/../altera_emif_arch_nf_191/sim/altera_emif_arch_nf_cal_counter.sv"                                   
    dict set design_files "altera_emif_arch_nf_pll_fast_sim.sv"                       "$QSYS_SIMDIR/../altera_emif_arch_nf_191/sim/altera_emif_arch_nf_pll_fast_sim.sv"                                  
    dict set design_files "altera_emif_arch_nf_pll_extra_clks.sv"                     "$QSYS_SIMDIR/../altera_emif_arch_nf_191/sim/altera_emif_arch_nf_pll_extra_clks.sv"                                
    dict set design_files "altera_emif_arch_nf_hps_clks_rsts.sv"                      "$QSYS_SIMDIR/../altera_emif_arch_nf_191/sim/altera_emif_arch_nf_hps_clks_rsts.sv"                                 
    dict set design_files "altera_emif_arch_nf_io_tiles_wrap.sv"                      "$QSYS_SIMDIR/../altera_emif_arch_nf_191/sim/altera_emif_arch_nf_io_tiles_wrap.sv"                                 
    dict set design_files "altera_emif_arch_nf_abphy_mux.sv"                          "$QSYS_SIMDIR/../altera_emif_arch_nf_191/sim/altera_emif_arch_nf_abphy_mux.sv"                                     
    dict set design_files "altera_emif_arch_nf_hmc_avl_if.sv"                         "$QSYS_SIMDIR/../altera_emif_arch_nf_191/sim/altera_emif_arch_nf_hmc_avl_if.sv"                                    
    dict set design_files "altera_emif_arch_nf_hmc_sideband_if.sv"                    "$QSYS_SIMDIR/../altera_emif_arch_nf_191/sim/altera_emif_arch_nf_hmc_sideband_if.sv"                               
    dict set design_files "altera_emif_arch_nf_hmc_mmr_if.sv"                         "$QSYS_SIMDIR/../altera_emif_arch_nf_191/sim/altera_emif_arch_nf_hmc_mmr_if.sv"                                    
    dict set design_files "altera_emif_arch_nf_hmc_amm_data_if.sv"                    "$QSYS_SIMDIR/../altera_emif_arch_nf_191/sim/altera_emif_arch_nf_hmc_amm_data_if.sv"                               
    dict set design_files "altera_emif_arch_nf_hmc_ast_data_if.sv"                    "$QSYS_SIMDIR/../altera_emif_arch_nf_191/sim/altera_emif_arch_nf_hmc_ast_data_if.sv"                               
    dict set design_files "altera_emif_arch_nf_afi_if.sv"                             "$QSYS_SIMDIR/../altera_emif_arch_nf_191/sim/altera_emif_arch_nf_afi_if.sv"                                        
    dict set design_files "altera_emif_arch_nf_seq_if.sv"                             "$QSYS_SIMDIR/../altera_emif_arch_nf_191/sim/altera_emif_arch_nf_seq_if.sv"                                        
    dict set design_files "altera_emif_arch_nf_regs.sv"                               "$QSYS_SIMDIR/../altera_emif_arch_nf_191/sim/altera_emif_arch_nf_regs.sv"                                          
    dict set design_files "altera_oct.sv"                                             "$QSYS_SIMDIR/../altera_emif_arch_nf_191/sim/altera_oct.sv"                                                        
    dict set design_files "altera_oct_um_fsm.sv"                                      "$QSYS_SIMDIR/../altera_emif_arch_nf_191/sim/altera_oct_um_fsm.sv"                                                 
    dict set design_files "altera_std_synchronizer_nocut.v"                           "$QSYS_SIMDIR/../altera_emif_arch_nf_191/sim/altera_std_synchronizer_nocut.v"                                      
    dict set design_files "mem_array_abphy.sv"                                        "$QSYS_SIMDIR/../altera_emif_arch_nf_191/sim/mem_array_abphy.sv"                                                   
    dict set design_files "io_12_lane_bcm__nf5es_abphy.sv"                            "$QSYS_SIMDIR/../altera_emif_arch_nf_191/sim/io_12_lane_bcm__nf5es_abphy.sv"                                       
    dict set design_files "io_12_lane__nf5es_abphy.sv"                                "$QSYS_SIMDIR/../altera_emif_arch_nf_191/sim/io_12_lane__nf5es_abphy.sv"                                           
    dict set design_files "top_emif_0_altera_emif_arch_nf_191_bclhany.sv"             "$QSYS_SIMDIR/../altera_emif_arch_nf_191/sim/top_emif_0_altera_emif_arch_nf_191_bclhany.sv"                        
    dict set design_files "top_emif_0_altera_avalon_mm_bridge_191_x6qdesi.v"          "$QSYS_SIMDIR/../altera_avalon_mm_bridge_191/sim/top_emif_0_altera_avalon_mm_bridge_191_x6qdesi.v"                 
    dict set design_files "altera_avalon_st_jtag_interface.v"                         "$QSYS_SIMDIR/../altera_jtag_dc_streaming_191/sim/altera_avalon_st_jtag_interface.v"                               
    dict set design_files "altera_jtag_dc_streaming.v"                                "$QSYS_SIMDIR/../altera_jtag_dc_streaming_191/sim/altera_jtag_dc_streaming.v"                                      
    dict set design_files "altera_jtag_sld_node.v"                                    "$QSYS_SIMDIR/../altera_jtag_dc_streaming_191/sim/altera_jtag_sld_node.v"                                          
    dict set design_files "altera_jtag_streaming.v"                                   "$QSYS_SIMDIR/../altera_jtag_dc_streaming_191/sim/altera_jtag_streaming.v"                                         
    dict set design_files "altera_avalon_st_clock_crosser.v"                          "$QSYS_SIMDIR/../altera_jtag_dc_streaming_191/sim/altera_avalon_st_clock_crosser.v"                                
    dict set design_files "altera_std_synchronizer_nocut.v"                           "$QSYS_SIMDIR/../altera_jtag_dc_streaming_191/sim/altera_std_synchronizer_nocut.v"                                 
    dict set design_files "altera_avalon_st_pipeline_base.v"                          "$QSYS_SIMDIR/../altera_jtag_dc_streaming_191/sim/altera_avalon_st_pipeline_base.v"                                
    dict set design_files "altera_avalon_st_idle_remover.v"                           "$QSYS_SIMDIR/../altera_jtag_dc_streaming_191/sim/altera_avalon_st_idle_remover.v"                                 
    dict set design_files "altera_avalon_st_idle_inserter.v"                          "$QSYS_SIMDIR/../altera_jtag_dc_streaming_191/sim/altera_avalon_st_idle_inserter.v"                                
    dict set design_files "altera_avalon_st_pipeline_stage.sv"                        "$QSYS_SIMDIR/../altera_jtag_dc_streaming_191/sim/altera_avalon_st_pipeline_stage.sv"                              
    dict set design_files "top_emif_0_timing_adapter_191_rrgemwi.sv"                  "$QSYS_SIMDIR/../timing_adapter_191/sim/top_emif_0_timing_adapter_191_rrgemwi.sv"                                  
    dict set design_files "top_emif_0_altera_avalon_sc_fifo_191_e5eqkcq.v"            "$QSYS_SIMDIR/../altera_avalon_sc_fifo_191/sim/top_emif_0_altera_avalon_sc_fifo_191_e5eqkcq.v"                     
    dict set design_files "altera_avalon_st_bytes_to_packets.v"                       "$QSYS_SIMDIR/../altera_avalon_st_bytes_to_packets_191/sim/altera_avalon_st_bytes_to_packets.v"                    
    dict set design_files "altera_avalon_st_packets_to_bytes.v"                       "$QSYS_SIMDIR/../altera_avalon_st_packets_to_bytes_191/sim/altera_avalon_st_packets_to_bytes.v"                    
    dict set design_files "altera_avalon_packets_to_master.v"                         "$QSYS_SIMDIR/../altera_avalon_packets_to_master_191/sim/altera_avalon_packets_to_master.v"                        
    dict set design_files "top_emif_0_channel_adapter_191_uc27kqq.sv"                 "$QSYS_SIMDIR/../channel_adapter_191/sim/top_emif_0_channel_adapter_191_uc27kqq.sv"                                
    dict set design_files "top_emif_0_channel_adapter_191_cco4x3a.sv"                 "$QSYS_SIMDIR/../channel_adapter_191/sim/top_emif_0_channel_adapter_191_cco4x3a.sv"                                
    dict set design_files "altera_reset_controller.v"                                 "$QSYS_SIMDIR/../altera_reset_controller_191/sim/altera_reset_controller.v"                                        
    dict set design_files "altera_reset_synchronizer.v"                               "$QSYS_SIMDIR/../altera_reset_controller_191/sim/altera_reset_synchronizer.v"                                      
    dict set design_files "top_emif_0_alt_mem_if_jtag_master_191_rksoe3i.v"           "$QSYS_SIMDIR/../alt_mem_if_jtag_master_191/sim/top_emif_0_alt_mem_if_jtag_master_191_rksoe3i.v"                   
    dict set design_files "top_emif_0_altera_merlin_master_translator_191_g7h47bq.sv" "$QSYS_SIMDIR/../altera_merlin_master_translator_191/sim/top_emif_0_altera_merlin_master_translator_191_g7h47bq.sv"
    dict set design_files "top_emif_0_altera_merlin_slave_translator_191_x56fcki.sv"  "$QSYS_SIMDIR/../altera_merlin_slave_translator_191/sim/top_emif_0_altera_merlin_slave_translator_191_x56fcki.sv"  
    dict set design_files "top_emif_0_altera_mm_interconnect_191_3yb4cia.v"           "$QSYS_SIMDIR/../altera_mm_interconnect_191/sim/top_emif_0_altera_mm_interconnect_191_3yb4cia.v"                   
    dict set design_files "top_emif_0_altera_ip_col_if_191_ksrpnai.v"                 "$QSYS_SIMDIR/../altera_ip_col_if_191/sim/top_emif_0_altera_ip_col_if_191_ksrpnai.v"                               
    dict set design_files "top_emif_0_altera_avalon_onchip_memory2_191_qdw5d3q.v"     "$QSYS_SIMDIR/../altera_avalon_onchip_memory2_191/sim/top_emif_0_altera_avalon_onchip_memory2_191_qdw5d3q.v"       
    dict set design_files "top_emif_0_altera_mm_interconnect_191_dexdb4a.v"           "$QSYS_SIMDIR/../altera_mm_interconnect_191/sim/top_emif_0_altera_mm_interconnect_191_dexdb4a.v"                   
    dict set design_files "top_emif_0_altera_emif_cal_slave_nf_191_rmzieji.v"         "$QSYS_SIMDIR/../altera_emif_cal_slave_nf_191/sim/top_emif_0_altera_emif_cal_slave_nf_191_rmzieji.v"               
    dict set design_files "top_emif_0_altera_mm_interconnect_191_monheay.v"           "$QSYS_SIMDIR/../altera_mm_interconnect_191/sim/top_emif_0_altera_mm_interconnect_191_monheay.v"                   
    dict set design_files "top_emif_0_altera_emif_1910_d3ribzq.v"                     "$QSYS_SIMDIR/../altera_emif_1910/sim/top_emif_0_altera_emif_1910_d3ribzq.v"                                       
    dict set design_files "top_emif_0.v"                                              "$QSYS_SIMDIR/top_emif_0.v"                                                                                        
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
