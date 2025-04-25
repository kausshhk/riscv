module RV_tb_top;
logic [31:0] out;
bit clk, exit, outType;
int count;

always #5 clk = ~clk;
initial clk = 0;

RV dut(out, exit, outType, clk);
RV_tb tb(count, out, exit, clk);

endmodule

program RV_tb(
    output int clk_count,
	  input logic [31:0] out,
	  input bit exit,
	  input logic clk
	);

	int good = 0, bad = 0;
	assign clk_count = 0;
	logic [31:0] ins_mem_file [0:65];

	initial begin
		//for(int i = 0; i < 20; i++) begin
		while (!exit) begin
		    @(posedge clk);
			$display("Output: %0d at %0d", out, $time); 
			clk_count = clk_count + 1;
		end
		$display("Pass vs Fail :- %0d, %0d", good, bad); 
	end
endprogram
