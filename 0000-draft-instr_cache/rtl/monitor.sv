class c2c_monitor extends uvm_monitor;

    `uvm_component_utils(c2c_monitor)

    virtual cache_if vif;
  
  	uvm_analysis_port #(c2c_packet) c2c_mon_to_sb_port;
    c2c_packet packet;

    function new(string name = "c2c_monitor", uvm_component parent = null);
        super.new(name, parent);
        c2c_mon_to_sb_port = new("c2c_mon_to_sb_port", this);
    endfunction

    function void start_of_simulation_phase (uvm_phase phase);
        `uvm_info(get_type_name(), {"start of simulation", get_full_name()},UVM_HIGH);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        packet = c2c_packet::type_id::create("packet");
        if (!uvm_config_db #(virtual cache_if)::get(this, "", "vif", vif)) 
          `uvm_fatal("MONITOR", "Unable to access uvm_config_db to retrieve vif")
        else
          `uvm_info("MONITOR", "Interface connection is successful", UVM_MEDIUM)
    endfunction

    virtual task run_phase(uvm_phase phase);
        forever begin
            @(posedge vif.cache_res_o.valid);
            packet.cache_res_o = vif.cache_res_o;
            c2c_mon_to_sb_port.write(packet);
          `uvm_info(get_type_name(), "Monitor for core:", UVM_MEDIUM);
          packet.print();
        end
    endtask

endclass

class m2c_monitor extends uvm_monitor;

    `uvm_component_utils(m2c_monitor)

    virtual cache_if vif;
  uvm_analysis_port #(m2c_packet) m2c_mon_to_sb_port;
    m2c_packet packet;

    function new(string name = "m2c_monitor", uvm_component parent = null);
        super.new(name, parent);
        m2c_mon_to_sb_port = new("m2c_mon_to_sb_port", this);
    endfunction

    function void start_of_simulation_phase (uvm_phase phase);
        `uvm_info(get_type_name(), {"start of simulation", get_full_name()},UVM_HIGH);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        packet = m2c_packet::type_id::create("packet");
        if (!uvm_config_db #(virtual cache_if)::get(this, "", "vif", vif)) 
            `uvm_fatal("MON", "Unable to access uvm_config_db to retrieve vif")
          else
          `uvm_info("MONITOR", "Interface connection is successful", UVM_MEDIUM)
    endfunction

    virtual task run_phase(uvm_phase phase);
        forever begin
            @(posedge vif.lowX_res_i.valid);
            packet.lowX_res_i = vif.lowX_res_i;
            m2c_mon_to_sb_port.write(packet);
          `uvm_info("M2C_MONITOR", "Monitor for lowx:", UVM_MEDIUM);
          packet.print();
        end
    endtask

endclass
