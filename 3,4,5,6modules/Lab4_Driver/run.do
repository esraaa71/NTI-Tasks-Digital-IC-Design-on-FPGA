if {[file exists work]} {vdel -lib work -all}
vlib work
vlog driver.v driver_test.v
vsim work.driver_test
add wave -r /*
radix binary
run -all
wave zoom full
