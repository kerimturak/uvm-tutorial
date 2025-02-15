package cache_pkg;

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

endpackage