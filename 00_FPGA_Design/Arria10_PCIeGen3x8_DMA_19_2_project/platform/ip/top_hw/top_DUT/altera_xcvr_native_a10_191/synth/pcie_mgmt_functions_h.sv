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
package pcie_mgmt_functions_h;


import pcie_mgmt_commands_h::*;

localparam  MAX_LABEL = 512;
localparam  MAX_DEPTH = 4096;

typedef struct 
{
  integer             rom_labels[0:(MAX_LABEL-1)];  // Label address
  integer             rom_i;
  integer             clocks_per_second;  // Must be set from outside
  logic [ROM_WIDTH-1:0] prog_rom  [0:(MAX_DEPTH-1)]; // Command storage ROM
} prom_struct_t;

task automatic set_clocks_per_second;
  input integer new_clocks_per_second;
  ref prom_struct_t prom_set;
  begin
    prom_set.clocks_per_second = new_clocks_per_second;
  end
endtask


task automatic f_noop;
  ref prom_struct_t prom_set;
    begin
    prom_set.prog_rom[prom_set.rom_i]= sleep(0);
    prom_set.rom_i=prom_set.rom_i+1;
  end
endtask

// Halt function
// Required as last instruction in ROM. Instructs the command
// processor to halt execution indefinitely.
//
// @param unused - An unused but required value.
task automatic f_halt;
  ref prom_struct_t prom_set;
    begin
    prom_set.prog_rom[prom_set.rom_i]= halt(0);
    prom_set.rom_i=prom_set.rom_i+1;
  end
endtask

// Sleep function
// Pauses execution for the number of clock cycles specified
// by the parameter "ticks"
//
// @param ticks - The number of clock cycles to sleep
task automatic f_sleep;
  input [WAIT_SIZE-1:0] ticks;
  ref prom_struct_t prom_set;
    begin
    prom_set.prog_rom[prom_set.rom_i]= sleep(ticks);
    prom_set.rom_i=prom_set.rom_i+1;
  end
endtask

task automatic f_convert_ctle;
  ref prom_struct_t prom_set;
    begin
    prom_set.prog_rom[prom_set.rom_i]= convert_ctle(0);
    prom_set.rom_i=prom_set.rom_i+1;
  end
endtask

task automatic f_add_to_reg;
  input [REG_SIZE-1:0] value;
  ref prom_struct_t prom_set;
    begin
    prom_set.prog_rom[prom_set.rom_i]= add_to_reg(value);
    prom_set.rom_i=prom_set.rom_i+1;
  end
endtask

task automatic f_mod_mem_value;
  input [REG_SIZE-1:0] mask;
  ref prom_struct_t prom_set;
    begin
    prom_set.prog_rom[prom_set.rom_i]=modify_reg_from_mem_address(mask);
    prom_set.rom_i=prom_set.rom_i+1;
  end
endtask

task automatic f_sub_from_reg;
  input [REG_SIZE-1:0] value;
  ref prom_struct_t prom_set;
    begin
    prom_set.prog_rom[prom_set.rom_i]= sub_from_reg(value);
    prom_set.rom_i=prom_set.rom_i+1;
  end
endtask

task automatic f_inc_mem_address;
  ref prom_struct_t prom_set;
    begin
    prom_set.prog_rom[prom_set.rom_i]= inc_mem_address(0);
    prom_set.rom_i=prom_set.rom_i+1;
  end
endtask

task automatic f_load_mem_address;
  ref prom_struct_t prom_set;
    begin
    prom_set.prog_rom[prom_set.rom_i]= load_mem_addr_to_reg(0);
    prom_set.rom_i=prom_set.rom_i+1;
  end
endtask

task automatic f_store_mem_address;
  ref prom_struct_t prom_set;
    begin
    prom_set.prog_rom[prom_set.rom_i]= store_reg_to_mem_addr(0);
    prom_set.rom_i=prom_set.rom_i+1;
  end
endtask

task automatic f_st_reg_to_address;
  ref prom_struct_t prom_set;
    begin
    prom_set.prog_rom[prom_set.rom_i]= wr_to_mem_address(0);
    prom_set.rom_i=prom_set.rom_i+1;
  end
