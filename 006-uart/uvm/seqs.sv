class seqs extends uvm_sequence #(packet);

  // Registers the class seqs to factory
  // sequence and transaction  --> uvm-object_utils
  // others                    --> uvm_component_utils

  `uvm_object_utils(seqs)

  function new(string name = "seqs");  // sequence and item related class (object) must have default name
    super.new(name);
  endfunction

  //`uvm_declare_p_sequencer(seqs)

  virtual task body();
    repeat (10) `uvm_do(req)
    // The print method deep_prints the current onject's variable.
    // This is not declared as virtual so we cannot override.
    // We can use hook/call-back method instead, do_print
    //req.print();
    // sprint bir nesneyi stringe çevirir, sformat f formatlı bir yazımı string olarak döndürür
    `uvm_info("SEQS", $sformatf("Packet : \n%s", req.sprint()), UVM_LOW);
    `uvm_info("SEQS2", $sformatf("convert2string:%s", convert2string()), UVM_LOW)
  endtask

endclass