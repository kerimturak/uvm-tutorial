
interface spmp_stack_if #(parameter int WIDTH = 8) (input logic clk, input logic rst_n);
	// Push port
	logic        push_req;
	logic [WIDTH-1:0] push_data;
	logic        push_ack;
	logic        full;

	// Pop port 0
	logic        pop_req0;
	logic        pop_valid0;
	logic [WIDTH-1:0] pop_data0;

	// Pop port 1
	logic        pop_req1;
	logic        pop_valid1;
	logic [WIDTH-1:0] pop_data1;

	// Pop port 2
	logic        pop_req2;
	logic        pop_valid2;
	logic [WIDTH-1:0] pop_data2;
endinterface