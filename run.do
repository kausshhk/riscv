vlib work
vlog src/utils/adder.sv 
vlog src/utils/rca.sv 
vlog test/utils/add_tb.sv 
vlog rv_top.sv
vsim work.rv_top
#add wave -r *
run -all