// ----------------------------------------------------------------------
// adder_monitor: UVM Monitor (Gözlemci)
// Açıklama:
// - `adder_monitor`, **adder_if** arayüzünü (interface) sürekli gözlemleyerek veri yakalar.
// - `adder_packet` nesnelerini oluşturur ve bu verileri **analysis port** üzerinden test ortamına iletir.
// - Monitör, **sadece gözlem yapar ve DUT’a herhangi bir veri göndermez**.
// ----------------------------------------------------------------------

class adder_monitor extends uvm_monitor;

  virtual interface adder_if vif;

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


  function void start_of_simulation_phase(uvm_phase phase);
    `uvm_info(get_type_name(), {"start of simulation for ", get_full_name()}, UVM_HIGH)
  endfunction : start_of_simulation_phase

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

  task run_phase(uvm_phase phase);
    `uvm_info(get_type_name(), "Inside the run_phase", UVM_MEDIUM);
    forever begin
      #10;  // 10 zaman birimi gecikme

      // Sanal arayüzden giriş ve çıkış verilerini oku
      packet.num1 = vif.num1;
      packet.num2 = vif.num2;
      packet.out  = vif.out;

      // Yakalanan veriyi analysis port üzerinden diğer bileşenlere gönder
      adder_send.write(packet);

      // Yakalanan veriyi ekrana yazdır
      packet.print();
    end
  endtask : run_phase

endclass : adder_monitor