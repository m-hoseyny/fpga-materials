module DI(
  input clk,
  input rst, ld,
  input [4:0]inAddress,
  output reg[4:0] outAddress
);
  always @(posedge clk, posedge rst)begin
    if (rst)
      outAddress <= 5'b0;
    else 
      if(ld)
        outAddress <= inAddress;
      else
        outAddress <= outAddress;
  end
endmodule

module DI_TB();
  reg clk, rst, ld;
  reg [4:0]inAddress;
  wire [4:0]outAddress;
  
  DI di(clk, rst, inAddress, outAddress);
  initial begin
	  clk=0;
    repeat (40)
    #200 clk=~clk;
	end
  
  initial begin
    rst = 1; 
    #400;
    rst = 0; 
    inAddress = 5'b00011;
    #400;
    inAddress = 5'b00111;
    #400;
  end
endmodule