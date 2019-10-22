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

// Revision 2.1
(* altera_attribute = " -name GLOBAL_SIGNAL OFF -to \"alt_xcvr_resync:reset_pulse_inst|resync_chains[0].sync_r[2]\" " *)
module altera_xcvr_native_pcie_dfe_ip #(
  parameter num_channels            = 8,
  parameter disable_continuous_dfe  = 0,
  parameter enable_hip              = 0,
  parameter sim_reduced_counters    = 0,
  parameter avmm_sel_bits           = 3,
  parameter avmm_addr_bits          = 10
) ( 
  input                                       clock,
  input                                       reset,
  input                                       ltssm_detect_quiet,
  input                                       ltssm_detect_active,
  input                                       ltssm_rcvr_equalization,
  input   [1:0]                               pcie_rate_sw,

  // HIP only signal for supporting reduced sim counters
  input                                       hip_reduce_counters,

  // Reconfig Interface to the transceiver
  input                                       xcvr_rcfg_waitrequest,
  input   [31:0]                              xcvr_rcfg_readdata,
  output                                      xcvr_rcfg_lock,
  output                                      xcvr_rcfg_read,
  output                                      xcvr_rcfg_write,
  output  [avmm_sel_bits+avmm_addr_bits-1:0]  xcvr_rcfg_address,
  output  [31:0]                              xcvr_rcfg_writedata
);

///////////////////////////////////////////////////////////////////////////////
// Import parameters
///////////////////////////////////////////////////////////////////////////////
import altera_xcvr_native_pcie_dfe_params_h::*;


///////////////////////////////////////////////////////////////////////////////
// Import parameters
///////////////////////////////////////////////////////////////////////////////
wire   reduceded_sim_counter;
assign reduceded_sim_counter = (enable_hip) ? hip_reduce_counters : sim_reduced_counters[0];


///////////////////////////////////////////////////////////////////////////////
// Lock out the Reconfig Interface from the user
// wires and registers
///////////////////////////////////////////////////////////////////////////////
wire                      reset_sync;
wire                      gen3_speed;
wire                      gen12_speed;
wire                      rate_change;
wire                      detect_skew_timeout;
wire                      ltssm_detect;
wire                      indexed_all_channels;
wire                      ltssm_rcvr_equalization_sync;
wire                      ltssm_detect_active_sync;
wire                      ltssm_detect_quiet_sync;
wire                      process_running_done;
wire  [30:0]              mgmt_master_address;
wire  [NUM_PIO_IN-1:0]    pio_to_mgmt_master;
wire  [NUM_PIO_OUT-1:0]   pio_from_mgmt_master;

reg                       modeb_not_restored;
reg                       process_go;
reg                       process_running;
reg                       en_continuous_dfe;
reg                       phase2_not_request;
reg   [1:0]               pcie_rate;
reg   [1:0]               current_rate;
reg   [2:0]               detect_skew_cnt;
reg   [2:0]               vec_timeout;
reg   [3:0]               sm_state;
reg   [3:0]               pcie_rate_sync;
reg   [20:0]              timer_counter;
reg   [20:0]              timer_threshold;
reg   [avmm_sel_bits-1:0] channel_count;


///////////////////////////////////////////////////////////////////////////////
// Assign statements for control/status signals
///////////////////////////////////////////////////////////////////////////////
assign gen3_speed                 = (enable_hip) ? (pcie_rate == 2'b11) : (pcie_rate == 2'b10);
assign gen12_speed                = (enable_hip) ? (pcie_rate != 2'b11) : (pcie_rate != 2'b10);
assign rate_change                = (current_rate != pcie_rate);
assign ltssm_detect               = (ltssm_detect_quiet_sync | ltssm_detect_active_sync);
assign detect_skew_timeout        = (detect_skew_cnt == 3'h7);
assign process_running_done       = (~pio_from_mgmt_master[PIO_OUT_RUNNING] && process_running);
assign indexed_all_channels       = ((channel_count == (num_channels-1)) && process_running_done);

// Lock out the Reconfig Interface from the user
assign xcvr_rcfg_lock             =  (sm_state != SM_IDLE);


///////////////////////////////////////////////////////////////////////////////
// Create a reset pulse
///////////////////////////////////////////////////////////////////////////////
(*preserve*) reg          reg0 = 1'b0;
alt_xcvr_resync #(
  .SYNC_CHAIN_LENGTH         ( 3 ),
  .WIDTH                     ( 1 ),
  .INIT_VALUE                ( 1 )
) reset_pulse_inst (
  .clk                       (clock),
  .reset                     (reset),
  .d                         (reg0),
  .q                         (reset_sync)  
);


