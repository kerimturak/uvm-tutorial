module memory (
  input  logic clk,
  input  logic rst_ni,
  input  logic wr_en_i,
  input  logic rd_en_i,
  input  logic [1:0] addr_i,
  input  logic [7:0] data_i,
  output  logic [7:0] data_o
);

  logic [7:0] memory [3:0];
  
  always @ (posedge clk) begin
    if (!rst_ni) begin
      foreach(memory[i]) memory[i] <= '0;
    end else begin
      if (wr_en_i) memory[addr_i] <= data_i;
      if (rd_en_i) data_o <= memory[addr_i];
    end
  end
  
endmodule