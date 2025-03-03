class adder_driver extends uvm_driver #(adder_packet);

  virtual interface adder_if vif;

  `uvm_component_utils(adder_driver)

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  function void start_of_simulation_phase(uvm_phase phase);
    `uvm_info(get_type_name(), {"start of simulation for ", get_full_name()}, UVM_HIGH)
  endfunction : start_of_simulation_phase

  function void connect_phase(uvm_phase phase);
    if (!uvm_config_db#(virtual adder_if)::get(this, "", "vif", vif))
      `uvm_error("NOVIF", {"virtual interface must be set for: ", get_full_name(), ".vif"})
  endfunction : connect_phase

  task run_phase(uvm_phase phase);
    forever begin
      // Sequence'den yeni istek al
      seq_item_port.get_next_item(req);

      // Veriyi fiziksel interface’e (DUT girişlerine) aktar
      @(posedge vif.clk);
      vif.num1 <= req.num1;
      vif.num2 <= req.num2;

      // İşlem tamamlandığında bilgi mesajı bas
      `uvm_info(get_type_name(), "Adder response received", UVM_LOW);

      // İşlemin tamamlanmasını beklemek için 10 zaman birimi bekle
       @(posedge vif.clk);
		req.out <= vif.out;
      // Gelen işlemi ekrana yazdır
      req.print();
	  @(posedge vif.clk)
      // İşlemin tamamlandığını bildirmek için item_done() çağrılır
      seq_item_port.item_done();
    end
  endtask : run_phase

endclass : adder_driver