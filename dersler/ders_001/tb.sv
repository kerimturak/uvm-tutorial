class stack;

  local string name;
  rand int unsigned length;

  bit [7:0] data[];
  bit [3:0] sp;

  //constraint c_len {length inside {[1 : 32]};}  // örnek sınır

  function new(string name = "null");
    this.name = name;
    $display("name:%0s", this.name);
    $display("New object is created");
  endfunction

  function void post_randomize();
    data = new[length];
    foreach (data[i]) begin
      data[i] = $urandom_range(0, 255);
      $display("data[%0d] : %00d", i, data[i]);
    end
  endfunction

endclass





module tb ();

  stack s;  // handle (class variable)
  /*
  handle : stack[address] ->  memory []
  */

  initial begin
    s = new("benim");  // constructor ile memory build ettim.
    s.randomize() with {length == 12;};
    s.randomize() with {
      length < 12;
      length > 5;
    };
  end
endmodule
