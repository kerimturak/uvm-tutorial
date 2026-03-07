module spmp_stack_tb_top ();
    import spmp_pkg::*;

    bit clk, rst_n;

    spmp_stack_if stack_if(clk, rst_n);
    env spmp_env;

    spmp_stack dut (
        .clk(stack_if.clk),
        .rst_n(stack_if.rst_n),
        .push_req(stack_if.push_req),
        .push_data(stack_if.push_data),
        .push_ack(stack_if.push_ack),
        .full(stack_if.full),
        .pop_req0(stack_if.pop_req0),
        .pop_valid0(stack_if.pop_valid0),
        .pop_data0(stack_if.pop_data0),
        .pop_req1(stack_if.pop_req1),
        .pop_valid1(stack_if.pop_valid1),
        .pop_data1(stack_if.pop_data1),
        .pop_req2(stack_if.pop_req2),
        .pop_valid2(stack_if.pop_valid2),
        .pop_data2(stack_if.pop_data2)
    );

    always #5 clk = ~clk;

    initial begin
        rst_n = 1;
        @(posedge clk);
        rst_n = 0;
        @(posedge clk);
        rst_n = 1;
        @(posedge clk);

        spmp_env = new("env");
        spmp_env.configure(stack_if);
        spmp_env.run(50);
        $finish;

    end
endmodule
