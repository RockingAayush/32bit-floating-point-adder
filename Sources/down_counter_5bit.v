module down_counter_5bit(
    input [4:0] count,
    input Load,
    input Clk,
    output shift_enable,
    output [4:0] Q   // Added Q as output
);

wire [4:0] Qbar;
wire [4:0] T;
wire [4:0] J;
wire [4:0] K;

assign T[0] = Q[0] | Q[1] | Q[2] | Q[3] | Q[4];
assign T[1] = Qbar[0] & (Q[1] | Q[2] | Q[3] | Q[4]);
assign T[2] = Qbar[0] & Qbar[1] & (Q[2] | Q[3] | Q[4]);
assign T[3] = Qbar[0] & Qbar[1] & Qbar[2] & (Q[3] | Q[4]);
assign T[4] = Qbar[0] & Qbar[1] & Qbar[2] & Qbar[3] & Q[4];

assign shift_enable = ~(Q[0] | Q[1] | Q[2] | Q[3] | Q[4]);

// Combinational logic for JK inputs
assign J = (Load) ? count : T;
assign K = (Load) ? ~count : T;

// Instantiating 5 JK flip-flops
jkFF jkFF0(.J(J[0]), .K(K[0]), .Clk(Clk), .Q(Q[0]), .Qbar(Qbar[0]));
jkFF jkFF1(.J(J[1]), .K(K[1]), .Clk(Clk), .Q(Q[1]), .Qbar(Qbar[1]));
jkFF jkFF2(.J(J[2]), .K(K[2]), .Clk(Clk), .Q(Q[2]), .Qbar(Qbar[2]));
jkFF jkFF3(.J(J[3]), .K(K[3]), .Clk(Clk), .Q(Q[3]), .Qbar(Qbar[3]));
jkFF jkFF4(.J(J[4]), .K(K[4]), .Clk(Clk), .Q(Q[4]), .Qbar(Qbar[4]));

endmodule
