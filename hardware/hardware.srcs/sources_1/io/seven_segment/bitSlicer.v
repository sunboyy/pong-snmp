`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/02/2019 09:59:36 PM
// Design Name: 
// Module Name: bitSlicer
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


module bitSlicer(
    output reg [3:0] out,
    input [15:0] in,
    input [1:0] sel
);
always @(sel, in)
    case (sel)
        0 : out = in[3:0];
        1 : out = in[7:4];
        2 : out = in[11:8];
        3 : out = in[15:12];
    endcase
endmodule
