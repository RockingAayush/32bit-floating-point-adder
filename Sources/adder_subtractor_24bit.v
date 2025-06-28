`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.06.2025 11:31:22
// Design Name: 
// Module Name: adder_subtractor_24bit
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

module adder_subtractor_24bit(
    input [23:0] A,
    input [23:0] B,
    input Ctl,
    input enable,
    output [23:0] Sum,
    output Cout,
    output [23:0] Difference
);

wire [23:0] B_xor_ctl;
wire [23:0] carry;

assign B_xor_ctl = B ^ {24{Ctl}};

genvar i;
generate for(i = 0; i < 24; i = i + 1) begin: adder_chain
    if (i == 0) begin
        full_adder FA(
            .A(A[i]),
            .B(B_xor_ctl[i]),
            .Cin(Ctl),
            .Cout(carry[i]),
            .Sum(Sum[i]),
            .enable(enable)
        );
    end else begin
        full_adder FA(
            .A(A[i]),
            .B(B_xor_ctl[i]),
            .Cin(carry[i-1]),
            .Cout(carry[i]),
            .Sum(Sum[i]),
            .enable(enable)
        );
    end
end
endgenerate

assign Cout = carry[23];
assign Difference = Cout ? Sum : ~Sum + 1;

endmodule

