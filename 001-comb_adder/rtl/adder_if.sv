// ----------------------------------------------------------------------
// adder_if: Adder için Interface (Arayüz)
// Açıklama:
// - Bu **interface**, toplama işlemi gerçekleştiren bir tasarım (DUT) ile haberleşmeyi sağlar.
// - **UVM doğrulama ortamında** kullanılmak üzere tanımlanmıştır.
// - **Driver**, **Monitor** ve **Test Bench** gibi bileşenlerin tasarım ile veri alışverişini sağlar.
// - **Virtual Interface (Sanal Arayüz) olarak kullanılır** ve UVM bileşenleri tarafından erişilir.
// ----------------------------------------------------------------------

interface adder_if;
  logic [7:0] num1;  // Toplama işlemi için birinci giriş
  logic [7:0] num2;  // Toplama işlemi için ikinci giriş
  logic [8:0] out;  // Toplama işlemi sonucu
endinterface : adder_if