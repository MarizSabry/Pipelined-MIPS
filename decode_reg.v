module decode_reg(
	input clk,rst,clear,
	input [31:0] instruction,WD3,PCPlus4D,ALUOutM,
	input [4:0] A3,
	output PCSrcD,
	output [31:0]PCBranchD,
	output reg MemtoRegE,MemWriteE,ALUSrcE,RegDestE,RegWrieE,ForwardADE,ForwardBDE,
	output reg [31:0] SignImmE,RD1E,RD2E,RsdE,RtDE,RdDE,
	output reg [2:0] ALUControlE

);
wire MemtoReg,MemWrite,ALUSrc,RegDest,RegWrie,ForwardAD,ForwardBD;
wire [31:0] SignImmD,RD1,RD2,Rsd,RtD,RdD;
wire[2:0]ALUControl;

always @(posedge clk or negedge rst) begin
	if (!rst) begin
		
		MemtoRegE<=0;
		MemWriteE<=0;
		ALUSrcE<=0;
		RegDestE<=0;
		RegWrieE<=0;
		
		ForwardADE<=0;
		ForwardBDE<=0;
		SignImmE<=0;
		RD1E<=0;
		RD2E<=0;
		RsdE<=0;
		RtDE<=0;
		RdDE<=0;
		ALUControlE<=0;
	end
	else if (clear) begin
		
		MemtoRegE<=0;
		MemWriteE<=0;
		ALUSrcE<=0;
		RegDestE<=0;
		RegWrieE<=0;
		
		ForwardADE<=0;
		ForwardBDE<=0;
		SignImmE<=0;
		RD1E<=0;
		RD2E<=0;
		RsdE<=0;
		RtDE<=0;
		RdDE<=0;
		ALUControlE<=0;
	end
	else begin
		
		
		MemtoRegE<=MemtoReg;
		MemWriteE<=MemWrite;
		ALUSrcE<=ALUSrc;
		RegDestE<=RegDest;
		RegWrieE<=RegWrie;
		
		ForwardADE<=ForwardAD;
		ForwardBDE<=ForwardBD;
		SignImmE<=SignImmD;
		RD1E<=RD1;
		RD2E<=RD2;
		RsdE<=Rsd;
		RtDE<=RtDE;
		RdDE<=RdDE;
		ALUControlE<=ALUControl;
	end

end
decode dec(
	.clk(clk),
	.rst(rst),
	.instruction(instruction),
	.WD3(WD3),
	.Rsd(Rsd),
	.RtD(RtD),
	.RdD(RdD),
	.PCPlus4D(PCPlus4D),
	.ALUOutM(ALUOutM),
	.A3(A3),
	.MemtoReg(MemtoReg),
	.MemWrite(MemWrite),
	.ALUSrc(ALUSrc),
	.RegDest(RegDest),
	.RegWrie(RegWrie),
	.PCSrcD(PCSrcD),
	.ForwardAD(ForwardAD),
	.ForwardBD(ForwardBD),
	
	.ALUControl(ALUControl),
	.SignImmD(SignImmD),
	.RD1(RD1),
	.RD2(RD2),
	.PCBranchD(PCBranchD)
);


endmodule 
