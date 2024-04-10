module FullAdder (A, B, Cin, S, Cout);
    input A, B, Cin;
    output Cout, S;

    assign Cout = (A && B) || (Cin && A) || (Cin && B);
    assign S = A ^ B ^ Cin;
endmodule

module RippleCarryAdder8Bit (A, B, Cin, sum, Cout);
    input [7:0]A, B;
    input Cin;
    output [7:0]sum;
    output Cout;
    
    wire C[8:0];

    FullAdder FA[7:0] (A, B, C[7:0], sum, C[8:1]);
    assign C[0] = Cin;
    assign Cout = C[8];
endmodule

module FA_TB;
    reg [7:0]A, B;
    reg Cin;
    wire [7:0]S;
    wire Cout;

    RippleCarryAdder8Bit Test (A, B, Cin, S, Cout);

    initial begin
        #10 
        A = 8'b01010101;
        B = 8'b10101010;
        Cin = 1'b0;
        #10
        A = 8'b11111111;
        B = 8'b00000001;
        Cin = 1'b0;
        #10
        A = 8'b11111110;
        B = 8'b00000001;
        Cin = 1'b1;
    end
endmodule