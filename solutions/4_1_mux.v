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
