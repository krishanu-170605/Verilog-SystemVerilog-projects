module cla_tb;

    localparam int N = 4;

    logic [N-1:0] A, B;
    logic Cin;
    logic [N-1:0] Sum;
    logic Cout;

    carry_lookahead_adder #(N) uut (
        .A(A), .B(B), .Cin(Cin),
        .Sum(Sum), .Cout(Cout)
    );

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars;
        $display("Time |   A   |   B   | Cin |  Sum  | Cout");
        $monitor("%4t | %b | %b |  %b  | %b |  %b",
                 $time, A, B, Cin, Sum, Cout);

      for(int a=0;a<(1<<N);a++) begin
        for(int b=0;b<(1<<N);b++) begin
          for(int c=0;c<2;c++) begin
            A=a;
            B=b;
            Cin=c;
            #10;
          end
        end
      end

        $finish;
    end

endmodule
