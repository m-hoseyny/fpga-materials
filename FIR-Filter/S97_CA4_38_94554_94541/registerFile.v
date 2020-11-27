module registerFile(
	input [2:0] readRegister1, readRegister2, writeRegister,
	input clk, rst, regWrite,
	input [7:0]writeData,
	output [7:0] readData1, readData2
);
	reg [7:0]mem[0:7];
	integer i;

	always @(negedge clk or posedge rst) begin
		if (rst) begin
            for (i = 0; i < 8; i = i + 1)
                mem[i] = 8'b0;
        end
        else if (regWrite)
            mem[writeRegister] = writeData;
        mem[0] = 8'b0;
	end

	assign readData1 = mem[readRegister1];
    assign readData2 = mem[readRegister2];

endmodule

module registerFileTB();
	reg [2:0] readRegister1, readRegister2, writeRegister;
	reg clk, rst, regWrite;
	reg [7:0]writeData;
	wire [7:0] readData1, readData2;

  	registerFile regFile(readRegister1, readRegister2, writeRegister, clk, rst, regWrite, writeData, readData1, readData2);
  
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
	    readRegister1 = 3'b001;
	    readRegister2 = 3'b010;
	    regWrite = 1'b0;
	    #400;
	    writeRegister = 3'b001;
	    writeData = 8'b00010101;
	    readRegister1 = 3'b011;
	    readRegister2 = 3'b100;
	    regWrite = 1'b1;
	    #400;
	    readRegister1 = 3'b001;
	    readRegister2 = 3'b010;
	    regWrite = 1'b0;
	    #400;
  	end
endmodule