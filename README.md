# ldpc-fpga
Playground for implementing LDPC codes on FPGA

The work contained in this repository is focused on implementing a multiplier to be used to in an LDPC encoder. The multiplier used modulo-2 arithmetic.

* The [`main`](https://github.com/CodePurble/ldpc-fpga/tree/main) branch contains a brute-force and naive implementation of the multiplier (it is unlikely to be of any practical use.
* The [`re-arch`](https://github.com/CodePurble/ldpc-fpga/tree/re-arch) branch (this branch) contains a more practical design for the multiplier.

Both implementations are, however, intended to be very fast. Take a look at [`notes.md`](https://github.com/CodePurble/ldpc-fpga/blob/main/notes.md) for details on the size of parity check matrices that are used in various standards.

## ⚠️ Important ⚠️
The current state of this branch is unusable. Commits prefixed with `wip` are those that contain partially working or broken implementations. For the last working implementation, see commit [`9727b4b`](https://github.com/CodePurble/ldpc-fpga/commit/9727b4bf16ffcc5572a6b557ddc749873093d5c3).

The code in commit [`9727b4b`](https://github.com/CodePurble/ldpc-fpga/commit/9727b4bf16ffcc5572a6b557ddc749873093d5c3). currently fails to pass the implementation stage in Vivado (targetting the Basys3 FPGA) for dimensions of `2304 x 1536` due to resource overutilization. I think the problem lies in the I/O, as I am trying to ingenst _all_ the data at once, leading to a ~3000% overutilization of I/O resources. My idea to fix this is to use buffered I/O, which is what has been attempted in commit [`c43ff71`](https://github.com/CodePurble/ldpc-fpga/commit/c43ff716934e0f8d2037f42538fb40e554a4eadf). 2 buffers (one each for input and output) have been implemented and tested ([input buffer](https://github.com/CodePurble/ldpc-fpga/blob/re-arch/hdl/streambuf_in.v), [output buffer](https://github.com/CodePurble/ldpc-fpga/blob/re-arch/hdl/streambuf_out.v)). What remains to be done is integrate these into the overall design ([this module](https://github.com/CodePurble/ldpc-fpga/blob/re-arch/hdl/encoder.v)). The buffers operate on a smaller slice of the data, and can mitigate the massive overutilisation problem.

## Module descriptions

All modules are present in the `hdl` directory, testbenches are in the `test` directory. Behavioural simulation has been done using `iverilog`, synthesis, implementation and place-route has been done using Xilinx Vivado. The top level module is `hdl/encode.v` so use that as the top module when importing into Xilinx Vivado.

```verilog
module counter(
    clk, // clock (rising edge)
    rst, // synchronous reset
    en, // enable
    stop_val, // value to stop counting at
    count, // counting output
    stop // asserted high once stop_val is reached
);

parameter COUNT_MAX_BITS = 10;

input clk, en, rst;
input [COUNT_MAX_BITS-1:0] stop_val;
output reg stop;
output reg [COUNT_MAX_BITS-1:0] count;
```

```verilog
module mod2mul(
    info_bit_slice, // information bits (1 x K)
    generator_col_slice, // vector representing a single column of the generator matrix (K x 1)
    code_bit // encoded bit
);

parameter SLICE_SIZE = 3;

input [SLICE_SIZE-1:0] info_bit_slice;
input [SLICE_SIZE-1:0] generator_col_slice;
output code_bit;
```

```verilog
// This is a RAM-like shift register
module streambuf_in(
    clk, // clock
    rst, // internal address counter reset
    data_out
);

parameter DATA_WIDTH = 16;
parameter ADDR_WIDTH = 2;

input clk;
input rst;
output reg [DATA_WIDTH-1:0] data_out;
```

```verilog
// This is also like a RAM-like shift register
module streambuf_out(
    clk, // clock
    rst, // internal address counter reset
    read, // assert high when you want to read data from the buffer
    data_in,
    data_out
);

parameter DATA_WIDTH = 16;
parameter ADDR_WIDTH = 2;

input clk, rst, read;
input [DATA_WIDTH-1:0] data_in;
output reg [DATA_WIDTH-1:0] data_out;

```
