`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/29/2019 12:45:41 PM
// Design Name: 
// Module Name: vga_sync
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


module vgaTracker(
    output hsync, vsync, video_on, p_tick,
    output [9:0] x, y,
    input clk, reset
);

localparam H_DISPLAY = 640;
localparam H_L_BORDER = 48;
localparam H_R_BORDER = 16;
localparam H_RETRACE = 96;
localparam H_MAX = H_DISPLAY + H_L_BORDER + H_R_BORDER + H_RETRACE;
localparam START_H_RETRACE = H_DISPLAY + H_R_BORDER;
localparam END_H_RETRACE = START_H_RETRACE + H_RETRACE - 1;

localparam V_DISPLAY = 480;
localparam V_T_BORDER = 33;
localparam V_B_BORDER = 10;
localparam V_RETRACE = 2;
localparam V_MAX = V_DISPLAY + V_T_BORDER + V_B_BORDER + V_RETRACE;
localparam START_V_RETRACE = V_DISPLAY + V_B_BORDER;
localparam END_V_RETRACE = START_V_RETRACE + V_RETRACE - 1;

reg [1:0] pixel_reg;
wire pixel_tick = pixel_reg == 0;
always @(posedge clk)
    pixel_reg <= pixel_reg + 1;

reg [9:0] h_count_reg = 0;
reg [9:0] v_count_reg = 0;
wire [9:0] h_count_next = pixel_tick ? ((h_count_reg + 1) % H_MAX) : h_count_reg;
wire [9:0] v_count_next = (pixel_tick && h_count_reg == H_MAX - 1) ? ((v_count_reg + 1) % V_MAX) : v_count_reg;

assign hsync = (h_count_reg >= START_H_RETRACE) && (h_count_reg <= END_H_RETRACE);
assign vsync = (v_count_reg >= START_V_RETRACE) && (v_count_reg <= END_V_RETRACE);

always @(posedge clk, posedge reset)
    if (reset) begin
        v_count_reg <= 0;
        h_count_reg <= 0;
    end
    else begin
        v_count_reg <= v_count_next;
        h_count_reg <= h_count_next;
    end

assign video_on = (h_count_reg < H_DISPLAY) && (v_count_reg < V_DISPLAY);

assign x = h_count_reg;
assign y = v_count_reg;
assign p_tick = pixel_tick;

endmodule
