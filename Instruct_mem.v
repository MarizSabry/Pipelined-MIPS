module Instruct_mem (
input 		[31:0] PC,
output	 	[31:0] Instr
);

reg [31:0] Instruct_mem [0:7];

initial
begin
$readmemb("Instructions.txt",Instruct_mem);
end

assign Instr = Instruct_mem[PC];

endmodule