`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.08.2026 21:14:54
// Design Name: 
// Module Name: tb_sync_top
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

module tb_sync_fifo;

parameter DATA_WIDTH = 8;
parameter DEPTH = 16;
parameter ADDR_WIDTH = 4;

reg clk;
reg rst;
reg wr_en;
reg rd_en;
reg [DATA_WIDTH-1:0] din;

wire [DATA_WIDTH-1:0] dout;
wire full;
wire empty;

// DUT
sync_fifo #(
    .DATA_WIDTH(DATA_WIDTH),
    .DEPTH(DEPTH),
    .ADDR_WIDTH(ADDR_WIDTH)
)
dut(
    .clk(clk),
    .rst(rst),
    .wr_en(wr_en),
    .rd_en(rd_en),
    .din(din),
    .dout(dout),
    .full(full),
    .empty(empty)
);

// Clock Generation
always #5 clk = ~clk;

initial begin

    clk = 0;
    rst = 1;
    wr_en = 0;
    rd_en = 0;
    din = 0;

    //-------------------------
    // RESET
    //-------------------------
    #20;
    rst = 0;

    //-------------------------
    // WRITE 5 DATA
    //-------------------------

    repeat(5)
    begin
        @(posedge clk);
        wr_en = 1;
        din = din + 8'h11;
    end

    @(posedge clk);
    wr_en = 0;

    //-------------------------
    // READ 5 DATA
    //-------------------------

    repeat(5)
    begin
        @(posedge clk);
        rd_en = 1;
    end

    @(posedge clk);
    rd_en = 0;

    //-------------------------
    // FILL FIFO
    //-------------------------

    repeat(16)
    begin
        @(posedge clk);
        wr_en = 1;
        din = din + 1;
    end

    @(posedge clk);
    wr_en = 0;

    //-------------------------
    // EMPTY FIFO
    //-------------------------

    repeat(16)
    begin
        @(posedge clk);
        rd_en = 1;
    end

    @(posedge clk);
    rd_en = 0;

    //-------------------------
    // SIMULTANEOUS READ & WRITE
    //-------------------------

    @(posedge clk);
    wr_en = 1;
    din = 8'hAA;

    @(posedge clk);
    wr_en = 0;

    @(posedge clk);
    wr_en = 1;
    rd_en = 1;
    din = 8'h55;

    @(posedge clk);
    wr_en = 0;
    rd_en = 0;

    #50;

    $finish;

end

// Monitor
initial begin

$monitor("Time=%0t rst=%b wr=%b rd=%b din=%h dout=%h full=%b empty=%b count=%d",
$time,
rst,
wr_en,
rd_en,
din,
dout,
full,
empty,
dut.count);

end

endmodule
