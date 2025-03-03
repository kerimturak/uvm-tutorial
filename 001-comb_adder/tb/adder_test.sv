class base_test extends uvm_test;

  `uvm_component_utils(base_test)

  adder_env env;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

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