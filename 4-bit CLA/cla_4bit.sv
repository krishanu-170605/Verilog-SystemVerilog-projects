module carry_lookahead_adder #(parameter WIDTH = 4)(
    input  logic [WIDTH-1:0] a, b,
    input  logic              cin,        
    output logic [WIDTH-1:0] sum,
    output logic              carry_out
);

    logic [WIDTH-1:0] g, p;
    logic [WIDTH:0] c;

    // Initialize carry chain with cin
    assign c[0] = cin;

    // Generate and propagate
    assign g = a & b;
    assign p = a ^ b;

    genvar i, j;
    generate
        for (i = 0; i < WIDTH; i++) begin : carry_bits
            logic [i:0] term;
            assign term[0] = g[i];

            // Build the propagate-generate chain
            for (j = 0; j < i; j++) begin : prop_chain
                assign term[j+1] = (&p[i -: (j+1)]) & g[i-j-1];
            end

            // Combine all terms plus the all-propagate * c[0] case
            assign c[i+1] = (|term) | ((&p[i:0]) & c[0]);
        end
    endgenerate

    // Final sum and carry-out
    assign sum = a ^ b ^ c[WIDTH-1:0];
    assign carry_out = c[WIDTH];

endmodule
