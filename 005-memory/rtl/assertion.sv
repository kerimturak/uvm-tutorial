module assertion (
  input  logic clk,
  input  logic rst_ni,
  input  logic wr_en_i,
  input  logic rd_en_i,
  input  logic [1:0] addr_i,
  input  logic [7:0] data_i,
  input  logic [7:0] data_o
);

  property rw_contention;
    @(posedge clk)
    wr_en_i == 1'b1 |-> rd_en_i != 1'b1;
  endproperty;
  
  RW_CONTENTION : assert property(rw_contention) $display("%0d  %0d",wr_en_i, rd_en_i);

endmodule
    
    /*
    module assertion (memory_if.modp_assertion vif);

  property rw_contention;
    @(posedge vif.clk)
    vif.wr_en_i == 1'b1 |-> vif.rd_en_i != 1'b1;
  endproperty;
  
  RW_CONTENTION : assert property(rw_contention) $display("%0d  %0d", vif.wr_en_i, vif.rd_en_i);

endmodule
*/