`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/23/2019 10:21:34 PM
// Design Name: 
// Module Name: outSevenSegment
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


module sevenSegRegister(
    output [6:0] seg,
    output [3:0] an,
    input clk,
    input realClk,
    input [15:0] data,
    input weAll, we3, we2, we1, we0, weDec,
    input reset
);
reg [15:0] mem;
wire [15:0] bcdData;
hexToBcd htb(bcdData, data);
always @(posedge clk, posedge reset)
    if (reset)
        mem = 0;
    else if (weAll)
        mem = data;
    else if (we3)
        mem[15:12] = data[3:0];
    else if (we2)
        mem[11:8] = data[3:0];
    else if (we1)
        mem[7:4] = data[3:0];
    else if (we0)
        mem[3:0] = data[3:0];
    else if (weDec)
        mem = bcdData;
sevenSegDisplayer ssdp(seg, an, realClk, mem);
endmodule
