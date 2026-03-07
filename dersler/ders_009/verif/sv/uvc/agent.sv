class agent extends component_base;

  sequencer sq;
  driver drv;
  monitor mn;

  function new(string name, component_base parent= null);
    super.new(name, parent);
    sq  = new("sequencer", this);
    drv = new("driver", this);
    mn  = new("monitor", this);

    drv.sref = sq;
  endfunction

endclass