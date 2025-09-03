module twoToFourDecoder(a0, a1, b0, b1, b2, b3);

  input a0, a1;
  output b0, b1, b2, b3;

  wire na0, na1;

  not (na0, a0);
  not (na1, a1);

  and (b0, na0, na1); // 00
  and (b1, na0, a1);  // 01
  and (b2, a0, na1);  // 10
  and (b3, a0, a1);   // 11

endmodule


module tb_twoToFourDecode;

reg a0,a1;
wire b0,b1,b2,b3;

twoToFourDecoder tb (a0,a1,b0,b1,b2,b3);

initial 
    begin
    
    a0 = 0; a1 = 0;
	#20;
	a0 = 0; a1 = 1;
	#20;
	a0 = 1; a1 = 0; 
	#20;
	a0 = 1; a1 = 1; 
	
	end
	
	initial #100 $finish;
endmodule
	
    


