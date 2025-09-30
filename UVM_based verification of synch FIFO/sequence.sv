class fifo_seq extends uvm_sequence#(fifo_seq_item);
  `uvm_object_utils(fifo_seq)
  
  function new(string name="fifo_seq");
    super.new(name);
  endfunction
  fifo_seq_item seq;
endclass


//reset


// class fifo_reset_tc extends fifo_seq;
//   `uvm_object_utils(fifo_reset_tc)
  
//   function new(string name="fifo_reset_tc");
//     super.new(name);
//   endfunction
  
//   task body();
//     // Create the request item
//     seq = fifo_seq_item::type_id::create("seq");
//     repeat(5)begin

//     // Start the transaction
//       start_item(seq);
   
//     // Manually set values
//       assert(seq.randomize() with {seq.rst== 0;seq.wr_en == 0;seq.rd_en==1;});
 
//     // Finish the transaction
//       finish_item(seq);
//     end
//   endtask
// endclass

//write
// class fifo_write_tc extends fifo_seq;
//   `uvm_object_utils(fifo_write_tc)
  
//   function new(string name="fifo_write_tc");
//     super.new(name);
//   endfunction
  
//    virtual task body();
//     // Create the request item
//      repeat(16)begin
//        seq = fifo_seq_item::type_id::create("seq");   
//     // Start the transaction
//        start_item(seq);
//        assert(seq.randomize() with {rst== 1;wr_en == 1;rd_en==0;});
//        finish_item(seq);
//      end
//   endtask
  
// endclass

// //read
// class fifo_read_tc extends fifo_seq;
  
//   `uvm_object_utils(fifo_read_tc)
  
//   function new(string name="fifo_read_tc");
//     super.new(name);
//   endfunction
  
//   virtual task body();
//     // Create the request item
//     seq = fifo_seq_item::type_id::create("seq");
    
//     repeat(10)
//       begin
//     start_item(seq);
//     assert(seq.randomize() with {rst== 0;wr_en == 1;rd_en==0;});
//     finish_item(seq);
//       end
    
//     repeat(10)
//       begin
//      start_item(seq);
//     assert(seq.randomize() with {rst== 0;wr_en == 0;rd_en==1;});
//     finish_item(seq);
//       end
//   endtask
  
// endclass

//full

// class fifo_full_tc extends fifo_seq;
  
//   //fifo_write_tc wr_seq;
  
//  // virtual fifo_if vif;
  
  
//   `uvm_object_utils(fifo_full_tc)
  
 
  
//   function new(string name="fifo_full_tc");
//     super.new(name);
//   endfunction
  
//    virtual task body();
// //     if (!uvm_config_db#(virtual fifo_if)::get(null, "", "vif", vif)) begin
// //       `uvm_fatal("FULL_TC", "VIF not set in config DB")
// //     end
     
// //      while(!vif.full) begin
//      repeat(10)begin
//        seq = fifo_seq_item::type_id::create("seq");
//        start_item(seq);
//        assert(seq.randomize() with {rst==1;wr_en == 1;rd_en==0;});
//        finish_item(seq);
//     end

//         `uvm_info("FULL_TC", "FIFO is now FULL", UVM_MEDIUM)
//   endtask

  
//  endclass




//empty

class fifo_empty_tc extends fifo_seq;
  
  //fifo_write_tc wr_seq;
  
  `uvm_object_utils(fifo_empty_tc)
 
  function new(string name="fifo_empty_tc");
    super.new(name);
  endfunction
  
   virtual task body();
     
      repeat(10)begin
       seq = fifo_seq_item::type_id::create("seq");
       start_item(seq);
       assert(seq.randomize() with {rst==1;wr_en == 1;rd_en==0;});
       finish_item(seq);
    end


     repeat(10)begin
       seq = fifo_seq_item::type_id::create("seq");
       start_item(seq);
       assert(seq.randomize() with {rst==1;wr_en == 0;rd_en==1;});
       finish_item(seq);
    end

     `uvm_info("EMPTY_TC", "FIFO is now EMPTY", UVM_MEDIUM)
  endtask
  
 endclass

// //write after read



// class fifo_wr_after_rd_tc extends fifo_seq;

//   `uvm_object_utils(fifo_wr_after_rd_tc)
  
//   function new(string name="fifo_wr_after_rd_tc");
//     super.new(name);
//   endfunction
  
  
//   virtual task body();
    
//     repeat(10)begin
//       fork 
//       begin
   
//        seq = fifo_seq_item::type_id::create("seq");
//        start_item(seq);
//        assert(seq.randomize() with {rst==1;wr_en == 1;rd_en==0;});
//        finish_item(seq);
//         ##1;
//       end
//      join_any  
//        seq = fifo_seq_item::type_id::create("seq");
//        start_item(seq);
//        assert(seq.randomize() with {rst==1;wr_en == 1;rd_en==0;});
//        finish_item(seq);
//     end
   
   
//     `uvm_info("RD_AFTER_WR_TC", "READ after writing ", UVM_MEDIUM)
//    endtask
// endclass


