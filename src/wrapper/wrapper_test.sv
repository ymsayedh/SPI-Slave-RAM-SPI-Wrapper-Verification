package wrapper_test_pkg; 

    import uvm_pkg::*;
    `include "uvm_macros.svh"

    import wrapper_env_pkg::*;
    import slave_env_pkg::*;
    import RAM_env_pkg::*;

    import wrapper_config_obj::*;
    import slave_config_obj::*;
    import pkg_cfg::*;

    import wrapper_write_only_seq_pkg::*;
    import wrapper_read_only_seq_pkg::*;
    import wrapper_reset_seq_pkg::*;
    import wrapper_write_read_seq_pkg::*;

    class wrapper_test extends uvm_test;

        `uvm_component_utils(wrapper_test)

        wrapper_env env;
        wrapper_config_reg wrapper_cfg;
        wrapper_write_only_seq write_only_seq;
        wrapper_read_only_seq read_only_seq;
        wrapper_reset_seq reset_seq;
        wrapper_write_read_seq write_read_seq;

        slave_config_reg slave_cfg;
        slave_env env_slave;

        RAM_config_obj RAM_cfg;
        RAM_env env_RAM;

        function new(input string name = "wrapper_test", uvm_component parent = null);
            super.new(name, parent);
        endfunction

        function void build_phase(input uvm_phase phase);

            super.build_phase(phase);
            env = wrapper_env::type_id::create("env", this);
            wrapper_cfg = wrapper_config_reg::type_id::create("wrapper_cfg", this);
            write_only_seq = wrapper_write_only_seq::type_id::create("write_only_seq", this);
            read_only_seq = wrapper_read_only_seq::type_id::create("read_only_seq", this);
            reset_seq = wrapper_reset_seq::type_id::create("reset_seq", this);
            write_read_seq = wrapper_write_read_seq::type_id::create("write_read_seq", this);

            slave_cfg = slave_config_reg::type_id::create("slave_cfg", this);
            env_slave = slave_env::type_id::create("env_slave", this);

            RAM_cfg = RAM_config_obj::type_id::create("RAM_cfg", this);
            env_RAM = RAM_env::type_id::create("env_RAM", this);

        if(!uvm_config_db #(virtual wrapper_if)::get(this, "", "wrapper_IF", 
        wrapper_cfg.wrapper_vif)) begin
        `uvm_fatal("Build_phase", "Test - Unable to get wrapper virtual interface")
        end

        if(!uvm_config_db #(virtual slave_if)::get(this, "", "slave_IF", 
        slave_cfg.slave_vif)) begin
        `uvm_fatal("Build_phase", "Test - Unable to get slave virtual interface")
        end

        if(!uvm_config_db #(virtual RAM_if)::get(this, "", "RAM_IF", 
        RAM_cfg.RAM_config_vif)) begin
        `uvm_fatal("Build_phase", "Test - Unable to get RAM virtual interface")
        end

        RAM_cfg.is_active = UVM_PASSIVE;
        slave_cfg.is_active = UVM_PASSIVE;
        wrapper_cfg.is_active = UVM_ACTIVE;

        uvm_config_db #(wrapper_config_reg)::set(this, "env.*", "CFG_WRAPPER", wrapper_cfg);
        uvm_config_db #(slave_config_reg)::set(this, "env_slave.*", "CFG_SLAVE", slave_cfg);
        uvm_config_db #(RAM_config_obj)::set(this, "env_RAM.*", "CFG_RAM", RAM_cfg);

    endfunction
    
        task run_phase(input uvm_phase phase);
            super.run_phase(phase);

            phase.raise_objection(this);
            `uvm_info("run_phase", "Reset Asserted", UVM_LOW)
            reset_seq.start(env.agent.sqr);
            `uvm_info("run_phase", "Reset Desserted", UVM_LOW)

            `uvm_info("run_phase", "Stimuli Generated", UVM_LOW)
            write_only_seq.start(env.agent.sqr);
            `uvm_info("run_phase", "Stimuli Degenerated", UVM_LOW)

            `uvm_info("run_phase", "Stimuli Generated", UVM_LOW)
            read_only_seq.start(env.agent.sqr);
            `uvm_info("run_phase", "Stimuli Degenerated", UVM_LOW)

            `uvm_info("run_phase", "Stimuli Generated", UVM_LOW)
            write_read_seq.start(env.agent.sqr);
            `uvm_info("run_phase", "Stimuli Degenerated", UVM_LOW)

            phase.drop_objection(this);
    endtask

    endclass: wrapper_test
endpackage
