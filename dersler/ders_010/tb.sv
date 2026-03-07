interface class printable;
  pure virtual function void print();
endclass

virtual class packet #(
  parameter int WIDTH = 8,
  parameter int DEPTH = 8,
  type T = bit
);
  string name;
  rand T [WIDTH-1:0] data[DEPTH-1:0];

  function new(string name = "");
    this.name = name;
    $display("Nesne : %0s", name);
  endfunction

endclass

class extended_packet #(type T = int)
  extends packet#(.T(T))
  implements printable;

  function new(string name = "");
    super.new(name);
  endfunction

  extern function void print();
endclass

function void extended_packet::print();
  foreach (data[i]) begin
    $display("data[%0d]: %0h", i, data[i]);
  end
endfunction

module tb ();

  typedef extended_packet #(.T(bit)) bit_packet;
  typedef extended_packet #(.T(int)) int_packet;

  int_packet pkt;
  printable p_if;

  initial begin
    pkt = new("pkt");
    pkt.randomize();
    pkt.print();

    p_if = pkt;
    p_if.print();
  end

endmodule