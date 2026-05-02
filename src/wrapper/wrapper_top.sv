import uvm_pkg::*;
`include "uvm_macros.svh"
import wrapper_test_pkg::*;

module wrapper_top();

    bit clk;

    parameter int MEM_DEPTH = 256;
    parameter int ADDR_SIZE = 8;

    initial begin
        forever begin
        #1 clk = ~clk;
        end
    end

    wrapper_if wrapper_if (
        .clk(clk)
    );

    slave_if slave_if (
        .clk(clk)
    );

    RAM_if #(
        .MEM_DEPTH(MEM_DEPTH),
        .ADDR_SIZE(ADDR_SIZE)
    ) RAM_if (
        .clk(clk)
    );  

    WRAPPER DUT (
        .MOSI(wrapper_if.MOSI),
        .MISO(wrapper_if.MISO),
        .SS_n(wrapper_if.SS_n),
        .clk(clk),
        .rst_n(wrapper_if.rst_n)
    );

    wrapper_ref REF (
        .MOSI(wrapper_if.MOSI),
        .MISO(wrapper_if.MISO_ref),
        .SS_n(wrapper_if.SS_n),
        .clk(clk),
        .rst_n(wrapper_if.rst_n)
    );

    initial begin
        uvm_config_db#(virtual wrapper_if)::set(null, "uvm_test_top", "wrapper_IF", wrapper_if);
        uvm_config_db#(virtual slave_if)::set(null, "uvm_test_top", "slave_IF", slave_if);
        uvm_config_db#(virtual RAM_if)::set(null, "uvm_test_top", "RAM_IF", RAM_if);
        run_test("wrapper_test");
    end
 
endmodule
