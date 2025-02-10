class sequencer extends uvm_sequencer #(packet);
  
  `uvm_component_utils(sequencer)

  function new(input string name, uvm_component parent);
    super.new(name, parent);
  endfunction
  
endclass