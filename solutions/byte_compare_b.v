module byte_compare_behavioral (
  output reg equal,
  output reg greater,
  output reg less,
  input [7:0] A,
  input [7:0] B
);
  always @ (A or B) begin
    if (A == B) begin
      equal = 1;
      greater = 0;
      less = 0;
    end else if (A > B) begin
      equal = 0;
      greater = 1;
      less = 0;
    end else begin
      equal = 0;
      greater = 0;
      less = 1;
    end
  end
endmodule
