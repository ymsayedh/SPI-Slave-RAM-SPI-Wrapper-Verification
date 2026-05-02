package slave_env_pkg;
import uvm_pkg::*;
import slave_agent_pkg::*;
import slave_sb_pkg::*;
import slave_cov_collctr_pkg::*;


`include "uvm_macros.svh"

class slave_env extends uvm_env;

  `uvm_component_utils(slave_env)

  slave_agent agent;
  slave_cov_collctr cov;
  slave_sb sb;

  function new(input string name = "slave_env", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    agent = slave_agent::type_id::create("agent", this);
    sb = slave_sb::type_id::create("sb", this);
    cov = slave_cov_collctr::type_id::create("cov", this);
  endfunction

  function void connect_phase(input uvm_phase phase);
    super.connect_phase(phase);
    agent.agt_ap.connect(sb.sb_export);
    agent.agt_ap.connect(cov.cov_export);
  endfunction
  

endclass
endpackage
