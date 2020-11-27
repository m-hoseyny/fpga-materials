module ALU(
	input [7:0]A, B,
	input [1:0]ALU_OP,
	input cin,
	output reg[7:0]out,
	output reg cout, zero, neg
);
	always@(A, B, cin, ALU_OP) begin
		out = 8'b0;
	    zero = 0;
	    cout = 0;
		neg = 0;
	    case (ALU_OP)
	      0 : {cout, out} = A + B;
	      1 : {cout, out} = A + B + cin;
	      2 : out = A & B;
	      3 : out = A | B;
	    endcase
	    if(out == 8'b0 && ALU_OP != 4'b1100)
	    	zero = 1;
		if(out[7] == 1)
			neg = 1;
	end
endmodule

module ALUTB();
	reg [7:0]A, B;
	reg [3:0]ALU_OP;
	reg cin;
	wire [7:0]out;
	wire cout, zero, neg;

	ALU a1(A, B, ALU_OP, cin, out, cout, zero, neg);
	initial begin
		A = 8'b00000011;
		B = 8'b00000011;
		cin = 1'b1;
		ALU_OP = 4'b0000;
		#100;
		A = 8'b00000011;
		B = 8'b00000011;
		cin = 1'b1;
		ALU_OP = 4'b0001;
		#100;
		A = 8'b00100011;
		B = 8'b00000011;
		cin = 1'b1;
		ALU_OP = 4'b0010;
		#100;
		A = 8'b00100011;
		B = 8'b00000011;
		cin = 1'b1;
		ALU_OP = 4'b0011;
		#100;
		$stop;
	end
endmodule