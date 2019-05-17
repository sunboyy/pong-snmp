`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/02/2019 10:36:58 PM
// Design Name: 
// Module Name: sevenSegDisplayer
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


module sevenSegDisplayer(
    output [6:0] seg,
    output [3:0] an,
    input clk,
    input [15:0] number
);
wire targetClk;
clockDivisorBundle #(18) cdb(targetClk, clk);

wire [1:0] state;
counter #(2) ct(state, targetClk);

activeLowDecoder #(2) ald(an, state);

wire [3:0] hex;
bitSlicer bs(hex, number, state);
sevenSegDecoder ssd(seg, hex);
endmodule
