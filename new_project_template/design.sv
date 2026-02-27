// =============================================================================
// Design Module (RTL Örneği)
// =============================================================================

module design (
	input logic clk,
	input logic rst,
	input logic [7:0] data_in,
	output logic [7:0] data_out
);

	// Simple pass-through design
	always @(posedge clk) begin
		if (rst)
			data_out <= 8'h00;
		else
			data_out <= data_in;
	end

endmodule
