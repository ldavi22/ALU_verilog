`timescale 1ns / 1ps

module comparator_testbench;

  // Declare inputs and outputs
  reg [7:0] A, B;
  wire equal_b, greater_b, less_b;
  wire equal_df, greater_df, less_df;
  wire equal_gl;

  // Instantiate behavioral comparator
  byte_compare_behavioral U1 (
    .equal(equal_b),
    .greater(greater_b),
    .less(less_b),
    .A(A),
    .B(B)
  );

  // Instantiate dataflow comparator
  byte_compare_df U2 (
    .equal(equal_df),
    .greater(greater_df),
    .less(less_df),
    .A(A),
    .B(B)
  );

  // Instantiate gate-level comparator (only equality)
  byte_compare_gate U3 (
    .equal(equal_gl),
    .A(A),
    .B(B)
  );

  // Stimulus block (no display)
  initial begin
    // Test Case 1: A = B
    A = 8'b10101010; B = 8'b10101010; #10;

    // Test Case 2: A > B
    A = 8'b11110000; B = 8'b10101010; #10;

    // Test Case 3: A < B
    A = 8'b01010101; B = 8'b10101010; #10;

    // Test Case 4: A = 0, B = 255
    A = 8'b00000000; B = 8'b11111111; #10;

    // Test Case 5: A = 255, B = 0
    A = 8'b11111111; B = 8'b00000000; #10;

    $finish;
  end

endmodule
