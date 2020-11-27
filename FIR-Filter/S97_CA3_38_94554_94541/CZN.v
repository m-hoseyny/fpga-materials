module CZN(
  input clk,
  input rst,
  input [2:0]inAddress,
  output reg[2:0] outAddress
);
  always @(posedge clk, posedge rst)begin
    if (rst)
      outAddress <= 3'b0;
    else 
      outAddress <= inAddress;
  end
endmodule

module DI_TB();
  reg clk, rst;
  reg [2:0]inAddress;
  wire [2:0]outAddress;
  
  CZN czn(clk, rst, inAddress, outAddress);
  initial begin
	  clk=0;
    repeat (40)
    #200 clk=~clk;
	end
  
  initial begin
    rst = 1; 
    #400;
    rst = 0; 
    inAddress = 5'b11;
    #400;
    inAddress = 5'b01;
    #400;
  end
endmodule