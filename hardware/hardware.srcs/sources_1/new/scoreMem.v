`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/19/2019 05:14:11 PM
// Design Name: 
// Module Name: scoreMem
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


module scoreMem(
    output reg color,
    input [8:0] x,
    input [8:0] y,
    input [3:0] number
    );
    
reg [0:15] number0 [0:23];
reg [0:15] number1 [0:23];
reg [0:15] number2 [0:23];
reg [0:15] number3 [0:23];
reg [0:15] number4 [0:23];
reg [0:15] number5 [0:23];
reg [0:15] number6 [0:23];
reg [0:15] number7 [0:23];
reg [0:15] number8 [0:23];
reg [0:15] number9 [0:23];

initial
begin
    $readmemb("number_0.mem", number0);
    $readmemb("number_1.mem", number1);
    $readmemb("number_2.mem", number2);
    $readmemb("number_3.mem", number3);
    $readmemb("number_4.mem", number4);
    $readmemb("number_5.mem", number5);
    $readmemb("number_6.mem", number6);
    $readmemb("number_7.mem", number7);
    $readmemb("number_8.mem", number8);
    $readmemb("number_9.mem", number9);
end

always @*
    case (number)
        0: color = number0[y][x];
        1: color = number1[y][x];
        2: color = number2[y][x];
        3: color = number3[y][x];
        4: color = number4[y][x];
        5: color = number5[y][x];
        6: color = number6[y][x];
        7: color = number7[y][x];
        8: color = number8[y][x];
        9: color = number9[y][x];
    endcase
endmodule

