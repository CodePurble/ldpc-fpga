// when writing to this buffer, data_out is latched onto the previous value
// it held. Inputs do not affect the output when writing.
//
// NOTE: Remember to pulse rest during a rising edge to reset the counter
// between reads and writes to start reading/writing from the first address
module streambuf_out(
    clk,
    rst,
    read,
    data_in,
    data_out
);

parameter DATA_WIDTH = 16;
parameter ADDR_WIDTH = 2;

input clk, rst, read;
input [DATA_WIDTH-1:0] data_in;
output reg [DATA_WIDTH-1:0] data_out;

/* wire cnt_rst;
assign cnt_rst = rst | read; */

reg [DATA_WIDTH-1:0] internal_mem [0:(2**ADDR_WIDTH)-1];

wire cnt_en, cnt_stop;
wire [ADDR_WIDTH-1:0] cnt_stop_val;
wire [ADDR_WIDTH-1:0] cnt_count;

assign cnt_en = 1;
assign cnt_stop_val = (2**ADDR_WIDTH)-1;

counter #(.COUNT_MAX_BITS(ADDR_WIDTH)) cnt(
    .clk(clk),
    .rst(rst),
    .en(cnt_en),
    .stop_val(cnt_stop_val),
    .count(cnt_count),
    .stop(cnt_stop)
);

always @(negedge clk)
begin
    if(read) begin
        data_out = internal_mem[cnt_count];
    end
    else begin
        internal_mem[cnt_count] = data_in;
    end
end

endmodule

