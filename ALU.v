module ALU(
	input  [31:0] SrcAE,
    input  [31:0] SrcBE, 
    output  reg [31:0] ALUOut, 
	input  [2:0] ALUControlE );

wire [31:0] BSigned, Sum;
assign BSigned = ALUControlE[2]? ~SrcBE:SrcBE;
assign Sum = SrcAE + BSigned + ALUControlE[2];

always@(*) begin
case (ALUControlE)
	3'b000: ALUOut <= SrcAE & BSigned;
	3'b001: ALUOut <= SrcAE | BSigned;
	3'b010: ALUOut <= SrcAE + SrcBE;
	3'b100: ALUOut <= SrcAE & BSigned;
	3'b101: ALUOut <= SrcAE | BSigned;
	3'b110: ALUOut <= SrcAE - SrcBE;
	3'b111: ALUOut <= Sum[31]; //SLT
	default : ALUOut <= 'b0;
endcase

end


endmodule
 