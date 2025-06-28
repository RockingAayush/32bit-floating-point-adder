`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.06.2025 20:22:24
// Design Name: 
// Module Name: tb_PIPO_bidirectional_shift_register
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


module tb_PIPO_bidirectional_shift_register();
reg [23:0]I;
reg Clear;
reg Clk;
reg [1:0]S;
wire [23:0]A;
wire guard;
wire round;
wire sticky;

PIPO_bidirectional_shift_register uut(.I(I),.Clear(Clear),.Clk(Clk),.S(S),.A(A),.guard(guard),.round(round),.sticky(sticky));

always #5 Clk = ~Clk;

initial begin
    I = 24'b0000_0000_0000_0000_0000_0000;
    Clk = 0;
    Clear = 0;
    S = 2'b00;
    
    #10
    I = 24'b0000_0110_0000_0000_0000_0010;
    S = 2'b11;
    #10
    S = 2'b01;
    #10
    S = 2'b01;
    #10
    S = 2'b00;
    #10
    S = 2'b10;
    #10
    S = 2'b00;
    #10
    Clear = 1;
    #10
    Clear = 0;
    I = 24'b0000_0110_0000_0000_1000_0000;
    S = 2'b11;
    #10// Right shift
    S = 2'b01;
    #10// Right shift
    S = 2'b01;
    #10// Right shift
    S = 2'b01;
    #10// Right shift
    S = 2'b01;
    #10// Right shift
    S = 2'b01;
end
endmodule
