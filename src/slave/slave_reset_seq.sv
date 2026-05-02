package slave_reset_seq_pkg;
    import uvm_pkg::*;
    `include "uvm_macros.svh"
    import slave_seq_item_pkg::*;
    import shared_pkg::*;

    class slave_reset_seq extends uvm_sequence #(slave_seq_item);

        `uvm_object_utils(slave_reset_seq)
        slave_seq_item seq_item;
        
        function new(input string name = "slave_main_seq");
            super.new(name);
        endfunction
        
        task body();
            seq_item = slave_seq_item::type_id::create("seq_item");
            start_item(seq_item);
            seq_item.rst_n = 0;
            seq_item.MOSI = 0;
            seq_item.state_ref = state_e'(0);
            seq_item.MOSI_arr = 0;
            seq_item.SS_n = 1;
            finish_item(seq_item);
        endtask
        

    endclass
    

endpackage
