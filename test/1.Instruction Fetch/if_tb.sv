/*
* class testing;
static logic [39:0][7:0] instruction = {
		8'h12, 8'h34, 8'h56, 8'h78,
		8'h9a, 8'hbc, 8'hde, 8'hf0,
		8'h12, 8'h34, 8'h56, 8'h78,
		8'h9a, 8'hbc, 8'hde, 8'hf0,
		8'h12, 8'h34, 8'h56, 8'h78,
		8'h9a, 8'hbc, 8'hde, 8'hf0,
		8'h12, 8'h34, 8'h56, 8'h78,
		8'h9a, 8'hbc, 8'hde, 8'hf0,
		8'h12, 8'h34, 8'h56, 8'h78,
		8'h9a, 8'hbc, 8'hde, 8'hf0
	};
	
endclass
*/
class testing_1;
static logic [31:0] instruction [$]= {
		32'h00002683,
		32'h00c02023,
		32'h00b50633,
		32'h00d00593,
		32'h00c00513,
		32'h00000000
	};

endclass

module IF_tb_top;
logic [31:0] instruction;
bit PCsrc;
logic [31:0] curr_addr, branch_addr;
bit clk;

always #5 clk = ~clk;

IF dut(instruction, curr_addr, PCsrc, branch_addr, clk);
IF_tb tb(instruction, PCsrc, branch_addr, curr_addr, clk);

endmodule

program IF_tb (
	input logic [31:0] instruction,
	output bit PCsrc,
	output logic [31:0] branch_addr,
	input logic [31:0] curr_addr,
	input logic clk
	);
    int good = 0, bad = 0;
    logic [31:0] prev_addr;

    assign PCsrc = 0;
    logic [31:0] tb_inst;

    testing_1 tb;
	initial begin
		tb = new;
		for(int i = 0; i < 10; i++) begin
			branch_addr = i*4;
			prev_addr = branch_addr;
			@(posedge clk);
				tb_inst = {tb.instruction[prev_addr+3],tb.instruction[prev_addr+2],tb.instruction[prev_addr+1],tb.instruction[prev_addr]};
				if(instruction == tb_inst) begin
					good++;
					$display("okay :- %0d. for PCsrc = %0b, at address(%0h) instruction != (%0h) vs %0h", i, PCsrc, curr_addr, instruction, tb_inst);
				end else begin
					bad++;
					$display("Error :- %0d. for PCsrc = %0b, at address(%0h) instruction != (%0h) vs %0h", i, PCsrc, curr_addr, instruction, tb_inst);
				end							
		 end
		 $display("Pass vs Fail :- %0d, %0d", good, bad); 
	 end
endprogram

module ins_mem_test_if ( // instruction memory
	output logic [31:0] instruction,
	input logic [31:0] address
);
	logic [31:0] instruction_tb [5:0]= {
		32'h00002683,
		32'h00c02023,
		32'h00b50633,
		32'h00d00593,
		32'h00c00513,
		32'h00000000
	};

	always_comb begin
		instruction = instruction_tb[address];
		//instruction = {instruction_tb[address+3],instruction_tb[address+2],instruction_tb[address+1],instruction_tb[address]};
	end
endmodule
/*
module ins_mem_test ( // instruction memory
	output logic [31:0] instruction,
	input logic [31:0] address
);
	logic [7:0] instruction_tb [39:0]= {
		8'h12, 8'h34, 8'h56, 8'h78,
		8'h9a, 8'hbc, 8'hde, 8'hf0,
		8'h12, 8'h34, 8'h56, 8'h78,
		8'h9a, 8'hbc, 8'hde, 8'hf0,
		8'h12, 8'h34, 8'h56, 8'h78,
		8'h9a, 8'hbc, 8'hde, 8'hf0,
		8'h12, 8'h34, 8'h56, 8'h78,
		8'h9a, 8'hbc, 8'hde, 8'hf0,
		8'h12, 8'h34, 8'h56, 8'h78,
		8'h9a, 8'hbc, 8'hde, 8'hf0
	};
	
	always_comb begin
        instruction = {instruction_tb[address+3],instruction_tb[address+2],instruction_tb[address+1],instruction_tb[address]};
	end
endmodule
*/
