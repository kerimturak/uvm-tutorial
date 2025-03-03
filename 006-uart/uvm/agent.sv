class agent extends uvm_agent;

  `uvm_component_utils(agent)
  sequencer uart_sequencer;
  driver    uart_driver;
  monitor   uart_monitor;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    if (get_is_active() == UVM_ACTIVE) begin
      // create function for components take two arguments
      uart_driver    = driver::type_id::create("uart_driver", this);
      uart_sequencer = sequencer::type_id::create("uart_sequencer", this);
    end
    uart_monitor = monitor::type_id::create("uart_monitor", this);
  endfunction

  function void connect_phase(uvm_phase phase);
    if (get_is_active() == UVM_ACTIVE) begin
      uart_driver.seq_item_port.connect(uart_sequencer.seq_item_export);
    end
  endfunction

endclass
