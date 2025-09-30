class fifo_driver extends uvm_driver#(fifo_seq_item);

  virtual fifo_if vif;
  fifo_seq_item seq;
  
  `uvm_component_utils(fifo_driver)

  function new (string name="fifo_driver", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual fifo_if)::get(this, "", "vif", vif))
      `uvm_fatal("NO_VIF", {"virtual interface must be set for: ", get_full_name(), ".vif"});
  endfunction
  
 /* function void connect_phase(uvm_phase phase);
  //  super.connect_Phase(phase);
    vif=vif;
  endfunction*/

  task run_phase(uvm_phase phase);
 
     @(vif.driver_cb);
     vif.driver_cb.rst   <= 0;
       @(vif.driver_cb);
     vif.driver_cb.rst   <= 1;
    
    forever begin
      
      seq_item_port.get_next_item(seq);
      drive();
      seq_item_port.item_done();
    end
  endtask

  
  
  virtual task drive();
    
  
   
    if(seq.wr_en==1)begin
       @(vif.driver_cb);
    vif.driver_cb.wr_en <=1;
    
      vif.driver_cb.data_in <= seq.data_in;
      @(vif.driver_cb);
      vif.driver_cb.wr_en <=0;
    end
    else if(seq.rd_en==1) begin
      		@(vif.driver_cb);
    			vif.driver_cb.rd_en <= 1;
      @(vif.driver_cb);
    			vif.driver_cb.rd_en <= 0;
    end
    
    `uvm_info("FIFO_DRIVER", 
      $sformatf("Driving: wr_en=%0b rd_en=%0b data_in=%0h data_out=%0h full=%0b empty=%0b rst=%0b",
                 seq.wr_en, seq.rd_en, seq.data_in, seq.data_out, seq.full, seq.empty, seq.rst),
              UVM_MEDIUM)
  endtask

endclass
