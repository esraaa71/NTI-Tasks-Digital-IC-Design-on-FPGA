module decoder #(parameter N=2)(en,in,out);
input en;
input [N-1:0] in;
output [((1<<N)-1):0] out;

assign out=(en)?(1'b1<<in):{((1<<N)){1'b0}};

endmodule
