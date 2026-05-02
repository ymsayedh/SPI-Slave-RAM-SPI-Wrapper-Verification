package shared_pkg;
    typedef enum bit [2 : 0] {WR_DATA = 3'b001, WR_ADD = 3'b000, RD_ADD = 3'b110, 
    RD_DATA = 3'b111} state_e;
    int counter = 0;
    bit SS_n_prev;
endpackage
