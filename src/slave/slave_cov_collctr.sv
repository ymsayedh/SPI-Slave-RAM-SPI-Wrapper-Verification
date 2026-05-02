package slave_cov_collctr_pkg;
    import uvm_pkg::*;
    `include "uvm_macros.svh"
    import slave_seq_item_pkg::*;
    import shared_pkg::*;

    class slave_cov_collctr extends uvm_component;
        
        `uvm_component_utils(slave_cov_collctr)
        uvm_analysis_export #(slave_seq_item) cov_export;
        uvm_tlm_analysis_fifo #(slave_seq_item) cov_fifo;
        slave_seq_item cov_seq_item;

        covergroup cov_name;

            rxd_cp : coverpoint cov_seq_item.rx_data[9:8];

            ssn_cp : coverpoint cov_seq_item.SS_n {
                bins full_tx = (1 => 0[*13] => 1);
                bins extended_tx = (1 => 0[*23] => 1);
            }
            
            mosi_cp : coverpoint cov_seq_item.MOSI {
                bins wradd = (0 => 0 => 0);
                bins wrrdata = (0 => 0 => 1);
                bins rdadd = (1 => 1 => 0);
                bins rddata = (1 => 1 => 1);
            }

            ssn_mosi_cross : cross ssn_cp, mosi_cp{
                bins wadd = binsof(ssn_cp.full_tx) && binsof(mosi_cp.wradd);
                bins wdata = binsof(ssn_cp.full_tx) && binsof(mosi_cp.wrrdata);
            }

        endgroup

        function new(input string name = "slave_cov_collctr",
             uvm_component parent = null);
            super.new(name, parent);
            cov_name = new;
        endfunction
        
        function void build_phase(input uvm_phase phase);
            super.build_phase(phase);
            cov_export = new("cov_export", this);
            cov_fifo = new("cov_fifo", this);
        endfunction
        
        function void connect_phase(input uvm_phase phase);
            super.connect_phase(phase);
            cov_export.connect(cov_fifo.analysis_export);
        endfunction
        
        task run_phase(input uvm_phase phase);
            super.run_phase(phase);
            forever begin
                cov_fifo.get(cov_seq_item);
                cov_name.sample;
            end
            
        endtask
    
    endclass
    

endpackage
