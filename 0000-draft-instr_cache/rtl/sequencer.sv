class c2c_sequencer extends uvm_sequencer #(c2c_packet);

    `uvm_component_utils(c2c_sequencer)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void start_of_simulation_phase (uvm_phase phase);
        `uvm_info(get_type_name(), {"start of simulation", get_full_name()},UVM_HIGH);
    endfunction

endclass

class m2c_sequencer extends uvm_sequencer #(m2c_packet);

    `uvm_component_utils(m2c_sequencer)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void start_of_simulation_phase (uvm_phase phase);
        `uvm_info(get_type_name(), {"start of simulation", get_full_name()},UVM_HIGH);
    endfunction

endclass
