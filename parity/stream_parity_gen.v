module stream_parity_gen (
    input  wire clk,
    input  wire reset,
    input  wire serial_in,

    output reg  parity_out,
    output reg  valid
);

    reg [2:0] bit_count;     // counts 0 to 7
    reg parity_reg;          // stores running XOR

    always @(posedge clk) begin
        
        if (reset) begin
            bit_count <= 3'b000;
            parity_reg <= 1'b0;
            parity_out <= 1'b0;
            valid <= 1'b0;
        end

        else begin

            valid <= 1'b0;   // default state

            // receive serial bits
            if (bit_count < 3'd7) begin
                
                parity_reg <= parity_reg ^ serial_in;
                bit_count <= bit_count + 1'b1;

            end

            // 8th bit received
            else begin

                parity_out <= parity_reg ^ serial_in;
                valid <= 1'b1;

                // prepare for next byte
                bit_count <= 3'b000;
                parity_reg <= 1'b0;

            end
        end
    end

endmodule
