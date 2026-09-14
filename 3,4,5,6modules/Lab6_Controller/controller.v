module controller(opcode,phase,zero,sel,rd,ld_ir,inc_pc,halt,ld_pc,data_e,ld_ac,wr);
input [2:0] opcode,phase;
input zero;
output reg sel,rd,ld_ir,inc_pc,halt,ld_pc,data_e,ld_ac,wr;

reg aluop,skz,jmp,sto,hlt;

always @(*)
begin
aluop=(opcode==3'b010)||(opcode==3'b011)||(opcode==3'b100)||(opcode==3'b101);
skz=(opcode==3'b001);
jmp=(opcode==3'b111);
sto=(opcode==3'b110);
hlt=(opcode==3'b000);

sel=0;
rd=0;
ld_ir=0;
inc_pc=0;
halt=0;
ld_pc=0;
data_e=0;
ld_ac=0;
wr=0;

case(phase)
3'b000:
begin
sel=1;
end

3'b001:
begin
sel=1;
rd=1;
end

3'b010:
begin
sel=1;
rd=1;
ld_ir=1;
end

3'b011:
begin
sel=1;
rd=1;
ld_ir=1;
end

3'b100:
begin
inc_pc=1;
halt=hlt;
end

3'b101:
begin
rd=aluop;
end

3'b110:
begin
rd=aluop;
inc_pc=skz&zero;
ld_pc=jmp;
data_e=sto;
end

3'b111:
begin
rd=aluop;
ld_pc=jmp;
data_e=sto;
ld_ac=aluop;
wr=sto;
end
endcase
end

endmodule
