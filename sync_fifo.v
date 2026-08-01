//`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.08.2026 21:13:34
// Design Name: 
// Module Name: sync_fifo
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

module sync_fifo #(
    parameter DATA_WIDTH = 8,
    parameter DEPTH = 16,
    parameter ADDR_WIDTH = 4      // log2(DEPTH)
)(
    input                         clk,
    input                         rst,
    input                         wr_en,
    input                         rd_en,
    input  [DATA_WIDTH-1:0]       din,
    output reg [DATA_WIDTH-1:0]   dout,
    output                        full,
    output                        empty
);

    // FIFO Memory
    reg [DATA_WIDTH-1:0] mem [0:DEPTH-1];

    // Read & Write Pointers
    reg [ADDR_WIDTH-1:0] wr_ptr;
    reg [ADDR_WIDTH-1:0] rd_ptr;

    // Counter
    reg [ADDR_WIDTH:0] count;

    // Status Flags
    assign full  = (count == DEPTH);
    assign empty = (count == 0);

    integer i;

    always @(posedge clk) begin

        if (rst) begin

            wr_ptr <= 0;
            rd_ptr <= 0;
            count  <= 0;
            dout   <= 0;

            for(i=0;i<DEPTH;i=i+1)
                mem[i] <= 0;

        end
        else begin

            // WRITE ONLY
            if (wr_en && !full && !(rd_en && !empty)) begin

                mem[wr_ptr] <= din;
                wr_ptr <= wr_ptr + 1;
                count <= count + 1;

            end

            // READ ONLY
            else if (rd_en && !empty && !(wr_en && !full)) begin

                dout <= mem[rd_ptr];
                rd_ptr <= rd_ptr + 1;
                count <= count - 1;

            end

            // READ + WRITE SAME CLOCK
            else if (wr_en && !full && rd_en && !empty) begin

                mem[wr_ptr] <= din;
                dout <= mem[rd_ptr];

                wr_ptr <= wr_ptr + 1;
                rd_ptr <= rd_ptr + 1;

                // count remains same

            end

        end

    end

endmodule

