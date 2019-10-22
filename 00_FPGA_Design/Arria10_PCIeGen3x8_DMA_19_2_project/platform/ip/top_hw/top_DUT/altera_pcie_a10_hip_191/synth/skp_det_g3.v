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


module skp_det_g3 (
   input [31:0] rxdata,
   input rxstartblock,
   input [1:0] rxsynchdr,
   input rxvalid,
   input rxdatavalid,
   input rate_g3,
   input core_clk,
   input core_rst_n,

   output reg skp_pat_det_g3_ps //pulse stretched SKP pattern detect indicator
);

wire skp_pat_det_g3_sb;
wire skp_pat_det_g3_d;
wire skp_end_det_g3;
wire false_skp_det;

reg [1:0]  skp_pat_det_g3;
//reg skp_pat_det_g3_ps;
reg skp_pat_det_g3_sb_dly;
reg skp_pat_det_g3_d_dly;

reg [1:0] rxsynchdr_ext;

//detect Arria 10 Gen3 block aligner SKP error pattern. SKP pattern detected during data block
assign skp_pat_det_g3_sb = ((rxdata[31:0] == 32'haaaa_aaaa) & rxstartblock & (rxsynchdr[1:0] == 2'b10) & rxvalid); //Detect start of SKP in scrambled data when syn header is datablk 
assign skp_pat_det_g3_d  = ((rxdata[31:0] == 32'haaaa_aaaa) & (rxsynchdr_ext[1:0] == 2'b10) & rxvalid & rxdatavalid); //Detect next cycle of scrambled data looking like a SKP
assign skp_end_det_g3    = (rxdata[7:0] == 8'he1) & (rxsynchdr_ext[1:0] == 2'b10) & rxvalid & rxdatavalid;

//assign false_skp_det = ~(k_g3_skp_det_dis) & (skp_pat_det_g3_sb_dly & skp_pat_det_g3_d) | (skp_pat_det_g3_d_dly & skp_end_det_g3); //first two cycles of a 32-bit SKP OS detected in a datablock
//assign false_skp_det = (skp_pat_det_g3_sb_dly & skp_pat_det_g3_d) | (skp_pat_det_g3_d_dly & skp_end_det_g3); //first two cycles of a 32-bit SKP OS detected in a datablock
assign false_skp_det = (skp_pat_det_g3_sb_dly & skp_pat_det_g3_d) | (skp_pat_det_g3_sb_dly & skp_end_det_g3); //first two cycles of a 32-bit SKP OS detected in a datablock

always @ (posedge core_clk or negedge core_rst_n) begin
   if(!core_rst_n) begin
      skp_pat_det_g3[1:0]     <= 2'b00;
      skp_pat_det_g3_ps       <= 1'b0;
      skp_pat_det_g3_sb_dly   <= 1'b0;
      skp_pat_det_g3_d_dly    <= 1'b0;
	  rxsynchdr_ext			  <= 2'b00;
   end   
   else begin         
      skp_pat_det_g3_sb_dly   <= rxvalid ? skp_pat_det_g3_sb : skp_pat_det_g3_sb_dly;
      skp_pat_det_g3_d_dly    <= skp_pat_det_g3_d;
      skp_pat_det_g3[1:0]     <= {skp_pat_det_g3[0], false_skp_det};
      skp_pat_det_g3_ps       <= (skp_pat_det_g3[1] | skp_pat_det_g3[0] | false_skp_det ); //pulse stretch output for 3 cycles (6ns worst case @ 500MHz)
	  rxsynchdr_ext[1:0]	  <= (rxstartblock==1'b1) ? rxsynchdr[1:0] : rxsynchdr_ext[1:0];
   end
end

endmodule