module AluOut(
	input clk,
	input clk_en,
	input [31:0] value,
	output reg [31:0] ALUOUT
);
always@ (*) begin
	ALUOUT[31:0] <= value[31:0];
end

endmodule
