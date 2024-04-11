module control_unit(
	input [5:0] opcode,
	input [5:0] func,
	output reg MemtoReg,MemWrite,Branch,ALUSrc,RegDest,RegWrie,
	output reg [2:0] ALUControl
);


parameter [2:0] ALU_add='b010;
parameter [2:0] ALU_sub='b110;
parameter [2:0] ALU_and='b000;
parameter [2:0] ALU_or='b001;
parameter [2:0] ALU_slt='b111;

parameter [5:0] opcode_R='b0;
parameter [5:0] opcode_lw='b100011;
parameter [5:0] opcode_sw='b101011;
parameter [5:0] opcode_beq='b000100;


always @(*)begin
	case (opcode)
	opcode_R: begin
		RegWrie='b1;
		RegDest='b1;
		ALUSrc='b0;
		Branch='b0;
		MemWrite='b0;
		MemtoReg= 'b0;
		if(func=='b100000 )begin
			ALUControl=ALU_add;
		end
		else if(func=='b100010)begin
			ALUControl=ALU_sub;
		end
		else if(func=='b100100)begin
			ALUControl=ALU_and;
		end
		else if(func=='b100101)begin
			ALUControl=ALU_or;
		end
		else if(func=='b101010)begin
			ALUControl=ALU_slt;
		end
		else begin
			ALUControl='b0;
		end
	end
	opcode_lw: begin
		RegWrie='b1;
		RegDest='b0;
		ALUSrc='b1;
		Branch='b0;
		MemWrite='b0;
		MemtoReg= 'b1;
		ALUControl=ALU_add;
	end
	opcode_sw: begin
		RegWrie='b0;
		RegDest='b0;
		ALUSrc='b1;
		Branch='b0;
		MemWrite='b1;
		MemtoReg= 'b0;
		ALUControl=ALU_add;
	end
	opcode_beq: begin
		RegWrie='b0;
		RegDest='b0;
		ALUSrc='b0;
		Branch='b1;
		MemWrite='b0;
		MemtoReg= 'b0;
		ALUControl=ALU_sub;
	end
	default: begin
		RegWrie='b0;
		RegDest='b0;
		ALUSrc='b0;
		Branch='b0;
		MemWrite='b0;
		MemtoReg= 'b0;
		ALUControl='b0;
	end
	endcase

end


endmodule 
