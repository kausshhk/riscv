module cache #(
    parameter int b_offset = 2,
    int l_offset = 20,
    int t_offset = 10
) (
    output logic [31:0] data,
    input  logic [31:0] address
);
  logic [2 ** b_offset - 1:0] cache_file[2 ** l_offset];
  logic [t_offset - 1:0] tag[2 ** l_offset];
  for (i = 0; i < t_offset; i++) begin
    mux tag_comp_u ();
  end
  // TODO:
  // 1 x n b comparator
  // no.tag bits x no.linesx1 mux
endmodule
