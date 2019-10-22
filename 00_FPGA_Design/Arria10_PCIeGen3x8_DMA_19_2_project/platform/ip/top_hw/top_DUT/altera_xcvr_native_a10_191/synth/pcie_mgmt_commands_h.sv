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
package pcie_mgmt_commands_h;

localparam  CMD_SIZE  = 5;
localparam  ARG1_SIZE = 32;

localparam  ROM_WIDTH = CMD_SIZE + ARG1_SIZE;

// Define bit offsets within ROM word
localparam  ARG1_OFST = 0;
localparam  CMD_OFST  = ARG1_OFST + ARG1_SIZE;

// Bit field abstractions
localparam  WAIT_OFST       = ARG1_OFST;
localparam  WAIT_SIZE       = ARG1_SIZE;
localparam  REG_OFST        = ARG1_OFST;
localparam  REG_SIZE        = ARG1_SIZE;
localparam  REG_VAL_OFST    = ARG1_OFST;
localparam  REG_VAL_SIZE    = ARG1_SIZE;
localparam  BIT_INDEX_OFST  = ARG1_OFST;
localparam  BIT_INDEX_SIZE  = 5;
localparam  BIT_VAL_OFST    = BIT_INDEX_OFST + BIT_INDEX_SIZE;
localparam  BIT_VAL_SIZE    = 1;
localparam  BIT_INDEX2_OFST = BIT_VAL_OFST + BIT_VAL_SIZE;
localparam  CMP_VAL_OFST    = ARG1_OFST;
localparam  CMP_VAL_SIZE    = ARG1_SIZE;

// Define all the commands
localparam  CMD_HALT              = 5'd0,
            CMD_WAIT              = 5'd1,
            // REG ops
            CMD_LOAD_ADDR         = 5'd2,
            CMD_LOAD_RESULT       = 5'd3,
            CMD_WRITE_REG         = 5'd4,
            CMD_READ_REG          = 5'd5,
            CMD_READ_REG_BIT      = 5'd6,
            CMD_WAIT_REG          = 5'd7,
            CMD_WAIT_REG_BIT      = 5'd8,
            // PIO ops
            CMD_WRITE_PIO_BIT_RES = 5'd9,
            CMD_READ_PIO_BIT      = 5'd10,
            CMD_WAIT_PIO_BIT      = 5'd11,
            // Register ops
            CMD_CMP_RESULT        = 5'd12,
            CMD_JNEZ              = 5'd13,
            //Commands for Read Modified Write
            CMD_MOD               = 5'd14,
            CMD_MASK              = 5'd15,
            //Memory OPs
            CMD_LD_MEM_ADDR       = 5'd16,
            CMD_ST_MEM_ADDR       = 5'd17,
            CMD_LD_REG_FROM_MEM   = 5'd18,
            CMD_LD_MOD_FROM_MEM   = 5'd19,
            CMD_ST_REG_TO_MEM     = 5'd20,
            CMD_INC_MEM_ADDR      = 5'd21,
            //ALU
            CMD_ADD               = 5'd22,
            CMD_SUB               = 5'd23,
            CMD_CONVERT_CTLE      = 5'd24;



`define FUNC_PROTO function [ROM_WIDTH-1:0]

// NOOP
`FUNC_PROTO noop;
  input unused;
  begin
    noop = sleep(0);
  end
endfunction


