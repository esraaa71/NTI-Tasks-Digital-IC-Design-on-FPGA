`timescale 1ns/1ps

module stream_parity_gen_tb;

reg clk;
reg reset;
reg serial_in;

wire parity_out;
wire valid;
wire [7:0] data_out;


stream_parity_gen DUT(
    .clk(clk),
    .reset(reset),
    .serial_in(serial_in),
    .parity_out(parity_out),
    .valid(valid),
    .data_out(data_out)
);


// 10ns clock
always #5 clk = ~clk;



// Send complete byte
task send_byte(input [7:0] data);

integer i;

begin

    for(i=7;i>=0;i=i-1)
    begin
        @(negedge clk);
        serial_in = data[i];
    end


    @(posedge clk);


    if(valid)
    begin
        $display(
        "Data = %d | Binary = %b | Parity = %b",
        data_out,
        data_out,
        parity_out
        );
    end

end

endtask



integer value;


initial begin

clk = 0;
reset = 0;
serial_in = 0;


// reset
#10;
reset = 1;

#10;
reset = 0;


// Test all values 0-255

for(value=0; value<256; value=value+1)
begin

    send_byte(value[7:0]);

end


#50;

$stop;

end


endmodule