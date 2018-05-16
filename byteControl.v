module byteControl (
	input clk,       // Clock
	input[31:0] a, // input a
	input partition, // Defines the amount of numbers to ignore
	output reg[31:0] f // output f
);

	// Control wich part of the word is going to pass the other part is going to become zero
	always @(posedge clk) begin
		case (partition)
			0: begin
				f <= 0;
			end

			1: begin
				f <= a[8:0];
			end

			2: begin
				f <= a[16:0];
			end

			3: begin
				f <= a;
			end

			default: begin
				f <= a;
			end
		endcase
	end

endmodule


module testBenchByteControl();

	reg [31:0] a;
	reg [2:0] part;
	reg clk;
	wire [31:0] f;

	byteControl bc(
		.clk(clk), 
		.a(a),
		.partition(part),
		.f(f)
	);

	parameter baseTime = 10;
	parameter testVal = 32'b11111111111111111111111111111111;

	initial begin
		#(baseTime)
		a = 24;
		part = 0;
		clk = clk ^ 1;
		#(baseTime)
		a = 24;
		part = 1;
		clk = clk ^ 1;
		#(baseTime)
		a = 24;
		part = 2;
		clk = clk ^ 1;
		#(baseTime)
		a = 24;
		part = 3;
		clk = clk ^ 1;
		#(baseTime)
		a = 24;
		part = 4;
		clk = clk ^ 1;
		#(baseTime)
		a = 24;
		part = 4;
		clk = clk ^ 1;
	end

endmodule