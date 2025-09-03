module first(e, a, b, c, d);
    input a, b, c, d;
    output e;
    assign e = (a | ~b) & (~c) & (c | d);
endmodule

module second(e, a, b, c, d);
    input a, b, c, d;
    output e;
    assign e = ((~c & d) | (b & c & d) | (c & ~d)) & (~a | b);
endmodule

module third(e, a, b, c, d);
    input a, b, c, d;
    output e;
    assign e = ((a & b | c) & d) | (~b & c);
endmodule
		