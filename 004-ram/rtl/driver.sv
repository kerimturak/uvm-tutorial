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
      forever begin
    seq_item_port.get_next_item(req);
    vif.addr_i  <= req.addr_i;
    vif.data_i  <= req.data_i;
    vif.rw_en_i <= req.rw_en_i;
    @(posedge vif.clk);
    req.print();
    seq_item_port.item_done();
      end
  endtask
      
endclass