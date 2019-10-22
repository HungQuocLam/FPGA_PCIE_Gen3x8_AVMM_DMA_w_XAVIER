module top_hw (
		input  wire [31:0] hip_ctrl_test_in,                //           hip_ctrl.test_in
		input  wire        hip_ctrl_simu_mode_pipe,         //                   .simu_mode_pipe
		input  wire        hip_pipe_sim_pipe_pclk_in,       //           hip_pipe.sim_pipe_pclk_in
		output wire [1:0]  hip_pipe_sim_pipe_rate,          //                   .sim_pipe_rate
		output wire [4:0]  hip_pipe_sim_ltssmstate,         //                   .sim_ltssmstate
		output wire [2:0]  hip_pipe_eidleinfersel0,         //                   .eidleinfersel0
		output wire [2:0]  hip_pipe_eidleinfersel1,         //                   .eidleinfersel1
		output wire [2:0]  hip_pipe_eidleinfersel2,         //                   .eidleinfersel2
		output wire [2:0]  hip_pipe_eidleinfersel3,         //                   .eidleinfersel3
		output wire [2:0]  hip_pipe_eidleinfersel4,         //                   .eidleinfersel4
		output wire [2:0]  hip_pipe_eidleinfersel5,         //                   .eidleinfersel5
		output wire [2:0]  hip_pipe_eidleinfersel6,         //                   .eidleinfersel6
		output wire [2:0]  hip_pipe_eidleinfersel7,         //                   .eidleinfersel7
		output wire [1:0]  hip_pipe_powerdown0,             //                   .powerdown0
		output wire [1:0]  hip_pipe_powerdown1,             //                   .powerdown1
		output wire [1:0]  hip_pipe_powerdown2,             //                   .powerdown2
		output wire [1:0]  hip_pipe_powerdown3,             //                   .powerdown3
		output wire [1:0]  hip_pipe_powerdown4,             //                   .powerdown4
		output wire [1:0]  hip_pipe_powerdown5,             //                   .powerdown5
		output wire [1:0]  hip_pipe_powerdown6,             //                   .powerdown6
		output wire [1:0]  hip_pipe_powerdown7,             //                   .powerdown7
		output wire        hip_pipe_rxpolarity0,            //                   .rxpolarity0
		output wire        hip_pipe_rxpolarity1,            //                   .rxpolarity1
		output wire        hip_pipe_rxpolarity2,            //                   .rxpolarity2
		output wire        hip_pipe_rxpolarity3,            //                   .rxpolarity3
		output wire        hip_pipe_rxpolarity4,            //                   .rxpolarity4
		output wire        hip_pipe_rxpolarity5,            //                   .rxpolarity5
		output wire        hip_pipe_rxpolarity6,            //                   .rxpolarity6
		output wire        hip_pipe_rxpolarity7,            //                   .rxpolarity7
		output wire        hip_pipe_txcompl0,               //                   .txcompl0
		output wire        hip_pipe_txcompl1,               //                   .txcompl1
		output wire        hip_pipe_txcompl2,               //                   .txcompl2
		output wire        hip_pipe_txcompl3,               //                   .txcompl3
		output wire        hip_pipe_txcompl4,               //                   .txcompl4
		output wire        hip_pipe_txcompl5,               //                   .txcompl5
		output wire        hip_pipe_txcompl6,               //                   .txcompl6
		output wire        hip_pipe_txcompl7,               //                   .txcompl7
		output wire [31:0] hip_pipe_txdata0,                //                   .txdata0
		output wire [31:0] hip_pipe_txdata1,                //                   .txdata1
		output wire [31:0] hip_pipe_txdata2,                //                   .txdata2
		output wire [31:0] hip_pipe_txdata3,                //                   .txdata3
		output wire [31:0] hip_pipe_txdata4,                //                   .txdata4
		output wire [31:0] hip_pipe_txdata5,                //                   .txdata5
		output wire [31:0] hip_pipe_txdata6,                //                   .txdata6
		output wire [31:0] hip_pipe_txdata7,                //                   .txdata7
		output wire [3:0]  hip_pipe_txdatak0,               //                   .txdatak0
		output wire [3:0]  hip_pipe_txdatak1,               //                   .txdatak1
		output wire [3:0]  hip_pipe_txdatak2,               //                   .txdatak2
		output wire [3:0]  hip_pipe_txdatak3,               //                   .txdatak3
		output wire [3:0]  hip_pipe_txdatak4,               //                   .txdatak4
		output wire [3:0]  hip_pipe_txdatak5,               //                   .txdatak5
		output wire [3:0]  hip_pipe_txdatak6,               //                   .txdatak6
		output wire [3:0]  hip_pipe_txdatak7,               //                   .txdatak7
		output wire        hip_pipe_txdetectrx0,            //                   .txdetectrx0
		output wire        hip_pipe_txdetectrx1,            //                   .txdetectrx1
		output wire        hip_pipe_txdetectrx2,            //                   .txdetectrx2
		output wire        hip_pipe_txdetectrx3,            //                   .txdetectrx3
		output wire        hip_pipe_txdetectrx4,            //                   .txdetectrx4
		output wire        hip_pipe_txdetectrx5,            //                   .txdetectrx5
		output wire        hip_pipe_txdetectrx6,            //                   .txdetectrx6
		output wire        hip_pipe_txdetectrx7,            //                   .txdetectrx7
		output wire        hip_pipe_txelecidle0,            //                   .txelecidle0
		output wire        hip_pipe_txelecidle1,            //                   .txelecidle1
		output wire        hip_pipe_txelecidle2,            //                   .txelecidle2
		output wire        hip_pipe_txelecidle3,            //                   .txelecidle3
		output wire        hip_pipe_txelecidle4,            //                   .txelecidle4
		output wire        hip_pipe_txelecidle5,            //                   .txelecidle5
		output wire        hip_pipe_txelecidle6,            //                   .txelecidle6
		output wire        hip_pipe_txelecidle7,            //                   .txelecidle7
		output wire        hip_pipe_txdeemph0,              //                   .txdeemph0
		output wire        hip_pipe_txdeemph1,              //                   .txdeemph1
		output wire        hip_pipe_txdeemph2,              //                   .txdeemph2
		output wire        hip_pipe_txdeemph3,              //                   .txdeemph3
		output wire        hip_pipe_txdeemph4,              //                   .txdeemph4
		output wire        hip_pipe_txdeemph5,              //                   .txdeemph5
		output wire        hip_pipe_txdeemph6,              //                   .txdeemph6
		output wire        hip_pipe_txdeemph7,              //                   .txdeemph7
		output wire [2:0]  hip_pipe_txmargin0,              //                   .txmargin0
		output wire [2:0]  hip_pipe_txmargin1,              //                   .txmargin1
		output wire [2:0]  hip_pipe_txmargin2,              //                   .txmargin2
		output wire [2:0]  hip_pipe_txmargin3,              //                   .txmargin3
		output wire [2:0]  hip_pipe_txmargin4,              //                   .txmargin4
		output wire [2:0]  hip_pipe_txmargin5,              //                   .txmargin5
		output wire [2:0]  hip_pipe_txmargin6,              //                   .txmargin6
		output wire [2:0]  hip_pipe_txmargin7,              //                   .txmargin7
		output wire        hip_pipe_txswing0,               //                   .txswing0
		output wire        hip_pipe_txswing1,               //                   .txswing1
		output wire        hip_pipe_txswing2,               //                   .txswing2
		output wire        hip_pipe_txswing3,               //                   .txswing3
		output wire        hip_pipe_txswing4,               //                   .txswing4
		output wire        hip_pipe_txswing5,               //                   .txswing5
		output wire        hip_pipe_txswing6,               //                   .txswing6
		output wire        hip_pipe_txswing7,               //                   .txswing7
		input  wire        hip_pipe_phystatus0,             //                   .phystatus0
		input  wire        hip_pipe_phystatus1,             //                   .phystatus1
		input  wire        hip_pipe_phystatus2,             //                   .phystatus2
		input  wire        hip_pipe_phystatus3,             //                   .phystatus3
		input  wire        hip_pipe_phystatus4,             //                   .phystatus4
		input  wire        hip_pipe_phystatus5,             //                   .phystatus5
		input  wire        hip_pipe_phystatus6,             //                   .phystatus6
		input  wire        hip_pipe_phystatus7,             //                   .phystatus7
		input  wire [31:0] hip_pipe_rxdata0,                //                   .rxdata0
		input  wire [31:0] hip_pipe_rxdata1,                //                   .rxdata1
		input  wire [31:0] hip_pipe_rxdata2,                //                   .rxdata2
		input  wire [31:0] hip_pipe_rxdata3,                //                   .rxdata3
		input  wire [31:0] hip_pipe_rxdata4,                //                   .rxdata4
		input  wire [31:0] hip_pipe_rxdata5,                //                   .rxdata5
		input  wire [31:0] hip_pipe_rxdata6,                //                   .rxdata6
		input  wire [31:0] hip_pipe_rxdata7,                //                   .rxdata7
		input  wire [3:0]  hip_pipe_rxdatak0,               //                   .rxdatak0
		input  wire [3:0]  hip_pipe_rxdatak1,               //                   .rxdatak1
		input  wire [3:0]  hip_pipe_rxdatak2,               //                   .rxdatak2
		input  wire [3:0]  hip_pipe_rxdatak3,               //                   .rxdatak3
		input  wire [3:0]  hip_pipe_rxdatak4,               //                   .rxdatak4
		input  wire [3:0]  hip_pipe_rxdatak5,               //                   .rxdatak5
		input  wire [3:0]  hip_pipe_rxdatak6,               //                   .rxdatak6
		input  wire [3:0]  hip_pipe_rxdatak7,               //                   .rxdatak7
		input  wire        hip_pipe_rxelecidle0,            //                   .rxelecidle0
		input  wire        hip_pipe_rxelecidle1,            //                   .rxelecidle1
		input  wire        hip_pipe_rxelecidle2,            //                   .rxelecidle2
		input  wire        hip_pipe_rxelecidle3,            //                   .rxelecidle3
		input  wire        hip_pipe_rxelecidle4,            //                   .rxelecidle4
		input  wire        hip_pipe_rxelecidle5,            //                   .rxelecidle5
		input  wire        hip_pipe_rxelecidle6,            //                   .rxelecidle6
		input  wire        hip_pipe_rxelecidle7,            //                   .rxelecidle7
		input  wire [2:0]  hip_pipe_rxstatus0,              //                   .rxstatus0
		input  wire [2:0]  hip_pipe_rxstatus1,              //                   .rxstatus1
		input  wire [2:0]  hip_pipe_rxstatus2,              //                   .rxstatus2
		input  wire [2:0]  hip_pipe_rxstatus3,              //                   .rxstatus3
		input  wire [2:0]  hip_pipe_rxstatus4,              //                   .rxstatus4
		input  wire [2:0]  hip_pipe_rxstatus5,              //                   .rxstatus5
		input  wire [2:0]  hip_pipe_rxstatus6,              //                   .rxstatus6
		input  wire [2:0]  hip_pipe_rxstatus7,              //                   .rxstatus7
		input  wire        hip_pipe_rxvalid0,               //                   .rxvalid0
		input  wire        hip_pipe_rxvalid1,               //                   .rxvalid1
		input  wire        hip_pipe_rxvalid2,               //                   .rxvalid2
		input  wire        hip_pipe_rxvalid3,               //                   .rxvalid3
		input  wire        hip_pipe_rxvalid4,               //                   .rxvalid4
		input  wire        hip_pipe_rxvalid5,               //                   .rxvalid5
		input  wire        hip_pipe_rxvalid6,               //                   .rxvalid6
		input  wire        hip_pipe_rxvalid7,               //                   .rxvalid7
		input  wire        hip_pipe_rxdataskip0,            //                   .rxdataskip0
		input  wire        hip_pipe_rxdataskip1,            //                   .rxdataskip1
		input  wire        hip_pipe_rxdataskip2,            //                   .rxdataskip2
		input  wire        hip_pipe_rxdataskip3,            //                   .rxdataskip3
		input  wire        hip_pipe_rxdataskip4,            //                   .rxdataskip4
		input  wire        hip_pipe_rxdataskip5,            //                   .rxdataskip5
		input  wire        hip_pipe_rxdataskip6,            //                   .rxdataskip6
		input  wire        hip_pipe_rxdataskip7,            //                   .rxdataskip7
		input  wire        hip_pipe_rxblkst0,               //                   .rxblkst0
		input  wire        hip_pipe_rxblkst1,               //                   .rxblkst1
		input  wire        hip_pipe_rxblkst2,               //                   .rxblkst2
		input  wire        hip_pipe_rxblkst3,               //                   .rxblkst3
		input  wire        hip_pipe_rxblkst4,               //                   .rxblkst4
		input  wire        hip_pipe_rxblkst5,               //                   .rxblkst5
		input  wire        hip_pipe_rxblkst6,               //                   .rxblkst6
		input  wire        hip_pipe_rxblkst7,               //                   .rxblkst7
		input  wire [1:0]  hip_pipe_rxsynchd0,              //                   .rxsynchd0
		input  wire [1:0]  hip_pipe_rxsynchd1,              //                   .rxsynchd1
		input  wire [1:0]  hip_pipe_rxsynchd2,              //                   .rxsynchd2
		input  wire [1:0]  hip_pipe_rxsynchd3,              //                   .rxsynchd3
		input  wire [1:0]  hip_pipe_rxsynchd4,              //                   .rxsynchd4
		input  wire [1:0]  hip_pipe_rxsynchd5,              //                   .rxsynchd5
		input  wire [1:0]  hip_pipe_rxsynchd6,              //                   .rxsynchd6
		input  wire [1:0]  hip_pipe_rxsynchd7,              //                   .rxsynchd7
		output wire [17:0] hip_pipe_currentcoeff0,          //                   .currentcoeff0
		output wire [17:0] hip_pipe_currentcoeff1,          //                   .currentcoeff1
		output wire [17:0] hip_pipe_currentcoeff2,          //                   .currentcoeff2
		output wire [17:0] hip_pipe_currentcoeff3,          //                   .currentcoeff3
		output wire [17:0] hip_pipe_currentcoeff4,          //                   .currentcoeff4
		output wire [17:0] hip_pipe_currentcoeff5,          //                   .currentcoeff5
		output wire [17:0] hip_pipe_currentcoeff6,          //                   .currentcoeff6
		output wire [17:0] hip_pipe_currentcoeff7,          //                   .currentcoeff7
		output wire [2:0]  hip_pipe_currentrxpreset0,       //                   .currentrxpreset0
		output wire [2:0]  hip_pipe_currentrxpreset1,       //                   .currentrxpreset1
		output wire [2:0]  hip_pipe_currentrxpreset2,       //                   .currentrxpreset2
		output wire [2:0]  hip_pipe_currentrxpreset3,       //                   .currentrxpreset3
		output wire [2:0]  hip_pipe_currentrxpreset4,       //                   .currentrxpreset4
		output wire [2:0]  hip_pipe_currentrxpreset5,       //                   .currentrxpreset5
		output wire [2:0]  hip_pipe_currentrxpreset6,       //                   .currentrxpreset6
		output wire [2:0]  hip_pipe_currentrxpreset7,       //                   .currentrxpreset7
		output wire [1:0]  hip_pipe_txsynchd0,              //                   .txsynchd0
		output wire [1:0]  hip_pipe_txsynchd1,              //                   .txsynchd1
		output wire [1:0]  hip_pipe_txsynchd2,              //                   .txsynchd2
		output wire [1:0]  hip_pipe_txsynchd3,              //                   .txsynchd3
		output wire [1:0]  hip_pipe_txsynchd4,              //                   .txsynchd4
		output wire [1:0]  hip_pipe_txsynchd5,              //                   .txsynchd5
		output wire [1:0]  hip_pipe_txsynchd6,              //                   .txsynchd6
		output wire [1:0]  hip_pipe_txsynchd7,              //                   .txsynchd7
		output wire        hip_pipe_txblkst0,               //                   .txblkst0
		output wire        hip_pipe_txblkst1,               //                   .txblkst1
		output wire        hip_pipe_txblkst2,               //                   .txblkst2
		output wire        hip_pipe_txblkst3,               //                   .txblkst3
		output wire        hip_pipe_txblkst4,               //                   .txblkst4
		output wire        hip_pipe_txblkst5,               //                   .txblkst5
		output wire        hip_pipe_txblkst6,               //                   .txblkst6
		output wire        hip_pipe_txblkst7,               //                   .txblkst7
		output wire        hip_pipe_txdataskip0,            //                   .txdataskip0
		output wire        hip_pipe_txdataskip1,            //                   .txdataskip1
		output wire        hip_pipe_txdataskip2,            //                   .txdataskip2
		output wire        hip_pipe_txdataskip3,            //                   .txdataskip3
		output wire        hip_pipe_txdataskip4,            //                   .txdataskip4
		output wire        hip_pipe_txdataskip5,            //                   .txdataskip5
		output wire        hip_pipe_txdataskip6,            //                   .txdataskip6
		output wire        hip_pipe_txdataskip7,            //                   .txdataskip7
		output wire [1:0]  hip_pipe_rate0,                  //                   .rate0
		output wire [1:0]  hip_pipe_rate1,                  //                   .rate1
		output wire [1:0]  hip_pipe_rate2,                  //                   .rate2
		output wire [1:0]  hip_pipe_rate3,                  //                   .rate3
		output wire [1:0]  hip_pipe_rate4,                  //                   .rate4
		output wire [1:0]  hip_pipe_rate5,                  //                   .rate5
		output wire [1:0]  hip_pipe_rate6,                  //                   .rate6
		output wire [1:0]  hip_pipe_rate7,                  //                   .rate7
		input  wire        hip_serial_rx_in0,               //         hip_serial.rx_in0
		input  wire        hip_serial_rx_in1,               //                   .rx_in1
		input  wire        hip_serial_rx_in2,               //                   .rx_in2
		input  wire        hip_serial_rx_in3,               //                   .rx_in3
		input  wire        hip_serial_rx_in4,               //                   .rx_in4
		input  wire        hip_serial_rx_in5,               //                   .rx_in5
		input  wire        hip_serial_rx_in6,               //                   .rx_in6
		input  wire        hip_serial_rx_in7,               //                   .rx_in7
		output wire        hip_serial_tx_out0,              //                   .tx_out0
		output wire        hip_serial_tx_out1,              //                   .tx_out1
		output wire        hip_serial_tx_out2,              //                   .tx_out2
		output wire        hip_serial_tx_out3,              //                   .tx_out3
		output wire        hip_serial_tx_out4,              //                   .tx_out4
		output wire        hip_serial_tx_out5,              //                   .tx_out5
		output wire        hip_serial_tx_out6,              //                   .tx_out6
		output wire        hip_serial_tx_out7,              //                   .tx_out7
		input  wire        dut_npor_npor,                   //           dut_npor.npor
		input  wire        dut_npor_pin_perst,              //                   .pin_perst
		input  wire        refclk_clk,                      //             refclk.clk
		output wire        core_clk_out_clk,                //       core_clk_out.clk
		output wire [0:0]  emif_0_mem_mem_ck,               //         emif_0_mem.mem_ck
		output wire [0:0]  emif_0_mem_mem_ck_n,             //                   .mem_ck_n
		output wire [16:0] emif_0_mem_mem_a,                //                   .mem_a
		output wire [0:0]  emif_0_mem_mem_act_n,            //                   .mem_act_n
		output wire [1:0]  emif_0_mem_mem_ba,               //                   .mem_ba
		output wire [0:0]  emif_0_mem_mem_bg,               //                   .mem_bg
		output wire [0:0]  emif_0_mem_mem_cke,              //                   .mem_cke
		output wire [0:0]  emif_0_mem_mem_cs_n,             //                   .mem_cs_n
		output wire [0:0]  emif_0_mem_mem_odt,              //                   .mem_odt
		output wire [0:0]  emif_0_mem_mem_reset_n,          //                   .mem_reset_n
		inout  wire [7:0]  emif_0_mem_mem_dqs,              //                   .mem_dqs
		inout  wire [7:0]  emif_0_mem_mem_dqs_n,            //                   .mem_dqs_n
		inout  wire [63:0] emif_0_mem_mem_dq,               //                   .mem_dq
		inout  wire [7:0]  emif_0_mem_mem_dbi_n,            //                   .mem_dbi_n
		input  wire        emif_0_oct_oct_rzqin,            //         emif_0_oct.oct_rzqin
		input  wire        emif_0_pll_ref_clk_clk,          // emif_0_pll_ref_clk.clk
		output wire        emif_0_status_local_cal_success, //      emif_0_status.local_cal_success
		output wire        emif_0_status_local_cal_fail     //                   .local_cal_fail
	);
endmodule

