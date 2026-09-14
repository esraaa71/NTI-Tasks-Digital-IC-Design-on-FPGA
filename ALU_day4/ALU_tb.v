`timescale 1ns/1ps

module ALU_tb;

reg [5:0] A;
reg [5:0] B;
reg Cin;
reg [2:0] Control;

wire [5:0] Output;
wire Cout;

ALU uut (
    .A(A),
    .B(B),
    .Cin(Cin),
    .Control(Control),
    .Output(Output),
    .Cout(Cout)
);

initial begin

    A = 6'b001010;
    B = 6'b000101;
    Cin = 0;
    Control = 3'b000;
    #10;

    A = 6'b001010;
    B = 6'b000101;
    Cin = 1;
    Control = 3'b000;
    #10;

    A = 6'b001010;
    B = 6'b000101;
    Cin = 0;
    Control = 3'b001;
    #10;

    A = 6'b001010;
    B = 6'b000101;
    Cin = 1;
    Control = 3'b001;
    #10;

    A = 6'b101010;
    B = 6'b010101;
    Cin = 0;
    Control = 3'b010;
    #10;

    A = 6'b101010;
    B = 6'b010101;
    Cin = 1;
    Control = 3'b010;
    #10;

    A = 6'b000101;
    B = 6'b000000;
    Cin = 0;
    Control = 3'b011;
    #10;

    A = 6'b101010;
    B = 6'b110011;
    Cin = 0;
    Control = 3'b100;
    #10;

    A = 6'b101010;
    B = 6'b101010;
    Cin = 0;
    Control = 3'b101;
    #10;

    A = 6'b101010;
    B = 6'b101011;
    Cin = 0;
    Control = 3'b101;
    #10;

    A = 6'b101100;
    B = 6'b000000;
    Cin = 0;
    Control = 3'b110;
    #10;

    A = 6'b101100;
    B = 6'b000000;
    Cin = 0;
    Control = 3'b111;
    #10;

    $stop;

end

endmodule
