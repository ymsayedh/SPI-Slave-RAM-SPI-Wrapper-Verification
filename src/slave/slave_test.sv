package slave_test_pkg; 

    import uvm_pkg::*;
    `include "uvm_macros.svh"

    import slave_env_pkg::*;
    import slave_config_obj::*;
    import slave_main_seq_pkg::*;
    import slave_reset_seq_pkg::*;

    class slave_test extends uvm_test;

        `uvm_component_utils(slave_test)

        slave_env env;
        slave_config_reg cfg;
        slave_main_seq main_seq;
        slave_reset_seq reset_seq;

        function new(input string name = "slave_test", uvm_component parent = null);
            super.new(name, parent);
        endfunction

        function void build_phase(input uvm_phase phase);

            super.build_phase(phase);
            env = slave_env::type_id::create("env", this);
            cfg = slave_config_reg::type_id::create("cfg");
            main_seq = slave_main_seq::type_id::create("main_seq");
            reset_seq = slave_reset_seq::type_id::create("reset_seq");

        if(!uvm_config_db #(virtual slave_if)::get(this, "", "slave_IF", 
        cfg.slave_vif)) begin
        `uvm_fatal("Build_phase", "Test - Unable to get virtual interface")
        end

        uvm_config_db #(slave_config_reg)::set(this, "*", "CFG_SLAVE", cfg);

        cfg.is_active = UVM_ACTIVE;

    endfunction
    
        task run_phase(input uvm_phase phase);
            super.run_phase(phase);
            phase.raise_objection(this);
            `uvm_info("run_phase", "Reset Asserted", UVM_LOW)
            reset_seq.start(env.agent.sqr);
            `uvm_info("run_phase", "Reset Desserted", UVM_LOW)

            `uvm_info("run_phase", "Stimuli Generated", UVM_LOW)
            main_seq.start(env.agent.sqr);
            `uvm_info("run_phase", "Stimuli Degenerated", UVM_LOW)

            phase.drop_objection(this);
    endtask

    endclass: slave_test
endpackage
