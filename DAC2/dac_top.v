`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/23/2025 12:55:15 AM
// Design Name: 
// Module Name: dac_top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module DA2_Top (
input clk,
input rst,
input update,
input [11:0] value0,
input [11:0] value1,
output [1:0] SDATA,
output SYNC,
output SCLK
);
//wire rst;
//wire update;

//wire SCLK;
wire SCLK_en;
da2_dual uut1(
clk,
rst,
//Serial data line
SCLK,
SDATA,
SYNC,
//Enable clock
SCLK_en,
//Output value and mode
2'b00,
2'b00,
//Channel modes: 00 Enabled, Power off modes: 01 1kOhm, 10 100kOhm, 11 High-Z
value0,
value1,
//Control signals
update);

//clock divider
clkDiv25en uut2(
clk,

rst,
SCLK_en,
SCLK);


// vio_0 v(
// .clk(clk), // input wire clk
// .probe_in0(SCLK), // input wire [0 : 0] probe_in0
// .probe_in1(SYNC), // input wire [0 : 0] probe_in1
// .probe_in2(SDATA), // input wire [1 : 0] probe_in2
// .probe_out0(value0), // output wire [11 : 0] probe_out0
// .probe_out1(value1),
// .probe_out2(rst),
// .probe_out3(update) // output wire [11 : 0] probe_out1
//);

endmodule

