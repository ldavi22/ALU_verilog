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