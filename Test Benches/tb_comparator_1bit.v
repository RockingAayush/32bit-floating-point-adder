`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.06.2025 19:35:06
// Design Name: 
// Module Name: tb_comparator_1bit
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


module tb_comparator_1bit();
reg A;
reg B;
reg L_in;
reg E_in;
reg G_in;
wire L_out;
wire E_out;
wire G_out;

comparator_1bit uut(.A(A),.B(B),.L_in(L_in),.E_in(E_in),.G_in(G_in),.L_out(L_out),.E_out(E_out),.G_out(G_out));
initial begin
    A = 0;
    B = 0;
    L_in = 0;
    E_in = 1;
    G_in = 0;
    #10
    A = 0;
    B = 1;
    L_in = 0;
    E_in = 1;
    G_in = 0;
    #10
    A = 1;
    B = 0;
    L_in = 0;
    E_in = 1;
    G_in = 0;
    #10
    A = 1;
    B = 1;
    L_in = 0;
    E_in = 1;
    G_in = 0;
    #10
    A = 1;
    B = 1;
    L_in = 1;
    E_in = 0;
    G_in = 0;
    #10
    A = 1;
    B = 1;
    L_in = 0;
    E_in = 0;
    G_in = 1;
end
endmodule
