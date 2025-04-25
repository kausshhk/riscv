module RV(
    output logic [31:0] out,
    output bit exit, OutType,
    input bit clk
);
  (* dont_touch = "yes" *) logic [6:0] opcode, func7;
  (* dont_touch = "yes" *) logic [31:0] instruction, rs1, rs2, immediate, pc, AluOut, wb_data, MemData, PcOut;
  (* dont_touch = "yes" *) logic RegWrite, MemRead, MemWrite, branch, AluSrc, MemToReg, PcRelative, PcBranch, zero;
  (* dont_touch = "yes" *) logic [3:0] AluOp;
  (* dont_touch = "yes" *) logic [2:0] func3;
  (* dont_touch = "yes" *) logic [4:0] rd;
  (* dont_touch = "yes" *) IF u_if (instruction, pc,
    PcBranch, PcOut, clk);
  (* dont_touch = "yes" *) ID u_id (opcode, func7, func3, rs1, rs2, immediate,
    RegWrite, clk, wb_data, instruction);
  (* dont_touch = "yes" *) CU u_cu (RegWrite, MemRead, MemWrite,  branch, AluSrc, MemToReg, PcRelative, OutType, AluOp,
    func7, func3, opcode);
  (* dont_touch = "yes" *) EX u_ex (AluOut, zero,
    pc, rs1, rs2, immediate, AluOp, AluSrc, PcRelative);
  (* dont_touch = "yes" *) MA u_ma(MemData,
    rs2, AluOut, func3, MemRead, MemWrite);
  (* dont_touch = "yes" *) WB u_wb(wb_data,
    AluOut, MemData, MemToReg);
  (* dont_touch = "yes" *) Branch u_br(confirm, PcOut,
    func3, opcode, AluOut, pc, immediate, zero);

  assign PcBranch = branch & confirm;

  (* dont_touch = "yes" *) always_comb begin : OutMux
    if (OutType == 0) // Data Output
      out = wb_data;
    else if (OutType == 1) begin // Pc Output
      out = pc;
    end
  end

  (* dont_touch = "yes" *) assign exit = (instruction == 32'h00000000)? 1'b1 : 1'b0;

endmodule
