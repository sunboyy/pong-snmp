`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/02/2019 09:02:19 PM
// Design Name: 
// Module Name: clockDivisorBundle
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


module clockDivisorBundle(
    output targetClk,
    input clk
);
parameter depth = 2;
wire [depth:0] intermediateClk;
assign intermediateClk[0] = clk;
assign targetClk = intermediateClk[depth];

genvar i;
for (i=0; i<depth; i=i+1)
begin
    clockDivisor cd(intermediateClk[i+1], intermediateClk[i]);
end
endmodule
