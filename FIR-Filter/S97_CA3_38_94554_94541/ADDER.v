module Adder13Bit(
	input [12:0]A, B,
	output [12:0]Out
);
	assign Out = A + B;
endmodule

module Adder13BitSigned(
	input [12:0]A,
	input signed [12:0] B,
	output [12:0]Out
);
	assign Out = A + B;
endmodule

module AdderTB();
	reg [12:0] A, B;
	wire [12:0] Out;
	Adder13BitSigned a1(A, B, Out);

	initial begin
		A = 13'b1000000000001;
		B = 13'b1111111111111;
		#50;
		A = 13'b0000000000001;
		B = 13'b0000011101010;
		#50;
		$stop;
	end
endmodule