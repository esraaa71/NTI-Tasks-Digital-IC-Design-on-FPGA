`timescale 1ns/1ps

module Debouncing_cir_tb;

    reg clk;
    reg rst;
    reg sw;

    wire db1;


    // DUT instantiation
    Debouncing_cir dut (
        .clk(clk),
        .rst(rst),
        .sw(sw),
        .db1(db1)
    );


    // Clock generation
    // 20ns period
    always #10 clk = ~clk;



    initial begin

        // Initial values
        clk = 0;
        rst = 1;
        sw  = 0;


        // Reset
        #20;
        rst = 0;



        //==================================
        // Test pressing switch with bounce
        //==================================

        #50;

        // bouncing
        sw = 1;
        #10;
        sw = 0;
        #10;
        sw = 1;
        #10;
        sw = 0;
        #10;
        sw = 1;


        // stable press
        #500;



        //==================================
        // Release switch with bounce
        //==================================

        sw = 0;
        #10;
        sw = 1;
        #10;
        sw = 0;
        #10;
        sw = 1;
        #10;
        sw = 0;


        // stable release
        #500;


        $finish;

    end


endmodule