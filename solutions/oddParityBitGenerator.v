module oddParityBitGenerator(a0,a1,a2,odd_parity_bit);

output odd_parity_bit;
input a0,a1,a2;

wire w1,w2,w3,w4,w5; 

not G1(w1,a0);
xor G2(w2,a1,a2);
xnor G3(w3,a1,a2);
and G4(w4,w3,a0);
and  G5(w5,w2,w1);
nor G6(odd_parity_bit,w5,w4);


endmodule