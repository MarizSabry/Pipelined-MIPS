module Hazard_unit (
	input [4:0] RsD,
	input [4:0] RtD,
	input [4:0] RsE,
	input [4:0] RtE,

	input [4:0] WriteRegE,
	input [4:0] WriteRegM,
	input [4:0] WriteRegW,
	input 		RegWriteE,
	input 		RegWriteW,
	input 		RegWriteM,
	input 		MemtoRegE,
	input 		MemtoRegM,
	input		BranchD,

	output [1:0]ForwardBE,
	output [1:0]ForwardAE,
	output 		ForwardBD,
	output 		ForwardAD,
	output 		FlushE,
	output      StallD,
	output      StallF
);

wire branchstall, lwstall;

assign ForwardAE = ((RsE != 0) && (RsE == WriteRegM) && (RegWriteM)) ? 
						2'b10 :
					(((RsE != 0) && (RsE == WriteRegW) && (RegWriteW)) ? 
						2'b01 :
						2'b00 ); 

assign ForwardBE = ((RtE != 0) && (RtE == WriteRegM) && (RegWriteM)) ? 
						2'b10 :
					(((RtE != 0) && (RtE == WriteRegW) && (RegWriteW)) ? 
						2'b01 :
						2'b00 ); 

assign ForwardAD = ((RsD != 0) && (RsD == WriteRegM) && (RegWriteM));
assign ForwardBD = ((RtD != 0) && (RtD == WriteRegM) && (RegWriteM));

assign lwstall = (((RsD == RtE) || (RtD == RtE)) && (MemtoRegE)) ;
assign branchstall = (BranchD && RegWriteE && (WriteRegE == RsD || WriteRegE == RtD) || BranchD && MemtoRegM &&  (WriteRegM == RsD || WriteRegM == RtD)); 

assign StallF = lwstall|| branchstall;
assign StallD = lwstall || branchstall;
assign FlushE = lwstall || branchstall;

endmodule : Hazard_unit