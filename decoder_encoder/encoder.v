module encoder #(parameter N=4)(en,in,out);
input en;
input [N-1:0] in;
output reg [N-1:0] out;

integer i;

always @(*)
begin
out=0;
if(en)
begin
for(i=0;i<N;i=i+1)
begin
if(in[i])
out=i;
end
end
end

endmodule
