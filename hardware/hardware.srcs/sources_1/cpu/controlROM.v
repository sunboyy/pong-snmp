`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/24/2019 12:30:09 PM
// Design Name: 
// Module Name: controlROM
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


module controlROM(
    output [15:0] data,
    output [15:0] addr,
    output reg [4:0] regA,
    output reg [4:0] regB,
    output reg [4:0] regD,
    output [3:0] aluMode,
    output [17:0] controlSignal,
    input [31:0] instruction,
    input [1:0] counter,
    input [1:0] flag,
    input interrupt
);
reg [9:0] controlSignalBundle;
// controlSignalBundle = {memWE, regWE, aluOE, pcOE, pcWE, saveFlag, irWEM, irWEL, call, ret};
wire [3:0] opcode = instruction[31:28];

localparam ANY = 4'hx;
localparam LDA = 4'h1;
localparam STA = 4'h2;
localparam MOV = 4'h3;
localparam ALU = 4'h4;
localparam CMP = 4'h5;
localparam JMP = 4'h6;
localparam CLL = 4'h7;
localparam RET = 4'h8;
localparam BRN = 4'h9;
localparam PSH = 4'ha;
localparam POP = 4'hb;
localparam CLA = 4'hc;

localparam FT1 = 2'h0;
localparam FT2 = 2'h1;
localparam EXC = 2'h2;

wire [1:0] memOpt = instruction[27:26];
localparam MIM = 2'h0;
localparam MDI = 2'h1;
localparam MRI = 2'h2;

localparam JAL = 3'h0;
localparam JEQ = 3'h1;
localparam JNE = 3'h2;
localparam JLT = 3'h3;
localparam JLE = 3'h4;
localparam JGT = 3'h5;
localparam JGE = 3'h6;

wire fetch1 = counter == FT1;
wire fetch2 = counter == FT2;
wire exec = counter == EXC;
wire iload = exec & (opcode == LDA);
wire istore = exec & (opcode == STA);
wire imove = exec & (opcode == MOV);
wire ialu = exec & (opcode == ALU);
wire icmp = exec & (opcode == CMP);
wire ijmp = exec & (opcode == JMP);
wire icall = exec & (opcode == CLL);
wire iret = exec & (opcode == RET);
wire ibrn = exec & (opcode == BRN);
wire ipush = exec & (opcode == PSH);
wire ipop = exec & (opcode == POP);
wire icack = exec & (opcode == CLA);
wire mimm = memOpt == MIM;
wire mdirect = memOpt == MDI;
wire mregin = memOpt == MRI;

wire [2:0] jmpMode = instruction[27:25];
wire shouldJump = (jmpMode == JAL) |
    ((jmpMode == JEQ) & flag[0]) |
    ((jmpMode == JNE) & ~flag[0]) |
    ((jmpMode == JLT) & flag[1]) |
    ((jmpMode == JLE) & (|flag)) |
    ((jmpMode == JGT) & ~(|flag)) |
    ((jmpMode == JGE) & ~flag[1]);

always @*
    casex ({interrupt, opcode, counter})
        {1'b0, ANY, FT1} : controlSignalBundle = 10'b0001001000;
        {1'b0, ANY, FT2} : controlSignalBundle = 10'b0001000100;
        {1'b1, ANY, FT1} : controlSignalBundle = 10'b0000001000;
        {1'b1, ANY, FT2} : controlSignalBundle = 10'b0000000100;
        {1'bx, LDA, EXC} : controlSignalBundle = 10'b0100000000;
        {1'bx, STA, EXC} : controlSignalBundle = 10'b1000000000;
        {1'bx, MOV, EXC} : controlSignalBundle = 10'b0100000000;
        {1'bx, ALU, EXC} : controlSignalBundle = 10'b0110000000;
        {1'bx, CMP, EXC} : controlSignalBundle = 10'b0000010000;
        {1'bx, JMP, EXC} : controlSignalBundle = {4'b0, shouldJump, 5'b0};
        {1'bx, CLL, EXC} : controlSignalBundle = 10'b0000000010;
        {1'bx, RET, EXC} : controlSignalBundle = 10'b0000000001;
        {1'bx, BRN, EXC} : controlSignalBundle = 10'b0000000000;
        {1'bx, PSH, EXC} : controlSignalBundle = 10'b0000000000;
        {1'bx, POP, EXC} : controlSignalBundle = 10'b0100000000;
        {1'bx, CLA, EXC} : controlSignalBundle = 10'b0000000010;
        default: controlSignalBundle = 0;
    endcase

wire memOE = fetch1 | fetch2 | (iload & (mdirect | mregin));
wire branch = ibrn & shouldJump;
wire push = ipush;
wire pop = ipop;
wire iack = icack;
wire regAOE = ipush;
wire regBOE = (istore & mdirect) | (istore & mregin) | imove;
wire regAAE = (iload | istore) & mregin;
assign controlSignal = {memOE, regAOE, regBOE, controlSignalBundle, branch, push, pop, iack, regAAE};

wire addrOE = (iload | istore) & mdirect;
assign addr = addrOE ? instruction[15:0] : 16'bZ;

wire dataOE = (iload & mimm) | ijmp | icall | ibrn | icack;
assign data = dataOE ? instruction[15:0] : 16'bZ;
assign data = (interrupt & fetch1) ? 16'hc000 : 16'bZ;
assign data = (interrupt & fetch2) ? 16'h0200 : 16'bZ;

//assign regA = ((istore & mdirect) | ialu | icmp | ipush) ? instruction[25:21] : 5'bZ;
//assign regA = (iload & mregin) ? instruction[20:16] : 5'bZ;
always @*
    if (ialu | icmp | ipush)
        regA = instruction[25:21];
    else if ((iload | istore) & mregin)
        regA = instruction[20:16];
    else
        regA = 0;

//assign regB = (imove | ialu | icmp) ? instruction[20:16] : 5'bZ;
always @*
    if (istore & (mdirect | mregin))
        regB = instruction[25:21];
    else if (imove | ialu | icmp)
        regB = instruction[20:16];
    else
        regB = 0;

//assign regD = (iload | imove | ipop) ? instruction[25:21] : 5'bZ;
//assign regD = ialu ? instruction[15:11] : 5'bZ;
always @*
    case ({opcode, counter})
        {LDA, EXC} : regD = instruction[25:21];
        {MOV, EXC} : regD = instruction[25:21];
        {ALU, EXC} : regD = instruction[15:11];
        {POP, EXC} : regD = instruction[25:21];
        default : regD = 0;
    endcase

assign aluMode = instruction[3:0];
endmodule
