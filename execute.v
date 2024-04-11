module execute (
		   input [2:0] ALUControlE, 
	       input  ALUSrcE,
	       input  RegDstE,
	       input  [1:0] ForwardAE,
	       input  [1:0] ForwardBE,
	       input  [31:0]RD1E,
	       input  [31:0]RD2E,
	       input  [31:0]ALUOutM,
	       input  [31:0]ResultW,
	       input  [31:0]SignImmE,
	       input  [4:0]RdE,
	       input  [4:0]RtE,
	       output [31:0] WriteDataE,
	       output [4:0] WriteRegE,
	       output [31:0] ALUOutE

);

wire [31:0] Bmux_out,SrcAE,SrcBE;
wire [4:0] Rmux_Out;
assign WriteDataE = Bmux_out;

MUX2 #( .WIDTH('d5)) 
Rmux (
	.IN1(RtE),
	.IN2(RdE),
	.sel(RegDstE),
	.out(Rmux_Out));

MUX2 BSignmux (	
	.IN1(Bmux_out),
	.IN2(SignImmE),
	.sel(ALUSrcE),
	.out(SrcBE));
MUX4 Amux (	
	.A(RD1E),
	.B(ResultW),
	.C(ALUOutM),
	.D('b0),
	.select(ForwardAE),
	.Out(SrcAE));
MUX4 Bmux (
	.A(RD2E),
	.B(ResultW),
	.C(ALUOutM),
	.D('b0),
	.select(ForwardBE),
	.Out(Bmux_out));
ALU alu(	
	.SrcAE(SrcAE),
	.SrcBE(SrcBE),
	.ALUOut(ALUOutE),
	.ALUControlE(ALUControlE));


endmodule
