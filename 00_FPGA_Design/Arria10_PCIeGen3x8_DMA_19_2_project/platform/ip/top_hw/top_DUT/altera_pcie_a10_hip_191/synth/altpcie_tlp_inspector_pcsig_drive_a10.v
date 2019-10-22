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


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                                                   //
//    ALTPCIE_TLP_INSPECTOR : Optional module to monitor TLP Performances on AvalonTream HIP Bus, added to ALTPCIE_HIP_256_PIPEn1B                   //
//                                                                                                                                                   //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                                                   //
//    ____________________________________________________________________________________________________________________________________________   //
//    |                                                                                                                                          |   //
//    |                                                       PCIe TLP Header                                                                    |   //
//    |__________________________________________________________________________________________________________________________________________|   //
//    |31  30  29  |28  27  26  25  24  |23  |22  21  20  |19  |18  |17  |16  |15  |14  |13  12  |11  10  |9   8   7   6   5   4   3   2   1   0 |   //
//    |7   6   5   |4   3   2   1   0   |7   |6   5   4   |3   |2   |1   |0   |7   |6   |5   4   |3   2   |1   0   7   6   5   4   3   2   1   0 |   //
// h1 |FMT         |TYPE                |R   |TC          |R   |A   |R   |TH  |TD  |EP  |Attr    |ATT     |Length                                |   //
// h2 |                                                                                                            | Last BE        |First BE    |   //
// h3 |                                                                                                                                          |   //
// h4 |__________________________________________________________________________________________________________________________________________|   //
//    |                                                                                                                                          |   //
//    |                                                     MEMORY TLP                                                                           |   //
//    |__________________________________________________________________________________________________________________________________________|   //
// h2 |            Requester ID                                               |    TAG                             | Last BE        |First BE    |   //
// h3 |               Address                                                                                                                    |   //
// h4 |__________________________________________________________________________________________________________________________________________|   //
//    |                                                                                                                                          |   //
//    |                                                     COMPLETION TLP                                                                       |   //
//    |__________________________________________________________________________________________________________________________________________|   //
// h2 |            Completer ID                                               |Cpl Status     |  |    Byte Count                                 |   //
// h3 |            Requester ID                                               |    TAG                             | R | Lower Address           |   //
// h4 |__________________________________________________________________________________________________________________________________________|   //
//                                                                                                                                                   //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on


module altpcie_tlp_inspector_pcsig_drive_a10 # (
      parameter ST_DATA_WIDTH                         = 64,
      parameter VSEC_HIPDRV_SIGNAL_PAR                = 0,
      parameter VSEC_HIPDRV_SIGNAL_PWR                = 0,
      parameter ST_BE_WIDTH                           = 8,
      parameter LANES                                 = 8,
      parameter ST_CTRL_WIDTH                         = 1,
      parameter PLD_CLK_IS_250MHZ                     = 0
      ) (
      // Single clock domain clk (which is pld_clk in the level above)
      //    - All Inputs are synchronized to clk
      //    - All Outputs are synchronized to clk

      // CSEB Signals
      input                       pcsig_wr_pulse_op  , // In  Wr Pulse 0x50
      input                       pcsig_wr_pulse_dt  , // In  Wr Pulse 0x54
      input  [31:0]               pcsig_wrdata       , // in  [31:0]
      input  [31:0]               pcsig_opcode       , // in  [31:0]
      input                       pcsig_rd_pulse_dt  , // In  Rd Pulse - Read Data Register
      input                       pcsig_rd_pulse_st  , // In  Rd Pulse - Read Status Register
      output reg [31:0]           pcsig_rddata       , // out [31:0]


      // HIP.AST Interface
      input [ST_BE_WIDTH-1 : 0]   rx_ast_be     ,
      input [ST_DATA_WIDTH-1 : 0] rx_ast_data   ,
      input [1 : 0]               rx_ast_empty  ,
      input [ST_CTRL_WIDTH-1 : 0] rx_ast_eop    ,
      input [ST_CTRL_WIDTH-1 : 0] rx_ast_sop    ,
      input [ST_CTRL_WIDTH-1 : 0] rx_ast_valid  ,
      output reg                  rx_st_mask    ,
      output reg                  rx_st_ready   ,

      input                       tx_ast_ready  ,
      output reg [255 : 0]        tx_st_data    ,
      output reg [1 :0]           tx_st_empty   ,
      output reg [3 :0]           tx_st_eop     ,
      output reg [3 :0]           tx_st_err     ,
      output reg [3 :0]           tx_st_sop     ,
      output reg                  tx_st_valid   ,

      output reg [4 : 0]          aer_msi_num   ,
      output reg                  app_int_sts   ,
      output reg [4 : 0]          app_msi_num   ,
      output reg                  app_msi_req   ,
      output reg [2 : 0]          app_msi_tc    ,
      output reg [4 : 0]          pex_msi_num   ,

      output reg [31:0]           tx_st_parity  ,
      output reg                  pm_auxpwr     ,
      output reg [9 : 0]          pm_data       ,
      output reg                  pme_to_cr     ,
      output reg                  pm_event      ,
      output reg [6 :0]           cpl_err       ,
      output reg                  cpl_pending   ,
      input                       clk           ,
      input                       sclr

      );

