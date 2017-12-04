vlog RateDivider.v
vsim -L altera_mf_ver RateDivider
log -r {/*}
add wave {/*}



force {reset} 0
force {rate} 28'b0000000000000000000000000010

force {clk} 0
run 1ns
force {clk} 1
run 1ns

force {clk} 0
run 1ns
force {clk} 1
run 1ns

force {clk} 0
run 1ns
force {clk} 1
run 1ns

force {clk} 0
run 1ns
force {clk} 1
run 1ns

force {clk} 0
run 1ns
force {clk} 1
run 1ns

force {clk} 0
run 1ns
force {clk} 1
run 1ns

