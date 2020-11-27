module Control(
	input [4:0]OPCODE,
	output reg memRead, memWrite, memToReg, ALUSrc, RegWrite, RegDst,
	output reg[2:0] jumpType,
	output reg[1:0] ALUOP
);
	always @(OPCODE) begin
		{memRead, memWrite, memToReg, ALUSrc, RegWrite, RegDst} = 6'b0;
		{jumpType, ALUOP} = 5'b0;
		if(OPCODE[4:3] == 2'b00) begin
			ALUOP = 2'b01;
			RegWrite = 1'b1;
		end
		else if(OPCODE[4:3] == 2'b01) begin
			ALUOP = 2'b01;
			ALUSrc = 1'b1;
			RegWrite = 1'b1;
		end
		else if(OPCODE[4:2] == 3'b110) begin
			ALUOP = 2'b10;
			ALUSrc = 1'b1;
			RegWrite = 1'b1;
		end
		else if(OPCODE[4:2] == 3'b100) begin
			case(OPCODE[1:0])
				0: begin
						ALUOP = 2'b11;
						ALUSrc = 1'b1;
						memRead = 1'b1;
						memToReg = 1'b1;
						RegWrite = 1'b1;
				   end
				1: begin
						ALUOP = 2'b11;
						ALUSrc = 1'b1;
						memWrite = 1'b1;
				   end
			endcase
		end
		else if(OPCODE[4:2] == 3'b101) begin
			case(OPCODE[1:0])
				0: begin // zero
						jumpType = 3'b001;
				   end
				1: begin // not zero
						jumpType = 3'b010;
				   end
				2: begin // cout
						jumpType = 3'b011;
				   end
				3: begin // not cout
						jumpType = 3'b100;
				   end
			endcase
		end
		else if(OPCODE == 5'b11100) begin // jmp
			jumpType = 3'b101;
		end
		else if(OPCODE == 5'b11101) begin // jsb
			jumpType = 3'b110;
		end
		else if(OPCODE == 5'b11110) begin // ret
			jumpType = 3'b111;
		end
	end
endmodule