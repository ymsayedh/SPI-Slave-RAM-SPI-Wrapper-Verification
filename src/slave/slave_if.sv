interface slave_if(clk);
    input clk;
    bit MOSI, MISO_ref, MISO, rst_n, SS_n, tx_valid, rx_valid, rx_valid_ref;
    logic [9 : 0] rx_data, rx_data_ref;
    logic [7 : 0] tx_data;

    modport MON (input clk, MOSI, MISO, rst_n, tx_valid, tx_data, rx_data, rx_valid, SS_n);
    

endinterface : slave_if
