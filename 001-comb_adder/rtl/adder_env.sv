// ----------------------------------------------------------------------
// adder_env: UVM Environment (Ortam)
// Açıklama:
// - `adder_env`, **agent (ajan) ve scoreboard (puanlama tahtası)** bileşenlerini içeren
//   üst seviye doğrulama ortamını temsil eder.
// - **Agent**, doğrulama işlemlerini (driver, sequencer, monitor) yönetir.
// - **Scoreboard**, gelen verileri değerlendirerek doğrulama sonuçlarını analiz eder.
// - Bu sınıf, tüm doğrulama bileşenlerinin **inşa edilmesini ve bağlanmasını sağlar.**
// ----------------------------------------------------------------------

class adder_env extends uvm_env;

  // ----------------------------------------------------------------------
  // Environment İçindeki Bileşenler
  // - `agent`: Doğrulama sürecini yöneten UVM bileşeni (driver, monitor, sequencer içerir).
  // - `sb`: Scoreboard bileşeni, test sonuçlarını değerlendirir.
  // ----------------------------------------------------------------------
  adder_agent agent;
  adder_scoreboard sb;

  // ----------------------------------------------------------------------
  // `uvm_component_utils(adder_env)`
  // - `adder_env` nesnesini UVM fabrika sistemine kaydeder.
  // - `create()` fonksiyonunun kullanılmasını sağlar.
  // ----------------------------------------------------------------------
  `uvm_component_utils(adder_env)

  // ----------------------------------------------------------------------
  // Constructor (Yapıcı Fonksiyon)
  // - `adder_env` nesnesini başlatır.
  // - `super.new(name, parent);` ile üst sınıf olan `uvm_env`'in yapıcı fonksiyonu çağrılır.
  // ----------------------------------------------------------------------
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  // ----------------------------------------------------------------------
  // build_phase()
  // - Simülasyon başlamadan önce **bileşenleri oluşturur.**
  // - **Agent ve Scoreboard bileşenleri UVM ortamında dinamik olarak oluşturulur.**
  // ----------------------------------------------------------------------
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    // Agent oluşturuluyor (Driver, Sequencer, Monitor içerir)
    agent = adder_agent::type_id::create("agent", this);

    // Scoreboard oluşturuluyor (Doğrulama sonuçlarını analiz edecek)
    sb = adder_scoreboard::type_id::create("sb", this);
  endfunction : build_phase

  // ----------------------------------------------------------------------
  // connect_phase()
  // - **Agent ve Scoreboard arasındaki bağlantıyı sağlar.**
  // - Monitor tarafından yakalanan veriler **Scoreboard'a gönderilir**.
  // - `agent.monitor.adder_send.connect(sb.adder_mon);` bağlantısı ile
  //   Monitor'den gelen işlemler Scoreboard'a yönlendirilir.
  // ----------------------------------------------------------------------
  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    agent.monitor.adder_send.connect(sb.adder_mon);
  endfunction

  // ----------------------------------------------------------------------
  // start_of_simulation_phase()
  // - Simülasyonun başında çağrılan özel bir UVM fonksiyonudur.
  // - `uvm_info()` mesajı basarak, hangi environment'ın çalıştığını bildirir.
  // - `get_full_name()` ile bileşenin tam yolu yazdırılır.
  // ----------------------------------------------------------------------
  function void start_of_simulation_phase(uvm_phase phase);
    `uvm_info(get_type_name(), {"start of simulation for ", get_full_name()}, UVM_HIGH)
  endfunction : start_of_simulation_phase

endclass : adder_env

// ----------------------------------------------------------------------
// KODUN SAĞLADIĞI ÖZELLİKLER
// ----------------------------------------------------------------------
// 1. **Factory Desteği (`create()`)**
//    - `adder_env` nesnesi fabrika sisteminde oluşturulabilir.
//    - Örnek:
//      ```systemverilog
//      adder_env env;
//      env = adder_env::type_id::create("env", parent);
//      ```
//
// 2. **Bağlantı Yönetimi (`connect_phase()`)**
//    - `agent.monitor.adder_send.connect(sb.adder_mon);` ile **Monitor'den gelen işlemler Scoreboard'a gönderilir.**
//    - **Agent, Scoreboard'a bağlanarak doğrulama sonuçları analiz edilir.**
//
// 3. **Bileşenlerin Dinamik Olarak Oluşturulması (`build_phase()`)**
//    - **Agent ve Scoreboard bileşenleri UVM ortamında dinamik olarak oluşturulur.**
//
// 4. **Simülasyon Başlangıcı Bilgilendirme**
//    - `start_of_simulation_phase()` fonksiyonu çalıştığında, hangi **environment'ın aktif olduğu** bilgisi yazdırılır.
//    - Örnek çıktı:
//      ```
//      UVM_INFO @ 0: start of simulation for test_env
//      ```
//
// 5. **UVM Standartlarına Uygunluk**
//    - `uvm_component_utils()` kullanılarak **factory sistemine kaydedilmiştir.**
//    - **Bileşenler inşa edilir ve bağlanır**, böylece **doğrulama ortamı tamamlanır.**
//
// ----------------------------------------------------------------------
// Bu kod, UVM doğrulama ortamında **environment yönetimi** için optimize edilmiştir.
// ----------------------------------------------------------------------
