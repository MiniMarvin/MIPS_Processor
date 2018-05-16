module myMux(
	input [2:0] select,
	input [31:0] A,
	input [31:0] B,
	input [31:0] C,
	input [31:0] D,
	input [31:0] E,
	input [31:0] F,
	input [31:0] G,
	input [31:0] H,
	output reg [31:0] word
);
always@ (*) begin
	case(select)
	3'b000:
		word[31:0] <= A;
	3'b001:
		word[31:0] <= B;
	3'b010:
		word[31:0] <= C;
	3'b011:		
		word[31:0] <= D;
	3'b100:
		word[31:0] <= E;
	3'b101:
		word[31:0] <= F;
	3'b110:
		word[31:0] <= G;
	3'b111:		
		word[31:0] <= H;
	endcase
end
endmodule
