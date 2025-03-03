`include "adder_pkg.sv"

module top;

  import uvm_pkg::*;
  `include "uvm_macros.svh"
  import adder_pkg::*;

  bit clk;
  bit rst;
  always #5 clk = ~clk;
  adder_if vif (clk, rst);

  adder i_adder (
    .clk  (clk),
    .rst  (rst),
    .num1 (vif.num1),
    .num2 (vif.num2),
    .out  (vif.out)
  );

  initial begin
    // Virtual interface'in UVM test ortamında kullanılmasını sağla
    uvm_config_db#(virtual adder_if)::set(null, "*", "vif", vif);

    // UVM testini başlat
    run_test("base_test");
  end

   initial begin
    rst <= 1;
    @(posedge clk);
    rst <= 0;
  end

  initial begin
    $dumpfile("dumb.vcd");  // Dalga dosyasını belirle
    $dumpvars;              // Tüm sinyalleri kaydet
  end

endmodule : top