///////////////////////////////////////////////////////////////////////////////
// Synchronize the rate signal as well as the status signals
///////////////////////////////////////////////////////////////////////////////
always@(posedge clock or posedge reset_sync) begin
  if(reset_sync) begin
    vec_timeout     <=  3'b0;
    pcie_rate_sync  <=  4'b0;
    pcie_rate       <=  2'b0;
  end else begin
    pcie_rate_sync  <=  {pcie_rate_sync[1:0], pcie_rate_sw};

    if(pcie_rate != pcie_rate_sync[3:2]) begin
      if(vec_timeout != 3'b111) begin
        vec_timeout <=  vec_timeout + 3'b1;
      end else begin
        pcie_rate   <=  pcie_rate_sync[3:2];
      end
    end else begin
      vec_timeout   <=  3'b0;
    end
  end
end

alt_xcvr_resync #(
  .SYNC_CHAIN_LENGTH         ( 3 ),
  .WIDTH                     ( 3 ),
  .INIT_VALUE                ( 0 )
) ltssm_state_sync_inst (
  .clk                       (clock),
  .reset                     (reset_sync),
  .d                         ({ltssm_rcvr_equalization, ltssm_detect_active, ltssm_detect_quiet}),
  .q                         ({ltssm_rcvr_equalization_sync, ltssm_detect_active_sync, ltssm_detect_quiet_sync}) 
);

///////////////////////////////////////////////////////////////////////////////
// Small counter for skew alignment
// If we are not in detect,
///////////////////////////////////////////////////////////////////////////////
always@(posedge clock or posedge reset_sync)begin
  if(reset_sync) begin
    detect_skew_cnt     <=  3'b0;
  end else begin
    if(ltssm_detect) begin
      detect_skew_cnt   <=  3'b0;
    end else begin
      if(detect_skew_timeout) begin
        detect_skew_cnt <=  detect_skew_cnt;
      end else begin
        detect_skew_cnt <=  detect_skew_cnt + 3'b1;
      end
    end
  end
end


///////////////////////////////////////////////////////////////////////////////
// register stage for edge detection
///////////////////////////////////////////////////////////////////////////////
always@(posedge clock or posedge reset_sync) begin
  if(reset_sync) begin
    process_running         <=  1'b0;
  end else begin
    process_running         <=  pio_from_mgmt_master[PIO_OUT_RUNNING];
  end
end


