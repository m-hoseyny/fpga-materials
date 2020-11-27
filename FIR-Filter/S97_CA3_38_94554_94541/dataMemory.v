module dataMemory (
  	input clk, rst,
	input [12:0] addr,
	input [7:0] writeData,
	input memWrite, memRead,
	output [7:0] readData
);
	
	reg [7:0]mem[0:8191];  // 256 words of 8-bit memory
	//initial $readmemb("memory.txt", mem);
	integer i;

	always @(posedge clk, posedge rst) begin
		if ( rst ) begin
	      for ( i = 0 ; i < 8191 ; i = i + 1 )
	        mem[i] <= 8'bx; 
	    end
	  	else if (memWrite)
	   		mem[addr] <= writeData;
			
		mem[13'd0] <= 8'b11100010;

	   	mem[13'd1] <= 8'b01000011;
	   	mem[13'd2] <= 8'b11101000;

	   	mem[13'd3] <= 8'b01000011;
	   	mem[13'd4] <= 8'b11101001;

		mem[13'd5] <= 8'b01000011;
	   	mem[13'd6] <= 8'b11101010;

		mem[13'd7] <= 8'b01000011;
	   	mem[13'd8] <= 8'b11101011;

		mem[13'd9] <= 8'b01000011;
	   	mem[13'd10] <= 8'b11101100;

		mem[13'd11] <= 8'b01000011;
	   	mem[13'd12] <= 8'b11101101;

		mem[13'd13] <= 8'b01000011;
	   	mem[13'd14] <= 8'b11101110;

		mem[13'd15] <= 8'b01000011;
	   	mem[13'd16] <= 8'b11101111;

		mem[13'd17] <= 8'b00100111;
	   	mem[13'd18] <= 8'b11010000;

	   	mem[13'd19] <= 8'b10000100;
	   	mem[13'd20] <= 8'b10010100;
	   	mem[13'd21] <= 8'b10000110;
	   	mem[13'd22] <= 8'b10110100;
	   	mem[13'd23] <= 8'b10100100;

	   	mem[13'd24] <= 8'b00000111;
	   	mem[13'd25] <= 8'b11010000;

	   	mem[13'd26] <= 8'b11100000;
	   	mem[13'd27] <= 8'b11000000;
	   	mem[13'd28] <= 8'b00000000;


		mem[13'd1000] <= 8'b00000001;
	   	mem[13'd1001] <= 8'b00000010;
	   	mem[13'd1002] <= 8'b00000011;
	   	mem[13'd1003] <= 8'b00000100;
		mem[13'd1004] <= 8'b00000101;
	   	mem[13'd1005] <= 8'b00000110;
		mem[13'd1006] <= 8'b00000111;
	   	mem[13'd1007] <= 8'b00001000;
	end

	assign readData = memRead ? mem[addr] : 8'bx;
endmodule

module DMTB();
  	reg clk, rst, memRead, memWrite;
  	reg [7:0]address;
  	reg [7:0]writeData;
  	wire [7:0]readData;
  	dataMemory dataMem(address, writeData, memWrite, memRead, clk, rst, readData);
  
  	initial begin
		clk=0;
    	repeat (20)
    	#200 clk=~clk;
	end
	
	initial begin
		rst = 1;
		#200;
	  	writeData = 8'b00000111;
	  	rst = 0;
	  	#200;
	  	memWrite = 0;
		memRead = 1;
		address = 8'b00000000000011;
		#400;
		memWrite = 1;
		memRead = 0;
		address = 12'b0000000000001;
		#400;
		memWrite = 0;
		memRead = 1;
		address = 12'b0000000000010;
		#400;
	end
endmodule
