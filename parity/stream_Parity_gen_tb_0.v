`timescale 1ns/1ps

module stream_parity_gen_tb;

    reg clk;
    reg reset;
    reg serial_in;

    wire parity_out;
    wire valid;


    // DUT
    stream_parity_gen DUT (
        .clk(clk),
        .reset(reset),
        .serial_in(serial_in),
        .parity_out(parity_out),
        .valid(valid)
    );


    // Clock generation (10ns period)
    always #5 clk = ~clk;


    // Task to send 8-bit stream
    task send_byte(input [7:0] data);
        integer i;
        begin

            $display("--------------------------------");
            $display("Sending data = %b", data);

            for(i=7; i>=0; i=i-1) begin
                
                @(negedge clk);
                serial_in = data[i];

                $display("Time=%0t | Bit %0d = %b",
                          $time, 
                          8-i,
                          data[i]);

            end


            // Wait for valid
            @(posedge clk);

            if(valid)
                $display("DONE: Parity = %b at time %0t",
                          parity_out,$time);
            else
                $display("ERROR: VALID not asserted");

        end
    endtask



    initial begin

        // initialize
        clk = 0;
        reset = 0;
        serial_in = 0;


        // reset
        #10;
        reset = 1;

        #10;
        reset = 0;


        // Test 1:
        // 10110010
        // number of ones = 4
        // expected parity = 0
        send_byte(8'b10110010);



        // Test 2:
        // 11100000
        // number of ones = 3
        // expected parity = 1
        send_byte(8'b11100000);



        // Test 3:
        // 00000000
        // number of ones = 0
        // expected parity = 0
        send_byte(8'b00000000);



        #50;

        $stop;

    end


endmodule