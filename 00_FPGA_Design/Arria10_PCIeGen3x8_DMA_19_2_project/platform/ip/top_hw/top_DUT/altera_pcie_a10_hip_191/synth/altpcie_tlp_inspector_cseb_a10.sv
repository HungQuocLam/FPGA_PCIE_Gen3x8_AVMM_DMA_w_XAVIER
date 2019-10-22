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


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                           //
//    altpcie_tlp_inspector_cseb : Extended config space to access TLP Inspector                                             //
//                                                                                                                           //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                           //
//     CSEB Bus Info Overview                                                                                                //
//                                                                                                                           //
//     |-------------------------------------------------------------------------|                                           //
//     |   CSEB address Space                                                    |                                           //
//     |-------------------------------------------------------------------------|                                           //
//     |   PCI/PCIe config space                              | Address value    |                                           //
//     |-------------------------------------------------------------------------|                                           //
//     |  Type0 or Type1 Configuration Registers (PCI Header) | 32'h000-32'h03Ch |                                           //
//     |  Reserved                                            | 32'h040          |                                           //
//     |  Reserved                                            | 32'h044          |                                           //
//     |  Reserved                                            | 32'h048-32'h04Ch |                                           //
//     |  MSI Capability Structure                            | 32'h050-32'h05Ch |                                           //
//     |  Reserved                                            | 32'h060-32'h064h |                                           //
//     |  MSI-X Capability Structure                          | 32'h068-32'h070h |                                           //
//     |  Power Management Capability Structure               | 32'h078-32'h07Ch |                                           //
//     |  PCI Express Capability Structure                    | 32'h080-32'h0BCh |                                           //
//     |  SSID/SSVID Capability Structure                     | 32'h0C0-32'h0C4h |                                           //
//     |  PCI Extensions (CSEB)***                            | 32'h0C8-32'h0FCh |                                           //
//     |  Virtual Channel Capability Structure                | 32'h100-32'h16Ch |                                           //
//     |  Reserved                                            | 32'h170-32'h1FCh |                                           //
//     |  Vendor Specific Extended Capability Structure       | 32'h200-32'h240h |                                           //
//     |  Secondary PciE Extended Capability Structure        | 32'h300-32'h318h |                                           //
//     |  Reserved                                            | 32'h31C-32'h7FCh |                                           //
//     |  AER                                                 | 32'h800-32'h834h |                                           //
//     |  PCI-E Extensions (CSEB)                             | 32'h900-32'hFFFh |                                           //
//     |-------------------------------------------------------------------------|                                           //
//                                                                                                                           //
//     __________________________________________________________________________________________________________________    //
//     |                                                                                                                |    //
//     | PCI Express Extended Capability Header                                                             Offset 8'h0 |    //
//     | _______________________________________________________________________________________________________________|    //
//     |                                                                                                                |    //
//     | 31                     20 |                  16|                                 0                             |    //
//     | Next Capability Offset    | Capability Version |PCI Express Extended Capability ID                             |    //
//     |                                                                                                                |    //
//     | 15:0  PCI Express Extended Capability ID : This field is a PCI-SIG defined ID number that indicates the nature |    //
//     |                                            and format of the Extended Capability.                              |    //
//     |                                            Extended Capability ID for the Vendor-Specific Capability is 000Bh. |    //
//     |                                            RO                                                                  |    //
//     | 19:16 Capability Version                 : This field is a PCI-SIG defined version number that indicates       |    //
//     |                                            the version of the Capability structure present.                    |    //
//     |                                            Must be 1h for this version of the specification                    |    //
//     | 31:20 Next Capability Offset             : This field contains the offset to the next PCI Express              |    //
//     |                                            Capability structure or 000h if no other items exist in             |    //
//     |                                            the linked list of Capabilities.                                    |    //
//     |                                            For Extended Capabilities implemented in Configuration Space,       |    //
//     |                                            this offset is relative to the beginning of PCI-compatible          |    //
//     |                                            Configuration Space and thus must always be either 000h             |    //
//     |                                            (for terminating list of Capabilities) or greater than 0FFh.        |    //
//     |                                                                                                                |    //
//     |________________________________________________________________________________________________________________|    //
//     |                                                                                                                |    //
//     | Vendor-Specific Header                                                                              Offset 04h |    //
//     | _______________________________________________________________________________________________________________|    //
//     |                                                                                                                |    //
//     | 31                     20 |                  16|                                 0                             |    //
//     | VSEC Length               | VSEC Rev           |                 VSEC ID                                       |    //
//     |                                                                                                                |    //
//     | 15:0  VSEC ID                            : This field is a vendor-defined ID number that indicates the nature  |    //
//     |                                            and format of the VSEC structure. Software must qualify the Vendor  |    //
//     |                                            ID before interpreting this field.                                  |    //
//     | 19:16 VSEC Rec                           : This field is a vendor-defined ID number that indicates             |    //
//     |                                            the nature and format of theVSEC structure.                         |    //
//     |                                            Software must qualify the Vendor ID before interpreting this field. |    //
//     |                                            This field is a PCI-SIG defined version number that indicates       |    //
//     | 31:20 VSEC Length                        : This field indicates the number of bytes in the entire VSEC         |    //
//     |                                            structure, including the PCI Express Extended Capability header,    |    //
//     |                                            the Vendor- Specific header, and the Vendor-Specific registers      |    //
//     |                                                                                                                |    //
//     |________________________________________________________________________________________________________________|    //
//     |                                                                                                                |    //
//     | Vendor-Specific Register - TLP Inspector Registers                                                             |    //
//     | _______________________________________________________________________________________________________________|    //
//     |                                                                                                   | Offset 08h |    //
//     | TRIGGER DWORD 1                                                                                   |____________|    //
//     |                                                                                                                |    //
//     | trigger [0]      | SOP         : When 1 trigger on first SOP                                                   |    //
//     |         [1]      | TX/RX       : When 1 trigger on RX AST, When 0 Trigger on TX AST                            |    //
//     |         [2]      | FMT_TLP     : When check trigger FMT_TLP                                                    |    //
//     |         [3]      | TAG         : When check trigger TAG                                                        |    //
//     |         [5:4]    | Address     : When check trigger Address Lower 24 bits                                      |    //
//     |                  |                    5:4 =2'b01, 8-bit addr LSB                                               |    //
//     |                  |                    5:4 =2'b10, 16-bit addr LSB                                              |    //
//     |                  |                    5:4 =2'b11, 32-bit addr LSB                                              |    //
//     |         [6]      | First BE    : When check trigger first BE                                                   |    //
//     |         [7]      | Last BE     : When check trigger last BE                                                    |    //
//     |         [8]      | Attr        : When check trigger Attr                                                       |    //
//     |         [9]      | Reset trigger only                                                                          |    //
//     |         [10]     | Reset reset Inspector                                                                       |    //
//     |         [11]     | Enable Trigger ON  : When set activate trigger logic                                        |    //
//     |         [12   ]  | Use CSEB trigger                                                                            |    //
//     |         [31:13]  | RESERVED                                                                                    |    //
//     | _______________________________________________________________________________________________________________|    //
//     |                                                                                                   | Offset 0Ch |    //
//     | TRIGGER DWORD 2                                                                                   |____________|    //
//     |                                                                                                                |    //
//     |         [ 7: 0]  |  [39:32]  | FMT TYPE: When trigger[2] set, trigger on                                       |    //
//     |                  |           |    _______________________________                                              |    //
//     |                  |           |    |                    |        |                                              |    //
//     |                  |           |    |  {FMT,TYPE}        |        |                                              |    //
//     |                  |           |    |____________________|________|                                              |    //
//     |                  |           |    | 8'b0000_0000       | MRd    |                                              |    //
//     |                  |           |    | 8'b0010_0000       | MRd    |                                              |    //
//     |                  |           |    | 8'b0000_0001       | MRdLk  |                                              |    //
//     |                  |           |    | 8'b0010_0001       | MRdLk  |                                              |    //
//     |                  |           |    | 8'b0100_0000       | MWr    |                                              |    //
//     |                  |           |    | 8'b0110_0000       | MWr    |                                              |    //
//     |                  |           |    | 8'b0000_0010       | IORd   |                                              |    //
//     |                  |           |    | 8'b0100_0010       | IOWr   |                                              |    //
//     |                  |           |    | 8'b0000_0100       | CfgRd0 |                                              |    //
//     |                  |           |    | 8'b0100_0100       | CfgWr0 |                                              |    //
//     |                  |           |    | 8'b0000_0101       | CfgRd1 |                                              |    //
//     |                  |           |    | 8'b0100_0101       | CfgWr1 |                                              |    //
//     |                  |           |    | 8'b0011_0XXX       | Msg    |                                              |    //
//     |                  |           |    | 8'b0111_0XXX       | MsgD   |                                              |    //
//     |                  |           |    | 8'b0000_1010       | Cpl    |                                              |    //
//     |                  |           |    | 8'b0100_1010       | CplD   |                                              |    //
//     |                  |           |    | 8'b0000_1011       | CplLk  |                                              |    //
//     |                  |           |    | 8'b0100_1011       | CplDLk |                                              |    //
//     |                  |           |    |_____________________________|                                              |    //
//     |                  |           |                                                                                 |    //
//     |                  |           |                                                                                 |    //
//     |         [15: 8]  |  [47:40]  | TAG : When trigger[3] set, trigger on TAG value                                 |    //
//     |         [19:16]  |  [51:48]  | First BE : When trigger[6] set, trigger on Last BE                              |    //
//     |         [23:20]  |  [55:52]  | Last BE : When trigger[7] set, trigger on Last BE                               |    //
//     |         [31:24]  |  [63:55]  | RESERVED                                                                        |    //
//     | _______________________________________________________________________________________________________________|    //
//     |                                                                                                   | Offset 10h |    //
//     | TRIGGER DWORD 3                                                                                   |____________|    //
//     |                                                                                                                |    //
//     |         [31:0]  |   [95:64]  | when trigger[5:4]>0 32 bit lower address trigger                                |    //
//     | _______________________________________________________________________________________________________________|    //
//     |                                                                                                   | Offset 14h |    //
//     | TRIGGER DWORD 4                                                                                   |____________|    //
//     |                                                                                                                |    //
//     |         [0]     | [96]     | When unset no stop trigger                                                        |    //
//     |         [1]     | [97]     | TX/RX       : When 1 stop-trigger on RX AST, When 0 Trigger on TX AST             |    //
//     |         [2]     | [98]     | FMT_TLP     : When check stop-trigger FMT_TLP                                     |    //
//     |         [3]     | [99]     | TAG         : When check stop-trigger TAG                                         |    //
//     |         [5:4]   | [101:100]| Address     : When check stop-trigger Address Lower 24 bits                       |    //
//     |                 |          |                    [101:100] =2'b01, 8-bit addr LSB                               |    //
//     |                 |          |                    [101:100] =2'b10, 16-bit addr LSB                              |    //
//     |                 |          |                    [101:100] =2'b11, 32-bit addr LSB                              |    //
//     |         [13:6]  | [109:102]| FMT TYPE: When stop-trigger[98] set,                                              |    //
//     |         [21:14] | [117:110]| TAG : When stop-trigger[99]                                                       |    //
//     | _______________________________________________________________________________________________________________|    //
//     |                                                                                                   | Offset 18h |    //
//     |                                                                                                   |____________|    //
//     | INSP_ADDRREADY_SOP_RX          {ast_cnt_rx_ready, ast_cnt_rx_sop}                                              |    //
//     | 31                                           16|                                 0                             |    //
//     | Number of times rx_ready de-assert on rx_valid | Number of of RX SOP                                           |    //
//     | _______________________________________________________________________________________________________________|    //
//     |                                                                                                   | Offset 1Ch |    //
//     | INSP_ADDRREADY_SOP_TX          {ast_cnt_tx_ready, ast_cnt_tx_sop}                                 |___________ |    //
//     | 31                                           16|                                 0                             |    //
//     | Number of times tx_ready de-assert on tx_valid | Number of of TX SOP                                           |    //
//     | _______________________________________________________________________________________________________________|    //
//     |                                                                                                   | Offset 20h |    //
//     | INSP_ADDRLATENCY_MRD_UPSTREAM  {PLD_CLK_IS_250MHZ,ast_max_read_latency, ast_min_read_latency}     |____________|    //
//     | 31                     30 |                  15|                                 0                             |    //
//     | When 1 pld clk is 250 MHz | Max read upstream  |  Min read upstream latency                                    |    //
//     | _______________________________________________________________________________________________________________|    //
//     |                                                                                                   | Offset 24h |    //
//     | INSP_ADDRMWR_THROUGHPUT_CLK    {PLD_CLK_IS_250MHZ,10'h0,ast_cnt_mwr_clk}                          |____________|    //
//     | 31                     30 |                  20|                                 0                             |    //
//     | When 1 pld clk is 250 MHz | RESERVED           |  Number of clock cycles for MWr upstream transfer             |    //
//     | _______________________________________________________________________________________________________________|    //
//     |                                                                                                   | Offset 28h |    //
//     | INSP_ADDRMWR_THROUGHPUT_DWORD  {12'h0                                   ,ast_cnt_mwr_dword}       |____________|    //
//     | 31                                           20|                                 0                             |    //
//     |                             RESERVED           |  Number of DWORD  MWr upstream transfer                       |    //
//     | _______________________________________________________________________________________________________________|    //
//     |                                                                                                   | Offset 2Ch |    //
//     | INSP_ADDRMRD_THROUGHPUT_CLK    {(PLD_CLK_IS_250MHZ==1)?2'b01:2'b00,10'h0,ast_cnt_mrd_clk}         |____________|    //
//     | 31                     30 |                  20|                                 0                             |    //
//     | When 1 pld clk is 250 MHz | RESERVED           |  Number of clock cycles for MRd upstream transfer             |    //
//     | _______________________________________________________________________________________________________________|    //
//     |                                                                                                   | Offset 30h |    //
//     | INSP_ADDRMRD_THROUGHPUT_DWORD  {12'h0                                   ,ast_cnt_mrd_dword}       |____________|    //
//     | 31                                           20|                                 0                             |    //
//     |                             RESERVED           |  Number of DWORD  MRd upstream transfer                       |    //
//     | _______________________________________________________________________________________________________________|    //
//     |                                                                                                   | Offset 34h |    //
//     | LTSSM  BLACK BOX Recording Retrieval                                                              |____________|    //
//     |                                                                                                                |    //
//     | [4:0] : LTSSM Transition                                                                                       |    //
//     | [5]   : perstn|npor                                                                                            |    //
//     | [13:6]: Is lock to data                                                                                        |    //
//     | [14]  : signaldetect                                                                                           |    //
//     | [16:15]: rate 1->G1, 2 -->G2, 3:G3                                                                             |    //
//     | [18:17]: Lanes : 0 ->x1, 0 ->x2, 0 ->x4,  0 ->x8,                                                              |    //
//     | [19   ]: RESERVED                                                                                              |    //
//     | [27:20]: Number of word in the black box                                                                       |    //
//     | [31:28]: RESERVED                                                                                              |    //
//     | _______________________________________________________________________________________________________________|    //
//     |                                                                                                   | Offset 38h |    //
//     | TLP BLACK BOX Recording Retrieval                                                                 |____________|    //
//     |                                                                                                                |    //
//     | Pop FIFO                                                                                                       |    //
//     | [0] RX Tlp when 1 else TX TLP                                                                                  |    //
//     | [8:1] TLP CNT                                                                                                  |    //
//     | [21:10] RESERVED                                                                                               |    //
//     | [26:22] fifo_used                                                                                              |    //
//     | [27]    fifo_empty                                                                                             |    //
//     | [28]    fifo_full                                                                                              |    //
//     | [31:29] RESERVED                                                                                               |    //
//     |                                                                                                                |    //
//     | _______________________________________________________________________________________________________________|    //
//     |                                                                                                   | Offset 3Ch |    //
//     | Retrieve H1 TLP                                                                                   |____________|    //
//     | [31:0] Header 1 TLP                                                                                            |    //
//     | _______________________________________________________________________________________________________________|    //
//     |                                                                                                   | Offset 40h |    //
//     | Retrieve H2 TLP                                                                                   |____________|    //
//     | [31:0] Header 2 TLP                                                                                            |    //
//     | _______________________________________________________________________________________________________________|    //
//     |                                                                                                   | Offset 44h |    //
//     | Retrieve H3 TLP                                                                                   |____________|    //
//     | [31:0] Header 3 TLP                                                                                            |    //
//     | _______________________________________________________________________________________________________________|    //
//     |                                                                                                   | Offset 48h |    //
//     | AVMM thin Master  TODO                                                                            |____________|    //
//     | [15:0]  data                                                                                                   |    //
//     | [23:16] Address                                                                                                |    //
//     | [24]    ReadReq                                                                                                |    //
//     | [25]    WriteReq                                                                                               |    //
//     | [31:26] Reserved WriteReq                                                                                               |    //
//     | _______________________________________________________________________________________________________________|    //
//     |                                                                                                                |    //
//     | RESERVED                       RESERVED                                                                        |    //
//     |                                                                                                                |    //
//     | _______________________________________________________________________________________________________________|    //
//                                                                                                                           //
//                                                                                                                           //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

