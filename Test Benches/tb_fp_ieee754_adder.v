`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.07.2025 16:31:07
// Design Name: 
// Module Name: tb_fp_ieee754_adder
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


module tb_fp_ieee754_adder();

reg Clk,Load,Reset;
reg [31:0]A;
reg [31:0]B;
wire [31:0]Result;

fp_ieee754_adder uut(
    .Clk(Clk),
    .Load(Load),
    .Reset(Reset),
    .A(A),
    .B(B),
    .Result(Result));
    
always #5 Clk = ~Clk;

initial begin
    Clk = 0;
    A = 0;
    B = 0;
    Load = 0;
    Reset = 1;
    
    #10
    A = 32'Hbf7a8284;
    B = 32'H3de408d9;
    Load = 1;
    Reset = 0;
    
    #10
    Load = 0;
end    
endmodule
