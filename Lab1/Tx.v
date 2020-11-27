module Tx
	(
		input clk,
		input rst,
		input TxD_start,
		input [7:0] TxD_data,
		input BaudTick,
		output reg TxD,
		output reg Busy
	);

	parameter IDLE = 2'd0;
	parameter SENDDATA = 2'd1;
	parameter ENDBIT = 2'd2;
	reg [1:0] state;
	reg [3:0] cnt;
	reg [7:0] input_Data;

	always @(posedge clk) begin
		if(~rst)
		begin
			cnt <= 4'd0;
		end
		else begin
			case (state)
				IDLE:
				begin
					cnt <= 4'd0;
					if(~TxD_start)					
						state <= SENDDATA;
				end
				SENDDATA:
				begin
					if(BaudTick == 1'b1) begin 
						if(cnt < 4'd8)
							state <= SENDDATA;
						else state <= ENDBIT;
						cnt <= cnt + 1;
					end
				end
				ENDBIT:
				begin
					if(BaudTick == 1'b1)
						state <= IDLE;
				end
				default : state <= IDLE;
			endcase
		end
	end

	always @(*) begin
		{TxD} = 1'b1;
		case (state)
			IDLE:
			begin
				TxD = 1'b1;
				Busy = 1'b0;
				if(~TxD_start) begin
					input_Data = TxD_data;
					TxD = 1'b0;
				end
			end
			SENDDATA:
			begin
				Busy = 1'b1;
				if(BaudTick == 1'b1) begin 
					if(cnt < 4'd8) begin 
						TxD = TxD_data[cnt];
					end
				end
			end
			ENDBIT:
			begin
				TxD = 1'b1;
				Busy = 1'b1;
			end
			default : /* default */;
		endcase
	end
endmodule // Tx

module Tx_TB ();

	reg clk, rst, TxD_start;
	reg [7:0] TxD_data;
	wire TxD, Busy;
	wire baud_rate;

	Tx inst_Tx (
		.clk       (clk),
		.rst       (rst),
		.TxD_start (TxD_start),
		.TxD_data  (TxD_data),
		.BaudTick  (baud_rate),
		.TxD       (TxD),
		.Busy      (Busy)
	);

	Baud_Rate_Generator #(
			.SYSTEM_CLOCK(50000000)
		) inst_Bound_Rate_Generator (
			.clk        (clk),
			.rst_n      (rst),
			.baud_rate (baud_rate)
		);

	initial begin
		clk = 0;
		repeat(20000) #10 clk = ~clk;
	end // initial

	initial begin
		rst = 0;
		TxD_data = 8'b00111000;
		TxD_start = 1;
		#15;
		rst = 1;
		#30000;
		TxD_start = 0;
		#5;
	end


endmodule