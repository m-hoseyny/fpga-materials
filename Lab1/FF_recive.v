module FF_recive(
	input clk, 
	input rst_n, 
	input ld1, 
	input ld2,
	input [7:0]dataIn,
	output [15:0] dataOut
	);

	reg [7:0]reg1, reg2;

	always @(posedge clk or negedge rst_n) begin : proc_regs
		if(~rst_n) begin
			reg1 <= 0;
			reg2 <= 0;
		end else begin
			if(ld1)
				reg1 <= dataIn;
			if(ld2)
				reg2 <= dataIn;
		end
	end

	assign dataOut = {reg1, reg2};


endmodule


