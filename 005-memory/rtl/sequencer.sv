class sequencer extends uvm_sequencer # (packet);
  
  `uvm_component_utils(sequencer)

  // All classes derived from uvm_component must have name and handle to parent
  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction
  
endclass