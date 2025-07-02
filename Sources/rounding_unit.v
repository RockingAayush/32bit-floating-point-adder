`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.07.2025 13:04:43
// Design Name: 
// Module Name: rounding_unit
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


module rounding_unit(Clk,Reset,exponent,mantissa,guard,round,sticky,enable,rounded_exponent,rounded_mantissa);
input Clk,Reset;
input enable;
input guard,round,sticky;
input [23:0]mantissa;
input [7:0]exponent;

output reg [7:0]rounded_exponent;
output reg [23:0]rounded_mantissa;

wire control = guard & (round|sticky|mantissa[0]);
wire carry;
wire [23:0]mantissa_rounded_up;
wire [23:0]mantissa_normal;
wire [7:0]exponent_normal;

adder_subtractor_24bit mantissa_adder(
    .A(mantissa),
    .B(24'b1),
    .Ctl(1'b0),
    .Sum(mantissa_rounded_up),
    .enable(enable),
    .Cout(carry),
    .Difference());

normalizing_unit normalize(
    .Clk(Clk),
    .enable(enable),
    .Reset(Reset),
    .carry(carry),
    .mantissa(mantissa_rounded_up),
    .exponent(exponent),
    .mantissa_normalized(mantissa_normal),
    .exponent_normalized(exponent_normal));
    
always@(*) begin
    case(control)
        1'b0: begin
            rounded_exponent <= exponent;
            rounded_mantissa <= mantissa;
        end
        1'b1: begin
            rounded_exponent <= exponent_normal;
            rounded_mantissa <= mantissa_normal;
        end
    endcase
end    
endmodule
