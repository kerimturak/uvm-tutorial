// sequence'i oluştur ve randomize et

class sequencer extends component_base;

    function new(string name="", component_base parent);
        super.new(name, parent);
    endfunction

    function void get_next_item(output packet pkt);
        pkt = new("sequencer_packet");
        void'(pkt.randomize());
    endfunction
endclass