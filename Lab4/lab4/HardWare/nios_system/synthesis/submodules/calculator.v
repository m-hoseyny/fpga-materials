module calculator(clk,reset,slave_writedata,slave_write,slave_chipselect,slave_read,slave_readdata,rst,slave_adress,master_read,master_address,master_waitrequest,master_readdata,master_writedata,master_write);
input clk,slave_read,slave_write,slave_chipselect;
input [31:0]slave_writedata;
input signed [31:0] master_readdata;
input rst,reset;
input [1:0] slave_adress;
output reg [31:0]slave_readdata;
output reg signed [31:0] master_writedata;
output reg master_read,master_write;
output reg [31:0]master_address;
input master_waitrequest;


reg [31:0]config_reg,right_addr,left_addr,out_adrr;




localparam Idle=0,Resetting=2,Reading=3,Loading=4,Writting=5,Counting=6,Addressing=1,doning=7;
reg resultreset,loadresult,countsizereset,countenablesize,countnumreset,countenablenum;
wire carryoutsize,carryoutnum;
reg signed [63:0] resultreg;
reg [10:0] countnum;
reg [18:0] countsize;
wire Go;
reg Done;
wire [10:0] num;
wire [18:0] size;
reg [2:0] ps,ns;
wire signed [31:0] data;
reg [31:0] addresspresent;

assign data=(master_readdata>0)?master_readdata:(-master_readdata);



assign num[10:0]=config_reg[11:1];
assign size[18:0]=config_reg[30:12];
assign Go=config_reg[0];

always @(posedge clk) begin
if(ps==Addressing)
addresspresent<=right_addr;
else if(loadresult==1)
addresspresent<=addresspresent+4;
end

always @(*) begin
countnumreset=0;resultreset=0;countsizereset=0;master_address=0;master_read=0;loadresult=0;countenablesize=0;master_write=0;countenablenum=0;
ns=Idle;
case(ps)
Idle:begin ns=(Go)?Addressing:Idle;countnumreset=1; end
Addressing:begin ns=Resetting;end
Resetting:begin ns=Reading;resultreset=1;countsizereset=1;end
Reading:begin ns=(master_waitrequest)?Reading:Loading;master_address=addresspresent;master_read=1;end
Loading:begin ns=(carryoutsize)?Writting:Reading;loadresult=1;countenablesize=1;end
Writting:begin ns=(master_waitrequest)?Writting:Counting;master_write=1;master_address=out_adrr+(countnum<<2);master_writedata=resultreg[53:22];end
Counting:begin ns=(carryoutnum)?doning:Resetting;countenablenum=1;end
doning:begin ns=Idle;Done=1;end
default:ns=Idle;
endcase
end

always @(posedge clk) begin
	if (reset==1)
	ps<=Idle;
	else
	ps<=ns;
	end
	
always @(posedge clk) begin
	if(reset==1)
	countsize<=0;
	else if(countsizereset==1)
	countsize<=0;
	else if(countenablesize==1)
	countsize<=countsize+1;
end
always @(posedge clk) begin
	if (reset == 1)
	countnum<=0;
	else if (countnumreset==1)
	countnum<=0;
	else if (countenablenum==1)
	countnum<=countnum+1;
	end
	
assign carryoutsize=(countsize==size);
assign carryoutnum=(countnum==num);

always @(posedge clk) begin
		if (reset == 1)
		resultreg<=0;
		else if (resultreset==1)
		resultreg<=0;
		else if (ns==Loading)
		resultreg<=resultreg+data;
		end
		



always @(posedge clk) begin 
   if(rst) begin 
	 config_reg[31:0]<=0;
	 right_addr[31:0]<=0;
	 left_addr[31:0]<=0;
	 out_adrr[31:0]<=0;
	end
   else if(slave_read==1&&slave_chipselect==1) begin 
	  case (slave_adress) 
	   0:slave_readdata[31:0]<=config_reg[31:0];
		1:slave_readdata[31:0]<=right_addr[31:0];
		2:slave_readdata[31:0]<=left_addr[31:0];
		3:slave_readdata[31:0]<=out_adrr[31:0];
		endcase
	end
  else if(slave_write==1&&slave_chipselect==1) begin 
    case(slave_adress) 
	   0:config_reg[31:0]<=slave_writedata[31:0];
		1:right_addr[31:0]<=slave_writedata[31:0];
		2:left_addr[31:0]<=slave_writedata[31:0];
		3:out_adrr[31:0]<=slave_writedata[31:0];
		endcase

	end
	else if(Done==1) begin
		config_reg[31]<=1;
		config_reg[0]<=0;
	end
end



endmodule
