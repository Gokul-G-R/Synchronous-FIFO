class fifo_seq_item extends uvm_sequence_item;
  
  
  `uvm_object_utils(fifo_seq_item)
  
  function new(string name="fifo_seq_item");
    super.new(name);
  endfunction
  
  parameter width=8;
  parameter depth=8;
  
  rand bit rst;
  rand bit wr_en;
  rand bit rd_en;
  randc bit [width-1:0] data_in;
  logic [width-1:0] data_out;
  logic full;
  logic empty;
  
  
  
endclass
