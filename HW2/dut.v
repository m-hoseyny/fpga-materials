/* Behavioral Verilog model that acts as the DUT driving asimple req/gnt protocol*/
 
module dut(clk, req, gnt); 
	input  clk,req; 
	output reg gnt; 
 
	initial 
		begin   
			gnt=1'b0; 
		end 
	initial
	begin
	 @ (posedge req);
	     @ (negedge clk); gnt=1'b0;
	   @ (negedge clk); gnt=1'b1;
	 @ (posedge req);
	     @ (negedge clk); gnt=1'b0;
	   @ (negedge clk); gnt=1'b0;
	end
endmodule
