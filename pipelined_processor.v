module pipelined_processor (
	input clk,
	input rst,
	output [31:0] testVal
	);
wire StallD,StallF,PCSrcD,MemToRegD,MemWriteD,
	 RegWriteD,ALUSrcD,RegDstD,ForwardAD,
	 FlushE,RegWriteE,MemToRegE,MemWriteE,
	 MemWriteM,ALUSrcE,RegDstE,RegWriteM,
	 MemToRegM,MemToRegW,RegWriteW,
	 BranchD;
wire [31:0] PCBranchD,instruction,PCPlus4D,
			ResultW,ALUOutM,SignImmD,RD1D,RD2D,
			RD1E,RD2E,WritedataM,
			WriteDataE,SignImmE,ALUOutE,ALUOutW,
			ReadDataW,RDM;
wire [4:0] WriteRegW,WriteRegE,WriteRegM, RsD,RtD,RdD,RsE,RtE,RdE;
wire [2:0] ALUControlD,ALUControlE;
wire [1:0] ForwardBE,ForwardAE;

Fetch_Unit FU(
.CLK(clk), 
.RST(rst), 
.RegF_EN(StallD), 
.PC_EN(StallF),
.PC_Src(PCSrcD),
.PC_branch(PCBranchD),
.Instruct(instruction),
.PC_plus4(PCPlus4D)
);

decode decode_unit (
	.clk(clk),
	.rst(clk),
	.instruction(instruction),
	.WD3(ResultW),
	.PCPlus4D(PCPlus4D),
	.ALUOutM(ALUOutM),
	.A3(WriteRegW),
	.WE3 (RegWriteW),
	.MemtoReg(MemToRegD),
	.MemWrite(MemWriteD),
	.ALUSrc(ALUSrcD),
	.RegDest(RegDstD),
	.RegWrie(RegWriteD),
	.PCSrcD(PCSrcD),
	.ForwardAD(ForwardAD),
	.ForwardBD(ForwardBD),
	.ALUControl(ALUControlD),
	.SignImmD(SignImmD),
	.PCBranchD(PCBranchD),
	.Branch(BranchD),
	.RD1(RD1D),
	.RD2(RD2D),
	.Rsd(RsD),
	.RtD(RtD),
	.RdD(RdD)
);

RegE  regE_inst (
	.rst_n(rst),
	.RegWriteD(RegWriteD),
	.MemToRegD(MemToRegD),
	.MemWriteD(MemWriteD),
	.ALUControlD(ALUControlD),
	.ALUSrcD(ALUSrcD),
	.RegDstD(RegDstD),
	.RD1D(RD1D),
	.RD2D(RD2D),
	.RsD(RsD),
	.RtD(RtD),
	.RdD(RdD),
	.SignImmD(SignImmD),
	.CLK(clk),
	.CLR(FlushE),
	.RegWriteE(RegWriteE),
	.MemToRegE(MemToRegE),
	.MemWriteE(MemWriteE),
	.ALUControlE(ALUControlE),
	.ALUSrcE(ALUSrcE),
	.RegDstE(RegDstE),
	.RD1E(RD1E),
	.RD2E(RD2E),
	.RsE(RsE),
	.RtE(RtE),
	.RdE(RdE),
	.SignImmE(SignImmE)
);

execute execute_unit ( 
	.ALUControlE(ALUControlE), 
    .ALUSrcE(ALUSrcE),
    .RegDstE(RegDstE),
	.ForwardAE(ForwardAE),
 	.ForwardBE(ForwardBE),
 	.RD1E(RD1E),
 	.RD2E(RD2E),
 	.ALUOutM(ALUOutM),
 	.ResultW(ResultW),
 	.SignImmE(SignImmE),
 	.RdE(RdE),
 	.RtE(RtE),
 	.WriteDataE(WriteDataE),
 	.WriteRegE(WriteRegE),
 	.ALUOutE(ALUOutE)
);

RegM regM_inst(
	.rst_n(rst),
	.RegWriteE(RegWriteE),
	.MemToRegE(MemToRegE),
	.MemWriteE(MemWriteE),
	.CLK(clk),
	.ALUOutE(ALUOutE),
	.WritedataE(WriteDataE),
	.WriteRegE(WriteRegE),
	.RegWriteM(RegWriteM),
	.MemToRegM(MemToRegM),
	.MemWriteM(MemWriteM),
	.ALUOutM(ALUOutM),
	.WritedataM(WritedataM),
	.WriteRegM(WriteRegM)
);

DataMemory #( .width('d32))
DMem(
	.clk(clk),
	.rst_n(rst),
	.Address(ALUOutM),
	.WriteData(WritedataM), //Data to be written
	.W_EN(MemWriteM), //write enable
	.ReadData(RDM),
	.testVal(testVal)
);

RegW regW_inst (
	.CLK(clk),
	.rst_n(rst),
	.ALUOutM(ALUOutM),
	.RDM(RDM),
	.WriteRegM(WriteRegM),
	.RegWriteM(RegWriteM),
	.MemToRegM(MemToRegM),
	.RegWriteW(RegWriteW),
	.MemToRegW(MemToRegW),
	.ReadDataW(ReadDataW),
	.ALUOutW(ALUOutW),
	.WriteRegW(WriteRegW)
);

MUX2  #( .WIDTH('d32))
mux2_1(
	.IN1(ALUOutW),
	.IN2(ReadDataW),
	.sel(MemToRegW),
	.out(ResultW)
);


Hazard_unit HU(
	.RsD(RsD),
	.RtD(RtD),
	.RsE(RsE),
	.RtE(RtE),

	.WriteRegE(WriteRegE),
	.WriteRegM(WriteRegM),
	.WriteRegW(WriteRegW),
	.RegWriteE(RegWriteE),
	.RegWriteW(RegWriteW),
	.RegWriteM(RegWriteM),
	.MemtoRegE(MemToRegE),
	.MemtoRegM(MemToRegM),
	.BranchD(BranchD),

	.ForwardBE(ForwardBE),
	.ForwardAE(ForwardAE),
	.ForwardBD(ForwardBD),
	.ForwardAD(ForwardAD),
	.FlushE(FlushE),
	.StallD(StallD),
	.StallF(StallF)
);
endmodule : pipelined_processor