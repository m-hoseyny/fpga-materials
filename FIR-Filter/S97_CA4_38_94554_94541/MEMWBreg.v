module MEMWBReg(
	// inputs
	input clk,
	input rst,
		// WB
	input memToRegMEM,
	input regWriteMEM,
		// comb
	input [7:0] readDataMEM,
	input [7:0] aluResMEM,
	input [2:0] rdMEM,
	// outputs
		// WB
	output reg memToRegMEMOut,
	output reg regWriteMEMOut,
		// comb
	output reg [7:0] readDataMEMOut,
	output reg [7:0] aluResMEMOut,
	output reg [2:0] rdMEMOut
);

	always @(posedge clk or posedge rst) begin
		if(rst) begin
			memToRegMEMOut 	<= 1'b0;
			regWriteMEMOut 	<= 1'b0;
			readDataMEMOut 	<= 8'b0;
			aluResMEMOut 	<= 8'b0;
			rdMEMOut 		<= 3'b0;
		end
		else begin
			memToRegMEMOut 	<= memToRegMEM;
			regWriteMEMOut 	<= regWriteMEM;
			readDataMEMOut 	<= readDataMEM;
			aluResMEMOut 	<= aluResMEM;
			rdMEMOut  		<= rdMEM;
		end
	end

endmodule