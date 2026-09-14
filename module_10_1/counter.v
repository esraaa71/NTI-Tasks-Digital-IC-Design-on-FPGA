module counter #(parameter WIDTH=5)(clk,rst,load,enab,cnt_in,cnt_out);
input clk,rst,load,enab;
input [WIDTH-1:0] cnt_in;
output reg [WIDTH-1:0] cnt_out;

reg [WIDTH-1:0] cnt_next;

function [WIDTH-1:0] count_func;
input [WIDTH-1:0] cnt_out;
input [WIDTH-1:0] cnt_in;
input load,enab;
begin
if(load)
count_func=cnt_in;
else if(enab)
count_func=cnt_out+1'b1;
else
count_func=cnt_out;
end
endfunction

always @(*)
begin
cnt_next=count_func(cnt_out,cnt_in,load,enab);
end

always @(posedge clk)
begin
if(rst)
cnt_out<=0;
else
cnt_out<=cnt_next;
end

endmodule
