module muxB(
	input [1:0] AluSrcB,
	input [31:0] A ,
	input [31:0] B,
	output reg [31:0] word
);
always@ (*) begin
	case(ALuSrcA)
	2'b00
	//default:
	endcase
end

endmodule
