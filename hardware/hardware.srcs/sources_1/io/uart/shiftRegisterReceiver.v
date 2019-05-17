`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/29/2019 05:19:35 PM
// Design Name: 
// Module Name: shiftRegisterReceiver
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


module shiftRegisterReceiver(
    output [7:0] out,
    input clk, shift, RsRx
);

reg [9:0] data = 0;
wire [9:0] ns = shift ? {RsRx, data[9:1]} : data;
always @(posedge clk)
    data = ns;
assign out = data[8:1];

endmodule
