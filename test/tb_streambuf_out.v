`timescale 1us/1ns

module tb_streambuf_out();

parameter DATA_WIDTH = 4;
parameter ADDR_WIDTH = 2;

reg clk;
reg rst;
reg read;
reg [DATA_WIDTH-1:0] data_in;
wire [DATA_WIDTH-1:0] data_out;

streambuf_out #(.DATA_WIDTH(4), .ADDR_WIDTH(2)) uut(
    .clk(clk),
    .rst(rst),
    .read(read),
    .data_in(data_in),
    .data_out(data_out)
);

initial
begin
    $dumpfile("../sim/tb_streambuf_out.vcd");
    $dumpvars(0, tb_streambuf_out);
    clk = 0;
    rst = 0;
    read = 0;
    #5 rst = 1;
    #10 rst = 0; data_in = 4'b1111;
    #20 data_in = 4'b0000;
    #20 data_in = 4'b1111;
    #20 data_in = 4'b0000;
    #10 read = 1; rst = 1;
    #10 rst = 0;
    #100 $finish;
end
always #10 clk = ~clk;

endmodule

