`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.06.2025 19:27:27
// Design Name: 
// Module Name: MUX_4to1
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


module MUX_4to1(S,In,Out);
input [3:0]In;
input [1:0]S;
output reg Out;

always@(*) begin
case(S) 
    2'b00: Out = In[0];
    2'b01: Out = In[1];
    2'b10: Out = In[2];
    2'b11: Out = In[3];
endcase
end
endmodule
