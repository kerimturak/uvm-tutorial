class driver extends uvm_driver #(packet);
  
  `uvm_component_utils(driver)
 
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
  
  virtual interface memory_if vif;
   // uvm_analysis_port #(packet) driver2scoreboard_port;

//Also note that the name of uvm_top is set to empty string "" so that it doesn't appear in the full hierarchical name of child components. Another common usage is while setting or getting an object in configuration database using uvm_config_db.
  function void connect_phase(uvm_phase phase);
    if(!uvm_config_db # (virtual memory_if)::get(this, "", "vif", vif))
        `uvm_fatal("NO_VIF",{"virtual interface must be set for: ",get_full_name(),".vif"});
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    forever begin
      seq_item_port.get_next_item(req);
      drive();
      seq_item_port.item_done();
    end
  endtask : run_phase
  
  virtual task drive();
    vif.wr_en <= 0;
    vif.rd_en <= 0;
    @(posedge vif.clk);
    vif.addr <= req.addr;
    if(req.wr_en) begin // write operation
      vif.wr_en <= req.wr_en;
      vif.wdata <= req.wdata;
      @(posedge vif.clk);
    end
    else if(req.rd_en) begin //read operation
      vif.rd_en <= req.rd_en;
      @(posedge vif.clk);
      vif.rd_en <= 0;
      @(posedge vif.clk);
      req.rdata = vif.rdata;
    end
    
  endtask : drive

endclass