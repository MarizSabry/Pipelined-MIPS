module PC_mod (
input 			CLK,
input 			RST,
input 			EN,
input 			PC_Src,	  //Control Signal: mux Selection
input 		[31:0] PC_branch, //In case of beq instruction
input 		[31:0] PC_plus4,  //In case of any other instructions
output reg 	[31:0] PC	  //current instruction address
);

wire [31:0] PC_incr;

mux_2x1 #(.Width(32)) mux(
.A(PC_plus4),
.B(PC_branch),
.S(PC_Src),
.OUT(PC_incr)
	);

always @(posedge CLK or negedge RST) begin
if (!RST) begin
PC <= 32'b0;
end
else if (EN) PC <= PC_incr;
end

endmodule
