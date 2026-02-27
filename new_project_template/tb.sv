// =============================================================================
// Testbench - UVM Test
// =============================================================================

`include "uvm_macros.svh"
`include "pkg.sv"

import uvm_pkg::*;
import pkg::*;

// =============================================================================
// Simple Test
// =============================================================================

class test_simple extends uvm_test;
	`uvm_component_utils(test_simple)
	
	function new(string name = "test_simple", uvm_component parent = null);
		super.new(name, parent);
	endfunction
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction
	
	function void end_of_elaboration_phase(uvm_phase phase);
		super.end_of_elaboration_phase(phase);
		print();
	endfunction
	
	task run_phase(uvm_phase phase);
		phase.raise_objection(this);
		
		`uvm_info("TEST", "Test başladı", UVM_MEDIUM)
		
		#100; // Simulate for 100 time units
		
		`uvm_info("TEST", "Test tamamlandı", UVM_MEDIUM)
		
		phase.drop_objection(this);
	endtask
	
endclass

// =============================================================================
// DUT Module (Optional - remove if not needed)
// =============================================================================

module dut (
	input logic clk,
	input logic rst,
	input logic [7:0] data_in,
	output logic [7:0] data_out
);

	design dut_inst (
		.clk(clk),
		.rst(rst),
		.data_in(data_in),
		.data_out(data_out)
	);

endmodule

// =============================================================================
// Testbench Top Level
// =============================================================================

module tb;
	`include "uvm_macros.svh"
	import uvm_pkg::*;
	import pkg::*;
	
	// Clock
	logic clk = 0;
	always #5 clk = ~clk;
	
	// Signals
	logic rst;
	logic [7:0] data_in;
	logic [7:0] data_out;
	
	// DUT Instance
	dut dut_inst (
		.clk(clk),
		.rst(rst),
		.data_in(data_in),
		.data_out(data_out)
	);
	
	initial begin
		// Reset
		rst = 1;
		#20;
		rst = 0;
		
		// Run UVM test
		run_test();
	end
	
	// Optional: Dump waves
	initial begin
		if ($test$plusargs("DUMP_WAVES")) begin
			$dumpfile("waves.vcd");
			$dumpvars(0, tb);
		end
	end
	
endmodule
