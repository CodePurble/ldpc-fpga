// simple 2-port memory
module memory(
    clk,
    addr,
    rw, // 0 is read, 1 is write
    o_en,
    data_out,
    data_in
);

parameter ADDR_W = 3;
parameter DATA_W = 5;
input [ADDR_W-1:0] addr;
input clk, o_en, rw;
input [DATA_W-1:0] data_in;
output reg [DATA_W-1:0] data_out;

reg [DATA_W-1:0] mem [0:(2**ADDR_W)];
always @(posedge clk)
begin
    if(~rw) begin
        if(~o_en) begin
            data_out = 'hz;
        end
        else begin
            data_out <= mem[addr];
        end
    end
    else begin
        mem[addr] <= data_in;
    end
end

endmodule

