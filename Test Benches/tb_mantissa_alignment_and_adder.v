
module tb_mantissa_alignment_and_adder();
reg S_A;
reg S_B;
reg [7:0]E_A;
reg [7:0]E_B;
reg [23:0]M_A;
reg [23:0]M_B;
reg Clk;
reg Reset;
reg Load;

wire S_Result;
wire [7:0]E_Result;
wire [23:0]M_Result;
wire Carry;
wire Result_stable;
wire guard;
wire round;
wire sticky;

mantissa_alignment_and_adder uut(
    .S_A(S_A),
    .S_B(S_B),
    .E_A(E_A),
    .E_B(E_B),
    .M_A(M_A),
    .M_B(M_B),
    .Clk(Clk),
    .Reset(Reset),
    .Load(Load),
    .S_Result(S_Result),
    .E_Result(E_Result),
    .M_Result(M_Result),
    .Carry(Carry),
    .Result_stable(Result_stable),
    .guard(guard),
    .round(round),
    .sticky(sticky));
    
always #5 Clk = ~Clk;
initial begin
    Clk = 0;
    Reset = 1;
    Load = 0;
    #10
    Reset = 0;
    S_A = 0;
    S_B = 0;
    E_A = 8'd130;
    E_B = 8'd120;
    M_A = 24'H800000;
    M_B = 24'H800000;
    Load = 1;
    #10
    Load = 0;
    #300
    
    Reset = 1;
    #10
    Reset = 0;
    S_A = 1;
    S_B = 0;
    E_A = 8'd130;
    E_B = 8'd120;
    M_A = 24'H800000;
    M_B = 24'H800301;
    Load = 1;
    #10
    Load = 0;
    #300
    
    Reset = 1;
    #10
    Reset = 0;
    S_A = 1;
    S_B = 0;
    E_A = 8'd120;
    E_B = 8'd120;
    M_A = 24'H800000;
    M_B = 24'H800000;
    Load = 1;
    #10
    Load = 0;
    #300
    
    Reset = 1;
    #10
    Reset = 0;
    S_A = 1;
    S_B = 1;
    E_A = 8'd120;
    E_B = 8'd120;
    M_A = 24'H800000;
    M_B = 24'H800000;
    Load = 1;
    #10
    Load = 0;
    #300
    
    Reset = 1;
    #10
    Reset = 0;
    S_A = 1;
    S_B = 1;
    E_A = 8'd120;
    E_B = 8'd130;
    M_A = 24'H800000;
    M_B = 24'H800000;
    Load = 1;
    #10
    Load = 0;
     
end

endmodule