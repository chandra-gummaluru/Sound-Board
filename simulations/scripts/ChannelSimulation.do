vlib work
vlog WaveMaker.v
vlog Channel.v
vlog ChannelSimulation.v

vsim ChannelSim
log -r {/*}
add wave {/*}


force {mode} 0 
force {playEn} 1
force {reset} 0
force {data} 2'b0

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