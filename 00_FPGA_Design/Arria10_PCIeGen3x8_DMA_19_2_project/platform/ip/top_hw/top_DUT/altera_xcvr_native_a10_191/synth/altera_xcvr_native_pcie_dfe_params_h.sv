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


// Revision 2.0
package altera_xcvr_native_pcie_dfe_params_h;
  // Program Labels for Jumps
  localparam PRGM_BEGIN           = 1;
  localparam PRGM_SW_GEN3         = 2;
  localparam PRGM_PHASE2_CTLE     = 3;
  localparam PRGM_PHASE2_DFE      = 4;
  localparam PRGM_SW_GEN1_2       = 5;
  localparam PRGM_RESTORE_MODEB   = 6;
  localparam PRGM_SKIP_MANUAL_DFE = 7;
  localparam PRGM_SKIP_CONT_DFE   = 8;
  localparam PRGM_SKIP_DFE_LOAD   = 9;
  localparam PRGM_SKIP_DFE_HOLD   = 10;
  localparam PRGM_SKIP_DFE_MODE_8 = 11;

  // Labels for PIO in
  localparam NUM_PIO_IN           = 7;

  localparam PIO_IN_GO            = 0;
  localparam PIO_IN_SW_GEN_1_2    = 1;
  localparam PIO_IN_SW_GEN_3      = 2;
  localparam PIO_IN_RESTORE_MODEB = 3;
  localparam PIO_IN_PHASE2_CTLE   = 4;
  localparam PIO_IN_PHASE2_DFE    = 5;
  localparam PIO_IN_CONTINUOUS_DFE= 6;
  
  // Labels for PIO out
  localparam NUM_PIO_OUT          = 7;

  localparam PIO_OUT_ERROR        = 0;
  localparam PIO_OUT_RUNNING      = 1;
  localparam PIO_OUT_SW_GEN_1_2   = 2;
  localparam PIO_OUT_SW_GEN_3     = 3;
  localparam PIO_OUT_RESTORE_MODEB= 4;
  localparam PIO_OUT_PHASE2_CTLE  = 5;
  localparam PIO_OUT_PHASE2_DFE   = 6;

  // Static settings
  localparam FORCE_JUMP           = 1;
  localparam GEN1_GEN2_CTLE_VAL   = 32'h00;

  // Test parameters
  localparam TST_MUX_DELAY        = 30;
  localparam SLEEP_DELAY          = 5;

  // Parameters for indexing through mem
  localparam NUM_ADDR_PER_CHNL    = 12;
  localparam INDX_ADDR_CTLE       = 0;
  localparam NUM_ADDR_CTLE        = 1;
  localparam INDX_ADDR_DFE        = 1;
  localparam NUM_ADDR_DFE         = 11;

  // Calibration status
  localparam ADDR_CALIBRATION     = 10'h103;
  localparam BIT_CALIBRATION      = 5;

  // DFE IP States
  localparam SM_POWERUP           = 4'h0;
  localparam SM_CHECK_CAL_STATUS  = 4'h1;
  localparam SM_IDLE              = 4'h2;
  localparam SM_EXECUTE_RATE_SW   = 4'h3;
  localparam SM_RESTORE_MODEB     = 4'h4;
  localparam SM_TIMEOUT_CTLE      = 4'h5;
  localparam SM_EXECUTE_CTLE      = 4'h6;
  localparam SM_TIMEOUT_DFE       = 4'h7;
  localparam SM_EXECUTE_DFE       = 4'h8;

endpackage
