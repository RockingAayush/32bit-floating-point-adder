`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.06.2025 19:42:50
// Design Name: 
// Module Name: comparator_24bit
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


module comparator_24bit(A,B,L,E,G);
input [23:0]A;
input [23:0]B;
output L;
output E;
output G;

wire [24:0]L_out;
wire [24:0]E_out;
wire [24:0]G_out;
genvar i;

assign L_out[0] = 1'b0;
assign G_out[0] = 1'b0;
assign E_out[0] = 1'b1;

generate for(i=0;i<24;i=i+1) begin: comp_chain
    comparator_1bit comparators(
                .A(A[23-i]),
                .B(B[23-i]),
                .L_in(L_out[i]),
                .G_in(G_out[i]),
                .E_in(E_out[i]),
                .L_out(L_out[i+1]),
                .E_out(E_out[i+1]),
                .G_out(G_out[i+1]));
end
endgenerate

assign L = L_out[24];
assign E = E_out[24];
assign G = G_out[24];
endmodule
