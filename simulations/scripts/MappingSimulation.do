vlib work
vlog WaveMaker.v
vlog WaveAdder.v
vlog Enabler.v
vlog Channel.v
vlog RAM0.v
vlog RAM1.v
vlog MappingSimulation.v

vsim -L altera_mf_ver Simulation
log -r {/*}
add wave {/*}

# KEY[3:0], SW[9:0], CLOCK_50


#initialize
force {KEY0} 1
force {KEY1} 1
force {KEY2} 1
force {KEY3} 1
force {SW} 0

force {CLOCK_50} 0
run 10ns
force {CLOCK_50} 1
run 10ns


#set playEn to 1, nothing should be outputting

force {SW} 1

force {CLOCK_50} 0
run 10ns
force {CLOCK_50} 1
run 10ns

force {CLOCK_50} 0
run 10ns
force {CLOCK_50} 1
run 10ns

force {CLOCK_50} 0
run 10ns
force {CLOCK_50} 1
run 10ns

force {CLOCK_50} 0
run 10ns
force {CLOCK_50} 1
run 10ns

force {CLOCK_50} 0
run 10ns
force {CLOCK_50} 1
run 10ns

force {CLOCK_50} 0
run 10ns
force {CLOCK_50} 1
run 10ns

force {CLOCK_50} 0
run 10ns
force {CLOCK_50} 1
run 10ns

force {CLOCK_50} 0
run 10ns
force {CLOCK_50} 1
run 10ns

force {CLOCK_50} 0
run 10ns
force {CLOCK_50} 1
run 10ns

force {CLOCK_50} 0
run 10ns
force {CLOCK_50} 1
run 10ns

force {CLOCK_50} 0
run 10ns
force {CLOCK_50} 1
run 10ns

force {CLOCK_50} 0
run 10ns
force {CLOCK_50} 1
run 10ns

force {CLOCK_50} 0
run 10ns
force {CLOCK_50} 1
run 10ns

force {CLOCK_50} 0
run 10ns
force {CLOCK_50} 1
run 10ns

force {CLOCK_50} 0
run 10ns
force {CLOCK_50} 1
run 10ns

force {CLOCK_50} 0
run 10ns
force {CLOCK_50} 1
run 10ns

force {CLOCK_50} 0
run 10ns
force {CLOCK_50} 1
run 10ns

force {CLOCK_50} 0
run 10ns
force {CLOCK_50} 1
run 10ns

force {CLOCK_50} 0
run 10ns
force {CLOCK_50} 1
run 10ns

force {CLOCK_50} 0
run 10ns
force {CLOCK_50} 1
run 10ns

force {CLOCK_50} 0
run 10ns
force {CLOCK_50} 1
run 10ns

force {CLOCK_50} 0
run 10ns
force {CLOCK_50} 1
run 10ns

force {CLOCK_50} 0
run 10ns
force {CLOCK_50} 1
run 10ns

force {CLOCK_50} 0
run 10ns
force {CLOCK_50} 1
run 10ns
