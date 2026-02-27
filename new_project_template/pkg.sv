// =============================================================================
// Package - Veri Tipleri ve Utilities
// =============================================================================

package pkg;
  import uvm_pkg::*;

  // Include UVM macros
  `include "uvm_macros.svh"

  // Simple test transaction
  class test_item extends uvm_sequence_item;
    // Fields
    rand logic [7:0] data;

    `uvm_object_utils(test_item)

    // Constructor
    function new(string name = "test_item");
      super.new(name);
    endfunction

    // Convert2string for printing
    function string convert2string();
      return $sformatf("data=%02X", data);
    endfunction
  endclass

endpackage
