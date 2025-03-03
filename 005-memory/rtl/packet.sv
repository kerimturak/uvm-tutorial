// All components and object classess derived from umb_object

class packet extends uvm_sequence_item;
  rand bit [1:0] addr;
  rand bit       wr_en;
  rand bit       rd_en;
  rand bit [7:0] wdata;
       bit [7:0] rdata;
  
  // Factory registeration
  `uvm_object_utils(packet) 

  // Field macros provide automation (print, copy, compare, clone)
  /*
  `uvm_object_utils_begin(packet)
        // `uvm_field_int(ARG, UVM_DEFAULT)
    `uvm_field_int(addr, UVM_DEFAULT)
  `uvm_object_utils_end
  */

  
  // We can implement custom do_copy, do_compare and do_print functions
  // Because field macros functions are expanded into general code, 
  // it may impact simulation performance and are generally not recommended.

  
  function new (string name = "packet");
    super.new(name);  
    // The message is ignored if the verbosity level is greater than the configured maximum verbosity level.
    // `uvm_info ("ID_STRING", "TEXT_MESSAGE", VERBOSITY_LEVEL)
    `uvm_info ("PACKET", "is created", UVM_LOW)
  endfunction

  // constraint for contention (wr, rd to same address simultaneously)
  constraint rd_wr_en_c {wr_en != rd_en;}
  
  // Bu sadece object classından türetilen yerlerde define edilebilir
  virtual function void do_print (uvm_printer printer);
    super.do_print(printer);
    printer.print_field_int("addr", addr, $bits( addr), UVM_HEX);
    printer.print_field_int("wdata", wdata, $bits( wdata), UVM_HEX);
    //printer.print_string();
  endfunction
  
/*
There is another function available in uvm_object called convert2string that will return a string instead of printing the contents in a predefined format. This allows you to define the output into a format you like. For example, we can simply print contents into a single line as shown.
*/
  
  virtual function string convert2string();
    string text  ="";
    $sformatf(text, "wr_en: %d", wr_en);
    return text;
  endfunction

  // Cover Point
  // Coverpoints are put together in a covergroup block.
  // bins are said to be "hit/covered" when the variable reaches the corresponding values.
  // bin reserve is a single bin for all values that do not fall under the other bins.
  // common will have 12 separate bins, one for each value from 0x4 to 0xF.
  
endclass
