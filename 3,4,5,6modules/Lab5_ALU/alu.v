module alu #(parameter WIDTH=8)(opcode,in_a,in_b,a_is_zero,alu_out);
input [2:0] opcode;
input [WIDTH-1:0] in_a,in_b;
output a_is_zero;
output [WIDTH-1:0] alu_out;

assign a_is_zero=(in_a==0)?1'b1:1'b0;

assign alu_out=(opcode==3'b000)?in_a:
               (opcode==3'b001)?in_a:
               (opcode==3'b010)?in_a+in_b:
               (opcode==3'b011)?in_a&in_b:
               (opcode==3'b100)?in_a^in_b:
               (opcode==3'b101)?in_b:
               (opcode==3'b110)?in_a:
               in_a;

endmodule
