vcom file.vhd
vsim work.eToplama

add wave -logic A
add wave *

force A 1111 0 -- 1111 = 16#F

force reset 1 0
run 100
force reset 0 0
run 300

force reset 1 0, 0 100
run 400

force -freeze clk 0 0, 1 {50 ns} -r 100 ns

--do example.tcl