endtask

task automatic f_ld_address_to_reg;
  ref prom_struct_t prom_set;
    begin
    prom_set.prog_rom[prom_set.rom_i]= rd_from_mem_address(0);
    prom_set.rom_i=prom_set.rom_i+1;
  end
endtask

// Micro-sleep function
// Pauses execution for the number of microseconds specified
// by the parameter "usecs"
//
// @param usecs - The number of microseconds to sleep.
task automatic f_usleep;
  input integer usecs;
  ref prom_struct_t prom_set;
    reg [WAIT_SIZE-1:0] ticks;
  begin
    ticks = (prom_set.clocks_per_second / 1000000) * usecs;
    f_sleep(ticks, prom_set);
  end
endtask


// Load the internal result register with the value
// specified.
//
// @param datain - The value to be loaded to the internal result
//                register
task automatic f_load_result;
  input [REG_SIZE-1:0]  datain;
  ref prom_struct_t prom_set;
    begin
    prom_set.prog_rom[prom_set.rom_i]= load_result(datain);
    prom_set.rom_i=prom_set.rom_i+1;
  end
endtask

// Write result to register function
// Writes the data stored in the internal result register to the
// register specified by the parameter "address".
//
// @param address - Address of the register to write
task automatic f_write_result_to_reg;
  input [REG_SIZE-1:0]  address;
  ref prom_struct_t prom_set;
    begin
    prom_set.prog_rom[prom_set.rom_i]= load_address(address);
    prom_set.rom_i=prom_set.rom_i+1;
    prom_set.prog_rom[prom_set.rom_i]= write_reg(0);
    prom_set.rom_i=prom_set.rom_i+1;
  end
endtask


// Write register function
// Writes the data specified by the parameter "writedata" to the
// register specified by the parameter "address". First stores
// the writedata in the internal result register then writes it
// to the the specified address.
//
// @param address - Address of the register to write
// @param writedata - Data to be written to register
task automatic f_write_reg;
  input [REG_SIZE-1:0]      address;
  input [REG_VAL_SIZE-1:0]  writedata;
  ref prom_struct_t prom_set;
    begin
    f_load_result(writedata, prom_set);
    f_write_result_to_reg(address, prom_set);
  end
endtask


//Modifies the value of the results register with the value of the
//you with to write to the address.  Specify two values.  The first
//is used to mask the data register, and the second is the data value
//itself.  A 1 in the mask specifies that bit to be written from the data
//value.  A 0 in the mask specifies that bit to be igrored. ie recycled.
//
//@param mask_data - 32-bit mask for RMW
//@param modify_data - 32-bt data value for the register
//
//Use: f_modify_reg(mask_data, modify_data);
task automatic f_modify_reg;
  input [REG_VAL_SIZE-1:0]  mask_data;
  input [REG_VAL_SIZE-1:0]  modify_data;
  ref prom_struct_t prom_set;
    begin
    prom_set.prog_rom[prom_set.rom_i]= mask_reg(mask_data);
    prom_set.rom_i=prom_set.rom_i+1;
    prom_set.prog_rom[prom_set.rom_i]= modify_reg(modify_data);
    prom_set.rom_i=prom_set.rom_i+1;
  end
endtask


// Read register function
// Reads data from the register specified by the parameter "address"
// and stores the value in the internal result register.
//
// @param address - Address of the register to read
task automatic f_read_reg;
  input [REG_SIZE-1:0]  address;
  ref prom_struct_t prom_set;
    begin
    prom_set.prog_rom[prom_set.rom_i]= load_address(address);
    prom_set.rom_i=prom_set.rom_i+1;
    prom_set.prog_rom[prom_set.rom_i]= read_reg(0);
    prom_set.rom_i=prom_set.rom_i+1;
  end
endtask

