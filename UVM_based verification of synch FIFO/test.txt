class fifo_base_test extends uvm_test;

  `uvm_component_utils(fifo_base_test)
 
  
 fifo_env env;


  function new(string name = "fifo_base_test",uvm_component parent=null);
    super.new(name,parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);    
    env = fifo_env::type_id::create("env", this);
  endfunction 
  
 virtual function void end_of_elaboration_phase(uvm_phase phase);
    uvm_top.print_topology();
   
  endfunction

endclass 

class fifo_all_tc extends fifo_base_test;

  `uvm_component_utils(fifo_all_tc)
  

 // fifo_reset_tc      reset_seq;
  //fifo_write_tc      write_seq;
  //fifo_read_tc       read_seq;
  //fifo_full_tc       full_seq;
  fifo_empty_tc      empty_seq;
 //fifo_overflow_tc   overflow_seq;
  //fifo_underflow_tc  underflow_seq;
  //fifo_rd_after_wr_tc rd_after_wr_seq;
  
  function new(string name="fifo_all_tc", uvm_component parent=null);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    //reset_seq      = fifo_reset_tc::type_id::create("reset_seq");
    //write_seq      = fifo_write_tc::type_id::create("write_seq");
     //read_seq       = fifo_read_tc::type_id::create("read_seq");
      //full_seq       = fifo_full_tc::type_id::create("full_seq");
     empty_seq      = fifo_empty_tc::type_id::create("empty_seq");
    //overflow_seq   = fifo_overflow_tc::type_id::create("overflow_seq");
//     underflow_seq  = fifo_underflow_tc::type_id::create("underflow_seq");
    //wr_after_rd_seq= fifo_rd_after_wr_tc::type_id::create("wr_after_rd_seq");
    //rd_after_wr_seq= fifo_rd_after_wr_tc::type_id::create("rd_after_wr_seq");
  endfunction


  task run_phase(uvm_phase phase);
    phase.raise_objection(this);

    //reset_seq.start(env.fifo_agnt.sequencer);
   //write_seq.start(env.fifo_agnt.sequencer);
   //read_seq.start(env.fifo_agnt.sequencer);
   // full_seq.start(env.fifo_agnt.sequencer);
    empty_seq.start(env.fifo_agnt.sequencer);
    //overflow_seq.start(env.fifo_agnt.sequencer);
    //underflow_seq.start(env.fifo_agnt.sequencer);
    //rd_after_wr_seq.start(env.fifo_agnt.sequencer);
	phase.phase_done.set_drain_time(this, 50);
    phase.drop_objection(this);

  endtask

endclass
