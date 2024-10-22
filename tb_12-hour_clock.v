`timescale 1ns/1ps
`default_nettype none

module tb_12h ();
    reg clk, reset, ena;
    wire [7:0] ss, mm, hh;
    wire pm;

    top_module DUT (
        clk,
        reset,
        ena,
        pm,
        hh,
        mm,
        ss
    ); 
    initial begin
        clk = 1'b0;
        forever begin
            #1;
            clk = !clk;
        end
    end

    initial begin
        ena <= 1'b1;
        reset <= 1'b1;
        #3;
        reset <= 1'b0;
        #200000;
        $finish;
    end

    initial begin
        $dumpfile("12.vcd");
        $dumpvars(0, tb_12h);
    end
endmodule
