module mul (
	input clk,       // Clock
	input clk_en,    // Clock Enable
	input rst_n,     // Asynchronous reset active low
	input module_en, // Enable the operation of the module
	input start_div, // Start the 
	input operandA,
	input operandB,
	output ready,    // Inform that no division is occurring
	output hi,
	output lo
);
    
    reg A[31:0]; // Auxiliary register A
    reg BR[31:0]; //Auxiliary register BR (stores operandB)
    reg QR[31:0]; //Auxiliary register QR (stores operandA)
    reg Qn; //Auxiliary variable for the method
    reg cte; //CTE = 1
    initial A = 32d'0; //Initializing A == 0
    initial BR = operandB; //Initializing BR = opB
    initial QR = operandA; //Initializing QR = opA
    initial Qn = 1b'0; //Initializing Qn = 0
    initial cte = 1b'1; //Initializing cte = 1

    repeat(32) begin //Repeat 32 times (Number of bits of the operands)
    if(QR[0] == Qn)begin //If QR last bit equals to Qn
    A = A>>cte; //Shift A Right
    QR = QR>>cte; //Shift QR Right
    end
    if(QR[0] == 1 && Qn == 0)begin //If QR last bit equals to 1 and Qn equals to 0
    A = A-BR; 
    Qn = 1b'1; //Qn = 1;
    QR = QR>>cte; //Shift right QR
    if(A[0] == 1)begin //if the last A bit equals to 1 QR will be now equal to -QR
    QR = -QR;
    end
    A = A>>cte;
    A = -A; //A equals to -A because acording to the method the last QR bit should go as A first bit
    end
    if(QR[0] == 0 && Qn == 1)begin
    A = A + BR;
    Qn = 1b'0;
    QR = QR>>cte;
    if(A[0] == 1)begin //if the last A bit equals to 1 QR will be now equal to -QR
    QR = -QR;
    end
    A = A>>cte;
    end
    end
    assign hi = A;
    assign lo = QR;
    
endmodule