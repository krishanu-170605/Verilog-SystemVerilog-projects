module alu_8bit_tb();
reg [3:0] opcode;
reg [7:0] operand_a;
reg [7:0] operand_b;
wire [15:0] alu_out;
wire cout;
6
wire bout;
alu_8bit uut (.opcode(opcode), .operand_a(operand_a), .operand_b(operand_b), .alu_out(alu_out), .cout(cout), .bout(bout)); //instantiating the source code
integer i; //declaring variable i to iterate over a loop to generate opcode
initial begin
$monitor ("Time = %0t, Opcode = %0b, Operand A = %0b, Operand B = %0b, ALU output = %0b, Carry out = %0b, Borrow out= %0b",$time,opcode,operand_a,operand_b,alu_out,cout,bout); //Prints simulation results
operand_a=8'b00000000; operand_b=8'b00000000;
for (i=0;i<=15;i=i+1) //Iterating from 4'b0000 to 4'b1111
begin
opcode=i;
operand_a=$random; //Generating a random 8-bit number
operand_b=$random; //Generating a random 8-bit number
#10; //10 time units delay
end
#50 $stop; //Stop simulation
end
endmodule
