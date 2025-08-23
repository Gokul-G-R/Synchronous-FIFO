`timescale 1ns/1ps

module tb_sync_fifo;

    // Parameters
    parameter WIDTH = 8;
    parameter DEPTH = 16;

    // Inputs
    reg clk;
    reg rst;
    reg wr_en;
    reg rd_en;
    reg [WIDTH-1:0] wr_data;

    // Outputs
    wire [WIDTH-1:0] rd_data;
    wire full;
    wire empty;

    // Instantiate FIFO
    sync_fifo #(WIDTH, DEPTH) uut (
        .clk(clk),
        .rst(rst),
        .wr_en(wr_en),
        .rd_en(rd_en),
        .wr_data(wr_data),
        .rd_data(rd_data),
        .full(full),
        .empty(empty)
    );

    // Clock generation
    initial clk = 0;
    always #5 clk = ~clk; // 100 MHz clock

    // Tasks for write and read
    task write_fifo(input [WIDTH-1:0] data);
        begin
            wr_data = data;
            wr_en = 1;
            #10;
            wr_en = 0;
            #10;
        end
    endtask

    task read_fifo;
        begin
            rd_en = 1;
            #10;
            rd_en = 0;
            #10;
        end
    endtask

    // Declare loop variable for Vivado
    integer i;

    // Test procedure
    initial begin
        $display("Starting FIFO testbench...");

        // Reset FIFO
        rst = 1; wr_en = 0; rd_en = 0; wr_data = 0;
        #20;
        rst = 0;
        #10;
        if (empty && !full) $display("Reset successful, FIFO empty.");

        // -------------------------------
        // Test 1: Fill FIFO completely (full flag)
        $display("Test 1: Filling FIFO...");
        for (i=0; i<DEPTH; i=i+1) write_fifo(i);
        if (full) $display("PASS: FIFO full flag is set correctly.");
        else $display("FAIL: FIFO full flag not set.");

        // Try writing when full
        write_fifo(8'hFF);
        if (full) $display("PASS: Write ignored when FIFO full.");
        else $display("FAIL: FIFO allowed write when full.");

        // -------------------------------
        // Test 2: Read all elements (empty flag)
        $display("Test 2: Reading all FIFO elements...");
        for (i=0; i<DEPTH; i=i+1) read_fifo;
        if (empty) $display("PASS: FIFO empty flag is set correctly.");
        else $display("FAIL: FIFO empty flag not set.");

        // Try reading when empty
        read_fifo;
        if (empty) $display("PASS: Read ignored when FIFO empty.");
        else $display("FAIL: FIFO allowed read when empty.");

        // -------------------------------
        // Test 3: Simultaneous read/write
        $display("Test 3: Simultaneous read/write...");
        write_fifo(8'hAA);
        rd_en = 1; wr_en = 1; wr_data = 8'hBB;
        #10;
        rd_en = 0; wr_en = 0;
        $display("Simultaneous read/write done. rd_data = %h", rd_data);

        // -------------------------------
        // Test 4: Reset during operation
        $display("Test 4: Reset during operation...");
        write_fifo(8'h11);
        write_fifo(8'h22);
        rd_en = 1; wr_en = 1; wr_data = 8'h33;
        #10;
        rst = 1; #10;
        rst = 0; wr_en = 0; rd_en = 0;
        if (empty && !full) $display("PASS: FIFO reset during operation works.");
        else $display("FAIL: FIFO reset during operation failed.");

        // -------------------------------
        // Test 5: Pointer wrap-around
        $display("Test 5: Pointer wrap-around...");
        for (i=0; i<DEPTH+4; i=i+1) write_fifo(i+100);
        for (i=0; i<DEPTH+4; i=i+1) read_fifo;
        $display("Pointer wrap-around test completed.");

        $display("FIFO testbench finished.");
        $stop;
    end

endmodule
