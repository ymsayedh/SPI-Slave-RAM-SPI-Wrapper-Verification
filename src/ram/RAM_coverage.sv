package RAM_coverage_pkg;
    import seq_item_pkg::*;
    import uvm_pkg::*;
    `include "uvm_macros.svh"
    
    class RAM_coverage extends uvm_component;
        `uvm_component_utils(RAM_coverage)

        uvm_analysis_export   #(RAM_seq_item) cov_export;
        uvm_tlm_analysis_fifo #(RAM_seq_item) cov_fifo;
        RAM_seq_item seq_item_cov;

        covergroup cg ;
            // Coverpoint
            // Checks that all 4 possible command values occur.
            // Captures valid operation sequences
            cp_din : coverpoint seq_item_cov.din[9:8] {
                bins din_00 = {2'b00};
                bins din_01 = {2'b01} ;
                bins din_10 = {2'b10} ;
                bins din_11 = {2'b11} ;
                bins write_address_data = (2'b00 => 2'b01) ;
                bins read_address_data  = (2'b10 => 2'b11) ;
                bins write_read_data    = (2'b00 => 2'b01 => 2'b10 => 2'b11) ;
            }

            cp_rx : coverpoint seq_item_cov.rx_valid {bins rx_valid_1 = {1};}
            
            cp_tx : coverpoint seq_item_cov.tx_valid {bins tx_valid_1 = {1};}

            // Cross Coverage #1: din[9:8] × rx_valid
            // Ensures all command types occur while rx_valid is high.
            cross_rx_din : cross cp_din,cp_rx {
                option.cross_auto_bin_max = 0;
                bins rx_din_00 = binsof(cp_din.din_00) && binsof(cp_rx.rx_valid_1);
                bins rx_din_01 = binsof(cp_din.din_01) && binsof(cp_rx.rx_valid_1);
                bins rx_din_10 = binsof(cp_din.din_10) && binsof(cp_rx.rx_valid_1);
                bins rx_din_11 = binsof(cp_din.din_11) && binsof(cp_rx.rx_valid_1);
            }
            
            // Cross Coverage #2: din[9:8] × tx_valid
            // Focuses on cases where command = READ_DATA (2’b11) and tx_valid is asserted.
            cross_tx_din : cross cp_din,cp_tx {
                option.cross_auto_bin_max = 0;
                bins tx_din_11 = binsof(cp_din.din_11) && binsof(cp_tx.tx_valid_1);
            }
        endgroup

        function new (string name = "RAM_coverage" , uvm_component parent = null);
            super.new(name , parent) ;
            cg = new() ;
        endfunction

        function void build_phase (uvm_phase phase);
            super.build_phase(phase);
            cov_export = new("cov_export",this);
            cov_fifo   = new("cov_fifo",this);
        endfunction

        function void connect_phase(uvm_phase phase);
            super.connect_phase(phase);
            cov_export.connect(cov_fifo.analysis_export);
        endfunction

        task run_phase (uvm_phase phase);
            super.run_phase(phase);
            forever begin
                cov_fifo.get(seq_item_cov);
                cg.sample();
            end
        endtask: run_phase
    endclass 
endpackage