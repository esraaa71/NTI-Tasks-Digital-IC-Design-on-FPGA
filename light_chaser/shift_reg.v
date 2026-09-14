module shift_reg #(parameter WIDTH=10)(clk,reset_n,hold_n,shift_out);
input clk,reset_n,hold_n;
output shift_out;

reg [WIDTH-1:0] shift;

assign shift_out=shift[WIDTH-1];

always @(posedge clk or negedge reset_n)
begin
if(!reset_n)
shift<=10'b1000000000;
else if(hold_n)
shift<={shift[WIDTH-2:0],shift[WIDTH-1]};
end

endmodule
