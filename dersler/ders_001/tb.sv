
class stack;

  string name;

  rand bit [7:0] data[3:0];

  function new(string name = "");
    this.name = name;
    $display("Nesne : %0s", name);
  endfunction

  function void show();
    $display("Nesne : %0s", this.name);
    $display("Handle: %p", this);
    foreach (data[i]) begin
      $display("data[%0d]: %0d", i, data[i]);
    end
  endfunction
endclass


module tb ();

  stack s;  // class variable (handle) || adresi tutacak

  initial begin
    s = new("ilk_stack");
    s.randomize();
    s.show();
  end

endmodule
