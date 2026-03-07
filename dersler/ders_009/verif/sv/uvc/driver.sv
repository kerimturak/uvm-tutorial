// packet leri sinyal transitionlarına çevir
// interface üzerinden sür
class driver extends component_base;
    // class direkt olarak interface'e bağlı olmamalı 
    virtual spmp_stack_if vif;

    sequencer sref;
    packet pkt;

    function new(string name  = "", component_base parent = null);
        super.new(name, parent);
    endfunction

    task run(int runs);
        repeat (runs) begin
            sref.get_next_item(pkt);
            @(posedge vif.clk);
            vif.push_req  <= pkt.push_req;
            vif.push_data <= pkt.push_data;
        end
    endtask
endclass