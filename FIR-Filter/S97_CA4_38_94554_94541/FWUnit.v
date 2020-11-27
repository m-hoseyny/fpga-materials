module FWUnit(
	input [2:0] rdMEM,
	input [2:0] rdWB,
	input [2:0] rdEX,
	input [2:0] r1,
	input [2:0] r2,
	input regWriteMEM,
	input regWriteWB,
	input memWriteEX,
	output reg [1:0] FWselA,
	output reg [1:0] FWselB
);
	
	always @(*) begin
		{FWselA, FWselB} = 4'b0;

		// MEM
		if (regWriteMEM &&  rdMEM == r1  && rdMEM != 3'b0)
			FWselA = 2'b01;
		if (regWriteMEM &&  rdMEM == r2  && rdMEM != 3'b0)
			FWselB = 2'b01;
		if (regWriteMEM &&  rdMEM == rdEX  && memWriteEX && rdMEM != 3'b0)
			FWselB = 2'b01;		

		// WB
		if (regWriteWB &&  rdWB == r1  && rdWB != 3'b0)
			FWselA = 2'b10;
		if (regWriteWB &&  rdWB == r2  && rdWB != 3'b0)
			FWselB = 2'b10;	
		if (regWriteWB &&  rdWB == rdEX  && memWriteEX && rdWB != 3'b0)
			FWselB = 2'b10;	
	end
endmodule