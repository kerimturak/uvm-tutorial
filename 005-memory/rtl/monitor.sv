class monitor extends uvm_monitor;
  
  `uvm_component_utils(monitor)
  
    virtual interface memory_if vif;
    uvm_analysis_port # (packet) mon2sb_port;
	packet received_packet;
  
  function new (string name , uvm_component parent);
    super.new(name, parent);
    mon2sb_port = new("mon2sb_port", this);
    received_packet = new("received_packet");
  endfunction
  
  function void connect_phase(uvm_phase phase);
    if(!uvm_config_db # (virtual memory_if)::get(this, "", "vif", vif))
        `uvm_fatal("NO_VIF",{"virtual interface must be set for: ",get_full_name(),".vif"});
  endfunction
      
  virtual task run_phase(uvm_phase phase);
    forever begin
      @(posedge vif.clk);
      wait(vif.wr_en || vif.rd_en);
        received_packet.addr = vif.addr;
      if(vif.wr_en) begin
        received_packet.wr_en = vif.wr_en;
        received_packet.wdata = vif.wdata;
        received_packet.rd_en = 0;
        @(posedge vif.clk);
      end
      if(vif.rd_en) begin
        received_packet.rd_en = vif.rd_en;
        received_packet.wr_en = 0;
        @(posedge vif.clk);
        @(posedge vif.clk);
        received_packet.rdata = vif.rdata;
      end
	  mon2sb_port.write(received_packet);
      end 
  endtask : run_phase
endclass