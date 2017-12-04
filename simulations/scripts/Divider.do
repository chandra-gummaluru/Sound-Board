vlib work
vlog Divider.v
vsim -L altera_mf_ver Divider
log -r {/*}
add wave {/*}

force {numer} 24'd2293725
force {denom} 6'd35

run 10ns
run 10ns
run 10ns
run 10ns