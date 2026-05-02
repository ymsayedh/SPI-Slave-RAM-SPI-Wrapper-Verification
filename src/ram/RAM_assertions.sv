module RAM_sva(RAM_if.SVA ram_interface);

    // 1) When reset is active (rst_n = 0), outputs must be low
    property p_reset;
        @(posedge ram_interface.clk)
            (!ram_interface.rst_n) |=> (ram_interface.dout == 0 && ram_interface.tx_valid == 0);
    endproperty
    a_reset: assert property (p_reset)
        else $error("Assertion 1 failed");
    c_reset: cover property (p_reset);

    // 2) During address/data input phases, tx_valid must remain low
    property p_tx_low;
        @(posedge ram_interface.clk) disable iff (!ram_interface.rst_n || !ram_interface.rx_valid)
            (ram_interface.din[9:8] inside {2'b00, 2'b01, 2'b10}) |=> (ram_interface.tx_valid == 0);
    endproperty
    a_tx_low: assert property (p_tx_low)
        else $error("Assertion 2 failed");
    c_tx_low: cover property (p_tx_low);

    // After a read_data_seq, tx_valid must rise for one cycle then fall the next cycle
    property p_tx_high;
        @(posedge ram_interface.clk) disable iff (!ram_interface.rst_n)
            (ram_interface.rx_valid && ram_interface.din[9:8] == 2'b11) |=> ((ram_interface.tx_valid));
    endproperty
    a_tx_high: assert property (p_tx_high)
        else $error("Assertion 3 failed");
    c_tx_high: cover property (p_tx_high);
    
    // 4) Every Write Address must be followed by a Write Data operation
    property p_write;
        @(posedge ram_interface.clk) disable iff (!ram_interface.rst_n)
            (ram_interface.rx_valid && ram_interface.din[9:8] == 2'b00)|=> ##[1:$] (ram_interface.din[9:8] == 2'b01);
endproperty
    a_write: assert property (p_write)
        else $error("Write address not followed by write data");
    c_write: cover property (p_write);


    // 5)  Every Read Address must be followed by a Read Data operation
    property p_read;
        @(posedge ram_interface.clk) disable iff (!ram_interface.rst_n)
            (ram_interface.rx_valid && ram_interface.din[9:8] == 2'b10)|=> ##[1:$] (ram_interface.din[9:8] == 2'b11);
    endproperty
    a_read: assert property (p_read)
        else $error("Read address not followed by read data");
    c_read: cover property (p_read);


endmodule