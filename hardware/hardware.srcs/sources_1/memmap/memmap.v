`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/23/2019 11:05:46 PM
// Design Name: 
// Module Name: memmap
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


module memmap(
    output [6:0] seg,
    output [3:0] an,
    output RsTx, irq,
    output [1:0] vgaColor,
    output gameState,
    inout [15:0] d,
    input clk, realClk,
    input [15:0] addr,
    input [7:0] sw,
    input [9:0] vgaX, vgaY,
    input PS2Clk, PS2Data,
    input oe, we, RsRx, iack, reset
);
wire switch = addr == 16'hfff0;
wire ps2Receive = addr == 16'hffe0;
wire sevenSegWE0 = addr == 16'hfff8;
wire sevenSegWE1 = addr == 16'hfff9;
wire sevenSegWE2 = addr == 16'hfffa;
wire sevenSegWE3 = addr == 16'hfffb;
wire sevenSegWEAll = addr == 16'hfffe;
wire sevenSegWEDec = addr == 16'hffff;
wire sevenSeg = sevenSegWE0 | sevenSegWE1 | sevenSegWE2 | sevenSegWE3 | sevenSegWEAll | sevenSegWEDec;
wire vga = (addr >= 16'hff00) & (addr < 16'hff10);
wire io = switch | sevenSeg | vga | ps2Receive;
wire busy;
wire [15:0] keycode;

assign d = (switch & oe) ? {8'h0, sw} : 16'bZ;
assign d = (ps2Receive & oe) ? keycode : 16'bZ;

sevenSegRegister ssr(seg, an, clk, realClk, d, we & sevenSegWEAll,
    we & sevenSegWE3, we & sevenSegWE2, we & sevenSegWE1, we & sevenSegWE0,
    we & sevenSegWEDec, reset);

memory mem(d, clk, addr, oe & !io, we & !io);
vgaMemory vgam(vgaColor, gameState, d, clk, addr, vgaX, vgaY, oe & vga, we & vga, reset);
PS2Receiver kb(realClk, PS2Clk, PS2Data, keycode, irq, iack);

endmodule
