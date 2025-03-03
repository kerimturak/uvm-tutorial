package adder_pkg;

  import uvm_pkg::*;
  `include "uvm_macros.svh"

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