interface cache_if(input logic clk_i, rst_ni);
  icache_req_t cache_req_i;
  icache_res_t cache_res_o;
  logic        icache_miss_o;
  ilowX_res_t  lowX_res_i;
  ilowX_req_t  lowX_req_o;
endinterface