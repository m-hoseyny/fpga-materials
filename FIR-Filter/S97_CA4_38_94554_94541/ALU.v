module ALU(
	input [7:0]A, B,
	input [3:0]ALU_OP,
	input cin,
	output reg[7:0]out,
	output reg cout, zero
);
	always@(A, B, cin, ALU_OP) begin
		out = 8'b0;
	    zero = 0;
	    cout = 0;
	    case (ALU_OP)
	      0 : {cout, out} = A + B;
	      1 : {cout, out} = A + B + cin;
	      2 : {cout, out} = A - B;
	      3 : {cout, out} = A - B + cin;
	      4 : out = A & B;
	      5 : out = A | B;
	      6 : out = A ^ B;
	      7 : out = ~(A & B);
	      8 : {cout, out} = A << B[7:5];
	      9 : {cout, out} = A >> B[7:5];
	      10: begin
	      		case (B[7:5])
	      			0 : out[7:0] = A;
	      			1 : out[7:0] = {A[6:0], A[7]};
	      			2 : out[7:0] = {A[5:0], A[7:6]};
	      			3 : out[7:0] = {A[4:0], A[7:5]};
	      			4 : out[7:0] = {A[3:0], A[7:4]};
	      			5 : out[7:0] = {A[2:0], A[7:3]};
	      			6 : out[7:0] = {A[1:0], A[7:2]};
	      			7 : out[7:0] = {A[1], A[7:1]};
	      		endcase
	      	  end
	      11: begin
	      		case (B[7:5])
	      			0 : out[7:0] = A;
	      			1 : out[7:0] = {A[0], A[7:1]};
	      			2 : out[7:0] = {A[1:0], A[7:2]};
	      			3 : out[7:0] = {A[2:0], A[7:3]};
	      			4 : out[7:0] = {A[3:0], A[7:4]};
	      			5 : out[7:0] = {A[4:0], A[7:5]};
	      			6 : out[7:0] = {A[5:0], A[7:6]};
	      			7 : out[7:0] = {A[6:0], A[7]};
	      		endcase
	      	  end
	      12: begin
	      		if(B[7] == 0)
	      			out = A + B;
	      		else 
	      			out = A + (~B + 1'b1);	
	      	  end
	    endcase
	    if(out == 8'b0 && ALU_OP != 4'b1100)
	    	zero = 1;
	end
endmodule

module ALUTB();
	reg [7:0]A, B;
	reg [3:0]ALU_OP;
	reg cin;
	wire [7:0]out;
	wire cout, zero;

	ALU a1(A, B, ALU_OP, cin, out, cout, zero);
	initial begin
		A = 8'b00000011;
		B = 8'b00000011;
		cin = 1'b1;
		ALU_OP = 4'b0000;
		#100;
		A = 8'b00000011;
		B = 8'b00000011;
		cin = 1'b1;
		ALU_OP = 4'b0001;
		#100;
		A = 8'b00000011;
		B = 8'b00000011;
		cin = 1'b1;
		ALU_OP = 4'b0010;
		#100;
		A = 8'b00000011;
		B = 8'b00000011;
		cin = 1'b1;
		ALU_OP = 4'b0011;
		#100;
		A = 8'b00000011;
		B = 8'b00000011;
		cin = 1'b1;
		ALU_OP = 4'b0100;
		#100;
		A = 8'b00000011;
		B = 8'b00000011;
		cin = 1'b1;
		ALU_OP = 4'b0101;
		#100;
		A = 8'b00000011;
		B = 8'b00000011;
		cin = 1'b1;
		ALU_OP = 4'b0110;
		#100;
		A = 8'b00000011;
		B = 8'b00000011;
		cin = 1'b1;
		ALU_OP = 4'b0111;
		#100;
		A = 8'b00000011;
		B = 8'b01000000;
		cin = 1'b1;
		ALU_OP = 4'b1000;
		#100;
		A = 8'b00000011;
		B = 8'b01000000;
		cin = 1'b1;
		ALU_OP = 4'b1001;
		#100;
		A = 8'b00000011;
		B = 8'b01000000;
		cin = 1'b1;
		ALU_OP = 4'b1010;
		#100;
		A = 8'b00000011;
		B = 8'b01000000;
		cin = 1'b1;
		ALU_OP = 4'b1011;
		#100;
		$stop;
	end
endmodule