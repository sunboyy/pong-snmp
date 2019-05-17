`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/29/2019 05:04:39 PM
// Design Name: 
// Module Name: receiverStateMachine
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


module receiverStateMachine(
    output reset, increment, shift, save,
    input clk, nextBit, RsRx, count10
    ,//temp
    output reg [2:0] state
);
//reg [2:0] state = 0;
initial state = 0;
always @(posedge clk)
    case (state)
        0 : state = RsRx ? 0 : 1;
        1 : state = 2;
        2 : state = nextBit ? 3 : 2;
        3 : state = count10 ? 4 : 2;
        4 : state = 0;
    endcase
assign reset = state == 1;
assign save = state == 4;
assign increment = state == 3;
assign shift = state == 3;

endmodule
