`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/02/2019 09:01:07 PM
// Design Name: 
// Module Name: clockDivisor
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


module clockDivisor(
    output reg outputClk,
    input clk
);
initial outputClk = 0;
always @(posedge clk)
    outputClk = ~outputClk;
endmodule
