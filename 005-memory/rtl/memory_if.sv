// https://verificationacademy.com/forums/t/clocking-block-in-interface/29291/2

interface memory_if(input logic clk,rst_ni);
  
  logic [1:0] addr;
  logic wr_en;
  logic rd_en;
  logic [7:0] wdata;
  logic [7:0] rdata;

/*  
[default] clocking [identifier_name] @ [event_or_identifier]
	default input #[delay_or_edge] output #[delay_or_edge]
	[list of signals]
endclocking
*/
  clocking driver_cb @(posedge clk);
    // If an input skew is mentioned
    // then all input signals sampled at skew time units before the clock event
    // If an output skew is mentioned
    // then all output signals driven skew time units after the clock event
    // An input skew of 1step indicates that the signal should be sampled at the end of the previous time step, or in other words, immediately before the positive clock edge.
    default input #1 output #1;
    output addr;
    output wr_en;
    output rd_en;
    output wdata;
    input  rdata;  
  endclocking

  clocking monitor_cb @(posedge clk);
    default input #1 output #1;
    input addr;
    input wr_en;
    input rd_en;
    input wdata;
    input rdata;  
  endclocking
  
  modport DRIVER  (clocking driver_cb,input clk,rst_ni);
  modport MONITOR (clocking monitor_cb,input clk,rst_ni);
  //modport modp_assertion (input clk,rst_ni, addr, wr_en, rd_en, wdata, rdata);
endinterface