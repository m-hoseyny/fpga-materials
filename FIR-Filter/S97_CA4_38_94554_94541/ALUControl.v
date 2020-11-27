module ALUControl(
	input [1:0]ALUOP,
	input [2:0]fn,
	output reg[3:0]ALUOUT,
	output reg ld
);
	parameter [2:0] ADD = 3'b000, ADDC = 3'b001, SUB = 3'b010, SUBC = 3'b011, AND = 3'b100, OR = 3'b101, XOR = 3'b110, MASK = 3'b111;
	parameter [1:0] SHL = 2'b00, SHR = 2'b01, ROL = 2'b10, ROR = 2'b11;
	always @(ALUOP, fn) begin
		ld = 1'b0;
		case(ALUOP)
			1 : begin
					case(fn)
						ADD : begin
								ALUOUT = {1'b0, ADD};
								ld = 1'b1;
							  end
						ADDC: begin
								ALUOUT = {1'b0, ADDC};
								ld = 1'b1;
							  end
						SUB : begin
								ALUOUT = {1'b0, SUB};
								ld = 1'b1;
							  end
						SUBC: begin
								ALUOUT = {1'b0, SUBC};
								ld = 1'b1;
							  end
						AND : begin
								ALUOUT = {1'b0, AND};
								ld = 1'b1;
							  end
						OR  : begin
								ALUOUT = {1'b0, OR};
								ld = 1'b1;
							  end
						XOR : begin
								ALUOUT = {1'b0, XOR};
								ld = 1'b1;
							  end
						MASK: begin
								ALUOUT = {1'b0, MASK};
								ld = 1'b1;
							  end
					endcase
				end
			2 : begin
					case(fn[1:0])
						SHL: begin
								ALUOUT = {2'b10, SHL};
								ld = 1'b1;
							 end
						SHR: begin
								ALUOUT = {2'b10, SHR};
								ld = 1'b1;
							 end
						ROL: begin
								ALUOUT = {2'b10, ROL};
								ld = 1'b1;
							 end
						ROR: begin
								ALUOUT = {2'b10, ROR};
								ld = 1'b1;
							 end
					endcase
				end
			3 : begin
					ALUOUT = 4'b1100;
				end
		endcase
	end
endmodule

module ALUCTB();
	reg [1:0]ALUOP;
	reg [2:0]fn;
	wire[3:0]ALUOUT;
	wire ld;

	ALUControl a1(ALUOP, fn, ALUOUT, ld);
	initial begin
		ALUOP = 2'b00;
		fn = 3'b000;
		#50;
		ALUOP = 2'b00;
		fn = 3'b010;
		#50;
		ALUOP = 2'b00;
		fn = 3'b110;
		#50;
		ALUOP = 2'b00;
		fn = 3'b111;
		#50;
		ALUOP = 2'b01;
		fn = 3'b001;
		#50;
		ALUOP = 2'b01;
		fn = 3'b011;
		#50;
		ALUOP = 2'b10;
		fn = 3'b000;
		#50;
		ALUOP = 2'b10;
		fn = 3'b001;
		#50;
	end
endmodule