class adder_scoreboard extends uvm_scoreboard;

  `uvm_component_utils(adder_scoreboard)

  // ----------------------------------------------------------------------
  // Analysis Port Tanımlaması
  // - `adder_mon`, `uvm_analysis_imp` yapısını kullanarak monitor'den gelen verileri alır.
  // - Monitor tarafından gönderilen `adder_packet` nesneleri burada işlenir.
  // ----------------------------------------------------------------------
  uvm_analysis_imp #(adder_packet, adder_scoreboard) adder_mon;

  adder_packet adder_transaction;

  int adder_count;

  function new(string name = "adder_scoreboard", uvm_component parent = null);
    super.new(name, parent);
    adder_count = 0;
    adder_mon = new("adder_mon", this);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    adder_transaction = adder_packet::type_id::create("adder_transaction");
  endfunction

  // ----------------------------------------------------------------------
  // write()
  // - Monitor tarafından gönderilen `adder_packet` nesnesini alır.
  // - `adder_transaction` değişkenine atar.
  // - `adder_count` değerini artırır.
  // - `report_results()` fonksiyonunu çağırarak işlemi değerlendirir.
  // ----------------------------------------------------------------------
  virtual function void write(adder_packet tc);
    adder_transaction = tc;
    adder_count++;
    report_results();
  endfunction

  // ----------------------------------------------------------------------
  // report_results()
  // - Gelen işlemin doğruluğunu kontrol eder.
  // - `num1 + num2 == out` koşulu sağlanıyorsa test geçer (`TEST is Passed`).
  // - Koşul sağlanmıyorsa hata (`TEST is Failed`) mesajı verilir.
  // ----------------------------------------------------------------------
virtual function void report_results();
  if (adder_transaction.num1 + adder_transaction.num2 == adder_transaction.out) begin
    `uvm_info(get_type_name(), $sformatf("TEST PASSED: %d + %d = %d", adder_transaction.num1, adder_transaction.num2, adder_transaction.out), UVM_NONE)
  end else begin
    `uvm_error(get_type_name(), $sformatf("TEST FAILED: %d + %d != %d", adder_transaction.num1, adder_transaction.num2, adder_transaction.out))
  end
endfunction


endclass : adder_scoreboard