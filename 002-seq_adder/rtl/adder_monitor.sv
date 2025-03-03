class adder_monitor extends uvm_monitor;

  virtual interface adder_if vif;
  `uvm_component_utils(adder_monitor)

  uvm_analysis_port #(adder_packet) adder_send;
  adder_packet packet;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    adder_send = new("adder_send", this);
  endfunction : new

  function void start_of_simulation_phase(uvm_phase phase);
    `uvm_info(get_type_name(), {"start of simulation for ", get_full_name()}, UVM_HIGH)
  endfunction : start_of_simulation_phase

  function void connect_phase(uvm_phase phase);
    if (!uvm_config_db#(virtual adder_if)::get(this, "", "vif", vif))
      `uvm_error("NOVIF", {"virtual interface must be set for: ", get_full_name(), ".vif"})
  endfunction : connect_phase

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    packet = adder_packet::type_id::create("packet");
  endfunction

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