module stack(
	input clk, rst, push, pop,
	input [11:0]addrIn,
	output reg[11:0]addrOut
);
	reg [11:0] stack [0:7];
	reg [2:0] ptr;
	initial ptr = 0;

	always @(posedge clk, posedge rst) begin
		if (rst)
			ptr = 0;
		else if (push)
			ptr <= ptr + 1;
		else if (pop && ptr > 0)
			ptr <= ptr - 1;
	end

	always @(push, pop) begin
		if(push)
			stack[ptr] <= addrIn;
		if(pop && ptr > 0)
			addrOut <= stack[ptr - 1];
		else 
			addrOut <= addrIn;
	end
endmodule

module stackTB();
	reg clk, rst, push, pop;
	reg [11:0] addrIn;
	wire [11:0] addrOut;

	stack s1(clk, rst, push, pop, addrIn, addrOut);
	initial begin
		clk=0;
	    repeat (40)
	    #200 clk=~clk;
	end
	initial begin
    	rst = 1; 
    	#400;
    	rst = 0; 
    	addrIn = 12'b000000111111;
    	#400;
    	push = 1;
    	#400;
    	addrIn = 12'b000111111111;
    	push = 1;
    	#400;
    	push = 0;
    	pop = 1;
    	#400;
    	push = 0;
    	pop = 1;
    	#400;
    	push = 0;
    	pop = 0;
    	#400;
  	end

endmodule