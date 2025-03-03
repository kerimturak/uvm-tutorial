class driver extends uvm_driver #(packet);

  `uvm_component_utils(driver)

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual interface uart_if vif;
  // uvm_analysis_port #(packet) driver2scoreboard_port;
  //Also note that the name of uvm_top is set to empty string "" so that it doesn't appear in the full
  // hierarchical name of child components. Another common usage is while setting or getting an object
  // in configuration database using uvm_config_db.

  function void connect_phase(uvm_phase phase);
    if (!uvm_config_db#(virtual uart_if)::get(this, "", "vif", vif)) `uvm_fatal("NO_VIF", {"virtual interface must be set for: ", get_full_name(), ".vif"});
  endfunction

  virtual task run_phase(uvm_phase phase);
    forever begin
      seq_item_port.get_next_item(req);
      drive();
      seq_item_port.item_done();
    end
  endtask : run_phase

  virtual task drive();
    vif.button_data <= '0;
    vif.tx_en       <= '0;
    vif.rx_en       <= '0;
    vif.tx_we       <= '0;
    vif.rx_re       <= '0;
    @(posedge vif.clk);
    vif.button_data <= req.button_data;
    vif.tx_en       <= req.tx_en      ;
    vif.rx_en       <= req.rx_en      ;
    vif.tx_we       <= req.tx_we      ;
    vif.rx_re       <= req.rx_re      ;
  endtask : drive

endclass
