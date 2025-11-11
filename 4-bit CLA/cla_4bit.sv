module carry_lookahead_adder #(parameter WIDTH = 4)(
    input  logic [WIDTH-1:0] a, b,
    output logic [WIDTH-1:0] sum,
    output logic carry_out
);

    logic [WIDTH-1:0] g, p;
    logic [WIDTH:0] c;
    assign c[0] = 1'b0;

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
            // Combine all terms plus the all-propagate * c0 case
            assign c[i+1] = (|term) | ((&p[i:0]) & c[0]);
        end
    endgenerate

    assign sum = a ^ b ^ c[WIDTH-1:0];
    assign carry_out = c[WIDTH];

endmodule
