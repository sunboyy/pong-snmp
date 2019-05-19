`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/19/2019 03:30:11 PM
// Design Name: 
// Module Name: scoreColor
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


module scoreColor(
    output colorATen, colorADigit,
    output colorBTen, colorBDigit,
    input [8:0] x, y,
    input [7:0] scoreA, scoreB
    );

wire [7:0] scoreABcd, scoreBBcd;
hexToBcd htbA(scoreABcd, scoreA);
hexToBcd htbB(scoreBBcd, scoreB);

wire [8:0] locY = y - 20;

scoreMem scoreMemATen(colorATen, x-40, locY, scoreABcd[7:4]);
scoreMem scoreMemADigit(colorADigit, x-56, locY, scoreABcd[3:0]);
scoreMem scoreMemBTen(colorBTen, x-248, locY, scoreBBcd[7:4]);
scoreMem scoreMemBDigit(colorBDigit, x-264, locY, scoreBBcd[3:0]);

endmodule
