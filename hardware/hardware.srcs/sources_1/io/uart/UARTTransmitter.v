`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/29/2019 02:15:14 PM
// Design Name: 
// Module Name: UARTTransmitter
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


module UARTTransmitter(
    output serial, busy,
    input clk, send,
    input [7:0] data
);

wire reset, increment, shift, load, nextBit, count10;

timer tm(nextBit, clk, reset);

counter10 ct10(count10, clk, increment, reset);

transmitterStateMachine tsm(busy, reset, increment, shift, load, clk, send, nextBit, count10);

shiftRegisterTransmitter srt(serial, clk, load, shift, data);

endmodule
