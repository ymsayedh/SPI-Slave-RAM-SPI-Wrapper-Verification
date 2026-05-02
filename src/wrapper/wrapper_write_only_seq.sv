package wrapper_write_only_seq_pkg;
    import uvm_pkg::*;
    `include "uvm_macros.svh"
    import wrapper_seq_item_pkg::*;
    import shared_pkg::*;

    class wrapper_write_only_seq extends uvm_sequence #(wrapper_seq_item);

        `uvm_object_utils(wrapper_write_only_seq)
        wrapper_seq_item seq_item;
        
        function new(input string name = "wrapper_write_only_seq");
            super.new(name);
        endfunction
        
        task body();
            seq_item = wrapper_seq_item::type_id::create("seq_item");
            
            repeat(300) begin
                start_item(seq_item);
                seq_item.readonly_c.constraint_mode(0);
                seq_item.ss_n_readdata_c.constraint_mode(0);
                seq_item.writenread_c.constraint_mode(0);
                if(counter % 13) begin
                    seq_item.MOSI_arr.rand_mode(0);
                    seq_item.state_ref.rand_mode(0);
                end
                else begin
                    seq_item.MOSI_arr.rand_mode(1);
                    seq_item.state_ref.rand_mode(1);
                end
                assert(seq_item.randomize with {seq_item.state_ref inside {WR_ADD
                    ,WR_DATA};});
                seq_item.update_counter_allcases;
                finish_item(seq_item);
            end
        endtask
        

    endclass
    

endpackage
