class scoreboard extends uvm_scoreboard;

  `uvm_component_utils(scoreboard)

  uvm_analysis_imp #(packet, scoreboard) monitor_port;

  packet trans[3:0];  // Bellek içeriğini saklayan dizi

  int fail_count = 0;  // Hata sayacı


  function new(string name, uvm_component parent);
    super.new(name, parent);
    monitor_port = new("monitor_port", this);  // Analysis port başlatılıyor

  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    // RAM başlangıç değerlerini sıfırla (ya da bilinmeyen değer ile başlat)

    foreach (trans[i]) begin
      trans[i] = packet::type_id::create($sformatf("trans[%0d]", i));
      trans[i].data_i = '0;  // Başlangıçta bellek içeriğini 0 yap

    end
  endfunction

  virtual function void write(packet item);
    `uvm_info(get_type_name(), $sformatf("Scoreboard: Received transaction - addr: %0d, data_i: %0d, rw_en: %0d, data_o: %0d", item.addr_i, item.data_i, item.rw_en_i, item.data_o), UVM_MEDIUM);

    if (item.rw_en_i) begin
      // Yazma işlemi -> Veriyi RAM modeli olan `trans[]` dizisine kaydet

      trans[item.addr_i].data_i = item.data_i;
      `uvm_info(get_type_name(), $sformatf("Scoreboard: Write to addr %0d, data %0d", item.addr_i, item.data_i), UVM_MEDIUM);
    end else begin
      // Okuma işlemi -> Beklenen veri ile karşılaştırma yap

      if (trans[item.addr_i].data_i == item.data_o) begin
        `uvm_info(get_type_name(), $sformatf("PASS: Read addr %0d, expected %0d, got %0d", item.addr_i, trans[item.addr_i].data_i, item.data_o), UVM_MEDIUM);
      end else begin
        `uvm_error(get_type_name(), $sformatf("FAIL: Read addr %0d, expected %0d, got %0d", item.addr_i, trans[item.addr_i].data_i, item.data_o));
        fail_count++;
      end
    end
  endfunction

  // Testin sonunda hata sayısını göster

  virtual function void report_phase(uvm_phase phase);
    `uvm_info(get_type_name(), $sformatf("Test completed. Total failures: %0d", fail_count), UVM_LOW);
  endfunction

endclass
