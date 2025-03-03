package adder_pkg;

  import uvm_pkg::*;
  `include "uvm_macros.svh"

  // ----------------------------------------------------------------------
  // Virtual Interface Yapılandırma Tanımı
  // - `adder_if_config`, **adder_if** sanal arayüzünü UVM test ortamına bağlamak için kullanılır.
  // - `uvm_config_db` kullanılarak sanal arayüzün driver ve monitor tarafından erişilmesi sağlanır.
  // ----------------------------------------------------------------------
  typedef uvm_config_db#(virtual adder_if) adder_if_config;

  `include "adder_packet.sv"
  `include "adder_sequence.sv"
  `include "adder_sequencer.sv"
  `include "adder_driver.sv"
  `include "adder_monitor.sv"
  `include "adder_agent.sv"
  `include "adder_scoreboard.sv"
  `include "adder_env.sv"
  `include "adder_test.sv"

endpackage : adder_pkg