`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.06.2025 15:55:48
// Design Name: 
// Module Name: adder_subtractor_8bit
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


module adder_subtractor_8bit(A,B,Ctl,Cout,Sum,Difference);
// Ctl = 1 A - B
input [7:0]A;
input [7:0]B;
input Ctl;
output [7:0]Sum;
output Cout;
output [7:0]Difference;

wire [7:0]B_xor_ctl;
wire [7:0]carry;
assign B_xor_ctl = B ^ {8{Ctl}};

genvar i;
generate for(i=0;i<8;i=i+1) begin: adder_chain
    if (i == 0) begin
        full_adder FA(
            .A(A[i]),
            .B(B_xor_ctl[i]),
            .Cin(Ctl),
            .Cout(carry[i]),
            .Sum(Sum[i]));
    end else begin
        full_adder FA(
            .A(A[i]),
            .B(B_xor_ctl[i]),
            .Cin(carry[i-1]),
            .Cout(carry[i]),
            .Sum(Sum[i]));
    end
end
endgenerate

assign Cout = carry[7];
assign Difference = Cout ? Sum : ~Sum + 1;
endmodule
