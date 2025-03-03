interface pattern_if (
    input clk,
    rst
);
  logic data;
  logic out;


  property PRO_pattern;
    @(posedge clk) $rose(
        data
    ) ##1 $fell(
        data
    ) ##1 data == 0 ##1 $rose(
        data
    );
  endproperty

  PATTERN :
  assert property (PRO_pattern) $display("pattern is found");

endinterface
