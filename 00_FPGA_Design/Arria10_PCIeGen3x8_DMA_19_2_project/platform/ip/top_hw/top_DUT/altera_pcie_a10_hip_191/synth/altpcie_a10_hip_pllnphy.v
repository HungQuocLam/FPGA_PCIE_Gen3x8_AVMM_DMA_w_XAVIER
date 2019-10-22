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

module altpcie_a10_hip_pllnphy # (
   parameter protocol_version = "Gen 1",
   parameter LANES            = 1,
   parameter export_phy_input_to_top_level_hwtcl = 0,
   parameter reconfig_address_width_integer_hwtcl = 11
   ) (
   //Native PHY Ports
   input  wire [LANES-1   :0]  tx_analogreset,                                          //     tx_analogreset.tx_analogreset
   input  wire [LANES-1   :0]  tx_digitalreset,                                         //    tx_digitalreset.tx_digitalreset
   input  wire [LANES-1   :0]  rx_analogreset,                                          //     rx_analogreset.rx_analogreset
   input  wire [LANES-1   :0]  rx_digitalreset,                                         //    rx_digitalreset.rx_digitalreset
   output wire [LANES-1   :0]  tx_cal_busy,                                             //        tx_cal_busy.tx_cal_busy
   output wire [LANES-1   :0]  rx_cal_busy,                                             //        rx_cal_busy.rx_cal_busy
   input  wire                 rx_cdr_refclk0,                                          //     rx_cdr_refclk0.clk
   output wire [LANES-1   :0]  tx_serial_data,                                          //     tx_serial_data.tx_serial_data
   input  wire [LANES-1   :0]  rx_serial_data,                                          //     rx_serial_data.rx_serial_data
   input  wire [LANES-1   :0]  rx_set_locktodata,                                       //  rx_set_locktodata.rx_set_locktodata
   input  wire [LANES-1   :0]  rx_set_locktoref,                                        //   rx_set_locktoref.rx_set_locktoref
   output wire [LANES-1   :0]  rx_is_lockedtoref,                                       //  rx_is_lockedtoref.rx_is_lockedtoref
   output wire [LANES-1   :0]  rx_is_lockedtodata,                                      // rx_is_lockedtodata.rx_is_lockedtodata
   input  wire [LANES-1   :0]  pipe_rx_polarity,                                        //   pipe_rx_polarity.pipe_rx_polarity
   input  wire [64*LANES-1:0]  tx_hip_data,                                             //        tx_hip_data.tx_hip_data
   output wire [51*LANES-1:0]  rx_hip_data,                                             //        rx_hip_data.rx_hip_data
   output wire                 hip_pipe_pclk,                                           //      hip_pipe_pclk.hip_pipe_pclk
   output wire                 hip_fixedclk,                                            //       hip_fixedclk.hip_fixedclk
   output wire [LANES-1   :0]  hip_frefclk,                                             //        hip_frefclk.hip_frefclk
   output wire [8*LANES-1 :0]  hip_ctrl,                                                //           hip_ctrl.hip_ctrl
   output wire [LANES-1   :0]  chnl_cal_done,                                           //      chnl_cal_done.hip_cal_done
   input  wire [2*LANES-1 :0]  pipe_rate,                                               //          pipe_rate.pipe_rate
   input  wire [3*LANES-1 :0]  pipe_rx_eidleinfersel,                                   // pipe_rx_eidleinfersel.pipe_rx_eidleinfersel
   output wire [LANES-1   :0]  pipe_rx_elecidle,                                        //      pipe_rx_elecidle.pipe_rx_elecidle
   input  wire [18*LANES-1:0]  pipe_g3_txdeemph,
   input  wire [3*LANES-1:0]   pipe_g3_rxpresethint,

   // Reconfig interface
   input  wire                 reconfig_clk,                                            // reconfig_clk.clk
   input  wire                 reconfig_reset,                                          // reconfig_reset.reset
   input  wire                 reconfig_write,                                          // reconfig_avmm.write
   input  wire                 reconfig_read,                                           // reconfig_avmm.read
   input  wire [reconfig_address_width_integer_hwtcl-1:0] reconfig_address,                                        // reconfig_avmm.address
   input  wire [31:0]          reconfig_writedata,                                      // reconfig_avmm.writedata
   output wire [31:0]          reconfig_readdata,                                       // reconfig_avmm.readdata
   output wire                 reconfig_waitrequest,                                    // reconfig_avmm.waitrequest

   input  wire                 reconfig_pll0_clk,                                       //     reconfig_clk.clk
   input  wire                 reconfig_pll0_reset,                                     //   reconfig_reset.reset
   input  wire                 reconfig_pll0_write,                                     //    reconfig_avmm.write
   input  wire                 reconfig_pll0_read,                                      //                 .read
   input  wire [9:0]           reconfig_pll0_address,                                   //                 .address
   input  wire [31:0]          reconfig_pll0_writedata,                                 //                 .writedata
   output wire [31:0]          reconfig_pll0_readdata,                                  //                 .readdata
   output wire                 reconfig_pll0_waitrequest,                               //                 .waitrequest

   input  wire                 reconfig_pll1_clk,                                       //     reconfig_clk.clk
   input  wire                 reconfig_pll1_reset,                                     //   reconfig_reset.reset
   input  wire                 reconfig_pll1_write,                                     //    reconfig_avmm.write
   input  wire                 reconfig_pll1_read,                                      //                 .read
   input  wire [9:0]           reconfig_pll1_address,                                   //                 .address
   input  wire [31:0]          reconfig_pll1_writedata,                                 //                 .writedata
   output wire [31:0]          reconfig_pll1_readdata,                                  //                 .readdata
   output wire                 reconfig_pll1_waitrequest,                               //                 .waitrequest

   //DFE interface   
   input  wire                 hip_reduce_counters,
   input  wire [1:0]           current_rate,           // PCIe generation
   input  wire                  ltssm_eq_phase2,   // LTSSM equalization Phase2
   input  wire                 ltssm_detect_active,   // LTSSM Detect Active state
   input  wire                 ltssm_detect_quiet,   // LTSSM Detect Quiet state
   //LC PLL ports
   input  wire                  pll_powerdown_lcpll,                                     //    pll_powerdown.pll_powerdown   //TODO for Gen3 with LC n FF PLL
   output wire                  pll_locked_lcpll,                                        //       pll_locked.pll_locked
   output wire                  pll_cal_done_lcpll,                                             //     pll_cal_done.hip_cal_done
   //FPLL ports
   input  wire                  pll_powerdown_fpll,                                      //    pll_powerdown.pll_powerdown   //TODO for Gen3 with LC n FF PLL
   output wire                  pll_locked_fpll,                                         //       pll_locked.pll_locked
   output wire                  pll_cal_done_fpll,                                             //     pll_cal_done.hip_cal_done
   // Master CGB reset port
   input  wire                  mcgb_rst,                                                //      reset to the MST CGB
   input  wire                  pll_refclk0,                                             //      pll_refclk0.clk

   input  wire                  pipe_hclk_in,
   output wire                  pll_pcie_clk,
// rx_polinv from the the fabric. pld_rx_polinv soft logic
   input  wire [LANES-1:0]      rx_polinv,
   
   //add for false skp detection
	output wire [LANES-1   :0]   rx_clkout,
	output wire [128*LANES-1:0]  rx_parallel_data
   );


localparam xn_design = (LANES==1)? 0:1;
localparam [255:0] ONES  = 256'HFFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF;
localparam [255:0] ZEROS = 256'H0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000;

wire          tx_serial_clk0;
wire          tx_serial_clk1;
wire [5:0]    tx_bonding_clocks;
wire          pll_pcie_clk_int;
wire [1:0]    pcie_sw;
wire [1:0]    pcie_sw_done;

assign        pll_pcie_clk_int = (export_phy_input_to_top_level_hwtcl == 1)? pipe_hclk_in : pll_pcie_clk;

