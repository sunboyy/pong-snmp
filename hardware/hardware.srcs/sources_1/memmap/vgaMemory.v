`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/05/2019 10:59:10 AM
// Design Name: 
// Module Name: vgaMemory
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


module vgaMemory(
    output reg vgaColor,
    inout [15:0] data,
    input clk,
    input [15:0] addr,
    input [9:0] vgaX, vgaY,
    input oe, we
);

reg gameState = 0;
reg [7:0] scoreA, scoreB;
reg [7:0] padA, padB;
reg [7:0] ballX, ballY;

wire [8:0] x = vgaX >> 1;
wire [8:0] y = vgaY >> 1;

initial begin
    scoreA = 0;
    scoreB = 0;
    padA = 0;
    padB = 0;
    ballX = 8;
    ballY = 0;
end

always @(posedge clk)
    if (we) begin
        if (addr == 16'hff00)
            gameState = data;
        if (addr == 16'hff01)
            scoreA = data;
        if (addr == 16'hff02)
            scoreB = data;
        if (addr == 16'hff03)
            padA = data;
        if (addr == 16'hff04)
            padB = data;
        if (addr == 16'hff05)
            ballX = data;
        if (addr == 16'hff06)
            ballY = data;
    end

assign data = oe & (addr == 16'hff00) ? gameState : 16'bZ;
assign data = oe & (addr == 16'hff01) ? scoreA : 16'bZ;
assign data = oe & (addr == 16'hff02) ? scoreB : 16'bZ;
assign data = oe & (addr == 16'hff03) ? padA : 16'bZ;
assign data = oe & (addr == 16'hff04) ? padB : 16'bZ;
assign data = oe & (addr == 16'hff05) ? ballX : 16'bZ;
assign data = oe & (addr == 16'hff06) ? ballY : 16'bZ;

always @*
    if (gameState)
        if (((y == 40) | (y == 201)) & (x >= 40) & (x < 280))
            vgaColor = 1;
        else if (((y >= 41) & (y < 201) & (x >= 40) & (x < 280)))
            if ((x - 40 >= ballX) & (x - 40 < ballX + 8) & (y - 41 >= ballY) & (y - 41 < ballY + 8))
                vgaColor = 1;
            else if ((x >= 40) & (x < 48) & (y - 41 >= padA) & (y - 41 < padA + 40))
                vgaColor = 1;
            else if ((x >= 272) & (x < 280) & (y - 41 >= padA) & (y - 41 < padA + 40))
                vgaColor = 1;
            else
                vgaColor = 0;
        else
            vgaColor = 0;
    else
        vgaColor = 0;
endmodule
