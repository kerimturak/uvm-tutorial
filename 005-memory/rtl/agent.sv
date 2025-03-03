class agent extends uvm_agent;
  
  `uvm_component_utils(agent)
  sequencer mem_sequencer;
  driver    mem_driver;
  monitor   mem_monitor;
 
  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    if (get_is_active() == UVM_ACTIVE) begin
      // create function for components take two arguments
      mem_driver    = driver::type_id::create("mem_driver", this);
      mem_sequencer = sequencer::type_id::create("mem_sequencer", this);
    end
    mem_monitor = monitor::type_id::create("mem_monitor", this);
  endfunction
  
  function void connect_phase(uvm_phase phase);
    if(get_is_active() == UVM_ACTIVE) begin
      mem_driver.seq_item_port.connect(mem_sequencer.seq_item_export);
    end
  endfunction

endclass