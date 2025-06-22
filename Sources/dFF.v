`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.06.2025 19:00:15
// Design Name: 
// Module Name: dFF
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


module dFF(D,Clear,Clk,Q);
input D;
input Clk;
input Clear;
output reg Q;


always@(posedge Clk or posedge Clear) begin
   if(Clear == 1'b1) Q <= 1'b0;
   else Q <= D;        
end
endmodule
