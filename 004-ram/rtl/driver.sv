class driver extends uvm_driver #(packet);
  
  `uvm_component_utils(driver)
  
  virtual interface ram_if vif;
    
  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction
    
  function void connect_phase(uvm_phase phase);
    if(!uvm_config_db#(virtual ram_if)::get(this, "", "vif", vif))
      `uvm_error("NOVIF", {"virtual interface must be set for: ", get_full_name(), ".vif"})
  endfunction
        
      
task run_phase(uvm_phase phase);
    `uvm_info(get_type_name(), "Driver: Starting run_phase", UVM_MEDIUM);
    forever begin
      seq_item_port.get_next_item(req);
      `uvm_info(get_type_name(), $sformatf("Driver: Received transaction - addr: %0d, data: %0d, rw_en: %0d",
                                           req.addr_i, req.data_i, req.rw_en_i), UVM_MEDIUM);
      
      vif.addr_i  <= req.addr_i;
      vif.data_i  <= req.data_i;
      vif.rw_en_i <= req.rw_en_i;

      @(posedge vif.clk);
      `uvm_info(get_type_name(), "Driver: Transaction applied to DUT", UVM_MEDIUM);

      if (!req.rw_en_i) begin
        `uvm_info(get_type_name(), "Driver: Read operation detected, waiting one cycle...", UVM_MEDIUM);
        @(posedge vif.clk); // Okuma işlemi için bir cycle bekle
        `uvm_info(get_type_name(), "Driver: Read operation completed", UVM_MEDIUM);
      end

      req.print();
      seq_item_port.item_done();
    end
endtask


      
endclass