localparam ZEROS               = 512'h0;

localparam TLP_TXFIFO_WIDTH    = ST_DATA_WIDTH + // output reg [255|127|64 : 0] tx_st_data
                                             2 + // output reg [1 :0]           tx_st_empty
                                             4 + // output reg [3 :0]           tx_st_eop
                                             4 + // output reg [3 :0]           tx_st_err
                                             4 + // output reg [3 :0]           tx_st_sop
                                             1 + // output reg                  tx_st_valid
                                             5 + // output reg [4 : 0]          aer_msi_num
                                             1 + // output reg                  app_int_sts
                                             5 + // output reg [4 : 0]          app_msi_num
                                             1 + // output reg                  app_msi_req
                                             3 + // output reg [2 : 0]          app_msi_tc
                                 (ST_DATA_WIDTH==64)? 6:
                                 (ST_DATA_WIDTH==128)? 2: 14;

localparam TLP_TXFIFO_WIDTH_DW = (ST_DATA_WIDTH/32)+1; // Number of DWORD

// synthesis translate_off
initial begin
      pcsig_rddata = ZEROS[31:0]    ; // out [31:0]

      aer_msi_num  = ZEROS [4 : 0]  ;  //Out [4 : 0]
      app_int_sts  = ZEROS [0]      ;  //Out
      app_msi_num  = ZEROS [4 : 0]  ;  //Out [4 : 0]
      app_msi_req  = ZEROS [0]      ;  //Out
      app_msi_tc   = ZEROS [2 : 0]  ;  //Out [2 : 0]
      pex_msi_num  = ZEROS [4 : 0]  ;  //Out [4 : 0]

      pm_auxpwr    = ZEROS [0]      ;  //Out
      pm_data      = ZEROS [9 : 0]  ;  //Out [9 : 0]
      pme_to_cr    = ZEROS [0]      ;  //Out
      pm_event     = ZEROS [0]      ;  //Out

      rx_st_mask   = ZEROS [0]      ;  //Out
      rx_st_ready  = ZEROS [0]      ;  //Out

      tx_st_data   = ZEROS [255 : 0];  //Out [255 : 0]
      tx_st_empty  = ZEROS [1 :0]   ;  //Out [1 :0]
      tx_st_eop    = ZEROS [3 :0]   ;  //Out [3 :0]
      tx_st_err    = ZEROS [3 :0]   ;  //Out [3 :0]
      tx_st_parity = ZEROS [31:0]   ;  //Out [31:0]
      tx_st_sop    = ZEROS [3 :0]   ;  //Out [3 :0]
      tx_st_valid  = ZEROS [0]      ;  //Out

      cpl_err      = ZEROS [6 :0]   ;  //Out [6 :0]
      cpl_pending  = ZEROS [0]      ;  //Out
end
// synthesis translate_on


reg [4:0]                   tlp_txfifo_cntwr  ;
reg [TLP_TXFIFO_WIDTH-1:0]  tlp_txfifo_wdata  ;
reg                         tlp_txfifo_wreq   ;
reg                         tlp_txfifo_rreq   ;
wire                        tlp_txfifo_full   ;
wire [TLP_TXFIFO_WIDTH-1:0] tlp_txfifo_rdata  ;
wire                        tlp_txfifo_empty  ;
wire [4:0]                  tlp_txfifo_used   ;

