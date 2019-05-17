`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/24/2019 11:07:52 AM
// Design Name: 
// Module Name: register
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


module register(
    output [15:0] outA,
    inout [15:0] outB,
    input clk,
    input [4:0] addrA,
    input [4:0] addrB,
    input [4:0] addrD,
    input [15:0] inD,
    input we
);
reg [15:0] mem [31:0];
assign outA = mem[addrA];
assign outB = mem[addrB];
always @(posedge clk)
    if (we)
        mem[addrD] = inD;
endmodule
