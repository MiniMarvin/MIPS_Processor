module UnidadeControle(
	input clk,
	input clk_en,
	input opcode,
	input shamt,
	input rs,
	input rt,
	input rd,
	input funct,
	output reg[7:0] MuxPC,
	output reg[7:0] IorD,
	output reg[7:0] IRWrite,
	output reg[7:0] PCSource,
	output reg[7:0] PCWrite,
	output reg[7:0] PCWriteCond,
	output reg[7:0] MemRead,
	output reg[7:0] MemWrite,
	output reg[7:0] MemAddress,
	output reg[7:0] MemToReg,
	output reg[7:0] AluSrcA,
	output reg[7:0] AluSrcB,
	output reg[7:0] AluOP,
	output reg[7:0] ShiftOP,
	output reg[7:0] ShiftSourceN,
	output reg[7:0] ShiftSourceE,
	output reg[7:0] Partition,
	output reg[7:0] ByteControl,
	output reg[7:0] IntCause,
	output reg[7:0] CauseWrite,
	output reg[7:0] EPCWrite,
	output reg[7:0] SignO,
	output reg[7:0] RegDst,
	output reg[7:0] RegWrite,
	output reg[7:0] ReadRegister,
	output reg[7:0] WriteData,
	output reg[7:0] DivMul,
	output reg[7:0] EnableDivMul
);

reg [7:0] state;
reg [7:0] timer;
//initial state <= 0;

// parameter timeBase