always @(posedge clk) begin : p_cseb
   if (sclr == 1'b1 ) begin
      pcsig_rddata <= ZEROS[31:0]    ; // out [31:0]

      aer_msi_num  <= ZEROS [4 : 0]  ;  //Out [4 : 0]
      app_int_sts  <= ZEROS [0]      ;  //Out
      app_msi_num  <= ZEROS [4 : 0]  ;  //Out [4 : 0]
      app_msi_req  <= ZEROS [0]      ;  //Out
      app_msi_tc   <= ZEROS [2 : 0]  ;  //Out [2 : 0]
      pex_msi_num  <= ZEROS [4 : 0]  ;  //Out [4 : 0]

      pm_auxpwr    <= ZEROS [0]      ;  //Out
      pm_data      <= ZEROS [9 : 0]  ;  //Out [9 : 0]
      pme_to_cr    <= ZEROS [0]      ;  //Out
      pm_event     <= ZEROS [0]      ;  //Out

      rx_st_mask   <= ZEROS [0]      ;  //Out
      rx_st_ready  <= ZEROS [0]      ;  //Out

      tx_st_data   <= ZEROS [255 : 0];  //Out [255 : 0]
      tx_st_empty  <= ZEROS [1 :0]   ;  //Out [1 :0]
      tx_st_eop    <= ZEROS [3 :0]   ;  //Out [3 :0]
      tx_st_err    <= ZEROS [3 :0]   ;  //Out [3 :0]
      tx_st_parity <= ZEROS [31:0]   ;  //Out [31:0]
      tx_st_sop    <= ZEROS [3 :0]   ;  //Out [3 :0]
      tx_st_valid  <= ZEROS [0]      ;  //Out

      cpl_err          <= ZEROS [6 :0]   ;  //Out [6 :0]
      cpl_pending      <= ZEROS [0]      ;  //Out

      tlp_txfifo_cntwr <= ZEROS [4:0]                 ;
      tlp_txfifo_wdata <= ZEROS [TLP_TXFIFO_WIDTH-1:0];
      tlp_txfifo_wreq  <= ZEROS [0]                   ;
      tlp_txfifo_rreq  <= ZEROS [0]                   ;
   end
   else begin

      if (VSEC_HIPDRV_SIGNAL_PAR==0) begin
         tx_st_parity <= ZEROS [31:0]   ;  //Out [31:0]
      end

      if (VSEC_HIPDRV_SIGNAL_PWR==0) begin
         pex_msi_num  <= ZEROS [4 : 0]  ;  //Out [4 : 0]
         pm_auxpwr    <= ZEROS [0]      ;  //Out
         pm_data      <= ZEROS [9 : 0]  ;  //Out [9 : 0]
         pme_to_cr    <= ZEROS [0]      ;  //Out
         pm_event     <= ZEROS [0]      ;  //Out
         cpl_err      <= ZEROS [6 :0]   ;  //Out [6 :0]
         cpl_pending  <= ZEROS [0]      ;  //Out
      end

      // Read FIFO
      if (tlp_txfifo_rdata==1'b1) begin
         tx_st_data   [ST_DATA_WIDTH-1 : 0] <= tlp_txfifo_rdata[ST_DATA_WIDTH-1  :               0];//
         tx_st_empty  [1 :0]                <= tlp_txfifo_rdata[ST_DATA_WIDTH+1  :ST_DATA_WIDTH+ 0];//
         tx_st_eop    [3 :0]                <= tlp_txfifo_rdata[ST_DATA_WIDTH+5  :ST_DATA_WIDTH+ 2];//
         tx_st_err    [3 :0]                <= tlp_txfifo_rdata[ST_DATA_WIDTH+9  :ST_DATA_WIDTH+ 6];//
         tx_st_sop    [3 :0]                <= tlp_txfifo_rdata[ST_DATA_WIDTH+13 :ST_DATA_WIDTH+10];//
         tx_st_valid                        <= tlp_txfifo_rdata[ST_DATA_WIDTH+14 :ST_DATA_WIDTH+14];//
         aer_msi_num  [4 : 0]               <= tlp_txfifo_rdata[ST_DATA_WIDTH+19 :ST_DATA_WIDTH+15];//
         app_int_sts                        <= tlp_txfifo_rdata[ST_DATA_WIDTH+20 :ST_DATA_WIDTH+20];//
         app_msi_num  [4 : 0]               <= tlp_txfifo_rdata[ST_DATA_WIDTH+25 :ST_DATA_WIDTH+21];//
         app_msi_req                        <= tlp_txfifo_rdata[ST_DATA_WIDTH+26 :ST_DATA_WIDTH+26];//
         app_msi_tc                         <= tlp_txfifo_rdata[ST_DATA_WIDTH+29 :ST_DATA_WIDTH+27];//
      end
   end
end

   altpcie_scfifo #(
      .WIDTH          (TLP_TXFIFO_WIDTH),
      .NUM_FIFO32     (4 )
   ) tlp_txfifo (
      .clk      (clk               ),
      .sclr     (sclr              ),
      .wdata    (tlp_txfifo_wdata  ),
      .wreq     (tlp_txfifo_wreq   ),
      .full     (tlp_txfifo_full   ),
      .rdata    (tlp_txfifo_rdata  ),
      .rreq     (tlp_txfifo_rreq   ),
      .empty    (tlp_txfifo_empty  ),
      .used     (tlp_txfifo_used   )
   );

endmodule
