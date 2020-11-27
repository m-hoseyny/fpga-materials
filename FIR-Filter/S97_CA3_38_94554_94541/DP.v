module DP(
    input clk, rst,
    input TRLD, IorD, pcWrite, pcWriteCond, IRLD, memWrite, memRead, wrSrc, DILD, regSrc, regWrite, pcSrc, ALUSrcb, 
    input [1:0] ALUOP, WDSrc,
    output [3:0] opCode
);


wire [12:0]pcIn, pcOut, pcUp, pcTR, memAddress;
wire [7:0]memOut, IROut, R1Out, R2Out, BOut, ALUA, ALUB, regBOut, ALUOut, ALURegOut, WriteData;
wire [4:0]DIOut;
wire [1:0]R1In, R2In, WriteReg;
wire Z, C, N;
wire [2:0]CZNOut;
wire CZNOutMux;
wire pcLD;

assign pcLD = (CZNOutMux & pcWriteCond) | pcWrite;
assign opCode = IROut[7:4];


PC pc(clk, rst, pcLD, pcIn, pcOut);
MUX13Bit muxMem(pcOut, pcTR, IorD, memAddress);
// memory
dataMemory datamem(clk, rst, memAddress, ALUA, memWrite, memRead, memOut);

IR irreg(clk, rst, IRLD, memOut, IROut);
DI direg(clk, rst, DILD, IROut[4:0], DIOut);
//MUX1Bit muxczn(1, C, Z, N, DIOut[2:1], CZN);
Adder13Bit pcadder(13'b0000000000001, pcOut, pcUp);
TR trreg(clk, rst, TRLD, {IROut[4:0], memOut}, pcTR);
MUX13Bit muxPC(pcUp, pcTR, pcSrc, pcIn);

MUX2Bit muxr1(IROut[3:2], DIOut[4:3], regSrc, R1In);
MUX2Bit muxWR(IROut[3:2], DIOut[4:3], wrSrc, WriteReg);
MUX8Bit3 muxWD(ALURegOut, memOut, ALUB, WDSrc, WriteData);
registerFile regfile(clk, rst, regWrite, R1In, IROut[1:0], WriteReg, WriteData, R1Out, R2Out);

REG8BIT A(clk, rst, R1Out, ALUA);
REG8BIT B(clk, rst, BOut, ALUB);
MUX8Bit alubmux(R2Out, memOut, ALUSrcb, BOut);
ALU alu(ALUA, ALUB, ALUOP, CZNOut[0], ALUOut, C, Z, N);
REG8BIT reg8bit(clk, rst, ALUOut, ALURegOut);
MUX1Bit cznMux(1'b1, CZNOut[0], CZNOut[1], CZNOut[2], DIOut[2:1], CZNOutMux);

CZN czn(clk, rst, {C,Z,N}, CZNOut);








endmodule