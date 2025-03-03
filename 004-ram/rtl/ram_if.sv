interface ram_if (
    input clk,
    rst
);
  logic [1:0] addr_i;
  logic [3:0] data_i;
  logic       rw_en_i;
  logic [3:0] data_o;
endinterface
