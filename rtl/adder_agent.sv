// ----------------------------------------------------------------------
// adder_agent: UVM Agent (Ajan)
// Açıklama:
// - `adder_agent`, **monitor, sequencer ve driver** bileşenlerini bir araya getirerek
//   **bağımsız bir doğrulama birimi** oluşturur.
// - **UVM_ACTIVE** modda çalıştığında **sequencer ve driver'ı oluşturur**,
//   **UVM_PASSIVE** modda çalıştığında sadece monitor kullanılır.
// - **Bağımsız, tekrar kullanılabilir ve modüler bir doğrulama yapısı sağlar.**
// ----------------------------------------------------------------------

class adder_agent extends uvm_agent;

  // ----------------------------------------------------------------------
  // Agent İçindeki Bileşenler
  // - `monitor`: DUT'ün giriş-çıkışlarını gözlemleyerek test ortamına veri aktarır.
  // - `sequencer`: Driver için veri üreten bileşendir.
  // - `driver`: Veri işlemlerini sequencer'dan alarak DUT'e iletir.
  // ----------------------------------------------------------------------
  adder_monitor   monitor;
  adder_sequencer sequencer;
  adder_driver    driver;

  // ----------------------------------------------------------------------
  // `uvm_component_utils` ile Agent Tanımlaması
  // - `uvm_component_utils_begin` ve `uvm_component_utils_end` ile
  //   UVM sistemine `adder_agent` kaydedilir.
  // - `is_active` değişkeni ile **ACTIVE (aktif) veya PASSIVE (pasif) modda çalışabilir**.
  // - `UVM_ACTIVE` modda driver ve sequencer oluşturulur.
  // - `UVM_PASSIVE` modda yalnızca monitor çalışır.
  // ----------------------------------------------------------------------
  `uvm_component_utils_begin(adder_agent)
    `uvm_field_enum(uvm_active_passive_enum, is_active, UVM_ALL_ON)
  `uvm_component_utils_end

  // ----------------------------------------------------------------------
  // Constructor (Yapıcı Fonksiyon)
  // - `adder_agent` nesnesini başlatır.
  // - `super.new(name, parent);` ile üst sınıf olan `uvm_agent`'in yapıcı fonksiyonu çağrılır.
  // ----------------------------------------------------------------------
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  // ----------------------------------------------------------------------
  // build_phase()
  // - Simülasyon başlamadan önce **bileşenleri oluşturur.**
  // - `monitor` her iki modda da oluşturulur.
  // - Eğer **UVM_ACTIVE** modda ise `sequencer` ve `driver` bileşenleri de oluşturulur.
  // ----------------------------------------------------------------------
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    // Monitor her zaman oluşturulur (Hem ACTIVE hem PASSIVE modda çalışır)
    monitor = adder_monitor::type_id::create("monitor", this);

    // Eğer agent ACTIVE moddaysa sequencer ve driver oluşturulur
    if (is_active == UVM_ACTIVE) begin
      sequencer = adder_sequencer::type_id::create("sequencer", this);
      driver = adder_driver::type_id::create("driver", this);
    end
  endfunction : build_phase

  // ----------------------------------------------------------------------
  // connect_phase()
  // - Driver ile Sequencer arasında bağlantı kurulur.
  // - **Bu bağlantı yalnızca UVM_ACTIVE modda çalışırken yapılır.**
  // - `driver.seq_item_port.connect(sequencer.seq_item_export);` ile
  //   driver ve sequencer birbirine bağlanır.
  // ----------------------------------------------------------------------
  function void connect_phase(uvm_phase phase);
    if (is_active == UVM_ACTIVE) 
      driver.seq_item_port.connect(sequencer.seq_item_export);
  endfunction : connect_phase

  // ----------------------------------------------------------------------
  // start_of_simulation_phase()
  // - Simülasyonun başında çağrılan özel bir UVM fonksiyonudur.
  // - `uvm_info()` mesajı basarak, hangi agent'ın çalıştığını bildirir.
  // - `get_full_name()` ile bileşenin tam yolu yazdırılır.
  // ----------------------------------------------------------------------
  function void start_of_simulation_phase(uvm_phase phase);
    `uvm_info(get_type_name(), {"start of simulation for ", get_full_name()}, UVM_HIGH)
  endfunction : start_of_simulation_phase

endclass : adder_agent

// ----------------------------------------------------------------------
// KODUN SAĞLADIĞI ÖZELLİKLER
// ----------------------------------------------------------------------
// 1. **Factory Desteği (`create()`)**
//    - `adder_agent` nesnesi fabrika sisteminde oluşturulabilir.
//    - Örnek:
//      ```systemverilog
//      adder_agent agent;
//      agent = adder_agent::type_id::create("agent", parent);
//      ```
//
// 2. **ACTIVE ve PASSIVE Mod Desteği**
//    - **UVM_ACTIVE** modda **sequencer ve driver** çalışır.
//    - **UVM_PASSIVE** modda sadece **monitor** çalışır.
//    - Test ortamına bağlı olarak **yalnızca gözlem (monitoring) veya aktif sürüş (driving) seçilebilir.**
//
// 3. **Bağlantı Yönetimi (`connect_phase()`)**
//    - `UVM_ACTIVE` modda çalışırken, **driver ve sequencer birbirine bağlanır.**
//
// 4. **Simülasyon Başlangıcı Bilgilendirme**
//    - `start_of_simulation_phase()` fonksiyonu çalıştığında, hangi **agent'ın aktif olduğu** bilgisi yazdırılır.
//    - Örnek çıktı:
//      ```
//      UVM_INFO @ 0: start of simulation for test_env.agent
//      ```
//
// 5. **UVM Standartlarına Uygunluk**
//    - `uvm_component_utils_begin` ve `uvm_component_utils_end` ile **factory sistemine kaydedilmiştir.**
//    - `is_active` değişkeni kullanılarak **agent'in modu esnek hale getirilmiştir.**
//
// ----------------------------------------------------------------------
// Bu kod, UVM doğrulama ortamında **agent yönetimi** için optimize edilmiştir.
// ----------------------------------------------------------------------
