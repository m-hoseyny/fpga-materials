
`timescale 1ns/1ps

module tb_controller (); /* this is automatically generated */

	logic rst_n;
	logic srst;
	logic clk;

	// clock
	initial begin
		clk = 0;
		repeat(200) #10 clk = ~clk;
	end

	// reset
	initial begin
		rst_n = 0;
		srst = 0;
		#20
		rst_n = 1;
		repeat (5) @(posedge clk);
		srst = 1;
		repeat (1) @(posedge clk);
		srst = 0;
	end

	// (*NOTE*) replace reset, clock, others

	parameter GetData1       = 4'd0;
	parameter GetData2       = 4'd1;
	parameter FIRCalculation = 4'd2;
	parameter SendData1      = 4'd3;
	parameter Busy1          = 4'd4;
	parameter SendData2      = 4'd5;
	parameter Busy2          = 4'd6;

	logic        data_ready;
	logic        outputValid;
	logic  [7:0] DataInRx;
	logic [15:0] DataInFIR;
	logic        busy;
	logic        inputValid;
	logic        TxD_start;
	logic  [7:0] DataOutTx;
	logic [15:0] DataOutFIR;

	controller inst_controller (
			.clk         (clk),
			.rst_n       (rst_n),
			.data_ready  (data_ready),
			.outputValid (outputValid),
			.DataInRx    (DataInRx),
			.DataInFIR   (DataInFIR),
			.busy        (busy),
			.inputValid  (inputValid),
			.TxD_start   (TxD_start),
			.DataOutTx   (DataOutTx),
			.DataOutFIR  (DataOutFIR)
		);

	initial begin
		// do something
		busy = 0;
		data_ready = 0;
		outputValid = 0;
		#103;
		data_ready = 1;
		DataInRx = 8'd15;
		#25;
		data_ready = 0;
		#100;
		data_ready = 1;
		DataInRx = 8'd25;
		#25;
		data_ready = 0;
		#200;
		outputValid = 1;
		DataInFIR = 16'd3865;
		#25;
		outputValid = 0;
		#50;
		busy = 1;
		#50;
		busy = 0;
		#50;
		busy = 1;
		#50;
		busy = 0;
		#50;





	end


endmodule
