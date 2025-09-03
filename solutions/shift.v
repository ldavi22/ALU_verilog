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

`timescale 1ns/1ps

module serialByteShift_tb;
    // Inputs
    reg [7:0] A;
    reg S0, SL, SR;
    
    // Outputs
    wire [7:0] B;
    
    // Instantiate the Unit Under Test (UUT)
    serialByteShift uut (
        .A(A),
        .B(B),
        .S0(S0),
        .SL(SL),
        .SR(SR)
    );
    
    initial begin
        // Initialize Inputs
        A = 8'b0;
        S0 = 0;
        SL = 0;
        SR = 0;
        
        // Monitor changes
        $monitor("Time=%0t A=%b S0=%b SL=%b SR=%b B=%b", 
                $time, A, S0, SL, SR, B);
        
        // Test cases
        // Right shift tests (S0=0)
        #10 A = 8'b10101010; S0 = 0; SR = 1;
        #10 A = 8'b11001100; S0 = 0; SR = 0;
        
        // Left shift tests (S0=1)
        #10 A = 8'b01010101; S0 = 1; SL = 1;
        #10 A = 8'b00110011; S0 = 1; SL = 0;
        
        // Edge cases
        #10 A = 8'b11111111; S0 = 0; SR = 0;
        #10 A = 8'b00000000; S0 = 1; SL = 1;
        
        #10 $finish;
    end
endmodule