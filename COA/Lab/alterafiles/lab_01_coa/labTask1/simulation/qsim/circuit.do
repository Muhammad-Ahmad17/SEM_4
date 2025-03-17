onerror {exit -code 1}
vlib work
vlog -work work circuit.vo
vlog -work work Waveform.vwf.vt
vsim -novopt -c -t 1ps -L cycloneive_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.circuit_vlg_vec_tst -voptargs="+acc"
vcd file -direction circuit.msim.vcd
vcd add -internal circuit_vlg_vec_tst/*
vcd add -internal circuit_vlg_vec_tst/i1/*
run -all
quit -f
