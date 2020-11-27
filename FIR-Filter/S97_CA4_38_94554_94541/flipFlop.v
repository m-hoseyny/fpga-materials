module FlipFlop(
	input D, clk, rst, ld,
	output reg Q
);
	always @(posedge clk, posedge rst) begin
		if(rst)
			Q <= 1'b0;
		else if(ld)
			Q <= D; 
	end 
endmodule

module FFTB();
	reg D, ld;
	reg clk, rst;
	wire Q;
	FlipFlop f1(D, clk, rst, ld, Q);

	initial begin
		clk=0;
	    repeat (10)
	    #200 clk=~clk;
	end

	initial begin
	   rst = 1; 
	   #400;
	   rst = 0;
	   ld = 1;
	   D = 1'b1;
	   #400;
	   ld = 0;
	   D = 1'b0;
	   #400;
	   ld = 1;
	   D = 1'b0;
	   #400;
	end
endmodule