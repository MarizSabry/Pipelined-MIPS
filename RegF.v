module RegF (
input CLK, RST, EN, CLR,
input [31:0] Instruct,
input [31:0] PC_plus4,
output reg [31:0] Instruct_out,
output reg [31:0] PC_plus4_out
);

always @(posedge CLK or negedge RST) begin
if(!RST) begin
Instruct_out <= 32'b0;
PC_plus4_out <= 32'b0;
end
else if (CLR) Instruct_out <= 32'b0;
else if (EN) begin
Instruct_out <= Instruct;
PC_plus4_out <= PC_plus4;
end
end

endmodule