///////////////////////////////////////
///////////   NATIVE PHY   ////////////
///////////////////////////////////////
generate begin : g_xcvr
   /////////                    X1              ///////////////////////////////////////////////
      if (LANES==1) begin
         if (protocol_version=="Gen 1")  begin  :g_phy_g1x1
            phy_g1x1 phy_g1x1 (
               .tx_analogreset         (tx_analogreset                 ),    // input  wire [0:0]  tx_analogreset,
               .tx_digitalreset        (tx_digitalreset                ),    // input  wire [0:0]  tx_digitalreset,
               .rx_analogreset         (rx_analogreset                 ),    // input  wire [0:0]  rx_analogreset,
               .rx_digitalreset        (rx_digitalreset                ),    // input  wire [0:0]  rx_digitalreset,
               .tx_cal_busy            (tx_cal_busy                    ),    // output wire [0:0]  tx_cal_busy,
               .rx_cal_busy            (rx_cal_busy                    ),    // output wire [0:0]  rx_cal_busy,
               .tx_serial_clk0         (tx_serial_clk0                 ),    // input  wire [0:0]  tx_serial_clk0,
               .rx_cdr_refclk0         (rx_cdr_refclk0                 ),    // input  wire        rx_cdr_refclk0,
               .tx_serial_data         (tx_serial_data                 ),    // output wire [0:0]  tx_serial_data,
               .rx_serial_data         (rx_serial_data                 ),    // input  wire [0:0]  rx_serial_data,
               .rx_set_locktodata      (rx_set_locktodata              ),    // input  wire [0:0]  rx_set_locktodata,
               .rx_set_locktoref       (rx_set_locktoref               ),    // input  wire [0:0]  rx_set_locktoref,
               .rx_is_lockedtoref      (rx_is_lockedtoref              ),    // output wire [0:0]  rx_is_lockedtoref,
               .rx_is_lockedtodata     (rx_is_lockedtodata             ),    // output wire [0:0]  rx_is_lockedtodata,
               .tx_hip_data            (tx_hip_data                    ),    // input  wire [63:0] tx_hip_data,
               .rx_hip_data            (rx_hip_data                    ),    // output wire [50:0] rx_hip_data,
               .hip_pipe_pclk          (hip_pipe_pclk                  ),    // output wire        hip_pipe_pclk,
               .hip_fixedclk           (hip_fixedclk                   ),    // output wire        hip_fixedclk,
               .hip_frefclk            (hip_frefclk                    ),    // output wire [0:0]  hip_frefclk,
               .hip_ctrl               (hip_ctrl                       ),    // output wire [7:0]  hip_ctrl,
               .hip_cal_done           (chnl_cal_done                  ),    // output wire [0:0]  hip_cal_done,
               .pipe_hclk_in           (pll_pcie_clk_int               ),    // input  wire        pipe_hclk_in,
               .pipe_rx_eidleinfersel  (pipe_rx_eidleinfersel          ),    // input  wire [2:0]  pipe_rx_eidleinfersel,
               .pipe_rx_elecidle       (pipe_rx_elecidle               ),    // output wire [0:0]  pipe_rx_elecidle,
               .pipe_rx_polarity       (pipe_rx_polarity               ),    // input  wire [0:0]  pipe_rx_polarity
               .hip_reduce_counters    (hip_reduce_counters            ),
               .pcie_rate              (current_rate                   ),           // PCIe generation
               .ltssm_rcvr_equalization   (ltssm_eq_phase2                ),   // LTSSM equalization Phase2
               .ltssm_detect_active    (ltssm_detect_active            ),   // LTSSM Detect Active state
               .ltssm_detect_quiet     (ltssm_detect_quiet             ),   // LTSSM Detect Quiet state
               .reconfig_clk           (reconfig_clk                   ),    // input  wire [0:0]  reconfig_clk,
               .reconfig_reset         (reconfig_reset                 ),    // input  wire [0:0]  reconfig_reset,
               .reconfig_write         (reconfig_write                 ),    // input  wire [0:0]  reconfig_write,
               .reconfig_read          (reconfig_read                  ),    // input  wire [0:0]  reconfig_read,
               .reconfig_address       (reconfig_address               ),    // input  wire [9:0]  reconfig_address,
               .reconfig_writedata     (reconfig_writedata             ),    // input  wire [31:0] reconfig_writedata,
               .reconfig_readdata      (reconfig_readdata              ),    // output wire [31:0] reconfig_readdata,
               .reconfig_waitrequest   (reconfig_waitrequest           ),    // output wire [0:0]  reconfig_waitrequest
               .rx_polinv              (rx_polinv                      )     // input wire [0:0]  rx_polinv

            );
         end
         else if (protocol_version=="Gen 2") begin   :g_phy_g2x1
            phy_g2x1 phy_g2x1 (
               .tx_analogreset         (tx_analogreset                 ),    // input  wire [0:0]  tx_analogreset,
               .tx_digitalreset        (tx_digitalreset                ),    // input  wire [0:0]  tx_digitalreset,
               .rx_analogreset         (rx_analogreset                 ),    // input  wire [0:0]  rx_analogreset,
               .rx_digitalreset        (rx_digitalreset                ),    // input  wire [0:0]  rx_digitalreset,
               .tx_cal_busy            (tx_cal_busy                    ),    // output wire [0:0]  tx_cal_busy,
               .rx_cal_busy            (rx_cal_busy                    ),    // output wire [0:0]  rx_cal_busy,
               .tx_serial_clk0         (tx_serial_clk0                 ),    // input  wire [0:0]  tx_serial_clk0,
               .rx_cdr_refclk0         (rx_cdr_refclk0                 ),    // input  wire        rx_cdr_refclk0,
               .tx_serial_data         (tx_serial_data                 ),    // output wire [0:0]  tx_serial_data,
               .rx_serial_data         (rx_serial_data                 ),    // input  wire [0:0]  rx_serial_data,
               .rx_set_locktodata      (rx_set_locktodata              ),    // input  wire [0:0]  rx_set_locktodata,
               .rx_set_locktoref       (rx_set_locktoref               ),    // input  wire [0:0]  rx_set_locktoref,
               .rx_is_lockedtoref      (rx_is_lockedtoref              ),    // output wire [0:0]  rx_is_lockedtoref,
               .rx_is_lockedtodata     (rx_is_lockedtodata             ),    // output wire [0:0]  rx_is_lockedtodata,
               .tx_hip_data            (tx_hip_data                    ),    // input  wire [63:0] tx_hip_data,
               .rx_hip_data            (rx_hip_data                    ),    // output wire [50:0] rx_hip_data,
               .hip_pipe_pclk          (hip_pipe_pclk                  ),    // output wire        hip_pipe_pclk,
               .hip_fixedclk           (hip_fixedclk                   ),    // output wire        hip_fixedclk,
               .hip_frefclk            (hip_frefclk                    ),    // output wire [0:0]  hip_frefclk,
               .hip_ctrl               (hip_ctrl                       ),    // output wire [7:0]  hip_ctrl,
               .hip_cal_done           (chnl_cal_done                  ),    // output wire [0:0]  hip_cal_done,
               .pipe_rate              (pipe_rate                      ),    // input  wire [1:0]  pipe_rate,
               .pipe_sw_done           (pcie_sw_done                   ),    // input  wire [1:0]  pipe_sw_done,
               .pipe_sw                (pcie_sw                        ),    // output wire [1:0]  pipe_sw,
               .pipe_hclk_in           (pll_pcie_clk_int               ),    // input  wire        pipe_hclk_in,
               .pipe_rx_eidleinfersel  (pipe_rx_eidleinfersel          ),    // input  wire [2:0]  pipe_rx_eidleinfersel,
               .pipe_rx_elecidle       (pipe_rx_elecidle               ),    // output wire [0:0]  pipe_rx_elecidle,
               .pipe_rx_polarity       (pipe_rx_polarity               ),    // input  wire [0:0]  pipe_rx_polarity
               .hip_reduce_counters    (hip_reduce_counters            ),
               .pcie_rate              (current_rate                   ),           // PCIe generation
               .ltssm_rcvr_equalization   (ltssm_eq_phase2                ),   // LTSSM equalization Phase2
               .ltssm_detect_active    (ltssm_detect_active            ),   // LTSSM Detect Active state
               .ltssm_detect_quiet     (ltssm_detect_quiet             ),   // LTSSM Detect Quiet state
               .reconfig_clk           (reconfig_clk                   ),    // input  wire [0:0]  reconfig_clk,
               .reconfig_reset         (reconfig_reset                 ),    // input  wire [0:0]  reconfig_reset,
               .reconfig_write         (reconfig_write                 ),    // input  wire [0:0]  reconfig_write,
               .reconfig_read          (reconfig_read                  ),    // input  wire [0:0]  reconfig_read,
               .reconfig_address       (reconfig_address               ),    // input  wire [9:0]  reconfig_address,
               .reconfig_writedata     (reconfig_writedata             ),    // input  wire [31:0] reconfig_writedata,
               .reconfig_readdata      (reconfig_readdata              ),    // output wire [31:0] reconfig_readdata,
               .reconfig_waitrequest   (reconfig_waitrequest           ),    // output wire [0:0]  reconfig_waitrequest
               .rx_polinv              (rx_polinv                      )     // input wire [0:0]  rx_polinv

            );
         end
         else begin  :g_phy_g3x1
            phy_g3x1 phy_g3x1 (
               .tx_analogreset         (tx_analogreset                 ),  //input  wire [0:0]  tx_analogreset,
               .tx_digitalreset        (tx_digitalreset                ),  //input  wire [0:0]  tx_digitalreset,
               .rx_analogreset         (rx_analogreset                 ),  //input  wire [0:0]  rx_analogreset,
               .rx_digitalreset        (rx_digitalreset                ),  //input  wire [0:0]  rx_digitalreset,
               .tx_cal_busy            (tx_cal_busy                    ),  //output wire [0:0]  tx_cal_busy,
               .rx_cal_busy            (rx_cal_busy                    ),  //output wire [0:0]  rx_cal_busy,
               .tx_serial_clk0         (tx_serial_clk0                 ),  //input  wire [0:0]  tx_serial_clk0,
               .tx_serial_clk1         (tx_serial_clk1                 ),  //input  wire [0:0]  tx_serial_clk1,
               .rx_cdr_refclk0         (rx_cdr_refclk0                 ),  //input  wire        rx_cdr_refclk0,
               .tx_serial_data         (tx_serial_data                 ),  //output wire [0:0]  tx_serial_data,
               .rx_serial_data         (rx_serial_data                 ),  //input  wire [0:0]  rx_serial_data,
               .rx_set_locktodata      (rx_set_locktodata              ),  //input  wire [0:0]  rx_set_locktodata,
               .rx_set_locktoref       (rx_set_locktoref               ),  //input  wire [0:0]  rx_set_locktoref,
               .rx_is_lockedtoref      (rx_is_lockedtoref              ),  //output wire [0:0]  rx_is_lockedtoref,
               .rx_is_lockedtodata     (rx_is_lockedtodata             ),  //output wire [0:0]  rx_is_lockedtodata,
               .tx_hip_data            (tx_hip_data                    ),  //input  wire [63:0] tx_hip_data,
               .rx_hip_data            (rx_hip_data                    ),  //output wire [50:0] rx_hip_data,
               .hip_pipe_pclk          (hip_pipe_pclk                  ),  //output wire        hip_pipe_pclk,
               .hip_fixedclk           (hip_fixedclk                   ),  //output wire        hip_fixedclk,
               .hip_frefclk            (hip_frefclk                    ),  //output wire [0:0]  hip_frefclk,
               .hip_ctrl               (hip_ctrl                       ),  //output wire [7:0]  hip_ctrl,
               .hip_cal_done           (chnl_cal_done                  ),  //output wire [0:0]  hip_cal_done,
               .pipe_rate              (pipe_rate                      ),  //input  wire [1:0]  pipe_rate,
               .pipe_sw_done           (pcie_sw_done                   ),  //input  wire [1:0]  pipe_sw_done,
               .pipe_sw                (pcie_sw                        ),  //output wire [1:0]  pipe_sw,
               .pipe_hclk_in           (pll_pcie_clk_int               ),  //input  wire        pipe_hclk_in,
               .pipe_g3_txdeemph       (pipe_g3_txdeemph               ),  //input  wire [17:0] pipe_g3_txdeemph,
               .pipe_g3_rxpresethint   (pipe_g3_rxpresethint           ),  //input  wire [2:0]  pipe_g3_rxpresethint,
               .pipe_rx_eidleinfersel  (pipe_rx_eidleinfersel          ),  //input  wire [2:0]  pipe_rx_eidleinfersel,
               .pipe_rx_elecidle       (pipe_rx_elecidle               ),  //output wire [0:0]  pipe_rx_elecidle,
               .pipe_rx_polarity       (pipe_rx_polarity               ),  //input  wire [0:0]  pipe_rx_polarity
               .hip_reduce_counters    (hip_reduce_counters            ),
               .pcie_rate              (current_rate                   ),           // PCIe generation
               .ltssm_rcvr_equalization   (ltssm_eq_phase2                ),   // LTSSM equalization Phase2
               .ltssm_detect_active    (ltssm_detect_active            ),   // LTSSM Detect Active state
               .ltssm_detect_quiet     (ltssm_detect_quiet             ),   // LTSSM Detect Quiet state
               .reconfig_clk           (reconfig_clk                   ),    // input  wire [0:0]  reconfig_clk,
               .reconfig_reset         (reconfig_reset                 ),    // input  wire [0:0]  reconfig_reset,
               .reconfig_write         (reconfig_write                 ),    // input  wire [0:0]  reconfig_write,
               .reconfig_read          (reconfig_read                  ),    // input  wire [0:0]  reconfig_read,
               .reconfig_address       (reconfig_address               ),    // input  wire [9:0]  reconfig_address,
               .reconfig_writedata     (reconfig_writedata             ),    // input  wire [31:0] reconfig_writedata,
               .reconfig_readdata      (reconfig_readdata              ),    // output wire [31:0] reconfig_readdata,
               .reconfig_waitrequest   (reconfig_waitrequest           ),    // output wire [0:0]  reconfig_waitrequest
               .rx_polinv              (rx_polinv                      )     // input wire [0:0]  rx_polinv

            );
         end
   /////////                    X2              ///////////////////////////////////////////////
                end
                else if (LANES==2) begin
         if (protocol_version=="Gen 1") begin  :g_phy_g2x2
            phy_g1x2 phy_g1x2 (
               .tx_analogreset         (tx_analogreset                 ),    // input  wire [1:0]   tx_analogreset,
               .tx_digitalreset        (tx_digitalreset                ),    // input  wire [1:0]   tx_digitalreset,
               .rx_analogreset         (rx_analogreset                 ),    // input  wire [1:0]   rx_analogreset,
               .rx_digitalreset        (rx_digitalreset                ),    // input  wire [1:0]   rx_digitalreset,
               .tx_cal_busy            (tx_cal_busy                    ),    // output wire [1:0]   tx_cal_busy,
               .rx_cal_busy            (rx_cal_busy                    ),    // output wire [1:0]   rx_cal_busy,
               .tx_bonding_clocks      ({LANES{tx_bonding_clocks}}     ),    // input  wire [11:0]  tx_bonding_clocks,
               .rx_cdr_refclk0         (rx_cdr_refclk0                 ),    // input  wire         rx_cdr_refclk0,
               .tx_serial_data         (tx_serial_data                 ),    // output wire [1:0]   tx_serial_data,
               .rx_serial_data         (rx_serial_data                 ),    // input  wire [1:0]   rx_serial_data,
               .rx_set_locktodata      (rx_set_locktodata              ),    // input  wire [1:0]   rx_set_locktodata,
               .rx_set_locktoref       (rx_set_locktoref               ),    // input  wire [1:0]   rx_set_locktoref,
               .rx_is_lockedtoref      (rx_is_lockedtoref              ),    // output wire [1:0]   rx_is_lockedtoref,
               .rx_is_lockedtodata     (rx_is_lockedtodata             ),    // output wire [1:0]   rx_is_lockedtodata,
               .tx_hip_data            (tx_hip_data                    ),    // input  wire [127:0] tx_hip_data,
               .rx_hip_data            (rx_hip_data                    ),    // output wire [101:0] rx_hip_data,
               .hip_pipe_pclk          (hip_pipe_pclk                  ),    // output wire         hip_pipe_pclk,
               .hip_fixedclk           (hip_fixedclk                   ),    // output wire         hip_fixedclk,
               .hip_frefclk            (hip_frefclk                    ),    // output wire [1:0]   hip_frefclk,
               .hip_ctrl               (hip_ctrl                       ),    // output wire [15:0]  hip_ctrl,
               .hip_cal_done           (chnl_cal_done                  ),    // output wire [1:0]   hip_cal_done,
               .pipe_rate              (pipe_rate                      ),    // input  wire [1:0]  pipe_rate,
               .pipe_sw_done           (pcie_sw_done                   ),    // input  wire [1:0]  pipe_sw_done,
               .pipe_sw                (pcie_sw                        ),    // output wire [1:0]  pipe_sw,
               .pipe_hclk_in           (pll_pcie_clk_int               ),    // input  wire         pipe_hclk_in,
               .pipe_rx_eidleinfersel  (pipe_rx_eidleinfersel          ),    // input  wire [5:0]   pipe_rx_eidleinfersel,
               .pipe_rx_elecidle       (pipe_rx_elecidle               ),    // output wire [1:0]   pipe_rx_elecidle,
               .pipe_rx_polarity       (pipe_rx_polarity               ),    // input  wire [1:0]   pipe_rx_polarity
               .hip_reduce_counters    (hip_reduce_counters            ),
               .pcie_rate              (current_rate                   ),           // PCIe generation
               .ltssm_rcvr_equalization   (ltssm_eq_phase2                ),   // LTSSM equalization Phase2
               .ltssm_detect_active    (ltssm_detect_active            ),   // LTSSM Detect Active state
               .ltssm_detect_quiet     (ltssm_detect_quiet             ),   // LTSSM Detect Quiet state
               .reconfig_clk           (reconfig_clk                   ),    // input  wire [0:0]  reconfig_clk,
               .reconfig_reset         (reconfig_reset                 ),    // input  wire [0:0]  reconfig_reset,
               .reconfig_write         (reconfig_write                 ),    // input  wire [0:0]  reconfig_write,
               .reconfig_read          (reconfig_read                  ),    // input  wire [0:0]  reconfig_read,
               .reconfig_address       (reconfig_address               ),    // input  wire [9:0]  reconfig_address,
               .reconfig_writedata     (reconfig_writedata             ),    // input  wire [31:0] reconfig_writedata,
               .reconfig_readdata      (reconfig_readdata              ),    // output wire [31:0] reconfig_readdata,
               .reconfig_waitrequest   (reconfig_waitrequest           ),    // output wire [0:0]  reconfig_waitrequest
               .rx_polinv              (rx_polinv                      )     // input wire [1:0]  rx_polinv

            );
         end
         else if (protocol_version=="Gen 2") begin  :g_phy_g2x2
            phy_g2x2 phy_g2x2 (
               .tx_analogreset         (tx_analogreset                 ),   // input  wire [1:0]   tx_analogreset,
               .tx_digitalreset        (tx_digitalreset                ),   // input  wire [1:0]   tx_digitalreset,
               .rx_analogreset         (rx_analogreset                 ),   // input  wire [1:0]   rx_analogreset,
               .rx_digitalreset        (rx_digitalreset                ),   // input  wire [1:0]   rx_digitalreset,
               .tx_cal_busy            (tx_cal_busy                    ),   // output wire [1:0]   tx_cal_busy,
               .rx_cal_busy            (rx_cal_busy                    ),   // output wire [1:0]   rx_cal_busy,
               .tx_bonding_clocks      ({LANES{tx_bonding_clocks}}     ),   // input  wire [11:0]  tx_bonding_clocks,
               .rx_cdr_refclk0         (rx_cdr_refclk0                 ),   // input  wire         rx_cdr_refclk0,
               .tx_serial_data         (tx_serial_data                 ),   // output wire [1:0]   tx_serial_data,
               .rx_serial_data         (rx_serial_data                 ),   // input  wire [1:0]   rx_serial_data,
               .rx_set_locktodata      (rx_set_locktodata              ),   // input  wire [1:0]   rx_set_locktodata,
               .rx_set_locktoref       (rx_set_locktoref               ),   // input  wire [1:0]   rx_set_locktoref,
               .rx_is_lockedtoref      (rx_is_lockedtoref              ),   // output wire [1:0]   rx_is_lockedtoref,
               .rx_is_lockedtodata     (rx_is_lockedtodata             ),   // output wire [1:0]   rx_is_lockedtodata,
               .tx_hip_data            (tx_hip_data                    ),   // input  wire [127:0] tx_hip_data,
               .rx_hip_data            (rx_hip_data                    ),   // output wire [101:0] rx_hip_data,
               .hip_pipe_pclk          (hip_pipe_pclk                  ),   // output wire         hip_pipe_pclk,
               .hip_fixedclk           (hip_fixedclk                   ),   // output wire         hip_fixedclk,
               .hip_frefclk            (hip_frefclk                    ),   // output wire [1:0]   hip_frefclk,
               .hip_ctrl               (hip_ctrl                       ),   // output wire [15:0]  hip_ctrl,
               .hip_cal_done           (chnl_cal_done                  ),   // output wire [1:0]   hip_cal_done,
               .pipe_rate              (pipe_rate                      ),   // input  wire [3:0]   pipe_rate,
               .pipe_sw_done           (pcie_sw_done                   ),   // input  wire [1:0]   pipe_sw_done,
               .pipe_sw                (pcie_sw                        ),   // output wire [1:0]   pipe_sw,
               .pipe_hclk_in           (pll_pcie_clk_int               ),   // input  wire         pipe_hclk_in,
               .pipe_rx_eidleinfersel  (pipe_rx_eidleinfersel          ),   // input  wire [5:0]   pipe_rx_eidleinfersel,
               .pipe_rx_elecidle       (pipe_rx_elecidle               ),   // output wire [1:0]   pipe_rx_elecidle,
               .pipe_rx_polarity       (pipe_rx_polarity               ),   // input  wire [1:0]   pipe_rx_polarity
               .hip_reduce_counters    (hip_reduce_counters            ),
               .pcie_rate              (current_rate                   ),           // PCIe generation
               .ltssm_rcvr_equalization   (ltssm_eq_phase2                ),   // LTSSM equalization Phase2
               .ltssm_detect_active    (ltssm_detect_active            ),   // LTSSM Detect Active state
               .ltssm_detect_quiet     (ltssm_detect_quiet             ),   // LTSSM Detect Quiet state
               .reconfig_clk           (reconfig_clk                   ),    // input  wire [0:0]  reconfig_clk,
               .reconfig_reset         (reconfig_reset                 ),    // input  wire [0:0]  reconfig_reset,
               .reconfig_write         (reconfig_write                 ),    // input  wire [0:0]  reconfig_write,
               .reconfig_read          (reconfig_read                  ),    // input  wire [0:0]  reconfig_read,
               .reconfig_address       (reconfig_address               ),    // input  wire [9:0]  reconfig_address,
               .reconfig_writedata     (reconfig_writedata             ),    // input  wire [31:0] reconfig_writedata,
               .reconfig_readdata      (reconfig_readdata              ),    // output wire [31:0] reconfig_readdata,
               .reconfig_waitrequest   (reconfig_waitrequest           ),    // output wire [0:0]  reconfig_waitrequest
               .rx_polinv              (rx_polinv                      )     // input wire [1:0]  rx_polinv

            );
         end
         else begin  :g_phy_g3x2
            phy_g3x2 phy_g3x2 (
               .tx_analogreset         (tx_analogreset                 ), // input  wire [1:0]   tx_analogreset,        //
               .tx_digitalreset        (tx_digitalreset                ), // input  wire [1:0]   tx_digitalreset,       //
               .rx_analogreset         (rx_analogreset                 ), // input  wire [1:0]   rx_analogreset,        //
               .rx_digitalreset        (rx_digitalreset                ), // input  wire [1:0]   rx_digitalreset,       //
               .tx_cal_busy            (tx_cal_busy                    ), // output wire [1:0]   tx_cal_busy,           //
               .rx_cal_busy            (rx_cal_busy                    ), // output wire [1:0]   rx_cal_busy,           //
               .tx_bonding_clocks      ({LANES{tx_bonding_clocks}}     ), // input  wire [11:0]  tx_bonding_clocks,     //
               .rx_cdr_refclk0         (rx_cdr_refclk0                 ), // input  wire         rx_cdr_refclk0,        //
               .tx_serial_data         (tx_serial_data                 ), // output wire [1:0]   tx_serial_data,        //
               .rx_serial_data         (rx_serial_data                 ), // input  wire [1:0]   rx_serial_data,        //
               .rx_set_locktodata      (rx_set_locktodata              ), // input  wire [1:0]   rx_set_locktodata,     //
               .rx_set_locktoref       (rx_set_locktoref               ), // input  wire [1:0]   rx_set_locktoref,      //
               .rx_is_lockedtoref      (rx_is_lockedtoref              ), // output wire [1:0]   rx_is_lockedtoref,     //
               .rx_is_lockedtodata     (rx_is_lockedtodata             ), // output wire [1:0]   rx_is_lockedtodata,    //
               .tx_hip_data            (tx_hip_data                    ), // input  wire [127:0] tx_hip_data,           //
               .rx_hip_data            (rx_hip_data                    ), // output wire [101:0] rx_hip_data,           //
               .hip_pipe_pclk          (hip_pipe_pclk                  ), // output wire         hip_pipe_pclk,         //
               .hip_fixedclk           (hip_fixedclk                   ), // output wire         hip_fixedclk,          //
               .hip_frefclk            (hip_frefclk                    ), // output wire [1:0]   hip_frefclk,           //
               .hip_ctrl               (hip_ctrl                       ), // output wire [15:0]  hip_ctrl,              //
               .hip_cal_done           (chnl_cal_done                  ), // output wire [1:0]   hip_cal_done,          //
               .pipe_rate              (pipe_rate                      ), // input  wire [3:0]   pipe_rate,             //
               .pipe_sw_done           (pcie_sw_done                   ), // input  wire [1:0]   pipe_sw_done,          //
               .pipe_sw                (pcie_sw                        ), // output wire [1:0]   pipe_sw,               //
               .pipe_hclk_in           (pll_pcie_clk_int               ), // input  wire         pipe_hclk_in,          //
               .pipe_g3_txdeemph       (pipe_g3_txdeemph               ), // input  wire [35:0]  pipe_g3_txdeemph,      //
               .pipe_g3_rxpresethint   (pipe_g3_rxpresethint           ), // input  wire [5:0]   pipe_g3_rxpresethint,  //
               .pipe_rx_eidleinfersel  (pipe_rx_eidleinfersel          ), // input  wire [5:0]   pipe_rx_eidleinfersel, //
               .pipe_rx_elecidle       (pipe_rx_elecidle               ), // output wire [1:0]   pipe_rx_elecidle,      //
               .pipe_rx_polarity       (pipe_rx_polarity               ), // input  wire [1:0]   pipe_rx_polarity       //
               .hip_reduce_counters    (hip_reduce_counters            ),
               .pcie_rate              (current_rate                   ),           // PCIe generation
               .ltssm_rcvr_equalization   (ltssm_eq_phase2                ),   // LTSSM equalization Phase2
               .ltssm_detect_active    (ltssm_detect_active            ),   // LTSSM Detect Active state
               .ltssm_detect_quiet     (ltssm_detect_quiet             ),   // LTSSM Detect Quiet state
               .reconfig_clk           (reconfig_clk                   ),    // input  wire [0:0]  reconfig_clk,
               .reconfig_reset         (reconfig_reset                 ),    // input  wire [0:0]  reconfig_reset,
               .reconfig_write         (reconfig_write                 ),    // input  wire [0:0]  reconfig_write,
               .reconfig_read          (reconfig_read                  ),    // input  wire [0:0]  reconfig_read,
               .reconfig_address       (reconfig_address               ),    // input  wire [9:0]  reconfig_address,
               .reconfig_writedata     (reconfig_writedata             ),    // input  wire [31:0] reconfig_writedata,
               .reconfig_readdata      (reconfig_readdata              ),    // output wire [31:0] reconfig_readdata,
               .reconfig_waitrequest   (reconfig_waitrequest           ),    // output wire [0:0]  reconfig_waitrequest
               .rx_polinv              (rx_polinv                      )     // input wire [1:0]  rx_polinv

            );
         end
      end
   /////////                    X4              ///////////////////////////////////////////////
      else if (LANES==4) begin
         if (protocol_version=="Gen 1") begin  :g_phy_g1x4
            phy_g1x4 phy_g1x4 (
               .tx_analogreset         (tx_analogreset                 ),    // input  wire [3:0]   tx_analogreset,
               .tx_digitalreset        (tx_digitalreset                ),    // input  wire [3:0]   tx_digitalreset,
               .rx_analogreset         (rx_analogreset                 ),    // input  wire [3:0]   rx_analogreset,
               .rx_digitalreset        (rx_digitalreset                ),    // input  wire [3:0]   rx_digitalreset,
               .tx_cal_busy            (tx_cal_busy                    ),    // output wire [3:0]   tx_cal_busy,
               .rx_cal_busy            (rx_cal_busy                    ),    // output wire [3:0]   rx_cal_busy,
               .tx_bonding_clocks      ({LANES{tx_bonding_clocks}}     ),    // input  wire [23:0]  tx_bonding_clocks,
               .rx_cdr_refclk0         (rx_cdr_refclk0                 ),    // input  wire         rx_cdr_refclk0,
               .tx_serial_data         (tx_serial_data                 ),    // output wire [3:0]   tx_serial_data,
               .rx_serial_data         (rx_serial_data                 ),    // input  wire [3:0]   rx_serial_data,
               .rx_set_locktodata      (rx_set_locktodata              ),    // input  wire [3:0]   rx_set_locktodata,
               .rx_set_locktoref       (rx_set_locktoref               ),    // input  wire [3:0]   rx_set_locktoref,
               .rx_is_lockedtoref      (rx_is_lockedtoref              ),    // output wire [3:0]   rx_is_lockedtoref,
               .rx_is_lockedtodata     (rx_is_lockedtodata             ),    // output wire [3:0]   rx_is_lockedtodata,
               .tx_hip_data            (tx_hip_data                    ),    // input  wire [255:0] tx_hip_data,
               .rx_hip_data            (rx_hip_data                    ),    // output wire [203:0] rx_hip_data,
               .hip_pipe_pclk          (hip_pipe_pclk                  ),    // output wire         hip_pipe_pclk,
               .hip_fixedclk           (hip_fixedclk                   ),    // output wire         hip_fixedclk,
               .hip_frefclk            (hip_frefclk                    ),    // output wire [3:0]   hip_frefclk,
               .hip_ctrl               (hip_ctrl                       ),    // output wire [31:0]  hip_ctrl,
               .hip_cal_done           (chnl_cal_done                  ),    // output wire [3:0]   hip_cal_done,
               .pipe_rate              (pipe_rate                      ),    // input  wire [1:0]  pipe_rate,
               .pipe_sw_done           (pcie_sw_done                   ),    // input  wire [1:0]  pipe_sw_done,
               .pipe_sw                (pcie_sw                        ),    // output wire [1:0]  pipe_sw,
               .pipe_hclk_in           (pll_pcie_clk_int               ),    // input  wire         pipe_hclk_in,
               .pipe_rx_eidleinfersel  (pipe_rx_eidleinfersel          ),    // input  wire [11:0]  pipe_rx_eidleinfersel,
               .pipe_rx_elecidle       (pipe_rx_elecidle               ),    // output wire [3:0]   pipe_rx_elecidle,
               .pipe_rx_polarity       (pipe_rx_polarity               ),    // input  wire [3:0]   pipe_rx_polarity
               .hip_reduce_counters    (hip_reduce_counters            ),
               .pcie_rate              (current_rate                   ),           // PCIe generation
               .ltssm_rcvr_equalization   (ltssm_eq_phase2                ),   // LTSSM equalization Phase2
               .ltssm_detect_active    (ltssm_detect_active            ),   // LTSSM Detect Active state
               .ltssm_detect_quiet     (ltssm_detect_quiet             ),   // LTSSM Detect Quiet state
               .reconfig_clk           (reconfig_clk                   ),    // input  wire [0:0]  reconfig_clk,
               .reconfig_reset         (reconfig_reset                 ),    // input  wire [0:0]  reconfig_reset,
               .reconfig_write         (reconfig_write                 ),    // input  wire [0:0]  reconfig_write,
               .reconfig_read          (reconfig_read                  ),    // input  wire [0:0]  reconfig_read,
               .reconfig_address       (reconfig_address               ),    // input  wire [9:0]  reconfig_address,
               .reconfig_writedata     (reconfig_writedata             ),    // input  wire [31:0] reconfig_writedata,
               .reconfig_readdata      (reconfig_readdata              ),    // output wire [31:0] reconfig_readdata,
               .reconfig_waitrequest   (reconfig_waitrequest           ),    // output wire [0:0]  reconfig_waitrequest
               .rx_polinv              (rx_polinv                      )     // input wire [3:0]  rx_polinv

            );
         end
         else if (protocol_version=="Gen 2") begin  :g_phy_g2x4
            phy_g2x4 phy_g2x4 (
               .tx_analogreset         (tx_analogreset                 ),   //  input  wire [3:0]   tx_analogreset,        //
               .tx_digitalreset        (tx_digitalreset                ),   //  input  wire [3:0]   tx_digitalreset,       //
               .rx_analogreset         (rx_analogreset                 ),   //  input  wire [3:0]   rx_analogreset,        //
               .rx_digitalreset        (rx_digitalreset                ),   //  input  wire [3:0]   rx_digitalreset,       //
               .tx_cal_busy            (tx_cal_busy                    ),   //  output wire [3:0]   tx_cal_busy,           //
               .rx_cal_busy            (rx_cal_busy                    ),   //  output wire [3:0]   rx_cal_busy,           //
               .tx_bonding_clocks      ({LANES{tx_bonding_clocks}}     ),   //  input  wire [23:0]  tx_bonding_clocks,     //
               .rx_cdr_refclk0         (rx_cdr_refclk0                 ),   //  input  wire         rx_cdr_refclk0,        //
               .tx_serial_data         (tx_serial_data                 ),   //  output wire [3:0]   tx_serial_data,        //
               .rx_serial_data         (rx_serial_data                 ),   //  input  wire [3:0]   rx_serial_data,        //
               .rx_set_locktodata      (rx_set_locktodata              ),   //  input  wire [3:0]   rx_set_locktodata,     //
               .rx_set_locktoref       (rx_set_locktoref               ),   //  input  wire [3:0]   rx_set_locktoref,      //
               .rx_is_lockedtoref      (rx_is_lockedtoref              ),   //  output wire [3:0]   rx_is_lockedtoref,     //
               .rx_is_lockedtodata     (rx_is_lockedtodata             ),   //  output wire [3:0]   rx_is_lockedtodata,    //
               .tx_hip_data            (tx_hip_data                    ),   //  input  wire [255:0] tx_hip_data,           //
               .rx_hip_data            (rx_hip_data                    ),   //  output wire [203:0] rx_hip_data,           //
               .hip_pipe_pclk          (hip_pipe_pclk                  ),   //  output wire         hip_pipe_pclk,         //
               .hip_fixedclk           (hip_fixedclk                   ),   //  output wire         hip_fixedclk,          //
               .hip_frefclk            (hip_frefclk                    ),   //  output wire [3:0]   hip_frefclk,           //
               .hip_ctrl               (hip_ctrl                       ),   //  output wire [31:0]  hip_ctrl,              //
               .hip_cal_done           (chnl_cal_done                  ),   //  output wire [3:0]   hip_cal_done,          //
               .pipe_rate              (pipe_rate                      ),   //  input  wire [7:0]   pipe_rate,             //
               .pipe_sw_done           (pcie_sw_done                   ),   //  input  wire [1:0]   pipe_sw_done,          //
               .pipe_sw                (pcie_sw                        ),   //  output wire [1:0]   pipe_sw,               //
               .pipe_hclk_in           (pll_pcie_clk_int               ),   //  input  wire         pipe_hclk_in,          //
               .pipe_rx_eidleinfersel  (pipe_rx_eidleinfersel          ),   //  input  wire [11:0]  pipe_rx_eidleinfersel, //
               .pipe_rx_elecidle       (pipe_rx_elecidle               ),   //  output wire [3:0]   pipe_rx_elecidle,      //
               .pipe_rx_polarity       (pipe_rx_polarity               ),   //  input  wire [3:0]   pipe_rx_polarity       //
               .hip_reduce_counters    (hip_reduce_counters            ),
               .pcie_rate              (current_rate                   ),           // PCIe generation
               .ltssm_rcvr_equalization   (ltssm_eq_phase2                ),   // LTSSM equalization Phase2
               .ltssm_detect_active    (ltssm_detect_active            ),   // LTSSM Detect Active state
               .ltssm_detect_quiet     (ltssm_detect_quiet             ),   // LTSSM Detect Quiet state
               .reconfig_clk           (reconfig_clk                   ),   // input  wire [0:0]  reconfig_clk,
               .reconfig_reset         (reconfig_reset                 ),   // input  wire [0:0]  reconfig_reset,
               .reconfig_write         (reconfig_write                 ),   // input  wire [0:0]  reconfig_write,
               .reconfig_read          (reconfig_read                  ),   // input  wire [0:0]  reconfig_read,
               .reconfig_address       (reconfig_address               ),   // input  wire [9:0]  reconfig_address,
               .reconfig_writedata     (reconfig_writedata             ),   // input  wire [31:0] reconfig_writedata,
               .reconfig_readdata      (reconfig_readdata              ),   // output wire [31:0] reconfig_readdata,
               .reconfig_waitrequest   (reconfig_waitrequest           ),   // output wire [0:0]  reconfig_waitrequest
               .rx_polinv              (rx_polinv                      )     // input wire [3:0]  rx_polinv
            );
         end
         else begin  :g_phy_g3x4
            phy_g3x4 phy_g3x4 (
               .tx_analogreset         (tx_analogreset                 ), // input  wire [3:0]   tx_analogreset,        //
               .tx_digitalreset        (tx_digitalreset                ), // input  wire [3:0]   tx_digitalreset,       //
               .rx_analogreset         (rx_analogreset                 ), // input  wire [3:0]   rx_analogreset,        //
               .rx_digitalreset        (rx_digitalreset                ), // input  wire [3:0]   rx_digitalreset,       //
               .tx_cal_busy            (tx_cal_busy                    ), // output wire [3:0]   tx_cal_busy,           //
               .rx_cal_busy            (rx_cal_busy                    ), // output wire [3:0]   rx_cal_busy,           //
               .tx_bonding_clocks      ({LANES{tx_bonding_clocks}}     ), // input  wire [23:0]  tx_bonding_clocks,     //
               .rx_cdr_refclk0         (rx_cdr_refclk0                 ), // input  wire         rx_cdr_refclk0,        //
               .tx_serial_data         (tx_serial_data                 ), // output wire [3:0]   tx_serial_data,        //
               .rx_serial_data         (rx_serial_data                 ), // input  wire [3:0]   rx_serial_data,        //
               .rx_set_locktodata      (rx_set_locktodata              ), // input  wire [3:0]   rx_set_locktodata,     //
               .rx_set_locktoref       (rx_set_locktoref               ), // input  wire [3:0]   rx_set_locktoref,      //
               .rx_is_lockedtoref      (rx_is_lockedtoref              ), // output wire [3:0]   rx_is_lockedtoref,     //
               .rx_is_lockedtodata     (rx_is_lockedtodata             ), // output wire [3:0]   rx_is_lockedtodata,    //
               .tx_hip_data            (tx_hip_data                    ), // input  wire [255:0] tx_hip_data,           //
               .rx_hip_data            (rx_hip_data                    ), // output wire [203:0] rx_hip_data,           //
               .hip_pipe_pclk          (hip_pipe_pclk                  ), // output wire         hip_pipe_pclk,         //
               .hip_fixedclk           (hip_fixedclk                   ), // output wire         hip_fixedclk,          //
               .hip_frefclk            (hip_frefclk                    ), // output wire [3:0]   hip_frefclk,           //
               .hip_ctrl               (hip_ctrl                       ), // output wire [31:0]  hip_ctrl,              //
               .hip_cal_done           (chnl_cal_done                  ), // output wire [3:0]   hip_cal_done,          //
               .pipe_rate              (pipe_rate                      ), // input  wire [7:0]   pipe_rate,             //
               .pipe_sw_done           (pcie_sw_done                   ), // input  wire [1:0]   pipe_sw_done,          //
               .pipe_sw                (pcie_sw                        ), // output wire [1:0]   pipe_sw,               //
               .pipe_hclk_in           (pll_pcie_clk_int               ), // input  wire         pipe_hclk_in,          //
               .pipe_g3_txdeemph       (pipe_g3_txdeemph               ), // input  wire [71:0]  pipe_g3_txdeemph,      //
               .pipe_g3_rxpresethint   (pipe_g3_rxpresethint           ), // input  wire [11:0]  pipe_g3_rxpresethint,  //
               .pipe_rx_eidleinfersel  (pipe_rx_eidleinfersel          ), // input  wire [11:0]  pipe_rx_eidleinfersel, //
               .pipe_rx_elecidle       (pipe_rx_elecidle               ), // output wire [3:0]   pipe_rx_elecidle,      //
               .pipe_rx_polarity       (pipe_rx_polarity               ), // input  wire [3:0]   pipe_rx_polarity       //
               .hip_reduce_counters    (hip_reduce_counters            ),
               .pcie_rate              (current_rate                   ),           // PCIe generation
               .ltssm_rcvr_equalization   (ltssm_eq_phase2                ),   // LTSSM equalization Phase2
               .ltssm_detect_active    (ltssm_detect_active            ),   // LTSSM Detect Active state
               .ltssm_detect_quiet     (ltssm_detect_quiet             ),   // LTSSM Detect Quiet state
               .reconfig_clk           (reconfig_clk                   ),    // input  wire [0:0]  reconfig_clk,
               .reconfig_reset         (reconfig_reset                 ),    // input  wire [0:0]  reconfig_reset,
               .reconfig_write         (reconfig_write                 ),    // input  wire [0:0]  reconfig_write,
               .reconfig_read          (reconfig_read                  ),    // input  wire [0:0]  reconfig_read,
               .reconfig_address       (reconfig_address               ),    // input  wire [9:0]  reconfig_address,
               .reconfig_writedata     (reconfig_writedata             ),    // input  wire [31:0] reconfig_writedata,
               .reconfig_readdata      (reconfig_readdata              ),    // output wire [31:0] reconfig_readdata,
               .reconfig_waitrequest   (reconfig_waitrequest           ),    // output wire [0:0]  reconfig_waitrequest
               .rx_polinv              (rx_polinv                      )     // input wire [3:0]  rx_polinv

            );
         end
      end
   /////////                    X8              ///////////////////////////////////////////////
      else  begin
         if (protocol_version=="Gen 1") begin  :g_phy_g1x8
            phy_g1x8 phy_g1x8 (
               .tx_analogreset         (tx_analogreset                 ),    // input  wire [7:0]   tx_analogreset,        //
               .tx_digitalreset        (tx_digitalreset                ),    // input  wire [7:0]   tx_digitalreset,       //
               .rx_analogreset         (rx_analogreset                 ),    // input  wire [7:0]   rx_analogreset,        //
               .rx_digitalreset        (rx_digitalreset                ),    // input  wire [7:0]   rx_digitalreset,       //
               .tx_cal_busy            (tx_cal_busy                    ),    // output wire [7:0]   tx_cal_busy,           //
               .rx_cal_busy            (rx_cal_busy                    ),    // output wire [7:0]   rx_cal_busy,           //
               .tx_bonding_clocks      ({LANES{tx_bonding_clocks}}     ),    // input  wire [47:0]  tx_bonding_clocks,     //
               .rx_cdr_refclk0         (rx_cdr_refclk0                 ),    // input  wire         rx_cdr_refclk0,        //
               .tx_serial_data         (tx_serial_data                 ),    // output wire [7:0]   tx_serial_data,        //
               .rx_serial_data         (rx_serial_data                 ),    // input  wire [7:0]   rx_serial_data,        //
               .rx_set_locktodata      (rx_set_locktodata              ),    // input  wire [7:0]   rx_set_locktodata,     //
               .rx_set_locktoref       (rx_set_locktoref               ),    // input  wire [7:0]   rx_set_locktoref,      //
               .rx_is_lockedtoref      (rx_is_lockedtoref              ),    // output wire [7:0]   rx_is_lockedtoref,     //
               .rx_is_lockedtodata     (rx_is_lockedtodata             ),    // output wire [7:0]   rx_is_lockedtodata,    //
               .tx_hip_data            (tx_hip_data                    ),    // input  wire [511:0] tx_hip_data,           //
               .rx_hip_data            (rx_hip_data                    ),    // output wire [407:0] rx_hip_data,           //
               .hip_pipe_pclk          (hip_pipe_pclk                  ),    // output wire         hip_pipe_pclk,         //
               .hip_fixedclk           (hip_fixedclk                   ),    // output wire         hip_fixedclk,          //
               .hip_frefclk            (hip_frefclk                    ),    // output wire [7:0]   hip_frefclk,           //
               .hip_ctrl               (hip_ctrl                       ),    // output wire [63:0]  hip_ctrl,              //
               .hip_cal_done           (chnl_cal_done                  ),    // output wire [7:0]   hip_cal_done,          //
               .pipe_rate              (pipe_rate                      ),    // input  wire [1:0]  pipe_rate,
               .pipe_sw_done           (pcie_sw_done                   ),    // input  wire [1:0]  pipe_sw_done,
               .pipe_sw                (pcie_sw                        ),    // output wire [1:0]  pipe_sw,
               .pipe_hclk_in           (pll_pcie_clk_int               ),    // input  wire         pipe_hclk_in,          //
               .pipe_rx_eidleinfersel  (pipe_rx_eidleinfersel          ),    // input  wire [23:0]  pipe_rx_eidleinfersel, //
               .pipe_rx_elecidle       (pipe_rx_elecidle               ),    // output wire [7:0]   pipe_rx_elecidle,      //
               .pipe_rx_polarity       (pipe_rx_polarity               ),    // input  wire [7:0]   pipe_rx_polarity       //
               .hip_reduce_counters    (hip_reduce_counters            ),
               .pcie_rate              (current_rate                   ),           // PCIe generation
               .ltssm_rcvr_equalization   (ltssm_eq_phase2                ),   // LTSSM equalization Phase2
               .ltssm_detect_active    (ltssm_detect_active            ),   // LTSSM Detect Active state
               .ltssm_detect_quiet     (ltssm_detect_quiet             ),   // LTSSM Detect Quiet state
               .reconfig_clk           (reconfig_clk                   ),    // input  wire [0:0]  reconfig_clk,
               .reconfig_reset         (reconfig_reset                 ),    // input  wire [0:0]  reconfig_reset,
               .reconfig_write         (reconfig_write                 ),    // input  wire [0:0]  reconfig_write,
               .reconfig_read          (reconfig_read                  ),    // input  wire [0:0]  reconfig_read,
               .reconfig_address       (reconfig_address               ),    // input  wire [9:0]  reconfig_address,
               .reconfig_writedata     (reconfig_writedata             ),    // input  wire [31:0] reconfig_writedata,
               .reconfig_readdata      (reconfig_readdata              ),    // output wire [31:0] reconfig_readdata,
               .reconfig_waitrequest   (reconfig_waitrequest           ),    // output wire [0:0]  reconfig_waitrequest
               .rx_polinv              (rx_polinv                      )     // input wire [7:0]  rx_polinv

            );
         end
         else if (protocol_version=="Gen 2") begin  :g_phy_g2x8
            phy_g2x8 phy_g2x8 (
               .tx_analogreset         (tx_analogreset                 ),   //  input  wire [7:0]   tx_analogreset,        //
               .tx_digitalreset        (tx_digitalreset                ),   //  input  wire [7:0]   tx_digitalreset,       //
               .rx_analogreset         (rx_analogreset                 ),   //  input  wire [7:0]   rx_analogreset,        //
               .rx_digitalreset        (rx_digitalreset                ),   //  input  wire [7:0]   rx_digitalreset,       //
               .tx_cal_busy            (tx_cal_busy                    ),   //  output wire [7:0]   tx_cal_busy,           //
               .rx_cal_busy            (rx_cal_busy                    ),   //  output wire [7:0]   rx_cal_busy,           //
               .tx_bonding_clocks      ({LANES{tx_bonding_clocks}}     ),   //  input  wire [47:0]  tx_bonding_clocks,     //
               .rx_cdr_refclk0         (rx_cdr_refclk0                 ),   //  input  wire         rx_cdr_refclk0,        //
               .tx_serial_data         (tx_serial_data                 ),   //  output wire [7:0]   tx_serial_data,        //
               .rx_serial_data         (rx_serial_data                 ),   //  input  wire [7:0]   rx_serial_data,        //
               .rx_set_locktodata      (rx_set_locktodata              ),   //  input  wire [7:0]   rx_set_locktodata,     //
               .rx_set_locktoref       (rx_set_locktoref               ),   //  input  wire [7:0]   rx_set_locktoref,      //
               .rx_is_lockedtoref      (rx_is_lockedtoref              ),   //  output wire [7:0]   rx_is_lockedtoref,     //
               .rx_is_lockedtodata     (rx_is_lockedtodata             ),   //  output wire [7:0]   rx_is_lockedtodata,    //
               .tx_hip_data            (tx_hip_data                    ),   //  input  wire [511:0] tx_hip_data,           //
               .rx_hip_data            (rx_hip_data                    ),   //  output wire [407:0] rx_hip_data,           //
               .hip_pipe_pclk          (hip_pipe_pclk                  ),   //  output wire         hip_pipe_pclk,         //
               .hip_fixedclk           (hip_fixedclk                   ),   //  output wire         hip_fixedclk,          //
               .hip_frefclk            (hip_frefclk                    ),   //  output wire [7:0]   hip_frefclk,           //
               .hip_ctrl               (hip_ctrl                       ),   //  output wire [63:0]  hip_ctrl,              //
               .hip_cal_done           (chnl_cal_done                  ),   //  output wire [7:0]   hip_cal_done,          //
               .pipe_rate              (pipe_rate                      ),   //  input  wire [15:0]  pipe_rate,             //
               .pipe_sw_done           (pcie_sw_done                   ),   //  input  wire [1:0]   pipe_sw_done,          //
               .pipe_sw                (pcie_sw                        ),   //  output wire [1:0]   pipe_sw,               //
               .pipe_hclk_in           (pll_pcie_clk_int               ),   //  input  wire         pipe_hclk_in,          //
               .pipe_rx_eidleinfersel  (pipe_rx_eidleinfersel          ),   //  input  wire [23:0]  pipe_rx_eidleinfersel, //
               .pipe_rx_elecidle       (pipe_rx_elecidle               ),   //  output wire [7:0]   pipe_rx_elecidle,      //
               .pipe_rx_polarity       (pipe_rx_polarity               ),   //  input  wire [7:0]   pipe_rx_polarity       //
               .hip_reduce_counters    (hip_reduce_counters            ),
               .pcie_rate              (current_rate                   ),           // PCIe generation
               .ltssm_rcvr_equalization   (ltssm_eq_phase2                ),   // LTSSM equalization Phase2
               .ltssm_detect_active    (ltssm_detect_active            ),   // LTSSM Detect Active state
               .ltssm_detect_quiet     (ltssm_detect_quiet             ),   // LTSSM Detect Quiet state
               .reconfig_clk           (reconfig_clk                   ),    // input  wire [0:0]  reconfig_clk,
               .reconfig_reset         (reconfig_reset                 ),    // input  wire [0:0]  reconfig_reset,
               .reconfig_write         (reconfig_write                 ),    // input  wire [0:0]  reconfig_write,
               .reconfig_read          (reconfig_read                  ),    // input  wire [0:0]  reconfig_read,
               .reconfig_address       (reconfig_address               ),    // input  wire [9:0]  reconfig_address,
               .reconfig_writedata     (reconfig_writedata             ),    // input  wire [31:0] reconfig_writedata,
               .reconfig_readdata      (reconfig_readdata              ),    // output wire [31:0] reconfig_readdata,
               .reconfig_waitrequest   (reconfig_waitrequest           ),    // output wire [0:0]  reconfig_waitrequest
               .rx_polinv              (rx_polinv                      )     // input wire [7:0]  rx_polinv
            );
         end
         else begin  :g_phy_g3x8
            phy_g3x8 phy_g3x8 (
               .rx_parallel_data       (rx_parallel_data               ),
               .rx_clkout              (rx_clkout                      ),
               .tx_analogreset         (tx_analogreset                 ),    // input  wire [7:0]   tx_analogreset,        //
               .tx_digitalreset        (tx_digitalreset                ),    // input  wire [7:0]   tx_digitalreset,       //
               .rx_analogreset         (rx_analogreset                 ),    // input  wire [7:0]   rx_analogreset,        //
               .rx_digitalreset        (rx_digitalreset                ),    // input  wire [7:0]   rx_digitalreset,       //
               .tx_cal_busy            (tx_cal_busy                    ),    // output wire [7:0]   tx_cal_busy,           //
               .rx_cal_busy            (rx_cal_busy                    ),    // output wire [7:0]   rx_cal_busy,           //
               .tx_bonding_clocks      ({LANES{tx_bonding_clocks}}     ),    // input  wire [47:0]  tx_bonding_clocks,     //
               .rx_cdr_refclk0         (rx_cdr_refclk0                 ),    // input  wire         rx_cdr_refclk0,        //
               .tx_serial_data         (tx_serial_data                 ),    // output wire [7:0]   tx_serial_data,        //
               .rx_serial_data         (rx_serial_data                 ),    // input  wire [7:0]   rx_serial_data,        //
               .rx_set_locktodata      (rx_set_locktodata              ),    // input  wire [7:0]   rx_set_locktodata,     //
               .rx_set_locktoref       (rx_set_locktoref               ),    // input  wire [7:0]   rx_set_locktoref,      //
               .rx_is_lockedtoref      (rx_is_lockedtoref              ),    // output wire [7:0]   rx_is_lockedtoref,     //
               .rx_is_lockedtodata     (rx_is_lockedtodata             ),    // output wire [7:0]   rx_is_lockedtodata,    //
               .tx_hip_data            (tx_hip_data                    ),    // input  wire [511:0] tx_hip_data,           //
               .rx_hip_data            (rx_hip_data                    ),    // output wire [407:0] rx_hip_data,           //
               .hip_pipe_pclk          (hip_pipe_pclk                  ),    // output wire         hip_pipe_pclk,         //
               .hip_fixedclk           (hip_fixedclk                   ),    // output wire         hip_fixedclk,          //
               .hip_frefclk            (hip_frefclk                    ),    // output wire [7:0]   hip_frefclk,           //
               .hip_ctrl               (hip_ctrl                       ),    // output wire [63:0]  hip_ctrl,              //
               .hip_cal_done           (chnl_cal_done                  ),    // output wire [7:0]   hip_cal_done,          //
               .pipe_rate              (pipe_rate                      ),    // input  wire [15:0]  pipe_rate,             //
               .pipe_sw_done           (pcie_sw_done                   ),    // input  wire [1:0]   pipe_sw_done,          //
               .pipe_sw                (pcie_sw                        ),    // output wire [1:0]   pipe_sw,               //
               .pipe_hclk_in           (pll_pcie_clk_int               ),    // input  wire         pipe_hclk_in,          //
               .pipe_g3_txdeemph       (pipe_g3_txdeemph               ),    // input  wire [143:0] pipe_g3_txdeemph,      //
               .pipe_g3_rxpresethint   (pipe_g3_rxpresethint           ),    // input  wire [23:0]  pipe_g3_rxpresethint,  //
               .pipe_rx_eidleinfersel  (pipe_rx_eidleinfersel          ),    // input  wire [23:0]  pipe_rx_eidleinfersel, //
               .pipe_rx_elecidle       (pipe_rx_elecidle               ),    // output wire [7:0]   pipe_rx_elecidle,      //
               .pipe_rx_polarity       (pipe_rx_polarity               ),    // input  wire [7:0]   pipe_rx_polarity       //
               .hip_reduce_counters    (hip_reduce_counters            ),
               .pcie_rate              (current_rate                   ),           // PCIe generation
               .ltssm_rcvr_equalization   (ltssm_eq_phase2                ),   // LTSSM equalization Phase2
               .ltssm_detect_active    (ltssm_detect_active            ),   // LTSSM Detect Active state
               .ltssm_detect_quiet     (ltssm_detect_quiet             ),   // LTSSM Detect Quiet state
               .reconfig_clk           (reconfig_clk                   ),    // input  wire [0:0]  reconfig_clk,
               .reconfig_reset         (reconfig_reset                 ),    // input  wire [0:0]  reconfig_reset,
               .reconfig_write         (reconfig_write                 ),    // input  wire [0:0]  reconfig_write,
               .reconfig_read          (reconfig_read                  ),    // input  wire [0:0]  reconfig_read,
               .reconfig_address       (reconfig_address               ),    // input  wire [9:0]  reconfig_address,
               .reconfig_writedata     (reconfig_writedata             ),    // input  wire [31:0] reconfig_writedata,
               .reconfig_readdata      (reconfig_readdata              ),    // output wire [31:0] reconfig_readdata,
               .reconfig_waitrequest   (reconfig_waitrequest           ),    // output wire [0:0]  reconfig_waitrequest
               .rx_polinv              (rx_polinv                      )     // input wire [7:0]  rx_polinv
            );
         end
      end
