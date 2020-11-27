module TR(
  input clk,
  input rst, TRLD,
  input [12:0]inAddress,
  output reg[12:0] outAddress
);
  always @(posedge clk, posedge rst)begin
    if (rst)
      outAddress <= 13'b0;
    else 
      if(TRLD)
        outAddress <= inAddress;

  end
endmodule

module TR_TB();
  reg clk, rst;
  reg [12:0]inAddress;
  wire [12:0]outAddress;
  
  TR tr(clk, rst, inAddress, outAddress);
  initial begin
	  clk=0;
    repeat (40)
    #200 clk=~clk;
	end
  
  initial begin
    rst = 1; 
    #400;
    rst = 0; 
    inAddress = 13'b0000000111111;
    #400;
    inAddress = 13'b0000001111111;
    #400;
  end
endmodule