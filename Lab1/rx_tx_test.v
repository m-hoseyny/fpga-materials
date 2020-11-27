module rx_tx_test();

	reg clk, rst;
	reg TxD_start;
	wire BaudTick, Boud4tick;
	reg [7:0]TxD_data;
	wire TxD;
	wire data_ready;
	wire [7:0] Rx_data;
	Baud_Rate_Generator #(
			.SYSTEM_CLOCK(50000000)
		) inst_Baud_Rate_Generator (
			.clk       (clk),
			.rst_n     (rst),
			.baud_rate (BaudTick)
		);
	Baud_Rate_Generator #(
			.SYSTEM_CLOCK(50000000/4)
		) inst_Baud_Rate_4Generator (
			.clk       (clk),
			.rst_n     (rst),
			.baud_rate (Boud4tick)
		);

	Tx inst_Tx (
		.clk       (clk),
		.rst       (rst),
		.TxD_start (TxD_start),
		.TxD_data  (TxD_data),
		.BaudTick  (BaudTick),
		.TxD       (TxD),
		.Busy      (Busy)
	);

	Rx inst_Rx (
		.clk          (clk),
		.rst_n        (rst),
		.nx_boud_rate (Boud4tick),
		.RxD          (TxD),
		.data_ready   (data_ready),
		.RxD_out      (Rx_data)
	);






	initial begin
		clk = 0;
		repeat(100000) #10 clk = ~clk;
	end // initial

	initial begin
		rst = 0;
		TxD_data = 8'b00111000;
		#15;
		rst = 1;
		#40;
		TxD_start = 0;
		#5;
		TxD_start = 1;
	end




endmodule