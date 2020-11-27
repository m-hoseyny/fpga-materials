module Register(clk, reset,ld, in, out);

    parameter WIDTH = 16;
    input clk, reset,ld;
    input [WIDTH-1:0]in;
    output reg[WIDTH-1:0]out;


    always @(posedge clk, negedge reset) begin
        if (~reset) 
            out <= 0;
        else
            if(ld)
                out <= in;
    end

endmodule


module Registe_TB();

    wire [31:0]out;
    reg [31:0]in;
    reg clk, reset, ld;
    Register #(.WIDTH(32)) Reg1(clk, reset,ld, in, out);
    initial begin
        clk = 1'b0;
        repeat(100) #10 clk = ~clk;
    end

    initial begin
        reset = 1'b1;
        ld = 0;
        #2;
        reset = 1'b0;
        #25;
        reset = 1'b1;
        #5;
        in = 16'd154;
        ld = 1;
        #40;
        ld = 0;
        in = 16'd54;
        #20;
        ld = 1;
        in = 16'd15;
        #500;
        $stop;

    end





endmodule


