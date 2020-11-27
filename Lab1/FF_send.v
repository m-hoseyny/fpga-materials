module FF_send(
	input clk, rst_n, sel,
	input [15:0]dataIn,
	output [7:0]dataOut

	);

	reg [15:0]data;

	always @(posedge clk or negedge rst_n) begin : proc_reg
		if(~rst_n) begin
			data <= 0;
		end else begin
			data <= dataIn;
		end
	end

	assign dataOut = sel ? data[15:8] : data[7:0];


endmodule // FF_send