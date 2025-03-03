class env extends uvm_env;

    `uvm_component_utils(env)

    c2c_agent cache_agent;
    m2c_agent lowX_agent;
    scoreboard sb;

    function new(string name = "env", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        cache_agent = c2c_agent::type_id::create("cache_agent", this);
        lowX_agent = m2c_agent::type_id::create("lowX_agent", this);
        sb = scoreboard::type_id::create("sb", this);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
      cache_agent.monitor.c2c_mon_to_sb_port.connect(sb.c2c_mon_port);
      lowX_agent.monitor.m2c_mon_to_sb_port.connect(sb.m2c_mon_port);
    endfunction

    function void start_of_simulation_phase (uvm_phase phase);
        `uvm_info(get_type_name(), {"start of simulation", get_full_name()},UVM_HIGH);
    endfunction

endclass
