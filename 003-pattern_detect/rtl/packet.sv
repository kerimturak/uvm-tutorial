class packet extends uvm_sequence_item;
  rand bit data;
  bit out;
 
  `uvm_object_utils_begin(packet)
  	`uvm_field_int(data, UVM_DEFAULT)
  `uvm_object_utils_end
  
  function new (input string name = "packet");
    super.new(name);
  endfunction
  
endclass