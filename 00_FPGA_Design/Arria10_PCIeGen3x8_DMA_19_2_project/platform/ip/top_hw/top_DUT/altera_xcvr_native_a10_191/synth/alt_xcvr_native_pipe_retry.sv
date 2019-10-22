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


`timescale 1ps/1ps 
module alt_xcvr_native_pipe_retry (
  input               pipe_pclk,
  input               tx_digitalreset,
  input      [1:0]    pld_rate,
  input      [19:0]   pld_testbus,
  output reg [1:0]    rate_retry
);

/*********************************************************************************/
// Set localparams for configuring index bits as well as synchronizing the reset
/*********************************************************************************/
// if we use a timeout of 127, then the delay for a single attempt is 508ns
// For an attempt + a restore, its 1us, which corresponds to 1.5us to attempt
// both a posedge and a negedge launch attempt.  The full retry time before
// a recycle is 2us.

// Timeout value = 2^(lcl_rate_switch_counter_width-2)-1 = 2^7-1 = 127
localparam lcl_rate_switch_counter_width  = 9;
localparam lcl_index_switch_clock         = lcl_rate_switch_counter_width-1;
localparam lcl_index_restory_pre_rate_sw  = lcl_rate_switch_counter_width-2;
localparam lcl_index_max_counter_timeout  = lcl_rate_switch_counter_width-3;

// Register for counter
reg   [lcl_rate_switch_counter_width-1:0]   retry_counter;

// Synchronize tx_digitalreset
wire          hv_pipe_clk;
wire          tx_digitalreset_pclk_sync;
wire          tx_digitalresetn_hv_sync;
alt_xcvr_resync #(
  .SYNC_CHAIN_LENGTH  ( 3 ),
  .WIDTH              ( 1 ),
  .SLOW_CLOCK         ( 0 ),
  .INIT_VALUE         ( 1 )
) tx_digitalreset_pclk_inst (
  .clk                (pipe_pclk),
  .reset              (tx_digitalreset),
  .d                  (1'b0),
  .q                  (tx_digitalreset_pclk_sync)
);

alt_xcvr_resync #(
  .SYNC_CHAIN_LENGTH  ( 3 ),
  .WIDTH              ( 1 ),
  .SLOW_CLOCK         ( 0 ),
  .INIT_VALUE         ( 0 )
) tx_digitalreset_hv_inst (
  .clk                (hv_pipe_clk),
  .reset              (tx_digitalreset),
  .d                  (1'b1),
  .q                  (tx_digitalresetn_hv_sync)
);


/*********************************************************************************/
// Take the asynchronous inputs of Rate from the testbus and the user.
/*********************************************************************************/
// Delcare local wires and registers
//reg   [2:0]   pld_rate_vec_timeout;
reg   [3:0]   pma_pld_rate_sync;
reg   [3:0]   pld_rate_sync;
wire  [1:0]   pma_pld_rate_r;
wire  [1:0]   pld_rate_restore;
wire  [1:0]   pld_rate_r;

// Assign the buses to the second stage of the reset registers;
assign pma_pld_rate_r     =  pma_pld_rate_sync[3:2]; 
assign pld_rate_restore   =  pld_rate_sync[3:2];
assign pld_rate_r         =  pld_rate_sync[1:0]; 

// Set a 2-stage synchronizer chain to minimize resolve spy-glass related issues.  Since
// the If the pld_rate from the core is asynchronous, then run a counter when the rate
// changes to resolve any issues with bit-skew.
always@(posedge pipe_pclk or posedge tx_digitalreset_pclk_sync) begin
  if(tx_digitalreset_pclk_sync) begin
    pma_pld_rate_sync          <= 4'b0;
    pld_rate_sync              <= 4'b0;
    
  end else begin
    // 2-bit synchronizer for the testbus
    pma_pld_rate_sync[1:0]     <= pld_testbus[9:8];
    pma_pld_rate_sync[3:2]     <= pma_pld_rate_sync[1:0];

    // 2-bitsynchrnoizer for the user pld_rate
    pld_rate_sync[1:0]         <= pld_rate;

    // when the testbus matches the incoming rate request, update the register.
    if( (pma_pld_rate_r == pld_rate_r) && (&retry_counter[lcl_index_max_counter_timeout:2]) ) begin
      pld_rate_sync[3:2]       <= pld_rate_sync[1:0];
    end
  end
end


/*********************************************************************************/
// Determine if a retry may be required.
/*********************************************************************************/
// Declare local wires
wire          lcl_require_retry;
reg           require_retry;

// A retry is required when the transceiver channel's current rate differes from the 
// requested rate from the core. 
assign lcl_require_retry     =  (pld_rate_r != pld_rate_restore);
always@(posedge pipe_pclk) begin
  require_retry <=  lcl_require_retry;
end


/*********************************************************************************/
// Run the timeout counter to track attempts rate and clock edge attempts
/*********************************************************************************/
// Declare local registers and wires
wire                                        switch_clock_edge;
wire                                        restore_pre_rate_sw;

// Assign the wires switch_clock_rate and restor_pre_rate_sw for readability purposes.
assign switch_clock_edge        = retry_counter[lcl_index_switch_clock];
assign restore_pre_rate_sw      = retry_counter[lcl_index_restory_pre_rate_sw];

// This block essentially runs two counters: a timeout to sample the ASN_TESTBUS for pcie_rate
// and rate attmpt counter to track of the current attempt.  For efficiency and readability 
// A single physical counter is uses.  The upper two bits are the rate attempt counter, and
// the lower 7 bits compose of the timeout counter
// 
// Timeout Counter = retry_counter[6:0]
// Rate Attempt Counter = {switch_clock_edge, switch_clock_edge} = retry_counter[8:7]
//
// There are 4 potential combinations for the rate attempt counter (retry_counter[8:7]
//          (0)Posedge clock, (0)requested rate switch             (encoding: 0 0) 
//          (0)Posedge clock, (1)restore pre-rate switch rate      (encoding: 0 1)
//          (1)negedge clock, (0)requested rate switch             (encoding: 1 0)
//          (1)negedge clock, (1)restory pre-rate switch rate      (encoding: 1 1)
always@(posedge pipe_pclk or posedge tx_digitalreset_pclk_sync) begin
  if(tx_digitalreset_pclk_sync) begin
    retry_counter         <=  {lcl_rate_switch_counter_width{1'b0}};

  end else begin // end if reset condition
    if(require_retry) begin
      retry_counter       <=  retry_counter + 1'b1;

    end else begin // end if require_retry
      retry_counter       <=  {lcl_rate_switch_counter_width{1'b0}};

    end // end else require_retry
  end // end else reset condition
end // end always block


/*********************************************************************************/
// Alternate the PCI Rate between transceiver current rate and requested rate
/*********************************************************************************/
// Declare local wires
wire  [1:0]   retry_attempt;

// Assign the PCIe rate request to the transceiver.  Alternates between the transceiver
// rate and the requested rate from the core.  Every timeout from the counter, the rate
// will either attempt to downtrain/uptrain or restore the current transceiver rate
assign retry_attempt  =  (restore_pre_rate_sw == 1'b1) ? pld_rate_restore : pld_rate_r;


/*********************************************************************************/
// Buffer the rate request as well as the clock switch on the PCLK
/*********************************************************************************/
// Declare local wires and registers
wire          rate_change_sync;
wire          update_pld_rate_output;
reg           rate_change;
reg           rate_change_edge;
reg restore_pre_rate_sw_buf;
reg require_retry_buf;
reg   [1:0]   hv_sync_vec_pipe_rate;

// Buffer the rate switch request as well as the clock edge switch on the pclk domain
always@(posedge pipe_pclk or posedge tx_digitalreset_pclk_sync) begin
  if(tx_digitalreset_pclk_sync) begin
    hv_sync_vec_pipe_rate    <= 2'b0;
    require_retry_buf        <= 1'b0;
    restore_pre_rate_sw_buf  <= 1'b0;
    rate_change              <= 1'b0;
  end else begin // end if tx_digitalreset_pclk_sync

    hv_sync_vec_pipe_rate    <= retry_attempt;
    restore_pre_rate_sw_buf  <= restore_pre_rate_sw;
    require_retry_buf        <= require_retry;
    rate_change              <= ((restore_pre_rate_sw ^ restore_pre_rate_sw_buf) || (require_retry & ~require_retry_buf)) ? ~rate_change  : rate_change;
  end // end else tx_digitalreseet_sync
end


/*********************************************************************************/
// Switch clock edge and rate request update
/*********************************************************************************/
// Based upon the clock edge requirement, swap the unateness
assign hv_pipe_clk  = (switch_clock_edge == 1'b1) ? ~pipe_pclk : pipe_pclk;

// Since the rate_sw_req is technically asynchronous due to the different clock networks,
// rate_attempt is on pclk and hv_sync_retry_rate is on HV - after the clock edge switch,
// the signal needs to be synchornized into the HV clock domain
alt_xcvr_resync #(
  .SYNC_CHAIN_LENGTH  ( 3 ),
  .WIDTH              ( 1 ),
  .SLOW_CLOCK         ( 0 ),
  .INIT_VALUE         ( 0 )
) rate_sw_sync_inst (
  .clk                (hv_pipe_clk),
  .reset              (1'b0),
  .d                  (rate_change),
  .q                  (rate_change_sync)
);

// After the rate_sw_req is synchronized (3-clock cycles later) into the hv_pipe_clk domain,
// the hv_sync_retry_rate can be updated.  This register will recycle its value until the
// value of rate_sw_req_sync is 1'b1.  After hv_sync_retry_rate is updated, the rate_sw_req
// will go to 1'b1, which will take 3-cycles to synchronize, at which point hv_sync_retry_rate
// will recycle its current value.
// 
// This offers a 3-cycle window for the value of hv_sync_vec_pipe_rate to stabilize at the input
// to hv_sync_retry_rate.
assign update_pld_rate_output = (rate_change_edge ^ rate_change_sync);
always@(posedge hv_pipe_clk) begin
  rate_change_edge      <=  rate_change_sync;
end

(* altera_attribute = " -name MAX_WIRES_FOR_CORE_PERIPHERY_TRANSFER 2 " *)
dffe hv_sync_retry_rate_r0 (
  .d          (hv_sync_vec_pipe_rate[0]),
  .clk        (hv_pipe_clk),
  .clrn       (tx_digitalresetn_hv_sync),
  .prn        (1'b1),
  .ena        (update_pld_rate_output),
  .q          (rate_retry[0])
);

(* altera_attribute = " -name MAX_WIRES_FOR_CORE_PERIPHERY_TRANSFER 2 " *)
dffe hv_sync_retry_rate_r1 (
  .d          (hv_sync_vec_pipe_rate[1]),
  .clk        (hv_pipe_clk),
  .clrn       (tx_digitalresetn_hv_sync),
  .prn        (1'b1),
  .ena        (update_pld_rate_output),
  .q          (rate_retry[1])
);

endmodule
