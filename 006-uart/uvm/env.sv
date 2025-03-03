class env extends uvm_env;

  agent      uart_agent;
  scoreboard uart_sb;

  `uvm_component_utils(env)

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    uart_agent = agent::type_id::create("uart_agent", this);
    uart_sb = scoreboard::type_id::create("uart_sb", this);
  endfunction

  function void connect_phase(uvm_phase phase);
    uart_agent.uart_monitor.mon2sb_port.connect(uart_sb.mon2sb_export);
  endfunction : connect_phase

endclass
