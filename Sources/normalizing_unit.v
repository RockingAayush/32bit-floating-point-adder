`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.06.2025 11:47:49
// Design Name: 
// Module Name: normalizing_unit
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


module normalizing_unit(Clk,Reset,carry,mantissa,exponent,mantissa_normalized,exponent_normalized,enable);
input Clk;
input enable;
input Reset;
input carry;
input [23:0]mantissa;
input [7:0]exponent;

output reg [23:0]mantissa_normalized;
output reg [7:0]exponent_normalized;

wire [7:0]shift_count;
wire [23:0]left_shift_mantissa;
wire [7:0]left_shift_exponent;
wire [23:0]right_shift_mantissa;
wire [7:0]right_shift_exponent;

// Edge detection logic
reg enable_d;  // delayed version of enable
wire enable_rising;
assign enable_rising = enable & ~enable_d;

// Generate one-cycle Load pulse on rising edge
reg Load;
always @(posedge Clk or posedge Reset) begin
    if (Reset) begin
        enable_d <= 0;
        Load <= 0;
    end else begin
        enable_d <= enable;
        Load <= enable_rising;  // one-cycle pulse
    end
end
    
    
Leading_Zero_Detector LZD(
    .num(mantissa),
    .enable(enable),
    .count(shift_count));
    
count_shifter left_mantissa(
    .Data(mantissa),
    .Count(shift_count),
    .guard(),
    .round(),
    .sticky(),
    .Clk(Clk),
    .Load(Load),
    .Direction(1'b1),
    .Result(left_shift_mantissa),
    .Clear(Reset));
 
adder_subtractor_8bit left_exponent(
    .A(exponent),
    .B(shift_count),
    .Ctl(1'b1),
    .enable(enable),
    .Sum(),
    .Cout(),
    .Difference(left_shift_exponent));        

count_shifter right_mantissa(
    .Data(mantissa),
    .Count(8'b1),
    .guard(),
    .round(),
    .sticky(),
    .Clk(Clk),
    .Load(Load),
    .Direction(1'b0),
    .Result(right_shift_mantissa),
    .Clear(Reset));
 
adder_subtractor_8bit right_exponent(
    .A(exponent),
    .B(8'b1),
    .Ctl(1'b0),
    .enable(enable),
    .Sum(right_shift_exponent),
    .Cout(),
    .Difference());

always@(*) begin
    case(carry)
    1'b0: begin
        mantissa_normalized = left_shift_mantissa;
        exponent_normalized = left_shift_exponent;
    end
    1'b1: begin
        mantissa_normalized = {1'b1,right_shift_mantissa[22:0]};
        exponent_normalized = right_shift_exponent;
    end
    endcase
end    
endmodule
