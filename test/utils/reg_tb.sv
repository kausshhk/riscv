module reg_top;
logic [31:0] wdata;
logic [31:0] rdata;
bit clk;
logic [4:0] regno;
bit rw;

always #1 clk = !clk;

  reg_tb tb(rdata, wdata, clk, regno, rw);
  register dut(rdata, wdata, clk, regno, rw);

endmodule


program reg_tb(
  input logic [31:0] rdata,
  output logic [31:0] tb_data,
  input bit clk,
  output logic [4:0] tb_regno,
  output bit tb_rw
);
  
int good, bad;
logic [31:0] data [31:0];

initial begin 
    tb_rw = 1;
    for (int a = 0; a < 32; a++) begin
        // Writing memory
        tb_data = $urandom;
        tb_regno = a;
        @(posedge clk);
        data[tb_regno] = tb_data;
    end

    tb_rw = 0;
    for (int a = 0; a < 32; a++) begin
        // Read Mode
        tb_regno = a;
      
        // testing memory
        @(posedge clk);
        if(data[tb_regno] == rdata) begin
            good++;
        end
        else begin
            bad++;
          $display("Test failed : %0d != %0d",data[tb_regno], rdata);
        end
    end
  $display("Passed vs Failed :- %0d / %0d", good, bad);
end
endprogram
