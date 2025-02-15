class base_test extends uvm_test;

  `uvm_component_utils(base_test)

  env environment;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    uvm_config_int::set(this, "*", "recording_detail", 1);
    environment = env::type_id::create("environment", this);
    uvm_config_wrapper::set(this, "environment.cache_agent.sequencer.run_phase", "default_sequence", c2c_seqs::get_type());
    uvm_config_wrapper::set(this, "environment.lowX_agent.sequencer.run_phase", "default_sequence", m2c_seqs::get_type());
  endfunction : build_phase

  function void end_of_elaboration_phase(uvm_phase phase);
    uvm_top.print_topology();
  endfunction : end_of_elaboration_phase

  function void start_of_simulation_phase(uvm_phase phase);
    `uvm_info(get_type_name(), {"start of simulation for ", get_full_name()}, UVM_HIGH);
  endfunction : start_of_simulation_phase

  function void check_phase(uvm_phase phase);
    check_config_usage();
  endfunction

endclass
