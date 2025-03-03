class base_test extends uvm_test;

  `uvm_component_utils(base_test)

  env   uart_env;
  seqs  uart_seq;

  function new(string name = "base_test",uvm_component parent=null);
    super.new(name,parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    uart_env = env::type_id::create("uart_env", this);
    uart_seq = seqs::type_id::create("uart_seq");
  endfunction : build_phase

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    uart_seq.start(uart_env.uart_agent.uart_sequencer);
    phase.drop_objection(this);
  endtask : run_phase

endclass