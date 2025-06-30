`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.06.2025 19:49:33
// Design Name: 
// Module Name: tb_Leading_Zero_Detector
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


module tb_Leading_Zero_Detector();

reg [23:0]num;
reg enable;
wire [7:0]count;

Leading_Zero_Detector uut(
    .num(num),
    .enable(enable),
    .count(count));
    
initial begin
    #10 
    enable = 0;
    num = 24'H000080;
    #10
    enable = 1;
    #10
    num = 24'H100123;
    #10 
    num = 24'H009008;
    #10
    num = 24'H000000;
    
end    
endmodule
