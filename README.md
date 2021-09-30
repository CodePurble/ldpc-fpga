# ldpc-fpga
Playground for implementing LDPC codes on FPGA

The work contained in this repository is focused on implementing a multiplier to be used to in an LDPC encoder. The multiplier used modulo-2 arithmetic.

* The [`main`](https://github.com/CodePurble/ldpc-fpga/tree/main) branch contains a brute-force and naive implementation of the multiplier (it is unlikely to be of any practical use.
* The [`re-arch`](https://github.com/CodePurble/ldpc-fpga/tree/re-arch) branch contains a more practical design for the multiplier. **Highly recommended you check this branch, since more meaningful stuff is here**

Both implementations are, however, intended to be very fast. Take a look at [`notes.md`](https://github.com/CodePurble/ldpc-fpga/blob/main/notes.md) for details on the size of parity check matrices that are used in various standards.
