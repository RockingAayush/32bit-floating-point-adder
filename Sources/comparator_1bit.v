`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.06.2025 18:58:24
// Design Name: 
// Module Name: comparator_1bit
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


module comparator_1bit(A,B,L_in,G_in,E_in,L_out,G_out,E_out);
input A;
input B;

input L_in;
input E_in;
input G_in;
output L_out;
output G_out;
output E_out;

assign L_out = (~A&B&E_in)|L_in;
assign G_out = (~B&A&E_in)|G_in;
assign E_out = (~(A^B))&E_in;
endmodule
