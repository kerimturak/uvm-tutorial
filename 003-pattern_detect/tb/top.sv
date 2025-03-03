module top;
  import uvm_pkg::*;  // UVM paketini içe aktar
  `include "uvm_macros.svh"  // UVM makrolarını içe aktar
  import pattern_pkg::*;
  bit clk;
  bit rst;

  always #5 clk = ~clk;

  pattern_if vif (
      clk,
      rst
  );

  pattern_detector p1001 (
      .clk (clk),
      .rst (rst),
      .data(vif.data),
      .out (vif.out)
  );

  initial begin
    uvm_config_db#(virtual pattern_if)::set(null, "*", "vif", vif);

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

endmodule : top
