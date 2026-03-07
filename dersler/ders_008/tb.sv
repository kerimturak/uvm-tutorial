
/*
agent ("agent")
   |
   |---- sequencer ("sequencer")
   |
   |---- driver ("driver")
   |
   |---- monitor ("monitor")
   */

// Component’ler birbirine handle (referans) vererek iletişim kurabilir.
class component_base;
  
  string name;
  component_base parent;

  function new(string name  = "", component_base parent);
    this.name = name;
    this.parent = parent;
  endfunction

/*
tree traversal

parent chain traversal
*/
  function string pathname();

    component_base ptr = this;

    pathname = name;

    while (ptr.parent != null) begin
      ptr = ptr.parent;
      pathname = {ptr.name, ".", pathname};
    end

  endfunction
endclass

class sequencer extends component_base;
  //string name;
  //agent parent;

  function new(string name  = "", component_base parent);
    //this.name = name;
    //this.parent = parent;
    super.new(name, parent);
  endfunction

  function void get_next_item();
    $display("Driver sequencer'a erişti");
  endfunction
endclass

class driver extends component_base;

  sequencer sref;

  function new(string name  = "", component_base parent);
    super.new(name, parent);
  endfunction

endclass

class monitor extends component_base;
  function new(string name  = "", component_base parent);
    super.new(name, parent);
  endfunction

endclass


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



module tb;
  agent ag;

  initial begin
    ag = new("agent");
    $display(ag.sq.pathname());
    $display(ag.drv.pathname());
    $display(ag.mn.pathname());
  end
endmodule

// Her component kendi instance name’ini ve parent pointer’ını tutar. Bu sayede component kendi hiyerarşik path’ini oluşturabilir.

/*

name
parent
pathname()

*/