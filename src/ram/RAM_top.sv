import uvm_pkg::*;
`include "uvm_macros.svh"
import RAM_test_pkg::*;

module RAM_top();

  bit clk = 0;
  initial begin
    forever
      #1 clk =~clk ;
  end
  
  //DUT
  RAM_if ram_interface (clk);
  
  RAM DUT (
    .clk         (ram_interface.clk),
    .rst_n       (ram_interface.rst_n),
    .din         (ram_interface.din),
    .rx_valid    (ram_interface.rx_valid),
    .tx_valid    (ram_interface.tx_valid),
    .dout        (ram_interface.dout)
  );

  // Golden Model
  RAM_golden_copy #(.MEM_DEPTH(256), .ADDR_SIZE(8)) GOLDEN (ram_interface.GOLDEN);

  //Assertions
  bind RAM RAM_sva sva_inst (ram_interface.SVA);

  initial begin
    uvm_config_db# (virtual RAM_if)::set(null,"","RAM_IF", ram_interface) ; 
    run_test ("RAM_test") ;
  end
endmodule
