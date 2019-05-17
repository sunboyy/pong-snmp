`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/23/2019 09:18:10 PM
// Design Name: 
// Module Name: system
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


module system(
    output [6:0] seg,
    output [3:0] an,
    output reg [15:0] led,
    output RsTx,
    output [3:0] vgaRed, vgaGreen, vgaBlue,
    output Hsync, Vsync,
    input clk,
    input [15:0] sw,
    input btnC,
    input btnL,
    input btnR,
    input RsRx
);

wire targetClk, btnCSync, btnRSync;
debouncer db1(btnCSync, clk, btnC);
debouncer db2(btnRSync, clk, btnR);
clockController cc(targetClk, clk, btnCSync, sw[15]);

wire [15:0] addr;
wire [15:0] data;
wire [9:0] vgaX, vgaY;
wire memOE, memWE, irq, iack, vgaColor, video_on, p_tick;
wire [1:0] ct; //temp
wire [15:0] pc; //temp
wire [31:0] instruction; //temp
wire [7:0] uartData; //temp
wire [2:0] uartrState; //temp
wire vga; //temp
cpu cpu(addr, memOE, memWE, iack, data, targetClk, irq, btnRSync, ct, pc, instruction);

memmap mmap(seg, an, RsTx, irq, vgaColor, data, targetClk, clk, addr, sw[11:4], vgaX, vgaY, memOE, memWE, RsRx, iack, btnRSync, uartData, uartrState, vga);

assign vgaRed = video_on ? {vgaColor, vgaColor, vgaColor, vgaColor} : 4'b0;
assign vgaGreen = video_on ? {vgaColor, vgaColor, vgaColor, vgaColor} : 4'b0;
assign vgaBlue = video_on ? {vgaColor, vgaColor, vgaColor, vgaColor} : 4'b0;
vgaTracker vgat(Hsync, Vsync, video_on, p_tick, vgaX, vgaY, clk, btnRSync);

always @*
    case (sw[2:0])
        0 : led = data;
        1 : led = addr;
        2 : led = instruction[15:0];
        3 : led = instruction[31:16];
        4 : led = {pc[13:0], ct};
        5 : led = {iack, irq, 3'h0, uartrState, uartData};
        6 : led = vga;
        default : led = 0;
    endcase
endmodule