module altpcie_tlp_inspector_cseb_a10 # (
      parameter CSEB_ENA              = 1,
      parameter RD2CPL_DLY            = 4,
      parameter CSEB_CAPABILITY_INFO  = 1,
      parameter VSEC_BYTE_LENGTH      = 12'h40,
      parameter VSEC_REV              = 4'h1,
      parameter VSEC_ID               = 16'hFACE
) (
      // Interface to HIP CSEB bus which is an extension of configuration space
      output  reg [31 : 0]       csebrddata,
      output  reg [4 : 0]        csebrdresponse,
                                 //  CSEB Response Codes
                                 //  3'h0;   - Successful completion
                                 //  3'h1;   - Access to undefined location:
                                 //            User should only use this if the CFG
                                 //            request addresses an unimplemented function
                                 //            (cfg bypass).
                                 //  3'h2;   - Fatal and permanent problem
                                 //  3'h3;   - Slave response timeout
                                 //  3'h4;   - Temporary problem - retry:
                                 //            Will map to CRS if k_temp_busy_crs is 1
                                 //            (useful for Cfg Bypass -- user needs to
                                 //             follow PCIe rules on using CRS).
                                 //            Else it will map to CA.
                                 //  3'h5;   - Parity Error
      output                     csebwaitrequest,
      output  reg [4 : 0]        csebwrresponse,
      output  reg                csebwrrespvalid,

      input [31 : 0]             csebaddr,
      input [3 : 0]              csebbe,
      input                      csebisshadow,
      input                      csebrden,
      input [31 : 0]             csebwrdata,
      input                      csebwren,
      input                      csebwrrespreq,

      input  [31:0]              monitor_data  ,
      output [7:0]               monitor_addr ,
      output                     monitor_rd_pulse ,

      output reg                 use_cseb_trigger ,
      output reg [31:0]          cseb_trigger     ,
      output reg [1:0]           cseb_trigger_dw  ,

      output reg                 pcsig_wr_pulse_op , // In  Wr Pulse
      output reg                 pcsig_wr_pulse_dt , // In  Wr Pulse
      output reg [31:0]          pcsig_wrdata      , // in  [31:0]
      output reg [31:0]          pcsig_opcode      , // in  [31:0]
      output reg                 pcsig_rd_pulse_dt , // In  Rd Pulse
      output reg                 pcsig_rd_pulse_st , // In  Rd Pulse
      input      [31:0]          pcsig_rddata      , // out [31:0]

      output reg                 avmm_thinmaster_write,
      output reg [7:0]           avmm_thinmaster_address,
      output reg [15:0]          avmm_thinmaster_writedata,
      output reg [1:0]           avmm_thinmaster_byteenable,
      output reg                 avmm_thinmaster_read,
      input                      avmm_thinmaster_waitrequest,
      input  [15:0]              avmm_thinmaster_readdata,
      input                      avmm_thinmaster_readdatavalid,

      input                      clk,
      input                      sclr

      );

