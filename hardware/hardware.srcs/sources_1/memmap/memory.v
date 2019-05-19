`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/23/2019 09:32:56 PM
// Design Name: 
// Module Name: memory
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


module memory (
    inout [15:0] d,
    input clk,
    input [12:0] addr,
    input oe, we
);
reg [15:0] mem [0:8191];
assign d = oe ? mem[addr] : 16'bZ;

initial $readmemb("program.mem", mem);
always @(posedge clk)
    if (we)
        mem[addr] = d;
endmodule
