module myMux(
	input [2:0] select,
	input [31:0] A,
	input [31:0] B,
	input [31:0] C,
	input [31:0] D,
	input [31:0] E,
	input [31:0] F,
	input [31:0] G,
	output reg [31:0] word
);
always@ (*) begin
	case(ALuSrcA)
	2'b00:
		word[31:0] <= A;
	//default:
	endcase
end

endmodule

module testMux();

	reg[2:0] s;

	reg dezesseis = 16;
	reg dois = 2;

	myMux(
		.select(shiftSourceN),
		.A(a),
		.B(b),
		.C(dezesseis),
		.D(dois),
		.word(f)
	);


endmodule
