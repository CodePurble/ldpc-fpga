`timescale 1us/1ns

module tb_streambuf_in();

parameter DATA_WIDTH = 4;
parameter ADDR_WIDTH = 2;

reg clk;
reg rst;
wire [DATA_WIDTH-1:0] data_out;

streambuf_in #(.DATA_WIDTH(4), .ADDR_WIDTH(2)) uut(
    .clk(clk),
    .rst(rst),
    .data_out(data_out)
);

initial
begin
    $dumpfile("../sim/tb_streambuf_in.vcd");
    $dumpvars(0, tb_streambuf_in);
    clk = 0;
    rst = 0;
    #5 rst = 1;
    #10 rst = 0;
    #100 $finish;
end
always #10 clk = ~clk;

endmodule
