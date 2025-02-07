// ----------------------------------------------------------------------
// adder_if: Adder için Interface (Arayüz)
// Açıklama:
// - Bu **interface**, toplama işlemi gerçekleştiren bir tasarım (DUT) ile haberleşmeyi sağlar.
// - **UVM doğrulama ortamında** kullanılmak üzere tanımlanmıştır.
// - **Driver**, **Monitor** ve **Test Bench** gibi bileşenlerin tasarım ile veri alışverişini sağlar.
// - **Virtual Interface (Sanal Arayüz) olarak kullanılır** ve UVM bileşenleri tarafından erişilir.
// ----------------------------------------------------------------------

interface adder_if;

  // ----------------------------------------------------------------------
  // Giriş Sinyalleri
  // - `num1` ve `num2`, toplama işlemi için kullanılan **8-bit girişlerdir.**
  // ----------------------------------------------------------------------
  logic [7:0] num1;  // Toplama işlemi için birinci giriş
  logic [7:0] num2;  // Toplama işlemi için ikinci giriş

  // ----------------------------------------------------------------------
  // Çıkış Sinyali
  // - `out`, toplama işleminin sonucunu döndürür.
  // - **8-bit iki sayının toplamı en fazla 9-bit olabilir**, bu yüzden `out` **9-bit olarak tanımlanmıştır.**
  // ----------------------------------------------------------------------
  logic [8:0] out;  // Toplama işlemi sonucu

endinterface : adder_if

// ----------------------------------------------------------------------
// KODUN SAĞLADIĞI ÖZELLİKLER
// ----------------------------------------------------------------------
// 1. **DUT ile Bağlantı Sağlama**
//    - `adder_if`, **toplama işlemi yapan devreye (DUT) giriş/çıkış sağlamak için kullanılır.**
//
// 2. **UVM ile Uyumlu Kullanım**
//    - **Driver**, **Monitor** ve diğer doğrulama bileşenleri `adder_if` kullanarak verileri okur ve yazar.
//    - **Virtual Interface (Sanal Arayüz) olarak kullanılır.**
//
// 3. **Test Bench Entegrasyonu**
//    - **`adder_if`**, UVM test ortamında bir **config_db** üzerinden driver ve monitor'a bağlanabilir:
//      ```systemverilog
//      uvm_config_db#(virtual adder_if)::set(this, "", "vif", vif);
//      ```
//
// 4. **Fiziksel Bağlantı Geliştirme**
//    - **Bu interface, testbench'teki fiziksel bağlantılar ile tasarım arasındaki veri transferini düzenler.**
//    - **Driver** tarafından yazılır ve **Monitor** tarafından okunur.
//
// ----------------------------------------------------------------------
// Bu kod, UVM doğrulama ortamında **interface yönetimi** için optimize edilmiştir.
// ----------------------------------------------------------------------
