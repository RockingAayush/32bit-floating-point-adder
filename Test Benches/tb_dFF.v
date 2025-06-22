`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.06.2025 19:08:58
// Design Name: 
// Module Name: tb_dFF
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


module tb_dFF();

reg D;
reg Clear;
reg Clk;
wire Q;

dFF uut(.D(D),.Clear(Clear),.Clk(Clk),.Q(Q));

always #5 Clk = ~Clk;
initial begin
    Clk = 0;
    Clear = 0;
    D = 0;
    #10
    D = 1;
    #10
    D = 0;
    #10 
    D = 1;
    #10
    Clear = 1;
    #10
    D = 1;
end
endmodule
