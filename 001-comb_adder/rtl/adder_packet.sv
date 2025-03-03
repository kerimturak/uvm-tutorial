// ----------------------------------------------------------------------
// adder_packet: UVM Sequence Item (Veri İşlem Nesnesi)
// Açıklama:
// - Bu sınıf, bir toplama işlemini temsil eden veri paketidir.
// - UVM doğrulama ortamında transaction (işlem) nesnesi olarak kullanılır.
// - Rastgele üretilebilen iki giriş değeri (num1 ve num2) içerir ve sonucu (out) hesaplar.
// - UVM Utility ve Field makroları kullanılarak, nesnenin otomatik yönetilmesi sağlanmıştır.
// ----------------------------------------------------------------------

class adder_packet extends uvm_sequence_item;

  // Rastgele atanabilir 8-bit genişliğinde iki operand (toplama işlemi için)
  rand bit [7:0] num1;
  rand bit [7:0] num2;

  // Toplama işlemi sonucu (8-bit iki sayının toplamı en fazla 9-bit olabilir)
  bit [8:0] out;

  // ----------------------------------------------------------------------
  // Constructor (Yapıcı Fonksiyon)
  // - Nesne oluşturulduğunda otomatik olarak çağrılır.
  // - Varsayılan olarak "adder_packet" ismi atanır.
  // - uvm_sequence_item dan türeilen sınıflar içinVarsayılan isim ataması zorunludur.
  // - super.new(name) ile üst sınıf olan uvm_sequence_item yapıcı fonksiyonu çağrılır.
  // ----------------------------------------------------------------------
  function new(input string name = "adder_packet");
    super.new(name);
  endfunction

  // ----------------------------------------------------------------------
  // `uvm_object_utils(adder_packet)
  // - UVM fabrika sistemine (Factory) nesneyi kaydeder.
  // - uvm_object'ten türetilmiş her sınıfın kaydedilmesi gerekir.
  // - get_type(), get_type_name()`create()` fonksiyonlarını tanımlar ve  create nesne oluşturulabilir.
  // - `adder_packet::type_id::create("pkt")` ile nesne dinamik olarak üretilebilir.
  // ----------------------------------------------------------------------
  `uvm_object_utils_begin(adder_packet)

    // ----------------------------------------------------------------------
    // - Class property (değişkenleri) için otomasyonu aktif etmek için kullanılır
    // `uvm_field_int(num1, UVM_DEFAULT)`
    // - num1 değişkenini UVM nesne yönetimine ekler.
    // - Otomatik olarak `print()`, `compare()`, `record()`, `randomize()` fonksiyonları ile uyumlu hale getirir.
    // - `UVM_DEFAULT` bayrağı, tüm temel işlemleri etkinleştirir.
    // - Alternatif olarak `UVM_NOCOMPARE`, `UVM_NOPRINT` gibi bayraklarla belirli özellikler kapatılabilir.
    // ----------------------------------------------------------------------
    `uvm_field_int(num1, UVM_DEFAULT)
    `uvm_field_int(num2, UVM_DEFAULT)

  `uvm_object_utils_end

endclass : adder_packet

// ----------------------------------------------------------------------
// KODUN SAĞLADIĞI ÖZELLİKLER
// ----------------------------------------------------------------------
// 1. **Factory Desteği (`create()`)**
//    - `adder_packet` nesnesi fabrika sisteminde oluşturulabilir.
//    - Örnek:
//      ```systemverilog
//      adder_packet pkt;
//      pkt = adder_packet::type_id::create("pkt");
//      ```
//
// 2. **Veri Yazdırma (`print()`)**
//    - Tüm değişkenleri yazdırabilir.
//    - Örnek:
//      ```systemverilog
//      pkt.print();
//      ```
//    - Çıktı:
//      ```
//      UVM_INFO @ 0: adder_packet
//        num1 = 'hA2
//        num2 = 'h3F
//      ```
//
// 3. **Nesne Karşılaştırma (`compare()`)**
//    - İki `adder_packet` nesnesini karşılaştırabilir.
//    - Örnek:
//      ```systemverilog
//      adder_packet pkt1, pkt2;
//      pkt1 = adder_packet::type_id::create("pkt1");
//      pkt2 = adder_packet::type_id::create("pkt2");
//
//      if(pkt1.compare(pkt2))
//        `uvm_info("TEST", "Paketler aynı!", UVM_MEDIUM)
//      else
//        `uvm_info("TEST", "Paketler farklı!", UVM_MEDIUM)
//      ```
//
// 4. **Rastgele Üretme (`randomize()`)**
//    - Rastgele num1 ve num2 değerleri oluşturabilir.
//    - Örnek:
//      ```systemverilog
//      pkt.randomize();
//      ```
//
// 5. **Dalga Kaydı (`record()`)**
//    - Verileri simülasyon dalgasına kaydedebilir.
//    - Örnek:
//      ```systemverilog
//      pkt.record();
//      ```
//
// 6. **Alternatif UVM Field Bayrakları:**
//    - `UVM_DEFAULT` → **Tüm işlemleri etkinleştirir.**
//    - `UVM_NOCOMPARE` → **Karşılaştırmayı devre dışı bırakır.**
//    - `UVM_NOPRINT` → **Yazdırmayı devre dışı bırakır.**
//    - `UVM_NORECORD` → **Dalga kaydını devre dışı bırakır.**
//
// ----------------------------------------------------------------------
// Bu kod, UVM testbençlerinde veri işlemlerini ve doğrulama süreçlerini
// hızlandırmak için optimize edilmiştir.
//
// ----------------------------------------------------------------------
// Other Field Macros
// `uvm_field_int( <field_name>, <flags> ) // integral types
// `uvm_field_object( <field_name>, <flags> ) // class handles
// `uvm_field_string( <field_name>, <flags> ) // strings
// `uvm_field_event( <field_name>, <flags> ) // events
// `uvm_field_real( <field_name>, <flags> ) // reals
// `uvm_field_enum( <enum_type>, <field_name>, <flags>) // enums
//
// `uvm_field_array_int() - unpacked 1-D dynamic arrays
// `uvm_field_sarray_int() - unpacked 1-D static arrays
// `uvm_field_queue_int() - queues
// `uvm_field_aa_<d_type>_<ix_type> - associative arrays