module sync_fifo #(parameter WIDTH=8, DEPTH=16)
(
    input wr_en, rd_en, clk, rst,             
    input [WIDTH-1:0] wr_data,
    output reg [WIDTH-1:0] rd_data,
    output reg full, empty
);

    // Internal signals
    localparam PTR_WIDTH = $clog2(DEPTH);       // Pointer width calculated internally
    reg [WIDTH-1:0] fifo [0:DEPTH-1];
    reg [PTR_WIDTH-1:0] wr_ptr, rd_ptr;        // Write and read pointers
    reg [PTR_WIDTH:0] count;                   // One extra bit to track full/empty

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            wr_ptr <= 0;
            rd_ptr <= 0;
            count <= 0;
            full <= 0;
            empty <= 1;
        end else begin
            // Write operation
            if (wr_en && !full) begin
                fifo[wr_ptr] <= wr_data;
                wr_ptr <= wr_ptr + 1;           // Wraps naturally
                count <= count + 1;
            end

            // Read operation
            if (rd_en && !empty) begin
                rd_data <= fifo[rd_ptr];
                rd_ptr <= rd_ptr + 1;           // Wraps naturally
                count <= count - 1;
            end

            // Update flags
            full  <= (count == DEPTH);
            empty <= (count == 0);
        end
    end

endmodule
