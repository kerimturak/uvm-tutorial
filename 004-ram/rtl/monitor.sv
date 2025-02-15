class monitor extends uvm_monitor;

  `uvm_component_utils(monitor)

  virtual interface ram_if vif;
    
  uvm_analysis_port #(packet) mon_to_sb;
  packet mon_packet;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    mon_to_sb = new("mon_to_sb", this);
  endfunction
    
  function void connect_phase(uvm_phase phase);
    if (!uvm_config_db#(virtual ram_if)::get(this, "", "vif", vif))
    `uvm_error("NOVIF", {"virtual interface must be set for: ", get_full_name(), ".vif"})
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    mon_packet = packet::type_id::create("mon_packet");
  endfunction
    
task run_phase(uvm_phase phase);
    `uvm_info(get_type_name(), "Monitor: Starting run_phase", UVM_MEDIUM);
    forever begin
      @(posedge vif.clk);
      `uvm_info(get_type_name(), "Monitor: Sampling signals from DUT", UVM_MEDIUM);
      
      mon_packet.addr_i  = vif.addr_i;
      mon_packet.data_i  = vif.data_i;
      mon_packet.rw_en_i = vif.rw_en_i;
      mon_packet.data_o  = vif.data_o;

      if (!vif.rw_en_i) begin
        `uvm_info(get_type_name(), "Monitor: Read operation detected, waiting one cycle...", UVM_MEDIUM);
        @(posedge vif.clk); // Okuma işlemi için bir cycle bekle
        mon_packet.data_o = vif.data_o; // Güncellenmiş veriyi al
        `uvm_info(get_type_name(), $sformatf("Monitor: Read completed - addr: %0d, data_o: %0d",
                                             mon_packet.addr_i, mon_packet.data_o), UVM_MEDIUM);
      end else begin
        `uvm_info(get_type_name(), $sformatf("Monitor: Write operation - addr: %0d, data_i: %0d",
                                             mon_packet.addr_i, mon_packet.data_i), UVM_MEDIUM);
      end

      mon_to_sb.write(mon_packet);
      mon_packet.print();
    end
endtask



endclass