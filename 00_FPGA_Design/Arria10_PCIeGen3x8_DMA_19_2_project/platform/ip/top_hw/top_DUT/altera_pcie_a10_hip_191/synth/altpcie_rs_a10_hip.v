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


// Complementary HIP reset logic (hiprst) used along with the
// HIP hard reset controller
//
// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on
module altpcie_rs_a10_hip (
   input          pld_clk,
   input          dlup_exit,
   input          hotrst_exit,
   input          l2_exit,
   input          npor_core,
   input   [4: 0] ltssm,

   output reg     hiprst
);

localparam [4:0] LTSSM_POL          = 5'b00010;
localparam [4:0] LTSSM_CPL          = 5'b00011;
localparam [4:0] LTSSM_DET          = 5'b00000;
localparam [4:0] LTSSM_RCV          = 5'b01100;
localparam [4:0] LTSSM_DIS          = 5'b10000;
localparam [4:0] LTSSM_DETA         = 5'b00001;
localparam [4:0] LTSSM_DETQ         = 5'b00000;

reg         hiprst_r;
wire        npor_sync   ;
reg         dlup_exit_r;
reg         exits_r;
reg         hotrst_exit_r;
reg         l2_exit_r;
reg [4: 0]  rsnt_cntn;
reg [4: 0]  ltssm_r;
reg [4: 0]  ltssm_rr;

   //reset Synchronizer

   altpcie_reset_delay_sync #(
      .ACTIVE_RESET           (0),
      .WIDTH_RST              (1),
      .NODENAME               ("npor_sync_altpcie_reset_delay_sync_altpcie_rs_a10_hip"),
      .LOCK_TIME_CNT_WIDTH    (1)
   ) npor_sync_altpcie_reset_delay_sync_altpcie_rs_a10_hip(
      .clk         (pld_clk),
      .async_rst   (npor_core),
      .sync_rst    (npor_sync)
   );

  //Reset delay
   always @(posedge pld_clk or negedge npor_sync) begin
      if (npor_sync == 1'b0) begin
         rsnt_cntn <= 5'h0;
      end
      else if (exits_r == 1'b1) begin
         rsnt_cntn <= 5'd10;
      end
      else if (rsnt_cntn != 5'd20) begin
         rsnt_cntn <= rsnt_cntn + 5'h1;
      end
   end


  //sync and config reset
   always @(posedge pld_clk or negedge npor_sync) begin
      if (npor_sync == 1'b0) begin
          hiprst_r <= 1'b1;
      end
      else begin
         if (exits_r == 1'b1) begin
             hiprst_r <= 1'b1;
         end
         else if (rsnt_cntn == 5'd20) begin
             hiprst_r <= 1'b0;
         end
      end
   end

   always @(posedge pld_clk or negedge npor_sync) begin
      if (npor_sync == 1'b0) begin
         dlup_exit_r    <= 1'b1;
         hotrst_exit_r  <= 1'b1;
         l2_exit_r      <= 1'b1;
         exits_r        <= 1'b0;
         hiprst         <= 1'b1;
         ltssm_r        <= LTSSM_DETQ;
         ltssm_rr       <= LTSSM_DETQ;
      end
      else begin
         ltssm_r        <= ltssm;
         ltssm_rr       <= ltssm_r;
         hiprst         <= hiprst_r;
         dlup_exit_r    <= dlup_exit;
         hotrst_exit_r  <= hotrst_exit;
         l2_exit_r      <= l2_exit;

         exits_r <= ((l2_exit_r == 1'b0)||(hotrst_exit_r == 1'b0)||(dlup_exit_r == 1'b0)||(ltssm_r == LTSSM_DIS))?1'b1:1'b0;
      end
   end

endmodule
