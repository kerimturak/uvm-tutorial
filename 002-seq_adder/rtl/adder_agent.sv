class adder_agent extends uvm_agent;

  adder_monitor   monitor;
  adder_sequencer sequencer;
  adder_driver    driver;

  `uvm_component_utils_begin(adder_agent)
    `uvm_field_enum(uvm_active_passive_enum, is_active, UVM_ALL_ON)
  `uvm_component_utils_end

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    // Monitor her zaman oluşturulur (Hem ACTIVE hem PASSIVE modda çalışır)
    monitor = adder_monitor::type_id::create("monitor", this);

    // Eğer agent ACTIVE moddaysa sequencer ve driver oluşturulur
    if (is_active == UVM_ACTIVE) begin
      sequencer = adder_sequencer::type_id::create("sequencer", this);
      driver = adder_driver::type_id::create("driver", this);
    end
  endfunction : build_phase

  function void connect_phase(uvm_phase phase);
    if (is_active == UVM_ACTIVE)
      driver.seq_item_port.connect(sequencer.seq_item_export);
  endfunction : connect_phase

  function void start_of_simulation_phase(uvm_phase phase);
    `uvm_info(get_type_name(), {"start of simulation for ", get_full_name()}, UVM_HIGH)
  endfunction : start_of_simulation_phase

endclass : adder_agent