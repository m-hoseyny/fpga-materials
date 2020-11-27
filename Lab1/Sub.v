module Sub(A, B, Out);

    parameter WIDTH = 64;

    input [WIDTH-1:0] A, B;
    output [WIDTH-1:0] Out;

    assign Out = A - B - 1;


endmodule