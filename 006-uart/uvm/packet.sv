// All components and object classess derived from umb_object


class packet extends uvm_sequence_item;
  rand logic [7:0] button_data; // tx input data
  rand logic       tx_en_i; // tranciever active
  rand logic       rx_en_i; // receiver active
  rand logic       tx_we_i; // write to tx buffer
  rand logic       rx_re_i; // read from rx buffer

  logic            tx_full;
  logic            tx_empty;
  logic            rx_full;
  logic            rx_empty;
  logic      [7:0] led_data; // rx output data


  `uvm_object_utils(packet)  // Factory registeration for create, get_type_name(), type_name()

  /*
    * Field macros provide automation (print, copy, compare, clone)
    * `uvm_object_utils_begin(packet)
    *       // `uvm_field_int(ARG, UVM_DEFAULT)
    *   `uvm_field_int(addr, UVM_DEFAULT)
    * `uvm_object_utils_end
  */

  // We can implement custom do_copy, do_compare and do_print functions
  // Because field macros functions are expanded into general code,
  // it may impact simulation performance and are generally not recommended.

  function new(string name = "packet");
    super.new(name);
    // The message is ignored if the verbosity level is greater than the configured maximum verbosity level.
    // `uvm_info ("ID_STRING", "TEXT_MESSAGE", VERBOSITY_LEVEL)
    `uvm_info("PACKET", "is created", UVM_LOW)
  endfunction

  // constraint for contention (wr, rd to same address simultaneously)

  constraint tx_full_no_write {
    if (tx_full) begin
      tx_we_i = '0;
    end
    }

  constraint tx_empty_no_operate {
    if (tx_empty) begin
      tx_en_i = '0;
    end
    }

  constraint rx_full_no_read {
    if (rx_full) begin
      rx_en_i = '0;
      tx_en_i = '0;
    end
    }

  constraint rx_empty_no_operate {
    if (rx_empty) begin
      rx_re_i = '0;
    end
    }

  // Bu sadece object classından türetilen yerlerde define edilebilir
  virtual function void do_print(uvm_printer printer);
    super.do_print(printer);
    printer.print_field_int("button_data", button_data, $bits(button_data), UVM_HEX);
    printer.print_field_int("tx_en_i", tx_en_i, $bits(tx_en_i), UVM_HEX);
    printer.print_field_int("rx_en_i", rx_en_i, $bits(rx_en_i), UVM_HEX);
    printer.print_field_int("tx_we_i", tx_we_i, $bits(tx_we_i), UVM_HEX);
    printer.print_field_int("rx_re_i", rx_re_i, $bits(rx_re_i), UVM_HEX);
  endfunction

  /*
    There is another function available in uvm_object called convert2string that will return a string
    instead of printing the contents in a predefined format. This allows you to define the output into
    a format you like. For example, we can simply print contents into a single line as shown.
  */

  virtual function string convert2string();
    string text = "";
    $sformatf(text, "tx_en_i: %d ", tx_en_i);
    $sformatf(text, "rx_en_i: %d ", rx_en_i);
    $sformatf(text, "tx_we_i: %d ", tx_we_i);
    $sformatf(text, "rx_re_i: %d ", rx_re_i);
    return text;
  endfunction

  // Cover Point
  // Coverpoints are put together in a covergroup block.
  // bins are said to be "hit/covered" when the variable reaches the corresponding values.
  // bin reserve is a single bin for all values that do not fall under the other bins.
  // common will have 12 separate bins, one for each value from 0x4 to 0xF.

endclass
