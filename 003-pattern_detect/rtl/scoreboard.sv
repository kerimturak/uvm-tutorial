class scoreboard extends uvm_scoreboard;
  `uvm_component_utils(scoreboard)

  uvm_analysis_imp #(packet, scoreboard) monitor_port;

  packet transaction;

  bit [3:0] ref_pattern;
  bit [3:0] act_pattern;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    monitor_port = new("monitor_port", this);  // Analysis port başlatılıyor

  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    transaction = packet::type_id::create("transaction");
  endfunction

  virtual function void write(packet tc);
    ref_pattern = 4'b1001;
    transaction = tc;
    act_pattern = act_pattern << 1 | transaction.data;
    `uvm_info("scoreboard", $sformatf("%b", act_pattern), UVM_LOW)
    report_results();
  endfunction

  virtual function void report_results();
    if (!(ref_pattern ^ act_pattern) && transaction.out) begin
      `uvm_info("scoreboard", $sformatf("Pattern found to match, next out should be 1, out: %0d", transaction.out), UVM_LOW)
    end else begin
      `uvm_warning("scoreboard", $sformatf("Pattern is not found, next out should be 0, out: %0d pattern : %0b", transaction.out, act_pattern))
    end
  endfunction

endclass