// Halt function
`FUNC_PROTO halt;
  input unused;
  reg [ROM_WIDTH-1:0] cmd;
  begin
    cmd = {ROM_WIDTH{1'b0}};
    cmd[CMD_OFST+:CMD_SIZE]  = CMD_HALT;
    halt = cmd;
  end
endfunction


// Sleep function waits for the specified number of clocks
`FUNC_PROTO sleep;
  input [WAIT_SIZE-1:0]  clock_cycle_count;
  reg [ROM_WIDTH-1:0] cmd;
  begin
    cmd = {ROM_WIDTH{1'b0}};
    cmd[CMD_OFST+:CMD_SIZE]    = CMD_WAIT;
    cmd[WAIT_OFST+:WAIT_SIZE]  = clock_cycle_count;
    sleep = cmd;
  end
endfunction


// Load a value into the address register
`FUNC_PROTO load_address;
  input [REG_SIZE-1:0]  address;
  reg [ROM_WIDTH-1:0]   cmd;
  begin
    cmd = {ROM_WIDTH{1'b0}};
    cmd[CMD_OFST+:CMD_SIZE] = CMD_LOAD_ADDR;
    cmd[REG_OFST+:REG_SIZE] = address;
    load_address = cmd;
  end
endfunction


// Load a value into the result register
`FUNC_PROTO load_result;
  input [REG_SIZE-1:0]  result;
  reg [ROM_WIDTH-1:0]   cmd;
  begin
    cmd = {ROM_WIDTH{1'b0}};
    cmd[CMD_OFST+:CMD_SIZE] = CMD_LOAD_RESULT;
    cmd[REG_OFST+:REG_SIZE] = result;
    load_result = cmd;
  end
endfunction

// Write the contents of the result register to the the register specified by
// address.
//
// @writedata - Data to be written.
`FUNC_PROTO write_reg;
  input [REG_VAL_SIZE-1:0]  unused;
  reg [ROM_WIDTH-1:0] cmd;
  begin
    cmd = {ROM_WIDTH{1'b0}};
    cmd[CMD_OFST+:CMD_SIZE] = CMD_WRITE_REG;
    write_reg = cmd;
  end
endfunction


// Reads data from the register specified by address
// and stores the read data into the result register
//
// @address - Address of the register to be read.
`FUNC_PROTO read_reg;
  input unused;
  reg [ROM_WIDTH-1:0] cmd;
  begin
    cmd = {ROM_WIDTH{1'b0}};
    cmd[CMD_OFST+:CMD_SIZE]  = CMD_READ_REG;
    read_reg = cmd;
  end
endfunction

//reads the data from the results register, and writes it to the local
//register, using the mask to modify only the correct bits.
//
// @modify_data- data to be written into the scratch register.  
`FUNC_PROTO modify_reg;
  input [REG_VAL_SIZE-1:0] modify_data;
  reg [ROM_WIDTH-1:0] cmd;
  begin
    cmd = {ROM_WIDTH{1'b0}};
    cmd[CMD_OFST+:CMD_SIZE]  = CMD_MOD;
    cmd[REG_VAL_OFST+:REG_VAL_SIZE] = modify_data;
    modify_reg = cmd;
  end
endfunction

//Stores the mask value into a local register specifically for performing
//RMW
//
// @mask_data - the mask for performing RMW
`FUNC_PROTO mask_reg;
  input [REG_VAL_SIZE-1:0] mask_data;
  reg [ROM_WIDTH-1:0] cmd;
  begin
    cmd = {ROM_WIDTH{1'b0}};
    cmd[CMD_OFST+:CMD_SIZE]  = CMD_MASK;
    cmd[REG_VAL_OFST+:REG_VAL_SIZE] = mask_data;
    mask_reg = cmd;
  end
endfunction


// Reads a data bit from the register at the specified
// address and stores it in the result register
`FUNC_PROTO read_reg_bit;
  input   [BIT_INDEX_SIZE-1:0] bit_index;
  reg [ROM_WIDTH-1:0] cmd;
  begin
    cmd = {ROM_WIDTH{1'b0}};
    cmd[CMD_OFST+:CMD_SIZE]  = CMD_READ_REG_BIT;
    cmd[BIT_INDEX_OFST+:BIT_INDEX_SIZE] = bit_index;
    read_reg_bit = cmd;
  end
endfunction


// Wait for register to equal value
`FUNC_PROTO wait_for_reg;
  input   [REG_VAL_SIZE-1:0]  expected_data;
  reg [ROM_WIDTH-1:0] cmd;
  begin
    cmd = {ROM_WIDTH{1'b0}};
    cmd[CMD_OFST+:CMD_SIZE] = CMD_WAIT_REG;
    cmd[REG_VAL_OFST+:REG_VAL_SIZE] = expected_data;
    wait_for_reg = cmd;
  end
endfunction


// Wait for a register bit to be 0 or 1
`FUNC_PROTO wait_for_reg_bit;
  input   [BIT_INDEX_SIZE-1:0] bit_index;
  input   [BIT_VAL_SIZE-1:0]   expected_bit_value;
  reg [ROM_WIDTH-1:0] cmd;
  begin
    cmd = {ROM_WIDTH{1'b0}};
    cmd[CMD_OFST+:CMD_SIZE] = CMD_WAIT_REG_BIT;
    cmd[BIT_INDEX_OFST+:BIT_INDEX_SIZE] = bit_index;
    cmd[BIT_VAL_OFST+:BIT_VAL_SIZE] = expected_bit_value;
    wait_for_reg_bit = cmd;
  end
endfunction

// Write bit from result register to PIO port bit
`FUNC_PROTO write_result_bit_to_pio_bit;
  input [BIT_INDEX_SIZE-1:0]  result_bit_index;
  input [BIT_INDEX_SIZE-1:0]  pio_bit_index;
  reg [ROM_WIDTH-1:0] cmd;
  begin
    cmd = {ROM_WIDTH{1'b0}};
    cmd[CMD_OFST+:CMD_SIZE] = CMD_WRITE_PIO_BIT_RES;
    cmd[BIT_INDEX_OFST+:BIT_INDEX_SIZE] = pio_bit_index;
    cmd[BIT_INDEX2_OFST+:BIT_INDEX_SIZE] = result_bit_index;
    write_result_bit_to_pio_bit = cmd;
  end
endfunction


// Read PIO bit and store value (0 or 1) to internal result register
`FUNC_PROTO read_pio_bit;
  input   [BIT_INDEX_SIZE-1:0]  bit_index;
  reg [ROM_WIDTH-1:0] cmd;
  begin
    cmd = {ROM_WIDTH{1'b0}};
    cmd[CMD_OFST+:CMD_SIZE] = CMD_READ_PIO_BIT;
    cmd[BIT_INDEX_OFST+:BIT_INDEX_SIZE] = bit_index;
    read_pio_bit = cmd;
  end
endfunction


// Wait for a bit on the PIO input to be 0 or 1
`FUNC_PROTO wait_for_pio_bit;
  input   [BIT_INDEX_SIZE-1:0]  bit_index;
  input   [BIT_VAL_SIZE-1:0]    expected_bit_value;
  reg [ROM_WIDTH-1:0] cmd;
  begin
    cmd = {ROM_WIDTH{1'b0}};
    cmd[CMD_OFST+:CMD_SIZE] = CMD_WAIT_PIO_BIT;
    cmd[BIT_INDEX_OFST+:BIT_INDEX_SIZE] = bit_index;
    cmd[BIT_VAL_OFST+:BIT_VAL_SIZE] = expected_bit_value;
    wait_for_pio_bit = cmd;
  end
endfunction


// Compare the value to the result register and staore the compare result
// (0 or 1) in the result register
`FUNC_PROTO compare_result;
  input [CMP_VAL_SIZE-1:0] compare_value;
  reg [ROM_WIDTH-1:0] cmd;
  begin
    cmd = {ROM_WIDTH{1'b0}};
    cmd[CMD_OFST+:CMD_SIZE] = CMD_CMP_RESULT;
    cmd[CMP_VAL_OFST+:CMP_VAL_SIZE] = compare_value;
    compare_result = cmd;
  end
endfunction


// Compare the value in the result register to 0
// If they are equal, continue execution, otherwise, jump to the
// command previously stored by the set_jump_address command.
`FUNC_PROTO jump_not_equal_zero;
  input [CMP_VAL_SIZE-1:0] address;
  reg [ROM_WIDTH-1:0] cmd;
  begin
    cmd = {ROM_WIDTH{1'b0}};
    cmd[CMD_OFST+:CMD_SIZE] = CMD_JNEZ;
    cmd[REG_OFST+:REG_SIZE] = address;
    jump_not_equal_zero = cmd;
  end
endfunction

`FUNC_PROTO add_to_reg;
  input [REG_SIZE-1:0] value;
  reg [ROM_WIDTH-1:0] cmd;
  begin
    cmd = {ROM_WIDTH{1'b0}};
    cmd[CMD_OFST+:CMD_SIZE] = CMD_ADD;
    cmd[REG_OFST+:REG_SIZE] = value;
    add_to_reg = cmd;
  end
endfunction

`FUNC_PROTO convert_ctle;
  input [REG_SIZE-1:0] value;
  reg [ROM_WIDTH-1:0] cmd;
  begin
    cmd = {ROM_WIDTH{1'b0}};
    cmd[CMD_OFST+:CMD_SIZE] = CMD_CONVERT_CTLE;
    cmd[REG_OFST+:REG_SIZE] = value;
    convert_ctle = cmd;
  end
endfunction

`FUNC_PROTO sub_from_reg;
  input [REG_SIZE-1:0] value;
  reg [ROM_WIDTH-1:0] cmd;
  begin
    cmd = {ROM_WIDTH{1'b0}};
    cmd[CMD_OFST+:CMD_SIZE] = CMD_SUB;
    cmd[REG_OFST+:REG_SIZE] = value;
    sub_from_reg = cmd;
  end
endfunction

`FUNC_PROTO inc_mem_address;
  input unused;
  reg [ROM_WIDTH-1:0] cmd;
  begin
    cmd = {ROM_WIDTH{1'b0}};
    cmd[CMD_OFST+:CMD_SIZE] = CMD_INC_MEM_ADDR;
    inc_mem_address = cmd;
  end
endfunction

`FUNC_PROTO load_mem_addr_to_reg;
  input unused;
  reg [ROM_WIDTH-1:0] cmd;
  begin
    cmd = {ROM_WIDTH{1'b0}};
    cmd[CMD_OFST+:CMD_SIZE] = CMD_LD_MEM_ADDR;
    load_mem_addr_to_reg = cmd;
  end
endfunction

`FUNC_PROTO store_reg_to_mem_addr;
  input [REG_SIZE-1:0] address;
  reg [ROM_WIDTH-1:0] cmd;
  begin
    cmd = {ROM_WIDTH{1'b0}};
    cmd[CMD_OFST+:CMD_SIZE] = CMD_ST_MEM_ADDR;
    cmd[REG_OFST+:REG_SIZE] = address;
    store_reg_to_mem_addr = cmd;
  end
endfunction

`FUNC_PROTO wr_to_mem_address;
  input unused;
  reg [ROM_WIDTH-1:0] cmd;
  begin
    cmd = {ROM_WIDTH{1'b0}};
    cmd[CMD_OFST+:CMD_SIZE] = CMD_ST_REG_TO_MEM;
    wr_to_mem_address = cmd;
  end
endfunction

`FUNC_PROTO rd_from_mem_address;
  input unused;
  reg [ROM_WIDTH-1:0] cmd;
  begin
    cmd = {ROM_WIDTH{1'b0}};
    cmd[CMD_OFST+:CMD_SIZE] = CMD_LD_REG_FROM_MEM;
    rd_from_mem_address = cmd;
  end
endfunction

`FUNC_PROTO modify_reg_from_mem_address; 
  input [REG_SIZE-1:0] mask;
  reg [ROM_WIDTH-1:0]  cmd;
  begin
    cmd = {ROM_WIDTH{1'b0}};
    cmd[REG_OFST+:REG_SIZE] = mask;
    cmd[CMD_OFST+:CMD_SIZE] = CMD_LD_MOD_FROM_MEM;
    modify_reg_from_mem_address = cmd;
  end
endfunction

// Log base 2 function for calculating bus widths
function integer clogb2;
  input [31:0] value;
  for (clogb2=0; value>0; clogb2=clogb2+1)
    value = value>>1;
endfunction

endpackage
