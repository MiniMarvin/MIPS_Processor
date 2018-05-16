module cpu(
	input clock,
	input reset,
	output reg[7:0] clk,
	output reg[7:0] clk_en,
	output reg[7:0] opcode,
	output reg[7:0] shamt,
	output reg[7:0] rs,
	output reg[7:0] rt,
	output reg[7:0] rd,
	output reg[7:0] funct
);

UnidadeControle UnidadeControle (
	.clk(clk),
	.clk_en(clk_en),
	.opcode(opcode),
	.shamt(shamt),
	.rs(rs),
	.rt(rt),
	.rd(rd),
	.funct(funct)
);

endmodule
