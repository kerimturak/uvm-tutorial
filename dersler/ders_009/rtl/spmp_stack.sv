// Simple stack DUT for UVM training
// One push port, three pop ports with fixed priority (pop0 > pop1 > pop2)
// Push accepted when not full. One pop served per cycle (highest priority request).
module spmp_stack #(
	parameter int WIDTH = 8,
	parameter int DEPTH = 16
) (
	input  logic clk,
	input  logic rst_n,

	// Push port
	input  logic        push_req,
	input  logic [WIDTH-1:0] push_data,
	output logic        push_ack,
	output logic        full,

	// Pop ports (3)
	input  logic        pop_req0,
	output logic        pop_valid0,
	output logic [WIDTH-1:0] pop_data0,

	input  logic        pop_req1,
	output logic        pop_valid1,
	output logic [WIDTH-1:0] pop_data1,

	input  logic        pop_req2,
	output logic        pop_valid2,
	output logic [WIDTH-1:0] pop_data2
);

	localparam int PTR_W = $clog2(DEPTH+1);

	// Memory and stack pointer
	logic [WIDTH-1:0] mem [0:DEPTH-1];
	logic [PTR_W-1:0] sp; // number of elements in stack (0..DEPTH)

	// Internal signals
	logic any_pop_req;
	logic [1:0] sel_pop; // 0..2
	logic pop_accept;
	logic push_accept;
	logic [WIDTH-1:0] pop_data_reg;

	assign any_pop_req = pop_req0 | pop_req1 | pop_req2;
	assign full = (sp == DEPTH);

	// Priority encoder: pop0 > pop1 > pop2
	always_comb begin
		sel_pop = 2'd0;
		if (pop_req0) sel_pop = 2'd0;
		else if (pop_req1) sel_pop = 2'd1;
		else if (pop_req2) sel_pop = 2'd2;
	end

	// Accept conditions
	// pop_accept only if stack not empty and some request present
	assign pop_accept = (sp != 0) && any_pop_req;
	// push_accept if not full
	assign push_accept = push_req && (sp != DEPTH);

	// Sequential behavior
	always_ff @(posedge clk or negedge rst_n) begin
		if (!rst_n) begin
			sp <= '0;
			push_ack <= 1'b0;
			pop_valid0 <= 1'b0;
			pop_valid1 <= 1'b0;
			pop_valid2 <= 1'b0;
			pop_data_reg <= '0;
		end else begin
			// default outputs low
			push_ack <= 1'b0;
			pop_valid0 <= 1'b0;
			pop_valid1 <= 1'b0;
			pop_valid2 <= 1'b0;

			// Handle push and/or pop in same cycle
			if (push_accept && !pop_accept) begin
				// only push: write at current top, increment sp
				mem[sp] <= push_data;
				sp <= sp + 1;
				push_ack <= 1'b1;
			end else if (!push_accept && pop_accept) begin
				// only pop: decrement sp, present top element
				sp <= sp - 1;
				pop_data_reg <= mem[sp-1];
				// set valid for selected port
				case (sel_pop)
					2'd0: pop_valid0 <= 1'b1;
					2'd1: pop_valid1 <= 1'b1;
					2'd2: pop_valid2 <= 1'b1;
				endcase
			end else if (push_accept && pop_accept) begin
				// both push and pop in same cycle: keep sp unchanged
				// pop returns old top (sp-1), push writes to old top position
				pop_data_reg <= mem[sp-1];
				mem[sp] <= push_data;
				push_ack <= 1'b1;
				case (sel_pop)
					2'd0: pop_valid0 <= 1'b1;
					2'd1: pop_valid1 <= 1'b1;
					2'd2: pop_valid2 <= 1'b1;
				endcase
			end
		end
	end

	// Output the pop data registers to each port (only selected port gets valid)
	assign pop_data0 = pop_data_reg;
	assign pop_data1 = pop_data_reg;
	assign pop_data2 = pop_data_reg;

endmodule
