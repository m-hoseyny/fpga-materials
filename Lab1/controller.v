module controller (
	input clk,    // Clock
	input rst_n,  // Asynchronous reset active low
	input data_ready,
	input outputValid,
	input busy,
	output reg inputValid,
	output reg TxD_start,
	output reg sel, ld1, ld2
);
	
	parameter GetData1 = 4'd0, GetData2 = 4'd1, FIRCalculation = 4'd2, SendData1 = 4'd3, Busy1 = 4'd4,
			  SendData2 = 4'd5, Busy2 = 4'd6, InputValidStage = 4'd7;

	reg [15:0]IOData;
	reg [7:0] IOData_8;

	reg [3:0]ps;

	always @(posedge clk) begin : proc_ps
		if(~rst_n) begin
			ps <= 4'd0;
		end else begin
			case(ps)
			GetData1:
			begin
				if(data_ready)
				begin
					ps <= GetData2;
				end
				else begin
					ps <= GetData1;
				end
			end

			GetData2:
				begin
				if(data_ready)
				begin
					ps <= InputValidStage;
				end
				else begin
					ps <= GetData2;
				end
			end

			InputValidStage:
			begin
				ps <= FIRCalculation;
			end

			FIRCalculation:
			begin
				if(outputValid)
				begin
					ps <= SendData1;
				end
				else begin
					ps <= FIRCalculation;
				end

			end

			SendData1:
			begin
				if(busy)
				begin
					ps <= Busy1;
				end
				else begin
					ps <= SendData1;
				end
			end

			Busy1:
			begin
				if(busy)
				begin
					ps <= Busy1;
				end
				else begin
					ps <= SendData2;
				end
			end

			SendData2:
			begin
				if(busy)
				begin
					ps <= Busy2;
				end
				else begin
					ps <= SendData2;
				end
			end

			Busy2:
			begin
				if(busy)
				begin
					ps <= Busy2;
				end
				else begin
					ps <= GetData1;
				end
			end


		endcase // ps
		end
	end

	always @(*) begin : proc_combitional
	{ld1, ld2, sel, inputValid, TxD_start} = 5'b00001;
		case(ps)
			GetData1:
			begin 
				if(data_ready)
					ld1 = 1;
				inputValid = 0;
			end
			GetData1:
			begin 
				ld1 = 0;
				if(data_ready)
					ld2 = 1;
				inputValid = 0;
			end
			InputValidStage:
			begin
				ld2 = 0;
				inputValid = 1;
			end

			FIRCalculation:
			begin
				inputValid = 0;
			end

			SendData1:
			begin
				sel = 0;
				if(busy)
				begin
					TxD_start = 1;
				end
				else begin
					TxD_start = 0;
				end
			end

			SendData2:
			begin
				sel = 1;
				if(busy)
				begin
					TxD_start = 1;
				end
				else begin
					TxD_start = 0;
				end
			end
		endcase // ps



	end










endmodule








