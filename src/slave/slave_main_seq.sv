package slave_main_seq_pkg;
    import uvm_pkg::*;
    `include "uvm_macros.svh"
    import slave_seq_item_pkg::*;
    import shared_pkg::*;

    class slave_main_seq extends uvm_sequence #(slave_seq_item);

        `uvm_object_utils(slave_main_seq)
        slave_seq_item seq_item;
        
        function new(input string name = "shift_reg_main_sequence");
            super.new(name);
        endfunction
        
        task body();
            seq_item = slave_seq_item::type_id::create("seq_item");
            repeat(300) begin
                start_item(seq_item);
                if(seq_item.state_ref inside {RD_ADD, WR_ADD, WR_DATA}) begin
                    seq_item.ss_n_readdata_c.constraint_mode(0);
                    seq_item.ss_n_allcases_c.constraint_mode(1);
                    if(counter % 13) begin
                        seq_item.MOSI_arr.rand_mode(0);
                        seq_item.state_ref.rand_mode(0);
                        seq_item.writenread_c.constraint_mode(0);
                    end
                    else if(counter == 0) begin
                        seq_item.MOSI_arr.rand_mode(1);
                        seq_item.state_ref.rand_mode(1);
                        seq_item.writenread_c.constraint_mode(1);
                    end
                    assert(seq_item.randomize);
                    seq_item.update_counter_allcases;
                    end
                else begin
                    seq_item.ss_n_readdata_c.constraint_mode(1);
                    seq_item.ss_n_allcases_c.constraint_mode(0);
                    if(counter % 23) begin
                        seq_item.MOSI_arr.rand_mode(0);
                        seq_item.state_ref.rand_mode(0);
                        seq_item.writenread_c.constraint_mode(0);
                    end
                    else if(counter == 0) begin
                        seq_item.MOSI_arr.rand_mode(1);
                        seq_item.state_ref.rand_mode(1);
                        seq_item.writenread_c.constraint_mode(1);
                    end
                    assert(seq_item.randomize);
                    seq_item.update_counter_readdatacase;
                end
                finish_item(seq_item);
            end
        endtask
        

    endclass
    

endpackage
