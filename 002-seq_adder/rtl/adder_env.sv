class adder_env extends uvm_env;

  adder_agent agent;
  adder_scoreboard sb;

  `uvm_component_utils(adder_env)

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    agent = adder_agent::type_id::create("agent", this);
    sb = adder_scoreboard::type_id::create("sb", this);
  endfunction : build_phase

  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    agent.monitor.adder_send.connect(sb.adder_mon);
  endfunction

  function void start_of_simulation_phase(uvm_phase phase);
    `uvm_info(get_type_name(), {"start of simulation for ", get_full_name()}, UVM_HIGH)
  endfunction : start_of_simulation_phase

endclass : adder_env
