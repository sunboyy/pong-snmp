`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/05/2019 10:59:10 AM
// Design Name: 
// Module Name: vgaMemory
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


module vgaMemory(
    output vgaColor,
    inout [15:0] data,
    input clk,
    input [15:0] addr,
    input [9:0] vgaX, vgaY,
    input oe, we
);
reg [15:0] mem [0:8191];
assign data = oe ? mem[addr] : 16'bZ;

always @(posedge clk)
    if (we)
        mem[addr] = data;

wire [8:0] vgaXMem = vgaX[9:1];
wire [8:0] vgaYMem = vgaY[9:1];
wire [13:0] loc = vgaYMem * 20 + vgaXMem[8:4];
wire [3:0] idx = 15 - vgaXMem[3:0];
assign vgaColor = mem[loc] >> idx;
endmodule
