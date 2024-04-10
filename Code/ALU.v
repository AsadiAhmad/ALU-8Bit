module ALU (a, b, op, clk, S, Cout, rst);
    input wire [7:0] a, b;
    input [3:0] op;
    input clk, rst;
    output reg [15:0] S;
    output Cout;
    reg Cin;
    initial Cin = 0;
    wire [7:0]sum;
    wire [15:0]P;
    reg [7:0] A, B;
    initial A = a;
    initial B = b;

    RippleCarryAdder8Bit T0 (.A(A), .B(B), .Cin(Cin), .sum(sum), .Cout(Cout));
    Multipyer T15 (.a(a), .b(b), .clk(clk), .rst(rst), .P(P));

    always @(posedge clk) begin
        case(op)
        4'b0000:
        begin
        Cin = 0;
        A = a;
        B = b;
        # 1 
        S = sum;
        end
        4'b0001:
        begin
        Cin = 1;
        A = a;
        B = ~b;
        #1
        S = sum;
        end
        4'b0010:
        S = |a;
        4'b0011:
        S = |b;
        4'b0100:
        S = a|b;
        4'b0101:
        S = a||b;
        4'b0110:
        S = ^a;
        4'b0111:
        S = ^b;
        4'b1000:
        S = a^b;
        4'b1001:
        S = &a;
        4'b1010:
        S = &b;
        4'b1011:
        S = a&b;
        4'b1100:
        S = a&&b;
        4'b1101:
        begin
        Cin = 1;
        A = ~a;
        B = b;
        #1
        S = sum;
        end
        4'b1110:
        begin
        Cin = 1;
        A = a;
        B = ~b;
        #1
        S = sum;
        end
        4'b1111:
        begin
        S = P;
        end
        endcase
    end
    
endmodule

module ALU_TB;
    reg [7:0] A, B;
    reg [3:0] op;
    reg clk, rst;
    wire [15:0] S;
    wire Cout;

    ALU test (A, B, op, clk, S, Cout, rst);

    initial clk = 0;
    always
    begin
        #5 clk = ~clk;
    end

    initial begin
        rst = 1'b1;
        A = 8'b11100011;
        B = 8'b01111011;
        op = 4'b0000;
        #10
        A = 8'b10010000;
        B = 8'b11111001;
        op = 4'b0111;
        #10
        A = 8'b00011000;
        B = 8'b11101011;
        op = 4'b1000;
        #10
        A = 8'b10010100;
        B = 8'b11100011;
        op = 4'b0110;
        #10
        A = 8'b00101010;
        B = 8'b11011111;
        op = 4'b1110;
        #10
        A = 8'b00011100;
        B = 8'b11000111;
        op = 4'b0001;
        #9
        rst = 1'b0;
        #1
        rst = 1'b1;
        A = 8'b10001110;
        B = 8'b00010010;
        op = 4'b1111;
        #99
        rst = 1'b0;
        #1
        rst = 1'b1;
        A = 8'b00010100;
        B = 8'b00001011;
        op = 4'b1001;
        #10
        A = 8'b01001001;
        B = 8'b10111010;
        op = 4'b1010;
        #10
        A = 8'b01111100;
        B = 8'b01111011;
        op = 4'b0110;
    end
endmodule