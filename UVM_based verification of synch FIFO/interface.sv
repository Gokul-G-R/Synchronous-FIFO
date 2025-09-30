interface fifo_if #(parameter WIDTH = 8, parameter DEPTH = 8) (input logic clk);

 
  logic wr_en;
  logic rd_en;
  logic rst;
  logic [WIDTH-1:0] data_in;
  logic [WIDTH-1:0] data_out;
  logic full;
  logic empty;
	
 
  clocking driver_cb @(posedge clk);
   default input #1 output #1;    
    output rst,wr_en, rd_en, data_in;
    input  data_out, full, empty;
  endclocking


  clocking monitor_cb @(posedge clk);
    default input #0 output #1;   
    input wr_en,rst, rd_en, data_in, data_out, full, empty;
  endclocking

  
  //modport DRIVER  (clocking driver_cb);
 /* modport DUT     (input clk, rst, wr_en, rd_en, data_in,
                   output data_out, full, empty);*/

endinterface
