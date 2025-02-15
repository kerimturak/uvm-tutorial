class c2c_driver extends uvm_driver #(c2c_packet);

    `uvm_component_utils(c2c_driver)

    c2c_packet packet;
    virtual cache_if vif;

    function new(string name = "c2c_driver", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    function void start_of_simulation_phase (uvm_phase phase);
        `uvm_info(get_type_name(), {"start of simulation", get_full_name()},UVM_HIGH);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        packet = c2c_packet::type_id::create("packet");
        if (!uvm_config_db #(virtual cache_if)::get(this, "", "vif", vif))
          `uvm_fatal("C2C_DRIVER", "Unable to access uvm_config_db to retrieve vif")
        else
          `uvm_info("C2C_DRIVER", "Interface connection is successful", UVM_MEDIUM)
    endfunction

    virtual task run_phase(uvm_phase phase);
        forever begin
            seq_item_port.get_next_item(packet);
            vif.cache_req_i <= packet.cache_req_i;
          `uvm_info("C2C_DRIVER", "Driving sequence from core:", UVM_MEDIUM);
          @(posedge vif.clk_i);
          packet.print();
          seq_item_port.item_done(); 
        end
    endtask

endclass

class m2c_driver extends uvm_driver #(m2c_packet);

    `uvm_component_utils(m2c_driver)

    m2c_packet packet;
    virtual cache_if vif;

    function new(string name = "m2c_driver", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    function void start_of_simulation_phase(uvm_phase phase);
        `uvm_info(get_type_name(), {"start of simulation", get_full_name()},UVM_HIGH);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        packet = m2c_packet::type_id::create("packet");
        if (!uvm_config_db #(virtual cache_if)::get(this, "", "vif", vif))
          `uvm_fatal("M2C_DRIVER", "Unable to access uvm_config_db to retrieve vif")
      else
          `uvm_info("M2C_DRIVER", "Interface connection is successful", UVM_MEDIUM)
    endfunction

    virtual task run_phase(uvm_phase phase);
        forever begin
            seq_item_port.get_next_item(packet);
            vif.lowX_res_i <= packet.lowX_res_i;
          `uvm_info("M2C_DRIVER", "Driving sequence from lowx:", UVM_MEDIUM);
          @(posedge vif.clk_i);
          packet.print();
            seq_item_port.item_done();
        end
    endtask
endclass
