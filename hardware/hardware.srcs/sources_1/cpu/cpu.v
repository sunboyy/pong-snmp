`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/24/2019 10:51:25 AM
// Design Name: 
// Module Name: cpu
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


module cpu(
    output [15:0] addr,
    output memOE, memWE, iack,
    inout [15:0] data,
    input clk, irq, reset,
    //temp
    output [1:0] ct,
    output [15:0] pcD,
    output [31:0] instruction
);
wire [4:0] regAddrA, regAddrB, regAddrD;
wire [15:0] outA, outB;
wire [3:0] aluMode;
wire regAOE, regBOE, regWE, regAAE, aluOE, pcOE, pcWE, pcUp, saveFlag;
wire [1:0] flag;
wire call, ret, branch, push, pop;
alu alu(data, flag, clk, outA, outB, aluMode, aluOE, saveFlag);
assign data = regAOE ? outA : 16'bZ;
assign data = regBOE ? outB : 16'bZ;
assign addr = regAAE ? outA : 16'bZ;
controlUnit cu(addr, regAddrA, regAddrB, regAddrD, aluMode, memOE, memWE, regAOE, regBOE, regWE, regAAE, aluOE, pcOE, pcWE, pcUp, saveFlag, call, ret, branch, push, pop, iack, data, clk, irq, flag, reset, ct, instruction);

stackZ stz(data, clk, push, pop, reset);
register r(outA, outB, clk, regAddrA, regAddrB, regAddrD, data, regWE);
programCounter pc(addr, clk, data, pcOE, pcWE, pcUp, call, ret, branch, reset, pcD);
endmodule
