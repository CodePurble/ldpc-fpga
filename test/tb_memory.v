module tb_memory();

parameter ADDR_W = 3;
parameter DATA_W = 5;
reg [ADDR_W-1:0] addr;
reg clk, o_en, rw;
reg [DATA_W-1:0] data_in;
wire [DATA_W-1:0] data_out;

memory #(.ADDR_W(ADDR_W), .DATA_W(DATA_W)) uut(
    .addr(addr),
    .o_en(o_en),
    .data_in(data_in),
    .data_out(data_out),
    .rw(rw),
    .clk(clk)
);

initial
begin
    clk = 0;
    o_en = 0;
    $dumpfile("../sim/tb_memory_dump.vcd");
    $dumpvars(0, tb_memory);
end

always #10 clk = ~clk;

initial
begin: test
    integer i;

    rw = 1;
    for(i = 0; i < 2**ADDR_W; i+=1) begin
        #20 addr = i;
        data_in = i;
    end

    rw = 0;
    o_en = 1;
    for(i = 0; i < 2**ADDR_W; i+=1) begin
        #20 addr = i;
    end
    #20 $finish;
end

endmodule
