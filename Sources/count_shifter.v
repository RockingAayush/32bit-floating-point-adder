`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.06.2025 10:15:01
// Design Name: 
// Module Name: count_shifter
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


module count_shifter(Count,Load,Data,Clear,Clk,Direction,Result);
input [23:0]Data;
input [7:0]Count;
input Load;  //Load = 1 Load data Load = 0 Shift
input Clk;
input Clear;
input Direction; //Direction = 0 right shift Direction = 1 left shift
output [23:0]Result;

wire [4:0]Q_count;
wire shift_enable;
reg [1:0]S;
wire [23:0] internal_result;

down_counter_5bit counter(
            .count(Count[4:0]),
            .Load(Load),
            .Clk(Clk),
            .shift_enable(shift_enable),
            .Q(Q_count));

always@(*) begin
    if (Load)
        S = 2'b11;      //Parallel load
    else if(~shift_enable)
        S = {Direction,~Direction};  //Right-Left shift
    else 
        S = 2'b00;   //Hold data        
end
        
PIPO_bidirectional_shift_register register(
            .I(Data),
            .Clear(Clear),
            .Clk(Clk),
            .S(S),
            .A(internal_result));
            
assign Result = (Count > 7'd24) ? 24'd0 : internal_result;                        
            
endmodule
