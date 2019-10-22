module top_DUT (
		output wire         coreclkout_hip,           //    coreclkout_hip.clk
		input  wire         refclk,                   //            refclk.clk
		input  wire         npor,                     //              npor.npor
		input  wire         pin_perst,                //                  .pin_perst
		output wire         app_nreset_status,        // app_nreset_status.reset_n
		input  wire [31:0]  test_in,                  //          hip_ctrl.test_in
		input  wire         simu_mode_pipe,           //                  .simu_mode_pipe
		input  wire         sim_pipe_pclk_in,         //          hip_pipe.sim_pipe_pclk_in
		output wire [1:0]   sim_pipe_rate,            //                  .sim_pipe_rate
		output wire [4:0]   sim_ltssmstate,           //                  .sim_ltssmstate
		output wire [2:0]   eidleinfersel0,           //                  .eidleinfersel0
		output wire [2:0]   eidleinfersel1,           //                  .eidleinfersel1
		output wire [2:0]   eidleinfersel2,           //                  .eidleinfersel2
		output wire [2:0]   eidleinfersel3,           //                  .eidleinfersel3
		output wire [2:0]   eidleinfersel4,           //                  .eidleinfersel4
		output wire [2:0]   eidleinfersel5,           //                  .eidleinfersel5
		output wire [2:0]   eidleinfersel6,           //                  .eidleinfersel6
		output wire [2:0]   eidleinfersel7,           //                  .eidleinfersel7
		output wire [1:0]   powerdown0,               //                  .powerdown0
		output wire [1:0]   powerdown1,               //                  .powerdown1
		output wire [1:0]   powerdown2,               //                  .powerdown2
		output wire [1:0]   powerdown3,               //                  .powerdown3
		output wire [1:0]   powerdown4,               //                  .powerdown4
		output wire [1:0]   powerdown5,               //                  .powerdown5
		output wire [1:0]   powerdown6,               //                  .powerdown6
		output wire [1:0]   powerdown7,               //                  .powerdown7
		output wire         rxpolarity0,              //                  .rxpolarity0
		output wire         rxpolarity1,              //                  .rxpolarity1
		output wire         rxpolarity2,              //                  .rxpolarity2
		output wire         rxpolarity3,              //                  .rxpolarity3
		output wire         rxpolarity4,              //                  .rxpolarity4
		output wire         rxpolarity5,              //                  .rxpolarity5
		output wire         rxpolarity6,              //                  .rxpolarity6
		output wire         rxpolarity7,              //                  .rxpolarity7
		output wire         txcompl0,                 //                  .txcompl0
		output wire         txcompl1,                 //                  .txcompl1
		output wire         txcompl2,                 //                  .txcompl2
		output wire         txcompl3,                 //                  .txcompl3
		output wire         txcompl4,                 //                  .txcompl4
		output wire         txcompl5,                 //                  .txcompl5
		output wire         txcompl6,                 //                  .txcompl6
		output wire         txcompl7,                 //                  .txcompl7
		output wire [31:0]  txdata0,                  //                  .txdata0
		output wire [31:0]  txdata1,                  //                  .txdata1
		output wire [31:0]  txdata2,                  //                  .txdata2
		output wire [31:0]  txdata3,                  //                  .txdata3
		output wire [31:0]  txdata4,                  //                  .txdata4
		output wire [31:0]  txdata5,                  //                  .txdata5
		output wire [31:0]  txdata6,                  //                  .txdata6
		output wire [31:0]  txdata7,                  //                  .txdata7
		output wire [3:0]   txdatak0,                 //                  .txdatak0
		output wire [3:0]   txdatak1,                 //                  .txdatak1
		output wire [3:0]   txdatak2,                 //                  .txdatak2
		output wire [3:0]   txdatak3,                 //                  .txdatak3
		output wire [3:0]   txdatak4,                 //                  .txdatak4
		output wire [3:0]   txdatak5,                 //                  .txdatak5
		output wire [3:0]   txdatak6,                 //                  .txdatak6
		output wire [3:0]   txdatak7,                 //                  .txdatak7
		output wire         txdetectrx0,              //                  .txdetectrx0
		output wire         txdetectrx1,              //                  .txdetectrx1
		output wire         txdetectrx2,              //                  .txdetectrx2
		output wire         txdetectrx3,              //                  .txdetectrx3
		output wire         txdetectrx4,              //                  .txdetectrx4
		output wire         txdetectrx5,              //                  .txdetectrx5
		output wire         txdetectrx6,              //                  .txdetectrx6
		output wire         txdetectrx7,              //                  .txdetectrx7
		output wire         txelecidle0,              //                  .txelecidle0
		output wire         txelecidle1,              //                  .txelecidle1
		output wire         txelecidle2,              //                  .txelecidle2
		output wire         txelecidle3,              //                  .txelecidle3
		output wire         txelecidle4,              //                  .txelecidle4
		output wire         txelecidle5,              //                  .txelecidle5
		output wire         txelecidle6,              //                  .txelecidle6
		output wire         txelecidle7,              //                  .txelecidle7
		output wire         txdeemph0,                //                  .txdeemph0
		output wire         txdeemph1,                //                  .txdeemph1
		output wire         txdeemph2,                //                  .txdeemph2
		output wire         txdeemph3,                //                  .txdeemph3
		output wire         txdeemph4,                //                  .txdeemph4
		output wire         txdeemph5,                //                  .txdeemph5
		output wire         txdeemph6,                //                  .txdeemph6
		output wire         txdeemph7,                //                  .txdeemph7
		output wire [2:0]   txmargin0,                //                  .txmargin0
		output wire [2:0]   txmargin1,                //                  .txmargin1
		output wire [2:0]   txmargin2,                //                  .txmargin2
		output wire [2:0]   txmargin3,                //                  .txmargin3
		output wire [2:0]   txmargin4,                //                  .txmargin4
		output wire [2:0]   txmargin5,                //                  .txmargin5
		output wire [2:0]   txmargin6,                //                  .txmargin6
		output wire [2:0]   txmargin7,                //                  .txmargin7
		output wire         txswing0,                 //                  .txswing0
		output wire         txswing1,                 //                  .txswing1
		output wire         txswing2,                 //                  .txswing2
		output wire         txswing3,                 //                  .txswing3
		output wire         txswing4,                 //                  .txswing4
		output wire         txswing5,                 //                  .txswing5
		output wire         txswing6,                 //                  .txswing6
		output wire         txswing7,                 //                  .txswing7
		input  wire         phystatus0,               //                  .phystatus0
		input  wire         phystatus1,               //                  .phystatus1
		input  wire         phystatus2,               //                  .phystatus2
		input  wire         phystatus3,               //                  .phystatus3
		input  wire         phystatus4,               //                  .phystatus4
		input  wire         phystatus5,               //                  .phystatus5
		input  wire         phystatus6,               //                  .phystatus6
		input  wire         phystatus7,               //                  .phystatus7
		input  wire [31:0]  rxdata0,                  //                  .rxdata0
		input  wire [31:0]  rxdata1,                  //                  .rxdata1
		input  wire [31:0]  rxdata2,                  //                  .rxdata2
		input  wire [31:0]  rxdata3,                  //                  .rxdata3
		input  wire [31:0]  rxdata4,                  //                  .rxdata4
		input  wire [31:0]  rxdata5,                  //                  .rxdata5
		input  wire [31:0]  rxdata6,                  //                  .rxdata6
		input  wire [31:0]  rxdata7,                  //                  .rxdata7
		input  wire [3:0]   rxdatak0,                 //                  .rxdatak0
		input  wire [3:0]   rxdatak1,                 //                  .rxdatak1
		input  wire [3:0]   rxdatak2,                 //                  .rxdatak2
		input  wire [3:0]   rxdatak3,                 //                  .rxdatak3
		input  wire [3:0]   rxdatak4,                 //                  .rxdatak4
		input  wire [3:0]   rxdatak5,                 //                  .rxdatak5
		input  wire [3:0]   rxdatak6,                 //                  .rxdatak6
		input  wire [3:0]   rxdatak7,                 //                  .rxdatak7
		input  wire         rxelecidle0,              //                  .rxelecidle0
		input  wire         rxelecidle1,              //                  .rxelecidle1
		input  wire         rxelecidle2,              //                  .rxelecidle2
		input  wire         rxelecidle3,              //                  .rxelecidle3
		input  wire         rxelecidle4,              //                  .rxelecidle4
		input  wire         rxelecidle5,              //                  .rxelecidle5
		input  wire         rxelecidle6,              //                  .rxelecidle6
		input  wire         rxelecidle7,              //                  .rxelecidle7
		input  wire [2:0]   rxstatus0,                //                  .rxstatus0
		input  wire [2:0]   rxstatus1,                //                  .rxstatus1
		input  wire [2:0]   rxstatus2,                //                  .rxstatus2
		input  wire [2:0]   rxstatus3,                //                  .rxstatus3
		input  wire [2:0]   rxstatus4,                //                  .rxstatus4
		input  wire [2:0]   rxstatus5,                //                  .rxstatus5
		input  wire [2:0]   rxstatus6,                //                  .rxstatus6
		input  wire [2:0]   rxstatus7,                //                  .rxstatus7
		input  wire         rxvalid0,                 //                  .rxvalid0
		input  wire         rxvalid1,                 //                  .rxvalid1
		input  wire         rxvalid2,                 //                  .rxvalid2
		input  wire         rxvalid3,                 //                  .rxvalid3
		input  wire         rxvalid4,                 //                  .rxvalid4
		input  wire         rxvalid5,                 //                  .rxvalid5
		input  wire         rxvalid6,                 //                  .rxvalid6
		input  wire         rxvalid7,                 //                  .rxvalid7
		input  wire         rxdataskip0,              //                  .rxdataskip0
		input  wire         rxdataskip1,              //                  .rxdataskip1
		input  wire         rxdataskip2,              //                  .rxdataskip2
		input  wire         rxdataskip3,              //                  .rxdataskip3
		input  wire         rxdataskip4,              //                  .rxdataskip4
		input  wire         rxdataskip5,              //                  .rxdataskip5
		input  wire         rxdataskip6,              //                  .rxdataskip6
		input  wire         rxdataskip7,              //                  .rxdataskip7
		input  wire         rxblkst0,                 //                  .rxblkst0
		input  wire         rxblkst1,                 //                  .rxblkst1
		input  wire         rxblkst2,                 //                  .rxblkst2
		input  wire         rxblkst3,                 //                  .rxblkst3
		input  wire         rxblkst4,                 //                  .rxblkst4
		input  wire         rxblkst5,                 //                  .rxblkst5
		input  wire         rxblkst6,                 //                  .rxblkst6
		input  wire         rxblkst7,                 //                  .rxblkst7
		input  wire [1:0]   rxsynchd0,                //                  .rxsynchd0
		input  wire [1:0]   rxsynchd1,                //                  .rxsynchd1
		input  wire [1:0]   rxsynchd2,                //                  .rxsynchd2
		input  wire [1:0]   rxsynchd3,                //                  .rxsynchd3
		input  wire [1:0]   rxsynchd4,                //                  .rxsynchd4
		input  wire [1:0]   rxsynchd5,                //                  .rxsynchd5
		input  wire [1:0]   rxsynchd6,                //                  .rxsynchd6
		input  wire [1:0]   rxsynchd7,                //                  .rxsynchd7
		output wire [17:0]  currentcoeff0,            //                  .currentcoeff0
		output wire [17:0]  currentcoeff1,            //                  .currentcoeff1
		output wire [17:0]  currentcoeff2,            //                  .currentcoeff2
		output wire [17:0]  currentcoeff3,            //                  .currentcoeff3
		output wire [17:0]  currentcoeff4,            //                  .currentcoeff4
		output wire [17:0]  currentcoeff5,            //                  .currentcoeff5
		output wire [17:0]  currentcoeff6,            //                  .currentcoeff6
		output wire [17:0]  currentcoeff7,            //                  .currentcoeff7
		output wire [2:0]   currentrxpreset0,         //                  .currentrxpreset0
		output wire [2:0]   currentrxpreset1,         //                  .currentrxpreset1
		output wire [2:0]   currentrxpreset2,         //                  .currentrxpreset2
		output wire [2:0]   currentrxpreset3,         //                  .currentrxpreset3
		output wire [2:0]   currentrxpreset4,         //                  .currentrxpreset4
		output wire [2:0]   currentrxpreset5,         //                  .currentrxpreset5
		output wire [2:0]   currentrxpreset6,         //                  .currentrxpreset6
		output wire [2:0]   currentrxpreset7,         //                  .currentrxpreset7
		output wire [1:0]   txsynchd0,                //                  .txsynchd0
		output wire [1:0]   txsynchd1,                //                  .txsynchd1
		output wire [1:0]   txsynchd2,                //                  .txsynchd2
		output wire [1:0]   txsynchd3,                //                  .txsynchd3
		output wire [1:0]   txsynchd4,                //                  .txsynchd4
		output wire [1:0]   txsynchd5,                //                  .txsynchd5
		output wire [1:0]   txsynchd6,                //                  .txsynchd6
		output wire [1:0]   txsynchd7,                //                  .txsynchd7
		output wire         txblkst0,                 //                  .txblkst0
		output wire         txblkst1,                 //                  .txblkst1
		output wire         txblkst2,                 //                  .txblkst2
		output wire         txblkst3,                 //                  .txblkst3
		output wire         txblkst4,                 //                  .txblkst4
		output wire         txblkst5,                 //                  .txblkst5
		output wire         txblkst6,                 //                  .txblkst6
		output wire         txblkst7,                 //                  .txblkst7
		output wire         txdataskip0,              //                  .txdataskip0
		output wire         txdataskip1,              //                  .txdataskip1
		output wire         txdataskip2,              //                  .txdataskip2
		output wire         txdataskip3,              //                  .txdataskip3
		output wire         txdataskip4,              //                  .txdataskip4
		output wire         txdataskip5,              //                  .txdataskip5
		output wire         txdataskip6,              //                  .txdataskip6
		output wire         txdataskip7,              //                  .txdataskip7
		output wire [1:0]   rate0,                    //                  .rate0
		output wire [1:0]   rate1,                    //                  .rate1
		output wire [1:0]   rate2,                    //                  .rate2
		output wire [1:0]   rate3,                    //                  .rate3
		output wire [1:0]   rate4,                    //                  .rate4
		output wire [1:0]   rate5,                    //                  .rate5
		output wire [1:0]   rate6,                    //                  .rate6
		output wire [1:0]   rate7,                    //                  .rate7
		input  wire         rx_in0,                   //        hip_serial.rx_in0
		input  wire         rx_in1,                   //                  .rx_in1
		input  wire         rx_in2,                   //                  .rx_in2
		input  wire         rx_in3,                   //                  .rx_in3
		input  wire         rx_in4,                   //                  .rx_in4
		input  wire         rx_in5,                   //                  .rx_in5
		input  wire         rx_in6,                   //                  .rx_in6
		input  wire         rx_in7,                   //                  .rx_in7
		output wire         tx_out0,                  //                  .tx_out0
		output wire         tx_out1,                  //                  .tx_out1
		output wire         tx_out2,                  //                  .tx_out2
		output wire         tx_out3,                  //                  .tx_out3
		output wire         tx_out4,                  //                  .tx_out4
		output wire         tx_out5,                  //                  .tx_out5
		output wire         tx_out6,                  //                  .tx_out6
		output wire         tx_out7,                  //                  .tx_out7
		input  wire [39:0]  txs_address_i,            //               txs.address
		input  wire         txs_chipselect_i,         //                  .chipselect
		input  wire [3:0]   txs_byteenable_i,         //                  .byteenable
		output wire [31:0]  txs_readdata_o,           //                  .readdata
		input  wire [31:0]  txs_writedata_i,          //                  .writedata
		input  wire         txs_read_i,               //                  .read
		input  wire         txs_write_i,              //                  .write
		output wire         txs_readdatavalid_o,      //                  .readdatavalid
		output wire         txs_waitrequest_o,        //                  .waitrequest
		output wire [63:0]  rxm_bar2_address_o,       //          rxm_bar2.address
		output wire [3:0]   rxm_bar2_byteenable_o,    //                  .byteenable
		input  wire [31:0]  rxm_bar2_readdata_i,      //                  .readdata
		output wire [31:0]  rxm_bar2_writedata_o,     //                  .writedata
		output wire         rxm_bar2_read_o,          //                  .read
		output wire         rxm_bar2_write_o,         //                  .write
		input  wire         rxm_bar2_readdatavalid_i, //                  .readdatavalid
		input  wire         rxm_bar2_waitrequest_i,   //                  .waitrequest
		output wire [63:0]  rd_dma_address_o,         //     dma_rd_master.address
		output wire         rd_dma_write_o,           //                  .write
		output wire [255:0] rd_dma_write_data_o,      //                  .writedata
		input  wire         rd_dma_wait_request_i,    //                  .waitrequest
		output wire [4:0]   rd_dma_burst_count_o,     //                  .burstcount
		output wire [31:0]  rd_dma_byte_enable_o,     //                  .byteenable
		output wire [63:0]  wr_dma_address_o,         //     dma_wr_master.address
		output wire         wr_dma_read_o,            //                  .read
		input  wire [255:0] wr_dma_read_data_i,       //                  .readdata
		input  wire         wr_dma_wait_request_i,    //                  .waitrequest
		output wire [4:0]   wr_dma_burst_count_o,     //                  .burstcount
		input  wire         wr_dma_read_data_valid_i, //                  .readdatavalid
		input  wire         rd_dts_chip_select_i,     //      rd_dts_slave.chipselect
		input  wire         rd_dts_write_i,           //                  .write
		input  wire [4:0]   rd_dts_burst_count_i,     //                  .burstcount
		input  wire [7:0]   rd_dts_address_i,         //                  .address
		input  wire [255:0] rd_dts_write_data_i,      //                  .writedata
		output wire         rd_dts_wait_request_o,    //                  .waitrequest
		input  wire         wr_dts_chip_select_i,     //      wr_dts_slave.chipselect
		input  wire         wr_dts_write_i,           //                  .write
		input  wire [4:0]   wr_dts_burst_count_i,     //                  .burstcount
		input  wire [7:0]   wr_dts_address_i,         //                  .address
		input  wire [255:0] wr_dts_write_data_i,      //                  .writedata
		output wire         wr_dts_wait_request_o,    //                  .waitrequest
		output wire [63:0]  rd_dcm_address_o,         //     rd_dcm_master.address
		output wire         rd_dcm_write_o,           //                  .write
		output wire [31:0]  rd_dcm_writedata_o,       //                  .writedata
		output wire         rd_dcm_read_o,            //                  .read
		output wire [3:0]   rd_dcm_byte_enable_o,     //                  .byteenable
		input  wire         rd_dcm_wait_request_i,    //                  .waitrequest
		input  wire [31:0]  rd_dcm_read_data_i,       //                  .readdata
		input  wire         rd_dcm_read_data_valid_i, //                  .readdatavalid
		output wire [63:0]  wr_dcm_address_o,         //     wr_dcm_master.address
		output wire         wr_dcm_write_o,           //                  .write
		output wire [31:0]  wr_dcm_writedata_o,       //                  .writedata
		output wire         wr_dcm_read_o,            //                  .read
		output wire [3:0]   wr_dcm_byte_enable_o,     //                  .byteenable
		input  wire         wr_dcm_wait_request_i,    //                  .waitrequest
		input  wire [31:0]  wr_dcm_read_data_i,       //                  .readdata
		input  wire         wr_dcm_read_data_valid_i  //                  .readdatavalid
	);
endmodule