///////////////////////////////////////////////////////////////////////////////
// State machine
///////////////////////////////////////////////////////////////////////////////
always@(posedge clock or posedge reset_sync) begin
  if(reset_sync) begin
    sm_state                <=  SM_POWERUP;
    process_go              <=  1'b0;
    current_rate            <=  2'b0;
    modeb_not_restored      <=  1'b1;
    en_continuous_dfe       <=  1'b1;
    phase2_not_request      <=  1'b0;
    timer_counter           <=  21'b0;
    timer_threshold         <=  (reduceded_sim_counter) ? 21'd1200 : 21'd1200000;

  end else begin
    // default the process_go signal for all states unless otherwise specified
    process_go              <=  1'b0;

    case(sm_state)
      // Powerup state to do a one-time readback on the calibration status
      SM_POWERUP: begin
        sm_state            <=  SM_CHECK_CAL_STATUS;
      end

      SM_CHECK_CAL_STATUS: begin
        // Intercept the AVMM read from the mgmt_master
        if((xcvr_rcfg_address[avmm_addr_bits-1:0] == ADDR_CALIBRATION) && xcvr_rcfg_read == 1'b1 && xcvr_rcfg_waitrequest == 1'b0) begin
          en_continuous_dfe   <=  xcvr_rcfg_readdata[BIT_CALIBRATION];
          sm_state            <=  SM_IDLE;
        end
      end

      SM_IDLE: begin
        current_rate        <=  pcie_rate;
        modeb_not_restored  <=  (detect_skew_timeout) ? 1'b1 : modeb_not_restored;
        phase2_not_request  <=  (ltssm_rcvr_equalization_sync) ? phase2_not_request : 1'b1;
        timer_counter       <=  21'b0;


        // State Transitions.  If we are changin rates, execute the rate change
        // current speed is decoded via combinational logic
        if (rate_change)  begin
          sm_state          <=  SM_EXECUTE_RATE_SW;
        end

        // Restoring mode B must be done everytime we enter detect quiet. This is
        // to ensure that the adaptation block can re-run phase 2.  If we enter
        // recovery equalization phase 2, then we must restore mode b fo re-running
        // phase 2
        else if(ltssm_detect_quiet_sync && modeb_not_restored || ltssm_rcvr_equalization_sync && phase2_not_request) begin
          sm_state          <=  SM_RESTORE_MODEB;
        end
      end

      SM_EXECUTE_RATE_SW: begin
        process_go          <=  1'b1;

        if(indexed_all_channels) begin
          sm_state          <=  SM_IDLE;
        end
      end

      SM_RESTORE_MODEB: begin
        // Set the timer threshold for a 12ms timeout
        timer_threshold     <=  (reduceded_sim_counter) ? 21'd1200 : 21'd1200000;
        timer_counter       <=  (reduceded_sim_counter) ? 21'b0    : timer_counter + 21'b1;

        // Run process over all channels
        process_go          <=  1'b1;

        // Set modeb_not_restored to 0
        modeb_not_restored  <=  1'b0;

        if(indexed_all_channels) begin
          if(ltssm_rcvr_equalization_sync)
            sm_state        <=  SM_TIMEOUT_CTLE;
          else
            sm_state        <=  SM_IDLE;
        end
      end

      SM_TIMEOUT_CTLE: begin
        // Set the timer threshold for a 12ms timeout
        timer_threshold     <=  (reduceded_sim_counter) ? 21'd1200 : 21'd1200000;

        // Check the timeout, else run the counter
        if(timer_counter  ==  timer_threshold) begin
          timer_counter     <=  21'b0;
          sm_state          <=  SM_EXECUTE_CTLE;
        end else begin
          timer_counter     <=  timer_counter + 21'b1;
        end
      end

      SM_EXECUTE_CTLE: begin
        // Set the timer threshold for a 10ms timeout
        timer_threshold     <=  (reduceded_sim_counter) ? 21'd1000 : 21'd1000000;
        timer_counter       <=  (reduceded_sim_counter) ? 21'b0    : timer_counter + 21'b1;

        // Run process over all channels
        process_go          <=  1'b1;

        if(indexed_all_channels) begin
          sm_state          <=  SM_TIMEOUT_DFE;
        end
      end

      SM_TIMEOUT_DFE: begin
        // Set the timer threshold for a 10ms timeout
        timer_threshold     <=  (reduceded_sim_counter) ? 21'd1000 : 21'd1000000;

        // Check the timeout, else run the counter
        if(timer_counter  ==  timer_threshold) begin
          timer_counter     <=  21'b0;
          sm_state          <=  SM_EXECUTE_DFE;
        end else begin
          timer_counter     <=  timer_counter + 21'b1;
        end

      end
        
      SM_EXECUTE_DFE: begin
        // Indicate that the flow has been run
        phase2_not_request  <=  1'b0;

        // Run the process over all channels
        process_go          <=  1'b1;

        if(indexed_all_channels) begin
          sm_state          <=  SM_IDLE;
        end
      end

      default: begin
        process_go          <=  1'b0;
        sm_state            <=  SM_IDLE;
      end

    endcase
  end
