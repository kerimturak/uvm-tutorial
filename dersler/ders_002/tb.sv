
typedef enum logic [2:0] {S, M, L} stack_size;

class stack;

  string name;

  rand  int unsigned length;
  rand bit [7:0] data[];
  rand stack_size ssize;

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
    $display("Nesne : %0s", name);
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
endclass


module tb ();

  stack s;  // class variable (handle) || adresi tutacak

initial begin
  s = new("ilk_stack");
  if (!s.randomize() with { ssize == L; }) begin
    $fatal(1, "Randomization failed");
  end
  s.show();
end

endmodule
