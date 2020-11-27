module ripple_counter_TB();
	
	reg clk, toggle, rst;
	wire [3:0] count;
	ripple_counter rc(clk, toggle, rst, count);
	
	initial begin
		toggle = 1'b0;
		repeat(100) #15 toggle = ~toggle;
	
	end
	
  initial begin
    clk = 1'b0;
    rst = 1'b1;
    repeat(4) #10 clk = ~clk;
    rst = 1'b0;
    repeat(200) #10 clk = ~clk; // generate a clock
    $stop;
  end

endmodule