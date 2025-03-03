class env extends uvm_env;
  
  agent      mem_agent;
  scoreboard mem_sb;
  
  `uvm_component_utils(env)

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    mem_agent = agent::type_id::create("mem_agent", this);
    mem_sb  = scoreboard::type_id::create("mem_sb", this);
  endfunction

  function void connect_phase(uvm_phase phase);
    mem_agent.mem_monitor.mon2sb_port.connect(mem_sb.mon2sb_export);
  endfunction : connect_phase

endclass