localparam ZEROS = 512'h0;
//     | 31                     20 |                  16|                                 0
//     | Next Capability Offset    | Capability Version |PCI Express Extended Capability ID
localparam NEXT_CAPABILITY_OFFSET           = 12'h0,
           CAPABILITY_VERSION               = 4'h1 ,
           VSEC_PCIE_EXTENDED_CAPABILITY_ID = 16'hB;
localparam MAX_VSEC_ADDR = 16'h904+{4'h0, VSEC_BYTE_LENGTH};

reg        csebwren_p1   ;
reg        csebrden_p1   ;
reg        csebaddr_0h   ;
reg        csebaddr_4h   ;
reg        csebaddr_8h   ;
reg        csebaddr_Ch   ;
reg        csebaddr_10h  ;
reg        csebaddr_14h  ;
reg        csebaddr_48h  ;
reg        csebaddr_gt_917h  ;
reg        csebaddr_gt_maxvsec_len  ;
reg [31:0] csebwrdata_p1 ;
reg [15:0] requester_id ;
reg        csebwaitrequest_r;
reg [RD2CPL_DLY-3:0]  cfgrd2cpl_dly   ;
reg        csebresp_ready;

reg [31:0] cseb_thinmaster ;
reg [31:0] avmm_thinmaster_pipe ;

