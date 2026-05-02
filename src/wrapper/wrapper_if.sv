interface wrapper_if(input bit clk);
    bit MOSI, MISO, MISO_ref, SS_n, rst_n;

    modport SVA (input clk, MOSI, MISO, SS_n, rst_n);
    

endinterface : wrapper_if
