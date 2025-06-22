module tb_down_counter_5bit;

reg [4:0] count;
reg Clk;
reg Load;
wire shift_enable;
wire [4:0] Q;

down_counter_5bit uut(
    .count(count),
    .Load(Load),
    .Clk(Clk),
    .shift_enable(shift_enable),
    .Q(Q)
);

// Clock generation
initial Clk = 0;
always #5 Clk = ~Clk; // 10ns clock period

initial begin
    $monitor("Time=%0t | Q=%b | count=%b | Load=%b | shift_enable=%b", $time, Q, count, Load, shift_enable);
    // Initial setup
    count = 5'b00000;
    Load = 0;
    #10;
    count = 5'b00111;
    Load = 1;
    #10;
    Load = 0;
    
end

endmodule
