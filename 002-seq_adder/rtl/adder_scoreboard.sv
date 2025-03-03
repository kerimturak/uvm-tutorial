class adder_scoreboard extends uvm_scoreboard;

  `uvm_component_utils(adder_scoreboard)

  uvm_analysis_imp #(adder_packet, adder_scoreboard) adder_mon;
  adder_packet adder_transaction;

  int adder_count;

  function new(string name = "adder_scoreboard", uvm_component parent = null);
    super.new(name, parent);
    adder_count = 0;
    adder_mon   = new("adder_mon", this);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    adder_transaction = adder_packet::type_id::create("adder_transaction");
  endfunction

  virtual function void write(adder_packet tc);
    adder_transaction = tc;
    adder_count++;
    report_results();
  endfunction

  virtual function void report_results();
    if (adder_transaction.num1 + adder_transaction.num2 == adder_transaction.out) begin
      `uvm_info(get_type_name(), $sformatf("TEST PASSED: %d + %d = %d", adder_transaction.num1, adder_transaction.num2, adder_transaction.out), UVM_NONE)
    end else begin
      `uvm_error(get_type_name(), $sformatf("TEST FAILED: %d + %d != %d", adder_transaction.num1, adder_transaction.num2, adder_transaction.out))
    end
  endfunction

endclass : adder_scoreboard