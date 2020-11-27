module dataMemory (
	input [7:0] addr,
	input [7:0] writeData,
	input memWrite, memRead,
	input clk, rst,
	output [7:0] readData
);
	
	reg [7:0]mem[0:255];  // 256 words of 8-bit memory
	integer i;

	always @(negedge clk, posedge rst) begin
		if ( rst ) begin
	      for ( i = 0 ; i < 256 ; i = i + 1 )
	        mem[i] <= 8'b0; 
	    end
	  	else if (memWrite)
	   		mem[addr] <= writeData;

	   	mem[8'd100] <= 8'b10000000;
	   	mem[8'd101] <= 8'b00000001;
	   	mem[8'd102] <= 8'b10000001;
	   	mem[8'd103] <= 8'b00000000;
	   	// mem[8'd104] <= 8'b10011000;
	   	// mem[8'd105] <= 8'b00100001;
	   	// mem[8'd106] <= 8'b10000001;
	   	// mem[8'd107] <= 8'b11111110;
	   	// mem[8'd108] <= 8'b10001000;
	   	// mem[8'd109] <= 8'b00010001;
	   	// mem[8'd110] <= 8'b10000001;
	   	// mem[8'd111] <= 8'b00001000;
	   	// mem[8'd112] <= 8'b10000000;
	   	// mem[8'd113] <= 8'b00010001;
	   	// mem[8'd114] <= 8'b10000001;
	   	// mem[8'd115] <= 8'b11111101;
	   	// mem[8'd116] <= 8'b10000110;
	   	// mem[8'd117] <= 8'b00000001;
	   	// mem[8'd118] <= 8'b10000001;
	   	// mem[8'd119] <= 8'b00110000;
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
		address = 8'b00000011;
		#400;
		memWrite = 1;
		memRead = 0;
		address = 12'b00000001;
		#400;
		memWrite = 0;
		memRead = 1;
		address = 12'b00000001;
		#400;
	end
endmodule
