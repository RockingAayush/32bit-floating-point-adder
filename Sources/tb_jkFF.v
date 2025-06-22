`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.06.2025 11:22:45
// Design Name: 
// Module Name: tb_jkFF
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


module tb_jkFF();

reg J,K,Clk;
wire Q,Qbar;

jkFF uut(.J(J),.K(K),.Clk(Clk),.Q(Q),.Qbar(Qbar));

always begin
    #05 Clk = ~Clk;
end

initial begin
    J = 0;
    K = 0;
    Clk  = 0;
    
    #10 J = 0; K = 1;
    #10 J = 0; K = 0;
    #10 J = 1; K = 0;
    #10 J = 1; K = 1;
    #10 J = 0; K = 0;
    #10 J = 1; K = 1;
    #10 J = 1; K = 1;
    #10 J = 0; K = 0;
    
end
endmodule
