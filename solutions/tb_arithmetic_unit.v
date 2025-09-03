module mux4_1(S0, S1, I0, I1, I2, I3, out);
  input S0, S1, I0, I1, I2, I3;
  output out;

  wire out0, out1, out2, out3, s0_not, s1_not;

  not G1(s0_not, S0), 
      G2(s1_not, S1);

  and G3(out0, I0, s0_not, s1_not),
      G4(out1, I1, S0, s1_not),
      G5(out2, I2, s0_not, S1),
      G6(out3, I3, S0, S1);

  or G7(out, out0, out1, out2, out3);
endmodule


module full_adder(A, B, C_in, S, C_out);

  input A, B, C_in;
  output S, C_out;

  wire x1, a1, a2;

  xor G1(x1, A, B),
      G2(S, x1, C_in);

  and G3(a1, A, B),
      G4(a2, x1, C_in);

  or G5(C_out, a1, a2);

endmodule

module arithmetic_unit (
    input A0, A1, A2, A3,
    input B0, B1, B2, B3,
    input C_in,
    input S0, S1,
    output D0, D1, D2, D3,
    output C_out
);

wire one;
wire zero = 1'b0;

wire B0_out, B1_out, B2_out, B3_out;
wire C0, C1, C2;

wire B0_not, B1_not, B2_not, B3_not;

not G0(B0_not, B0);
not G1(B1_not, B1);
not G2(B2_not, B2);
not G3(B3_not, B3);

not G4(one, zero);

mux4_1 bit_0(S0, S1, B0, B0_not, zero, one, B0_out);
mux4_1 bit_1(S0, S1, B1, B1_not, zero, one, B1_out);
mux4_1 bit_2(S0, S1, B2, B2_not, zero, one, B2_out);
mux4_1 bit_3(S0, S1, B3, B3_not, zero, one, B3_out);

full_adder sum_0(A0, B0_out, C_in, D0, C0);
full_adder sum_1(A1, B1_out, C0, D1, C1);
full_adder sum_2(A2, B2_out, C1, D2, C2);
full_adder sum_3(A3, B3_out, C2, D3, C_out);

endmodule

`timescale 1ns/1ps

module byte_arithmetic_tb();
    // Inputs (8-bit)
    reg [7:0] A_byte = 8'h00;
    reg [7:0] B_byte = 8'h00;
    reg C_in = 0;
    reg [1:0] S = 2'b00;  // Control bits
    
    // Outputs (8-bit)
    wire [7:0] D_byte;
    wire C_out;
    
    // Split into nibbles for the 4-bit units
    wire [3:0] A_lo = A_byte[3:0];
    wire [3:0] A_hi = A_byte[7:4];
    wire [3:0] B_lo = B_byte[3:0];
    wire [3:0] B_hi = B_byte[7:4];
    
    // Inter-unit carry
    wire carry_lo_to_hi;
    
    // Output nibbles
    wire [3:0] D_lo;
    wire [3:0] D_hi;
    
    assign D_byte = {D_hi, D_lo};
    
    // Instantiate the arithmetic units
    arithmetic_unit lo_nibble (
        .A0(A_lo[0]), .A1(A_lo[1]), .A2(A_lo[2]), .A3(A_lo[3]),
        .B0(B_lo[0]), .B1(B_lo[1]), .B2(B_lo[2]), .B3(B_lo[3]),
        .C_in(C_in),
        .S0(S[0]), .S1(S[1]),
        .D0(D_lo[0]), .D1(D_lo[1]), .D2(D_lo[2]), .D3(D_lo[3]),
        .C_out(carry_lo_to_hi)
    );
    
    arithmetic_unit hi_nibble (
        .A0(A_hi[0]), .A1(A_hi[1]), .A2(A_hi[2]), .A3(A_hi[3]),
        .B0(B_hi[0]), .B1(B_hi[1]), .B2(B_hi[2]), .B3(B_hi[3]),
        .C_in(carry_lo_to_hi),
        .S0(S[0]), .S1(S[1]),
        .D0(D_hi[0]), .D1(D_hi[1]), .D2(D_hi[2]), .D3(D_hi[3]),
        .C_out(C_out)
    );
    
    // Initialize waveform dumping
    initial begin
        $dumpfile("byte_ops.vcd");
        $dumpvars(0, byte_arithmetic_tb);
    end
    
    // Test procedure
    initial begin
        // Test 1: Byte Addition (A=55, B=33)
        $display("\n--- TEST 1: BYTE ADDITION (55 + 33) ---");
        A_byte = 8'h55;  // 01010101
        B_byte = 8'h33;  // 00110011
        S = 2'b00;       // Addition mode
        C_in = 0;
        #20;
        $display("Result: %h + %h = %h (Cout=%b)", A_byte, B_byte, D_byte, C_out);
        
        // Test 2: Byte Addition with Carry (55 + 33 + 1)
        $display("\n--- TEST 2: BYTE ADDITION WITH CARRY (55 + 33 + 1) ---");
        C_in = 1;
        #20;
        $display("Result: %h + %h + 1 = %h", A_byte, B_byte, D_byte);
        
        // Test 3: Byte Subtraction (55 - 33)
        $display("\n--- TEST 3: BYTE SUBTRACTION (55 - 33) ---");
        S = 2'b01;       // Subtraction mode
        C_in = 1;        // For 2's complement subtraction
        #20;
        $display("Result: %h - %h = %h", A_byte, B_byte, D_byte);
        
        // Test 4: Byte Increment (55 + 1)
        $display("\n--- TEST 4: BYTE INCREMENT (55 + 1) ---");
        S = 2'b10;       // Increment mode
        C_in = 1;
        #20;
        $display("Result: %h + 1 = %h", A_byte, D_byte);
        
        // Test 5: Byte Decrement (55 - 1)
        $display("\n--- TEST 5: BYTE DECREMENT (55 - 1) ---");
        S = 2'b11;       // Decrement mode
        C_in = 0;
        #20;
        $display("Result: %h - 1 = %h", A_byte, D_byte);
        
        // Final delay before finish
        #50;
        $display("\nAll byte-wide tests completed");
        $finish;
    end
endmodule