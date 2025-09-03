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
	
    