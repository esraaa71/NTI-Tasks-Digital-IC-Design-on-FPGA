module light_chaser_tb;

reg clk_50m;
reg reset_n;
reg hold_n;

wire clk_out;
wire shift_out;

clk_div #(4) c1(clk_50m,reset_n,clk_out);
shift_reg #(10) s1(clk_out,reset_n,hold_n,shift_out);

initial
begin
clk_50m=0;
forever #5 clk_50m=~clk_50m;
end

initial
begin
reset_n=0;
hold_n=1;

#20 reset_n=1;

#200 hold_n=0;

#50 hold_n=1;

#200 $finish;
end

endmodule
