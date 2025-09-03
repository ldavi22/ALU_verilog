module byte_compare_gate (
  output equal,
  input [7:0] A,
  input [7:0] B
);
  wire [7:0] x;

  xor (x[0], A[0], B[0]);
  xor (x[1], A[1], B[1]);
  xor (x[2], A[2], B[2]);
  xor (x[3], A[3], B[3]);
  xor (x[4], A[4], B[4]);
  xor (x[5], A[5], B[5]);
  xor (x[6], A[6], B[6]);
  xor (x[7], A[7], B[7]);

  nor (equal, x[0], x[1], x[2], x[3], x[4], x[5], x[6], x[7]);
endmodule
