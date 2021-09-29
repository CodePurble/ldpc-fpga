`timescale 1us/1ns

module tb_counter();

parameter COUNT_MAX_BITS = 3;

reg clk, en, rst;
reg [COUNT_MAX_BITS-1:0] stop_val;
wire stop;
wire [COUNT_MAX_BITS-1:0] count;

counter #(COUNT_MAX_BITS) uut(
    .clk(clk),
    .rst(rst),
    .en(en),
    .stop_val(stop_val),
    .count(count),
    .stop(stop)
);

initial
begin
    $dumpfile("../sim/tb_count.vcd");
    $dumpvars(0, tb_counter);
    clk = 0;
    en = 0;
    rst = 0;
    stop_val = 3'b101;
end
always #10 clk = ~clk;

initial
begin
    #5 rst = 1; en = 1;
    #10 rst = 0;
    #170 $finish;
end

endmodule
