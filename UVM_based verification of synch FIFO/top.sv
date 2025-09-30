`include "uvm_macros.svh"
 import uvm_pkg::*;


`include "interface.sv"
`include "seq_item.sv"
`include "sequence.sv"
 `include "sequencer.sv"
 `include "driver.sv"
 `include "monitor.sv"
`include "coverage.sv"
 `include "agent.sv"
 `include "scoreboard.sv"
 `include "environment.sv"
 `include "test.sv"



module top;
  
    bit clk = 0;

   always #5 clk = ~clk;
  
    
  fifo_if intf(clk); 
  
  sync_fifo DUT (
    .clk(clk),
    .rst(intf.rst),
    .wr_en(intf.wr_en),
    .rd_en(intf.rd_en),
    .data_in(intf.data_in),
    .data_out(intf.data_out),
    .full(intf.full),
    .empty(intf.empty)
   );
  

  initial begin 
     $dumpfile("dump.vcd"); 
    $dumpvars;
    uvm_config_db #(virtual fifo_if)::set(uvm_root::get(),"*","vif",intf);
  
  end

//   initial begin
//     intf.rst =0;
//     #7
//     intf.rst =1;
//   end
  initial begin 
    run_test("fifo_all_tc");
  end
  
endmodule

// `timescale 1ns/1ps

// module tb_sync_fifo;

//   // Parameters
//   parameter WIDTH = 8;
//   parameter DEPTH = 8;

//   // DUT Signals
//   reg clk;
//   reg rst;
//   reg wr_en;
//   reg rd_en;
//   reg [WIDTH-1:0] data_in;
//   wire [WIDTH-1:0] data_out;
//   wire full;
//   wire empty;

//   // DUT Instantiation
//   sync_fifo #(.width(WIDTH), .depth(DEPTH)) dut (
//     .clk(clk),
//     .rst(rst),
//     .wr_en(wr_en),
//     .rd_en(rd_en),
//     .data_in(data_in),
//     .data_out(data_out),
//     .full(full),
//     .empty(empty)
//   );

//   // Clock Generation: 10ns period
//   initial clk = 0;
//   always #5 clk = ~clk;
  
//   initial begin 
//     $dumpfile("dump.vcd");
//     $dumpvars;
//   end

//   // Stimulus
//   initial begin
//     // Initialize signals
//     rst = 0;
//     wr_en = 0;
//     rd_en = 0;
//     data_in = 0;

//     // Apply reset
//     #12 rst = 1;
//     $display("Reset De-asserted at time %0t", $time);

//     // Write some data until FIFO becomes full
//     repeat(DEPTH) begin
//       @(posedge clk);
//       if (!full) begin
//         wr_en = 1;
//         data_in = $random % 256;  // random 8-bit data
//         $display("Time %0t: Writing data = %0d", $time, data_in);
//       end
//     end
//     @(posedge clk) wr_en = 0;  // stop writing

//     // Try to read data until FIFO becomes empty
//     repeat(DEPTH) begin
//       @(posedge clk);
//       if (!empty) begin
//         rd_en = 1;
//         @(posedge clk); // wait one cycle to capture output
//         $display("Time %0t: Reading data = %0d", $time, data_out);
//       end
//     end
//     @(posedge clk) rd_en = 0;  // stop reading

//     // Finish Simulation
//     #20;
//     $display("Simulation Completed at time %0t", $time);
//     $finish;
//   end

// endmodule

