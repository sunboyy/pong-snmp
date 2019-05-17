`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/07/2019 09:37:34 PM
// Design Name: 
// Module Name: singlePulser
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


module singlePulser(
    output reg out,
    input clk,
    input in
);
wire syncIn;
debouncer (syncIn, clk, in);
reg [1:0] state = 0;
always @(posedge clk)
    case ({state, syncIn})
        3'b001 : state = 1;
        3'b010 : state = 0;
        3'b011 : state = 2;
        3'b100 : state = 0;
        3'b101 : state = 2;
    endcase
always @(state)
    case (state)
        1 : out = 1;
        default : out = 0;
    endcase
endmodule
