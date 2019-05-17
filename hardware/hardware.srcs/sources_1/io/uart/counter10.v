`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/29/2019 02:19:27 PM
// Design Name: 
// Module Name: counter10
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


module counter10(
    output count10,
    input clk, increment, reset
);

reg [3:0] count = 0;
always @(posedge clk, posedge reset)
    if (reset)
        count = 0;
    else
        count = (count + increment) % 10;
assign count10 = count == 9;

endmodule
