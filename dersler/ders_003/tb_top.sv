module tb_top();
    
    import package_file::*;
    class_file cf;

    initial begin
        cf = new("cf");
        start_test;
    end
endmodule