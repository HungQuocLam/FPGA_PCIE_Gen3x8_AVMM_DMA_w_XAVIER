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
module pcie_mgmt_cpu #(
    parameter PIO_OUT_SIZE  = 8,          // Width of PIO output port
    parameter PIO_IN_SIZE   = 8,          // Width of PIO input port
    parameter [PIO_OUT_SIZE-1:0] PIO_OUT_INIT_VALUE = 0,  // Initial value for pio_out registers
    parameter ROM_DEPTH     = 512,        // Depth of command ROM
    parameter MEM_DEPTH     = 8,
    parameter ROM_WIDTH     = pcie_mgmt_commands_h::ROM_WIDTH,
    parameter ADDR_WIDTH    = pcie_mgmt_commands_h::clogb2(ROM_DEPTH)
  ) (
  input                           clk,
  input                           reset,

  output  reg                     av_write,
  output  reg                     av_read,
  output  reg [30:0]              av_address,
  output  reg [31:0]              av_writedata,
  input       [31:0]              av_readdata,
  input                           av_waitrequest,

  // Instruction master (ROM interface)
  output  reg [ADDR_WIDTH-1:0]    rom_address,
  output                          rom_read,
  input       [ ROM_WIDTH-1:0]    rom_data,

  output  reg [PIO_OUT_SIZE-1:0]  pio_out,
  input       [ PIO_IN_SIZE-1:0]  pio_in
);

import pcie_mgmt_commands_h::*;  // Contains low-level instructions

integer i;
localparam  ST_FETCH      = 0,  // Fetching and decoding command
            ST_WAIT       = 1,  // Waiting for a number of clock cycles
            ST_WRITE_REG  = 2,  // Writing to an avalon register
            ST_READ_REG   = 3,  // Reading from an avalon register
            ST_WAIT_PIO   = 4,  // Reading from the PIO input
            ST_HALT       = 5;  // HALT, no more commands

// State machine signals
reg   [ 2:0]  state;
reg   [ 2:0]  next_state;
reg   [31:0]  wait_count;
wire          wait_done;
wire          read_reg_done;

// ROM operands
wire  [CMD_SIZE-1:0]        rom_cmd;
wire  [REG_VAL_SIZE-1:0]    reg_val;
wire  [REG_VAL_SIZE-1:0]    mask_val;
wire  [REG_SIZE-1:0]        reg_addr;
wire  [BIT_INDEX_SIZE-1:0]  bit_index;
wire  [BIT_INDEX_SIZE-1:0]  bit_index2;
wire                        bit_val;
wire  [WAIT_SIZE-1:0]       wait_val;
wire  [CMP_VAL_SIZE-1:0]    cmp_val;

