// ----------------------------------------------------------------------
// adder_scoreboard: UVM Scoreboard (Puanlama Tahtası)
// Açıklama:
// - `adder_scoreboard`, test edilen işlemleri doğrulayan bir bileşendir.
// - `adder_packet` nesnelerini alır ve doğruluğunu kontrol eder.
// - `write()` fonksiyonu aracılığıyla gelen işlemleri alır.
// - `report_results()` fonksiyonu ile işlem sonuçlarını değerlendirir.
// ----------------------------------------------------------------------

class adder_scoreboard extends uvm_scoreboard;

  // ----------------------------------------------------------------------
  // UVM Component Kayıt Makrosu
  // - `adder_scoreboard` nesnesini UVM fabrika sistemine kaydeder.
  // - `create()` fonksiyonunun kullanılmasını sağlar.
  // ----------------------------------------------------------------------
  `uvm_component_utils(adder_scoreboard)

  // ----------------------------------------------------------------------
  // Analysis Port Tanımlaması
  // - `adder_mon`, `uvm_analysis_imp` yapısını kullanarak monitor'den gelen verileri alır.
  // - Monitor tarafından gönderilen `adder_packet` nesneleri burada işlenir.
  // ----------------------------------------------------------------------
  uvm_analysis_imp #(adder_packet, adder_scoreboard) adder_mon;

  // Gelen işlemi saklamak için `adder_packet` nesnesi
  adder_packet adder_transaction;

  // Test edilen işlemlerin sayısını tutan sayaç
  int adder_count;

  // ----------------------------------------------------------------------
  // Constructor (Yapıcı Fonksiyon)
  // - `adder_scoreboard` nesnesini başlatır.
  // - `adder_mon` analysis port'unu oluşturur.
  // - `adder_count` sayacı sıfır olarak başlatılır.
  // ----------------------------------------------------------------------
  function new(string name = "adder_scoreboard", uvm_component parent = null);
    super.new(name, parent);
    adder_count = 0;
    adder_mon = new("adder_mon", this); // Analysis port başlatılıyor
  endfunction

  // ----------------------------------------------------------------------
  // build_phase()
  // - Simülasyon başlamadan önce bileşenleri oluşturur.
  // - `adder_transaction`, `adder_packet` nesnesi olarak başlatılır.
  // ----------------------------------------------------------------------
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

// ----------------------------------------------------------------------
// KODUN SAĞLADIĞI ÖZELLİKLER
// ----------------------------------------------------------------------
// 1. **Factory Desteği (`create()`)**
//    - `adder_scoreboard` nesnesi fabrika sisteminde oluşturulabilir.
//    - Örnek:
//      ```systemverilog
//      adder_scoreboard sb;
//      sb = adder_scoreboard::type_id::create("sb", parent);
//      ```
//
// 2. **Monitor ile Bağlantı**
//    - `uvm_analysis_imp` kullanılarak **monitor'den gelen işlemler alınır.**
//
// 3. **Test Sonuçlarını Değerlendirme**
//    - **write()** fonksiyonu ile işlemler alınır ve sayaç artırılır.
//    - **report_results()** fonksiyonu ile testin doğruluğu kontrol edilir.
//
// 4. **Hata ve Bilgilendirme Mesajları**
//    - **Doğru sonuçlar için `uvm_info()` mesajı verilir.**
//    - **Yanlış sonuçlar için `uvm_error()` mesajı üretilir.**
//
// 5. **Sayaç ile Test Takibi**
//    - `adder_count` ile kaç adet işlem test edildiği takip edilir.
//
// ----------------------------------------------------------------------
// Bu kod, UVM doğrulama ortamında **scoreboard yönetimi** için optimize edilmiştir.
// ----------------------------------------------------------------------
