package wrapper_config_obj;

    import uvm_pkg::*;
    `include "uvm_macros.svh"

    class wrapper_config_reg extends uvm_object;
        `uvm_object_utils(wrapper_config_reg)

        virtual wrapper_if wrapper_vif;
        uvm_active_passive_enum is_active;

        function new(input string name = "shift_reg_confif");
            super.new(name);
        endfunction


    endclass

endpackage
