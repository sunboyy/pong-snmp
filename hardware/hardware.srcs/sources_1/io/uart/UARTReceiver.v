`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/29/2019 04:59:41 PM
// Design Name: 
// Module Name: UARTReceiver
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


module UARTReceiver(
    output reg [7:0] data,
    output reg irq,
    input clk, RsRx, ack
    ,//temp
    output [2:0] uartrState
);
wire [7:0] shiftData;
wire nextBit, count10, increment, reset, shift, save;

initial irq = 0;
always @(posedge clk)
    if (save)
        irq = 1;
    else if (ack)
        irq = 0;

always @(posedge clk)
    if (save)
        data = shiftData;

timer tm(nextBit, clk, reset);
counter10 ct10(count10, clk, increment, reset);
shiftRegisterReceiver srr(shiftData, clk, shift, RsRx);

receiverStateMachine rsm(reset, increment, shift, save, clk, nextBit, RsRx, count10, uartrState);

endmodule
