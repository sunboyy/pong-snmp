`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/12/2019 02:33:09 PM
// Design Name: 
// Module Name: stack
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


module stack(
    output [15:0] dataOut,
    input clk, push, pop,
    input [15:0] dataIn,
    input reset
);
parameter SIZE = 8;
reg [15:0] mem [0:1<<SIZE-1];
reg [SIZE-1:0] n = 0;
always @(posedge clk)
    if (reset)
        n = 0;
    else if (push) begin
        mem[n] <= dataIn;
        n <= n + 1;
    end
    else if (pop)
        n <= n - 1;
assign dataOut = mem[n-1];
endmodule
