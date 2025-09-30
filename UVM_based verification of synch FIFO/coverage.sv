class fifo_coverage extends uvm_subscriber #(fifo_seq_item);
  `uvm_component_utils(fifo_coverage)
  
  uvm_analysis_imp#(fifo_seq_item,fifo_coverage) cvg_port;
  

  // Covergroup declaration
  covergroup fifo_cg;
    //option.per_instance = 1;

//     // Coverpoints on stimulus
//     cp_wr_en   : coverpoint tr.wr_en{bins wr1={[0:1]};}
//     cp_rd_en   : coverpoint tr.rd_en{bins rd1={[0:1]};}
//     cp_rst     : coverpoint 
//     			tr.rst {
//                   bins r1={[0:1]};
//                 }
//     cp_data_in : coverpoint 
//     			tr.data_in{
      
//                   bins data1 = {[0:63]};    
//                   bins data2 = {[64:127]};  
//                   bins data3 = {[128:255]}; 
//                 } 
    
//    wr_rd_cross : cross cp_wr_en,cp_rst, cp_rd_en;
//   endgroup
  
  
    // Coverpoints on stimulus
    cp_wr_en   : coverpoint tr.wr_en{bins wr1[]={[0:1]};}
    cp_rd_en   : coverpoint tr.rd_en{bins rd1[]={[0:1]};}
    cp_rst     : coverpoint 
    			tr.rst {
                  bins r1[]={[0:1]};
                }
    cp_data_in : coverpoint 
    			tr.data_in{
      
                  bins data1[] = {[0:63]};    
                  bins data2[] = {[64:127]};  
                  bins data3[] = {[128:255]}; ///70.86%
                } 
    
   wr_rd_cross : cross cp_wr_en,cp_rst, cp_rd_en;
  endgroup

  fifo_seq_item tr;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    fifo_cg = new();
    cvg_port=new("cvg_port",this);
  endfunction

  virtual function void write(fifo_seq_item t);
    tr = t;
    fifo_cg.sample();
  endfunction
  
 function void report_phase(uvm_phase phase);
     `uvm_info(get_full_name(),$sformatf("Coverage is %0.2f %%", fifo_cg.get_coverage()),UVM_LOW);
  endfunction


endclass
