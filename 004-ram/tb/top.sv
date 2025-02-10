`include "ram_if.sv"
`include "ram_pkg.sv"

module top;
  
  import uvm_pkg::*;       
  `include "uvm_macros.svh"
  import ram_pkg::*;
  
  bit clk;
  bit rst;

  always #5 clk = ~clk;

  ram_if vif (clk, rst);

  ram i_ram (
    .clk      (clk),
    .rst      (rst),
    .addr_i   (vif.addr_i),
    .data_i   (vif.data_i),
    .rw_en_i  (vif.rw_en_i),
    .data_o   (vif.data_o)
  );

  initial begin
    uvm_config_db#(virtual ram_if)::set(null, "*", "vif", vif);
    run_test("base_test");
  end

   initial begin
    rst <= 1;
    @(posedge clk);
    rst <= 0;
  end
 
  initial begin
    $dumpfile("dumb.vcd");
    $dumpvars;
  end
endmodule