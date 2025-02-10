class scoreboard extends uvm_scoreboard;
  `uvm_component_utils(scoreboard)
  
  uvm_analysis_imp #(packet, scoreboard) monitor_port;
  
  packet trans[3:0];
  int idx;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    monitor_port = new("monitor_port", this); // Analysis port başlatılıyor
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    trans[0] =   packet::type_id::create("trans0");
    trans[1] =   packet::type_id::create("trans1");
    trans[2] =   packet::type_id::create("trans2");
    trans[3] =   packet::type_id::create("trans3");
  endfunction
  

  
  virtual function write(packet item);
    if (item.rw_en_i) begin
      trans[item.addr_i] = item;
      idx++;
    end else begin
      if (trans[item.addr_i].data_i == item.data_o) begin 
        $display("pass");
      end else begin
        $display("fail");
      end
      idx--;
    end
  endfunction
  
  

endclass