`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/29/2019 03:13:34 PM
// Design Name: 
// Module Name: transmitterStateMachine
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


module transmitterStateMachine(
    output busy, reset, increment, shift, load,
    input clk, send, nextBit, count10
);

reg [2:0] state;
always @(posedge clk)
    case (state)
        0 : state = send ? 1 : 0;
        1 : state = 2;
        2 : state = nextBit ? 3 : 2;
        3 : state = count10 ? 4 : 2;
        4 : state = send ? 4 : 0;
    endcase

assign reset = state == 1;
assign increment = state == 3;
assign shift = (state == 0) | (state == 3);
assign load = (state == 0) | (state == 1);
assign busy = (state == 1) | (state == 2) | (state == 3);

endmodule
