package wrapper_env_pkg;
import uvm_pkg::*;
import wrapper_agent_pkg::*;
import wrapper_sb_pkg::*;

`include "uvm_macros.svh"

class wrapper_env extends uvm_env;

  `uvm_component_utils(wrapper_env)

  wrapper_agent agent;
  wrapper_sb sb;

  function new(input string name = "wrapper_env", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    agent = wrapper_agent::type_id::create("agent", this);
    sb = wrapper_sb::type_id::create("sb", this);
  endfunction

  function void connect_phase(input uvm_phase phase);
    super.connect_phase(phase);
    agent.agt_ap.connect(sb.sb_export);
  endfunction
  

endclass
endpackage
