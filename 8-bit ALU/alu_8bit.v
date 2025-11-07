module alu_8bit(
input [3:0] opcode, //4-bit opcode input to select operation
input [7:0] operand_a, //8-bit operand 1 input
input [7:0] operand_b, //8-bit operand 2 input
output reg [15:0] alu_out, //16-bit ALU output(to handle multiplication)
output reg cout, //Carry flag if there's overflow from bit 7
5
output reg bout //Borrow flag
);
reg [8:0] temp_result;
always @(*) begin
cout=1'b0; //Default value
bout=1'b0; //Default value
case (opcode)
// Arithmetic operations
4'b0000: begin // Addition
temp_result = operand_a + operand_b;
alu_out = {8'b0, temp_result[7:0]}; //Store lower 8 bits
cout = temp_result[8]; //Carry out from bit 8
end
4'b0001: begin // Subtraction
temp_result = operand_a - operand_b; //Store lower 8 bits
alu_out = {8'b0, temp_result[7:0]}; //Borrow if MSB is 0 after subtraction
bout = ~temp_result[8];
end
4'b0010: alu_out = operand_a * operand_b; // Multiplication
4'b0011: alu_out = (operand_b != 0) ? operand_a % operand_b : 16'd0; // Modulo division
// Bitwise shift operations
4'b0100: alu_out = {8'b0, operand_a << 1}; // Logical Left Shift
4'b0101: alu_out = {8'b0, operand_a >> 1}; // Logical Right Shift
4'b0110: alu_out = {operand_a[7], operand_a[7:1]}; // Arithmetic Shift Right
// Logical operations
4'b0111: alu_out = {8'b0, ~operand_a[7:0]}; // NOT
4'b1000: alu_out = {8'b0, operand_a | operand_b}; // OR
4'b1001: alu_out = {8'b0, operand_a & operand_b}; // AND
4'b1010: alu_out = {8'b0, operand_a ^ operand_b}; // XOR
4'b1011: alu_out = {8'b0, ~(operand_a | operand_b)}; // NOR
4'b1100: alu_out = {8'b0, ~(operand_a & operand_b)}; // NAND
4'b1101: alu_out = {8'b0, ~(operand_a ^ operand_b)}; // XNOR
// Comparison operations
4'b1110: alu_out = (operand_a > operand_b) ? 16'd1 : 16'd0; // Greater than or less than
4'b1111: alu_out = (operand_a == operand_b) ? 16'd1 : 16'd0; // Equal
default: alu_out=16'd0; //don't care
endcase
end
endmodule
