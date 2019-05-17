`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/23/2019 10:00:47 PM
// Design Name: 
// Module Name: alu
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


module alu(
    output [15:0] out,
    output reg [1:0] flag,
    input clk,
    input [15:0] a, b,
    input [3:0] mode,
    input oe,
    input saveFlag
);
reg [15:0] result;
assign out = oe ? result : 16'bZ;
always @(a, b, mode)
    case (mode)
        1 : result = a + b;
        2 : result = a - b;
        3 : result = a * b;
        4 : result = a / b;
        5 : result = a % b;
        6 : result = a & b;
        7 : result = a | b;
        8 : result = a ^ b;
        9 : result = ~a;
        10 : result = -a;
        11 : result = a << b;
        12 : result = a >> b;
        default : result = a;
    endcase
always @(posedge clk)
    if (saveFlag)
        flag = {a < b, a == b};
endmodule
