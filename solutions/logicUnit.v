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

`timescale 1ns/1ps

module byteLogic_tb;
    // Inputs
    reg [7:0] A;
    reg [7:0] B;
    reg [1:0] S;
    
    // Outputs
    wire [7:0] Y;
    
    // Instantiate the Unit Under Test (UUT)
    byteLogic uut (
        .A(A),
        .B(B),
        .S(S),
        .Y(Y)
    );
    
    initial begin
        // Initialize Inputs
        A = 8'b0;
        B = 8'b0;
        S = 2'b00;
        
        // Monitor changes
        $monitor("Time=%0t A=%b B=%b S=%b Y=%b", 
                $time, A, B, S, Y);
        
        // Test cases
        // AND operation
        #10 A = 8'b10101010; B = 8'b11001100; S = 2'b00;
        
        // OR operation
        #10 A = 8'b10101010; B = 8'b11001100; S = 2'b01;
        
        // XOR operation
        #10 A = 8'b10101010; B = 8'b11001100; S = 2'b10;
        
        // NOT operation
        #10 A = 8'b10101010; B = 8'b11001100; S = 2'b11;
        
        // Additional test cases
        #10 A = 8'b11110000; B = 8'b10100101; S = 2'b00;
        #10 A = 8'b11110000; B = 8'b10100101; S = 2'b01;
        #10 A = 8'b11110000; B = 8'b10100101; S = 2'b10;
        #10 A = 8'b11110000; S = 2'b11;  // B doesn't matter for NOT
        
        #10 $finish;
    end
endmodule