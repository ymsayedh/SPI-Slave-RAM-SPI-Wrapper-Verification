package wrapper_fixed_seq_pkg;
    import uvm_pkg::*;
    `include "uvm_macros.svh"
    import wrapper_seq_item_pkg::*;
    import shared_pkg::*;

    // FAILED ATEMPT, DO NOT USE

    class wrapper_fixed_seq extends uvm_sequence #(wrapper_seq_item);

        `uvm_object_utils(wrapper_fixed_seq)
        wrapper_seq_item seq_item;
        state_e prev_state;
        bit [1:0] state_count = 0;
        
        function new(input string name = "wrapper_fixed_seq");
            super.new(name);
        endfunction
        
        task body();
            seq_item = wrapper_seq_item::type_id::create("seq_item");
            repeat(300) begin
                start_item(seq_item);
                seq_item.writeonly_c.constraint_mode(0);
                seq_item.readonly_c.constraint_mode(0);
                seq_item.writenread_c.constraint_mode(0);
                seq_item.mosi_arr_c.constraint_mode(0);
                seq_item.state_ref.rand_mode(0);
                seq_item.data.rand_mode(0);
                seq_item.MOSI_arr.rand_mode(0);
                
            if(seq_item.state_ref inside {WR_ADD}) begin
                seq_item.ss_n_readdata_c.constraint_mode(0);
                seq_item.ss_n_allcases_c.constraint_mode(1);
                assert(seq_item.randomize with {MOSI_arr == {WR_ADD, 8'hab};});
                seq_item.update_counter_allcases;
                if(counter == 13) begin
                    seq_item.state_ref = WR_DATA;
                end
                end
            else if(seq_item.state_ref inside {WR_DATA}) begin
                    seq_item.ss_n_readdata_c.constraint_mode(0);
                    seq_item.ss_n_allcases_c.constraint_mode(1);
                    assert(seq_item.randomize with {MOSI_arr == {WR_DATA, 8'hab};});
                    seq_item.update_counter_allcases;
                    if(counter == 13) begin
                        seq_item.state_ref = RD_ADD;
                    end
            end
            else if(seq_item.state_ref inside {RD_ADD}) begin
                    seq_item.ss_n_readdata_c.constraint_mode(0);
                    seq_item.ss_n_allcases_c.constraint_mode(1);
                    assert(seq_item.randomize with {MOSI_arr == {RD_ADD, 8'hab};});
                    seq_item.update_counter_allcases;
                    if(counter == 13) begin
                        seq_item.state_ref = RD_DATA;
                    end
            end
            else if(seq_item.state_ref inside {RD_DATA}) begin
                    seq_item.ss_n_readdata_c.constraint_mode(1);
                    seq_item.ss_n_allcases_c.constraint_mode(0);
                    assert(seq_item.randomize with {MOSI_arr == {RD_DATA, 8'hab};});
                    seq_item.update_counter_readdatacase;
                end
                finish_item(seq_item);
            end
        endtask
        

    endclass
    

endpackage
