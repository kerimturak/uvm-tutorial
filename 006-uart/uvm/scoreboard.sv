class scoreboard extends uvm_scoreboard;

  `uvm_component_utils(scoreboard)

  uvm_analysis_imp #(packet, scoreboard) mon2sb_export;
  packet pkt_qu[$];
  bit [7:0] sc_mem[4];

  // new - constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    mon2sb_export = new("mon2sb_export", this);
  endfunction

  virtual function void write(packet pkt);
    //pkt.print();
    pkt_qu.push_back(pkt);
  endfunction : write

  virtual task run_phase(uvm_phase phase);
    packet mem_pkt;

    forever begin
      wait (pkt_qu.size() > 0);
      mem_pkt = pkt_qu.pop_front();

      if (mem_pkt.tx_we_i) begin
       
      end
    end
  endtask : run_phase

endclass
