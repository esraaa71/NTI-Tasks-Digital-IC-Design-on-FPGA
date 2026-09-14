module ALU (
    input  [5:0] A,
    input  [5:0] B,
    input        Cin,
    input  [2:0] Control,
    output reg [5:0] Output,
    output reg       Cout
);

always @(*) begin
    Output = 6'b000000;
    Cout = 1'b0;

    case (Control)

        3'b000: begin
            {Cout, Output} = A + B + Cin;
        end

        3'b001: begin
            {Cout, Output} = A - B - Cin;
        end

        3'b010: begin
            if (Cin == 1'b0)
                Output = A;
            else
                Output = B;
            Cout = 1'b0;
        end

        3'b011: begin
            Output = -A;
            Cout = 1'b0;
        end

        3'b100: begin
            Output = A ^ B;
            Cout = 1'b0;
        end

        3'b101: begin
            if (A == B)
                Output = 6'b000001;
            else
                Output = 6'b000000;
            Cout = 1'b0;
        end

        3'b110: begin
            Output = {1'b0, A[5:1]};
            Cout = 1'b0;
        end

        3'b111: begin
            Output = $signed(A) >>> 1;
            Cout = 1'b0;
        end

        default: begin
            Output = 6'b000000;
            Cout = 1'b0;
        end

    endcase
end

endmodule
