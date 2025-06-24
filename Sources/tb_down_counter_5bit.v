`timescale 1ns / 1ps

module tb_down_counter_5bit;

    // Testbench signals
    reg [4:0] count;
    reg Load;
    reg Clk;
    reg Reset;
    wire shift_enable;
    wire [4:0] Q;

    // Instantiate the counter
    down_counter_5bit uut (
        .count(count),
        .Load(Load),
        .Clk(Clk),
        .Reset(Reset),
        .shift_enable(shift_enable),
        .Q(Q)
    );

    // Clock generation: 10ns period
    always #5 Clk = ~Clk;

    initial begin
        $display("Time\tClk\tReset\tLoad\tCount\tQ\tshift_enable");
        $monitor("%0t\t%b\t%b\t%b\t%02d\t%b\t%b", $time, Clk, Reset, Load, count, Q, shift_enable);

        // Initialize
        Clk = 0;
        Reset = 1;
        Load = 0;
        count = 5'd0;

        // Hold reset for some time
        #10;
        Reset = 0;

        // Wait 1 cycle
        #10;

        // Load 10 into counter (should work since Q == 0)
        count = 5'd10;
        Load = 1;
        #10;
        Load = 0;

        // Count down
        repeat (6) #10;

        // Try to load 7 while counting (should be ignored)
        count = 5'd7;

        // Continue counting to 0
        repeat (5) #10;

        // Now Q = 0 and shift_enable = 1, load 5
        count = 5'd5;
        Load = 1;
        #10;
        Load = 0;

        // Let it count to 0 again
        repeat (6) #10;

        // Apply reset in middle of operation
        Reset = 1;
        #10;
        Reset = 0;

        // Load 3 after reset
        count = 5'd3;
        Load = 1;
        #10;
        Load = 0;

        // Final countdown
        repeat (5) #10;

        $finish;
    end

endmodule
