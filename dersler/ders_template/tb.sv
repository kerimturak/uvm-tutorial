
class basic_stack;

  rand bit [7:0] data  [3:0];
  rand bit [1:0] index;

  function new();
    $display("Hello, SystemVerilog OOP!");
  endfunction

  function void print_stack();
    $display("Stack contents:");
    foreach (data[i]) begin
      $display("data[%0d] = %0h", i, data[i]);
    end
  endfunction


endclass


module tb;
  // Clock
  logic       rst = 0;
  logic       clk = 0;

  basic_stack stack;

  always #5 clk = ~clk;



  initial begin
    stack = new();
    stack.randomize() with {data[0] == 1;};
    stack.print_stack();
    // Reset
    rst = 1;
    #20;
    rst = 0;
    $finish;
  end

  // Optional: Dump waves
  initial begin
    if ($test$plusargs("DUMP_WAVES")) begin
      $dumpfile("waves.vcd");
      $dumpvars(0, tb);
    end
  end

endmodule
