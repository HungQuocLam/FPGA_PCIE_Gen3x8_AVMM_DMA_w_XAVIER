// top_emif_0_altera_ip_col_if_191_ksrpnai.v

// This file was auto-generated from altera_ip_col_if_hw.tcl.  If you edit it your changes
// will probably be lost.
// 
// Generated using ACDS version 19.2 57

`timescale 1 ps / 1 ps
module top_emif_0_altera_ip_col_if_191_ksrpnai (
		input  wire        avl_clk_in_clk,         //  avl_clk_in.clk
		output wire        avl_clk_out_clk,        // avl_clk_out.clk
		input  wire        avl_rst_in_reset,       //  avl_rst_in.reset
		output wire        avl_rst_out_reset,      // avl_rst_out.reset
		input  wire        to_ioaux_waitrequest,   //    to_ioaux.waitrequest
		input  wire [31:0] to_ioaux_readdata,      //            .readdata
		input  wire        to_ioaux_readdatavalid, //            .readdatavalid
		output wire [0:0]  to_ioaux_burstcount,    //            .burstcount
		output wire [31:0] to_ioaux_writedata,     //            .writedata
		output wire [29:0] to_ioaux_address,       //            .address
		output wire        to_ioaux_write,         //            .write
		output wire        to_ioaux_read,          //            .read
		output wire [3:0]  to_ioaux_byteenable,    //            .byteenable
		output wire        to_ioaux_debugaccess    //            .debugaccess
	);

	wire  [31:0] colmaster_master_readdata;                         // mm_interconnect_0:colmaster_master_readdata -> colmaster:master_readdata
	wire         colmaster_master_waitrequest;                      // mm_interconnect_0:colmaster_master_waitrequest -> colmaster:master_waitrequest
	wire  [31:0] colmaster_master_address;                          // colmaster:master_address -> mm_interconnect_0:colmaster_master_address
	wire         colmaster_master_read;                             // colmaster:master_read -> mm_interconnect_0:colmaster_master_read
	wire   [3:0] colmaster_master_byteenable;                       // colmaster:master_byteenable -> mm_interconnect_0:colmaster_master_byteenable
	wire         colmaster_master_readdatavalid;                    // mm_interconnect_0:colmaster_master_readdatavalid -> colmaster:master_readdatavalid
	wire         colmaster_master_write;                            // colmaster:master_write -> mm_interconnect_0:colmaster_master_write
	wire  [31:0] colmaster_master_writedata;                        // colmaster:master_writedata -> mm_interconnect_0:colmaster_master_writedata
	wire  [31:0] mm_interconnect_0_avl_bridge_out_s0_readdata;      // avl_bridge_out:s0_readdata -> mm_interconnect_0:avl_bridge_out_s0_readdata
	wire         mm_interconnect_0_avl_bridge_out_s0_waitrequest;   // avl_bridge_out:s0_waitrequest -> mm_interconnect_0:avl_bridge_out_s0_waitrequest
	wire         mm_interconnect_0_avl_bridge_out_s0_debugaccess;   // mm_interconnect_0:avl_bridge_out_s0_debugaccess -> avl_bridge_out:s0_debugaccess
	wire  [29:0] mm_interconnect_0_avl_bridge_out_s0_address;       // mm_interconnect_0:avl_bridge_out_s0_address -> avl_bridge_out:s0_address
	wire         mm_interconnect_0_avl_bridge_out_s0_read;          // mm_interconnect_0:avl_bridge_out_s0_read -> avl_bridge_out:s0_read
	wire   [3:0] mm_interconnect_0_avl_bridge_out_s0_byteenable;    // mm_interconnect_0:avl_bridge_out_s0_byteenable -> avl_bridge_out:s0_byteenable
	wire         mm_interconnect_0_avl_bridge_out_s0_readdatavalid; // avl_bridge_out:s0_readdatavalid -> mm_interconnect_0:avl_bridge_out_s0_readdatavalid
	wire         mm_interconnect_0_avl_bridge_out_s0_write;         // mm_interconnect_0:avl_bridge_out_s0_write -> avl_bridge_out:s0_write
	wire  [31:0] mm_interconnect_0_avl_bridge_out_s0_writedata;     // mm_interconnect_0:avl_bridge_out_s0_writedata -> avl_bridge_out:s0_writedata
	wire   [0:0] mm_interconnect_0_avl_bridge_out_s0_burstcount;    // mm_interconnect_0:avl_bridge_out_s0_burstcount -> avl_bridge_out:s0_burstcount

	top_emif_0_altera_avalon_mm_bridge_191_x6qdesi #(
		.DATA_WIDTH        (32),
		.SYMBOL_WIDTH      (8),
		.HDL_ADDR_WIDTH    (30),
		.BURSTCOUNT_WIDTH  (1),
		.PIPELINE_COMMAND  (1),
		.PIPELINE_RESPONSE (1),
		.SYNC_RESET        (0)
	) avl_bridge_out (
		.clk              (avl_clk_in_clk),                                    //   input,   width = 1,   clk.clk
		.reset            (avl_rst_in_reset),                                  //   input,   width = 1, reset.reset
		.s0_waitrequest   (mm_interconnect_0_avl_bridge_out_s0_waitrequest),   //  output,   width = 1,    s0.waitrequest
		.s0_readdata      (mm_interconnect_0_avl_bridge_out_s0_readdata),      //  output,  width = 32,      .readdata
		.s0_readdatavalid (mm_interconnect_0_avl_bridge_out_s0_readdatavalid), //  output,   width = 1,      .readdatavalid
		.s0_burstcount    (mm_interconnect_0_avl_bridge_out_s0_burstcount),    //   input,   width = 1,      .burstcount
		.s0_writedata     (mm_interconnect_0_avl_bridge_out_s0_writedata),     //   input,  width = 32,      .writedata
		.s0_address       (mm_interconnect_0_avl_bridge_out_s0_address),       //   input,  width = 30,      .address
		.s0_write         (mm_interconnect_0_avl_bridge_out_s0_write),         //   input,   width = 1,      .write
		.s0_read          (mm_interconnect_0_avl_bridge_out_s0_read),          //   input,   width = 1,      .read
		.s0_byteenable    (mm_interconnect_0_avl_bridge_out_s0_byteenable),    //   input,   width = 4,      .byteenable
		.s0_debugaccess   (mm_interconnect_0_avl_bridge_out_s0_debugaccess),   //   input,   width = 1,      .debugaccess
		.m0_waitrequest   (to_ioaux_waitrequest),                              //   input,   width = 1,    m0.waitrequest
		.m0_readdata      (to_ioaux_readdata),                                 //   input,  width = 32,      .readdata
		.m0_readdatavalid (to_ioaux_readdatavalid),                            //   input,   width = 1,      .readdatavalid
		.m0_burstcount    (to_ioaux_burstcount),                               //  output,   width = 1,      .burstcount
		.m0_writedata     (to_ioaux_writedata),                                //  output,  width = 32,      .writedata
		.m0_address       (to_ioaux_address),                                  //  output,  width = 30,      .address
		.m0_write         (to_ioaux_write),                                    //  output,   width = 1,      .write
		.m0_read          (to_ioaux_read),                                     //  output,   width = 1,      .read
		.m0_byteenable    (to_ioaux_byteenable),                               //  output,   width = 4,      .byteenable
		.m0_debugaccess   (to_ioaux_debugaccess),                              //  output,   width = 1,      .debugaccess
		.s0_response      (),                                                  // (terminated),                    
		.m0_response      (2'b00)                                              // (terminated),                    
	);

	top_emif_0_alt_mem_if_jtag_master_191_rksoe3i #(
		.USE_PLI     (0),
		.PLI_PORT    (50000),
		.FIFO_DEPTHS (2)
	) colmaster (
		.clk_clk              (avl_clk_in_clk),                 //   input,   width = 1,          clk.clk
		.clk_reset_reset      (avl_rst_in_reset),               //   input,   width = 1,    clk_reset.reset
		.master_reset_reset   (),                               //  output,   width = 1, master_reset.reset
		.master_address       (colmaster_master_address),       //  output,  width = 32,       master.address
		.master_readdata      (colmaster_master_readdata),      //   input,  width = 32,             .readdata
		.master_read          (colmaster_master_read),          //  output,   width = 1,             .read
		.master_write         (colmaster_master_write),         //  output,   width = 1,             .write
		.master_writedata     (colmaster_master_writedata),     //  output,  width = 32,             .writedata
		.master_waitrequest   (colmaster_master_waitrequest),   //   input,   width = 1,             .waitrequest
		.master_readdatavalid (colmaster_master_readdatavalid), //   input,   width = 1,             .readdatavalid
		.master_byteenable    (colmaster_master_byteenable)     //  output,   width = 4,             .byteenable
	);

	top_emif_0_altera_mm_interconnect_191_3yb4cia mm_interconnect_0 (
		.colmaster_master_address                         (colmaster_master_address),                          //   input,  width = 32,                           colmaster_master.address
		.colmaster_master_waitrequest                     (colmaster_master_waitrequest),                      //  output,   width = 1,                                           .waitrequest
		.colmaster_master_byteenable                      (colmaster_master_byteenable),                       //   input,   width = 4,                                           .byteenable
		.colmaster_master_read                            (colmaster_master_read),                             //   input,   width = 1,                                           .read
		.colmaster_master_readdata                        (colmaster_master_readdata),                         //  output,  width = 32,                                           .readdata
		.colmaster_master_readdatavalid                   (colmaster_master_readdatavalid),                    //  output,   width = 1,                                           .readdatavalid
		.colmaster_master_write                           (colmaster_master_write),                            //   input,   width = 1,                                           .write
		.colmaster_master_writedata                       (colmaster_master_writedata),                        //   input,  width = 32,                                           .writedata
		.avl_bridge_out_s0_address                        (mm_interconnect_0_avl_bridge_out_s0_address),       //  output,  width = 30,                          avl_bridge_out_s0.address
		.avl_bridge_out_s0_write                          (mm_interconnect_0_avl_bridge_out_s0_write),         //  output,   width = 1,                                           .write
		.avl_bridge_out_s0_read                           (mm_interconnect_0_avl_bridge_out_s0_read),          //  output,   width = 1,                                           .read
		.avl_bridge_out_s0_readdata                       (mm_interconnect_0_avl_bridge_out_s0_readdata),      //   input,  width = 32,                                           .readdata
		.avl_bridge_out_s0_writedata                      (mm_interconnect_0_avl_bridge_out_s0_writedata),     //  output,  width = 32,                                           .writedata
		.avl_bridge_out_s0_burstcount                     (mm_interconnect_0_avl_bridge_out_s0_burstcount),    //  output,   width = 1,                                           .burstcount
		.avl_bridge_out_s0_byteenable                     (mm_interconnect_0_avl_bridge_out_s0_byteenable),    //  output,   width = 4,                                           .byteenable
		.avl_bridge_out_s0_readdatavalid                  (mm_interconnect_0_avl_bridge_out_s0_readdatavalid), //   input,   width = 1,                                           .readdatavalid
		.avl_bridge_out_s0_waitrequest                    (mm_interconnect_0_avl_bridge_out_s0_waitrequest),   //   input,   width = 1,                                           .waitrequest
		.avl_bridge_out_s0_debugaccess                    (mm_interconnect_0_avl_bridge_out_s0_debugaccess),   //  output,   width = 1,                                           .debugaccess
		.avl_bridge_out_reset_reset_bridge_in_reset_reset (avl_rst_in_reset),                                  //   input,   width = 1, avl_bridge_out_reset_reset_bridge_in_reset.reset
		.clk_bridge_out_clk_1_clk                         (avl_clk_in_clk)                                     //   input,   width = 1,                       clk_bridge_out_clk_1.clk
	);

	assign avl_clk_out_clk = avl_clk_in_clk;

	assign avl_rst_out_reset = avl_rst_in_reset;

endmodule
