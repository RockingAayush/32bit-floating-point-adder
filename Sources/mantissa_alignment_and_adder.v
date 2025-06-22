`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.06.2025 11:35:57
// Design Name: 
// Module Name: mantissa_alignment_and_adder
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


module mantissa_alignment_and_adder(Clk,Reset,S_A,S_B,E_A,E_B,M_A,M_B,S_Result,E_Result,M_Result,Carry);
input S_A;
input S_B;
input [7:0]E_A;
input [7:0]E_B;
input [23:0]M_A;
input [23:0]M_B;
input Clk;
input Reset;

output reg S_Result;
output reg [7:0]E_Result;
output reg [23:0]M_Result;
output reg Carry;

wire exponent_borrow;
wire [7:0]count_to_shift;

reg [23:0]mantissa_to_be_aligned;
reg [23:0]mantissa_as_it_is;

wire [23:0]aligned_mantissa;
wire [23:0]mantissa_sum;
wire [23:0]mantissa_difference;
wire carry_after_mantissa_addition;
wire control_for_adder_or_subtractor;

reg load_flag;

wire mantissa_as_it_is_greater;
wire mantissa_to_be_aligned_greater;
wire mantissas_equal;

wire exponent_A_greater;
wire exponent_B_greater;
wire exponents_equal;

assign control_for_adder_or_subtractor = S_A^S_B;

always @(posedge Clk or posedge Reset) begin
    if (Reset)
        load_flag <= 1'b1; // When Reset is asserted, prepare to load
    else
        load_flag <= 1'b0; // Automatically deassert Load on the next cycle
end

adder_subtractor_8bit exponent_difference(
        .A(E_A),
        .B(E_B),
        .Ctl(1'b1),
        .Sum(),
        .Cout(exponent_borrow),        // exponent_borrow = 1 means no borrow happened (E_A > E_B)
        .Difference(count_to_shift));  // |E_A - E_B|

always@(*) begin        
case(exponent_borrow) 
    1'b0: begin //E_A < E_B
        mantissa_to_be_aligned = M_A;
        mantissa_as_it_is = M_B;
        E_Result = E_B;
        end
    1'b1: begin //E_A > E_B
        mantissa_to_be_aligned = M_B;
        mantissa_as_it_is = M_A;
        E_Result = E_A;
    end    
endcase        
end


count_shifter mantissa_aligner(
    .Count(count_to_shift),
    .Load(load_flag),
    .Data(mantissa_to_be_aligned),
    .Clear(Reset),
    .Clk(Clk),
    .Direction(1'b0),
    .Result(aligned_mantissa));  

adder_subtractor_24bit mantissa_adder(
    .A(mantissa_as_it_is),
    .B(aligned_mantissa),
    .Ctl(control_for_adder_or_subtractor),     // Depends on sign
    .Sum(mantissa_sum),
    .Cout(carry_after_mantissa_addition),
    .Difference(mantissa_difference));

comparator_24bit exponent_compare (
    .A({16'b0, E_A}),
    .B({16'b0, E_B}),
    .L(exponent_B_greater),
    .E(exponents_equal),
    .G(exponent_A_greater)
);
    
comparator_24bit mantissa_compare (
    .A(mantissa_as_it_is),
    .B(aligned_mantissa),
    .L(mantissa_to_be_aligned_greater),
    .E(mantissas_equal),
    .G(mantissa_as_it_is_greater)
);
    

always @(*) begin
    if (S_A == S_B) begin
        S_Result = S_A;
    end else begin
        if (exponent_A_greater)
            S_Result = S_A;
        else if (exponent_B_greater)
            S_Result = S_B;
        else begin // exponents_equal
            if (mantissa_as_it_is_greater)
                S_Result = (mantissa_as_it_is == M_A) ? S_A : S_B;
            else if (mantissa_to_be_aligned_greater)
                S_Result = (mantissa_to_be_aligned == M_A) ? S_A : S_B;
            else
                S_Result = 1'b0; // Both exactly equal
        end
    end
end


always@(*) begin
    case(control_for_adder_or_subtractor)
        1'b0: begin
            M_Result = mantissa_sum;
            Carry = carry_after_mantissa_addition;
        end     
        1'b1:begin
            M_Result = mantissa_difference; 
            Carry = 0'b0;
        end
    endcase
end              
endmodule
