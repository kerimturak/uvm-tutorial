module top;

  import uvm_pkg::*;
  `include "uvm_macros.svh"
  import adder_pkg::*;

  adder_if vif ();

  adder i_adder (
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

  // ----------------------------------------------------------------------
  // Dalga Dosyasının (VCD) Kaydedilmesi
  // - `$dumpfile("dumb.vcd");` → VCD dosya adı belirlenir.
  // - `$dumpvars;` → **Tüm sinyaller dalga dosyasına kaydedilir.**
  // - Simülasyonun analiz edilebilmesi için **dalga dosyası oluşturulur.**
  // ----------------------------------------------------------------------
  initial begin
    $dumpfile("dumb.vcd");  // Dalga dosyasını belirle
    $dumpvars;              // Tüm sinyalleri kaydet
  end

endmodule : top