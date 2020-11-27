module MUX2Bit(
	input [1:0]A, B,
	input sel,
    output [1:0]Out
);
	assign Out = (sel) ? B : A;
endmodule

module MUX8Bit(
	input [7:0]A, B,
	input sel,
    output [7:0]Out
);
	assign Out = (sel) ? B : A;
endmodule

module MUX8Bit3(
	input [7:0]A, B, C,
	input [1:0]sel,
    output [7:0]Out
);
	assign Out = (sel == 2'b00) ? A :
				(sel == 2'b01) ? B :
				(sel == 2'b10) ? C :
				(sel == 2'b11) ? 1'bz : 1'bz;
endmodule

module MUX13Bit(
	input [12:0]A, B,
	input sel,
    output [12:0]Out
);
	assign Out = (sel) ? B : A;
endmodule

module MUX1Bit(
	input A, B, C, D,
	input [1:0]sel,
    output Out
);
	assign Out = (sel == 2'b00) ? A :
  				 (sel == 2'b01) ? B :
  				 (sel == 2'b10) ? C :
  				 (sel == 2'b11) ? D : 1'bz;
endmodule


module MUXTB();
	reg [11:0] A, B, C, D;
	reg [1:0] sel;
	wire [11:0]out;
	MUX12Bit m1(A, B, C, D, sel, out);

	initial begin
		A = 12'b000000000000;
		B = 12'b000000000001;
		C = 12'b000000000010;
		D = 12'b000000000011;
		sel = 2'b00;
		#50;
		A = 12'b000000000000;
		B = 12'b000000000001;
		C = 12'b000000000010;
		D = 12'b000000000011;
		sel = 2'b01;
		#50;
		A = 12'b000000000000;
		B = 12'b000000000001;
		C = 12'b000000000010;
		D = 12'b000000000011;
		sel = 2'b10;
		#50;
		A = 12'b000000000000;
		B = 12'b000000000001;
		C = 12'b000000000010;
		D = 12'b000000000011;
		sel = 2'b11;
		#50;
		$stop;
	end
endmodule