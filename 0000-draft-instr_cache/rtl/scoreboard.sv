class scoreboard extends uvm_scoreboard;

    `uvm_component_utils(scoreboard)

  uvm_analysis_port #(c2c_packet) c2c_mon_port;
  uvm_analysis_port #(m2c_packet) m2c_mon_port;

    c2c_packet cache_transaction;
    m2c_packet lowX_transaction;

    int cache_count;
    int lowX_count;

    function new(string name = "scoreboard", uvm_component parent = null);
        super.new(name, parent);
        cache_count = 0;
        lowX_count = 0;
        c2c_mon_port = new("c2c_mon_port", this); 
        m2c_mon_port = new("m2c_mon_port", this);   
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        cache_transaction = c2c_packet::type_id::create("cache_transaction");
        lowX_transaction = m2c_packet::type_id::create("lowX_transaction");
    endfunction

    virtual function void write_cache_transaction(c2c_packet tc);
        cache_transaction = tc;
        cache_count++;
        `uvm_info("SCOREBOARD", $sformatf("Received Cache Transaction: req: %0d, res: %0d", tc.cache_req_i, tc.cache_res_o), UVM_HIGH);
        if (tc.icache_miss_o) begin
            `uvm_info("SCOREBOARD", "Cache Miss Detected", UVM_HIGH);
        end else begin
            `uvm_info("SCOREBOARD", "Cache Hit Detected", UVM_HIGH);
        end
    endfunction

    virtual function void write_lowX_transaction(m2c_packet tc);
        lowX_transaction = tc;
        lowX_count++;
        `uvm_info("SCOREBOARD", $sformatf("Received LowX Transaction: req: %0d, res: %0d", tc.lowX_req_o, tc.lowX_res_i), UVM_HIGH);
    endfunction

    virtual function void report_results();
        `uvm_info("SCOREBOARD", $sformatf("Total Cache Transactions: %0d", cache_count), UVM_HIGH);
        `uvm_info("SCOREBOARD", $sformatf("Total LowX Transactions: %0d", lowX_count), UVM_HIGH);
    endfunction

endclass
