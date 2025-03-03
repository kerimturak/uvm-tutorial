class base_test extends uvm_test;

  `uvm_component_utils(base_test)

  env   mem_env;
  seqs  mem_seq;

  function new(string name = "base_test",uvm_component parent=null);
    super.new(name,parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    mem_env = env::type_id::create("mem_env", this);
    mem_seq = seqs::type_id::create("mem_seq");
  endfunction : build_phase

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    mem_seq.start(mem_env.mem_agent.mem_sequencer);
    phase.drop_objection(this);
  endtask : run_phase

endclass