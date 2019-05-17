`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/12/2019 03:48:20 PM
// Design Name: 
// Module Name: stackZ
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


module stackZ(
    inout [15:0] data,
    input clk, push, pop, reset
);
wire [15:0] dataOut;
assign data = pop ? dataOut : 16'bZ;
stack st(dataOut, clk, push, pop, data, reset);
endmodule
