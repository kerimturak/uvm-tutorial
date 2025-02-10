module ram(
  input clk, rst,
  input logic [1:0] addr_i,
  input logic [3:0] data_i,
  input logic rw_en_i,
  output logic [3:0] data_o
);
  
  logic [3:0] memory [3:0];
  
  always_ff @(posedge clk) begin
    if(rst) begin
      foreach(memory[i]) memory[i] <= '0;
      data_o <= '0;
    end else begin
      if(rw_en_i)
        memory[addr_i] <= data_i;
      else 
        data_o <= memory[addr_i];
    end
  end
  
endmodule