end
endgenerate

////////////////////////////////////
///////////   ATX PLL   ////////////
////////////////////////////////////
generate begin : g_pll
      // TODO
      wire OPEN_hip_cal_done;
      wire OPEN_pll_locked;

      if ((protocol_version=="Gen 1") || (protocol_version=="Gen 2")) begin
         if (xn_design==0) begin : g_pll_g1g2x1
            fpll_g1g2x1 fpll_g1g2x1 (
               .pll_powerdown          (pll_powerdown_fpll        ),  // input  wire  pll_powerdown, //
               .pll_refclk0            (pll_refclk0               ),  // input  wire  pll_refclk0,   //
               .tx_serial_clk          (tx_serial_clk0            ),  // output wire  tx_serial_clk, //
               .pll_locked             (pll_locked_fpll           ),  // output wire  pll_locked,    //
               .pll_pcie_clk           (pll_pcie_clk              ),  // output wire  pll_pcie_clk,  //
               .hip_cal_done           (pll_cal_done_fpll         ),  // output wire  hip_cal_done   //
               .reconfig_clk0          (reconfig_pll0_clk         ),                          //    reconfig_clk0.clk
               .reconfig_reset0        (reconfig_pll0_reset       ),                          //    reconfig_reset0.reset
               .reconfig_write0        (reconfig_pll0_write       ),                          //    reconfig_avmm0.write
               .reconfig_read0         (reconfig_pll0_read        ),                          //                  .read
               .reconfig_address0      (reconfig_pll0_address     ),                          //                  .address
               .reconfig_writedata0    (reconfig_pll0_writedata   ),                          //                  .writedata
               .reconfig_readdata0     (reconfig_pll0_readdata    ),                          //                  .readdata
               .reconfig_waitrequest0  (reconfig_pll0_waitrequest )                           //                  .waitrequest
            );
         end
         else begin : g_pll_g12n
            fpll_g1g2xn fpll_g1g2xn (
               .pll_powerdown         (pll_powerdown_fpll         ),  // input  wire       pll_powerdown,
               .pll_refclk0           (pll_refclk0                ),  // input  wire       pll_refclk0,
               .pll_locked            (pll_locked_fpll            ),  // output wire       pll_locked,
               .pll_pcie_clk          (pll_pcie_clk               ),  // output wire       pll_pcie_clk,
               .mcgb_hip_cal_done     (pll_cal_done_fpll          ),  // output wire       mcgb_hip_cal_done,
               .mcgb_rst              (mcgb_rst                   ),  // input  wire       mcgb_rst,
               .tx_bonding_clocks     (tx_bonding_clocks          ),  // output wire [5:0] tx_bonding_clocks,
               .pcie_sw               (pcie_sw                    ),  // input  wire [1:0] pcie_sw,
               .pcie_sw_done          (pcie_sw_done               ),  // output wire [1:0] pcie_sw_done,
               .reconfig_clk0         (reconfig_pll0_clk         ),                          //    reconfig_clk0.clk
               .reconfig_reset0       (reconfig_pll0_reset       ),                          //    reconfig_reset0.reset
               .reconfig_write0       (reconfig_pll0_write       ),                          //    reconfig_avmm0.write
               .reconfig_read0        (reconfig_pll0_read        ),                          //                  .read
               .reconfig_address0     (reconfig_pll0_address     ),                          //                  .address
               .reconfig_writedata0   (reconfig_pll0_writedata   ),                          //                  .writedata
               .reconfig_readdata0    (reconfig_pll0_readdata    ),                          //                  .readdata
               .reconfig_waitrequest0 (reconfig_pll0_waitrequest )                           //                  .waitrequest
            );
         end
      end
      else begin // protocol_version=="Gen 3"
            fpll_g3 fpll_g3 (
               .pll_refclk0            (pll_refclk0               ), // input  wire  pll_refclk0,
               .pll_powerdown          (pll_powerdown_fpll        ), // input  wire  pll_powerdown,
               .pll_locked             (pll_locked_fpll           ), // output wire  pll_locked,   // TODO Connect to something
               .tx_serial_clk          (tx_serial_clk0            ), // output wire  ,
               .pll_pcie_clk           (pll_pcie_clk              ),
               .hip_cal_done           (pll_cal_done_fpll         ), // output wire  hip_cal_done  // TODO Connect to something
               .reconfig_clk0          (reconfig_pll0_clk         ),                          //    reconfig_clk0.clk
               .reconfig_reset0        (reconfig_pll0_reset       ),                          //    reconfig_reset0.reset
               .reconfig_write0        (reconfig_pll0_write       ),                          //    reconfig_avmm0.write
               .reconfig_read0         (reconfig_pll0_read        ),                          //                  .read
               .reconfig_address0      (reconfig_pll0_address     ),                          //                  .address
               .reconfig_writedata0    (reconfig_pll0_writedata   ),                          //                  .writedata
               .reconfig_readdata0     (reconfig_pll0_readdata    ),                          //                  .readdata
               .reconfig_waitrequest0  (reconfig_pll0_waitrequest )                           //                  .waitrequest
            );

         if (xn_design==0) begin : g_pll_g3x1
            lcpll_g3x1 lcpll_g3x1 (
               .pll_powerdown          (pll_powerdown_lcpll       ),// input  wire  pll_powerdown, //
               .pll_refclk0            (pll_refclk0               ),// input  wire  pll_refclk0,   //
               .tx_serial_clk          (tx_serial_clk1            ),// output wire  tx_serial_clk, //
               .pll_locked             (pll_locked_lcpll          ),// output wire  pll_locked,
               .hip_cal_done           (pll_cal_done_lcpll        ),// output wire  hip_cal_done   //
               .reconfig_clk0          (reconfig_pll1_clk         ),                               //    reconfig_clk0.clk
               .reconfig_reset0        (reconfig_pll1_reset       ),                               //    reconfig_reset0.reset
               .reconfig_write0        (reconfig_pll1_write       ),                               //    reconfig_avmm0.write
               .reconfig_read0         (reconfig_pll1_read        ),                               //                  .read
               .reconfig_address0      (reconfig_pll1_address     ),                               //                  .address
               .reconfig_writedata0    (reconfig_pll1_writedata   ),                               //                  .writedata
               .reconfig_readdata0     (reconfig_pll1_readdata    ),                               //                  .readdata
               .reconfig_waitrequest0  (reconfig_pll1_waitrequest )                                //                  .waitrequest
            );
         end
         else begin : g_pll_g3n
            lcpll_g3xn lcpll_g3xn (
               .pll_powerdown         (pll_powerdown_lcpll       ), // input  wire       pll_powerdown,    //    pll_powerdown.pll_powerdown
               .pll_refclk0           (pll_refclk0               ), // input  wire       pll_refclk0,      //      pll_refclk0.clk
               .pll_locked            (pll_locked_lcpll          ), // output wire       pll_locked,       //       pll_locked.pll_locked
               .hip_cal_done          (pll_cal_done_lcpll        ), // output wire       hip_cal_done,     //     hip_cal_done.hip_cal_done
               .mcgb_rst              (mcgb_rst                  ), // input  wire       mcgb_rst,         //         mcgb_rst.mcgb_rst
               .mcgb_aux_clk0         (tx_serial_clk0            ),
               .tx_bonding_clocks     (tx_bonding_clocks         ), // output wire [5:0] mcgb_bonding_clk, // mcgb_bonding_clk.mcgb_bonding_clk
               .pcie_sw               (pcie_sw                   ), // input  wire [1:0] pcie_sw,          //          pcie_sw.pcie_sw       // ONLY used in bonded mode, for X1 phy_ip has internal CGB
               .pcie_sw_done          (pcie_sw_done              ), // output wire [1:0] pcie_sw_done,     //     pcie_sw_done.pcie_sw_done  //
               .reconfig_clk0         (reconfig_pll1_clk         ),                          //    reconfig_clk0.clk
               .reconfig_reset0       (reconfig_pll1_reset       ),                          //    reconfig_reset0.reset
               .reconfig_write0       (reconfig_pll1_write       ),                          //    reconfig_avmm0.write
               .reconfig_read0        (reconfig_pll1_read        ),                          //                  .read
               .reconfig_address0     (reconfig_pll1_address     ),                          //                  .address
               .reconfig_writedata0   (reconfig_pll1_writedata   ),                          //                  .writedata
               .reconfig_readdata0    (reconfig_pll1_readdata    ),                          //                  .readdata
               .reconfig_waitrequest0 (reconfig_pll1_waitrequest )                           //                  .waitrequest
            );
         end
      end
end
endgenerate

endmodule

