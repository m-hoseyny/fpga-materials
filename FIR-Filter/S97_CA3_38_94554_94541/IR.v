module IR(
  input clk,
  input rst, ld,
  input [7:0]inAddress,
  output reg[7:0] outAddress
);
  always @(posedge clk, posedge rst)begin
    if (rst)
      outAddress <= 8'b0;
    else 
      if(ld)
        outAddress <= inAddress;
      else
        outAddress <= outAddress;
  end
endmodule

module IR_TB();
  reg clk, rst;
  reg [12:0]inAddress;
  wire [12:0]outAddress;
  
  IR ir(clk, rst, inAddress, outAddress);
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