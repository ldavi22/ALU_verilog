module testbench;
    reg a, b, c, d;  // Inputs (registers)
    wire e1, e2, e3; // Outputs (wires)

    first U1 (e1, a, b, c, d);
    second U2 (e2, a, b, c, d);
    third U3 (e3, a, b, c, d);

    // Initial block: Executes once at the beginning of the simulation
    initial begin
        $dumpfile("testbench.vcd"); // Save waveform data for visualization
        $dumpvars(0, testbench); // Dump all variables

        // Print header for monitoring output in terminal
        $display("Time | A B C D | E1 E2 E3");
        $monitor("%g | %b %b %b %b | %b  %b  %b", $time, a, b, c, d, e1, e2, e3);

        // Apply different test cases with 10ns delay
        a = 0; b = 0; c = 0; d = 0; #10;
        a = 0; b = 0; c = 0; d = 1; #10;
        a = 0; b = 0; c = 1; d = 0; #10;
        a = 0; b = 0; c = 1; d = 1; #10;
        a = 0; b = 1; c = 0; d = 0; #10;
        a = 0; b = 1; c = 0; d = 1; #10;
        a = 0; b = 1; c = 1; d = 0; #10;
        a = 0; b = 1; c = 1; d = 1; #10;
        a = 1; b = 0; c = 0; d = 0; #10;
        a = 1; b = 0; c = 0; d = 1; #10;
        a = 1; b = 0; c = 1; d = 0; #10;
        a = 1; b = 0; c = 1; d = 1; #10;
        a = 1; b = 1; c = 0; d = 0; #10;
        a = 1; b = 1; c = 0; d = 1; #10;
        a = 1; b = 1; c = 1; d = 0; #10;
        a = 1; b = 1; c = 1; d = 1; #10;

        $finish; // End simulation
    end
endmodule