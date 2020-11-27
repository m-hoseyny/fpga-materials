module HazardUnit(
	input [2:0] r1ID,
	input [2:0] r2ID,
	input [2:0] rdEX,
	input [1:0] jType,
	input memReadEX,
	output reg stallID,
	output reg stallPC,
	output reg flush
);
	always @(*) begin
		{stallID, stallPC, flush} = 3'b0;
		// stall
		if (memReadEX && (rdEX == r1ID || rdEX == r2ID))
			{stallID, stallPC} = 2'b11;
		// flush
		if (jType != 2'b00 && ~stallID)
			flush = 1'b1;
	end
endmodule