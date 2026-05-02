onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider Ref
add wave -noupdate /slave_top/DUT_ref/IDLE
add wave -noupdate /slave_top/DUT_ref/WRITE
add wave -noupdate /slave_top/DUT_ref/CHK_CMD
add wave -noupdate /slave_top/DUT_ref/READ_ADD
add wave -noupdate /slave_top/DUT_ref/READ_DATA
add wave -noupdate /slave_top/DUT_ref/clk
add wave -noupdate /slave_top/DUT_ref/rst_n
add wave -noupdate /slave_top/DUT_ref/MOSI
add wave -noupdate /slave_top/DUT_ref/tx_valid
add wave -noupdate /slave_top/DUT_ref/SS_n
add wave -noupdate /slave_top/DUT_ref/tx_data
add wave -noupdate /slave_top/DUT_ref/rx_valid
add wave -noupdate /slave_top/DUT_ref/rx_valid_reg
add wave -noupdate /slave_top/DUT_ref/MISO
add wave -noupdate /slave_top/DUT_ref/rx_data
add wave -noupdate /slave_top/DUT_ref/counter
add wave -noupdate /slave_top/DUT_ref/counter_reg
add wave -noupdate /slave_top/DUT_ref/received_address
add wave -noupdate /slave_top/DUT_ref/cs
add wave -noupdate /slave_top/DUT_ref/ns
add wave -noupdate -divider dut
add wave -noupdate /slave_top/DUT/IDLE
add wave -noupdate /slave_top/DUT/WRITE
add wave -noupdate /slave_top/DUT/CHK_CMD
add wave -noupdate /slave_top/DUT/READ_ADD
add wave -noupdate /slave_top/DUT/READ_DATA
add wave -noupdate /slave_top/DUT/MOSI
add wave -noupdate /slave_top/DUT/clk
add wave -noupdate /slave_top/DUT/rst_n
add wave -noupdate /slave_top/DUT/SS_n
add wave -noupdate /slave_top/DUT/tx_valid
add wave -noupdate /slave_top/DUT/tx_data
add wave -noupdate /slave_top/DUT/rx_data
add wave -noupdate /slave_top/DUT/rx_valid
add wave -noupdate /slave_top/DUT/MISO
add wave -noupdate /slave_top/DUT/counter
add wave -noupdate /slave_top/DUT/received_address
add wave -noupdate /slave_top/DUT/cs
add wave -noupdate /slave_top/DUT/ns
add wave -noupdate -radix decimal /shared_pkg::counter
add wave -noupdate /slave_top/DUT/sva/write_data_as
add wave -noupdate /slave_top/DUT/sva/write_add_as
add wave -noupdate /slave_top/DUT/sva/read_add_as
add wave -noupdate /slave_top/DUT/sva/read_data_as
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 149
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {30 ns}
