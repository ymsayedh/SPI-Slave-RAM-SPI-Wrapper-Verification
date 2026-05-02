package wrapper_agent_pkg;

    import uvm_pkg::*;
    `include "uvm_macros.svh"
    import wrapper_read_only_seq_pkg::*;
    import wrapper_reset_seq_pkg::*;
    import wrapper_write_only_seq_pkg::*;
    import wrapper_monitor_pkg::*;
    import wrapper_driver::*;
    import wrapper_seqr_pkg::*;
    import wrapper_config_obj::*;
    import wrapper_seq_item_pkg::*;

    class wrapper_agent extends uvm_agent;
        
        `uvm_component_utils(wrapper_agent)
        wrapper_monitor mon;
        wrapper_driver driver;
        wrapper_seqr sqr;
        wrapper_config_reg cfg;
        uvm_analysis_port #(wrapper_seq_item) agt_ap;

        function new(input string name = "wrapper_agent", uvm_component parent = null);
            super.new(name, parent);
        endfunction
        
        function void build_phase(input uvm_phase phase);
            super.build_phase(phase);
            if(!uvm_config_db #(wrapper_config_reg)::get(this, "", "CFG_WRAPPER", cfg)) begin
                `uvm_fatal("build_phase", "Unable to reterive configuration object")
            end
            sqr = wrapper_seqr::type_id::create("sqr", this);
            driver = wrapper_driver::type_id::create("driver", this);
            mon = wrapper_monitor::type_id::create("mon", this);
            agt_ap = new("agt_ap", this);
        endfunction
        
        function void connect_phase(input uvm_phase phase);
            super.connect_phase(phase);
            driver.wrapper_vif = cfg.wrapper_vif;
            mon.wrapper_vif = cfg.wrapper_vif;
            driver.seq_item_port.connect(sqr.seq_item_export);
            mon.mon_ap.connect(agt_ap); 
        endfunction
        

    endclass
    

endpackage
