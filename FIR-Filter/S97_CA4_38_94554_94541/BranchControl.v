module BranchControl(
	input [2:0] jType,
	input c,
	input z,
	output reg [1:0] addrSrc,
	output reg push, pop
);
	always @(jType) begin
		{addrSrc, push, pop} = 4'b0000;
		if (jType == 3'b001) begin
			if(z)
				addrSrc = 2'b10;
		end
		else if (jType == 3'b010) begin
			if(~z)
				addrSrc = 2'b10;
		end
		else if (jType == 3'b011) begin
			if(c)
				addrSrc = 2'b10;
		end
		else if (jType == 3'b100) begin
			if(~c)
				addrSrc = 2'b10;
		end
		else if (jType == 3'b101) begin
			addrSrc = 2'b11;
		end
		else if (jType == 3'b110) begin
			addrSrc = 2'b11;
			push = 1'b1;
		end
		else if (jType == 3'b111) begin
			addrSrc = 2'b01;
			pop = 1'b1;
		end
	end
endmodule