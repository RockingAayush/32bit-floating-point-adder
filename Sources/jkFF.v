`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.06.2025 11:15:19
// Design Name: 
// Module Name: jkFF
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


module jkFF(J,K,Clk,Q,Qbar,Reset);
input J;
input K;
input Clk;
input Reset;
output reg Q;
output Qbar;

assign Qbar = ~Q;

always@(posedge Clk or posedge Reset) begin
if (Reset) begin
    Q <= 1'b0;
end else begin
case({J,K})
    2'b00: begin
        Q <= Q;
    end
    2'b01: begin
        Q <= 1'b0;
    end
    2'b10: begin
        Q <= 1'b1;
    end
    2'b11: begin
        Q <= ~Q;
    end
endcase
end
end
endmodule
