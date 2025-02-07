// ----------------------------------------------------------------------
// base_test: UVM Test Sınıfı
// Açıklama:
// - `base_test`, UVM doğrulama ortamında temel test yapısını tanımlar.
// - Test sırasında `adder_env` ortamı oluşturulur ve çalıştırılır.
// - `build_phase()`, `end_of_elaboration_phase()`, `start_of_simulation_phase()`
//   ve `check_phase()` gibi fonksiyonları içerir.
// - **Simülasyon başlatıldığında environment (env) oluşturulur ve test çalıştırılır.**
// ----------------------------------------------------------------------

class base_test extends uvm_test;

  // ----------------------------------------------------------------------
  // UVM Component Kayıt Makrosu
  // - `base_test` nesnesini UVM fabrika sistemine kaydeder.
  // - `create()` fonksiyonunun kullanılmasını sağlar.
  // ----------------------------------------------------------------------
  `uvm_component_utils(base_test)

  // ----------------------------------------------------------------------
  // Test İçindeki Bileşenler
  // - `env`: **adder_env**, test ortamını yönetmek için kullanılır.
  // - `adder_env` içinde `adder_agent`, `adder_scoreboard` ve diğer bileşenler bulunur.
  // ----------------------------------------------------------------------
  adder_env env;

  // ----------------------------------------------------------------------
  // Constructor (Yapıcı Fonksiyon)
  // - `base_test` nesnesini başlatır.
  // - `super.new(name, parent);` ile üst sınıf olan `uvm_test`'in yapıcı fonksiyonu çağrılır.
  // ----------------------------------------------------------------------
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  // ----------------------------------------------------------------------
  // build_phase()
  // - Simülasyon başlamadan önce test ortamı bileşenlerini oluşturur ve yapılandırır.
  // - **`uvm_config_int::set(this, "*", "recording_detail", 1);`**
  //   - Simülasyon dalgasının detaylarını kaydetmek için kullanılır.
  // - **Environment (env) dinamik olarak oluşturulur.**
  // - **Sequencer için varsayılan sequence atanır.**
  // ----------------------------------------------------------------------
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    // Dalga kaydı detay seviyesini belirleme
    uvm_config_int::set(this, "*", "recording_detail", 1);

    // Environment (env) nesnesini oluştur
    env = adder_env::type_id::create("env", this);

    // Sequencer'ın `run_phase` aşamasında varsayılan sequence olarak `adder_base_seq` atanır.
    uvm_config_wrapper::set(this, "env.agent.sequencer.run_phase", "default_sequence", adder_base_seq::get_type());
  endfunction : build_phase

  // ----------------------------------------------------------------------
  // end_of_elaboration_phase()
  // - Simülasyonun **oluşturulma (elaboration)** aşamasının sonunda çağrılır.
  // - **Tüm UVM hiyerarşisini yazdırır.**
  // - `uvm_top.print_topology();` komutu ile test ortamının bileşenleri yazdırılır.
  // ----------------------------------------------------------------------
  function void end_of_elaboration_phase(uvm_phase phase);
    uvm_top.print_topology();
  endfunction : end_of_elaboration_phase

  // ----------------------------------------------------------------------
  // start_of_simulation_phase()
  // - Simülasyonun başında çağrılan özel bir UVM fonksiyonudur.
  // - `uvm_info()` mesajı basarak, hangi testin çalıştığını bildirir.
  // - `get_full_name()` ile bileşenin tam yolu yazdırılır.
  // ----------------------------------------------------------------------
  function void start_of_simulation_phase(uvm_phase phase);
    `uvm_info(get_type_name(), {"start of simulation for ", get_full_name()}, UVM_HIGH);
  endfunction : start_of_simulation_phase

  // ----------------------------------------------------------------------
  // check_phase()
  // - Simülasyon sonunda yapılandırma ayarlarını kontrol eder.
  // - `check_config_usage();` fonksiyonu ile tüm konfigürasyon ayarlarının
  //   doğru kullanılıp kullanılmadığını analiz eder.
  // ----------------------------------------------------------------------
  function void check_phase(uvm_phase phase);
    check_config_usage();
    endfunction

endclass : base_test

// ----------------------------------------------------------------------
// KODUN SAĞLADIĞI ÖZELLİKLER
// ----------------------------------------------------------------------
// 1. **Factory Desteği (`create()`)**
//    - `base_test` nesnesi fabrika sisteminde oluşturulabilir.
//    - Örnek:
//      ```systemverilog
//      base_test test;
//      test = base_test::type_id::create("test", parent);
//      ```
//
// 2. **Test Ortamının Oluşturulması (`build_phase()`)**
//    - `adder_env` ortamı oluşturulur ve test bileşenleri başlatılır.
//    - `run_phase` içinde `adder_base_seq` varsayılan sequence olarak atanır.
//
// 3. **Test Ortamının Yazdırılması (`end_of_elaboration_phase()`)**
//    - `uvm_top.print_topology();` ile test ortamı bileşenleri yazdırılır.
//
// 4. **Simülasyon Başlangıcı Bilgilendirme**
//    - `start_of_simulation_phase()` fonksiyonu çalıştığında, hangi **testin aktif olduğu** bilgisi yazdırılır.
//    - Örnek çıktı:
//      ```
//      UVM_INFO @ 0: start of simulation for test_env
//      ```
//
// 5. **Test Yapılandırma Kontrolleri (`check_phase()`)**
//    - `check_config_usage();` ile testin doğru yapılandırıldığı kontrol edilir.
//
// 6. **UVM Standartlarına Uygunluk**
//    - `uvm_component_utils()` kullanılarak **factory sistemine kaydedilmiştir.**
//    - Test ortamı **modüler ve genişletilebilir bir yapıya sahiptir.**
//
// ----------------------------------------------------------------------
// Bu kod, UVM doğrulama ortamında **test yönetimi** için optimize edilmiştir.
// ----------------------------------------------------------------------
