module Fetch_Unit (
input CLK, RST, RegF_EN, PC_EN,
input 		 PC_Src,
input [31:0] PC_branch,
output[31:0] Instruct,
output[31:0] PC_plus4
);

wire [31:0] PC, PC_4, Instr;

PC_Adder U1(
.PC(PC),
.PC_plus4(PC_4)
);

PC_mod U2(
.CLK(CLK),
.RST(RST),
.EN(PC_EN),
.PC_Src(PC_Src),	  
.PC_branch(PC_branch), 
.PC_plus4(PC_4),
.PC(PC)	
);

Instruct_mem U3(
.PC(PC),
.Instr(Instr)
);

RegF U4 (
.CLK(CLK), 
.RST(RST),
.EN(RegF_EN),
.CLR(PC_Src),
.Instruct(Instr),
.PC_plus4(PC_4),
.Instruct_out(Instruct),
.PC_plus4_out(PC_plus4)
);

endmodule