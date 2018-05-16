module muxShiftN(
	input [1:0] shiftSourceN,
	input [31:0] A,
	input [31:0] B,
	output reg [31:0] word
);
always@ (*) begin
	case(shiftSourceN)
	1'b000:
		word[31:0] <= A[31:0];
	1'b001:
		word[31:0] <= B[31:0];
	1'b011:
		word <= 16;
	1'b100:
		word <= 2;
	default: word <= 1'b0;
	endcase
end

endmodule
