module controller (
input clk, rst, 
input [3:0]opCode,
output reg TRLD, pc_src, pc_write, IorD, pc_write_cond, mem_write, mem_read, IR_write, ldil, reg_src, reg_write, alu_src_b, wr_src,
output reg [1:0] wd_src,  alu_op
);
  parameter [3:0] IF = 4'b0000, ID0 = 4'b0001, ID1 = 4'b0010, MWR = 4'b0011, jmp = 4'b0100, LDI = 4'b0101, ADI = 4'b0110, LDA = 4'b0111, 
                  STA = 4'b1000, ANDA = 4'b1001, ACI = 4'b1010, WRI = 4'b1011;
  reg [3:0]ps, ns;
  always @(posedge clk, posedge rst)begin 
    if (rst)
      ps <= IF;
    else
      ps <= ns;
  end
  
  always @(ps) begin
    {TRLD, pc_src, pc_write, IorD, pc_write_cond, mem_write, mem_read, IR_write, ldil, reg_src, reg_write, alu_src_b, wr_src} = 13'b0;
    wd_src = 2'b00;  
    alu_op = 2'b00;

    case (ps)
      
      IF : begin
        IorD = 0;
        mem_read = 1;
        IR_write = 1;
        pc_src = 0;
        pc_write = 1;
        ns = ID0;
      end
      
      ID0 : begin
        IorD = 0;
        if (opCode[3:1] == 3'b000 || opCode[3:1] == 3'b001 || opCode[3:1] == 3'b010 || opCode[3:1] == 3'b011 || opCode[3:1] == 3'b110)
        begin
          pc_src = 0;
          pc_write = 1;
          mem_read = 1;
          TRLD = 1;
        end
        else begin
          pc_src = 0;
          pc_write = 0;
          mem_read = 0;
        end
        ns = ID1;
      end
      
      ID1 : begin
        reg_src = 0;
        alu_src_b = 0;
        if(opCode == 4'b1000)
          ns = MWR;
        else if(opCode == 4'b1001 || opCode == 4'b1010 || opCode == 4'b1011)
          ns = ACI;
        else if(opCode[3:1] == 3'b000 || opCode[3:1] == 3'b001 || opCode[3:1] == 3'b010 || opCode[3:1] == 3'b011)
          ns = ADI;
        else if(opCode[3:1] == 3'b110)
          ns = jmp;
        else if(opCode[3:1] == 3'b111)
          ns = LDI;
      end
      
      MWR : begin
        wd_src = 2'b10;
        wr_src = 0;
        reg_write = 1;
        ns = IF;
      end
      
      jmp : begin
        pc_src = 1;
        pc_write_cond = 1;
        ns = IF;
      end
      
      LDI : begin
        ldil = 1;
        ns = IF;
      end
      
      ADI : begin
        IorD = 1;
        mem_read = 1;
        reg_src = 1;
        if(opCode[3:1] == 3'b000) begin
          wd_src = 1;
          wr_src = 1;
          reg_write = 1;
          ns = IF;
        end
        else if(opCode[3:1] == 3'b001)
          ns = STA;
        else if(opCode[3:1] == 3'b010 || opCode[3:1] == 3'b011) begin
          ns = ANDA;
          alu_src_b = 1;
        end
      end
      
      STA : begin
        IorD = 1;
        mem_write = 1;
        ns = IF;
      end
      
      ANDA : begin
        alu_src_b = 1;
        if(opCode[3:1] == 3'b010)
          alu_op = 2'b01;
        else
          alu_op = 2'b10;
        ns = WRI;
      end
      
      ACI : begin
        alu_src_b = 0;
        if(opCode == 4'b1001)
          alu_op = 2'b01;
        else if(opCode == 4'b1010)
          alu_op = 2'b10;
        else if(opCode == 4'b1011)
          alu_op = 2'b11;
        ns = WRI;
      end
      
      WRI : begin
        wr_src = 1;
        wd_src = 0;
        reg_write = 1;
        ns = IF;
      end
    endcase
  end 

endmodule
