module counter(
    clk,
    rst,
    en,
    stop_val,
    count,
    stop
);

parameter COUNT_MAX_BITS = 10;

input clk, en, rst;
input [COUNT_MAX_BITS-1:0] stop_val;
output reg stop;
output reg [COUNT_MAX_BITS-1:0] count;

always @(posedge clk)
begin
    if(rst) begin
        count = 0;
        stop = 0;
    end
    else if(en) begin
        if(count == stop_val) begin
            stop = 1;
        end
        else begin
            count = count + 1;
        end
    end
end

endmodule
