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


module PIPO_bidirectional_shift_register(I,Clear,Clk,S,A,guard,round,sticky);
input [23:0]I;
input Clear;
input Clk;
input [1:0]S;
output [23:0]A;
output guard;
output round;
output reg sticky;

wire [25:0]I_appended_00;
wire [25:0]A_extended;
wire [25:0]mux_out;


always@(posedge Clk or posedge Clear) begin
    if(Clear) begin
        sticky <= 1'b0;
    end else if(S == 2'b01) begin
        sticky <= sticky | A_extended[0];
    end
end

assign I_appended_00 = {I, 2'b00};
assign A = A_extended[25:2];  
assign guard = A_extended[1];
assign round = A_extended[0];

genvar i;
generate for(i = 0;i<26;i=i+1) begin: DFF_chain
    
    MUX_4to1 mux(.S(S),
                 .In(
                    (i==0)?{I_appended_00[i],1'b0,A_extended[i+1],A_extended[i]}:
                    (i==25)?{I_appended_00[i],A_extended[i-1],1'b0,A_extended[i]}:
                    {I_appended_00[i],A_extended[i-1],A_extended[i+1],A_extended[i]}
                    ),
                 .Out(mux_out[i]));
    
    dFF DFF(.D(mux_out[i]),
            .Clear(Clear),
            .Clk(Clk),
            .Q(A_extended[i]));                      
    end
endgenerate

    
endmodule
