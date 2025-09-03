`timescale 1ns/1ps

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

module byteLogic(A,B,S,Y);
    input [7:0] A;
    input [7:0] B;
    input [1:0] S;
    output reg [7:0] Y;

    always @(*) begin
        case (S)
            2'b00: Y = A & B;  // AND
            2'b01: Y = A | B;  // OR
            2'b10: Y = A ^ B;  // XOR
            2'b11: Y = ~A;     // NOT
            default: Y = 8'b0;  // Default case
        endcase
    end
endmodule

module serialByteShift(A,B,S0,SL,SR);
    input [7:0] A;
    output reg [7:0] B;
    input S0, SL, SR;

    always @(*) begin
        case(S0)
            1'b0: begin  // Right shift operation with SR input
                B = {A[6:0], SR};
            end
            1'b1: begin  // Left shift operation with SL input
                B = {SL, A[7:1]};
            end
        endcase
    end
endmodule