// Read register bit function
// Reads data from the register specified by the parameter "address"
// and stores the value of the bit within the register specified by
// the parameter "bit_index" in the internal result register.
//
// @param address - Address of the register to read
// @param bit_index - Index of the bit within the register to read
task automatic f_read_reg_bit;
  input [REG_SIZE-1:0]        address;
  input [BIT_INDEX_SIZE-1:0]  bit_index;
  ref prom_struct_t prom_set;
    begin
    prom_set.prog_rom[prom_set.rom_i]= load_address(address);
    prom_set.rom_i=prom_set.rom_i+1;
    prom_set.prog_rom[prom_set.rom_i]= read_reg_bit(bit_index);
    prom_set.rom_i=prom_set.rom_i+1;
  end
endtask


// Wait for register function
// Continuously reads data from the register specified by the parameter
// "address" and waits until the register's value equals the value
// specified by parameter "expected_data" before continuing execution.
// The value of the register is stored in the internal result register.
//
// @param address - Address of the register to read (and wait for)
// @param expected_data - Value to wait for the register to equal.
task automatic f_wait_for_reg;
  input [REG_SIZE-1:0]      address;
  input [REG_VAL_SIZE-1:0]  expected_data;
  ref prom_struct_t prom_set;
    begin
    prom_set.prog_rom[prom_set.rom_i]= load_address(address);
    prom_set.rom_i=prom_set.rom_i+1;
    prom_set.prog_rom[prom_set.rom_i]= wait_for_reg(expected_data);
    prom_set.rom_i=prom_set.rom_i+1;
  end
endtask

// Wait for register bit function
// Continuously reads data from the register specified by the parameter
// "address" and waits until the value of the bit specified by "bit_index"
// equals the value specified by the parameter "expected_data" (0 or 1).
//
// @param address - Address of the register to read (and wait for).
// @param bit_index - Index of the bit within the register to read.
task automatic f_wait_for_reg_bit;
  input [REG_SIZE-1:0]        address;
  input [BIT_INDEX_SIZE-1:0]  bit_index;
  input [REG_VAL_SIZE-1:0]    expected_data;
  ref prom_struct_t prom_set;
    begin
    prom_set.prog_rom[prom_set.rom_i]= load_address(address);
    prom_set.rom_i=prom_set.rom_i+1;
    prom_set.prog_rom[prom_set.rom_i]= wait_for_reg_bit(bit_index, expected_data);
    prom_set.rom_i=prom_set.rom_i+1;
  end
endtask


// Write bit from result register to PIO output bit
// Reads a bit specified by the parameter "result_bit_index" within the
// internal result register and writes the value to the PIO output port bit
// specified by the parameter "pio_bit_index".
//
// @param result_bit_index - Index of the bit within the internal result
// register.
// @param pio_bit_index - Index of the bit within the PIO output port to write
// to.
task automatic f_write_result_bit_to_pio_bit;
  input [BIT_INDEX_SIZE-1:0]  result_bit_index;
  input [BIT_INDEX_SIZE-1:0]  pio_bit_index;
  ref prom_struct_t prom_set;
    begin
    prom_set.prog_rom[prom_set.rom_i]= write_result_bit_to_pio_bit(result_bit_index, pio_bit_index);
    prom_set.rom_i=prom_set.rom_i+1;
  end
endtask


// Write PIO bit function
// Writes the value specified by the parameter "bit_value" (0 or 1) to
// the PIO output bit specified by the parameter "bit_index". First
// writes the value to the internal result register then writes it to the
// PIO.
//
// @param bit_index - The bit within the PIO output port to write to.
// @param bit_value - The value to write to the PIO output bit.
task automatic f_write_pio_bit;
  input [BIT_INDEX_SIZE-1:0]  bit_index;
  input [BIT_VAL_SIZE-1:0]    bit_value;
  ref prom_struct_t prom_set;
    begin
    f_load_result(bit_value, prom_set);
    f_write_result_bit_to_pio_bit(0, bit_index, prom_set);
  end
endtask


// Read PIO bit function
// Reads a bit from the PIO input port and stores the value (0 or 1) into the
// internal result register.
//
// @param bit_index - Index of bit within the PIO input port to read.
task automatic f_read_pio_bit;
  input [BIT_INDEX_SIZE-1:0]  bit_index;
  ref prom_struct_t prom_set;
    begin
    prom_set.prog_rom[prom_set.rom_i]= read_pio_bit(bit_index);
    prom_set.rom_i=prom_set.rom_i+1;
  end
