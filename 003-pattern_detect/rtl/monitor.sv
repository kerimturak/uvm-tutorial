class monitor extends uvm_monitor;
  `uvm_component_utils(monitor)

  packet mon_pattern;

  virtual interface pattern_if vif;

  uvm_analysis_port #(packet) mon_to_sb;
  packet pattern;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    mon_to_sb = new("mon_to_sb", this);
  endfunction

  function void connect_phase(uvm_phase phase);
    if (!uvm_config_db#(virtual pattern_if)::get(this, "", "vif", vif)) `uvm_error("NOVIF", {"virtual interface must be set for: ", get_full_name(), ".vif"})
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    mon_pattern = packet::type_id::create("mon_pattern");
  endfunction

  task run_phase(uvm_phase phase);
    `uvm_info(get_type_name(), "Inside the run_phase", UVM_MEDIUM);
    forever begin
      @(posedge vif.clk);
      mon_pattern.data = vif.data;
      mon_pattern.out  = vif.out;
      mon_to_sb.write(mon_pattern);
      mon_pattern.print();
    end
  endtask : run_phase

endclass
