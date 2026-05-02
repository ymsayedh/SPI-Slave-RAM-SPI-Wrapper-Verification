module slave_sva(
    slave_if.MON slave_iff
);

sequence write_data_seq;
    !slave_iff.MOSI[*3] ##10 slave_iff.rx_valid;
endsequence : write_data_seq

sequence write_add_seq;
    !slave_iff.MOSI[*2] ##1 slave_iff.MOSI ##10 slave_iff.rx_valid;
endsequence : write_add_seq

sequence read_add_seq;
    slave_iff.MOSI[*2] ##1 !slave_iff.MOSI ##10 slave_iff.rx_valid;
endsequence : read_add_seq

sequence read_data_seq;
    slave_iff.MOSI[*3] ##10 slave_iff.rx_valid;
endsequence : read_data_seq

sequence rx_valid_sec;
    ##9 slave_iff.rx_valid;
endsequence : rx_valid_sec


property rst_p;
    @(posedge slave_iff.clk) !slave_iff.rst_n |=> !slave_iff.MISO & !slave_iff.rx_valid & 
                            !slave_iff.rx_data; 
endproperty : rst_p

property write_data_p;
    @(posedge slave_iff.clk) disable iff(!slave_iff.rst_n || slave_iff.tx_valid) 
    $fell(slave_iff.SS_n) |=> !slave_iff.MOSI |=> !slave_iff.MOSI |=> slave_iff.MOSI |=> rx_valid_sec;
endproperty : write_data_p
    
property write_add_p;
    @(negedge slave_iff.clk) disable iff(!slave_iff.rst_n || slave_iff.tx_valid) 
    $fell(slave_iff.SS_n) |=> !slave_iff.MOSI |=> !slave_iff.MOSI |=> !slave_iff.MOSI |=> rx_valid_sec;
endproperty : write_add_p

property read_add_p;
    @(posedge slave_iff.clk) disable iff(!slave_iff.rst_n || slave_iff.tx_valid) 
    $fell(slave_iff.SS_n) |=> slave_iff.MOSI |=> slave_iff.MOSI |=> !slave_iff.MOSI |=> rx_valid_sec;
endproperty : read_add_p

property read_data_p;
    @(posedge slave_iff.clk) disable iff(!slave_iff.rst_n) 
    $fell(slave_iff.SS_n) |=> slave_iff.MOSI |=> slave_iff.MOSI |=> slave_iff.MOSI |=> rx_valid_sec;
endproperty : read_data_p

rst_as : assert property ( rst_p );
rst_cov : cover property ( rst_p );

write_data_as : assert property ( write_data_p );
write_data_cov : cover property ( write_data_p );

write_add_as : assert property ( write_add_p );
write_add_cov : cover property ( write_add_p );

read_add_as : assert property ( read_add_p );
read_add_cov : cover property ( read_add_p );

read_data_as : assert property ( read_data_p );
read_data_cov : cover property ( read_data_p );

endmodule
