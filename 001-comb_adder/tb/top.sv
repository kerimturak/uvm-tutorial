// ----------------------------------------------------------------------
// top: Testbench Üst Modülü
// Açıklama:
// - `top` modülü, **UVM doğrulama ortamını başlatan ana modüldür.**
// - `adder_if` interface’ini oluşturur ve tasarım (DUT) ile bağlantısını sağlar.
// - **UVM test ortamını çalıştırır (`run_test();`).**
// - **Dalga kaydını başlatır (`$dumpfile`, `$dumpvars`).**
// ----------------------------------------------------------------------

module top;

  // ----------------------------------------------------------------------
  // UVM Kütüphanelerinin Dahil Edilmesi
  // - `uvm_pkg`, tüm UVM fonksiyonlarını içerir.
  // - `uvm_macros.svh`, UVM makrolarını (`uvm_info`, `uvm_error`, vb.) kullanmak için gereklidir.
  // - `adder_pkg`, doğrulama için gerekli **bileşenleri içeren UVM paketi** içe aktarılır.
  // ----------------------------------------------------------------------
  import uvm_pkg::*;          // UVM paketini içe aktar
  `include "uvm_macros.svh"   // UVM makrolarını içe aktar
  import adder_pkg::*;        // Adder doğrulama bileşenlerini içe aktar

  // ----------------------------------------------------------------------
  // Interface Tanımlaması
  // - `vif` adlı bir **adder_if (sanal arayüz)** nesnesi oluşturulur.
  // - Bu interface, tasarım (DUT) ile testbench bileşenleri arasında veri akışını sağlar.
  // ----------------------------------------------------------------------
  adder_if vif ();

  // ----------------------------------------------------------------------
  // Tasarımın (DUT) Bağlanması
  // - `i_adder`, test edilen **adder modülü (DUT)**'dür.
  // - **DUT giriş ve çıkışları interface ile bağlanır.**
  //   - `num1`, `num2` girişleri interface’in `num1`, `num2` değişkenlerine bağlanır.
  //   - `out` çıkışı interface’in `out` değişkenine bağlanır.
  // ----------------------------------------------------------------------
  adder i_adder (
    .num1 (vif.num1),
    .num2 (vif.num2),
    .out  (vif.out)
  );

  // ----------------------------------------------------------------------
  // UVM Test Ortamının Başlatılması
  // - `uvm_config_db` kullanılarak **sanal arayüz (vif)** UVM test ortamına bağlanır.
  // - `run_test();` fonksiyonu çağrılarak **UVM test başlatılır.**
  // ----------------------------------------------------------------------
  initial begin
    // Virtual interface'in UVM test ortamında kullanılmasını sağla
    uvm_config_db#(virtual adder_if)::set(null, "*", "vif", vif);
    
    // UVM testini başlat
    run_test();
  end

  // ----------------------------------------------------------------------
  // Dalga Dosyasının (VCD) Kaydedilmesi
  // - `$dumpfile("dumb.vcd");` → VCD dosya adı belirlenir.
  // - `$dumpvars;` → **Tüm sinyaller dalga dosyasına kaydedilir.**
  // - Simülasyonun analiz edilebilmesi için **dalga dosyası oluşturulur.**
  // ----------------------------------------------------------------------
  initial begin
    $dumpfile("dumb.vcd");  // Dalga dosyasını belirle
    $dumpvars;              // Tüm sinyalleri kaydet
  end

endmodule : top

// ----------------------------------------------------------------------
// KODUN SAĞLADIĞI ÖZELLİKLER
// ----------------------------------------------------------------------
// 1. **DUT ile Testbench Bağlantısı**
//    - `adder_if vif ();` ile tasarım (DUT) ve test ortamı bağlanır.
//    - **DUT girişleri ve çıkışları interface ile entegre edilir.**
//
// 2. **UVM Test Ortamının Başlatılması**
//    - `uvm_config_db::set(null, "*", "vif", vif);` ile **virtual interface** UVM test ortamına tanıtılır.
//    - `run_test();` fonksiyonu çağrılarak **UVM test başlatılır.**
//
// 3. **Dalga Kaydının Başlatılması**
//    - `$dumpfile("dumb.vcd");` → Simülasyon dalga dosyası oluşturulur.
//    - `$dumpvars;` → Tüm sinyaller VCD dosyasına kaydedilir.
//
// 4. **UVM Standartlarına Uygunluk**
//    - **`uvm_config_db` ile sanal arayüz ayarlanmıştır.**
//    - **Tüm UVM test süreci otomatik olarak başlatılır (`run_test();`).**
//
// ----------------------------------------------------------------------
// Bu kod, UVM doğrulama ortamında **testbench yönetimi** için optimize edilmiştir.
// ----------------------------------------------------------------------
