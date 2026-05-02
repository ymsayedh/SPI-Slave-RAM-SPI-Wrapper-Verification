package slave_config_obj;

    import uvm_pkg::*;
    `include "uvm_macros.svh"

    class slave_config_reg extends uvm_object;
        `uvm_object_utils(slave_config_reg)

        virtual slave_if slave_vif;
        uvm_active_passive_enum is_active;

        function new(input string name = "shift_reg_confif");
            super.new(name);
        endfunction


    endclass

endpackage
