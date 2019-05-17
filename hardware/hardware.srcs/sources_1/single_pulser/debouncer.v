`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/11/2019 01:43:01 PM
// Design Name: 
// Module Name: debouncer
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


module debouncer (
    output out,
    input clk,
    input in
);

wire targetClk;
reg [3:0] interm;
clockDivisorBundle #(19) cdb(targetClk, clk);
always @(posedge targetClk)
begin
    interm[3] <= interm[2];
    interm[2] <= interm[1];
    interm[1] <= interm[0];
    interm[0] <= in;
end
assign out = interm[0] & interm[1] & interm[2] & interm[3];
endmodule
