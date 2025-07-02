`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.07.2025 13:19:57
// Design Name: 
// Module Name: tb_rounding_unit
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


module tb_rounding_unit();

reg Clk,enable,Reset;
reg [23:0]mantissa;
reg [7:0]exponent;
reg guard,round,sticky;

wire [23:0]rounded_mantissa;
wire [7:0]rounded_exponent;

rounding_unit uut(
    .Clk(Clk),
    .enable(enable),
    .Reset(Reset),
    .mantissa(mantissa),
    .exponent(exponent),
    .guard(guard),
    .round(round),
    .sticky(sticky),
    .rounded_mantissa(rounded_mantissa),
    .rounded_exponent(rounded_exponent));
    
always #5 Clk = ~Clk;

initial begin
    Clk = 0;
    enable = 0;
    Reset = 1;
    mantissa = 24'd0;
    exponent = 8'd0;
    guard = 0;
    round = 0;
    sticky = 0;
    
    #10
    Reset = 0;
    enable = 1;
    mantissa = 24'HFFFFF0;
    exponent = 8'd130;
    guard = 0;
    round = 0;
    sticky = 0;
    #50
    Reset  = 1;
    enable = 0;
    #10
    Reset = 0;
    enable = 1;
    guard = 1;
    round = 0;
    sticky = 0;
    
    #50
    Reset  = 1;
    enable = 0;
    #10
    Reset = 0;
    enable = 1;
    mantissa = 24'HFFFFF0;
    guard = 1;
    round = 1;
    sticky = 0;
    
    #50
    Reset  = 1;
    enable = 0;
    #10
    Reset = 0;
    enable = 1;
    mantissa = 24'HFFFFFF;
    guard = 1;
    round = 0;
    sticky = 0;
end    
endmodule
