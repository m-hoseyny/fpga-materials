// -------------------------------------------------------------
//
// Module: filter_serial
// Generated by MATLAB(R) 8.5 and the Filter Design HDL Coder 2.9.7.
// Generated on: 2016-11-27 14:04:30
// -------------------------------------------------------------

// -------------------------------------------------------------
// HDL Code Generation Options:
//
// TargetDirectory: C:\Users\Javad\Desktop\LAB3_NEW\Matlab\Fully_serial
// Name: filter_serial
// SerialPartition: 64
// TargetLanguage: Verilog
// TestBenchStimulus: 
// TestBenchUserStimulus:  User data, length 221184
// ErrorMargin: 0

// -------------------------------------------------------------
// HDL Implementation    : Fully Serial
// Multipliers           : 1
// Folding Factor        : 64
// -------------------------------------------------------------
// Filter Settings:
//
// Discrete-Time FIR Filter (real)
// -------------------------------
// Filter Structure  : Direct-Form FIR
// Filter Length     : 64
// Stable            : Yes
// Linear Phase      : Yes (Type 2)
// Arithmetic        : fixed
// Numerator         : s32,32 -> [-5.000000e-01 5.000000e-01)
// Input             : s32,31 -> [-1 1)
// Filter Internals  : Specify Precision
//   Output          : s32,28 -> [-8 8)
//   Product         : s31,31 -> [-5.000000e-01 5.000000e-01)
//   Accumulator     : s34,31 -> [-4 4)
//   Round Mode      : convergent
//   Overflow Mode   : wrap
// -------------------------------------------------------------

