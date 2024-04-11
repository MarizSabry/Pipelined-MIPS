module register_file(
	input [4:0] A1,A2,A3,
	input [31:0] WD3,
	input WE3,clk,rst,
	
	output reg [31:0] RD1,RD2
	
);
	integer i;
	reg [31:0] Registers [0:31];
	always @(posedge clk or negedge rst) begin
		if(!rst)begin
			for (i=0;i<32;i=i+1) begin
				Registers[i]<=i;
			end
		end
		else begin
			RD1<=Registers[A1];
			RD2<=Registers[A2];
			if (WE3) begin
				Registers[A3] <=WD3;
			end

		end


	end


endmodule
