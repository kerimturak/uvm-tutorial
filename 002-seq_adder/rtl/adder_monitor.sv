// ----------------------------------------------------------------------
// adder_monitor: UVM Monitor (Gözlemci)
// Açıklama:
// - `adder_monitor`, **adder_if** arayüzünü (interface) sürekli gözlemleyerek veri yakalar.
// - `adder_packet` nesnelerini oluşturur ve bu verileri **analysis port** üzerinden test ortamına iletir.
// - Monitör, **sadece gözlem yapar ve DUT’a herhangi bir veri göndermez**.
// ----------------------------------------------------------------------

class adder_monitor extends uvm_monitor;

  // ----------------------------------------------------------------------
  // Virtual Interface Bağlantısı
  // - `adder_if` sanal arayüzü üzerinden DUT (tasarım) giriş ve çıkışları okunur.
  // - Monitor, interface’i sadece **okur**, herhangi bir veri yazmaz.
  // ----------------------------------------------------------------------
  virtual interface adder_if vif;

  // ----------------------------------------------------------------------
  // `uvm_component_utils(adder_monitor)`
  // - `adder_monitor` nesnesini UVM fabrika sistemine kaydeder.
  // - `create()` fonksiyonunun kullanılmasını sağlar.
  // ----------------------------------------------------------------------
  `uvm_component_utils(adder_monitor)

  // ----------------------------------------------------------------------
  // Analysis Port Tanımlaması
  // - `adder_send`, yakalanan verileri diğer UVM bileşenlerine (örn. scoreboard) iletmek için kullanılır.
  // - `uvm_analysis_port #(adder_packet) adder_send;` ile tanımlanmıştır.
  // ----------------------------------------------------------------------
  uvm_analysis_port #(adder_packet) adder_send;

  // Yakalanan verileri tutacak `adder_packet` nesnesi
  adder_packet packet;

  // ----------------------------------------------------------------------
  // Constructor (Yapıcı Fonksiyon)
  // - `adder_monitor` nesnesini başlatır.
  // - `adder_send` analysis port'unu oluşturur.
  // - `super.new(name, parent);` ile üst sınıfın yapıcı fonksiyonu çağrılır.
  // ----------------------------------------------------------------------
  function new(string name, uvm_component parent);
    super.new(name, parent);
    adder_send = new("adder_send", this);  // Analysis port'unu başlat
  endfunction : new

  // ----------------------------------------------------------------------
  // start_of_simulation_phase()
  // - Simülasyonun başında çağrılan özel bir UVM fonksiyonudur.
  // - `uvm_info()` mesajı basarak, hangi monitor'un çalıştığını bildirir.
  // - `get_full_name()` ile bileşenin tam yolu yazdırılır.
  // ----------------------------------------------------------------------
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
  // build_phase()
  // - UVM yapısının inşası sırasında çağrılır.
  // - `adder_packet` nesnesi oluşturulur.
  // ----------------------------------------------------------------------
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    packet = adder_packet::type_id::create("packet");
  endfunction

  // ----------------------------------------------------------------------
  // run_phase()
  // - Simülasyon boyunca sürekli çalışacak olan ana task’tir.
  // - **Her 10 zaman biriminde** veriyi interface’ten okur.
  // - `adder_packet` nesnesini güncelleyerek **analysis port** üzerinden test ortamına gönderir.
  // - Okunan verileri ekrana yazdırır.
  // - Burada reset'in tamamlanmasının beklenmesi gerekiyor. Çünkü golden model monitor üzerinden
  // gelen verileri scoreboardda değerlendirmeye başlıyor hemen.
  // - Outputun 1 cycle sonra interface'e verilmesinin nedeni de sürülen iki sayının sonucu bir sonraki cycleda çıkar.
  // ----------------------------------------------------------------------
  task run_phase(uvm_phase phase);
    `uvm_info(get_type_name(), "Inside the run_phase", UVM_MEDIUM);
    forever begin
      @(posedge vif.clk);

      // Sanal arayüzden giriş ve çıkış verilerini oku
      packet.num1 = vif.num1;
      packet.num2 = vif.num2;
      @(posedge vif.clk);
      packet.out  = vif.out;
	   @(posedge vif.clk);
      // Yakalanan veriyi analysis port üzerinden diğer bileşenlere gönder
      adder_send.write(packet);

      // Yakalanan veriyi ekrana yazdır
      packet.print();
    end
  endtask : run_phase

endclass : adder_monitor

// ----------------------------------------------------------------------
// KODUN SAĞLADIĞI ÖZELLİKLER
// ----------------------------------------------------------------------
// 1. **Factory Desteği (`create()`)**
//    - `adder_monitor` nesnesi fabrika sisteminde oluşturulabilir.
//    - Örnek:
//      ```systemverilog
//      adder_monitor mon;
//      mon = adder_monitor::type_id::create("mon", parent);
//      ```
//
// 2. **Sanallaştırılmış Arayüz Bağlantısı (`connect_phase()`)**
//    - `adder_if` bağlantısının doğrulandığını kontrol eder.
//    - Eğer bağlantı başarısız olursa, hata mesajı üretir.
//
// 3. **Simülasyon Başlangıcı Bilgilendirme**
//    - `start_of_simulation_phase()` fonksiyonu çalıştığında, hangi **monitor'un aktif olduğu** bilgisi yazdırılır.
//    - Örnek çıktı:
//      ```
//      UVM_INFO @ 0: start of simulation for test_env.monitor
//      ```
//
// 4. **Veri Yakalama ve Analysis Port ile İletme**
//    - `adder_monitor`, **adder_if** arayüzünü sürekli gözlemleyerek giriş-çıkış verilerini okur.
//    - `adder_packet` nesnesini **analysis port üzerinden diğer bileşenlere iletir.**
//
// 5. **Zamanlama Yönetimi ve Veri Yazdırma**
//    - Veriler **10 zaman biriminde bir** okunur ve `packet.print();` ile yazdırılır.
//
// ------------------------------------
