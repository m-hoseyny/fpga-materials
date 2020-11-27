module instructionMemory(
  input [11:0]inAddress,
	output [18:0]instruction
);
	reg [18:0] RAM [0:4095];
	initial
		$readmemb("instructions.txt", RAM);
	assign instruction = RAM[inAddress];
endmodule

module  IMTB();
  reg [11:0]inAddress;
  wire [18:0]instruction;
  instructionMemory IM(inAddress,instruction);
  
  initial begin
    #300;
    inAddress = 12'b0;
    #300;
    inAddress = 12'b000000000001;
    #300;
    inAddress = 12'b000000000010;
    #300;
    $stop;
  end
endmodule