// ----------------------------------------------------------------------
// adder_sequencer: UVM Sequencer (İşlem Sırası Yöneticisi)
// Açıklama:
// - Bu sınıf, UVM ortamında `adder_packet` nesnelerini yöneten bir **sequencer** tanımlar.
// - `uvm_sequencer #(adder_packet)` sınıfından türetilmiştir.
// - Sequencer, driver ile **doğrudan iletişim kurarak** doğrulama sürecinde veri akışını kontrol eder.
// - `adder_base_seq` tarafından oluşturulan işlemleri alır ve driver'a gönderir.
// ----------------------------------------------------------------------

class adder_sequencer extends uvm_sequencer #(adder_packet);

  `uvm_component_utils(adder_sequencer)

  // ----------------------------------------------------------------------
  // Constructor (Yapıcı Fonksiyon)
  // - `adder_sequencer` nesnesini başlatır.
  // - **İki parametre alır**:
  //   - `string name`: Sequencer bileşeninin ismi.
  //   - `uvm_component parent`: Sequencer'ın ait olduğu üst bileşen (parent).
  //   - `uvm_component parent` tan türetilen sınıflar default isme sahip olmazsa hata üretmez.
  // - `super.new(name, parent);` ile **üst sınıf olan `uvm_sequencer`'in yapıcı fonksiyonu çağrılır**.
  // ----------------------------------------------------------------------
  function new(string name, uvm_component parent);
    super.new(name, parent);     // UVM yapısına uygun şekilde constructor çağırılır.
  endfunction

  // ----------------------------------------------------------------------
  // start_of_simulation_phase()
  // - Simülasyonun başında çağrılan özel bir UVM fonksiyonudur.
  // - `uvm_info()` mesajı basarak, hangi sequencer'ın çalıştığını bildirir.
  // - `get_full_name()` ile bileşenin tam yolu yazdırılır.
  // ----------------------------------------------------------------------
  function void start_of_simulation_phase(uvm_phase phase);
    `uvm_info(get_type_name(), {"start of simulation for ", get_full_name()}, UVM_HIGH)
  endfunction : start_of_simulation_phase

endclass : adder_sequencer