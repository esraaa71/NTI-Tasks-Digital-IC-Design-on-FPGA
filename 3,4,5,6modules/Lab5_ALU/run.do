if {[file exists work]} {vdel -lib work -all}
vlib work
vlog alu.v alu_test.v
vsim work.alu_test
add wave -r /*
radix binary
run -all
wave zoom full
