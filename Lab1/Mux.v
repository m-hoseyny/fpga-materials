module Mux(sel, A, B, Out);

    parameter WIDTH = 64;
    input sel;
    input [WIDTH-1:0] A, B;
    output [WIDTH-1:0] Out;

    assign Out = (sel) ? B : A;
endmodule