package pattern_pkg;

  import uvm_pkg::*;          // UVM kütüphanesini içe aktar
  `include "uvm_macros.svh"   // UVM makrolarını ekle

  typedef uvm_config_db#(virtual pattern_if) pattern_if_config;

  `include "packet.sv"
  `include "sequence.sv"
  `include "sequencer.sv"
  `include "driver.sv"
  `include "monitor.sv"
  `include "agent.sv"
  `include "scoreboard.sv"
  `include "env.sv"
  `include "test.sv"
endpackage