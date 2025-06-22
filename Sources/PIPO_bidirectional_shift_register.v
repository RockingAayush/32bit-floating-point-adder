`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.06.2025 18:59:06
// Design Name: 
// Module Name: PIPO_bidirectional_shift_register
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


module PIPO_bidirectional_shift_register(I,Clear,Clk,S,A);
input [23:0]I;
input Clear;
input Clk;
input [1:0]S;
output [23:0]A;

wire [23:0]mux_out;
genvar i;
generate for(i = 0;i<24;i=i+1) begin: DFF_chain
    
    MUX_4to1 mux(.S(S),
                 .In(
                    (i==0)?{I[i],1'b0,A[i+1],A[i]}:
                    (i==23)?{I[i],A[i-1],1'b0,A[i]}:
                    {I[i],A[i-1],A[i+1],A[i]}
                    ),
                 .Out(mux_out[i]));
    
    dFF DFF(.D(mux_out[i]),
            .Clear(Clear),
            .Clk(Clk),
            .Q(A[i]));                      
    end
endgenerate    
endmodule
