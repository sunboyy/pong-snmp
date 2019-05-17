`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/24/2019 11:44:58 AM
// Design Name: 
// Module Name: controlUnit
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


module controlUnit(
    output [15:0] addr,
    output [4:0] regAddrA, regAddrB, regAddrD,
    output [3:0] aluMode,
    output memOE, memWE,
    output regAOE, regBOE, regWE, regAAE,
    output aluOE,
    output pcOE, pcWE, pcUp,
    output saveFlag, call, ret, branch, push, pop, iack,
    inout [15:0] data,
    input clk, irq,
    input [1:0] flag,
    input reset,
    // temp
    output [1:0] ct,
    output [31:0] instruction
);
reg [1:0] counter = 0;
assign ct = counter; //temp
always @(posedge clk, posedge reset)
    if (reset)
        counter = 0;
    else
        counter = counter + 1;

reg interrupt = 0;
always @(posedge clk)
    if (counter == 3)
        interrupt = irq;

wire irWEM, irWEL;
wire [31:0] irData;
assign instruction = irData; //temp
assign pcUp = (irWEM | irWEL) & !interrupt;
instructionRegister ir(irData, clk, data, irWEM, irWEL);
wire [17:0] controlSignal = {memOE, regAOE, regBOE, memWE, regWE, aluOE, pcOE, pcWE, saveFlag, irWEM, irWEL, call, ret, branch, push, pop, iack, regAAE};
controlROM crom(data, addr, regAddrA, regAddrB, regAddrD, aluMode, controlSignal, irData, counter, flag, interrupt);
endmodule
