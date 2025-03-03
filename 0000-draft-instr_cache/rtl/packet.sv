class c2c_packet extends uvm_sequence_item;

    rand icache_req_t cache_req_i;
    icache_res_t cache_res_o;
    bit icache_miss_o;

    function new(input string name = "c2c_packet");
        super.new(name);
    endfunction

    `uvm_object_utils_begin(c2c_packet)
        `uvm_field_int(cache_req_i, UVM_DEFAULT)
    `uvm_object_utils_end
 
endclass

class m2c_packet extends uvm_sequence_item;

    ilowX_req_t lowX_req_o;
    rand ilowX_res_t lowX_res_i;

    function new(input string name = "m2c_packet");
        super.new(name);
    endfunction

    `uvm_object_utils_begin(m2c_packet)
        `uvm_field_int(lowX_res_i, UVM_DEFAULT)
    `uvm_object_utils_end

endclass
