module mux_2x1 #(parameter Width = 'd32) (
	input 		[Width - 1:0] A,
	input 		[Width - 1:0] B,
	input 			      S,
	output reg 	[Width - 1:0] OUT
	);

always @(*) begin
case (S) 
0:OUT <= A;
1:OUT <= B;
endcase
end

endmodule
