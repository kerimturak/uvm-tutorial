class env extends uvm_env;

  agent i_agent;
  scoreboard sb;

  `uvm_component_utils(env)

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    i_agent = agent::type_id::create("i_agent", this);
    sb = scoreboard::type_id::create("sb", this);
  endfunction : build_phase

  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    i_agent.i_monitor.mon_to_sb.connect(sb.monitor_port);
  endfunction

  function void start_of_simulation_phase(uvm_phase phase);
    `uvm_info(get_type_name(), {"start of simulation for ", get_full_name()}, UVM_HIGH)
  endfunction : start_of_simulation_phase

endclass

