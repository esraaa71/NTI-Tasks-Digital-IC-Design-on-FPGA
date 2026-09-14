module memory #(parameter AWIDTH=5,DWIDTH=8)(clk,wr,rd,addr,data);
input clk,wr,rd;
input [AWIDTH-1:0] addr;
inout [DWIDTH-1:0] data;

reg [DWIDTH-1:0] memory [0:(1<<AWIDTH)-1];

always @(posedge clk)
begin
if(wr)
memory[addr]<=data;
end

assign data=(rd)?memory[addr]:'bz;

endmodule
