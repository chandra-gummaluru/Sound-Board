vlib work
vlog WaveMaker.v
vsim WaveMaker
log -r {/*}
add wave {/*}

force {clock} 0
force {reset} 0
force {depth} 2'd5
force {enable} 0

run 10ns

force {enable} 1

force {clock} 0
run 10ns
force {clock} 1
run 10ns

force {enable} 0

force {clock} 0
run 10ns
force {clock} 1
run 10ns


force {clock} 0
run 10ns
force {clock} 1
run 10ns

force {clock} 0
run 10ns
force {clock} 1
run 10ns


force {clock} 0
run 10ns
force {clock} 1
run 10ns


force {clock} 0
run 10ns
force {clock} 1
run 10ns


force {clock} 0
run 10ns
force {clock} 1
run 10ns

force {clock} 0
run 10ns
force {clock} 1
run 10ns


force {clock} 0
run 10ns
force {clock} 1
run 10ns

force {enable} 1

force {clock} 0
run 10ns
force {clock} 1
run 10ns

force {clock} 0
run 10ns
force {clock} 1
run 10ns