
class fifo_agent extends uvm_agent;

  
  fifo_driver    driver;
  fifo_sequencer sequencer;
  fifo_monitor   monitor;

  
  `uvm_component_utils(fifo_agent)
  
  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction

 
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    monitor = fifo_monitor::type_id::create("monitor", this);

    
    if(get_is_active() == UVM_ACTIVE) begin
      driver    = fifo_driver::type_id::create("driver", this);
      sequencer = fifo_sequencer::type_id::create("sequencer", this);
      //cvg = fifo_coverage:: type_id :: create("cvg",this);
    end
  endfunction 
  
  function void connect_phase(uvm_phase phase);
    if(get_is_active() == UVM_ACTIVE) begin
      
      driver.seq_item_port.connect(sequencer.seq_item_export);
     
    end
  endfunction 

endclass 
