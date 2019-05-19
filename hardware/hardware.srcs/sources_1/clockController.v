`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/24/2019 07:05:30 PM
// Design Name: 
// Module Name: clockController
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


module clockController(
    output targetClk,
    input clk,
    input trigger,
    input auto
);
wire dividedClk;
clockDivisorBundle #(10) cdb(dividedClk, clk);
assign targetClk = auto ? dividedClk : trigger;
endmodule
