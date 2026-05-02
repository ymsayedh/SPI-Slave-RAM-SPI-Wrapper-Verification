import uvm_pkg::*;
`include "uvm_macros.svh"
import slave_test_pkg::*;

module slave_top();

    bit clk;

    initial begin
        forever begin
        #1 clk = ~clk;
        end
    end

    slave_if slave_iff (
        .clk(clk)
    );

    SLAVE DUT (
        .MOSI(slave_iff.MOSI),
        .MISO(slave_iff.MISO),
        .SS_n(slave_iff.SS_n),
        .clk(slave_iff.clk),
        .rst_n(slave_iff.rst_n),
        .rx_data(slave_iff.rx_data),
        .rx_valid(slave_iff.rx_valid),
        .tx_data(slave_iff.tx_data),
        .tx_valid(slave_iff.tx_valid)
    );

    slave_ref DUT_ref (
        .clk(clk),
        .rst_n(slave_iff.rst_n),
        .MOSI(slave_iff.MOSI),
        .tx_valid(slave_iff.tx_valid),
        .SS_n(slave_iff.SS_n),
        .tx_data(slave_iff.tx_data),
        .rx_valid(slave_iff.rx_valid_ref),
        .MISO(slave_iff.MISO_ref),
        .rx_data(slave_iff.rx_data_ref)
    );

    bind SLAVE slave_sva sva (slave_iff.MON);

    initial begin
        uvm_config_db#(virtual slave_if)::set(null, "uvm_test_top", "slave_IF", slave_iff);
        run_test("slave_test");
    end
 
endmodule
