package wrapper_sb_pkg;
    import uvm_pkg::*;
    `include "uvm_macros.svh"
    import wrapper_seq_item_pkg::*;
//   import shared_package::*;pkgs


    class wrapper_sb extends uvm_scoreboard;
        
        `uvm_component_utils(wrapper_sb)
        uvm_analysis_export #(wrapper_seq_item) sb_export;
        uvm_tlm_analysis_fifo #(wrapper_seq_item) sb_fifo;
        wrapper_seq_item sb_seq_item;


        // Counters
        int correct_counter = 0, error_counter = 0;
        
        function new(input string name = "wrapper_sb", uvm_component parent = null);
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
                if(sb_seq_item.MISO != sb_seq_item.MISO_ref) begin
                    `uvm_error("run_phase", $sformatf({"Comparison failled, Transaction",
                    "recieved by DUT: %s While by reference 0b%0b"}, sb_seq_item.convert2string, 
                    sb_seq_item.MISO_ref))
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
