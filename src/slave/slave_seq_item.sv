package slave_seq_item_pkg;
    import uvm_pkg::*;
    `include "uvm_macros.svh"
    
    import shared_pkg::*;

    class slave_seq_item extends uvm_sequence_item;
        
        `uvm_object_utils(slave_seq_item)
        rand bit rst_n, SS_n, tx_valid;
        rand logic [7 : 0] tx_data;
        logic [9 : 0] rx_data, rx_data_ref;
        rand bit [10 : 0] MOSI_arr;
        bit MOSI, MISO, MISO_ref, rx_valid, rx_valid_ref;
        rand state_e state_ref;
        state_e prev_state;

        function new(input string name = "slave_seq_item");
            super.new(name);
        endfunction

        function string convert2string();
            return $sformatf({"%s rst_n = 0b%0b rx_data = 0b%b rx_valid = 0b%b",
             "MISO = 0b%b"}, super.convert2string(), rst_n, rx_data, rx_valid,
              MISO);
        endfunction
        
        function string convert2string_stimulus();
            return $sformatf({"rst_n = 0b%0b tx_data = 0b%0b tx_valid = 0b%b", 
            " MOSI = 0b%0b SS_n = 0b%b"}, rst_n, tx_data, tx_valid, MOSI, SS_n);
        endfunction
        
        // Constraints
        constraint reset_c {   
            rst_n  dist {1:/99, 0:/1};
        }

        constraint ss_n_allcases_c {
            if(counter == 13) {
                SS_n == 1;
            }
            else {
                SS_n == 0;
            }
        }

        constraint ss_n_readdata_c {
            if(counter == 23) {
                SS_n == 1;
            }
            else {
                SS_n == 0;
            }
        }

        constraint mosiarr_c {
            MOSI_arr == {state_ref, tx_data};
        
        }

        constraint state_c {
            unique {state_ref};
        }

        constraint txv_c {
            if(state_ref == RD_DATA && counter > 12){
                tx_valid == 1;
            }
            else {
                tx_valid == 0;
            }
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
        
        function void post_randomize;
            if(!rst_n) begin
                counter = 0;
                MOSI = 0;
            end
            else begin
                if(counter > 0) begin
                    MOSI = MOSI_arr[11 - counter];
                    $display("@%g %0b %s", $time, MOSI_arr, state_ref);
                end
            end
            prev_state = state_ref;
        endfunction
        
        function void update_counter_allcases;
            counter = (counter + 1) % 14;
        endfunction
        
        function void update_counter_readdatacase;
            counter = (counter + 1) % 24;
        endfunction

    endclass
    

endpackage
