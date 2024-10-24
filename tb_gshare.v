`timescale 1ns/1ps
`default_nettype none

module tb_gshare ();
    reg clk, areset;
    reg predict_valid, train_valid, train_taken, train_mispredicted;
    reg [6:0] predict_pc, train_history, train_pc;
    wire predict_taken;
    wire [6:0] predict_history;


    top_module DUT (
        clk,
        areset,
   
        predict_valid,
        predict_pc,
        predict_taken,
        predict_history,
   
        train_valid,
        train_taken,
        train_mispredicted,
        train_history,
        train_pc
    ); 
    initial begin
        clk = 1'b0;
        forever begin
            #1;
            clk = !clk;
        end
    end

    initial begin
        areset <= 1'b1;
        #3;
        areset <= 1'b0;
        #100;
        $finish;
    end
    
    initial begin
        #5;
        train_valid <= 1'b0;
        predict_valid <= 1'b0;
        #10;
        train_valid <= 1'b1;
        predict_valid <= 1'b1;
        train_taken <= 1'b1;
        train_pc <= 7'd0;
        train_history <= 7'd0;
        predict_pc <= 7'd0; 
    end

    initial begin
        $dumpfile("gshare.vcd");
        $dumpvars(0, tb_gshare);
    end
endmodule

