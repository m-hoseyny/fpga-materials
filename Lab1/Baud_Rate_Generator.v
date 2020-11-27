`timescale 1ns / 1ps
module Baud_Rate_Generator (
	input clk,    // Clock
	input rst_n,  // Asynchronous reset active low
	output reg baud_rate
	
);

parameter SYSTEM_CLOCK = 50000000;
parameter COUNTER_LENGTH = SYSTEM_CLOCK/115200;


reg [$clog2(COUNTER_LENGTH):0] cnt;

always @(posedge clk or negedge rst_n) begin : proc_cnt
	if(~rst_n) begin
		cnt <= 0;
		baud_rate <= 0;
	end else begin
		cnt <= cnt + 1;
		if (cnt == COUNTER_LENGTH - 1) begin
			baud_rate <= 1;
			cnt <= 0;
		end 
		else begin
			cnt <= cnt + 1;
			baud_rate <= 0;
		end

	end
end



endmodule


module BRG_TB ();

	reg clk, rst_n;
	wire baud_rate;

	Baud_Rate_Generator #(
			.SYSTEM_CLOCK(50000000)
		) inst_Bound_Rate_Generator (
			.clk        (clk),
			.rst_n      (rst_n),
			.baud_rate (baud_rate)
		);


	initial begin
		clk = 0;
		repeat (11000) #10 clk <= ~clk;
	end

	initial begin
		rst_n = 0;
		#15;
		rst_n = 1;
	end

endmodule