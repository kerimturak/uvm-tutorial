// sinyal değişimlerini yakala ve datayı yeniden kur
class monitor extends component_base;
    // class direkt olarak interface'e bağlı olmamalı 
    virtual spmp_stack_if vif;

    packet pkt;

    function new(string name  = "", component_base parent = null);
        super.new(name, parent);
    endfunction

    task run();
        forever begin
            @(posedge vif.clk);
            pkt = new();
            pkt.push_req  = vif.push_req;
            pkt.push_data = vif.push_data;
            pkt.print();
        end
    endtask
endclass