vlib work
vlog src/utils/adder.sv 
vlog src/utils/rca.sv 
vlog test/utils/add_tb.sv 
vlog top.sv
vsim work.top
#add wave -r *
run -all