// //read after write
// class fifo_rd_after_wr_tc extends fifo_seq;

//   `uvm_object_utils(fifo_rd_after_wr_tc)
  
//   function new(string name="fifo_wr_after_rd_tc");
//     super.new(name);
//   endfunction
  
  
//   virtual task body();
    
//     repeat(256)begin
//       fork 
//       begin
   
//        seq = fifo_seq_item::type_id::create("seq");
//        start_item(seq);
//         assert(seq.randomize() with {rst==1;wr_en == 1;rd_en==0;});
//        finish_item(seq);

//       end
//      join_any  
//        seq = fifo_seq_item::type_id::create("seq");
//        start_item(seq);
//       assert(seq.randomize() with {rst==1;wr_en == 0;rd_en==1;});
//        finish_item(seq);
//     end
   
   
//     `uvm_info("RD_AFTER_WR_TC", "READ after writing ", UVM_MEDIUM)
//    endtask
// endclass
  
 
 

// //overflow

// class fifo_overflow_tc extends fifo_seq;
  
//   `uvm_object_utils(fifo_overflow_tc)

//   function new(string name="fifo_overflow_tc");
//     super.new(name);
//   endfunction

//   virtual task body();
//     // Keep writing until FIFO is full
//     while(!p_sequencer.vif.full) begin
//       req = fifo_seq_item::type_id::create("req");
//       start_item(req);
//       req.rst    = 1;
//       req.wr_en  = 1;  // write
//       req.rd_en  = 0;  // no read
//       finish_item(req);
//     end

//     `uvm_info("OVERFLOW_TC", "FIFO is now FULL", UVM_MEDIUM)

//     // Try one more write to trigger overflow
//     req = fifo_seq_item::type_id::create("req");
//     start_item(req);
//     req.rst    = 1;
//     req.wr_en  = 1;  // write after full
//     req.rd_en  = 0;
//     finish_item(req);

//     `uvm_info("OVERFLOW_TC", "Attempted write after FIFO FULL to check overflow", UVM_MEDIUM)
//   endtask

// endclass



// //underflow


// class fifo_underflow_tc extends fifo_seq;
  
//   `uvm_object_utils(fifo_underflow_tc)

//   function new(string name="fifo_underflow_tc");
//     super.new(name);
//   endfunction

//   virtual task body();
    
//     while(!p_sequencer.vif.empty) begin
//       req = fifo_seq_item::type_id::create("req");
//       start_item(req);
//       req.rst    = 1;
//       req.wr_en  = 0;  
//       req.rd_en  = 1;  
//       finish_item(req);
//     end

//     `uvm_info("UNDERFLOW_TC", "FIFO is now FULL", UVM_MEDIUM)

//     // Try one more write to trigger overflow
//     req = fifo_seq_item::type_id::create("req");
//     start_item(req);
//     req.rst    = 1;
//     req.wr_en  = 0;  
//     req.rd_en  = 1;// ready after empty 
//     finish_item(req);

//     `uvm_info("UNDERFLOW_TC", "Attempted read after FIFO EMPTY to check underflow", UVM_MEDIUM)
//   endtask

// endclass


// /*
// //simultaneous read and write 


// class fifo_simul_rd_wr_tc extends fifo_seq;
  
//   `uvm_object_utils(fifo_simul_rd_wr_tc)
  
//   function new(string name="fifo_simul_rd_wr_tc");
//     super.new(name);
//   endfunction
  
//   virtual task body();
//     // Create the request item
//     req = seq_item::type_id::create("req");
    
//     // Start the transaction
//     start_item(req);
    
//     // Manually set values
//     req.rst    = 1;
//     req.wr_en  = 1;
//     req.rd_en  = 1;
    
//     // Finish the transaction
//     finish_item(req);
    
//     `uvm_info("SIMUL_READ_WRITE_TC", "simultaneous read write", UVM_MEDIUM)
//   endtask
  
// endclass
// */

// //consecutive read and write

  
// class fifo_consec_tc extends fifo_seq;
  
//   fifo_write_tc wr_seq;
  
  
//   `uvm_object_utils(fifo_consec_tc)
  
//   function new(string name="fifo_consec_tc");
//     super.new(name);
//   endfunction
  
//   virtual task body ();
    
//     if(!p_sequencer.vif.full)
//      begin
//     `uvm_do(wr_seq);
//     `uvm_do(rd_seq);
//     end
//  else begin
//     `uvm_do(rd_seq);
//     `uvm_do(wr_seq);
//  end
//   endtask

// endclass*/
