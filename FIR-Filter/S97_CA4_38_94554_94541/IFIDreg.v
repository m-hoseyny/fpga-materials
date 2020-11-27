module IFIDReg(
	input clk,
	input rst,
	input flushIFID,
	input stallIFID,
	input [11:0] pcPlusOneIF,
	input [18:0] instIF,
	output reg [11:0] pcPlusOneIFOut,
	output reg [18:0] instIFOut 
);

	always @(posedge clk or posedge rst) begin
		if(rst || flushIFID) begin
			pcPlusOneIFOut <= 12'b0;
			instIFOut <= 19'b0;
		end
		else if(~stallIFID) begin
			pcPlusOneIFOut <= pcPlusOneIF;
			instIFOut <= instIF;
		end
	end

endmodule