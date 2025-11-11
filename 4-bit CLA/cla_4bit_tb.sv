module cla_tb;

    parameter WIDTH = 4;

    logic [WIDTH-1:0] A, B;
    logic Cin;
    logic [WIDTH-1:0] Sum;
    logic Carry_out;

    
  carry_lookahead_adder #(.WIDTH(WIDTH)) uut (
        .a(A),
        .b(B),
        .cin(Cin),
        .sum(Sum),
        .carry_out(Carry_out)
    );

    integer i, j, k;

    initial begin
        $dumpfile("waves.vcd");
        $dumpvars;
        
      $display("Time |  A   |  B   | Cin | Sum  | Cout");
        $display("-------------------------------------------------------------");
        $monitor("%4t | %b | %b |  %b  | %b |  %b",
                 $time, A, B, Cin, Sum, Carry_out);

        
        for (i = 0; i < (1 << WIDTH); i = i + 1) begin
            for (j = 0; j < (1 << WIDTH); j = j + 1) begin
                for (k = 0; k < 2; k = k + 1) begin
                    A   = i[WIDTH-1:0];
                    B   = j[WIDTH-1:0];
                    Cin = k[0];
                    #5;

                    
                    if ({Carry_out, Sum} !== ({1'b0, A} + {1'b0, B} + Cin)) begin
                        $error("Mismatch: %0d + %0d + Cin=%0d => Expected %0d, Got {Cout:%b, Sum:%0d}",
                               A, B, Cin, A + B + Cin, Carry_out, Sum);
                    end
                end
            end
        end

        $display("-------------------------------------------------------------");
        $display("All %0d combinations verified successfully!",
                 (1 << (2 * WIDTH)) * 2);
        $finish;
    end

endmodule
