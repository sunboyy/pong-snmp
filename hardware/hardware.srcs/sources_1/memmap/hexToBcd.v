`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/10/2019 07:40:09 PM
// Design Name: 
// Module Name: hexToBcd
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


module hexToBcd(
    output [15:0] bcd,
    input [15:0] hex
);
assign bcd[3:0] = hex % 10;
assign bcd[7:4] = (hex / 10) % 10;
assign bcd[11:8] = (hex / 100) % 10;
assign bcd[15:12] = (hex / 1000) % 10;
endmodule
