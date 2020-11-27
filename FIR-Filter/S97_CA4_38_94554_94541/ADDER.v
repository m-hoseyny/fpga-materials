module Adder12Bit(
	input [11:0]A, B,
	output [11:0]Out
);
	assign Out = A + B;
endmodule

module Adder12BitSigned(
	input [11:0]A,
	input signed [11:0] B,
	output [11:0]Out
);
	assign Out = A + B;
endmodule

module AdderTB();
	reg [11:0] A, B;
	wire [11:0] Out;
	Adder12BitSigned a1(A, B, Out);

	initial begin
		A = 12'b100000000001;
		B = 12'b111111111111;
		#50;
		A = 12'b000000000001;
		B = 12'b000011101010;
		#50;
		$stop;
	end
endmodule