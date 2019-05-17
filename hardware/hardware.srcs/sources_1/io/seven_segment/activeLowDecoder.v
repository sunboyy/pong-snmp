`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/02/2019 09:21:42 PM
// Design Name: 
// Module Name: activeLowDecoder
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


module activeLowDecoder #(parameter width = 2) (
    output [2**width-1:0] out,
    input [width-1:0] in
);
assign out = ~(1 << in);
endmodule
