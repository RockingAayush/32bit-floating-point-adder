`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.06.2025 16:25:41
// Design Name: 
// Module Name: tb_adder_subtractor_8bit
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


module tb_adder_subtractor_8bit();

reg [7:0]A;
reg [7:0]B;
reg Ctl;
reg enable;
wire Cout;
wire [7:0]Sum;
wire [7:0]Difference;

adder_subtractor_8bit uut(.A(A),.B(B),.Ctl(Ctl),.Cout(Cout),.Sum(Sum),.Difference(Difference),.enable(enable));
initial begin
    #10
    enable = 0;
    A = 8'd28;
    B = 8'd34;
    Ctl = 0;
    #10
    A = 8'b1111_1111;
    B = 8'd34;
    Ctl = 0;
    #10
    A = 8'd28;
    B = 8'd34;
    Ctl = 1;
    #10
    enable = 1;
    A = 8'b1111_1111;
    B = 8'd34;
    Ctl = 1;
    #10
    A = 8'd0;
    B = 8'd1;
    Ctl = 1;
    #10
    A = 8'd1;
    B = 8'd0;
    Ctl = 1;
    #10
    A = 8'd22;
    B = 8'd22;
    Ctl = 1;
end
endmodule