always@ (*) begin
	case(state)
	1: begin
		MuxPC <= 0;
		IorD <= 0;
		IRWrite <= 0;
		PCSource <= 0;
		PCWrite <= 0;
		PCWriteCond <= 0;
		MemRead <= 1;
		MemWrite <= 0;
		MemAddress <= 0;
		MemToReg <= 0;
		AluSrcA <= 0;
		AluSrcB <= 1;
		AluOP <= 1;
		ShiftOP <= 0;
		ShiftSourceN <= 0;
		ShiftSourceE <= 0;
		Partition <= 0;
		ByteControl <= 0;
		IntCause <= 0;
		CauseWrite <= 0;
		EPCWrite <= 0;
		SignO <= 0;
		RegDst <= 0;
		RegWrite <= 0;
		ReadRegister <= 0;
		WriteData <= 0;
		DivMul <= 0;
		EnableDivMul <= 0;
		
		state <= 2;
		timer <= 0;
	end
	2: begin
		if(timer == 2) begin
			state <= 3;
			timer <= 0;
		end
		else begin
			timer <= timer + 1;
		end
		
		MuxPC <= 0;
		IorD <= 0;
		IRWrite <= 1;
		PCSource <= 0;
		PCWrite <= 1;
		PCWriteCond <= 0;
		MemRead <= 0;
		MemWrite <= 0;
		MemAddress <= 0;
		MemToReg <= 0;
		AluSrcA <= 0;
		AluSrcB <= 0;
		AluOP <= 0;
		ShiftOP <= 0;
		ShiftSourceN <= 0;
		ShiftSourceE <= 0;
		Partition <= 0;
		ByteControl <= 0;
		IntCause <= 0;
		CauseWrite <= 0;
		EPCWrite <= 0;
		SignO <= 0;
		RegDst <= 0;
		RegWrite <= 0;
		ReadRegister <= 0;
		WriteData <= 0;
		DivMul <= 0;
		EnableDivMul <= 0;
	end
	3: begin
		MuxPC <= 0;
		IorD <= 0;
		IRWrite <= 0;
		PCSource <= 0;
		PCWrite <= 0;
		PCWriteCond <= 0;
		MemRead <= 0;
		MemWrite <= 0;
		MemAddress <= 0;
		MemToReg <= 0;
		AluSrcA <= 0;
		AluSrcB <= 3;
		AluOP <= 1;
		ShiftOP <= 0;
		ShiftSourceN <= 3;
		ShiftSourceE <= 2;
		Partition <= 0;
		ByteControl <= 0;
		IntCause <= 0;
		CauseWrite <= 0;
		EPCWrite <= 0;
		SignO <= 0;
		RegDst <= 0;
		RegWrite <= 0;
		ReadRegister <= 0;
		WriteData <= 0;
		DivMul <= 0;
		EnableDivMul <= 0;

		// PROXIMO ESTADO
		if (opcode == 0) begin // r type functions
			if (funct == 8'h20) begin // add
				state <= 26;
			end
			if (funct == 8'h24) begin // and
				state <= 25;
			end
			if (funct == 8'h1a) begin // div
				state <= 22;
			end
			if (funct == 8'h18) begin // mult
				state <= 21;
			end
			if (funct == 8'h8) begin // jr
				state <= 19;
			end
			if (funct == 8'h10) begin // mfhi
				state <= 18;
			end
			if (funct == 8'h12) begin // mflo
				state <= 17;
			end
			if (funct == 8'h0) begin // sll
				state <= 31;
			end
			if (funct == 8'h4) begin // sllv
				state <= 32;
			end
			if (funct == 8'h2a) begin // slt
				state <= 28;
			end
			if (funct == 8'h3) begin // sra
				state <= 33;
			end
			if (funct == 8'h7) begin // srav
				state <= 34;
			end
			if (funct == 8'h2) begin // srl
				state <= 29;
			end
			if (funct == 8'h22) begin // sub
				state <= 24;
			end
			if (funct == 8'hd) begin // break
				state <= 15;
			end
			if (funct == 8'h13) begin // rte
				state <= 14;
			end
			if (funct == 8'h5) begin // push
				state <= 38;
			end
			if (funct == 8'h6) begin // pop
				state <= 41;
			end
		end
		else if (opcode == 8'h2 || opcode == 8'h3)begin // j/jal
			if (opcode == 8'h2) begin
				state <= 51;
			end
			else begin
				state <= 52;
			end
		end
		else begin // Formato I
			if (opcode == 8'h8) begin // addi
				state <= 48;
			end
			if (opcode == 8'h9) begin // addiu
				state <= 47;
			end
			if (opcode == 8'h4) begin // beq
				state <= 46;
			end
			if (opcode == 8'h5) begin // bne
				state <= 43;
			end
			if (opcode == 8'h6) begin // ble
				state <= 44;
			end
			if (opcode == 8'h7) begin // bgt
				state <= 45;
			end
			if (opcode == 8'hf) begin // lui
				state <= 30;
			end
			if (opcode == 8'ha) begin // slti
				/////////////////////////////////////////////////// FAZER!!!!!!!!!!! NAO TA NA CARTOLINA
			end
		end
		
	end
	4: begin
		MuxPC <= 0;
		IorD <= 0;
		IRWrite <= 0;
		PCSource <= 0;
		PCWrite <= 0;
		PCWriteCond <= 0;
		MemRead <= 0;
		MemWrite <= 0;
		MemAddress <= 0;
		MemToReg <= 0;
		AluSrcA <= 1;
		AluSrcB <= 2;
		AluOP <= 1;
		ShiftOP <= 0;
		ShiftSourceN <= 0;
		ShiftSourceE <= 0;
		Partition <= 0;
		ByteControl <= 0;
		IntCause <= 0;
		CauseWrite <= 0;
		EPCWrite <= 0;
		SignO <= 0;
		RegDst <= 0;
		RegWrite <= 0;
		ReadRegister <= 0;
		WriteData <= 0;
		DivMul <= 0;
		EnableDivMul <= 0;

		if (opcode == 8'h28) begin // sb
			state <= 13;
		end
		if (opcode == 8'h29) begin // sh
			state <= 10;
		end
		if (opcode == 8'h2b) begin // sw
			state <= 7;
		end
		if (opcode == 8'h23) begin // lw
			state <= 5;
		end
		if (opcode == 8'h20) begin // lb
			state <= 11;
		end
		if (opcode == 8'h21) begin // lh
			state <= 8;
		end
	end 
	5: begin
		///
		MuxPC <= 0;
		IorD <= 1;
		IRWrite <= 0;
		PCSource <= 0;
		PCWrite <= 0;
		PCWriteCond <= 0;
		MemRead <= 1;
		MemWrite <= 0;
		MemAddress <= 0;
		MemToReg <= 0;
		AluSrcA <= 0;
		AluSrcB <= 0;
		AluOP <= 0;
		ShiftOP <= 0;
		ShiftSourceN <= 0;
		ShiftSourceE <= 0;
		Partition <= 0;
		ByteControl <= 1;
		IntCause <= 0;
		CauseWrite <= 0;
		EPCWrite <= 0;
		SignO <= 0;
		RegDst <= 0;
		RegWrite <= 0;
		ReadRegister <= 0;
		WriteData <= 0;
		DivMul <= 0;
		EnableDivMul <= 0;
		//

		if (timer == 2) begin
			timer <= 0;
			state <= 6;
		end
		else begin
			timer <= timer + 1;
		end
	end
	6: begin

		MuxPC <= 0;
		IorD <= 0;
		IRWrite <= 0;
		PCSource <= 0;
		PCWrite <= 0;
		PCWriteCond <= 0;
		MemRead <= 0;
		MemWrite <= 0;
		MemAddress <= 0;
		MemToReg <= 1;
		AluSrcA <= 0;
		AluSrcB <= 0;
		AluOP <= 0;
		ShiftOP <= 0;
		ShiftSourceN <= 0;
		ShiftSourceE <= 0;
		Partition <= 0;
		ByteControl <= 0;
		IntCause <= 0;
		CauseWrite <= 0;
		EPCWrite <= 0;
		SignO <= 0;
		RegDst <= 0;
		RegWrite <= 1;
		ReadRegister <= 0;
		WriteData <= 0;
		DivMul <= 0;
		EnableDivMul <= 0;

		if (timer == 1) begin
			/////////
			// acabou
		end
		else begin
			timer <= timer + 1;
		end
	end
	7: begin
		MuxPC <= 0;
		IorD <= 1;
		IRWrite <= 0;
		PCSource <= 0;
		PCWrite <= 0;
		PCWriteCond <= 0;
		MemRead <= 0;
		MemWrite <= 1;
		MemAddress <= 0;
		MemToReg <= 0;
		AluSrcA <= 0;
		AluSrcB <= 0;
		AluOP <= 0;
		ShiftOP <= 0;
		ShiftSourceN <= 0;
		ShiftSourceE <= 0;
		Partition <= 0;
		ByteControl <= 0;
		IntCause <= 0;
		CauseWrite <= 0;
		EPCWrite <= 0;
		SignO <= 0;
		RegDst <= 0;
		RegWrite <= 0;
		ReadRegister <= 0;
		WriteData <= 0;
		DivMul <= 0;
		EnableDivMul <= 0;
	end
	8: begin
		MuxPC <= 0;
		IorD <= 0;
		IRWrite <= 0;
		PCSource <= 0;
		PCWrite <= 0;
		PCWriteCond <= 0;
		MemRead <= 0;
		MemWrite <= 0;
		MemAddress <= 0;
		MemToReg <= 0;
		AluSrcA <= 0;
		AluSrcB <= 0;
		AluOP <= 0;
		ShiftOP <= 0;
		ShiftSourceN <= 0;
		ShiftSourceE <= 0;
		Partition <= 1;
		ByteControl <= 1;
		IntCause <= 0;
		CauseWrite <= 0;
		EPCWrite <= 0;
		SignO <= 0;
		RegDst <= 0;
		RegWrite <= 0;
		ReadRegister <= 0;
		WriteData <= 0;
		DivMul <= 0;
		EnableDivMul <= 0;

		if (timer == 2) begin
			state <= 9;
			timer <= 0;
		end
		else begin
			timer <= timer + 1;
		end
	end
	9: begin
		MuxPC <= 0;
		IorD <= 0;
		IRWrite <= 0;
		PCSource <= 0;
		PCWrite <= 0;
		PCWriteCond <= 0;
		MemRead <= 0;
		MemWrite <= 0;
		MemAddress <= 0;
		MemToReg <= 1;
		AluSrcA <= 0;
		AluSrcB <= 0;
		AluOP <= 0;
		ShiftOP <= 0;
		ShiftSourceN <= 0;
		ShiftSourceE <= 0;
		Partition <= 0;
		ByteControl <= 0;
		IntCause <= 0;
		CauseWrite <= 0;
		EPCWrite <= 0;
		SignO <= 0;
		RegDst <= 0;
		RegWrite <= 1;
		ReadRegister <= 0;
		WriteData <= 0;
		DivMul <= 0;
		EnableDivMul <= 0;

		if (timer == 1) begin
			////////
			// acabou
		end
		else begin
			timer <= timer + 1;
		end
	end
	10: begin
		MuxPC <= 0;
		IorD <= 1;
		IRWrite <= 0;
		PCSource <= 0;
		PCWrite <= 0;
		PCWriteCond <= 0;
		MemRead <= 0;
		MemWrite <= 1;
		MemAddress <= 0;
		MemToReg <= 0;
		AluSrcA <= 0;
		AluSrcB <= 0;
		AluOP <= 0;
		ShiftOP <= 0;
		ShiftSourceN <= 0;
		ShiftSourceE <= 0;
		Partition <= 1;
		ByteControl <= 0;
		IntCause <= 0;
		CauseWrite <= 0;
		EPCWrite <= 0;
		SignO <= 0;
		RegDst <= 0;
		RegWrite <= 0;
		ReadRegister <= 0;
		WriteData <= 0;
		DivMul <= 0;
		EnableDivMul <= 0;
	end
	11: begin
		MuxPC <= 0;
		IorD <= 0;
		IRWrite <= 0;
		PCSource <= 0;
		PCWrite <= 0;
		PCWriteCond <= 0;
		MemRead <= 0;
		MemWrite <= 0;
		MemAddress <= 0;
		MemToReg <= 0;
		AluSrcA <= 0;
		AluSrcB <= 0;
		AluOP <= 0;
		ShiftOP <= 0;
		ShiftSourceN <= 0;
		ShiftSourceE <= 0;
		Partition <= 1;
		ByteControl <= 2;
		IntCause <= 0;
		CauseWrite <= 0;
		EPCWrite <= 0;
		SignO <= 0;
		RegDst <= 0;
		RegWrite <= 0;
		ReadRegister <= 0;
		WriteData <= 0;
		DivMul <= 0;
		EnableDivMul <= 0;

		if (timer == 2) begin
			state <= 12;
			timer <= 0;
		end
		else begin
			timer <= timer + 1;
		end
	end
	12: begin
		MuxPC <= 0;
		IorD <= 0;
		IRWrite <= 0;
		PCSource <= 0;
		PCWrite <= 0;
		PCWriteCond <= 0;
		MemRead <= 0;
		MemWrite <= 0;
		MemAddress <= 0;
		MemToReg <= 1;
		AluSrcA <= 0;
		AluSrcB <= 0;
		AluOP <= 0;
		ShiftOP <= 0;
		ShiftSourceN <= 0;
		ShiftSourceE <= 0;
		Partition <= 0;
		ByteControl <= 0;
		IntCause <= 0;
		CauseWrite <= 0;
		EPCWrite <= 0;
		SignO <= 0;
		RegDst <= 0;
		RegWrite <= 1;
		ReadRegister <= 0;
		WriteData <= 0;
		DivMul <= 0;
		EnableDivMul <= 0;

		if (timer == 1) begin
			/////////
			/// acabou
		end
		else begin
			timer <= timer + 1;
		end
	end
	13: begin
		MuxPC <= 0;
		IorD <= 1;
		IRWrite <= 0;
		PCSource <= 0;
		PCWrite <= 0;
		PCWriteCond <= 0;
		MemRead <= 0;
		MemWrite <= 1;
		MemAddress <= 0;
		MemToReg <= 0;
		AluSrcA <= 0;
		AluSrcB <= 0;
		AluOP <= 0;
		ShiftOP <= 0;
		ShiftSourceN <= 0;
		ShiftSourceE <= 0;
		Partition <= 0;
		ByteControl <= 0;
		IntCause <= 0;
		CauseWrite <= 0;
		EPCWrite <= 0;
		SignO <= 0;
		RegDst <= 0;
		RegWrite <= 0;
		ReadRegister <= 0;
		WriteData <= 0;
		DivMul <= 0;
		EnableDivMul <= 0;
	end
	14: begin
		MuxPC <= 0;
		IorD <= 0;
		IRWrite <= 0;
		PCSource <= 3;
		PCWrite <= 1;
		PCWriteCond <= 0;
		MemRead <= 0;
		MemWrite <= 0;
		MemAddress <= 0;
		MemToReg <= 0;
		AluSrcA <= 0;
		AluSrcB <= 0;
		AluOP <= 0;
		ShiftOP <= 0;
		ShiftSourceN <= 0;
		ShiftSourceE <= 0;
		Partition <= 0;
		ByteControl <= 0;
		IntCause <= 0;
		CauseWrite <= 0;
		EPCWrite <= 0;
		SignO <= 0;
		RegDst <= 0;
		RegWrite <= 0;
		ReadRegister <= 0;
		WriteData <= 0;
		DivMul <= 0;
		EnableDivMul <= 0;

		if (timer == 1) begin
			/////// acabou
		end
		else begin
			timer <= timer + 1;
		end
	end
	15: begin
		MuxPC <= 0;
		IorD <= 0;
		IRWrite <= 0;
		PCSource <= 0;
		PCWrite <= 0;
		PCWriteCond <= 0;
		MemRead <= 0;
		MemWrite <= 0;
		MemAddress <= 0;
		MemToReg <= 0;
		AluSrcA <= 0;
		AluSrcB <= 1;
		AluOP <= 2;
		ShiftOP <= 0;
		ShiftSourceN <= 0;
		ShiftSourceE <= 0;
		Partition <= 0;
		ByteControl <= 0;
		IntCause <= 0;
		CauseWrite <= 0;
		EPCWrite <= 0;
		SignO <= 0;
		RegDst <= 0;
		RegWrite <= 0;
		ReadRegister <= 0;
		WriteData <= 0;
		DivMul <= 0;
		EnableDivMul <= 0;
	end
	16: begin
		MuxPC <= 0;
		IorD <= 0;
		IRWrite <= 0;
		PCSource <= 1;
		PCWrite <= 1;
		PCWriteCond <= 0;
		MemRead <= 0;
		MemWrite <= 0;
		MemAddress <= 2;
		MemToReg <= 0;
		AluSrcA <= 0;
		AluSrcB <= 1;
		AluOP <= 2;
		ShiftOP <= 0;
		ShiftSourceN <= 0;
		ShiftSourceE <= 0;
		Partition <= 0;
		ByteControl <= 0;
		IntCause <= 3;
		CauseWrite <= 3;
		EPCWrite <= 0;
		SignO <= 0;
		RegDst <= 0;
		RegWrite <= 0;
		ReadRegister <= 0;
		WriteData <= 0;
		DivMul <= 0;
		EnableDivMul <= 0;
		/// error write epc
	end
	17: begin
		MuxPC <= 0;
		IorD <= 0;
		IRWrite <= 0;
		PCSource <= 0;
		PCWrite <= 0;
		PCWriteCond <= 0;
		MemRead <= 0;
		MemWrite <= 0;
		MemAddress <= 0;
		MemToReg <= 2;
		AluSrcA <= 0;
		AluSrcB <= 0;
		AluOP <= 0;
		ShiftOP <= 0;
		ShiftSourceN <= 0;
		ShiftSourceE <= 0;
		Partition <= 0;
		ByteControl <= 0;
		IntCause <= 0;
		CauseWrite <= 0;
		EPCWrite <= 0;
		SignO <= 0;
		RegDst <= 3;
		RegWrite <= 1;
		ReadRegister <= 0;
		WriteData <= 0;
		DivMul <= 0;
		EnableDivMul <= 0;

		if (timer == 1) begin
			/////// acabou
		end
		else begin
			timer <= timer + 1;
		end
	end
	18: begin
		MuxPC <= 0;
		IorD <= 0;
		IRWrite <= 0;
		PCSource <= 0;
		PCWrite <= 0;
		PCWriteCond <= 0;
		MemRead <= 0;
		MemWrite <= 0;
		MemAddress <= 0;
		MemToReg <= 1;
		AluSrcA <= 0;
		AluSrcB <= 0;
		AluOP <= 0;
		ShiftOP <= 0;
		ShiftSourceN <= 0;
		ShiftSourceE <= 0;
		Partition <= 0;
		ByteControl <= 0;
		IntCause <= 0;
		CauseWrite <= 0;
		EPCWrite <= 0;
		SignO <= 0;
		RegDst <= 3;
		RegWrite <= 1;
		ReadRegister <= 0;
		WriteData <= 0;
		DivMul <= 0;
		EnableDivMul <= 0;

		if (timer == 1) begin
			/////// acabou
		end
		else begin
			timer <= timer + 1;
		end
	end
	19: begin
		MuxPC <= 3;
		IorD <= 0;
		IRWrite <= 0;
		PCSource <= 0;
		PCWrite <= 0;
		PCWriteCond <= 0;
		MemRead <= 0;
		MemWrite <= 0;
		MemAddress <= 0;
		MemToReg <= 0;
		AluSrcA <= 0;
		AluSrcB <= 3;
		AluOP <= 1;
		ShiftOP <= 0;
		ShiftSourceN <= 0;
		ShiftSourceE <= 0;
		Partition <= 0;
		ByteControl <= 0;
		IntCause <= 0;
		CauseWrite <= 0;
		EPCWrite <= 0;
		SignO <= 0;
		RegDst <= 0;
		RegWrite <= 0;
		ReadRegister <= 0;
		WriteData <= 0;
		DivMul <= 0;
		EnableDivMul <= 0;

		state <= 20;
	end
	20: begin
		MuxPC <= 0;
		IorD <= 0;
		IRWrite <= 0;
		PCSource <= 1;
		PCWrite <= 1;
		PCWriteCond <= 0;
		MemRead <= 0;
		MemWrite <= 0;
		MemAddress <= 0;
		MemToReg <= 0;
		AluSrcA <= 0;
		AluSrcB <= 0;
		AluOP <= 0;
		ShiftOP <= 0;
		ShiftSourceN <= 0;
		ShiftSourceE <= 0;
		Partition <= 0;
		ByteControl <= 0;
		IntCause <= 0;
		CauseWrite <= 0;
		EPCWrite <= 0;
		SignO <= 0;
		RegDst <= 0;
		RegWrite <= 0;
		ReadRegister <= 0;
		WriteData <= 0;
		DivMul <= 0;
		EnableDivMul <= 0;
	end
	21: begin
		MuxPC <= 0;
		IorD <= 0;
		IRWrite <= 0;
		PCSource <= 0;
		PCWrite <= 0;
		PCWriteCond <= 0;
		MemRead <= 0;
		MemWrite <= 0;
		MemAddress <= 0;
		MemToReg <= 0;
		AluSrcA <= 0;
		AluSrcB <= 0;
		AluOP <= 0;
		ShiftOP <= 0;
		ShiftSourceN <= 0;
		ShiftSourceE <= 0;
		Partition <= 0;
		ByteControl <= 0;
		IntCause <= 0;
		CauseWrite <= 0;
		EPCWrite <= 0;
		SignO <= 0;
		RegDst <= 0;
		RegWrite <= 0;
		ReadRegister <= 0;
		WriteData <= 0;
		DivMul <= 0;
		EnableDivMul <= 1;

		////////////////////////////////////////////////////////////// aqui eh a multiplicacao. ver overflow.
	end
	22: begin
		MuxPC <= 0;
		IorD <= 0;
		IRWrite <= 0;
		PCSource <= 0;
		PCWrite <= 0;
		PCWriteCond <= 0;
		MemRead <= 0;
		MemWrite <= 0;
		MemAddress <= 0;
		MemToReg <= 0;
		AluSrcA <= 0;
		AluSrcB <= 0;
		AluOP <= 0;
		ShiftOP <= 0;
		ShiftSourceN <= 0;
		ShiftSourceE <= 0;
		Partition <= 0;
		ByteControl <= 0;
		IntCause <= 0;
		CauseWrite <= 0;
		EPCWrite <= 0;
		SignO <= 0;
		RegDst <= 0;
		RegWrite <= 0;
		ReadRegister <= 0;
		WriteData <= 0;
		DivMul <= 0;
		EnableDivMul <= 0;

		//////////////////////////////////////////////////////////////// if divisao por 0
		//////////////////////////////////////////////////////////state <= 23;
	end
	23: begin
		//
		MuxPC <= 0;
		IorD <= 0;
		IRWrite <= 0;
		PCSource <= 1;
		PCWrite <= 1;
		PCWriteCond <= 0;
		MemRead <= 0;
		MemWrite <= 0;
		MemAddress <= 3;
		MemToReg <= 0;
		AluSrcA <= 0;
		AluSrcB <= 1;
		AluOP <= 2;
		ShiftOP <= 0;
		ShiftSourceN <= 0;
		ShiftSourceE <= 0;
		Partition <= 0;
		ByteControl <= 0;
		IntCause <= 2;
		CauseWrite <= 1;
		EPCWrite <= 1;
		SignO <= 0;
		RegDst <= 0;
		RegWrite <= 0;
		ReadRegister <= 0;
		WriteData <= 0;
		DivMul <= 0;
		EnableDivMul <= 0;
	end
	24: begin
		MuxPC <= 0;
		IorD <= 0;
		IRWrite <= 0;
		PCSource <= 0;
		PCWrite <= 0;
		PCWriteCond <= 0;
		MemRead <= 0;
		MemWrite <= 0;
		MemAddress <= 0;
		MemToReg <= 0;
		AluSrcA <= 1;
		AluSrcB <= 0;
		AluOP <= 2;
		ShiftOP <= 0;
		ShiftSourceN <= 0;
		ShiftSourceE <= 0;
		Partition <= 0;
		ByteControl <= 0;
		IntCause <= 0;
		CauseWrite <= 0;
		EPCWrite <= 0;
		SignO <= 0;
		RegDst <= 0;
		RegWrite <= 0;
		ReadRegister <= 0;
		WriteData <= 0;
		DivMul <= 0;
		EnableDivMul <= 0;

		////////////////////////////////////////////////////////// if overflow
		//////////////////////////////////////////////////////// state <= 37
		//////////////////////////////////////////////////////// else
		//////////////////////////////////////////////////////// state <= 27;
	end
	25: begin
		MuxPC <= 0;
		IorD <= 0;
		IRWrite <= 0;
		PCSource <= 0;
		PCWrite <= 0;
		PCWriteCond <= 0;
		MemRead <= 0;
		MemWrite <= 0;
		MemAddress <= 0;
		MemToReg <= 0;
		AluSrcA <= 1;
		AluSrcB <= 0;
		AluOP <= 3;
		ShiftOP <= 0;
		ShiftSourceN <= 0;
		ShiftSourceE <= 0;
		Partition <= 0;
		ByteControl <= 0;
		IntCause <= 0;
		CauseWrite <= 0;
		EPCWrite <= 0;
		SignO <= 0;
		RegDst <= 0;
		RegWrite <= 0;
		ReadRegister <= 0;
		WriteData <= 0;
		DivMul <= 0;
		EnableDivMul <= 0;

		state <= 27;
	end
	26: begin
		MuxPC <= 0;
		IorD <= 0;
		IRWrite <= 0;
		PCSource <= 0;
		PCWrite <= 0;
		PCWriteCond <= 0;
		MemRead <= 0;
		MemWrite <= 0;
		MemAddress <= 0;
		MemToReg <= 0;
		AluSrcA <= 1;
		AluSrcB <= 0;
		AluOP <= 1;
		ShiftOP <= 0;
		ShiftSourceN <= 0;
		ShiftSourceE <= 0;
		Partition <= 0;
		ByteControl <= 0;
		IntCause <= 0;
		CauseWrite <= 0;
		EPCWrite <= 0;
		SignO <= 0;
		RegDst <= 0;
		RegWrite <= 0;
		ReadRegister <= 0;
		WriteData <= 0;
		DivMul <= 0;
		EnableDivMul <= 0;

		//////////////////////////////////////////////////////// if overflow
		////////////////////////////////////////////////////// state <= 37
		////////////////////////////////////////////////////// else
		////////////////////////////////////////////////////// state <= 27;
	end
	27: begin
		MuxPC <= 0;
		IorD <= 0;
		IRWrite <= 0;
		PCSource <= 0;
		PCWrite <= 0;
		PCWriteCond <= 0;
		MemRead <= 0;
		MemWrite <= 0;
		MemAddress <= 0;
		MemToReg <= 0;
		AluSrcA <= 0;
		AluSrcB <= 0;
		AluOP <= 0;
		ShiftOP <= 0;
		ShiftSourceN <= 0;
		ShiftSourceE <= 0;
		Partition <= 0;
		ByteControl <= 0;
		IntCause <= 0;
		CauseWrite <= 0;
		EPCWrite <= 0;
		SignO <= 0;
		RegDst <= 1;
		RegWrite <= 1;
		ReadRegister <= 0;
		WriteData <= 0;
		DivMul <= 0;
		EnableDivMul <= 0;
		
		///////////////////////////////////////////////////////timer
	end
	28: begin
		MuxPC <= 0;
		IorD <= 0;
		IRWrite <= 0;
		PCSource <= 0;
		PCWrite <= 0;
		PCWriteCond <= 0;
		MemRead <= 0;
		MemWrite <= 0;
		MemAddress <= 0;
		MemToReg <= 0;
		AluSrcA <= 1;
		AluSrcB <= 0;
		AluOP <= 7;
		ShiftOP <= 0;
		ShiftSourceN <= 0;
		ShiftSourceE <= 0;
		Partition <= 0;
		ByteControl <= 0;
		IntCause <= 0;
		CauseWrite <= 0;
		EPCWrite <= 0;
		SignO <= 0;
		RegDst <= 0;
		RegWrite <= 0;
		ReadRegister <= 0;
		WriteData <= 0;
		DivMul <= 0;
		EnableDivMul <= 0;

		/////////////////////////////////////////////////////MANDA PRO QUE FALTOU (54 - ja ta la embaixo no codigo)
	end
	29: begin
		MuxPC <= 0;
		IorD <= 0;
		IRWrite <= 0;
		PCSource <= 0;
		PCWrite <= 0;
		PCWriteCond <= 0;
		MemRead <= 0;
		MemWrite <= 0;
		MemAddress <= 0;
		MemToReg <= 0;
		AluSrcA <= 0;
		AluSrcB <= 0;
		AluOP <= 0;
		ShiftOP <= 3;
		ShiftSourceN <= 2;
		ShiftSourceE <= 2;
		Partition <= 0;
		ByteControl <= 0;
		IntCause <= 0;
		CauseWrite <= 0;
		EPCWrite <= 0;
		SignO <= 0;
		RegDst <= 0;
		RegWrite <= 0;
		ReadRegister <= 0;
		WriteData <= 0;
		DivMul <= 0;
		EnableDivMul <= 0;

		state <= 35;
	end
	30: begin
		MuxPC <= 0;
		IorD <= 0;
		IRWrite <= 0;
		PCSource <= 0;
		PCWrite <= 0;
		PCWriteCond <= 0;
		MemRead <= 0;
		MemWrite <= 0;
		MemAddress <= 0;
		MemToReg <= 0;
		AluSrcA <= 0;
		AluSrcB <= 0;
		AluOP <= 0;
		ShiftOP <= 1;
		ShiftSourceN <= 2;
		ShiftSourceE <= 2;
		Partition <= 0;
		ByteControl <= 0;
		IntCause <= 0;
		CauseWrite <= 0;
		EPCWrite <= 0;
		SignO <= 0;
		RegDst <= 0;
		RegWrite <= 0;
		ReadRegister <= 0;
		WriteData <= 0;
		DivMul <= 0;
		EnableDivMul <= 0;

		state <= 35;
	end
	31: begin
		MuxPC <= 0;
		IorD <= 0;
		IRWrite <= 0;
		PCSource <= 0;
		PCWrite <= 0;
		PCWriteCond <= 0;
		MemRead <= 0;
		MemWrite <= 0;
		MemAddress <= 0;
		MemToReg <= 0;
		AluSrcA <= 0;
		AluSrcB <= 0;
		AluOP <= 0;
		ShiftOP <= 2;
		ShiftSourceN <= 1;
		ShiftSourceE <= 1;
		Partition <= 0;
		ByteControl <= 0;
		IntCause <= 0;
		CauseWrite <= 0;
		EPCWrite <= 0;
		SignO <= 0;
		RegDst <= 0;
		RegWrite <= 0;
		ReadRegister <= 0;
		WriteData <= 0;
		DivMul <= 0;
		EnableDivMul <= 0;

		state <= 35;
	end
	32: begin
		MuxPC <= 0;
		IorD <= 0;
		IRWrite <= 0;
		PCSource <= 0;
		PCWrite <= 0;
		PCWriteCond <= 0;
		MemRead <= 0;
		MemWrite <= 0;
		MemAddress <= 0;
		MemToReg <= 0;
		AluSrcA <= 0;
		AluSrcB <= 0;
		AluOP <= 0;
		ShiftOP <= 2;
		ShiftSourceN <= 0;
		ShiftSourceE <= 0;
		Partition <= 0;
		ByteControl <= 0;
		IntCause <= 0;
		CauseWrite <= 0;
		EPCWrite <= 0;
		SignO <= 0;
		RegDst <= 0;
		RegWrite <= 0;
		ReadRegister <= 0;
		WriteData <= 0;
		DivMul <= 0;
		EnableDivMul <= 0;

		state <= 35;
	end
	33: begin
		MuxPC <= 0;
		IorD <= 0;
		IRWrite <= 0;
		PCSource <= 0;
		PCWrite <= 0;
		PCWriteCond <= 0;
		MemRead <= 0;
		MemWrite <= 0;
		MemAddress <= 0;
		MemToReg <= 0;
		AluSrcA <= 0;
		AluSrcB <= 0;
		AluOP <= 0;
		ShiftOP <= 1;
		ShiftSourceN <= 1;
		ShiftSourceE <= 3;
		Partition <= 0;
		ByteControl <= 0;
		IntCause <= 0;
		CauseWrite <= 0;
		EPCWrite <= 0;
		SignO <= 0;
		RegDst <= 0;
		RegWrite <= 0;
		ReadRegister <= 0;
		WriteData <= 0;
		DivMul <= 0;
		EnableDivMul <= 0;

		state <= 35;
	end
	34: begin
		MuxPC <= 0;
		IorD <= 0;
		IRWrite <= 0;
		PCSource <= 0;
		PCWrite <= 0;
		PCWriteCond <= 0;
		MemRead <= 0;
		MemWrite <= 0;
		MemAddress <= 0;
		MemToReg <= 0;
		AluSrcA <= 0;
		AluSrcB <= 0;
		AluOP <= 0;
		ShiftOP <= 2;
		ShiftSourceN <= 0;
		ShiftSourceE <= 3;
		Partition <= 0;
		ByteControl <= 0;
		IntCause <= 0;
		CauseWrite <= 0;
		EPCWrite <= 0;
		SignO <= 0;
		RegDst <= 0;
		RegWrite <= 0;
		ReadRegister <= 0;
		WriteData <= 0;
		DivMul <= 0;
		EnableDivMul <= 0;

		state <= 35;
	end
	35: begin
		MuxPC <= 0;
		IorD <= 0;
		IRWrite <= 0;
		PCSource <= 0;
		PCWrite <= 0;
		PCWriteCond <= 0;
		MemRead <= 0;
		MemWrite <= 0;
		MemAddress <= 0;
		MemToReg <= 0;
		AluSrcA <= 2;
		AluSrcB <= 3;
		AluOP <= 1;
		ShiftOP <= 0;
		ShiftSourceN <= 0;
		ShiftSourceE <= 0;
		Partition <= 0;
		ByteControl <= 0;
		IntCause <= 0;
		CauseWrite <= 0;
		EPCWrite <= 0;
		SignO <= 0;
		RegDst <= 0;
		RegWrite <= 0;
		ReadRegister <= 0;
		WriteData <= 0;
		DivMul <= 0;
		EnableDivMul <= 0;

		state <= 36;
	end
	36: begin
		MuxPC <= 0;
		IorD <= 0;
		IRWrite <= 0;
		PCSource <= 0;
		PCWrite <= 0;
		PCWriteCond <= 0;
		MemRead <= 0;
		MemWrite <= 0;
		MemAddress <= 0;
		MemToReg <= 0;
		AluSrcA <= 0;
		AluSrcB <= 0;
		AluOP <= 0;
		ShiftOP <= 0;
		ShiftSourceN <= 0;
		ShiftSourceE <= 0;
		Partition <= 0;
		ByteControl <= 0;
		IntCause <= 0;
		CauseWrite <= 0;
		EPCWrite <= 0;
		SignO <= 0;
		RegDst <= 3;
		RegWrite <= 1;
		ReadRegister <= 0;
		WriteData <= 0;
		DivMul <= 0;
		EnableDivMul <= 0;

		state <= 37;
	end
	37: begin
		//
		MuxPC <= 0;
		IorD <= 0;
		IRWrite <= 0;
		PCSource <= 1;
		PCWrite <= 1;
		PCWriteCond <= 0;
		MemRead <= 0;
		MemWrite <= 0;
		MemAddress <= 4;
		MemToReg <= 0;
		AluSrcA <= 0;
		AluSrcB <= 1;
		AluOP <= 2;
		ShiftOP <= 0;
		ShiftSourceN <= 0;
		ShiftSourceE <= 0;
		Partition <= 0;
		ByteControl <= 0;
		IntCause <= 1;
		CauseWrite <= 1;
		EPCWrite <= 1;
		SignO <= 0;
		RegDst <= 0;
		RegWrite <= 0;
		ReadRegister <= 0;
		WriteData <= 0;
		DivMul <= 0;
		EnableDivMul <= 0;
	end
	38: begin
		MuxPC <= 0;
		IorD <= 0;
		IRWrite <= 0;
		PCSource <= 0;
		PCWrite <= 0;
		PCWriteCond <= 0;
		MemRead <= 0;
		MemWrite <= 0;
		MemAddress <= 0;
		MemToReg <= 0;
		AluSrcA <= 1;
		AluSrcB <= 1;
		AluOP <= 2;
		ShiftOP <= 0;
		ShiftSourceN <= 0;
		ShiftSourceE <= 0;
		Partition <= 0;
		ByteControl <= 0;
		IntCause <= 0;
		CauseWrite <= 0;
		EPCWrite <= 0;
		SignO <= 0;
		RegDst <= 0;
		RegWrite <= 0;
		ReadRegister <= 0;
		WriteData <= 0;
		DivMul <= 0;
		EnableDivMul <= 0;

		//////////////////////////////////////////////////////////////////// FALTA O AIN ????????????
		state <= 39;
	end
	39: begin
		MuxPC <= 0;
		IorD <= 0;
		IRWrite <= 0;
		PCSource <= 0;
		PCWrite <= 0;
		PCWriteCond <= 0;
		MemRead <= 0;
		MemWrite <= 0;
		MemAddress <= 1;
		MemToReg <= 1;
		AluSrcA <= 0;
		AluSrcB <= 0;
		AluOP <= 0;
		ShiftOP <= 0;
		ShiftSourceN <= 0;
		ShiftSourceE <= 0;
		Partition <= 0;
		ByteControl <= 0;
		IntCause <= 0;
		CauseWrite <= 0;
		EPCWrite <= 0;
		SignO <= 0;
		RegDst <= 0; /////////////////////////////////////////////////////// wirte register mux???
		RegWrite <= 0;
		ReadRegister <= 0;
		WriteData <= 4;
		DivMul <= 0;
		EnableDivMul <= 0;

		state <= 40;
	end
	40: begin
		MuxPC <= 0;
		IorD <= 0;
		IRWrite <= 0;
		PCSource <= 0;
		PCWrite <= 0;
		PCWriteCond <= 0;
		MemRead <= 0;
		MemWrite <= 0;
		MemAddress <= 0;
		MemToReg <= 1;
		AluSrcA <= 0;
		AluSrcB <= 0;
		AluOP <= 0;
		ShiftOP <= 0;
		ShiftSourceN <= 0;
		ShiftSourceE <= 0;
		Partition <= 0;
		ByteControl <= 0;
		IntCause <= 0;
		CauseWrite <= 0;
		EPCWrite <= 0;
		SignO <= 0;
		RegDst <= 0;
		RegWrite <= 1; //////////////////////////////////////// WriteReg???
		ReadRegister <= 1;
		WriteData <= 0;
		DivMul <= 0;
		EnableDivMul <= 0;

		//////////////////////////////////////////////////////////////////// CHECAR O "READREGISTER = 1"

		if (timer == 1) begin
			//// acabou
		end
		else begin
			timer <= timer + 1;
		end
	end
	41: begin
		//////////////////////////////////////////////////////////////////// FALTA O AIN ????????????
		MuxPC <= 0;
		IorD <= 0;
		IRWrite <= 0;
		PCSource <= 0;
		PCWrite <= 0;
		PCWriteCond <= 0;
		MemRead <= 0;
		MemWrite <= 0;
		MemAddress <= 0;
		MemToReg <= 0;
		AluSrcA <= 1;
		AluSrcB <= 1;
		AluOP <= 1;
		ShiftOP <= 0;
		ShiftSourceN <= 0;
		ShiftSourceE <= 0;
		Partition <= 0;
		ByteControl <= 0;
		IntCause <= 0;
		CauseWrite <= 0;
		EPCWrite <= 0;
		SignO <= 0;
		RegDst <= 0;
		RegWrite <= 0;
		ReadRegister <= 0;
		WriteData <= 0;
		DivMul <= 0;
		EnableDivMul <= 0;

		state <= 42;	
	end
	42: begin
		MuxPC <= 0;
		IorD <= 0;
		IRWrite <= 0;
		PCSource <= 0;
		PCWrite <= 0;
		PCWriteCond <= 0;
		MemRead <= 1;
		MemWrite <= 1;
		MemAddress <= 1;
		MemToReg <= 1;
		AluSrcA <= 0;
		AluSrcB <= 0;
		AluOP <= 0;
		ShiftOP <= 0;
		ShiftSourceN <= 0;
		ShiftSourceE <= 0;
		Partition <= 0;
		ByteControl <= 0;
		IntCause <= 0;
		CauseWrite <= 0;
		EPCWrite <= 0;
		SignO <= 0;
		RegDst <= 0;
		RegWrite <= 0;
		ReadRegister <= 0;
		WriteData <= 3;
		DivMul <= 0;
		EnableDivMul <= 0;

		state <= 40;
	end
	// 43: begin
	// 	AluSrcA <= 1;
	// 	AluSrcB <= 1;
	// 	AluOP <= 1;
	// 	PCWriteCond <= 1;
	// 	PCWrite <= 1;
	// end
	// 44: begin
	// 	AluSrcA <= 1; //////////////////////////////////////////////////////// VER!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	// 	AluSrcB <= 1;
	// 	AluOP <= 1;
	// 	PCWriteCond <= 1;
	// 	PCWrite <= 1;
	// end
	// 45: begin
	// 	AluSrcA <= 1;
	// 	AluSrcB <= 1;
	// 	AluOP <= 1;
	// 	PCWriteCond <= 1;
	// 	PCWrite <= 1;
	// end
	// 46: begin
	// 	AluSrcA <= 1;
	// 	AluSrcB <= 1;
	// 	AluOP <= 1;
	// 	PCWriteCond <= 1;
	// 	PCWrite <= 1;
	// end
	47: begin
		MuxPC <= 0;
		IorD <= 0;
		IRWrite <= 0;
		PCSource <= 0;
		PCWrite <= 0;
		PCWriteCond <= 0;
		MemRead <= 0;
		MemWrite <= 0;
		MemAddress <= 0;
		MemToReg <= 0;
		AluSrcA <= 1;
		AluSrcB <= 2;
		AluOP <= 1;
		ShiftOP <= 0;
		ShiftSourceN <= 0;
		ShiftSourceE <= 0;
		Partition <= 0;
		ByteControl <= 0;
		IntCause <= 0;
		CauseWrite <= 0;
		EPCWrite <= 0;
		SignO <= 0;
		RegDst <= 0;
		RegWrite <= 0;
		ReadRegister <= 0;
		WriteData <= 0;
		DivMul <= 0;
		EnableDivMul <= 0;

		//////////////////////////////////////////////////////////////// SignO <= 1; (o que eh)
	end
	48: begin
		MuxPC <= 0;
		IorD <= 0;
		IRWrite <= 0;
		PCSource <= 0;
		PCWrite <= 0;
		PCWriteCond <= 0;
		MemRead <= 0;
		MemWrite <= 0;
		MemAddress <= 0;
		MemToReg <= 0;
		AluSrcA <= 1;
		AluSrcB <= 2;
		AluOP <= 1;
		ShiftOP <= 0;
		ShiftSourceN <= 0;
		ShiftSourceE <= 0;
		Partition <= 0;
		ByteControl <= 0;
		IntCause <= 0;
		CauseWrite <= 0;
		EPCWrite <= 0;
		SignO <= 0;
		RegDst <= 0;
		RegWrite <= 0;
		ReadRegister <= 0;
		WriteData <= 0;
		DivMul <= 0;
		EnableDivMul <= 0;

		//////////////////////////////////////////////////////////////// SignO <= 0; (o que eh)
	end
	49: begin
		MuxPC <= 0;
		IorD <= 0;
		IRWrite <= 0;
		PCSource <= 0;
		PCWrite <= 0;
		PCWriteCond <= 0;
		MemRead <= 0;
		MemWrite <= 0;
		MemAddress <= 0;
		MemToReg <= 0;
		AluSrcA <= 0;
		AluSrcB <= 0;
		AluOP <= 0;
		ShiftOP <= 0;
		ShiftSourceN <= 0;
		ShiftSourceE <= 0;
		Partition <= 0;
		ByteControl <= 0;
		IntCause <= 0;
		CauseWrite <= 0;
		EPCWrite <= 0;
		SignO <= 0;
		RegDst <= 1;
		RegWrite <= 1;
		ReadRegister <= 0;
		WriteData <= 0;
		DivMul <= 0;
		EnableDivMul <= 0;
	end
	50: begin
		MuxPC <= 0;
		IorD <= 0;
		IRWrite <= 0;
		PCSource <= 0;
		PCWrite <= 0;
		PCWriteCond <= 0;
		MemRead <= 0;
		MemWrite <= 0;
		MemAddress <= 0;
		MemToReg <= 0;
		AluSrcA <= 0;
		AluSrcB <= 0;
		AluOP <= 0;
		ShiftOP <= 0;
		ShiftSourceN <= 0;
		ShiftSourceE <= 0;
		Partition <= 0;
		ByteControl <= 0;
		IntCause <= 0;
		CauseWrite <= 0;
		EPCWrite <= 0;
		SignO <= 0;
		RegDst <= 1;
		RegWrite <= 1;
		ReadRegister <= 0;
		WriteData <= 0;
		DivMul <= 0;
		EnableDivMul <= 0;
	end
	51: begin
		MuxPC <= 0;
		IorD <= 0;
		IRWrite <= 0;
		PCSource <= 2;
		PCWrite <= 1;
		PCWriteCond <= 0;
		MemRead <= 0;
		MemWrite <= 0;
		MemAddress <= 0;
		MemToReg <= 0;
		AluSrcA <= 0;
		AluSrcB <= 0;
		AluOP <= 0;
		ShiftOP <= 0;
		ShiftSourceN <= 0;
		ShiftSourceE <= 0;
		Partition <= 0;
		ByteControl <= 0;
		IntCause <= 0;
		CauseWrite <= 0;
		EPCWrite <= 0;
		SignO <= 0;
		RegDst <= 0;
		RegWrite <= 0;
		ReadRegister <= 0;
		WriteData <= 0;
		DivMul <= 0;
		EnableDivMul <= 0;
	end
	52: begin
		MuxPC <= 0;
		IorD <= 0;
		IRWrite <= 0;
		PCSource <= 0;
		PCWrite <= 0;
		PCWriteCond <= 0;
		MemRead <= 0;
		MemWrite <= 0;
		MemAddress <= 0;
		MemToReg <= 0;
		AluSrcA <= 0;
		AluSrcB <= 0;
		AluOP <= 0;
		ShiftOP <= 0;
		ShiftSourceN <= 0;
		ShiftSourceE <= 0;
		Partition <= 0;
		ByteControl <= 0; ///////////////////////////////////// BYTE CONTROL DA PROBLEMA!
		IntCause <= 0;
		CauseWrite <= 0;
		EPCWrite <= 0;
		SignO <= 0;
		RegDst <= 2;
		RegWrite <= 0;
		ReadRegister <= 0;
		WriteData <= 0;
		DivMul <= 0;
		EnableDivMul <= 0;

		state <= 53;
	end
	53: begin
		MuxPC <= 0;
		IorD <= 0;
		IRWrite <= 0;
		PCSource <= 2;
		PCWrite <= 1;
		PCWriteCond <= 0;
		MemRead <= 0;
		MemWrite <= 0;
		MemAddress <= 0;
		MemToReg <= 0;
		AluSrcA <= 0;
		AluSrcB <= 0;
		AluOP <= 0;
		ShiftOP <= 0;
		ShiftSourceN <= 0;
		ShiftSourceE <= 0;
		Partition <= 0;
		ByteControl <= 0;
		IntCause <= 0;
		CauseWrite <= 0;
		EPCWrite <= 0;
		SignO <= 0;
		RegDst <= 0;
		RegWrite <= 0;
		ReadRegister <= 0;
		WriteData <= 0;
		DivMul <= 0;
		EnableDivMul <= 0;
	end
	54: begin
		
	end
	endcase
end
endmodule




///////////////////////////////////////////////////////// TESTE DE CAIO AQUI
// module testUnidadeControle();


// reg a, b;
// parameter timeBase = 10;
// UnidadeControle uc(.a(a), .b(b))


// initial begin
// 	#(timeBase)
// 	a = 1
// 	b = 0
// 	#(timeBase)
// end

// endmodule






// if (opcode == 0) begin // r type functions
// 	if (funct == 8'h20) begin // add
// 		AluOP <= 1;
// 		AluSrcA <= 1;
// 		AluSrcB <= 0;
// 	end
// 	if (funct == 8'h24) begin // and
// 		AluOP <= 3;
// 		AluSrcA <= 1;
// 		AluSrcB <= 0;
// 	end
// 	if (funct == 8'h1a) begin // div
// 		DivMul <= 1;
// 		EnableDivMul <= 1;
// 	end
// 	if (funct == 8'h18) begin // mult
// 		DivMul <= 0;
// 		EnableDivMul <= 1;
// 	end
// 	if (funct == 8'h8) begin // jr
// 		AluOP <= 1;
// 		AluSrcA <= 0;
// 		AluSrcB <= 3;
// 		//MuxPC <= 3;  (MUX DO FINAL)
// 	end
// 	if (funct == 8'h10) begin // mfhi
// 		MemToReg <= 1;
// 		RegDst <= 3;
// 		RegWrite <= 1;
// 	end
// 	if (funct == 8'h12) begin // mflo
// 		MemToReg <= 2;
// 		RegDst <= 3;
// 		RegWrite <= 1;
// 	end
// 	if (funct == 8'h0) begin // sll
// 		ShiftSourceE <= 1;
// 		ShiftSourceN <= 1;
// 		ShiftOP <= 2;
// 	end
// 	if (funct == 8'h4) begin // sllv
// 		ShiftSourceE <= 0;
// 		ShiftSourceN <= 0;
// 		ShiftOP <= 2;
// 	end
// 	if (funct == 8'h2a) begin // slt
// 		ShiftSourceE <= 7;
// 		ShiftSourceN <= 1;
// 		ShiftOP <= 0;
// 	end
// 	if (funct == 8'h3) begin // sra
// 		ShiftSourceE <= 3;
// 		ShiftSourceN <= 1;
// 		ShiftOP <= 1;
// 	end
// 	if (funct == 8'h7) begin // srav
// 		ShiftSourceE <= 3;
// 		ShiftSourceN <= 0;
// 		ShiftOP <= 2;
// 	end
// 	if (funct == 8'h2) begin // srl
// 		ShiftSourceE <= 1;
// 		ShiftSourceN <= 1;
// 		ShiftOP <= 3;
// 	end
// 	if (funct == 8'h22) begin // sub
// 		AluOP <= 1;
// 		AluSrcA <= 1;
// 		AluSrcB <= 3;
// 	end
// 	if (funct == 8'hd) begin // break
// 		AluOP <= 1;
// 		AluSrcA <= 0;
// 		AluSrcB <= 1;
// 	end
// 	if (funct == 8'h13) begin // rte
// 		PCSource <= 3;
// 		PCWrite <= 1;
// 		//cnt <= 1;
// 		state <= 14;
// 	end
// 	if (funct == 8'h5) begin // push
// 		if (timer )
// 	end
// 	if (funct == 8'h6) begin // pop
		
// 	end
// end
// else if (opcode == 8'h2 || opcode == 8'h3)begin // j/jal
	
// end
// else begin // Formato I
// 	if (opcode == 8'h8) begin // addi
	
// 	end
// 	if (opcode == 8'h9) begin // addiu
	
// 	end
// 	if (opcode == 8'h4) begin // beq
	
// 	end
// 	if (opcode == 8'h5) begin // bne
	
// 	end
// 	if (opcode == 8'h6) begin // ble
	
// 	end
// 	if (opcode == 8'h7) begin // bgt
	
// 	end
// 	if (opcode == 8'h20) begin // lb
	
// 	end
// 	if (opcode == 8'h21) begin // lh
	
// 	end
// 	if (opcode == 8'hf) begin // lui
	
// 	end
// 	if (opcode == 8'h23) begin // lw
// 		MemRead <= 1;
// 		/// ct = 2;
// 		IorD <= 1;
// 		ByteControl <= 0;
// 	end
// 	if (opcode == 8'h28) begin // sb
	
// 	end
// 	if (opcode == 8'h29) begin // sh
	
// 	end
// 	if (opcode == 8'ha) begin // slti
	
// 	end
// 	if (opcode == 8'h2b) begin // sw
	
// 	end
// end