class monitor extends uvm_monitor;

  `uvm_component_utils(monitor)

  virtual interface uart_if vif;
  uvm_analysis_port #(packet) mon2sb_port;
  packet received_packet;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    mon2sb_port = new("mon2sb_port", this);
    received_packet = new("received_packet");
  endfunction

  function void connect_phase(uvm_phase phase);
    if (!uvm_config_db#(virtual uart_if)::get(this, "", "vif", vif)) `uvm_fatal("NO_VIF", {"virtual interface must be set for: ", get_full_name(), ".vif"});
  endfunction

  virtual task run_phase(uvm_phase phase);
    forever begin
      wait (vif.tx_en || vif.rx_en || vif.tx_we || vif.rx_re);
      received_packet.led_data = vif.led_data;
      @(posedge vif.clk);
      mon2sb_port.write(received_packet);
    end
  endtask : run_phase

endclass