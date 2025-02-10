// Our pattern 1001
module pattern_detector(
input clk, rst, data,
output logic out);
  
  enum logic [1:0] {S0, S1, S2, S3} state, next_state;
  
  always_ff @(posedge clk) begin
    if(rst) state <= S0;
    else    state <= next_state;
  end
 
  always_comb begin
    
    case(state)
      S0: next_state = data ? S1 : S0;
      S1: next_state = data ? S0 : S2;
      S2: next_state = data ? S0 : S3;
      S3: next_state = data ? S0 : S0;
    endcase
    
    out = state == S3 && data == 1'b1;
  end
endmodule