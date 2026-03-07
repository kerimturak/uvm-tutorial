
typedef enum logic [2:0] {S, M, L} stack_size;

class stack;
// dynamic
  string name;
  rand  int unsigned length;
  rand bit [7:0] data[];
  rand stack_size ssize;

  static bit [7:0] instance_count;

  //constraint d_arr_length {length < 32; length > 1;}
  constraint SIZE_C {
    (ssize == S) -> length inside {[1:3]};
    (ssize == M) -> length inside {[4:7]};
    (ssize == L) -> length inside {[8:12]};
  }

  constraint ORDER_C {
    solve ssize  before length; // önce ssize seç
    solve length before data;   // sonra length, en son data (size)
  }

  function new(string name = "");
    this.name = name;
    instance_count ++;
    $display("Nesne : %0s, number of instance", name, instance_count);
  endfunction

  function void show();
    $display("Handle: %p", this);
    foreach (data[i]) begin
      $display("data[%0d]: %0d", i, data[i]);
    end
  endfunction

  function void post_randomize();
    data = new[length];
    foreach (data[i]) begin
      data[i] = $urandom;
    end
  endfunction

  static function bit [7:0] get_count();
    return instance_count;
  endfunction

endclass



module tb ();

  stack s0;  // class variable (handle) || adresi tutacak
  stack s1;  // class variable (handle) || adresi tutacak
  stack s2;

  initial begin
    s0 = new("ilk_stack0");
    s1 = new("ilk_stack1");
    if (!s0.randomize() with { ssize == L; }) begin
      $fatal(1, "Randomization failed");
    end
    s0.show();
    $display("Number of instance count : %0d", s1.get_count());
    $display("Number of instance count : %0d", stack::get_count());
  end

endmodule
