module REG8BIT(
  input clk,
  input rst,
  input [7:0]inAddress,
  output reg[7:0] outAddress
);
  always @(posedge clk, posedge rst)begin
    if (rst)
      outAddress <= 8'b0;
    else 
      outAddress <= inAddress;
  end
endmodule

module REG8BIT_TB();
  reg clk, rst;
  reg [12:0]inAddress;
  wire [12:0]outAddress;
  
  REG8BIT reg8bit(clk, rst, inAddress, outAddress);
  initial begin
	  clk=0;
    repeat (40)
    #200 clk=~clk;
	end
  
  initial begin
    rst = 1; 
    #400;
    rst = 0; 
    inAddress = 8'b0000111;
    #400;
    inAddress = 8'b0000011;
    #400;
  end
endmodule