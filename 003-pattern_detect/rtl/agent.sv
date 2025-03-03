class agent extends uvm_agent;

  monitor   i_monitor;
  sequencer i_sequencer;
  driver    i_driver;


  `uvm_component_utils_begin(agent)
    `uvm_field_enum(uvm_active_passive_enum, is_active, UVM_ALL_ON)
  `uvm_component_utils_end

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    i_monitor = monitor::type_id::create("i_monitor", this);
    if (is_active == UVM_ACTIVE) begin
      i_sequencer = sequencer::type_id::create("i_sequencer", this);
      i_driver    = driver::type_id::create("dri_driveriver", this);
    end
  endfunction : build_phase

  function void connect_phase(uvm_phase phase);
    if (is_active == UVM_ACTIVE) i_driver.seq_item_port.connect(i_sequencer.seq_item_export);
  endfunction : connect_phase

  function void start_of_simulation_phase(uvm_phase phase);
    `uvm_info(get_type_name(), {"start of simulation for ", get_full_name()}, UVM_HIGH)
  endfunction : start_of_simulation_phase

endclass
