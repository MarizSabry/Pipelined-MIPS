module decode(
	input clk,rst,WE3,
	input [31:0] instruction,WD3,PCPlus4D,ALUOutM,
	input [4:0] A3,
	output Branch,MemtoReg,MemWrite,ALUSrc,RegDest,RegWrie,PCSrcD,ForwardAD,ForwardBD,
	output [2:0] ALUControl,
	output [31:0] SignImmD,PCBranchD,RD1,RD2,
	output [4:0]  Rsd,RtD,RdD
);
wire equalD;
wire [31:0] SignImmD_internal,M1,M2;
register_file RF(
	.A1(instruction[25:21]),
	.A2(instruction[20:16]),
	.A3(A3),
	.WD3(WD3),
	.WE3(WE3),
	.clk(clk),
	.rst(rst),
	.RD1(RD1),
	.RD2(RD2)
	
);
control_unit CU(
	.opcode(instruction[31:26]),
	.func(instruction[5:0]),
	.MemtoReg(MemtoReg),
	.MemWrite(MemWrite),
	.Branch(Branch),
	.ALUSrc(ALUSrc),
	.RegDest(RegDest),
	.RegWrie(RegWrie),
	.ALUControl(ALUControl)
);

MUX2#(.WIDTH(32)) Mux1(
	.IN1(RD1),
	.IN2(ALUOutM),
	.sel(ForwardAD),
	.out(M1)
);
MUX2#(.WIDTH(32)) Mux2(
	.IN1(RD2),
	.IN2(ALUOutM),
	.sel(ForwardBD),
	.out(M2)
);

assign SignImmD_internal={{16{instruction[15]}},instruction[15:0]};
assign SignImmD=SignImmD_internal;
assign RsD=instruction[25:21];
assign RtD=instruction[20:16];
assign RdD=instruction[15:11];
assign PCBranchD=PCPlus4D+(SignImmD_internal<<2);
assign equalD=M1==M2;
assign PCSrcD=equalD & Branch;

endmodule
