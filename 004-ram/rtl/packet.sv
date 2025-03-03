class packet extends uvm_sequence_item;

  rand bit [1:0] addr_i;
  rand bit [3:0] data_i;
  rand bit       rw_en_i;
  bit      [3:0] data_o;

  `uvm_object_utils_begin(packet)
    `uvm_field_int(addr_i, UVM_DEFAULT)
    `uvm_field_int(data_i, UVM_DEFAULT)
    `uvm_field_int(rw_en_i, UVM_DEFAULT)
  `uvm_object_utils_end

  function new(string name = "packet");
    super.new(name);
  endfunction

endclass
