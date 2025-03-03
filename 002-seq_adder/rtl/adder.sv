module adder (
    input logic clk,
    input logic rst,
    input logic [7:0] num1,
    input logic [7:0] num2,
    output logic [8:0] out
);

  always_ff @(posedge clk) begin
    if (rst) out <= 0;
    else out <= num1 + num2;
  end

endmodule
