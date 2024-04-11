module PC_Adder (
input [31:0] PC,
output [31:0] PC_plus4
);

assign PC_plus4 = PC + 32'b100;

endmodule