// Internal signals
reg                         cmd_done;
wire                        reg_match;
wire                        reg_bit_match;
wire                        pio_bit_match;
wire  [REG_VAL_SIZE-1:0]    mem_data;
reg   [REG_VAL_SIZE-1:0]    r0;
reg   [REG_VAL_SIZE-1:0]    mem_addr;
reg   [REG_VAL_SIZE-1:0]    mask = {REG_VAL_SIZE{1'b0}};
reg   [REG_VAL_SIZE-1:0]    cpu_memory  [0:MEM_DEPTH-1];

//*********************************************************************
//************************ Command ROM ********************************
assign  rom_read  = cmd_done | reset;
//********************** End Command ROM ******************************
//*********************************************************************

//*********************************************************************
//**************** Extract Operands From ROM Data *********************
assign  rom_cmd   = rom_data[CMD_OFST+:CMD_SIZE];
assign  reg_addr  = rom_data[REG_OFST+:REG_SIZE];
assign  wait_val  = rom_data[WAIT_OFST+:WAIT_SIZE];

assign  reg_val   = rom_data[REG_VAL_OFST+:REG_VAL_SIZE];
assign  mask_val  = rom_data[REG_VAL_OFST+:REG_VAL_SIZE];
assign  bit_index = rom_data[BIT_INDEX_OFST+:BIT_INDEX_SIZE];
assign  bit_index2= rom_data[BIT_INDEX2_OFST+:BIT_INDEX_SIZE];
assign  bit_val   = rom_data[BIT_VAL_OFST+:BIT_VAL_SIZE];

assign  cmp_val   = rom_data[CMP_VAL_OFST+:CMP_VAL_SIZE];
//************** End Extract Operands From ROM Data *******************
//*********************************************************************


//*********************************************************************
//************************ Internal Signals ***************************
// Matches
assign  reg_match     = (av_readdata  == reg_val);
assign  reg_bit_match = (av_readdata[bit_index] == bit_val);
assign  pio_bit_match = (pio_in     [bit_index] == bit_val);
// Done flags
assign  wait_done     = !wait_count;
assign  read_reg_done = (rom_cmd == CMD_WAIT_REG)     ? reg_match :
                        (rom_cmd == CMD_WAIT_REG_BIT) ? reg_bit_match :
                        1'b1;

always @* begin
  case(state)
      ST_FETCH:
        case(rom_cmd)
          CMD_LOAD_ADDR,
          CMD_LOAD_RESULT,
          CMD_WRITE_PIO_BIT_RES,
          CMD_READ_PIO_BIT,
          //--self
          CMD_MOD,
          CMD_MASK,
          CMD_LD_MEM_ADDR,
          CMD_ST_MEM_ADDR,
          CMD_ST_REG_TO_MEM,
          CMD_LD_REG_FROM_MEM,
          CMD_LD_MOD_FROM_MEM,
          CMD_INC_MEM_ADDR,
          CMD_ADD,
          CMD_CONVERT_CTLE,
          CMD_SUB,
          CMD_CMP_RESULT:
                        cmd_done  = 1'b1;
          default:      cmd_done  = 1'b0;

        endcase
      ST_WAIT:          cmd_done  = wait_done;
      ST_WRITE_REG:     cmd_done  = !av_waitrequest;
      ST_READ_REG:      cmd_done  = !av_waitrequest & read_reg_done;
      ST_WAIT_PIO:      cmd_done  = pio_bit_match;
      default:          cmd_done  = 1'b0;
  endcase
end
//************************ Internal Signals ***************************
//*********************************************************************


//*********************************************************************
//************************ State Machine ******************************
// State decoder
always @(posedge clk or posedge reset)
  if(reset)                   state <= ST_FETCH;
  else if(state == ST_FETCH)  state <= next_state;
  else if(cmd_done)           state <= next_state;

always @*
  begin
    case(state)
      // Get next command
      ST_FETCH:
        case(rom_cmd)
          CMD_HALT:         next_state  = ST_HALT;

          CMD_WRITE_REG:    next_state  = ST_WRITE_REG;

          CMD_READ_REG,
          CMD_READ_REG_BIT,
          CMD_WAIT_REG,
          CMD_WAIT_REG_BIT: next_state  = ST_READ_REG;

          CMD_WAIT_PIO_BIT: next_state  = ST_WAIT_PIO;

          CMD_JNEZ,
          CMD_WAIT:         next_state  = ST_WAIT;
          default:          next_state  = state;

        endcase
      // Wait
      ST_WAIT:              next_state  = ST_FETCH;
      // Write
      ST_WRITE_REG:         next_state  = ST_FETCH;
      // Read register
      ST_READ_REG:          next_state  = ST_FETCH;
      // Read the PIO port
      ST_WAIT_PIO:          next_state  = ST_FETCH;
      // HALT!(remain here)
      ST_HALT:              next_state  = ST_HALT;
      default:              next_state  = state;
    endcase
  end
//********************** End State Machine ****************************
//*********************************************************************


//*********************************************************************
//*********************** Output Encoders *****************************

// Registers changing only on fetch
always @(posedge clk or posedge reset)
  if(reset)
                        rom_address <= {ADDR_WIDTH{1'b0}};
  else if((state == ST_FETCH) & (rom_cmd == CMD_JNEZ) & |r0)
                        rom_address <= reg_addr[0+:ADDR_WIDTH];
  else if(cmd_done)
                        rom_address <= rom_address + { {(ADDR_WIDTH-1){1'b0}}, 1'b1};


// Avalon interface decoder
always @(posedge clk or posedge reset)
  if(reset) begin
                        av_write    <= 1'b0;
                        av_read     <= 1'b0;
                        av_address  <= 31'd0;
                        av_writedata<= 32'd0;
  end else begin
    case(state)
      // Get next command
      ST_FETCH: begin
        case(rom_cmd)
          CMD_LOAD_ADDR:
                        av_address  <= reg_addr[30:0];

          CMD_WRITE_REG: begin
                        av_write    <= 1'b1;
                        av_writedata<= r0;
          end
          CMD_READ_REG,
          CMD_READ_REG_BIT,
          CMD_WAIT_REG,
          CMD_WAIT_REG_BIT:
                        av_read     <= 1'b1;
        endcase
      end
      // Write
      ST_WRITE_REG:     av_write    <= ~cmd_done;
      // Read register
      ST_READ_REG:      av_read     <= ~cmd_done;
    endcase
  end


// Wait counter
always @(posedge clk or posedge reset)
  if(reset)             wait_count  <= 32'd0;
  else if((state == ST_FETCH) && (rom_cmd == CMD_WAIT))
                        wait_count  <= wait_val;
  else if((state == ST_WAIT) && !cmd_done)
                        wait_count  <= wait_count + 32'hffffffff;


// pio_out decoder
always @(posedge clk or posedge reset)
  if(reset)             pio_out     <= PIO_OUT_INIT_VALUE[0+:PIO_OUT_SIZE];
  else if(state == ST_FETCH) begin
    if(rom_cmd == CMD_WRITE_PIO_BIT_RES)
                        pio_out[bit_index]  <= r0[bit_index2];
  end

// Error decoder
assign mem_data = cpu_memory[mem_addr];
always @(posedge clk or posedge reset)
  if(reset) begin
    r0          <= {REG_VAL_SIZE{1'b0}};
    mask        <= {REG_VAL_SIZE{1'b0}};
    mem_addr    <= {REG_VAL_SIZE{1'b0}};
    for( i = 0; i < MEM_DEPTH; i = i + 1 ) begin
      cpu_memory[i]  <= 'd0;
    end
  end else begin
    for( i = 0; i < MEM_DEPTH; i = i + 1 ) begin
      cpu_memory[i]  <= cpu_memory[i];
    end

    case(state)
      ST_FETCH:
        if(rom_cmd == CMD_CMP_RESULT) begin
                        r0    <= {CMP_VAL_SIZE{1'b0}};
                        r0[0] <= (r0 == cmp_val) ? 1'b0 : 1'b1;
        end else if(rom_cmd == CMD_LOAD_RESULT) begin
                        r0    <= reg_val;
        end else if(rom_cmd == CMD_READ_PIO_BIT) begin
                        r0    <= {{REG_VAL_SIZE-1{1'b0}},pio_in[bit_index]};
        end else if(rom_cmd == CMD_MASK) begin
                        //Stores the mask in a local register.
                        mask <= mask_val;
        end else if(rom_cmd == CMD_MOD) begin
                          r0 <= ((mask & reg_val) | (~mask & r0));
        end else if(rom_cmd == CMD_ADD) begin
                        r0    <=  r0+reg_val;
        end else if(rom_cmd == CMD_CONVERT_CTLE) begin
                        r0    <=  (mem_data[3:1] == 3'b111) ? {r0[REG_VAL_SIZE-1:6],5'b11100,r0[0]} : {r0[REG_VAL_SIZE-1:6],mem_data[3:0],1'b0,r0[0]};
        end else if(rom_cmd == CMD_SUB) begin
                        r0    <=  r0-reg_val;
        end else if(rom_cmd == CMD_LD_MEM_ADDR) begin
                        r0    <=  mem_addr;
        end else if(rom_cmd == CMD_ST_MEM_ADDR) begin
                        mem_addr <= r0;    
        end else if(rom_cmd == CMD_INC_MEM_ADDR) begin
                        mem_addr <= mem_addr + 32'b1;
        end else if(rom_cmd == CMD_LD_REG_FROM_MEM) begin
                        r0    <= mem_data;
        end else if(rom_cmd == CMD_LD_MOD_FROM_MEM) begin
                        r0    <= ((mask_val & mem_data) | (~mask_val & r0));
        end else if(rom_cmd == CMD_ST_REG_TO_MEM) begin
                        cpu_memory[mem_addr]  <=  r0;
        end


      ST_READ_REG:
        if(cmd_done)
          if(rom_cmd == CMD_READ_REG_BIT)
                        r0  <= {{REG_VAL_SIZE-1{1'b0}},av_readdata[bit_index]};
          else
                        r0  <= av_readdata;
      ST_WAIT_PIO:
                        r0  <= {{REG_VAL_SIZE-1{1'b0}},pio_in[bit_index]};
    endcase
  end
//********************* End Output Encoders ***************************
//*********************************************************************

endmodule
