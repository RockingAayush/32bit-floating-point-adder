`timescale 1ns / 1ps

module tb_normalizing_unit();

    // Inputs
    reg Clk;
    reg Reset;
    reg carry;
    reg [23:0] mantissa;
    reg [7:0] exponent;
    reg enable;
    // Outputs
    wire [23:0] mantissa_normalized;
    wire [7:0] exponent_normalized;
    wire done;
    // Instantiate the Unit Under Test (UUT)
    normalizing_unit uut (
        .Clk(Clk),
        .Reset(Reset),
        .carry(carry),
        .mantissa(mantissa),
        .exponent(exponent),
        .mantissa_normalized(mantissa_normalized),
        .exponent_normalized(exponent_normalized),
        .enable(enable),
        .done(done)
    );

    // Clock generation
    always #5 Clk = ~Clk;

    initial begin
        
        Clk = 0;
        Reset = 1;
        enable = 0;
        carry = 0;
        mantissa = 24'b000010000000000000000000;  // Example: leading zeros to test LZD
        exponent = 8'd127;
        #10
        Reset = 0;
        enable = 1;
        #100
        
        Reset = 1;
        enable = 0; 
        carry = 1;
        mantissa = 24'b000010000000000000000000;
        exponent = 8'd30;
        #10
        Reset = 0;
        enable = 1;
        #100
        
        Reset = 1;
        enable = 0; 
        carry = 0;
        mantissa = 24'b00000000000000000000001;
        exponent = 8'd30;
        #10
        Reset = 0;
        enable = 1;
    end
endmodule
