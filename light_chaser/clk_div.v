module clk_div #(parameter DIV=6250000)(clk_50m,reset_n,clk_out);
input clk_50m,reset_n;
output reg clk_out;

reg [31:0] count;

always @(posedge clk_50m or negedge reset_n)
begin
if(!reset_n)
begin
count<=0;
clk_out<=0;
end
else if(count==DIV-1)
begin
count<=0;
clk_out<=~clk_out;
end
else
count<=count+1;
end

endmodule
