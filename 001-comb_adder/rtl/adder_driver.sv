// ----------------------------------------------------------------------
// adder_driver: UVM Driver (Sürücü)
// Açıklama:
// - Bu sınıf, UVM ortamında çalışan bir **driver** tanımlar.
// - `adder_packet` nesnelerini **sequencer**'dan alır ve **DUT'e** (Design Under Test) gönderir.
// - `virtual interface adder_if vif;` ile fiziksel arayüzü (interface) kontrol eder.
// - `run_phase()` içinde sürekli çalışarak gelen verileri işleyip arayüze yönlendirir.
// ----------------------------------------------------------------------

class adder_driver extends uvm_driver #(adder_packet);

  // ----------------------------------------------------------------------
  // Virtual Interface Bağlantısı
  // - Driver, fiziksel sinyaller ile çalışamaz; bu yüzden sanal (virtual) interface kullanır.
  // - `adder_if` türünden bir **interface** olan `vif`, simülasyon sırasında bağlanmalıdır.
  // ----------------------------------------------------------------------
  virtual interface adder_if vif;

  `uvm_component_utils(adder_driver)

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  function void start_of_simulation_phase(uvm_phase phase);
    `uvm_info(get_type_name(), {"start of simulation for ", get_full_name()}, UVM_HIGH)
  endfunction : start_of_simulation_phase

  // ----------------------------------------------------------------------
  // connect_phase()
  // - Simülasyon başlamadan önce `adder_if` arayüzünün bağlanmasını kontrol eder.
  // - `uvm_config_db` üzerinden **virtual interface bağlantısını doğrular**.
  // - Eğer bağlantı başarısız olursa, `uvm_error()` mesajı basarak hata verir.
  // ----------------------------------------------------------------------
  function void connect_phase(uvm_phase phase);
    if (!uvm_config_db#(virtual adder_if)::get(this, "", "vif", vif))
      `uvm_error("NOVIF", {"virtual interface must be set for: ", get_full_name(), ".vif"})
  endfunction : connect_phase

  // ----------------------------------------------------------------------
  // run_phase()
  // - Simülasyon sırasında **sürekli çalışacak** olan ana task'tir.
  // - **Sequencer'dan gelen işlemleri alır ve fiziksel arayüze yollar.**
  // - `seq_item_port.get_next_item(req);` ile sequencer'dan yeni işlem alınır.
  // - `vif.num1` ve `vif.num2` değerleri interface’e aktarılır.
  // - **Delay verilerek** işlemin tamamlanması beklenir.
  // - İşlem tamamlandıktan sonra `req.print();` ile gelen veriler ekrana yazdırılır.
  // - `seq_item_port.item_done();` çağrılarak **işlemin tamamlandığı bildirilir.**
  // ----------------------------------------------------------------------
  task run_phase(uvm_phase phase);
    forever begin
      // Sequence'den yeni istek al
      seq_item_port.get_next_item(req);

      // Veriyi fiziksel interface’e (DUT girişlerine) aktar
      vif.num1 <= req.num1;
      vif.num2 <= req.num2;

      // İşlem tamamlandığında bilgi mesajı bas
      `uvm_info(get_type_name(), "Adder response received", UVM_LOW);

      // İşlemin tamamlanmasını beklemek için 10 zaman birimi bekle
      #10;

      // Gelen işlemi ekrana yazdır
      req.print();

      // İşlemin tamamlandığını bildirmek için item_done() çağrılır
      seq_item_port.item_done();
    end
  endtask : run_phase

endclass : adder_driver