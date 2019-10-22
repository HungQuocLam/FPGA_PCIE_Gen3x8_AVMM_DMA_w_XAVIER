// top_hw.v

`timescale 1 ps / 1 ps

module top (
		input  wire        hip_serial_rx_in0,           //         hip_serial.rx_in0
		input  wire        hip_serial_rx_in1,           //                   .rx_in1
		input  wire        hip_serial_rx_in2,           //                   .rx_in2
		input  wire        hip_serial_rx_in3,           //                   .rx_in3
		input  wire        hip_serial_rx_in4,           //                   .rx_in4
		input  wire        hip_serial_rx_in5,           //                   .rx_in5
		input  wire        hip_serial_rx_in6,           //                   .rx_in6
		input  wire        hip_serial_rx_in7,           //                   .rx_in7
		output wire        hip_serial_tx_out0,          //                   .tx_out0
		output wire        hip_serial_tx_out1,          //                   .tx_out1
		output wire        hip_serial_tx_out2,          //                   .tx_out2
		output wire        hip_serial_tx_out3,          //                   .tx_out3
		output wire        hip_serial_tx_out4,          //                   .tx_out4
		output wire        hip_serial_tx_out5,          //                   .tx_out5
		output wire        hip_serial_tx_out6,          //                   .tx_out6
		output wire        hip_serial_tx_out7,          //                   .tx_out7
		input  wire        refclk_clk,                   //             refclk.clk
		input wire		   perstn_perstn,
		output wire			dk_alive_led,
		
		output wire [0:0]  emif_0_mem_ck,                  //             emif_0_mem_conduit_end.mem_ck
		output wire [0:0]  emif_0_mem_ck_n,                //                                   .mem_ck_n
		output wire [16:0] emif_0_mem_a,                   //                                   .mem_a
		output wire [0:0]  emif_0_mem_act_n,               //                                   .mem_act_n
		output wire [1:0]  emif_0_mem_ba,                  //                                   .mem_ba
		output wire [0:0]  emif_0_mem_bg,                  //                                   .mem_bg
		output wire [0:0]  emif_0_mem_cke,                 //                                   .mem_cke
		output wire [0:0]  emif_0_mem_cs_n,                //                                   .mem_cs_n
		output wire [0:0]  emif_0_mem_odt,                 //                                   .mem_odt
		output wire [0:0]  emif_0_mem_reset_n,             //                                   .mem_reset_n
		inout  wire [7:0]  emif_0_mem_dqs,                 //                                   .mem_dqs
		inout  wire [7:0]  emif_0_mem_dqs_n,               //                                   .mem_dqs_n
		inout  wire [63:0] emif_0_mem_dq,                  //                                   .mem_dq
		inout  wire [7:0]  emif_0_mem_dbi_n,               //                                   .mem_dbi_n
		input  wire        emif_0_oct_rzqin,               //             emif_0_oct_conduit_end.oct_rzqin
		input  wire        emif_0_pll_ref_clk             //      emif_0_pll_ref_clk_clock_sink.clk
	);
	
	wire core_clkout;
	wire emif_reset;
	
	reg [23:0] cnt;
	
	always @(posedge core_clkout or negedge perstn_perstn) begin
		if(perstn_perstn == 0) begin
			cnt <= 24'h0;
		end
		else begin
			cnt <= cnt + 1;
		end
	end
	
	assign dk_alive_led = cnt[23];
	
	top_hw top_hw (
		.emif_0_mem_mem_ck(emif_0_mem_ck),
		.emif_0_mem_mem_ck_n(emif_0_mem_ck_n),
		.emif_0_mem_mem_a(emif_0_mem_a),
		.emif_0_mem_mem_act_n(emif_0_mem_act_n),
		.emif_0_mem_mem_ba(emif_0_mem_ba),
		.emif_0_mem_mem_bg(emif_0_mem_bg),
		.emif_0_mem_mem_cke(emif_0_mem_cke),
		.emif_0_mem_mem_cs_n(emif_0_mem_cs_n),
		.emif_0_mem_mem_odt(emif_0_mem_odt),
		.emif_0_mem_mem_reset_n(emif_0_mem_reset_n),
		.emif_0_mem_mem_dqs(emif_0_mem_dqs),
		.emif_0_mem_mem_dqs_n(emif_0_mem_dqs_n),
		.emif_0_mem_mem_dq(emif_0_mem_dq),
		.emif_0_mem_mem_dbi_n(emif_0_mem_dbi_n),
		.emif_0_oct_oct_rzqin(emif_0_oct_rzqin),
		.emif_0_pll_ref_clk_clk(emif_0_pll_ref_clk),
		
		.core_clk_out_clk(core_clkout),
		.dut_npor_npor(perstn_perstn),               //           dut_npor.npor
		.dut_npor_pin_perst(perstn_perstn),          //                   .pin_perst
		.hip_serial_rx_in0(hip_serial_rx_in0),           //         hip_serial.rx_in0
		.hip_serial_rx_in1(hip_serial_rx_in1),           //                   .rx_in1
		.hip_serial_rx_in2(hip_serial_rx_in2),           //                   .rx_in2
		.hip_serial_rx_in3(hip_serial_rx_in3),           //                   .rx_in3
		.hip_serial_rx_in4(hip_serial_rx_in4),           //                   .rx_in4
		.hip_serial_rx_in5(hip_serial_rx_in5),           //                   .rx_in5
		.hip_serial_rx_in6(hip_serial_rx_in6),           //                   .rx_in6
		.hip_serial_rx_in7(hip_serial_rx_in7),           //                   .rx_in7
		.hip_serial_tx_out0(hip_serial_tx_out0),          //                   .tx_out0
		.hip_serial_tx_out1(hip_serial_tx_out1),          //                   .tx_out1
		.hip_serial_tx_out2(hip_serial_tx_out2),          //                   .tx_out2
		.hip_serial_tx_out3(hip_serial_tx_out3),          //                   .tx_out3
		.hip_serial_tx_out4(hip_serial_tx_out4),          //                   .tx_out4
		.hip_serial_tx_out5(hip_serial_tx_out5),          //                   .tx_out5
		.hip_serial_tx_out6(hip_serial_tx_out6),          //                   .tx_out6
		.hip_serial_tx_out7(hip_serial_tx_out7),          //                   .tx_out7
		.refclk_clk(refclk_clk)                   //             refclk.clk
		);
endmodule
