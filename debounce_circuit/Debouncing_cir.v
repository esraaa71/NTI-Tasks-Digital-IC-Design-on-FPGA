`timescale 1ns/1ps

module Debouncing_cir (
    input  wire clk,
    input  wire rst,
    input  wire sw,
    output reg  db1
);

    //================================================
    // m_tick generator (free running counter)
    // clk = 20ns
    // m_tick every 100ns
    //================================================

    parameter WAIT_TOP = 4;

    reg [2:0] counter;
    reg m_tick;


    always @(posedge clk or posedge rst) begin
        if (rst) begin
            counter <= 3'b000;
            m_tick  <= 1'b0;
        end

        else begin
            if (counter == WAIT_TOP) begin
                counter <= 3'b000;
                m_tick  <= 1'b1;
            end

            else begin
                counter <= counter + 1'b1;
                m_tick  <= 1'b0;
            end
        end
    end



    //================================================
    // FSM states
    //================================================

    typedef enum reg [3:0] {
        ZERO,
        WAIT1_1,
        WAIT1_2,
        WAIT1_3,
        ONE,
        WAIT0_1,
        WAIT0_2,
        WAIT0_3
    } state_t;


    state_t cs, ns;



    //================================================
    // Next state logic
    //================================================

    always @(*) begin

        ns = cs;

        case(cs)

            ZERO:
            begin
                if(sw)
                    ns = WAIT1_1;
            end


            WAIT1_1:
            begin
                if(!sw)
                    ns = ZERO;

                else if(m_tick)
                    ns = WAIT1_2;
            end


            WAIT1_2:
            begin
                if(!sw)
                    ns = ZERO;

                else if(m_tick)
                    ns = WAIT1_3;
            end


            WAIT1_3:
            begin
                if(!sw)
                    ns = ZERO;

                else if(m_tick)
                    ns = ONE;
            end



            ONE:
            begin
                if(!sw)
                    ns = WAIT0_1;
            end



            WAIT0_1:
            begin
                if(sw)
                    ns = ONE;

                else if(m_tick)
                    ns = WAIT0_2;
            end



            WAIT0_2:
            begin
                if(sw)
                    ns = ONE;

                else if(m_tick)
                    ns = WAIT0_3;
            end



            WAIT0_3:
            begin
                if(sw)
                    ns = ONE;

                else if(m_tick)
                    ns = ZERO;
            end



            default:
                ns = ZERO;

        endcase

    end



    //================================================
    // State register
    //================================================

    always @(posedge clk or posedge rst) begin

        if(rst)
            cs <= ZERO;

        else
            cs <= ns;

    end



    //================================================
    // Output logic
    //================================================

    always @(*) begin

        if(cs == ONE)
            db1 = 1'b1;

        else
            db1 = 1'b0;

    end


endmodule