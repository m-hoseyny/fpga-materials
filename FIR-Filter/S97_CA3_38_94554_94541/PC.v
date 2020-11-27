module PC(
  input clk,
  input rst,
  input ld,
  input [12:0]inAddress,
  output reg[12:0] outAddress
);
  always @(posedge clk, posedge rst)begin
    if (rst)
      outAddress <= 13'b0;
    else 
      if (ld)
        outAddress <= inAddress;
      else
        outAddress <= outAddress;
  end
endmodule

module PCTB();
  reg clk, rst, ld;
  reg [12:0]inAddress;
  wire [12:0]outAddress;
  
  PC pc(clk, rst, ld, inAddress, outAddress);
  initial begin
	  clk=0;
    repeat (40)
    #200 clk=~clk;
	end
  
  initial begin
    rst = 1; 
    #400;
    rst = 0; 
    ld = 1;
    inAddress = 13'b0000000111111;
    #400;
    inAddress = 13'b0000001111111;
    #400;
    ld = 0;
    inAddress = 13'b0000000111111;
    #400;
    inAddress = 13'b0000001111111;
    #400;
  end
endmodule