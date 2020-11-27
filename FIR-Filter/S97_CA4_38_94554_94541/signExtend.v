module SE(
	input [7:0] in,
	output [11:0] out
);
	assign out = in[7] ? {4'b1111, in} : {4'b0000, in};
endmodule