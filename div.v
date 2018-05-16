module mul (
	input clk,       // Clock
	input clk_en,    // Clock Enable
	input rst_n,     // Asynchronous reset active low
	input operandA,
	input operandB,
	input module_en, // Enable the operation of the module
	input start_div, // Start the 
	output ready,    // Inform that no division is occurring
	output hi, // Quotient of the division
	output lo      // Rest of the division value
);
    
    reg remainder[31:0];
    reg divisor[31:0];
    reg quotient[31:0];

    initial remainder = operandA;
    initial divisor = operandB;
    initial quotient = 32d'0;

    repeat(32)begin

    remainder = remainder - divisor;
    if(remainder < 0)begin
    remainder = remainder + divisor;
    quotient = quotient<<1;
    end
    if(remainder >= 0)begin
    quotient = quotient<<1;
    quotient[0] = 1b'1;
    end
    divisor = divisor>>1;
    end

    assign hi = quotient;
    assign lo = remainder;

endmodule