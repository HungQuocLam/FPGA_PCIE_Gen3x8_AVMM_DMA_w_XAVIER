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


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

module altpcie_rxm_2_dma_controller_decode # (
    parameter  bar_type_hwtcl = 64
  ) (
      input  [bar_type_hwtcl-1:0] rxm_address_i,
      input  [31:0]  rxm_read_data_wr_ctrl_i,
      input  rxm_read_data_valid_wr_ctrl_i,
      input  [31:0]  rxm_read_data_rd_ctrl_i,
      input  rxm_read_data_valid_rd_ctrl_i,
      input  rxm_wait_request_rd_ctrl_i,
      input  rxm_wait_request_wr_ctrl_i,
      output rxm_read_data_valid_o,
      output [31:0] rxm_read_data_o,
      output chip_select_rdctrl_o,
      output chip_select_wrctrl_o,
      output rxm_wait_request_o
  );

  assign chip_select_wrctrl_o = rxm_address_i[8];
  assign chip_select_rdctrl_o = ~chip_select_wrctrl_o;
  assign rxm_read_data_valid_o = (chip_select_wrctrl_o) ?   rxm_read_data_valid_wr_ctrl_i  : rxm_read_data_valid_rd_ctrl_i;
  assign rxm_read_data_o       = (chip_select_wrctrl_o) ?   rxm_read_data_wr_ctrl_i        : rxm_read_data_rd_ctrl_i;
  assign rxm_wait_request_o    = (chip_select_wrctrl_o) ?   rxm_wait_request_wr_ctrl_i     : rxm_wait_request_rd_ctrl_i;

endmodule