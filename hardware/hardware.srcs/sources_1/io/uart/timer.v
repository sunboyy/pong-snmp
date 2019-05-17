`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/29/2019 01:59:54 PM
// Design Name: 
// Module Name: clockDivisor9600
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


module timer(
    output nextBit,
    input clk, reset
);
parameter MAX_COUNT = 10417;

reg [24:0] counter = 0;
always @(posedge clk, posedge reset)
    if (reset)
        counter = 0;
    else
        counter = (counter + 1) % MAX_COUNT;

assign nextBit = counter == MAX_COUNT / 2;

endmodule
