`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.06.2025 16:27:53
// Design Name: 
// Module Name: tb_adder_subtractor_24bit
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


module tb_adder_subtractor_24bit();

reg [23:0]A;
reg [23:0]B;
reg Ctl;
reg enable;
wire Cout;
wire [23:0]Sum;
wire [23:0]Difference;

adder_subtractor_24bit uut(.A(A),.B(B),.Ctl(Ctl),.Cout(Cout),.Sum(Sum),.Difference(Difference),.enable(enable));
initial begin
    #10
    enable = 1;
    A = 24'd28;
    B = 24'd34;
    Ctl = 0;
    #10
    A = 24'b1111_1111;
    B = 24'd34;
    Ctl = 0;
    #10
    A = 24'd28;
    B = 24'd34;
    Ctl = 1;
    #10
    A = 24'b1111_1111;
    B = 24'd34;
    Ctl = 1;
    #10
    A = 24'd0;
    B = 24'd1;
    Ctl = 1;
    #10
    enable = 0;
    A = 24'd1;
    B = 24'd0;
    Ctl = 1;
    #10
    A = 24'd0;
    B = 24'd0;
    Ctl = 1;
    #10
    A = 24'd2222;
    B = 24'd2222;
    Ctl = 1;
end
endmodule
