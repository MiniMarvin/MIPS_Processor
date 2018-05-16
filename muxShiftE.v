module muxShiftE(
	input [1:0] shiftSourceE,
	input [31:0] A,
	input [31:0] B,
	input [31:0] C,
	output reg [31:0] word
);
always@ (*) begin
	case(shiftSourceE)
	1'b00:
		word[31:0] <= A[31:0];
	1'b01:
		word[31:0] <= B[31:0];
	1'b11:
		word[31:0] <= C[31:0];
	default: word <= 1'b0;
	endcase
end

endmodule
