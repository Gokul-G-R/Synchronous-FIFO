class fifo_scoreboard extends uvm_scoreboard;
  
  `uvm_component_utils(fifo_scoreboard)

  parameter width=8;
  parameter depth=8;
  
  uvm_analysis_imp#(fifo_seq_item, fifo_scoreboard) item_collected_export;

  bit [width-1:0] local_fifo[$]; 
  bit full_flag;
  bit empty_flag;
  

  function new(string name = "fifo_scoreboard", uvm_component parent = null);
    super.new(name, parent);
  endfunction


  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    item_collected_export = new("item_collected_export", this);
  endfunction
  bit [width-1:0] exp_data;
  
virtual function void write(fifo_seq_item pkt);
 
  `uvm_info("FIFO SCOREBOARD", 
      $sformatf("Driving: wr_en=%0b rd_en=%0b data_in=%0h data_out=%0h full=%0b empty=%0b rst=%0b",
                 pkt.wr_en, pkt.rd_en, pkt.data_in, pkt.data_out, pkt.full, pkt.empty, pkt.rst),
      UVM_MEDIUM)
  if (!pkt.rst) begin
    local_fifo.delete();   
    full_flag  = 0;
    empty_flag = 1;

    `uvm_info(get_type_name(),$sformatf("RESET: FIFO cleared. full_flag=%0b, empty_flag=%0b",full_flag, empty_flag),UVM_LOW)
    return;
  end


  if (pkt.wr_en) begin
    if (local_fifo.size() == depth) begin
      `uvm_error(get_type_name(), "FIFO OVERFLOW: Write when FULL")
    end
    else begin
      local_fifo.push_back(pkt.data_in);
      `uvm_info(get_type_name(),
                $sformatf("WRITE: Data %0h pushed, FIFO size=%0d",
                          pkt.data_in, local_fifo.size()),
                UVM_LOW)
    end
  end


  if (pkt.rd_en) begin
    if (local_fifo.size() == 0) begin
      `uvm_error(get_type_name(), "FIFO UNDERFLOW: Read when EMPTY")
    end
    else begin
    exp_data = local_fifo.pop_front();
      if (exp_data == pkt.data_out)
        `uvm_info(get_type_name(),
                  $sformatf("READ Match: Expected %0h, Got %0h, FIFO size=%0d",
                            exp_data, pkt.data_out, local_fifo.size()),
                  UVM_LOW)
      else
        `uvm_error(get_type_name(),
                   $sformatf("READ Mismatch: Expected %0h, Got %0h",
                             exp_data, pkt.data_out))
    end
  end

  full_flag  = (local_fifo.size() == depth);
  empty_flag = (local_fifo.size() == 0);

  if (full_flag)
    `uvm_info(get_type_name(), "FIFO is FULL", UVM_LOW)

  if (empty_flag)
    `uvm_info(get_type_name(), "FIFO is EMPTY", UVM_LOW)

endfunction

endclass
