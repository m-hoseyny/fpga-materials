module IDEXReg(
	// inputs
	input clk,
	input rst,
	input flushIDEX,
		// EX
	input [2:0] jTypeID,
	input [1:0] aluOpID,
	input aluSrcID,
		// MEM
	input memReadID, memWriteID,
		// WB
	input memToRegID,
	input regWriteID,
		// comb
	input [11:0] pcPlusOneID,
	input [11:0] bAddressID,
	input [11:0] jAdressID,
	input [7:0] readData1ID, readData2ID,
	input [2:0] fnID,
	input [2:0] r1ID, r2ID, rdID,
	// outputs
		// EX
	output reg [2:0] jTypeIDOut,
	output reg [1:0] aluOpIDOut,
	output reg aluSrcIDOut,
		// MEM
	output reg memReadIDOut, memWriteIDOut,
		// WB
	output reg memToRegIDOut,
	output reg regWriteIDOut,
		// comb
	output reg [11:0] pcPlusOneIDOut,
	output reg [11:0] bAddressIDOut,
	output reg [11:0] jAdressIDOut,
	output reg [7:0] readData1IDOut, readData2IDOut,
	output reg [2:0] fnIDOut,
	output reg [2:0] r1IDOut, r2IDOut, rdIDOut
);

	always @(posedge clk or posedge rst) begin
		if(rst || flushIDEX) begin
		    jTypeIDOut 		<= 3'b0;
			aluOpIDOut 		<= 2'b0;
			aluSrcIDOut 	<= 1'b0;
			memReadIDOut 	<= 1'b0; 
			memWriteIDOut 	<= 1'b0;
			memToRegIDOut 	<= 1'b0;
			regWriteIDOut 	<= 1'b0;
			pcPlusOneIDOut 	<= 12'b0;
			bAddressIDOut 	<= 12'b0;
			jAdressIDOut 	<= 12'b0;
			readData1IDOut 	<= 8'b0;
			readData2IDOut 	<= 8'b0;
			fnIDOut 		<= 3'b0;
			r1IDOut 		<= 3'b0; 
			r2IDOut 		<= 3'b0; 
			rdIDOut 		<= 3'b0;
		end
		else begin
			jTypeIDOut 		<= jTypeID;
			aluOpIDOut 		<= aluOpID;
			aluSrcIDOut 	<= aluSrcID;
			memReadIDOut 	<= memReadID; 
			memWriteIDOut 	<= memWriteID;
			memToRegIDOut 	<= memToRegID;
			regWriteIDOut 	<= regWriteID;
			pcPlusOneIDOut 	<= pcPlusOneID;
			bAddressIDOut 	<= bAddressID;
			jAdressIDOut 	<= jAdressID;
			readData1IDOut 	<= readData1ID;
			readData2IDOut 	<= readData2ID;
			fnIDOut 		<= fnID;
			r1IDOut 		<= r1ID; 
			r2IDOut 		<= r2ID; 
			rdIDOut 		<= rdID;
		end
	end

endmodule