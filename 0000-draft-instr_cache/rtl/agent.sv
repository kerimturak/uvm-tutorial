class c2c_agent extends uvm_agent;

    `uvm_component_utils(c2c_agent)

    c2c_sequencer sequencer;
    c2c_driver driver;
    c2c_monitor monitor;

    function new(string name = "c2c_agent", uvm_component parent = null);
        super.new(name, parent);
        monitor = c2c_monitor::type_id::create("monitor",this);
        driver = c2c_driver::type_id::create("driver",this);
        sequencer = c2c_sequencer::type_id::create("sequencer",this);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        driver.seq_item_port.connect(sequencer.seq_item_export);
    endfunction

    function void start_of_simulation_phase (uvm_phase phase);
        `uvm_info(get_type_name(), {"start of simulation", get_full_name()},UVM_HIGH);
    endfunction
endclass

class m2c_agent extends uvm_agent;
    `uvm_component_utils(m2c_agent)

    m2c_sequencer sequencer;
    m2c_driver driver;
    m2c_monitor monitor;

    function new(string name = "m2c_agent", uvm_component parent = null);
        super.new(name, parent);
        monitor = m2c_monitor::type_id::create("monitor",this);
        driver = m2c_driver::type_id::create("driver",this);
        sequencer = m2c_sequencer::type_id::create("sequencer",this);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        driver.seq_item_port.connect(sequencer.seq_item_export);
    endfunction

    function void start_of_simulation_phase (uvm_phase phase);
        `uvm_info(get_type_name(), {"start of simulation", get_full_name()},UVM_HIGH);
    endfunction

endclass