endtask

//  Wait for PIO bit function
//  Continuously reads the value of the bit specified by the parameter
//  "bit_index" within the PIO input port and waits for the value of the
//  bit to be equal to the value specified by the parameter
//  "expected_bit_value" before continuing execution.
//
//  @param bit_index - Index of bit within the PIO input port to read.
//  @param expected_bit_value - Expected value of the bit on the PIO
//  input port
task automatic f_wait_for_pio_bit;
  input [BIT_INDEX_SIZE-1:0]  bit_index;
  input [BIT_VAL_SIZE-1:0]    expected_bit_value;
  ref prom_struct_t prom_set;
    begin
    prom_set.prog_rom[prom_set.rom_i]= wait_for_pio_bit(bit_index, expected_bit_value);
    prom_set.rom_i=prom_set.rom_i+1;
  end
endtask

// Compare result function
// Compares the contents of the internal result register to the value
// specified by the parameter "compare_value". Stores the result (1 for
// no-match, 0 for match) in the internal result register.
//
// @param compare_value. The value to compare with the internal result
// register.
task automatic f_compare_result;
  input [CMP_VAL_SIZE-1:0]  compare_value;
  ref prom_struct_t prom_set;
    begin
    prom_set.prog_rom[prom_set.rom_i]= compare_result(compare_value);
    prom_set.rom_i=prom_set.rom_i+1;
  end
endtask


// Set a label which can be subsequently jumped to.
//
// @param label - The integer label to assign as an identifier.
task automatic f_label;
  input integer label;
  ref prom_struct_t prom_set;
  begin
    if(prom_set.rom_labels[label] != -1)
      $display("[f_label] ERROR - Duplicate label %0d! at address %0d", label, prom_set.rom_i);
    else if(label < MAX_LABEL && label >= 0)
      prom_set.rom_labels[label] = prom_set.rom_i;
    else
      $display("[f_label] ERROR - Invalid label: %0d!, must be between 0<=MAX_LABEL", label);
  end
endtask

// jump-not-equal-zero instruction
// Compares the contents of the internal result register to 0. If the
// contents are 0, program execution continues, otherwise the program
// jumps to the indicated label which was set by a previous set_label command
task automatic f_jump_not_equal_zero;
  input integer label;
  ref prom_struct_t prom_set;
    begin
    if(label > MAX_LABEL || label < 0)
      $display("[mgmt_master] ERROR - Invalid jump label %0d!, must be between 0<=MAX_LABEL", label);
    begin
      prom_set.prog_rom[prom_set.rom_i]= jump_not_equal_zero(label);
      prom_set.rom_i=prom_set.rom_i+1;
    end
  end
endtask


task automatic pre_process;
  ref prom_struct_t prom_set;
  integer i;
  begin
    // Initialize ROM with HALT instructions
    for(i=0;i<MAX_DEPTH;i=i+1) begin
      prom_set.prog_rom[i] = halt(0);
    end
    // Initialize ROM labels (0 is an invalid address)
    for(i=0;i<MAX_LABEL;i=i+1) begin
      prom_set.rom_labels[i] = -1;
    end

    prom_set.rom_i = 0;
    f_noop(prom_set);         // First instruction is a NOOP
  end
endtask

// The post process task resolves code labels and jump instructions
task automatic post_process;
  
  ref prom_struct_t prom_set;
    integer i;
    integer label;
  begin
    for(i=0;i<MAX_DEPTH;i=i+1) begin
      label = prom_set.prog_rom[i][REG_VAL_OFST+:REG_VAL_SIZE];
      if(prom_set.prog_rom[i][CMD_OFST+:CMD_SIZE] == CMD_JNEZ) begin
        if(prom_set.rom_labels[label] == -1) begin
          $display("[post_process] ERROR - Invalid jump label %0d at address %0d. Label not initialized!", label, i);
        end else begin
          prom_set.prog_rom[i]= jump_not_equal_zero(prom_set.rom_labels[label]);
        end
      end
    end
  end
endtask


endpackage
