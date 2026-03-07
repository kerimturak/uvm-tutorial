// verification component diyebiliriz
class env extends component_base;

  agent ag;

  function new(string name, component_base parent = null);
    super.new(name, parent);
    ag  = new("agent", this);
  endfunction

    function void configure(virtual spmp_stack_if vif);
        ag.drv.vif = vif;
        ag.mn.vif  = vif;
    endfunction

    task run(int runs);
        fork
            ag.mn.run();
        join_none
        ag.drv.run(runs);
    endtask
endclass