class adder_base_seq extends uvm_sequence #(adder_packet);

  `uvm_object_utils(adder_base_seq)

  function new(string name = "adder_base_seq");
    super.new(name);
  endfunction

  task pre_body();
    uvm_phase phase;
    // UVM 1.2 ile gelen get_starting_phase() metodu kullanılarak test fazı alınır
    phase = get_starting_phase();
    if (phase != null) begin
      phase.raise_objection(this, get_type_name()); // Testin hala devam ettiğini bildir
      `uvm_info(get_type_name(), "raise objection", UVM_MEDIUM) // Bilgi mesajı bas
    end
  endtask : pre_body

  virtual task body();
    `uvm_info(get_type_name(), "Executing adder_packets sequence", UVM_LOW)
    repeat (5) `uvm_do(req)  // Rastgele 5 adet `adder_packet` oluştur ve gönder
  endtask

  task post_body();
    uvm_phase phase;
    // UVM 1.2 ile gelen get_starting_phase() metodu kullanılarak test fazı alınır
    phase = get_starting_phase();
    if (phase != null) begin
      phase.drop_objection(this, get_type_name()); // Testin tamamlandığını bildir
      `uvm_info(get_type_name(), "drop objection", UVM_MEDIUM) // Bilgi mesajı bas
    end
  endtask : post_body

endclass : adder_base_seq