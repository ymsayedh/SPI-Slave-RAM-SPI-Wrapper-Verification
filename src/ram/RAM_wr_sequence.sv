package RAM_read_write_seq_pkg ;
    import seq_item_pkg::*;
    import uvm_pkg::*;
    `include "uvm_macros.svh"

    class RAM_read_write_seq extends uvm_sequence #(RAM_seq_item) ;
    `uvm_object_utils(RAM_read_write_seq)

    RAM_seq_item seq_item ;
    RAM_seq_item seq_item2 ;

    function new (string name = "RAM_read_write_seq");
        super.new(name);
    endfunction

    task body();
        repeat(1000) begin
            seq_item = RAM_seq_item::type_id::create("seq_item");
            start_item(seq_item);

            seq_item.constraint_mode(0);
            seq_item.c_rx.constraint_mode(1);
            seq_item.c_rst.constraint_mode(1);
            
            case (seq_item.prev_op)
                //After Write Address operation
                2'b00 : assert (seq_item.randomize() with {seq_item.din[9:8] dist { [2'b00:2'b01] := 100};});
                //After Write Data operation
                2'b01 : assert (seq_item.randomize() with {seq_item.din[9:8] dist { 2'b00 := 40, 2'b10 := 60};});
                //After Read Address operation
                2'b10 : assert (seq_item.randomize() with {seq_item.din[9:8] dist { [2'b10:2'b11] := 100};});
                //After Read Data operation
                2'b11 : assert (seq_item.randomize() with {seq_item.din[9:8] dist {  2'b00 := 60, 2'b10 := 40};});
            endcase

            finish_item(seq_item);
        end

        repeat(100) begin
            seq_item2 = RAM_seq_item::type_id::create("seq_item2");
            start_item(seq_item2);

            seq_item2.constraint_mode(0);
            seq_item2.c_rx.constraint_mode(1);
            seq_item2.c_rst.constraint_mode(1);
            
                //
                assert (seq_item2.randomize() with {seq_item2.din[9:8] dist { [2'b00:2'b11] := 100};});

            finish_item(seq_item2);
        end
    endtask 
 endclass
endpackage