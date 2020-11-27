module PC(
  input clk,
  input rst,
  input pcStall,
  input [11:0]inAddress,
  output reg[11:0] outAddress
);
  always @(posedge clk, posedge rst)begin
    if (rst)
      outAddress <= 12'b0;
    else if(~pcStall)
      outAddress <= inAddress;
  end
endmodule

module PCTB();
  reg clk, rst;
  reg [11:0]inAddress;
  wire [11:0]outAddress;
  
  PC pc(clk, rst, inAddress, outAddress);
  initial begin
	  clk=0;
    repeat (40)
    #200 clk=~clk;
	end
  
  initial begin
    rst = 1; 
    #400;
    rst = 0; 
    inAddress = 12'b000000111111;
    #400;
    inAddress = 12'b000001111111;
    #400;
  end
endmodule