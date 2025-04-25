module EX_tb_top;

logic [31:0] AluOut;
bit zero;
logic [31:0] pc, rs1, rs2, imm;
logic [3:0] AluOp;
bit AluSrc, pc_relative;

EX_tb tb(AluOut, zero, pc, rs1, rs2, imm, AluOp, AluSrc, pc_relative);
EX dut(AluOut, zero, pc, rs1, rs2, imm, AluOp, AluSrc, pc_relative);
    

endmodule

program EX_tb (
    input logic [31:0] AluOut,
    input bit zero,
    output logic [31:0] pc, rs1, rs2, imm,
    output logic [3:0] AluOp,
    output bit AluSrc, pc_relative
	);
    int good = 0, bad = 0;

    task display;
        $display("AluOut:- %h", AluOut);
	$display("zero:- %0b", zero);
	$display("pc, imm :- %0b, %0b", pc, imm);
	$display("r1, r2 :- %0b, %0b", rs1, rs2);
	$display("AluSrc, PcRelative :- %0b, %0b", AluSrc, pc_relative);
	$display("AluOp:- %0b", AluOp);
    endtask
    
    initial begin
        //for(int i = 0; i < 10; i++) begin
		pc = 32'd8;
	       	rs1 = 32'd1; 
		rs2 = 32'd10; 
		imm = 32'd20;

		AluOp = 4'b0000;
		AluSrc = 1;
	       	pc_relative = 0;
		#10;
		display;
		AluOp = 4'b0000;
		AluSrc = 0;
	       	pc_relative = 1;
		#10;
		display;
		AluOp = 4'b0000;
		AluSrc = 1;
	       	pc_relative = 1;
		#10;
		display;
		
        //end
        $display("Pass vs Fail :- %0d, %0d", good, bad); 
     end
endprogram