end


///////////////////////////////////////////////////////////////////////////////
// Assigns for the Control Signals for the mgmt_master
///////////////////////////////////////////////////////////////////////////////
assign pio_to_mgmt_master[PIO_IN_GO]              = process_go;
assign pio_to_mgmt_master[PIO_IN_SW_GEN_1_2]      = ((sm_state ==  SM_EXECUTE_RATE_SW) && gen12_speed);
assign pio_to_mgmt_master[PIO_IN_SW_GEN_3]        = ((sm_state ==  SM_EXECUTE_RATE_SW) && gen3_speed);
assign pio_to_mgmt_master[PIO_IN_RESTORE_MODEB]   = (sm_state ==  SM_RESTORE_MODEB);
assign pio_to_mgmt_master[PIO_IN_PHASE2_CTLE]     = (sm_state ==  SM_EXECUTE_CTLE);
assign pio_to_mgmt_master[PIO_IN_PHASE2_DFE]      = (sm_state ==  SM_EXECUTE_DFE);
assign pio_to_mgmt_master[PIO_IN_CONTINUOUS_DFE]  = (disable_continuous_dfe) ? 1'b0 : en_continuous_dfe;


///////////////////////////////////////////////////////////////////////////////
// Channel Indexing for the addressing
///////////////////////////////////////////////////////////////////////////////
assign xcvr_rcfg_address  = {channel_count, mgmt_master_address[avmm_addr_bits-1:0]};
always@(posedge clock or posedge reset_sync) begin
  if(reset_sync) begin
    channel_count     <=  {avmm_sel_bits{1'b0}};
  end else begin
    if (sm_state == SM_EXECUTE_RATE_SW || sm_state == SM_RESTORE_MODEB || sm_state == SM_EXECUTE_CTLE || sm_state == SM_EXECUTE_DFE) begin
      if(channel_count == (num_channels - 1)) begin
        channel_count <=  channel_count;
      end else begin
        channel_count <=  channel_count + process_running_done;
      end
    end else begin
      channel_count   <=  {avmm_sel_bits{1'b0}};
    end
  end
end


///////////////////////////////////////////////////////////////////////////////
// mgmt_master cpu for reconfiguration.
///////////////////////////////////////////////////////////////////////////////
pcie_mgmt_master #(
  .CLOCKS_PER_SECOND   ( 100000000 ),                             // Used for time calculations
  .PIO_OUT_SIZE        ( NUM_PIO_OUT ),                           // Width of PIO output port
  .PIO_IN_SIZE         ( NUM_PIO_IN ),                            // Width of PIO input port
  .PIO_OUT_INIT_VALUE  ( 0 ),                                     // Initial value for pio_out registers
  .MEM_DEPTH           ( num_channels * NUM_ADDR_PER_CHNL + 1),   // Depth of the memory for DFE and CTLE
  .ROM_DEPTH           ( 1024 )                                   // Depth of command ROM

  ) pcie_mgmt_master_for_dfe (
  .clk                                (  clock                                     ),
  .reset                              (  reset_sync                                ),
  .av_write                           (  xcvr_rcfg_write                           ),
  .av_read                            (  xcvr_rcfg_read                            ),
  .av_address                         (  mgmt_master_address                       ),
  .av_writedata                       (  xcvr_rcfg_writedata                       ),
  .av_readdata                        (  xcvr_rcfg_readdata                        ),
  .av_waitrequest                     (  xcvr_rcfg_waitrequest                     ),
  .pio_out                            (  pio_from_mgmt_master                      ),
  .pio_in                             (  pio_to_mgmt_master                        )
);

endmodule
