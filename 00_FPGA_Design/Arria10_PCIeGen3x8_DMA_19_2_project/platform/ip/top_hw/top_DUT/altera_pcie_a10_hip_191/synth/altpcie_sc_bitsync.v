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
module altpcie_sc_bitsync
  #(
    parameter DWIDTH    = 1, // Sync Data input
    parameter NODENAME  = "altpcie_sc_bitsync", // Expecting Instance name
    parameter SYNCSTAGE = 2, // Sync stages
    parameter SDC_TYPE  = 0, // 0: Multi Cycle=3, 1:Multi Cycle=2, 2: Set False Path
    parameter RESET_VAL = 0  // Reset value
    )
    (
    input  wire              clk,     // clock
    input  wire              rst_n,   // async reset
    input  wire [DWIDTH-1:0] data_in, // data in
    output wire [DWIDTH-1:0] data_out // data out
);

   localparam SYNCSTAGE_INT=SYNCSTAGE-1;
   // set of handy SDC constraints
   localparam MULTI_2      = {"-name SDC_STATEMENT \"set_multicycle_path -to [get_keepers *" , NODENAME , "*altpcie_sc_bitsync_meta_dff\[*\]] 2\" "};
   localparam MULTI_3      = {"-name SDC_STATEMENT \"set_multicycle_path -to [get_keepers *" , NODENAME , "*altpcie_sc_bitsync_meta_dff\[*\]] 3\" "};
   localparam FPATH        = {"-name SDC_STATEMENT \"set_false_path -to [get_keepers *"      , NODENAME , "*altpcie_sc_bitsync_meta_dff\[*\]]\" "};
   localparam FHOLD        = {"-name SDC_STATEMENT \"set_false_path -hold -to [get_keepers *", NODENAME , "*altpcie_sc_bitsync_meta_dff\[*\]]\" "};
   localparam SDC          = (SDC_TYPE==0)?{MULTI_3,";",FHOLD}:(SDC_TYPE==1)?{MULTI_2,";",FHOLD}:{FPATH  ,";",FHOLD};

// synthesis translate_off
   initial begin
      $display("INFO:         altpcie_sc_bitsync::---------------------------------------------------------------------------------------------");
      $display("INFO:         altpcie_sc_bitsync:: NODENAME is %s", NODENAME);
      $display("INFO:         altpcie_sc_bitsync:: SDC is %s", SDC);
   end
// synthesis translate_on

   // Define wires/regs
   (* altera_attribute = SDC *)
   reg [DWIDTH-1:0]                 altpcie_sc_bitsync_meta_dff;
   wire                             reset_value;

   assign reset_value = (RESET_VAL == 1) ? 1'b1 : 1'b0;  // To eliminate truncating warning

   generate begin : g_bitsync
      if (SYNCSTAGE==2) begin : g_bitsync2
         // Sync Always block
         // Sync Always block
         reg [DWIDTH-1:0]     sync_regs;
         reg [DWIDTH-1:0]     sync_regsb;
         always @(negedge rst_n or posedge clk) begin
            if (rst_n == 1'b0) begin
               sync_regs[DWIDTH-1:0] <= {(DWIDTH){reset_value}};
               sync_regsb[DWIDTH-1:0] <= {(DWIDTH){reset_value}};
            end
            else begin
               sync_regs[DWIDTH-1:0] <= altpcie_sc_bitsync_meta_dff;
               sync_regsb[DWIDTH-1:0] <= sync_regs[DWIDTH-1:0] ;
            end
         end
         assign data_out[DWIDTH-1:0] = sync_regsb[DWIDTH-1:0];
      end
      else if (SYNCSTAGE==3) begin : g_bitsync3
         // Sync Always block
         // Sync Always block
         reg [DWIDTH-1:0]     sync_regs;
         reg [DWIDTH-1:0]     sync_regsb;
         reg [DWIDTH-1:0]     sync_regsc;
         always @(negedge rst_n or posedge clk) begin
            if (rst_n == 1'b0) begin
               sync_regs[DWIDTH-1:0] <= {(DWIDTH){reset_value}};
               sync_regsb[DWIDTH-1:0] <= {(DWIDTH){reset_value}};
               sync_regsc[DWIDTH-1:0] <= {(DWIDTH){reset_value}};
            end
            else begin
               sync_regs[DWIDTH-1:0] <= altpcie_sc_bitsync_meta_dff;
               sync_regsb[DWIDTH-1:0] <= sync_regs[DWIDTH-1:0] ;
               sync_regsc[DWIDTH-1:0] <= sync_regsb[DWIDTH-1:0] ;
            end
         end
         assign data_out[DWIDTH-1:0] = sync_regsc[DWIDTH-1:0];
      end
      else begin : g_bitsync4
         // Sync Always block
         reg [DWIDTH-1:0]     sync_regs;
         always @(negedge rst_n or posedge clk) begin
            if (rst_n == 1'b0) begin
               sync_regs[DWIDTH-1:0] <= {(DWIDTH){reset_value}};
            end
            else begin
               sync_regs[DWIDTH-1:0] <= altpcie_sc_bitsync_meta_dff;
            end
         end
         assign data_out[DWIDTH-1:0] = sync_regs[DWIDTH-1:0];
      end
   end
   endgenerate

   // Separated out the first stage of FFs without reset
   always @(posedge clk) begin
      altpcie_sc_bitsync_meta_dff[DWIDTH-1:0] <= data_in;
   end


endmodule // altpcie_sc_bitsync

// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on
module altpcie_sc_bitsync_node
  #(
    parameter DWIDTH    = 1, // Sync Data input
    parameter NODENAME  = "altpcie_sc_bitsync_node", // Instance name
    parameter SYNCSTAGE = 2, // Sync stages
    parameter SDC_TYPE  = 0, // 0: Multi Cycle=3, 1:Multi Cycle=2, 2: Set False Path
    parameter RESET_VAL = 0  // Reset value
    )
    (
    input  wire              clk,     // clock
    input  wire              rst_n,   // async reset
    input  wire [DWIDTH-1:0] data_in, // data in
    output wire [DWIDTH-1:0] data_out // data out
);

   altpcie_sc_bitsync #(
      .DWIDTH     ( DWIDTH          ),// Sync Data input
      .NODENAME   ( NODENAME        ),// Sync stages
      .SYNCSTAGE  ( SYNCSTAGE       ),// 0: Multi Cycle=3, 1:Multi Cycle=2, 2: Set False Path
      .SDC_TYPE   ( SDC_TYPE        ),// Instance name
      .RESET_VAL  ( RESET_VAL       ) // Reset value
    ) altpcie_sc_bitsync (
      .clk        (clk              ),// clock
      .rst_n      (rst_n            ),// async reset
      .data_in    (data_in          ),// data in
      .data_out   (data_out         ) // data out
   );

endmodule //altpcie_sc_bitsync_node
