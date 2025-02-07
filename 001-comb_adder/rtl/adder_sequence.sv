// ----------------------------------------------------------------------
// adder_base_seq: UVM Sequence (İşlem Sırası)
// Açıklama:
// - Bu sınıf, UVM ortamında çalışan bir **sequence** (işlem sırası) tanımlar.
// - `adder_packet` nesnelerinin gönderilmesini sağlar.
// - `pre_body()` ve `post_body()` metodları ile **objection** mekanizmasını kullanarak
//   testin bitişini kontrol eder.
// - `body()` fonksiyonu içinde 5 defa rastgele `adder_packet` nesnesi üretilir ve gönderilir.
// ----------------------------------------------------------------------

class adder_base_seq extends uvm_sequence #(adder_packet);

  // ----------------------------------------------------------------------
  // `uvm_object_utils(adder_base_seq)`
  // - UVM fabrika sistemine `adder_base_seq` nesnesini kaydeder.
  // - `create()` fonksiyonunun kullanılmasını sağlar.
  // - `print()`, `clone()`, `compare()`, `record()` gibi fonksiyonları destekler.
  // ----------------------------------------------------------------------
  `uvm_object_utils(adder_base_seq)  // sequences automation

  // ----------------------------------------------------------------------
  // Constructor (Yapıcı Fonksiyon)
  // - `adder_base_seq` nesnesini başlatır.
  // - Varsayılan olarak `"adder_base_seq"` ismini kullanır.
  // - `super.new(name);` ile üst sınıf olan `uvm_sequence`'in yapıcı fonksiyonu çağrılır.
  // ----------------------------------------------------------------------
  function new(string name = "adder_base_seq");
    super.new(name);
  endfunction

  // ----------------------------------------------------------------------
  // pre_body() - Test başlamadan önce çağrılan metod
  // - Objection mekanizmasını kullanarak testin erken bitmesini engeller.
  // - `get_starting_phase()` ile çalıştırıldığı UVM fazını alır.
  // - `raise_objection()` ile testin hala çalıştığını bildirir.
  // ----------------------------------------------------------------------
  task pre_body();
    uvm_phase phase;
    // UVM 1.2 ile gelen get_starting_phase() metodu kullanılarak test fazı alınır
    phase = get_starting_phase();
    if (phase != null) begin
      phase.raise_objection(this, get_type_name()); // Testin hala devam ettiğini bildir
      `uvm_info(get_type_name(), "raise objection", UVM_MEDIUM) // Bilgi mesajı bas
    end
  endtask : pre_body

  // ----------------------------------------------------------------------
  // body() - Asıl işlem sırası burada çalıştırılır
  // - `uvm_info()` kullanarak bilgi mesajı basar.
  // - 5 kez `adder_packet` nesnesi oluşturur ve gönderir.
  // - `repeat (5) `uvm_do(req);` ile 5 kez işlem yapılmasını sağlar.
  // ----------------------------------------------------------------------
  virtual task body();
    `uvm_info(get_type_name(), "Executing adder_packets sequence", UVM_LOW)
    repeat (5) `uvm_do(req)  // Rastgele 5 adet `adder_packet` oluştur ve gönder
  endtask

  // ----------------------------------------------------------------------
  // post_body() - Test bittikten sonra çağrılan metod
  // - Objection mekanizmasını kullanarak testin bitmesine izin verir.
  // - `drop_objection()` ile testin tamamlandığını bildirir.
  // ----------------------------------------------------------------------
  task post_body();
    uvm_phase phase;
    // UVM 1.2 ile gelen get_starting_phase() metodu kullanılarak test fazı alınır
    phase = get_starting_phase();
    if (phase != null) begin
      phase.drop_objection(this, get_type_name()); // Testin tamamlandığını bildir
      `uvm_info(get_type_name(), "drop objection", UVM_MEDIUM) // Bilgi mesajı bas
    end
  endtask : post_body

endclass : adder_base_seq

// ----------------------------------------------------------------------
// KODUN SAĞLADIĞI ÖZELLİKLER
// ----------------------------------------------------------------------
// 1. **Factory Desteği (`create()`)**
//    - `adder_base_seq` nesnesi fabrika sisteminde oluşturulabilir.
//    - Örnek:
//      ```systemverilog
//      adder_base_seq seq;
//      seq = adder_base_seq::type_id::create("seq");
//      ```
//
// 2. **Veri Gönderme (`body()`)**
//    - `adder_packet` nesnelerini `uvm_do(req)` ile gönderir.
//    - `repeat (5)` ifadesiyle **5 kez çalıştırılır.**
//
// 3. **Objection Mekanizması (`pre_body()` ve `post_body()`)**
//    - `raise_objection()` ile testin erken bitmesini engeller.
//    - `drop_objection()` ile testin tamamlandığını bildirir.
//
// 4. **Bilgi Mesajları (`uvm_info()`)**
//    - Test sürecini takip etmek için **bilgi mesajları basılır.**
//    - `pre_body()` içinde `"raise objection"` mesajı yazdırılır.
//    - `body()` içinde `"Executing adder_packets sequence"` mesajı yazdırılır.
//    - `post_body()` içinde `"drop objection"` mesajı yazdırılır.
//
// ----------------------------------------------------------------------
// Bu kod, UVM doğrulama ortamında **sequence yönetimi** ve **objection kontrolü**
// sağlamak için optimize edilmiştir.
// ----------------------------------------------------------------------