assign csebwaitrequest  = csebisshadow ? (csebwaitrequest_r|(csebrden&(~csebrden_p1))) : ~csebresp_ready;
assign monitor_addr     = csebaddr[7:0];
assign monitor_rd_pulse = ((csebrden==1'b1)&&(csebrden_p1==1'b0))?1'b1:1'b0;

always @(posedge clk) begin : p_cseb
   if ((sclr == 1'b1 )||(CSEB_ENA==0)) begin
      csebrddata        <= 32'h0;
      csebrdresponse    <= 5'h0;
      csebwaitrequest_r <= 1'h0;
      csebwrresponse    <= 5'h0;
      csebwrrespvalid   <= 1'h0;
      use_cseb_trigger  <= 1'b0;
      cseb_trigger      <= 32'h0;
      cseb_trigger_dw   <= 2'h0;
      cfgrd2cpl_dly     <= ZEROS[RD2CPL_DLY-3:0];
      csebwren_p1       <= 1'b0;
      csebwrdata_p1     <= 32'h0;
      csebaddr_0h       <= 1'b0;
      csebaddr_4h       <= 1'b0;
      csebaddr_8h       <= 1'b0;
      csebaddr_Ch       <= 1'b0;
      csebaddr_10h      <= 1'b0;
      csebaddr_14h      <= 1'b0;
      csebaddr_48h      <= 1'b0;
      csebrden_p1       <= 1'b0;
      csebaddr_gt_917h  <= 1'b0;
      csebaddr_gt_maxvsec_len  <= 1'b0;
      requester_id      <= 16'h0;
      pcsig_wr_pulse_op <= ZEROS[0]   ;
      pcsig_wr_pulse_dt <= ZEROS[0]   ;
      pcsig_wrdata      <= ZEROS[31:0];
      pcsig_opcode      <= ZEROS[31:0];
      pcsig_rd_pulse_dt <= ZEROS[0]   ;
      pcsig_rd_pulse_st <= ZEROS[0]   ;
      csebresp_ready    <= 1'b1;
   end
   else begin
      requester_id            <= csebaddr[31:16];
      csebwren_p1             <= (~csebisshadow) & csebwren;
      csebrden_p1             <= (~csebisshadow) & csebrden;
      csebaddr_0h             <= (csebaddr[15:0]==16'h900)?1'b1:1'b0;
      csebaddr_4h             <= (csebaddr[15:0]==16'h904)?1'b1:1'b0;
      csebaddr_8h             <= (csebaddr[15:0]==16'h908)?1'b1:1'b0;
      csebaddr_Ch             <= (csebaddr[15:0]==16'h90C)?1'b1:1'b0;
      csebaddr_10h            <= (csebaddr[15:0]==16'h910)?1'b1:1'b0;
      csebaddr_14h            <= (csebaddr[15:0]==16'h914)?1'b1:1'b0;
      csebaddr_48h            <= (csebaddr[15:0]==16'h948)?1'b1:1'b0;
      csebaddr_gt_917h        <= (csebaddr[15:0] >16'h917)?1'b1:1'b0;
      csebaddr_gt_maxvsec_len <= (csebaddr[15:0] > MAX_VSEC_ADDR)?1'b1:1'b0;
      csebwrdata_p1           <= csebwrdata;
      csebresp_ready          <= 1'b0;
      if (csebwren_p1==1'b1) begin
         cseb_trigger    <= (csebaddr_8h|csebaddr_Ch|csebaddr_10h|csebaddr_14h)?csebwrdata_p1:cseb_trigger;
         cseb_trigger_dw <= (csebaddr_8h ==1'b1)?2'h0:
                            (csebaddr_Ch ==1'b1)?2'h1:
                            (csebaddr_10h==1'b1)?2'h2:
                            (csebaddr_14h==1'b1)?2'h3:cseb_trigger_dw;
         csebwrrespvalid  <= 1'b1;
         csebresp_ready   <= 1'b1;
      end
      else begin
         csebwrrespvalid  <= 1'b0;
      end
      cfgrd2cpl_dly     <= {cfgrd2cpl_dly[RD2CPL_DLY-4:0], ((csebrden==1'b1) && (csebrden_p1==1'b0))?1'b1:1'b0};
      csebwaitrequest_r <= ((csebrden==1'b1)&&(csebrden_p1==1'b0))?1'b1:(cfgrd2cpl_dly>ZEROS[RD2CPL_DLY-3:0])?1'b1:1'b0;
      if (csebrden_p1==1'b1) begin
         if (csebaddr_0h==1'b1) begin
            csebrddata      <= {NEXT_CAPABILITY_OFFSET, CAPABILITY_VERSION, VSEC_PCIE_EXTENDED_CAPABILITY_ID};
            csebrdresponse  <= 5'h0;
            csebresp_ready  <= (cfgrd2cpl_dly>ZEROS[RD2CPL_DLY-3:0])?1'b0:1'b1;
         end
         else if (csebaddr_4h==1'b1) begin
            csebrddata      <= {VSEC_BYTE_LENGTH, VSEC_REV, VSEC_ID};
            csebrdresponse  <= 5'h0;
            csebresp_ready  <= (cfgrd2cpl_dly>ZEROS[RD2CPL_DLY-3:0])?1'b0:1'b1;
         end
         else if (csebaddr_48h==1'b1) begin
            csebrddata      <= cseb_thinmaster;
            csebrdresponse  <= 5'h0;
            csebresp_ready  <= (cfgrd2cpl_dly>ZEROS[RD2CPL_DLY-3:0])?1'b0:1'b1;
         end
         else if ((csebaddr_gt_917h==1'b1)&&(csebaddr_gt_maxvsec_len==1'b0)) begin
            csebrddata      <= monitor_data;
            csebrdresponse  <= 5'h0;
            csebresp_ready  <= (cfgrd2cpl_dly>ZEROS[RD2CPL_DLY-3:0])?1'b0:1'b1;
         end
         else begin
            csebrdresponse  <= 5'h1; // Undefined location UR
            csebresp_ready  <= (cfgrd2cpl_dly>ZEROS[RD2CPL_DLY-3:0])?1'b0:1'b1;
         end
      end
   end
end // p_cseb

reg [2:0]   avmm_master_state;

localparam [2:0] S_IDLE            = 3'h0;
localparam [2:0] S_CSEB_WRITE      = 3'h1;
localparam [2:0] S_AVMM_WRITE_REQ  = 3'h2;
localparam [2:0] S_AVMM_READ_REQ   = 3'h3;
localparam [2:0] S_AVMM_CPL        = 3'h4;

////////////////////////////////////////////////////////////////
//
// Create thin AVMM RX Mster from etyh CSEB register 'h948
//
always @(posedge clk) begin : p_thinmaster
   if ((sclr == 1'b1 )||(CSEB_ENA==0)) begin
      cseb_thinmaster             <= 32'h0;
      avmm_thinmaster_write       <= 1'b0;
      avmm_thinmaster_address     <= 8'h0;
      avmm_thinmaster_writedata   <= 16'h0;
      avmm_thinmaster_byteenable  <= 2'b11;
      avmm_thinmaster_read        <= 1'h0;
      avmm_master_state           <= 3'h0;
   end
   else begin
      avmm_thinmaster_byteenable  <= 2'b11;
      case (avmm_master_state)
         S_IDLE : begin
            if ((csebwren_p1==1'b1)&& (csebaddr_48h == 1'b1 )) begin
               cseb_thinmaster            <= csebwrdata_p1;
               avmm_thinmaster_write      <= 1'b0;
               avmm_thinmaster_read       <= 1'b0;
               avmm_master_state          <= S_CSEB_WRITE;
            end
            else begin
               avmm_master_state          <= S_IDLE;
            end
         end

         S_CSEB_WRITE : begin
            avmm_thinmaster_address    <= cseb_thinmaster[23:16];
            avmm_thinmaster_writedata  <= cseb_thinmaster[15:0 ];
            if (cseb_thinmaster[24] == 1'b1 ) begin
               avmm_thinmaster_write      <= 1'b0;
               avmm_thinmaster_read       <= 1'b1;
               avmm_master_state          <= S_AVMM_READ_REQ;
            end
            else if (cseb_thinmaster[25] == 1'b1 ) begin
               avmm_thinmaster_write      <= 1'b1;
               avmm_thinmaster_read       <= 1'b0;
               avmm_master_state          <= S_AVMM_WRITE_REQ;
            end

         end

         S_AVMM_WRITE_REQ : begin
            if (avmm_thinmaster_waitrequest==1'b0) begin
               avmm_thinmaster_write      <= 1'b0;
               cseb_thinmaster[25]        <= 1'b0;
               avmm_thinmaster_read       <= 1'b0;
               avmm_master_state          <= S_IDLE;
            end
            else begin
               avmm_master_state          <= S_AVMM_WRITE_REQ;
            end
         end

         S_AVMM_READ_REQ : begin
            if (avmm_thinmaster_waitrequest==1'b0) begin
               avmm_thinmaster_write      <= 1'b0;
               avmm_thinmaster_read       <= 1'b0;
               avmm_master_state          <= S_AVMM_CPL;
            end
            else begin
               avmm_master_state          <= S_AVMM_READ_REQ;
            end
         end

         S_AVMM_CPL : begin
            if (avmm_thinmaster_readdatavalid==1'b1) begin
               cseb_thinmaster[24]        <= 1'b0;
               cseb_thinmaster[15:0]      <= avmm_thinmaster_readdata[15:0];
               avmm_thinmaster_write      <= 1'b0;
               avmm_thinmaster_read       <= 1'b0;
               avmm_master_state          <= S_IDLE;
            end
            else begin
               avmm_master_state          <= S_AVMM_CPL;
            end
         end
         default : begin
            avmm_master_state          <= S_IDLE;
         end

      endcase
   end
end // p_thinmaster

endmodule

// ////////////////////////////////////////////ALTERA BFM TASK to cut and paste in altpcietb_bfm_driver_chaining
// //
// //
//    function [64*8:1] DisplayTLP ;
//       input  [31:0] h1 ;
//       input  [31:0] h2 ;
//       input  [31:0] h3 ;
//       input         rx ;
//       //input  [31:0] h4 ;
//       reg    [7*8:1] tlp_type;
//       reg    [8*5:1] tag;
//       begin
//          casex (h1[31:24])
//             8'b0000_0000 : begin
//                               tlp_type = "MRd"   ;
//                               tag      = {" (",dimage2(h2[15:8]),")"};
//                            end
//             8'b0010_0000 : begin
//                               tlp_type = "MRd"   ;
//                               tag      = {" (",dimage2(h2[15:8]),")"};
//                            end
//             8'b0000_0001 : begin
//                               tlp_type = "MRdLk" ;
//                               tag      = {" (",dimage2(h2[15:8]),")"};
//                            end
//             8'b0010_0001 : begin
//                               tlp_type = "MRdLk" ;
//                               tag      = {" (",dimage2(h2[15:8]),")"};
//                            end
//             8'b0100_0000 : begin
//                               tlp_type = "MWr"   ;
//                               tag      = "     ";
//                            end
//             8'b0110_0000 : begin
//                               tlp_type = "MWr"   ;
//                               tag      = "     ";
//                            end
//             8'b0000_0010 : begin
//                               tlp_type = "IORd"  ;
//                               tag      = {" (",dimage2(h2[15:8]),")"};
//                            end
//             8'b0100_0010 : begin
//                               tlp_type = "IOWr"  ;
//                               tag      = {" (",dimage2(h2[15:8]),")"};
//                            end
//             8'b0000_0100 : begin
//                               tlp_type = "CfgRd0";
//                               tag      = {" (",dimage2(h2[15:8]),")"};
//                            end
//             8'b0100_0100 : begin
//                               tlp_type = "CfgWr0";
//                               tag      = {" (",dimage2(h2[15:8]),")"};
//                            end
//             8'b0000_0101 : begin
//                               tlp_type = "CfgRd1";
//                               tag      = {" (",dimage2(h2[15:8]),")"};
//                            end
//             8'b0100_0101 : begin
//                               tlp_type = "CfgWr1";
//                               tag      = {" (",dimage2(h2[15:8]),")"};
//                            end
//             8'b0011_0XXX : begin
//                               tlp_type = "Msg"   ; //TODO Complete all Msg Cases
//                               tag      = "     ";
//                            end
//             8'b0111_0XXX : begin
//                               tlp_type = "MsgD"  ;
//                               tag      = "     "   ;
//                            end
//             8'b0000_1010 : begin
//                               tlp_type = "Cpl"   ;
//                               tag      = {" (",dimage2(h3[15:8]),")"};
//                            end
//             8'b0100_1010 : begin
//                               tlp_type = "CplD"  ;
//                               tag      = {" (",dimage2(h3[15:8]),")"};
//                            end
//             8'b0000_1011 : begin
//                               tlp_type = "CplLk" ;
//                               tag      = {" (",dimage2(h3[15:8]),")"};
//                            end
//             8'b0100_1011 : begin
//                               tlp_type = "CplDLk";
//                               tag      = {" (",dimage2(h3[15:8]),")"};
//                            end
//             default      : begin
//                               tlp_type = "TDB"  ;
//                               tag      = "     ";
//                            end
//          endcase
//          DisplayTLP={ tlp_type, tag, " | ", dimage4({h1[9:0],2'b00}) , "    | ", himage8(h1), "_", himage8(h2),  "_", himage8(h3)};
//       end
//    endfunction
// task inspector_config_space ;
//
//    reg  [31:0] dword;
//    reg  [2:0]  compl_status;
//    reg  unused_result ;
//    reg  [15:0] addr;
//    reg  pld_clk_is_250MHz;
//    reg  [19:0] nclk;
//    reg  [19:0] ndword;
//    reg  [31:0] nbytes;
//    reg  [31:0] ellapse_timens;
//    reg  [31:0] throughputMBps;
//    reg  [7:0]  ltssmfifo_used;
//    reg  empty;
//    reg  full;
//    reg  ast_rx;
//    reg  [31:0] tlp_h1;
//    reg  [31:0] tlp_h2;
//    reg  [31:0] tlp_h3;
//
//    begin
//          addr = 16'h900;
//
//          ebfm_cfgrd_wait(  1, 1, 0, addr, 4, SCR_MEMSLAVE, compl_status);
//          dword = shmem_read(SCR_MEMSLAVE,4) ;
//          $display("___________________________________________________________________________________________________________________________________");
//          $display("|                                                                                                                 |                ");
//          $display("| PCI Express Extended Capability Header                                                             Offset 8'h0  |    0x%s        ", himage4(addr));
//          $display("| ________________________________________________________________________________________________________________|________________");
//          $display("|                                                                                                                 |                ");
//          $display("| 31                     20 |                  16|                                 0                              |                ");
//          $display("| Next Capability Offset    | Capability Version |PCI Express Extended Capability ID                              |                ");
//          $display("|                                                                                                                 |                ");
//          $display("| 15:0  PCI Express Extended Capability ID : This field is a PCI-SIG defined ID number that indicates the nature  |    0x%s        ", himage4(dword[15:0]));
//          $display("|                                            and format of the Extended Capability.                               |                ");
//          $display("|                                            Extended Capability ID for the Vendor-Specific Capability is 000Bh.  |                ");
//          $display("|                                            RO                                                                   |                ");
//          $display("| 19:16 Capability Version                 : This field is a PCI-SIG defined version number that indicates        |    0x%s        ", himage4(dword[19:16]));
//          $display("|                                            the version of the Capability structure present.                     |                ");
//          $display("|                                            Must be 1h for this version of the specification                     |                ");
//          $display("| 31:20 Next Capability Offset             : This field contains the offset to the next PCI Express               |    0x%s        ", himage4(dword[31:20]));
//          $display("|                                            Capability structure or 000h if no other items exist in              |                ");
//          $display("|                                            the linked list of Capabilities.                                     |                ");
//          $display("|                                            For Extended Capabilities implemented in Configuration Space,        |                ");
//          $display("|                                            this offset is relative to the beginning of PCI-compatible           |                ");
//          $display("|                                            Configuration Space and thus must always be either 000h              |                ");
//          $display("|                                            (for terminating list of Capabilities) or greater than 0FFh.         |                ");
//
//          addr = 16'h904;
//          ebfm_cfgrd_wait(  1, 1, 0, addr, 4, SCR_MEMSLAVE, compl_status);
//          dword = shmem_read(SCR_MEMSLAVE,4) ;
//          $display("|_________________________________________________________________________________________________________________|_________________");
//          $display("|                                                                                                                 |                 ");
//          $display("| Vendor-Specific Header                                                                              Offset 04h  |    0x%s          ", himage4(addr));
//          $display("| ________________________________________________________________________________________________________________|_________________");
//          $display("|                                                                                                                 |                 ");
//          $display("| 31                     20 |                  16|                                 0                              |                 ");
//          $display("| VSEC Length               | VSEC Rev           |                 VSEC ID                                        |                 ");
//          $display("|                                                                                                                 |                 ");
//          $display("| 15:0  VSEC ID                            : This field is a vendor-defined ID number that indicates the nature   |    0x%s         ", himage4(dword[15:0]));
//          $display("|                                            and format of the VSEC structure. Software must qualify the Vendor   |                 ");
//          $display("|                                            ID before interpreting this field.                                   |                 ");
//          $display("| 19:16 VSEC Rec                           : This field is a vendor-defined ID number that indicates              |    0x%s         ", himage4(dword[19:16]));
//          $display("|                                            the nature and format of theVSEC structure.                          |                 ");
//          $display("|                                            Software must qualify the Vendor ID before interpreting this field.  |                 ");
//          $display("|                                            This field is a PCI-SIG defined version number that indicates        |                 ");
//          $display("| 31:20 VSEC Length                        : This field indicates the number of bytes in the entire VSEC          |     %s          ", dimage4(dword[31:20]));
//          $display("|                                            structure, including the PCI Express Extended Capability header,     |                 ");
//          $display("|                                            the Vendor- Specific header, and the Vendor-Specific registers       |                 ");
//          $display("|                                                                                                                 |                 ");
//
//          addr = 16'h918;
//          ebfm_cfgrd_wait(  1, 1, 0, addr, 4, SCR_MEMSLAVE, compl_status);
//          dword = shmem_read(SCR_MEMSLAVE,4) ;
//          $display("| ________________________________________________________________________________________________________________|_________________");
//          $display("|                                                                                                   | Offset 18h  |    0x%s          ", himage4(addr));
//          $display("|                                                                                                   |_____________|_________________");
//          $display("|                                                                                                                 |                 ");
//          $display("| [15:0]  Number of of RX SOP                                                                                     |     %s          ", dimage4(dword[15:0]));
//          $display("| [31:16] Number of times that HIP Avalon-St rx_ready de-assert when rx_valid is set                              |     %s          ", dimage4(dword[31:16]));
//
//          addr = 16'h91C;
//          ebfm_cfgrd_wait(  1, 1, 0, addr, 4, SCR_MEMSLAVE, compl_status);
//          dword = shmem_read(SCR_MEMSLAVE,4) ;
//          $display("| ________________________________________________________________________________________________________________|_________________");
//          $display("|                                                                                                   | Offset 1Ch  |    0x%s          ", himage4(addr));
//          $display("|                                                                                                   |_____________|_________________");
//          $display("| [15:0]  Number of of TX SOP                                                                                     |     %s          ", dimage4(dword[15:0]));
//          $display("| [31:16] Number of times that HIP Avalon St tx_ready de-assert when tx_valid is set                              |     %s          ", dimage4(dword[31:16]));
//
//          addr = 16'h920;
//          ebfm_cfgrd_wait(  1, 1, 0, addr, 4, SCR_MEMSLAVE, compl_status);
//          dword = shmem_read(SCR_MEMSLAVE,4) ;
//          $display("| ________________________________________________________________________________________________________________|_________________");
//          $display("|                                                                                                   | Offset 20h  |    0x%s          ", himage4(addr));
//          $display("|  Upstream read to completion latency                                                              |_____________|_________________");
//          $display("| pld clk is :                                                                                                    |     %d MHz      ", (dword[31:30]>2'b00)?250:125);
//          $display("| [14:0]   Min Mrd to Cpl  upstream latency : number of clock cycles                                              |     %s          ", dimage4(dword[14:0]));
//          $display("| [29:15]  Max Mrd to Cpl  upstream latency : number of clock cycles                                              |     %s          ", dimage4(dword[29:15]));
//
//          pld_clk_is_250MHz = (dword[31:30]>2'b00)?1:0;
//
//          addr = 16'h924;
//          ebfm_cfgrd_wait(  1, 1, 0, addr, 4, SCR_MEMSLAVE, compl_status);
//          dword = shmem_read(SCR_MEMSLAVE,4) ;
//          $display("| ________________________________________________________________________________________________________________|_________________");
//          $display("|                                                                                                   | Offset 24h  |    0x%s          ", himage4(addr));
//          $display("|                                                                                                   |_____________|_________________");
//          $display("| [19:0] Number of clock cycles for MWr upstream transfer                                                         |     %s          ", dimage4(dword[19:0]));
//          nclk = dword[19:0];
//
//          addr = 16'h928;
//          ebfm_cfgrd_wait(  1, 1, 0, addr, 4, SCR_MEMSLAVE, compl_status);
//          dword = shmem_read(SCR_MEMSLAVE,4) ;
//          $display("| ________________________________________________________________________________________________________________|_________________");
//          $display("|                                                                                                   | Offset 28h  |    0x%s          ", himage4(addr));
//          $display("|                                                                                                   |_____________|_________________");
//          $display("| [19:0]  Number of DWORD  MWr upstream transfer                                                                  |      %s          ", dimage4(dword[19:0]));
//          $display("|                                                                                                                 |                  ");
//          ndword = dword[19:0];
//
//          ellapse_timens = (pld_clk_is_250MHz==1'b1)?nclk*4:nclk*8;
//          nbytes         = ndword*4;
//          throughputMBps = (nclk>0)? (nbytes*1000)  / ellapse_timens :0;
//          $display("|                                                                                                                 |                  ");
//          $display("| Write throughput                                                                                                |      %s MBps     ", dimage4(throughputMBps));
//          $display("|                                                                                                                 |                  ");
//
//          addr = 16'h92C;
//          ebfm_cfgrd_wait(  1, 1, 0, addr, 4, SCR_MEMSLAVE, compl_status);
//          dword = shmem_read(SCR_MEMSLAVE,4) ;
//          $display("| ________________________________________________________________________________________________________________|_________________");
//          $display("|                                                                                                   | Offset 2Ch  |    0x%s          ", himage4(addr));
//          $display("|                                                                                                   |_____________|_________________");
//          $display("| [19:0]  Number of  clock cycles for MRd upstream transfer                                                       |      %s          ", dimage4(dword[19:0]));
//          $display("|                                                                                                                 |                  ");
//          nclk = dword[19:0];
//
//          addr = 16'h930;
//          ebfm_cfgrd_wait(  1, 1, 0, addr, 4, SCR_MEMSLAVE, compl_status);
//          dword = shmem_read(SCR_MEMSLAVE,4) ;
//          $display("| ________________________________________________________________________________________________________________|_________________");
//          $display("|                                                                                                   | Offset 30h  |    0x%s          ", himage4(addr));
//          $display("|                                                                                                   |_____________|_________________");
//          $display("| [19:0]  Number of DWORD  MRd upstream transfer                                                                  |     %s          ", dimage4(dword[19:0]));
//          $display("|                                                                                                                 |                  ");
//          ndword = dword[19:0];
//
//          ellapse_timens = (pld_clk_is_250MHz==1'b1)?nclk*4:nclk*8;
//          nbytes         = ndword*4;
//          throughputMBps = (nclk>0)? (nbytes*1000)  / ellapse_timens :0;
//          $display("|                                                                                                                 |                  ");
//          $display("| Read throughput                                                                                                 |      %s MBps     ", dimage4(throughputMBps));
//          $display("|                                                                                                                 |                  ");
//
//          addr = 16'h934;
//          ebfm_cfgrd_wait(  1, 1, 0, addr, 4, SCR_MEMSLAVE, compl_status);
//          dword = shmem_read(SCR_MEMSLAVE,4) ;
//          nclk  = (dword[18:17]==2'b00)?32'h1:
//                  (dword[18:17]==2'b01)?32'h2:
//                  (dword[18:17]==2'b10)?32'h4:32'h8;
//          $display("| ________________________________________________________________________________________________________________|_________________");
//          $display("|                                                                                                   | Offset 34h  |   0x%s          ", himage4(addr));
//          $display("| LTSSM  BLACK BOX Recording Retrieval                                                              |_____________|_________________");
//          $display("|                                                                                                                 |                 ");
//          $display("| [4:0] : LTSSM Transition                                                                                        |   0x%s         ", himage4(dword[4:0]));
//          $display("| [5]   : perstn|npor                                                                                             |     %s         ", dimage4(dword[5]));
//          $display("| [13:6]: Is lock to data                                                                                         |   0x%s         ", himage4(dword[13:6]));
//          $display("| [14]  : signaldetect                                                                                            |     %s         ", (dword[16:15]==2'b11)?"8.0Gb":(dword[16:15]==2'b10)?"5.0Gb":"2.5Gb");
//          $display("| [16:15]: rate 1->G1, 2 -->G2, 3:G3                                                                              |     %s         ", dimage4(dword[16:15]));
//          $display("| [18:17]: Number of lanes                                                                                        |     %s         ", dimage4(nclk[7:0]));
//          $display("| [19   ]: RESERVED                                                                                               |                ");
//          $display("| [27:20]: Number of word in the black box                                                                        |     %s         ", dimage4(dword[27:20]));
//          $display("| [31:28]: RESERVED                                                                                               |                ");
//          $display("|                                                                                                                 |                ");
//          nbytes=0;
//          nbytes[7:0]=dword[27:20];
//          if (nbytes>0) begin
//             $display("| --------------------------------------------------------------------------------------------------------------- |                ");
//             $display("|                                                                                                                 |                ");
//             $display("| LTSSM[4:0] |  Perstn  | Locktodata[7:0]  | Signaldetect   |  rate    | lane                                     |");
//             $display("|            |          |                  |                |          |                                          |");
//             while (nbytes > 0) begin
//                addr = 16'h934;
//                ebfm_cfgrd_wait(  1, 1, 0, addr, 4, SCR_MEMSLAVE, compl_status);
//                dword = shmem_read(SCR_MEMSLAVE,4) ;
//                nclk  = (dword[18:17]==2'b00)?32'h1:
//                        (dword[18:17]==2'b01)?32'h2:
//                        (dword[18:17]==2'b10)?32'h4: 32'h8;
//             $display("| %s       |    %s  | %s             | %s           |  %s   | %s                                     |", himage4(dword[4:0]),
//                                                                                                                                dimage4(dword[5]),
//                                                                                                                                himage4(dword[13:6]),
//                                                                                                                                dimage4(dword[14]),
//                                                                                                                                (dword[16:15]==2'b11)?"8.0Gb":
//                                                                                                                                (dword[16:15]==2'b10)?"5.0Gb":"2.5Gb",
//                                                                                                                                dimage4(nclk[7:0]  ));
//                nbytes=0;
//                nbytes[7:0]=dword[27:20];
//             end
//          end
//          $display("|                                                                                                                 |                ");
//          $display("| ________________________________________________________________________________________________________________|                ");
//          addr = 16'h938;
//          $display("|                                                                                                   | Offset 38h  |   0x%s          ", himage4(addr));
//          $display("| TLP Dump                                                                                          |_____________|_________________");
//          $display("|                                                                                                                 |                 ");
//          $display("|     |  TLP Type (Tag)           |  Bytes  | H1_H2_H3                                                            |             ");
//          empty=0;
//          full=0;
//          ast_rx=0;
//          while (empty == 0) begin
//             addr = 16'h938;
//             ebfm_cfgrd_wait(  1, 1, 0, addr, 4, SCR_MEMSLAVE, compl_status);
//             dword = shmem_read(SCR_MEMSLAVE,4) ;
//             empty = dword[31];
//             ast_rx = dword[0];
//             addr = 16'h93C;
//             ebfm_cfgrd_wait(  1, 1, 0, addr, 4, SCR_MEMSLAVE, compl_status);
//             tlp_h1 = shmem_read(SCR_MEMSLAVE,4) ;
//             addr = 16'h940;
//             ebfm_cfgrd_wait(  1, 1, 0, addr, 4, SCR_MEMSLAVE, compl_status);
//             tlp_h2 = shmem_read(SCR_MEMSLAVE,4) ;
//             addr = 16'h944;
//             ebfm_cfgrd_wait(  1, 1, 0, addr, 4, SCR_MEMSLAVE, compl_status);
//             tlp_h3 = shmem_read(SCR_MEMSLAVE,4) ;
//          $display("|  %s %s                                          |   0x%s             ", (ast_rx==1'b0)?"TX |":"RX |",DisplayTLP(tlp_h1, tlp_h2,tlp_h3, ast_rx), himage8(dword) );
//
//          end
//          $display("|                                                                                                                 |                ");
//          $display("| ________________________________________________________________________________________________________________|                ");
//    end
// endtask
