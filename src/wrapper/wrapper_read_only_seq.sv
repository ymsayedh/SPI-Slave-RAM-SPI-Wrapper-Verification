package wrapper_read_only_seq_pkg;
    import uvm_pkg::*;
    `include "uvm_macros.svh"
    import wrapper_seq_item_pkg::*;
    import shared_pkg::*;

    class wrapper_read_only_seq extends uvm_sequence #(wrapper_seq_item);

        `uvm_object_utils(wrapper_read_only_seq)
        wrapper_seq_item seq_item;
        state_e prev_state;
        
        function new(input string name = "wrapper_read_only_seq");
            super.new(name);
        endfunction
        
        task body();
            seq_item = wrapper_seq_item::type_id::create("seq_item");
            seq_item.state_ref = RD_DATA;
            repeat(300) begin
                start_item(seq_item);
                seq_item.writeonly_c.constraint_mode(0);
                seq_item.writenread_c.constraint_mode(0);
                if(seq_item.state_ref == RD_ADD) begin
                    seq_item.ss_n_readdata_c.constraint_mode(0);
                    seq_item.ss_n_allcases_c.constraint_mode(1);
                    if(counter % 13) begin
                        seq_item.MOSI_arr.rand_mode(0);
                        seq_item.state_ref.rand_mode(0);
                        seq_item.readonly_c.constraint_mode(0);
                    end
                    else if(counter == 0) begin
                        seq_item.MOSI_arr.rand_mode(1);
                        seq_item.state_ref.rand_mode(1);
                        seq_item.readonly_c.constraint_mode(1);
                        prev_state = seq_item.state_ref;
                    end
                    assert(seq_item.randomize with {state_ref inside {RD_DATA
                    , RD_ADD};});
                    seq_item.update_counter_allcases;
                    end
                else begin
                    seq_item.ss_n_readdata_c.constraint_mode(1);
                    seq_item.ss_n_allcases_c.constraint_mode(0);
                    if(counter % 23) begin
                        seq_item.MOSI_arr.rand_mode(0);
                        seq_item.state_ref.rand_mode(0);
                        seq_item.readonly_c.constraint_mode(0);
                    end
                    else if(counter == 0) begin
                        seq_item.MOSI_arr.rand_mode(1);
                        seq_item.state_ref.rand_mode(1);
                        seq_item.readonly_c.constraint_mode(1);
                        prev_state = seq_item.state_ref;
                    end
                    assert(seq_item.randomize with {state_ref inside {RD_ADD, 
                    RD_DATA};});
                    seq_item.update_counter_readdatacase;
                end
                finish_item(seq_item);
            end
        endtask
        

    endclass
    

endpackage
