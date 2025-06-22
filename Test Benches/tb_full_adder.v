`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.06.2025 15:49:37
// Design Name: 
// Module Name: tb_full_adder
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


module tb_full_adder();

reg A;
reg B;
reg Cin;
wire Cout;
wire Sum;

full_adder uut(.A(A),.B(B),.Cin(Cin),.Sum(Sum),.Cout(Cout));
initial begin
    #10 
    A = 1'b0;
    B = 1'b0;
    Cin = 1'b0;
    #10 
    A = 1'b1;
    B = 1'b1;
    Cin = 1'b0;
    #10 
    A = 1'b1;
    B = 1'b1;
    Cin = 1'b1;
    #10 
    A = 1'b0;
    B = 1'b1;
    Cin = 1'b1;
    
    
end
endmodule
