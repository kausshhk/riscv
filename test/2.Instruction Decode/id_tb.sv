module ID_tb_top;
logic [6:0] opcode, func7;
logic [2:0] func3;
logic [31:0] r1, r2;
logic [31:0] immediate;
logic RegWrite;
logic  [31:0] wb_data;
logic  [31:0] instruction;

ID_tb tb(.opcode(opcode), .func7(func7), .func3(func3), .r1(r1), .r2(r2), .immediate(immediate), .RegWrite(RegWrite), .wb_data(wb_data), .instruction(instruction));
ID dut(.opcode(opcode), .func7(func7), .func3(func3), .r1(r1), .r2(r2), .immediate(immediate), .RegWrite(RegWrite), .wb_data(wb_data), .instruction(instruction));

endmodule

program ID_tb (
    input logic [6:0] opcode, func7,
    input logic [2:0] func3,
    input logic [31:0] r1, r2,
    input logic [31:0] immediate,
    output logic RegWrite,
    output logic  [31:0] wb_data,
    output logic  [31:0] instruction
	);
    int good = 0, bad = 0;

    task display;
        $display("Instruction %h", instruction);
		$display("Opcode:- %0b", opcode);
		$display("Func7:- %0b", func7);
		$display("Func3:- %0b", func3);
		$display("r1, r2 :- %0b, %0b", r1, r2);
		$display("imm:- %0b", immediate);
    endtask
    
    initial begin
        //for(int i = 0; i < 10; i++) begin
		RegWrite = 1'b0;
		wb_data = 32'haaed1233;

		instruction = 32'h00c00533; // add x10 x0 x12
		#10;
		display;

		instruction = 32'h00c00513; // add x10 x0 12
		#10;
		display;

		instruction = 32'h000230b7; // lui x1, 0x23
		#10;
		display;
		
		instruction = 32'h0000a083; // lw x1, 0(x1)
		#10;
		display;

		instruction = 32'hff1ff06f; // j start
		#10;
		display;

		instruction = 32'hfe0006e3; // beq x0, x0, start
		#10;
		display;

		instruction = 32'h00032097; // auipc x1, 0x32
		#10;
		display;

		instruction = 32'h000080e7; // jalr x1
		#10;
		display;
        //end
        $display("Pass vs Fail :- %0d, %0d", good, bad); 
     end
endprogram
