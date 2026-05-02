package slave_sb_pkg;
    import uvm_pkg::*;
    `include "uvm_macros.svh"
    import slave_seq_item_pkg::*;
    import shared_pkg::*;


    class slave_sb extends uvm_scoreboard;
        
        `uvm_component_utils(slave_sb)
        uvm_analysis_export #(slave_seq_item) sb_export;
        uvm_tlm_analysis_fifo #(slave_seq_item) sb_fifo;
        slave_seq_item sb_seq_item;

        // Ref variables
        logic [5 : 0] dataout_ref;

        // Counters
        int correct_counter = 0, error_counter = 0;
        
        function new(input string name = "slave_sb", uvm_component parent = null);
            super.new(name, parent);
        endfunction
        
        function void build_phase(input uvm_phase phase);
            super.build_phase(phase);
            sb_export = new("sb_export", this);
            sb_fifo = new("sb_fifo", this);
        endfunction
        
        function void connect_phase(input uvm_phase phase);
            super.connect_phase(phase);
            sb_export.connect(sb_fifo.analysis_export);
        endfunction

        task run_phase(input uvm_phase phase);
            super.run_phase(phase);
            forever begin
                sb_fifo.get(sb_seq_item);
                if(sb_seq_item.MISO != sb_seq_item.MISO_ref || sb_seq_item.rx_valid !=
                    sb_seq_item.rx_valid_ref || sb_seq_item.rx_data != 
                    sb_seq_item.rx_data_ref) begin
                    `uvm_error("run_phase", $sformatf(string'({"Comparison failled, Transaction",
                    "recieved by DUT: %s While by reference: MISO = 0b%0b", 
                    "rx_valid = 0b%0b rx_data = 0b%0b"}), sb_seq_item.convert2string, 
                    sb_seq_item.MISO_ref, sb_seq_item.rx_valid_ref, sb_seq_item.rx_data_ref))
                    error_counter++;
                end
                else begin
                    `uvm_info("run_phase", $sformatf("Correct output: %s ", 
                    sb_seq_item.convert2string), UVM_MEDIUM)
                    correct_counter++;
                end
            end
            
        endtask
        

    endclass
    

endpackage
