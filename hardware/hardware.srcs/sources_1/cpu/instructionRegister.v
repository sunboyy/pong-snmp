`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/24/2019 12:23:48 PM
// Design Name: 
// Module Name: instructionRegister
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


module instructionRegister(
    output reg [31:0] out,
    input clk,
    input [15:0] data,
    input weMSB,
    input weLSB
);
initial out = 0;
always @(posedge clk)
begin
    if (weMSB)
        out[31:16] = data;
    if (weLSB)
        out[15:0] = data;
end
endmodule
