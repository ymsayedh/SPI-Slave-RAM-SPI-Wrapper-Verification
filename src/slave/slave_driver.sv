package slave_driver;

    import uvm_pkg::*;
    `include "uvm_macros.svh"
    import slave_seq_item_pkg::*;

    class slave_driver extends uvm_driver #(slave_seq_item);

        `uvm_component_utils(slave_driver)
        slave_seq_item stim_seq_item;
        virtual slave_if slave_vif;

        function new(input string name, uvm_component parent);
            super.new(name, parent);
        endfunction

        task run_phase(input uvm_phase phase);
            super.run_phase(phase);
            forever begin
                stim_seq_item = slave_seq_item::type_id
                ::create("stim_seq_item");
                seq_item_port.get_next_item(stim_seq_item);
                slave_vif.rst_n = stim_seq_item.rst_n;
                // Reset of the signals
                slave_vif.MOSI = stim_seq_item.MOSI;
                slave_vif.tx_valid = stim_seq_item.tx_valid;
                slave_vif.tx_data = stim_seq_item.tx_data;
                slave_vif.SS_n = stim_seq_item.SS_n;
                #2;
                seq_item_port.item_done();
                `uvm_info("run_phase", stim_seq_item.convert2string_stimulus(), UVM_HIGH)
            end
            

        endtask
    endclass

endpackage
