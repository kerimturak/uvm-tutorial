class seqs extends uvm_sequence #(packet);

  `uvm_object_utils(seqs)

  function new(input string name = "seqs");
    super.new(name);
  endfunction

  task pre_body();
    uvm_phase phase;
    phase = get_starting_phase;

    if (phase != null) begin
      phase.raise_objection(this, get_type_name());
      `uvm_info(get_type_name(), "raise objection", UVM_MEDIUM)
    end
  endtask

  virtual task body();
    `uvm_info(get_type_name(), "Executing packets sequence", UVM_LOW)
    repeat (100) `uvm_do(req)
  endtask

  task post_body();
    uvm_phase phase;
    phase = get_starting_phase();
    if (phase != null) begin
      phase.drop_objection(this, get_type_name());
      `uvm_info(get_type_name(), "drop objection", UVM_MEDIUM)
    end
  endtask

endclass
