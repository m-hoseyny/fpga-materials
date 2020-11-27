`timescale 1ns / 1ps
module tb_Rx ();
	wire data_ready;
	wire [7:0]RxD_out;
	reg clk, rst_n, nx_boud_rate, RxD;

	Rx inst_Rx (
			.clk          (clk),
			.rst_n        (rst_n),
			.nx_boud_rate (nx_boud_rate),
			.RxD          (RxD),
			.data_ready   (data_ready),
			.RxD_out      (RxD_out)
		);



	Baud_Rate_Generator #(
			.SYSTEM_CLOCK(50000000/4)
		) inst_Baud_Rate_Generator (
			.clk       (clk),
			.rst_n     (rst_n),
			.baud_rate (nx_boud_rate)
		);

	initial begin
		clk = 0;
		forever #10 clk <= ~clk;
	end

	initial begin
		rst_n = 0;
		#15;
		rst_n = 1;
		#15;
		repeat (10) #1 begin
			RxD = 0;
			#10000;
			RxD = 1;
			#10000;
			RxD = 0;
			#10000;
			RxD = 1;
			#10000;
		end

	end // initial


endmodule