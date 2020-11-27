module dp(input clk, rst);
	// IF
		// wires
		wire [11:0] inAddressIF, outAddressIF, pcPlusOneIF, addrOutStackIF;
		wire [18:0] instructionIF;
	// ID
		// wires
		wire memReadID, memWriteID, memToRegID, ALUSrcID, RegWriteID, RegDstID;
		wire [1:0] ALUOPID;
		wire [2:0] mux3BitOutID, jTypeID;
		wire [7:0] readData1OutID, readData2OutID;
		wire [10:0] muxControllOutID;
		wire [11:0] pcPlusOneID, signExtendOutID;
		wire [18:0] instructionID;
	// EX
		// wires
		wire pushEX, popEX, coutAluEX, coutFFOutEX, regWriteEX, memReadEX, memWriteEX, memToRegEX, zeroAluEX, zeroFFOutEX, ldEX, aluSrcEX; 
		wire [1:0] addrSrcEX, aluOpEX;
		wire [2:0] jTypeEX, fnEX, r1EX, r2EX, rdEX;
		wire [3:0] ALUOperEX;
		wire [7:0] readData1EX, readData2EX, ALUResEX, mux3InAOutEX, mux3InBOutEX, mux2InBOutEX;
		wire [11:0] jAdressEX, bAddressEX, pcPlusOneEX, branchAddrOutEX;
	// MEM
		// wires
		wire memReadMEM, memWriteMEM, memToRegMEM, regWriteMEM;
		wire [2:0] rdMEM;
		wire [7:0] aluResMEM, readData2MEM, readMemDataMEM;
	// WB
		// wires
		wire memToRegWB, regWriteWB;
		wire [2:0] rdWB;
		wire [7:0] readDataWB, aluResWB, muxOutWB;
	// Forwarding Unit
		// wires
		wire [1:0] FWSelA, FWSelB;
	// Hazard Unit
		// wires
		wire flushHAZ, stallHAZ, pcStallHAZ;

	// IF
		// components
		PC inst_PC_IF(
			.clk        (clk),
			.rst        (rst),
			.pcStall    (pcStallHAZ),
			.inAddress  (inAddressIF),
			.outAddress (outAddressIF)
		);
		Adder12Bit inst_Adder12Bit_IF(
			.A 	 (outAddressIF),
			.B 	 (12'b000000000001), 
			.Out (pcPlusOneIF)
		);
		MUX12Bit inst_MUX12Bit_IF(
			.A 	 (pcPlusOneIF),
			.B 	 (addrOutStackIF), 
			.C 	 (branchAddrOutEX), 
			.D 	 (jAdressEX), 
			.sel (addrSrcEX), 
			.Out (inAddressIF)
		);
		instructionMemory inst_instructionMemory_IF(
			.inAddress 	 (outAddressIF), 
			.instruction (instructionIF)
		);
		stack inst_stack_IF(
			.clk     (clk),
			.rst     (rst),
			.push    (pushEX),
			.pop     (popEX),
			.addrIn  (pcPlusOneIF),
			.addrOut (addrOutStackIF)
		);
		// pipe reg
		IFIDReg inst_IFIDReg_IF(
			.clk            (clk),
			.rst            (rst),
			.flushIFID      (flushHAZ),
			.stallIFID      (stallHAZ),
			.pcPlusOneIF    (pcPlusOneIF),
			.instIF         (instructionIF),
			.pcPlusOneIFOut (pcPlusOneID),
			.instIFOut      (instructionID)
		);

	// ID
		// components
		registerFile inst_registerFile_ID(
			.readRegister1 (instructionID[10:8]),
			.readRegister2 (mux3BitOutID),
			.writeRegister (rdWB),
			.clk           (clk),
			.rst           (rst),
			.regWrite      (regWriteWB),
			.writeData     (muxOutWB),
			.readData1     (readData1OutID),
			.readData2     (readData2OutID)
		);
		MUX3Bit inst_MUX3Bit_ID(
			.A 		(instructionID[7:5]), 
			.B 		(instructionID[13:11]), 
			.sel 	(RegDstID), 
			.Out 	(mux3BitOutID)
		);
		SE inst_SE_ID(
			.in  	(instructionID[7:0]), 
			.out 	(signExtendOutID)
		);
		Control inst_Control_ID(
			.OPCODE   (instructionID[18:14]),
			.memRead  (memReadID),
			.memWrite (memWriteID),
			.memToReg (memToRegID),
			.ALUSrc   (ALUSrcID),
			.RegWrite (RegWriteID),
			.RegDst   (RegDstID),
			.jumpType (jTypeID),
			.ALUOP    (ALUOPID)
		);
		MUX11Bit inst_MUX11Bit_ID(
			.A 		({memReadID, memWriteID, memToRegID, ALUSrcID, RegWriteID, RegDstID, jTypeID, ALUOPID}), 
			.B 		(11'b0), 
			.sel 	(stallHAZ), 
			.Out 	(muxControllOutID)
		);
		// pipe reg
		IDEXReg inst_IDEXReg_ID(
			.clk            (clk),
			.rst            (rst),
			.flushIDEX      (flushHAZ),
			.jTypeID        (muxControllOutID[4:2]),
			.aluOpID        (muxControllOutID[1:0]),
			.aluSrcID       (muxControllOutID[7]),
			.memReadID      (muxControllOutID[10]),
			.memWriteID     (muxControllOutID[9]),
			.memToRegID     (muxControllOutID[8]),
			.regWriteID     (muxControllOutID[6]),
			.pcPlusOneID    (pcPlusOneID),
			.bAddressID     (signExtendOutID),
			.jAdressID      (instructionID[11:0]),
			.readData1ID    (readData1OutID),
			.readData2ID    (readData2OutID),
			.fnID           (instructionID[16:14]),
			.r1ID           (instructionID[10:8]),
			.r2ID           (instructionID[7:5]),
			.rdID           (instructionID[13:11]),
			.jTypeIDOut     (jTypeEX),
			.aluOpIDOut     (aluOpEX),
			.aluSrcIDOut    (aluSrcEX),
			.memReadIDOut   (memReadEX),
			.memWriteIDOut  (memWriteEX),
			.memToRegIDOut  (memToRegEX),
			.regWriteIDOut  (regWriteEX),
			.pcPlusOneIDOut (pcPlusOneEX),
			.bAddressIDOut  (bAddressEX),
			.jAdressIDOut   (jAdressEX),
			.readData1IDOut (readData1EX),
			.readData2IDOut (readData2EX),
			.fnIDOut        (fnEX),
			.r1IDOut        (r1EX),
			.r2IDOut        (r2EX),
			.rdIDOut        (rdEX)
		);

	// EX
		// components
		ALU inst_ALU_EX(
			.A 		(mux3InAOutEX), 
			.B 		(mux2InBOutEX), 
			.ALU_OP (ALUOperEX), 
			.cin 	(coutFFOutEX), 
			.out 	(ALUResEX), 
			.cout 	(coutAluEX), 
			.zero 	(zeroAluEX)
		);
		Adder12BitSigned inst_Adder12BitSigned_EX(
			.A 		(pcPlusOneEX), 
			.B 		(bAddressEX), 
			.Out 	(branchAddrOutEX)
		);
		BranchControl inst_BranchControl_EX(
			.jType 		(jTypeEX), 
			.c 			(coutFFOutEX), 
			.z 			(zeroFFOutEX), 
			.addrSrc 	(addrSrcEX), 
			.push 		(pushEX), 
			.pop 		(popEX)
		);
		ALUControl inst_ALUControl_EX(
			.ALUOP  (aluOpEX),
			.fn     (fnEX),
			.ALUOUT (ALUOperEX),
			.ld     (ldEX)
		);
		FlipFlop inst_FlipFlopC_EX(
			.D 		(coutAluEX), 
			.clk 	(clk), 
			.rst 	(rst), 
			.ld 	(ldEX), 
			.Q 		(coutFFOutEX)
		);
		FlipFlop inst_FlipFlopZ_EX(
			.D 		(zeroAluEX), 
			.clk 	(clk), 
			.rst 	(rst), 
			.ld 	(ldEX), 
			.Q 		(zeroFFOutEX)
		);
		MUX8Bit3Input inst_MUX8Bit3InputA_EX(
			.A 		(readData1EX), 
			.B 		(aluResMEM),
			.C 		(muxOutWB),
			.sel 	(FWSelA), 
			.Out 	(mux3InAOutEX)
		);
		MUX8Bit3Input inst_MUX8Bit3InputB_EX(
			.A 		(readData2EX), 
			.B 		(aluResMEM),
			.C 		(muxOutWB),
			.sel 	(FWSelB), 
			.Out 	(mux3InBOutEX)
		);
		MUX8Bit inst_MUX8Bit(
			.A 		(mux3InBOutEX), 
			.B 		(bAddressEX[7:0]), 
			.sel 	(aluSrcEX), 
			.Out 	(mux2InBOutEX)
		);

		// pipe reg
		EXMEMReg inst_EXMEMReg(
			.clk            (clk),
			.rst            (rst),
			.memReadEX      (memReadEX),
			.memWriteEX     (memWriteEX),
			.memToRegEX     (memToRegEX),
			.regWriteEX     (regWriteEX),
			.aluResEX       (ALUResEX),
			.readData2EX    (mux3InBOutEX),
			.rdEX           (rdEX),
			.memReadEXOut   (memReadMEM),
			.memWriteEXOut  (memWriteMEM),
			.memToRegEXOut  (memToRegMEM),
			.regWriteEXOut  (regWriteMEM),
			.aluResEXOut    (aluResMEM),
			.readData2EXOut (readData2MEM),
			.rdEXOut        (rdMEM)
		);

	// MEM
		// components
		dataMemory inst_dataMemory_MEM(
			.addr      (aluResMEM),
			.writeData (readData2MEM),
			.memWrite  (memWriteMEM),
			.memRead   (memReadMEM),
			.clk       (clk),
			.rst       (rst),
			.readData  (readMemDataMEM)
		);

		// pipe reg
		MEMWBReg inst_MEMWBReg_MEM(
			.clk            (clk),
			.rst            (rst),
			.memToRegMEM    (memToRegMEM),
			.regWriteMEM    (regWriteMEM),
			.readDataMEM    (readMemDataMEM),
			.aluResMEM      (aluResMEM),
			.rdMEM          (rdMEM),
			.memToRegMEMOut (memToRegWB),
			.regWriteMEMOut (regWriteWB),
			.readDataMEMOut (readDataWB),
			.aluResMEMOut   (aluResWB),
			.rdMEMOut       (rdWB)
		);


	// WB
		// components
		MUX8Bit inst_MUX8Bit_WB(
			.A 		(aluResWB), 
			.B 		(readDataWB), 
			.sel 	(memToRegWB), 
			.Out 	(muxOutWB)
		);

	// Forwarding Unit
		// components
		FWUnit inst_FWUnit(
			.rdMEM       (rdMEM),
			.rdWB        (rdWB),
			.rdEX        (rdEX),
			.r1          (r1EX),
			.r2          (r2EX),
			.regWriteMEM (regWriteMEM),
			.regWriteWB  (regWriteWB),
			.memWriteEX  (memWriteEX),
			.FWselA      (FWSelA),
			.FWselB      (FWSelB)
		);

	// Hazard Unit
		// components
		HazardUnit inst_HazardUnit(
			.r1ID      (instructionID[10:8]),
			.r2ID      (instructionID[7:5]),
			.rdEX      (rdEX),
			.jType     (addrSrcEX),
			.memReadEX (memReadEX),
			.stallID   (stallHAZ),
			.stallPC   (pcStallHAZ),
			.flush     (flushHAZ)
		);

endmodule

module FINALTB();
 	reg clk, rst;
  
  	dp d(clk, rst);
  	initial begin
	  	clk=1;
    	repeat (400)
    	#200 clk=~clk;
	end
	
	initial begin
	  	rst = 1;
	  	#200;
	  	rst = 0;
	  	#400;
	end
endmodule
