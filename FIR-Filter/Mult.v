module Mult(A, B, out);

    parameter WIDTH = 32;

    input signed[WIDTH-1:0] A, B;
    output signed[WIDTH*2-1:0] out;

    assign out = A * B;


endmodule



module Mult_TB();
    reg [15:0] A, B;
    wire [31:0] out;

    Mult #(
        .WIDTH(16)
    ) mult (A, B, out);

    initial begin 
        A = 16'd14;
        B = 16'd16;
        #100;
        A = 16'd0;
        B = 16'd16;
        #100;
        A = 16'd30;
        B = 16'd16;
        #100;
        A = 16'd15;
        B = 16'd13;
        #100;
        $stop;


    end



endmodule


