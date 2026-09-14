module counter_test;

reg clk,rst,load,enab;
reg [4:0] cnt_in;
wire [4:0] cnt_out;

counter #(5) c1(clk,rst,load,enab,cnt_in,cnt_out);

initial
begin
clk=0;
forever #5 clk=~clk;
end

initial
begin
rst=1;
load=0;
enab=0;
cnt_in=5'b00000;

#10 rst=0;
load=1;
enab=1;
cnt_in=5'b10101;

#10 cnt_in=5'b01010;

#10 cnt_in=5'b11111;

#10 rst=1;

#10 rst=0;
load=1;
cnt_in=5'b11111;

#10 load=0;
enab=1;

#40 enab=0;

#20 $finish;
end

initial
begin
$monitor("At time %0t rst=%b load=%b enab=%b cnt_in=%b cnt_out=%b",
         $time,rst,load,enab,cnt_in,cnt_out);
end

endmodule
