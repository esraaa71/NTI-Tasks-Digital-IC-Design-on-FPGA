if {[file exists work]} {vdel -lib work -all}
vlib work
vlog multiplexor.v multiplexor_test.v
vsim work.multiplexor_test
add wave -r /*
radix binary
run -all
wave zoom full
