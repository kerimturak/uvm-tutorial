class packet;
	rand logic        push_req;
	rand logic [7:0]  push_data;

    function new (string name="");
    endfunction

    function void print();
        $display("push_req: \t %0b", push_req);
        $display("push_data: \t %0h\n", push_data);
    endfunction
endclass