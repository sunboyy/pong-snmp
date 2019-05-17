`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/29/2019 02:25:57 PM
// Design Name: 
// Module Name: shiftRegister
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


module shiftRegisterTransmitter(
    output serial,
    input clk, load, shift,
    input [7:0] loadData
);

reg [8:0] q;
wire reset = load & shift;
wire [8:0] ns = reset ? 9'b111111111 :
            load ? {loadData, 1'b0} :
            shift ? {1'b1, q[8:1]} : q;

always @(posedge clk)
    q = ns;

assign serial = q[0];
endmodule
