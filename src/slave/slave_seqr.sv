package slave_seqr_pkg;
    import uvm_pkg::*;
    `include "uvm_macros.svh"
    import slave_seq_item_pkg::*;
    
    class slave_seqr extends uvm_sequencer #(slave_seq_item);
        
        `uvm_component_utils(slave_seqr)

        function new(input string name = "slave_sequencer", uvm_component parent = null);
            super.new(name, parent);
        endfunction
        

    endclass
    

endpackage
