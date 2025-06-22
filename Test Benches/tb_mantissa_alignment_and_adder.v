`timescale 1ns/1ps

module tb_mantissa_alignment_and_adder();

reg Clk, Reset;
reg S_A, S_B;
reg [7:0] E_A, E_B;
reg [23:0] M_A, M_B;
wire S_Result;
wire [7:0] E_Result;
wire [23:0] M_Result;
wire Carry;

// Instantiate DUT
mantissa_alignment_and_adder dut (
    .Clk(Clk),
    .Reset(Reset),
    .S_A(S_A),
    .S_B(S_B),
    .E_A(E_A),
    .E_B(E_B),
    .M_A(M_A),
    .M_B(M_B),
    .S_Result(S_Result),
    .E_Result(E_Result),
    .M_Result(M_Result),
    .Carry(Carry)
);

always #5 Clk = ~Clk;

initial begin
    Clk = 0;
    Reset = 1;
    S_A = 0;
    S_B = 1;
    E_A = 8'd30;
    E_B = 8'd50;
    M_A = 24'H800000;
    M_B = 24'HFFFFFF;
    #10
    Reset = 0;
end
endmodule
