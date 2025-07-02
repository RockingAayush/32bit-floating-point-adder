`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.07.2025 16:07:52
// Design Name: 
// Module Name: fp_ieee754_adder
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


module fp_ieee754_adder(A,B,Result,Load,Clk,Reset);
input Clk,Load,Reset;
input [31:0]A;
input [31:0]B;
output [31:0]Result;

wire [23:0]mantissa_A = {1'b1,A[22:0]};
wire [23:0]mantissa_B = {1'b1,B[22:0]};
wire [7:0]exponent_A = A[30:23];
wire [7:0]exponent_B = B[30:23];
wire S_A = A[31];
wire S_B = B[31];
wire guard, round, sticky;

wire S_Result_first;
wire [7:0]E_Result_first;
wire [23:0]M_Result_first;
wire carry;
wire result_stable_first;
wire result_stable_second;

wire [23:0]mantissa_normalized;
wire [7:0]exponent_normalized;

wire [23:0]rounded_mantissa;
wire [7:0]rounded_exponent;
// First stage
mantissa_alignment_and_adder stage_1(
    .S_A(S_A),
    .S_B(S_B),
    .E_A(exponent_A),
    .E_B(exponent_B),
    .M_A(mantissa_A),
    .M_B(mantissa_B),
    .Clk(Clk),
    .Reset(Reset),
    .Load(Load),
    .S_Result(S_Result_first),
    .E_Result(E_Result_first),
    .M_Result(M_Result_first),
    .Carry(carry),
    .Result_stable(result_stable_first),
    .guard(guard),
    .round(round),
    .sticky(sticky));

//Second stage
normalizing_unit stage_2(
        .Clk(Clk),
        .Reset(Reset),
        .carry(carry),
        .mantissa(M_Result_first),
        .exponent(E_Result_first),
        .mantissa_normalized(mantissa_normalized),
        .exponent_normalized(exponent_normalized),
        .enable(result_stable_first),
        .done(result_stable_second)
    );
    
//Third stage
rounding_unit stage_3(
    .Clk(Clk),
    .enable(result_stable_second),
    .Reset(~result_stable_second),
    .mantissa(mantissa_normalized),
    .exponent(exponent_normalized),
    .guard(guard),
    .round(round),
    .sticky(sticky),
    .rounded_mantissa(rounded_mantissa),
    .rounded_exponent(rounded_exponent));

assign Result = {S_Result_first,rounded_exponent,rounded_mantissa[22:0]};        
endmodule
