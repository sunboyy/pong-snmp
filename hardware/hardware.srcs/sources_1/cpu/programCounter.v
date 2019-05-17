`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/24/2019 11:21:05 AM
// Design Name: 
// Module Name: programCounter
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


module programCounter(
    output [15:0] addrOut,
    input clk,
    input [15:0] addrIn,
    input oe, jmp, up, call, ret, branch, reset,
    //temp
    output [15:0] pc
);
reg [15:0] mem = 0;
assign pc = mem; //temp
assign addrOut = oe ? mem : 16'bZ;
wire [15:0] tos;
stack st(tos, clk, call, ret, mem, reset);
always @(posedge clk, posedge reset)
    if (reset)
        mem = 0;
    else
        if (up)
            mem = mem + 1;
        else if (jmp | call)
            mem = addrIn;
        else if (ret)
            mem = tos;
        else if (branch)
            mem = mem + addrIn;
endmodule