`timescale 1 ns / 1 ns

module filter_serial
               (
                clk,
                clk_enable,
                reset,
                filter_in,
                filter_out,
				Done
                );

  input   clk; 
  input   clk_enable; 
  input   reset; 
  input   signed [31:0] filter_in; //sfix32_En31
  output  signed [31:0] filter_out; //sfix32_En28
  output  reg Done;
  
////////////////////////////////////////////////////////////////
//Module Architecture: filter_serial
////////////////////////////////////////////////////////////////
  // Local Functions
  // Type Definitions
  // Constants
  parameter signed [31:0] coeff1 = 32'h00F17051; //sfix32_En32
  parameter signed [31:0] coeff2 = 32'h00C019AD; //sfix32_En32
  parameter signed [31:0] coeff3 = 32'hFF938062; //sfix32_En32
  parameter signed [31:0] coeff4 = 32'hFD93A638; //sfix32_En32
  parameter signed [31:0] coeff5 = 32'hFC3AB893; //sfix32_En32
  parameter signed [31:0] coeff6 = 32'hFCEAB857; //sfix32_En32
  parameter signed [31:0] coeff7 = 32'hFF61B53C; //sfix32_En32
  parameter signed [31:0] coeff8 = 32'h01931AF0; //sfix32_En32
  parameter signed [31:0] coeff9 = 32'h0177D407; //sfix32_En32
  parameter signed [31:0] coeff10 = 32'hFF3C3EBA; //sfix32_En32
  parameter signed [31:0] coeff11 = 32'hFD605840; //sfix32_En32
  parameter signed [31:0] coeff12 = 32'hFE3B244D; //sfix32_En32
  parameter signed [31:0] coeff13 = 32'h01451064; //sfix32_En32
  parameter signed [31:0] coeff14 = 32'h034445A5; //sfix32_En32
  parameter signed [31:0] coeff15 = 32'h01A99E66; //sfix32_En32
  parameter signed [31:0] coeff16 = 32'hFDBB7E90; //sfix32_En32
  parameter signed [31:0] coeff17 = 32'hFBC60960; //sfix32_En32
  parameter signed [31:0] coeff18 = 32'hFE8AFC60; //sfix32_En32
  parameter signed [31:0] coeff19 = 32'h03A78912; //sfix32_En32
  parameter signed [31:0] coeff20 = 32'h056677A5; //sfix32_En32
  parameter signed [31:0] coeff21 = 32'h00E88225; //sfix32_En32
  parameter signed [31:0] coeff22 = 32'hFA37F277; //sfix32_En32
  parameter signed [31:0] coeff23 = 32'hF9037B15; //sfix32_En32
  parameter signed [31:0] coeff24 = 32'h0040E07C; //sfix32_En32
  parameter signed [31:0] coeff25 = 32'h0960109C; //sfix32_En32
  parameter signed [31:0] coeff26 = 32'h097E138C; //sfix32_En32
  parameter signed [31:0] coeff27 = 32'hFD19E579; //sfix32_En32
  parameter signed [31:0] coeff28 = 32'hEED155A7; //sfix32_En32
  parameter signed [31:0] coeff29 = 32'hF0AA8086; //sfix32_En32
  parameter signed [31:0] coeff30 = 32'h0BF1DED9; //sfix32_En32
  parameter signed [31:0] coeff31 = 32'h3602E701; //sfix32_En32
  parameter signed [31:0] coeff32 = 32'h55907411; //sfix32_En32
  parameter signed [31:0] coeff33 = 32'h55907411; //sfix32_En32
  parameter signed [31:0] coeff34 = 32'h3602E701; //sfix32_En32
  parameter signed [31:0] coeff35 = 32'h0BF1DED9; //sfix32_En32
  parameter signed [31:0] coeff36 = 32'hF0AA8086; //sfix32_En32
  parameter signed [31:0] coeff37 = 32'hEED155A7; //sfix32_En32
  parameter signed [31:0] coeff38 = 32'hFD19E579; //sfix32_En32
  parameter signed [31:0] coeff39 = 32'h097E138C; //sfix32_En32
  parameter signed [31:0] coeff40 = 32'h0960109C; //sfix32_En32
  parameter signed [31:0] coeff41 = 32'h0040E07C; //sfix32_En32
  parameter signed [31:0] coeff42 = 32'hF9037B15; //sfix32_En32
  parameter signed [31:0] coeff43 = 32'hFA37F277; //sfix32_En32
  parameter signed [31:0] coeff44 = 32'h00E88225; //sfix32_En32
  parameter signed [31:0] coeff45 = 32'h056677A5; //sfix32_En32
  parameter signed [31:0] coeff46 = 32'h03A78912; //sfix32_En32
  parameter signed [31:0] coeff47 = 32'hFE8AFC60; //sfix32_En32
  parameter signed [31:0] coeff48 = 32'hFBC60960; //sfix32_En32
  parameter signed [31:0] coeff49 = 32'hFDBB7E90; //sfix32_En32
  parameter signed [31:0] coeff50 = 32'h01A99E66; //sfix32_En32
  parameter signed [31:0] coeff51 = 32'h034445A5; //sfix32_En32
  parameter signed [31:0] coeff52 = 32'h01451064; //sfix32_En32
  parameter signed [31:0] coeff53 = 32'hFE3B244D; //sfix32_En32
  parameter signed [31:0] coeff54 = 32'hFD605840; //sfix32_En32
  parameter signed [31:0] coeff55 = 32'hFF3C3EBA; //sfix32_En32
  parameter signed [31:0] coeff56 = 32'h0177D407; //sfix32_En32
  parameter signed [31:0] coeff57 = 32'h01931AF0; //sfix32_En32
  parameter signed [31:0] coeff58 = 32'hFF61B53C; //sfix32_En32
  parameter signed [31:0] coeff59 = 32'hFCEAB857; //sfix32_En32
  parameter signed [31:0] coeff60 = 32'hFC3AB893; //sfix32_En32
  parameter signed [31:0] coeff61 = 32'hFD93A638; //sfix32_En32
  parameter signed [31:0] coeff62 = 32'hFF938062; //sfix32_En32
  parameter signed [31:0] coeff63 = 32'h00C019AD; //sfix32_En32
  parameter signed [31:0] coeff64 = 32'h00F17051; //sfix32_En32

  // Signals
  reg  [5:0] cur_count; // ufix6
  wire phase_63; // boolean
  wire phase_0; // boolean
  reg  signed [31:0] delay_pipeline [0:63] ; // sfix32_En31
  wire signed [31:0] inputmux_1; // sfix32_En31
  reg  signed [33:0] acc_final; // sfix34_En31
  reg  signed [33:0] acc_out_1; // sfix34_En31
  wire signed [30:0] product_1; // sfix31_En31
  wire signed [31:0] product_1_mux; // sfix32_En32
  wire signed [63:0] mul_temp; // sfix64_En63
  wire signed [33:0] prod_typeconvert_1; // sfix34_En31
  wire signed [33:0] acc_sum_1; // sfix34_En31
  wire signed [33:0] acc_in_1; // sfix34_En31
  wire signed [33:0] add_signext; // sfix34_En31
  wire signed [33:0] add_signext_1; // sfix34_En31
  wire signed [34:0] add_temp; // sfix35_En31
  wire signed [31:0] output_typeconvert; // sfix32_En28
  reg  signed [31:0] output_register; // sfix32_En28

  // Block Statements
  always @ (posedge clk)
    begin: Counter_process
      if (reset == 1'b1) begin
        cur_count <= 6'b111111;
      end
      else begin
        if (clk_enable == 1'b1) begin
          if (cur_count == 6'b111111) begin
            cur_count <= 6'b000000;
          end
          else begin
            cur_count <= cur_count + 1;
          end
        end
      end
    end // Counter_process

  assign  phase_63 = (cur_count == 6'b111111 && clk_enable == 1'b1)? 1 : 0;

  assign  phase_0 = (cur_count == 6'b000000 && clk_enable == 1'b1)? 1 : 0;

  always @( posedge clk)
    begin: Delay_Pipeline_process
      if (reset == 1'b1) begin
        delay_pipeline[0] <= 0;
        delay_pipeline[1] <= 0;
        delay_pipeline[2] <= 0;
        delay_pipeline[3] <= 0;
        delay_pipeline[4] <= 0;
        delay_pipeline[5] <= 0;
        delay_pipeline[6] <= 0;
        delay_pipeline[7] <= 0;
        delay_pipeline[8] <= 0;
        delay_pipeline[9] <= 0;
        delay_pipeline[10] <= 0;
        delay_pipeline[11] <= 0;
        delay_pipeline[12] <= 0;
        delay_pipeline[13] <= 0;
        delay_pipeline[14] <= 0;
        delay_pipeline[15] <= 0;
        delay_pipeline[16] <= 0;
        delay_pipeline[17] <= 0;
        delay_pipeline[18] <= 0;
        delay_pipeline[19] <= 0;
        delay_pipeline[20] <= 0;
        delay_pipeline[21] <= 0;
        delay_pipeline[22] <= 0;
        delay_pipeline[23] <= 0;
        delay_pipeline[24] <= 0;
        delay_pipeline[25] <= 0;
        delay_pipeline[26] <= 0;
        delay_pipeline[27] <= 0;
        delay_pipeline[28] <= 0;
        delay_pipeline[29] <= 0;
        delay_pipeline[30] <= 0;
        delay_pipeline[31] <= 0;
        delay_pipeline[32] <= 0;
        delay_pipeline[33] <= 0;
        delay_pipeline[34] <= 0;
        delay_pipeline[35] <= 0;
        delay_pipeline[36] <= 0;
        delay_pipeline[37] <= 0;
        delay_pipeline[38] <= 0;
        delay_pipeline[39] <= 0;
        delay_pipeline[40] <= 0;
        delay_pipeline[41] <= 0;
        delay_pipeline[42] <= 0;
        delay_pipeline[43] <= 0;
        delay_pipeline[44] <= 0;
        delay_pipeline[45] <= 0;
        delay_pipeline[46] <= 0;
        delay_pipeline[47] <= 0;
        delay_pipeline[48] <= 0;
        delay_pipeline[49] <= 0;
        delay_pipeline[50] <= 0;
        delay_pipeline[51] <= 0;
        delay_pipeline[52] <= 0;
        delay_pipeline[53] <= 0;
        delay_pipeline[54] <= 0;
        delay_pipeline[55] <= 0;
        delay_pipeline[56] <= 0;
        delay_pipeline[57] <= 0;
        delay_pipeline[58] <= 0;
        delay_pipeline[59] <= 0;
        delay_pipeline[60] <= 0;
        delay_pipeline[61] <= 0;
        delay_pipeline[62] <= 0;
        delay_pipeline[63] <= 0;
      end
      else begin
        if (phase_63 == 1'b1) begin
          delay_pipeline[0] <= filter_in;
          delay_pipeline[1] <= delay_pipeline[0];
          delay_pipeline[2] <= delay_pipeline[1];
          delay_pipeline[3] <= delay_pipeline[2];
          delay_pipeline[4] <= delay_pipeline[3];
          delay_pipeline[5] <= delay_pipeline[4];
          delay_pipeline[6] <= delay_pipeline[5];
          delay_pipeline[7] <= delay_pipeline[6];
          delay_pipeline[8] <= delay_pipeline[7];
          delay_pipeline[9] <= delay_pipeline[8];
          delay_pipeline[10] <= delay_pipeline[9];
          delay_pipeline[11] <= delay_pipeline[10];
          delay_pipeline[12] <= delay_pipeline[11];
          delay_pipeline[13] <= delay_pipeline[12];
          delay_pipeline[14] <= delay_pipeline[13];
          delay_pipeline[15] <= delay_pipeline[14];
          delay_pipeline[16] <= delay_pipeline[15];
          delay_pipeline[17] <= delay_pipeline[16];
          delay_pipeline[18] <= delay_pipeline[17];
          delay_pipeline[19] <= delay_pipeline[18];
          delay_pipeline[20] <= delay_pipeline[19];
          delay_pipeline[21] <= delay_pipeline[20];
          delay_pipeline[22] <= delay_pipeline[21];
          delay_pipeline[23] <= delay_pipeline[22];
          delay_pipeline[24] <= delay_pipeline[23];
          delay_pipeline[25] <= delay_pipeline[24];
          delay_pipeline[26] <= delay_pipeline[25];
          delay_pipeline[27] <= delay_pipeline[26];
          delay_pipeline[28] <= delay_pipeline[27];
          delay_pipeline[29] <= delay_pipeline[28];
          delay_pipeline[30] <= delay_pipeline[29];
          delay_pipeline[31] <= delay_pipeline[30];
          delay_pipeline[32] <= delay_pipeline[31];
          delay_pipeline[33] <= delay_pipeline[32];
          delay_pipeline[34] <= delay_pipeline[33];
          delay_pipeline[35] <= delay_pipeline[34];
          delay_pipeline[36] <= delay_pipeline[35];
          delay_pipeline[37] <= delay_pipeline[36];
          delay_pipeline[38] <= delay_pipeline[37];
          delay_pipeline[39] <= delay_pipeline[38];
          delay_pipeline[40] <= delay_pipeline[39];
          delay_pipeline[41] <= delay_pipeline[40];
          delay_pipeline[42] <= delay_pipeline[41];
          delay_pipeline[43] <= delay_pipeline[42];
          delay_pipeline[44] <= delay_pipeline[43];
          delay_pipeline[45] <= delay_pipeline[44];
          delay_pipeline[46] <= delay_pipeline[45];
          delay_pipeline[47] <= delay_pipeline[46];
          delay_pipeline[48] <= delay_pipeline[47];
          delay_pipeline[49] <= delay_pipeline[48];
          delay_pipeline[50] <= delay_pipeline[49];
          delay_pipeline[51] <= delay_pipeline[50];
          delay_pipeline[52] <= delay_pipeline[51];
          delay_pipeline[53] <= delay_pipeline[52];
          delay_pipeline[54] <= delay_pipeline[53];
          delay_pipeline[55] <= delay_pipeline[54];
          delay_pipeline[56] <= delay_pipeline[55];
          delay_pipeline[57] <= delay_pipeline[56];
          delay_pipeline[58] <= delay_pipeline[57];
          delay_pipeline[59] <= delay_pipeline[58];
          delay_pipeline[60] <= delay_pipeline[59];
          delay_pipeline[61] <= delay_pipeline[60];
          delay_pipeline[62] <= delay_pipeline[61];
          delay_pipeline[63] <= delay_pipeline[62];
        end
      end
    end // Delay_Pipeline_process


  assign inputmux_1 = (cur_count == 6'b000000) ? delay_pipeline[0] :
                     (cur_count == 6'b000001) ? delay_pipeline[1] :
                     (cur_count == 6'b000010) ? delay_pipeline[2] :
                     (cur_count == 6'b000011) ? delay_pipeline[3] :
                     (cur_count == 6'b000100) ? delay_pipeline[4] :
                     (cur_count == 6'b000101) ? delay_pipeline[5] :
                     (cur_count == 6'b000110) ? delay_pipeline[6] :
                     (cur_count == 6'b000111) ? delay_pipeline[7] :
                     (cur_count == 6'b001000) ? delay_pipeline[8] :
                     (cur_count == 6'b001001) ? delay_pipeline[9] :
                     (cur_count == 6'b001010) ? delay_pipeline[10] :
                     (cur_count == 6'b001011) ? delay_pipeline[11] :
                     (cur_count == 6'b001100) ? delay_pipeline[12] :
                     (cur_count == 6'b001101) ? delay_pipeline[13] :
                     (cur_count == 6'b001110) ? delay_pipeline[14] :
                     (cur_count == 6'b001111) ? delay_pipeline[15] :
                     (cur_count == 6'b010000) ? delay_pipeline[16] :
                     (cur_count == 6'b010001) ? delay_pipeline[17] :
                     (cur_count == 6'b010010) ? delay_pipeline[18] :
                     (cur_count == 6'b010011) ? delay_pipeline[19] :
                     (cur_count == 6'b010100) ? delay_pipeline[20] :
                     (cur_count == 6'b010101) ? delay_pipeline[21] :
                     (cur_count == 6'b010110) ? delay_pipeline[22] :
                     (cur_count == 6'b010111) ? delay_pipeline[23] :
                     (cur_count == 6'b011000) ? delay_pipeline[24] :
                     (cur_count == 6'b011001) ? delay_pipeline[25] :
                     (cur_count == 6'b011010) ? delay_pipeline[26] :
                     (cur_count == 6'b011011) ? delay_pipeline[27] :
                     (cur_count == 6'b011100) ? delay_pipeline[28] :
                     (cur_count == 6'b011101) ? delay_pipeline[29] :
                     (cur_count == 6'b011110) ? delay_pipeline[30] :
                     (cur_count == 6'b011111) ? delay_pipeline[31] :
                     (cur_count == 6'b100000) ? delay_pipeline[32] :
                     (cur_count == 6'b100001) ? delay_pipeline[33] :
                     (cur_count == 6'b100010) ? delay_pipeline[34] :
                     (cur_count == 6'b100011) ? delay_pipeline[35] :
                     (cur_count == 6'b100100) ? delay_pipeline[36] :
                     (cur_count == 6'b100101) ? delay_pipeline[37] :
                     (cur_count == 6'b100110) ? delay_pipeline[38] :
                     (cur_count == 6'b100111) ? delay_pipeline[39] :
                     (cur_count == 6'b101000) ? delay_pipeline[40] :
                     (cur_count == 6'b101001) ? delay_pipeline[41] :
                     (cur_count == 6'b101010) ? delay_pipeline[42] :
                     (cur_count == 6'b101011) ? delay_pipeline[43] :
                     (cur_count == 6'b101100) ? delay_pipeline[44] :
                     (cur_count == 6'b101101) ? delay_pipeline[45] :
                     (cur_count == 6'b101110) ? delay_pipeline[46] :
                     (cur_count == 6'b101111) ? delay_pipeline[47] :
                     (cur_count == 6'b110000) ? delay_pipeline[48] :
                     (cur_count == 6'b110001) ? delay_pipeline[49] :
                     (cur_count == 6'b110010) ? delay_pipeline[50] :
                     (cur_count == 6'b110011) ? delay_pipeline[51] :
                     (cur_count == 6'b110100) ? delay_pipeline[52] :
                     (cur_count == 6'b110101) ? delay_pipeline[53] :
                     (cur_count == 6'b110110) ? delay_pipeline[54] :
                     (cur_count == 6'b110111) ? delay_pipeline[55] :
                     (cur_count == 6'b111000) ? delay_pipeline[56] :
                     (cur_count == 6'b111001) ? delay_pipeline[57] :
                     (cur_count == 6'b111010) ? delay_pipeline[58] :
                     (cur_count == 6'b111011) ? delay_pipeline[59] :
                     (cur_count == 6'b111100) ? delay_pipeline[60] :
                     (cur_count == 6'b111101) ? delay_pipeline[61] :
                     (cur_count == 6'b111110) ? delay_pipeline[62] :
                     delay_pipeline[63];

  //   ------------------ Serial partition # 1 ------------------

  assign product_1_mux = (cur_count == 6'b000000) ? coeff1 :
                        (cur_count == 6'b000001) ? coeff2 :
                        (cur_count == 6'b000010) ? coeff3 :
                        (cur_count == 6'b000011) ? coeff4 :
                        (cur_count == 6'b000100) ? coeff5 :
                        (cur_count == 6'b000101) ? coeff6 :
                        (cur_count == 6'b000110) ? coeff7 :
                        (cur_count == 6'b000111) ? coeff8 :
                        (cur_count == 6'b001000) ? coeff9 :
                        (cur_count == 6'b001001) ? coeff10 :
                        (cur_count == 6'b001010) ? coeff11 :
                        (cur_count == 6'b001011) ? coeff12 :
                        (cur_count == 6'b001100) ? coeff13 :
                        (cur_count == 6'b001101) ? coeff14 :
                        (cur_count == 6'b001110) ? coeff15 :
                        (cur_count == 6'b001111) ? coeff16 :
                        (cur_count == 6'b010000) ? coeff17 :
                        (cur_count == 6'b010001) ? coeff18 :
                        (cur_count == 6'b010010) ? coeff19 :
                        (cur_count == 6'b010011) ? coeff20 :
                        (cur_count == 6'b010100) ? coeff21 :
                        (cur_count == 6'b010101) ? coeff22 :
                        (cur_count == 6'b010110) ? coeff23 :
                        (cur_count == 6'b010111) ? coeff24 :
                        (cur_count == 6'b011000) ? coeff25 :
                        (cur_count == 6'b011001) ? coeff26 :
                        (cur_count == 6'b011010) ? coeff27 :
                        (cur_count == 6'b011011) ? coeff28 :
                        (cur_count == 6'b011100) ? coeff29 :
                        (cur_count == 6'b011101) ? coeff30 :
                        (cur_count == 6'b011110) ? coeff31 :
                        (cur_count == 6'b011111) ? coeff32 :
                        (cur_count == 6'b100000) ? coeff33 :
                        (cur_count == 6'b100001) ? coeff34 :
                        (cur_count == 6'b100010) ? coeff35 :
                        (cur_count == 6'b100011) ? coeff36 :
                        (cur_count == 6'b100100) ? coeff37 :
                        (cur_count == 6'b100101) ? coeff38 :
                        (cur_count == 6'b100110) ? coeff39 :
                        (cur_count == 6'b100111) ? coeff40 :
                        (cur_count == 6'b101000) ? coeff41 :
                        (cur_count == 6'b101001) ? coeff42 :
                        (cur_count == 6'b101010) ? coeff43 :
                        (cur_count == 6'b101011) ? coeff44 :
                        (cur_count == 6'b101100) ? coeff45 :
                        (cur_count == 6'b101101) ? coeff46 :
                        (cur_count == 6'b101110) ? coeff47 :
                        (cur_count == 6'b101111) ? coeff48 :
                        (cur_count == 6'b110000) ? coeff49 :
                        (cur_count == 6'b110001) ? coeff50 :
                        (cur_count == 6'b110010) ? coeff51 :
                        (cur_count == 6'b110011) ? coeff52 :
                        (cur_count == 6'b110100) ? coeff53 :
                        (cur_count == 6'b110101) ? coeff54 :
                        (cur_count == 6'b110110) ? coeff55 :
                        (cur_count == 6'b110111) ? coeff56 :
                        (cur_count == 6'b111000) ? coeff57 :
                        (cur_count == 6'b111001) ? coeff58 :
                        (cur_count == 6'b111010) ? coeff59 :
                        (cur_count == 6'b111011) ? coeff60 :
                        (cur_count == 6'b111100) ? coeff61 :
                        (cur_count == 6'b111101) ? coeff62 :
                        (cur_count == 6'b111110) ? coeff63 :
                        coeff64;
  assign mul_temp = inputmux_1 * product_1_mux;
  assign product_1 = (mul_temp[62:0] + {mul_temp[32], {31{~mul_temp[32]}}})>>>32;

  assign prod_typeconvert_1 = $signed({{3{product_1[30]}}, product_1});

  assign add_signext = prod_typeconvert_1;
  assign add_signext_1 = acc_out_1;
  assign add_temp = add_signext + add_signext_1;
  assign acc_sum_1 = add_temp[33:0];

  assign acc_in_1 = (phase_0 == 1'b1) ? prod_typeconvert_1 :
                   acc_sum_1;

  always @ (posedge clk)
    begin: Acc_reg_1_process
      if (reset == 1'b1) begin
        acc_out_1 <= 0;
      end
      else begin
        if (clk_enable == 1'b1) begin
          acc_out_1 <= acc_in_1;
        end
      end
    end // Acc_reg_1_process

  always @ (posedge clk)
    begin: Finalsum_reg_process
      if (reset == 1'b1) begin
        acc_final <= 0;
      end
      else begin
        if (phase_0 == 1'b1) begin
          acc_final <= acc_out_1;
        end
      end
    end // Finalsum_reg_process

  assign output_typeconvert = ({{1{acc_final[33]}}, acc_final[33:0]} + {acc_final[3], {2{~acc_final[3]}}})>>>3;

  always @ (posedge clk)
    begin: Output_Register_process
	  Done <= 1'b0;
      if (reset == 1'b1) begin
        output_register <= 0;
      end
      else begin
        if (phase_63 == 1'b1) begin
          output_register <= output_typeconvert;
		  Done <= 1'b1;
        end
      end
    end // Output_Register_process

  // Assignment Statements
  assign filter_out = output_register;
endmodule  // filter_serial
