`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// This is a sample self-checking testbench
// 
//////////////////////////////////////////////////////////////////////////////////
module myFIR_tb;

parameter   IN_WIDTH = 16;
parameter   OUT_WIDTH = 48;
parameter	DATA_LEN=150000;
reg   [IN_WIDTH-1:0] din;
wire  [OUT_WIDTH-1:0] dout;

reg [OUT_WIDTH-1:0]  expected_data [0:DATA_LEN];
reg [IN_WIDTH-1:0]  input_data [0:DATA_LEN];
reg [OUT_WIDTH-1:0]  temp_out;
reg clk,RST_n;
integer i,fp,cnt,k;

mansymFIR uut (
    .in(din), 
    .clk(clk), 
    .RST_n(RST_n), 
    .out(dout)
    );

initial
    begin  
    $readmemb("indata.txt", input_data);   
end

initial
    begin
    $readmemb("outdata.txt", expected_data);
end           

initial
begin
	clk = 1'b0;
end

always #10 clk = ~clk;

initial
   begin 
	RST_n = 1'b0;
   din = 16'b0;   
	cnt=0;
   #400;
   RST_n = 1'b1;
end         

initial
begin
	fp = $fopen("outManualFIRVerilog.txt");
	#400;
	cnt=5;
	k=0;
	$display("Testing %d Samples...",DATA_LEN);		
	for(i = 0; i < DATA_LEN*6; i = i + 1)
	begin
		@(negedge clk)
		begin
			if (cnt>=5)
			begin
				cnt=0;
				din =input_data[k];
				@(posedge clk)
				begin
					$fwrite(fp,"%b\n",dout);
					temp_out = expected_data[k];
					if(dout != temp_out[OUT_WIDTH-1:0])
					$display("test failed: %d   input: %x expected: %x output: %x" , i, din, temp_out[OUT_WIDTH-1:0], dout);
				end
				k=k+1;
			end
			else
				cnt=cnt+1;
		end
	end
$fclose(fp);
$display ("Test Passed.");
$finish;
end
endmodule
