`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.06.2025 10:57:34
// Design Name: 
// Module Name: tb_count_shifter
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


module tb_count_shifter();
reg [23:0]Data;
reg [7:0]Count;
reg Load;
reg Clk;
reg Clear;
reg Direction;
wire [23:0]Result;
wire shift_enable;

count_shifter uut(
                .Data(Data),
                .Count(Count),
                .Load(Load),
                .Clk(Clk),
                .Clear(Clear),
                .Direction(Direction),
                .Result(Result),
                .shift_enable(shift_enable)
                );

always #5 Clk = ~Clk;

initial begin
     
    // Initialize all inputs
        Clk = 0;
        Data = 24'd0;
        Load = 0;
        Count = 8'd0;
        Clear = 0;
        Direction = 0;

        // ------------------------------------
        // Test 1: Right shift (Direction = 0)
        // ------------------------------------
        #10
        Data = 24'b0000_1111_0000_1111_1111_1110;
        Count = 8'd6;
        Direction = 0;
        Load = 1;
        #10 Load = 0;

        #100; // wait for shift to complete

        // ------------------------------------
        // Test 2: Left shift (Direction = 1)
        // ------------------------------------
        Data = 24'b1010_0001_0101_1111_1100_0010;
        Count = 8'd4;
        Direction = 1;
        Load = 1;
        #10 Load = 0;

        #100;

        // ------------------------------------
        // Test 3: Count = 0 (no shift)
        // ------------------------------------
        Data = 24'b1111_1111_0000_0000_1111_1110;
        Count = 8'd0;
        Direction = 0;
        Load = 1;
        #10 Load = 0;

        #30;

        // ------------------------------------
        // Test 4: Count > 23 (invalid case)
        // ------------------------------------
        Data = 24'h5ABCDE;
        Count = 8'd30;
        Direction = 0;
        Load = 1;
        #10 Load = 0;

        #30;

        // ------------------------------------
        // Test 5: Clear test
        // ------------------------------------
        Data = 24'h7FFFFF;
        Count = 8'd5;
        Direction = 1;
        Clear = 1;  // active clear
        Load = 1;
        #10
        Clear = 0;  // release clear
        Load = 0;

        #100;

        $finish;
end                
endmodule
