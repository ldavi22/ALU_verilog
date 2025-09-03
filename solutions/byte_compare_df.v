module byte_compare_df (
  output equal,
  output greater,
  output less,
  input [7:0] A,
  input [7:0] B
);
  assign equal   = (A == B);
  assign greater = (A > B);
  assign less    = (A < B);

endmodule
