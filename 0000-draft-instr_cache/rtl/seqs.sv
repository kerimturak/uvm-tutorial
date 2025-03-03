class c2c_seqs extends uvm_sequence #(c2c_packet);
 
    `uvm_object_utils(c2c_seqs)

    function new(string name = "c2c_seqs");
        super.new(name);
    endfunction

  	virtual task pre_body();
		uvm_phase phase;
      	phase = get_starting_phase;
        if(phase != null) begin
          phase.raise_objection(this, get_type_name());
          `uvm_info("CORE_SEQS", "raise objection", UVM_MEDIUM)
        end
    endtask

    virtual task body();
        `uvm_info("CORE_SEQS", "Starting c2c_seqs", UVM_HIGH);
        repeat (100) `uvm_do(req)
        `uvm_info("CORE_SEQS", "Finished c2c_seqs", UVM_HIGH);
    endtask

    task post_body();
      uvm_phase phase;
      phase = get_starting_phase();
      if (phase != null) begin
        phase.drop_objection(this, get_type_name());
        `uvm_info("CORE_SEQS", "drop objection", UVM_MEDIUM)
      end
    endtask

endclass

class m2c_seqs extends uvm_sequence #(m2c_packet);

    `uvm_object_utils(m2c_seqs)

    function new(string name = "m2c_seqs");
        super.new(name);
    endfunction

  virtual task pre_body();
		uvm_phase phase;
      	phase = get_starting_phase;
        if(phase != null) begin
          phase.raise_objection(this, get_type_name());
          `uvm_info("MEM_SEQS", "raise objection", UVM_MEDIUM)
        end
    endtask

    virtual task body();
        `uvm_info("MEM_SEQS", "Starting core_cache_sequence", UVM_HIGH);
        repeat (100) `uvm_do(req)
        `uvm_info("MEM_SEQS", "Finished core_cache_sequence", UVM_HIGH);
    endtask

    task post_body();
      uvm_phase phase;
      phase = get_starting_phase();
      if (phase != null) begin
        phase.drop_objection(this, get_type_name());
        `uvm_info("MEM_SEQS", "drop objection", UVM_MEDIUM)
      end
    endtask

endclass
