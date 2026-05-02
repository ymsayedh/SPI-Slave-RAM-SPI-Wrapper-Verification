vlib work
vlog -f src_files.list +cover -covercells
vsim -voptargs=+acc work.RAM_top -classdebug -uvmcontrol=all -cover
# Add all interface signals
add wave -r sim:/RAM_top/ram_interface/*
run -all