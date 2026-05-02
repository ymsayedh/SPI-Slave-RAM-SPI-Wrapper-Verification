package wrapper_seq_item_pkg;
    import uvm_pkg::*;
    `include "uvm_macros.svh"
    import shared_pkg::*;
    

    class wrapper_seq_item extends uvm_sequence_item;
        
        `uvm_object_utils(wrapper_seq_item)
        rand bit rst_n;
        bit MISO, MISO_ref, MOSI;
        rand bit SS_n;
        rand bit [10 : 0] MOSI_arr;
        rand bit [7 : 0] data;
        rand state_e state_ref;
        state_e prev_state;
        

        function new(input string name = "wrapper_seq_item");
            super.new(name);
        endfunction

        function string convert2string();
            return $sformatf("%s MISO = 0b%0b", super.convert2string(), MISO);
        endfunction
        
        function string convert2string_stimulus();
            return $sformatf({"rst_n = 0b%0b MOSI = 0b%0b SS_n = 0b%0b "}, rst_n, MOSI, SS_n);
        endfunction
        
        // Constraints
        constraint rst_c {
            rst_n dist {99:/1 , 1:/1};
        }

        constraint ss_n_allcases_c{
            if(counter == 13){
                SS_n == 1;
            }
            else {
                SS_n == 0;
            }
        }
        
        constraint ss_n_readdata_c{
            if(counter == 23){
                SS_n == 1;
            }
            else {
                SS_n == 0;
            }
        }
        
        constraint mosi_arr_c {
            if(SS_n == 0 && SS_n_prev == 1){
                MOSI_arr == {state_ref, data};
            }
        }
        
        constraint readonly_c{
            if (prev_state == RD_DATA) {
                state_ref == RD_ADD;
            }
            else if(prev_state == RD_ADD) {
                state_ref == RD_DATA;
            }
        }

        constraint writeonly_c{
            state_ref dist {WR_ADD:/50, WR_DATA:/60};
        }

        constraint writenread_c {
            if(prev_state == WR_ADD){
                state_ref dist {WR_ADD, WR_DATA};
            }
            else if(prev_state == WR_DATA){
                state_ref dist {RD_ADD:/60, WR_ADD:/40};
            }
            else if(prev_state == RD_ADD){
                state_ref == RD_DATA;
            }
            else if(prev_state == RD_DATA){
                state_ref dist {WR_ADD:/60, RD_ADD:/40};
            }
        }

        function void update_counter_allcases;
            counter = (counter + 1) % 14;
        endfunction
        
        function void update_counter_readdatacase;
            counter = (counter + 1) % 24;
        endfunction

        function void post_randomize;
            if(counter > 0) begin
                MOSI = MOSI_arr[11 - counter];
            end
            SS_n_prev = SS_n;
            prev_state = state_ref;
        endfunction
        

    endclass
    

endpackage
