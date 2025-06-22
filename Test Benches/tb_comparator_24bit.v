`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.06.2025 20:02:17
// Design Name: 
// Module Name: tb_comparator_24bit
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


module tb_comparator_24bit();
reg [23:0]A;
reg [23:0]B;
wire L;
wire E;
wire G;

comparator_24bit uut(.A(A),.B(B),.L(L),.E(E),.G(G));
initial begin
    A = 24'd800;
    B = 24'd800;
    #10
    A = 24'd1800;
    B = 24'd800;
    #10
    A = 24'd1800;
    B = 24'd11800;
    #10
    A = 24'hFFFFFF;
    B = 24'd0;
    #10
    A = 24'hFFFFFF;
    B = 24'hFFFFFF;
    #10
    A = 24'd0;
    B = 24'd0;
    #10
    A = 24'H800000;
    B = 24'H000001;
    #10
    A = 24'H000001;
    B = 24'H800000;
end
endmodule
