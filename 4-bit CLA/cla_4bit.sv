module carry_lookahead_adder #(
    parameter int N = 4
)(
    input  logic [N-1:0] A, B,
    input  logic          Cin,
    output logic [N-1:0]  Sum,
    output logic          Cout
);

    logic [N-1:0] G, P;
    logic [N:0]   C;

    assign C[0] = Cin;

    assign G = A & B; //Carry generate
    assign P = A ^ B; // Carry propagate

    // Carry Look-Ahead Logic
    genvar i;
    generate
        for (i = 0; i < N; i++) begin : carry_block
            assign C[i+1] = G[i] | (P[i] & C[i]);
        end
    endgenerate

    // Sum
    assign Sum = P ^ C[N-1:0];

    // Carry out
    assign Cout = C[N];

endmodule
