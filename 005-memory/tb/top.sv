`include "uvm_macros.svh"
import uvm_pkg::*;
import ram_pkg::*;

module top;
  
  //clock and reset signal declaration `include "test.sv"
  bit clk;
  bit rst_ni;
  
  //clock generation
  always #5 clk = ~clk;
  
  //reset Generation
  initial begin
    rst_ni = 0;
    #5 rst_ni =1;
  end
  
  //creatinng instance of interface, inorder to connect DUT and testcase
  memory_if vif(clk,rst_ni);
  
  //DUT instance, interface signals are connected to the DUT ports
  memory DUT (
    .clk(vif.clk),
    .rst_ni(vif.rst_ni),
    .addr_i(vif.addr),
    .wr_en_i(vif.wr_en),
    .rd_en_i(vif.rd_en),
    .data_i(vif.wdata),
    .data_o(vif.rdata)
   );
  //bind  DUT assertion single_inst(vif);
  bind  DUT assertion single_inst(
    .clk(vif.clk),
    .rst_ni(vif.rst_ni),
    .addr_i(vif.addr),
    .wr_en_i(vif.wr_en),
    .rd_en_i(vif.rd_en),
    .data_i(vif.wdata),
    .data_o(vif.rdata)
  );
  
  //enabling the wave dump
  initial begin 
    uvm_config_db#(virtual memory_if)::set(null,"*","vif",vif);
    $dumpfile("dump.vcd"); $dumpvars;
  end
  
  initial begin 
    run_test("base_test");
  end
  
  covergroup cvr_grp @ (posedge clk);

    // Coverpoints can optionally have a name before a colon ":"
    one    : coverpoint vif.addr;
    second : coverpoint vif.wdata {
      bins one_three = {0};
      bins five = {2};
    }
  endgroup
  
  cvr_grp cvr;

  initial begin
    cvr = new();
    for (int i=0; i<10; i++) begin
      @(negedge clk);
      cvr.sample ();
      $display ("Coverage = %0.2f %%", cvr.get_inst_coverage());
    end
    $display ("Coverage = %0.2f %%", cvr.get_inst_coverage());
  end

endmodule