module MultiCycle(input clk, rst);
  
  wire TRLD, IorD, pcWrite, pcWriteCond, IRLD, memWrite, memRead, wrSrc, DILD, regSrc, regWrite, pcSrc, ALUSrcb;
  wire [1:0] ALUOP, WDSrc;
  wire [3:0] opCode;
  wire [2:0]CZNOut;
  
  DP dp(clk, rst,
        TRLD, IorD, pcWrite, pcWriteCond, IRLD, memWrite, memRead, wrSrc,DILD, regSrc, regWrite, pcSrc, ALUSrcb, 
        ALUOP, WDSrc,
        opCode);
  controller cu(clk, rst,
  opCode,TRLD, pcSrc,pcWrite,IorD,pcWriteCond, memWrite, memRead, IRLD, DILD, regSrc, regWrite, ALUSrcb, wrSrc,
  WDSrc, ALUOP);
  
endmodule

module MultiCycleTB();
 	reg clk, rst;
  
  	MultiCycle p(clk, rst);
  	initial begin
	  	clk=1;
    	repeat (400)
    	#200 clk=~clk;
	end
	
	initial begin
	  	rst = 1;
	  	#200;
	  	rst = 0;
	  	#400;
	end
endmodule



