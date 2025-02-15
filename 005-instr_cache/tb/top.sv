`timescale 1ns / 1ps

  import uvm_pkg::*;          // UVM kütüphanesini içe aktar
  `include "uvm_macros.svh"   // UVM makrolarını ekle

	import tcore_param::*;
	typedef uvm_config_db#(virtual cache_if) cache_if_config;

  `include "packet.sv"
  `include "sequence.sv"
  `include "sequencer.sv"
  `include "driver.sv"
  `include "monitor.sv"
  `include "agent.sv"
  `include "scoreboard.sv"
  `include "env.sv"
  `include "test.sv"
  `include "cache_if.sv"

module tb_icache();
  import uvm_pkg::*;          // UVM paketini içe aktar
  `include "uvm_macros.svh"   // UVM makrolarını içe aktar

  bit clk_i;
  bit rst_ni;

  cache_if vif(clk_i, rst_ni);

  icache i_icache(
    .clk_i(clk_i),
    .rst_ni(rst_ni),
    .cache_req_i(vif.cache_req_i),
    .cache_res_o(vif.cache_res_o),
    .icache_miss_o(vif.icache_miss_o),
    .lowX_res_i(vif.lowX_res_i),
    .lowX_req_o(vif.lowX_req_o)
  );

  initial begin
        // VCD dosyası ayarları
        $dumpfile("dump.vcd"); // VCD dosya adı
        $dumpvars(0, tb_icache); // Testbench içindeki tüm sinyalleri dök

        // UVM test ortamı için virtual interface ayarı
        uvm_config_db #(virtual cache_if)::set(null, "*", "vif", vif);

        // Testi çalıştır
        run_test("base_test");
  end

  // Saat sinyali üretimi
  initial begin
        clk_i = 0;
        rst_ni = 1; // Reset durumu
        #10 rst_ni = 0; // Reset'i kaldır
        #10000; // Test süresi
        $stop; // Simülasyonu durdur
  end

  // Saat sinyali oluşturma
  always #5 clk_i = ~clk_i;

endmodule
