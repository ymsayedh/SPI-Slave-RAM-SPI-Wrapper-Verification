package wrapper_seqr_pkg;
    import uvm_pkg::*;
    `include "uvm_macros.svh"
    import wrapper_seq_item_pkg::*;
    
    class wrapper_seqr extends uvm_sequencer #(wrapper_seq_item);
        
        `uvm_component_utils(wrapper_seqr)

        function new(input string name = "wrapper_sequencer", uvm_component parent = null);
            super.new(name, parent);
        endfunction
        

    endclass
    

endpackage
