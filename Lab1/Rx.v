`timescale 1ns / 1ps
module Rx (
	input clk,    // Clock
	input rst_n,  // Asynchronous reset active low
	input nx_boud_rate, // Clock Enable
	input RxD,
	output reg data_ready,
	output reg [7:0] RxD_out	
);


parameter START = 2'd0;
parameter CHECK_START = 2'd3;
parameter PROC = 2'd1;
parameter DATA_READY = 2'd2;

reg [2:0]boud_cnt_captcher;
reg [3:0]data_cnt;
// reg count_en;
reg [2:0]ps, ns;
// reg rst_n_boud_cnt;

// always @(negedge rst_n or posedge nx_boud_rate) begin : proc_boud_cnt_chapter
// 	if(~rst_n) begin
// 		boud_cnt_captcher <= 0;
// 	end else begin
// 		if(nx_boud_rate) begin
// 			if (count_en)
// 				boud_cnt_captcher <= boud_cnt_captcher + 1;
// 		end
// 		if(rst_n_boud_cnt)
// 			boud_cnt_captcher <= 2'b0;

// 	end
// end


// always @(negedge rst_n or posedge boud_cnt_captcher) begin : proc_data_cnt
// 	if(~rst_n) begin
// 		data_cnt <= 0;
// 	end else begin
// 		if(boud_cnt_captcher == 3)
// 			data_cnt <= data_cnt + 1;
// 		if(data_cnt == 4'd8)
// 			data_cnt <= 0;		
// 	end
// end

always @(posedge clk) begin : proc_ps
	if(~rst_n) begin
		ps <= START;
	end else begin
		ps <= ns;
	end
end

always @(posedge clk) begin : proc_comb
	data_ready = 0;
	// count_en = 0;
	// rst_n_boud_cnt = 0;
	if(~rst_n) begin
		boud_cnt_captcher = 0;
		data_cnt = 0;
	end
	// if(boud_cnt_captcher == 3)
	// 	data_cnt = data_cnt + 1;
	// if(data_cnt == 4'd9)
	// 	data_cnt = 0;	
	if(boud_cnt_captcher == 3'd4)
		boud_cnt_captcher = 0;	
	case (ps)
		START:
		begin
			if(~RxD)
			begin
				ns = CHECK_START;
				boud_cnt_captcher = 0;
			end
			else
			begin
				ns = START;
			end
		end
		CHECK_START:
		begin
			
			data_cnt = 0;	
			if (nx_boud_rate) begin
				if(boud_cnt_captcher >= 3'd1) begin
					if(~RxD) begin
						ns = PROC;
						boud_cnt_captcher = 0;
						data_cnt = 0;		
					end
					else
					begin
						ns = START;
					end
				end
				else begin
					ns = CHECK_START;
					boud_cnt_captcher = boud_cnt_captcher + 1;
				end
			end
		end
		PROC:
		begin
			if (nx_boud_rate) begin
				if(data_cnt<4'd1)
					RxD_out = 8'b0;	
				boud_cnt_captcher = boud_cnt_captcher + 1;
				if(data_cnt < 4'd9) 
				begin
					if(boud_cnt_captcher == 3'b01)
					begin 
						RxD_out[data_cnt-4'd1] = RxD;
						data_cnt = data_cnt + 1;
					end
					ns <= PROC;
				end
				else
				begin
					if(data_cnt == 4'd9) begin
						data_cnt <= 0;	
						boud_cnt_captcher = 0;
						ns = DATA_READY;
					end
				end
			end
		end
		DATA_READY:
		begin
			data_ready = 1;
			ns = START;
		end
	endcase
end




endmodule