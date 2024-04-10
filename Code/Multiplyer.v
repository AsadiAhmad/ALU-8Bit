module Multipyer (a, b, clk, rst, P);
    input [7:0]a, b;
    input clk, rst;
    output reg [15:0]P;
    reg [15:0]M;
    wire [7:0]x, y;
    integer counter;
    initial counter = 0;
    initial P = 16'b0000000000000000;
    initial M = 16'b0000000000000000;

    always @(posedge clk) begin
        if (counter < 8) begin
            if (counter == 0) 
                M = x;
            if (b[counter] == 1) begin
                P = P + M;
            end
            else begin
                P = P;
            end
            M = M << 1;
            counter = counter + 1;
        end
        else if (counter == 8) begin
            if (a[7] ^ b[7] == 1) begin
                P = ~P+1;
            end
            else begin 
                P = P;
            end
            counter = counter + 1;
        end
        else
            counter = 9;
    end
    always @(negedge rst) begin
        if (rst == 0)
            counter <= 0;
            P <= 16'b0000000000000000;
            M <= 16'b0000000000000000;
    end
    assign x = (a[7] == 0)? a:(~a+1);
    assign y = (b[7] == 0)? b:(~b+1);

endmodule

module MultipyerTB;
    reg [7:0]A, B;
    reg clk, rst;
    wire [15:0]S;

    Multipyer mult (A, B, clk, rst, S);

    initial clk = 0;
    always
    begin
        #5 clk = ~clk;
    end

    initial begin 
        rst = 1'b1;
        A = 8'b10000010;
        B = 8'b10000110;
        #100
        rst = 1'b0;
        A = 8'b00000110;
        B = 8'b01010110;
        #1 
        rst = 'b1;

    end
endmodule

