onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /wrapper_top/wrapper_if/clk
add wave -noupdate /wrapper_top/wrapper_if/MOSI
add wave -noupdate /wrapper_top/wrapper_if/MISO
add wave -noupdate /wrapper_top/wrapper_if/MISO_ref
add wave -noupdate /wrapper_top/wrapper_if/SS_n
add wave -noupdate /wrapper_top/wrapper_if/rst_n
add wave -noupdate /wrapper_top/slave_if/clk
add wave -noupdate /wrapper_top/DUT/RAM_instance/din
add wave -noupdate /wrapper_top/DUT/RAM_instance/clk
add wave -noupdate /wrapper_top/DUT/RAM_instance/rst_n
add wave -noupdate /wrapper_top/DUT/RAM_instance/rx_valid
add wave -noupdate /wrapper_top/DUT/RAM_instance/dout
add wave -noupdate /wrapper_top/DUT/RAM_instance/tx_valid
add wave -noupdate /wrapper_top/DUT/RAM_instance/MEM
add wave -noupdate /wrapper_top/DUT/RAM_instance/Rd_Addr
add wave -noupdate /wrapper_top/DUT/RAM_instance/Wr_Addr
add wave -noupdate /wrapper_top/DUT/SLAVE_instance/IDLE
add wave -noupdate /wrapper_top/DUT/SLAVE_instance/WRITE
add wave -noupdate /wrapper_top/DUT/SLAVE_instance/CHK_CMD
add wave -noupdate /wrapper_top/DUT/SLAVE_instance/READ_ADD
add wave -noupdate /wrapper_top/DUT/SLAVE_instance/READ_DATA
add wave -noupdate /wrapper_top/DUT/SLAVE_instance/MOSI
add wave -noupdate /wrapper_top/DUT/SLAVE_instance/clk
add wave -noupdate /wrapper_top/DUT/SLAVE_instance/rst_n
add wave -noupdate /wrapper_top/DUT/SLAVE_instance/SS_n
add wave -noupdate /wrapper_top/DUT/SLAVE_instance/tx_valid
add wave -noupdate /wrapper_top/DUT/SLAVE_instance/tx_data
add wave -noupdate /wrapper_top/DUT/SLAVE_instance/rx_data
add wave -noupdate /wrapper_top/DUT/SLAVE_instance/rx_valid
add wave -noupdate /wrapper_top/DUT/SLAVE_instance/MISO
add wave -noupdate /wrapper_top/DUT/SLAVE_instance/counter
add wave -noupdate /wrapper_top/DUT/SLAVE_instance/received_address
add wave -noupdate /wrapper_top/DUT/SLAVE_instance/cs
add wave -noupdate /wrapper_top/DUT/SLAVE_instance/ns
add wave -noupdate /shared_pkg::counter
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
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
WaveRestoreZoom {0 ns} {52 ns}
