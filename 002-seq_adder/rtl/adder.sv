/*
 Github   : https://github.com/kerimturak
 Linkedin : https://www.linkedin.com/in/kerimturak0/
*/

module adder(input clk, rst, input [7:0] num1, num2, output reg [8:0] out);

  always_ff@(posedge clk) begin
    if(rst)  out <= 0;
    else     out <= num1 + num2;
  end

endmodule