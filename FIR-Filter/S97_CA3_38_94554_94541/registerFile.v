module registerFile(
	input clk, rst, regWrite,
	input [1:0] readRegister1, readRegister2, writeRegister,
	input [7:0]writeData,
	output [7:0] readData1, readData2
);
	reg [7:0]mem[0:3];
	integer i;

	always @(posedge clk, posedge rst) begin
		if (rst) begin
            for (i = 0; i < 4; i = i + 1)
                mem[i] = 8'b0;
        end
        else if (regWrite)
            mem[writeRegister] = writeData;
	end

	assign readData1 = mem[readRegister1];
    assign readData2 = mem[readRegister2];

endmodule

module registerFileTB();
	reg [1:0] readRegister1, readRegister2, writeRegister;
	reg clk, rst, regWrite;
	reg [7:0]writeData;
	wire [7:0] readData1, readData2;

  	registerFile regFile(clk, rst, regWrite, writeData, readRegister1, readRegister2, writeRegister, readData1, readData2);
  
	initial begin
		clk=0;
    	repeat (40)
    	#200 clk=~clk;
	end
  
  	initial begin
    	#200;
    	rst = 1; 
	    #400;
	    rst = 0;
	    readRegister1 = 2'b01;
	    readRegister2 = 2'b10;
	    regWrite = 1'b0;
	    #400;
	    writeRegister = 2'b01;
	    writeData = 8'b00010101;
	    readRegister1 = 2'b11;
	    readRegister2 = 2'b00;
	    regWrite = 1'b1;
	    #400;
	    readRegister1 = 2'b01;
	    readRegister2 = 2'b10;
	    regWrite = 1'b0;
	    #400;
  	end
endmodule