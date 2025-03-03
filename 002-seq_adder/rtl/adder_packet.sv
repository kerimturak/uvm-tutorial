class adder_packet extends uvm_sequence_item;

  rand bit [7:0] num1;
  rand bit [7:0] num2;

  bit [8:0] out;

  function new(input string name = "adder_packet");
    super.new(name);
  endfunction

  `uvm_object_utils_begin(adder_packet)
    `uvm_field_int(num1, UVM_DEFAULT)
    `uvm_field_int(num2, UVM_DEFAULT)
  `uvm_object_utils_end

endclass : adder_packet