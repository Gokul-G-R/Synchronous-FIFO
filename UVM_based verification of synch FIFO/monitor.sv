class fifo_monitor extends uvm_monitor;
  
   `uvm_component_utils(fifo_monitor)

  uvm_analysis_port #(fifo_seq_item) item_collected_port;
  

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
  
  virtual fifo_if vif;
  fifo_seq_item tx;
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    item_collected_port = new("item_collected_port", this);
    if(!uvm_config_db#(virtual fifo_if)::get(this, "", "vif", vif))
      `uvm_fatal("NOVIF", "Virtual interface not set");
  endfunction

  virtual task run_phase(uvm_phase phase);
    
    forever begin
      tx = fifo_seq_item::type_id::create("tx");
        
      @(vif.monitor_cb); 
        tx.rst      = vif.monitor_cb.rst;
        tx.full     = vif.monitor_cb.full;
        tx.empty    = vif.monitor_cb.empty;
        tx.wr_en   = vif.monitor_cb.wr_en;
        tx.rd_en   = vif.monitor_cb.rd_en;
        tx.data_in = vif.monitor_cb.data_in;
        tx.data_out = vif.monitor_cb.data_out;
		item_collected_port.write(tx);
        
        
         `uvm_info("FIFO_MONITOR", 
              $sformatf("Observed transaction: wr=%0b, rd=%0b, data_in=%0h, data_out=%0h, full=%0b, empty=%0b",tx.wr_en, tx.rd_en, tx.data_in, tx.data_out, tx.full, tx.empty),UVM_MEDIUM);
      end
    

  endtask
endclass
