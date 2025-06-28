`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.06.2025 15:43:20
// Design Name: 
// Module Name: full_adder
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


module full_adder(A,B,Cin,Cout,Sum,enable);
input A;
input B;
input Cin;
input enable;
output reg Sum;
output reg Cout;

always@(*) begin
    if (enable) begin
        Sum = A^B^Cin;
        Cout = (A&B) | (A^B)&Cin;
    end else begin
        Sum = 1'b0;
        Cout = 1'b0;
    end
end
endmodule
