`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/19/2019 02:38:37 PM
// Design Name: 
// Module Name: scoreMemory
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


module scoreMemory(
    output reg color,
    input [8:0] x,
    input [8:0] y,
    input [4:0] number
    );
    
reg [15:0] number0 [0:23];
reg [15:0] number1 [0:23];
reg [15:0] number2 [0:23];
reg [15:0] number3 [0:23];
reg [15:0] number4 [0:23];
reg [15:0] number5 [0:23];
reg [15:0] number6 [0:23];
reg [15:0] number7 [0:23];
reg [15:0] number8 [0:23];
reg [15:0] number9 [0:23];
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

endmodule
