module assertion (
    input logic       clk,
    input logic       rst_ni,
    input logic [7:0] button_data,
    input logic [7:0] led_data,
    input logic       tx_en_i,
    input logic       tx_we_i,
    input logic       rx_en_i,
    input logic       rx_re_i,
    input logic       tx_full,
    input logic       tx_empty,
    input logic       rx_full,
    input logic       rx_empty
);



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
