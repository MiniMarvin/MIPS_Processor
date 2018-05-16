module partControl(
	input clk,
	input clk_en,
	input [31:0] A,
	input [31:0] B,
	input [2:0] partition, 
	output reg [31:0] word
);

always@ (*) begin
	word[31:0] <= A[31:0];
	case(partition)
	3'b000:
		word[31:0] <= {A[31:1],B[0:0]};
	3'b001:
		word[31:0] <= {A[31:8],B[7:0]};
	3'b010:
		word[31:0] <= {A[31:16],B[15:0]};
	3'b011:
		word[31:0] <=  B[31:0];
	//3'b100:
	default : word[31:0] <= 1'b0;
	endcase
end

endmodule

module testPartControl(
	output f
);

reg [31:0] A;
reg [31:0] B;
reg [2:0] partition;
reg clk;

partControl pc(
	.clk(clk)
);

parameter simulationTime = 10;

initial begin
	#(simulationTime)
	A = 2111000111; 
	B = 1232323324;
	clk = clk^1;
	partition = 0;
	#(simulationTime)
	A = 2111000111;
	B = 1232323324;
	clk = clk^1;
	partition = 1;
	#(simulationTime)
	A = 2111000111;
	B = 1232323324;
	clk = clk^1;
	partition = 2;
	#(simulationTime)
	A = 2111000111;
	B = 1232323324;
	clk = clk^1;
	partition = 3;
	
end

endmodule
