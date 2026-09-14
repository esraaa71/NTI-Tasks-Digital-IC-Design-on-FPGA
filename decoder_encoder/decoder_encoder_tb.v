module decoder_encoder_tb;

reg en;
reg [1:0] din;
wire [3:0] dout;

reg [3:0] ein;
wire [3:0] eout;

decoder #(2) d1(en,din,dout);
encoder #(4) e1(en,ein,eout);

initial
begin

en=0;
din=0;
ein=0;

#10 en=1;
#10 din=2'b00; ein=4'b0001;
#10 din=2'b01; ein=4'b0010;
#10 din=2'b10; ein=4'b0100;
#10 din=2'b11; ein=4'b1000;

#10 en=0;

#10 $finish;

end

endmodule
