`timescale 1ns/1ps

module tb_The_complete_timer();
    reg clk, reset, data, ack;
    wire counting, done;
    wire [3:0] count;

    top_module DUT (
        clk,
        reset,      // Synchronous reset
        data, count, counting, done, ack 
    );
    // Clock
    initial begin 
        clk = 1'b0;
        forever begin
            #1 clk = !clk;
        end
    end
    // Reset
    initial begin
        reset <= 1'b1;
        #(2);
        reset <= 1'b0; 
    end
    
    // data, ack
    initial begin
        ack <= 1'b0;
        data <= 1'b0;
        #(1*2) data <= 1'b1;    
        #(1*2) data <= 1'b0;
        #(2*2) data <= 1'b1;
        #(2*2) data <= 1'b0;
        #(1*2) data <= 1'b1;
        #(1*2) data <= 1'b0;
        #(3*2) data <= 1'b1;

        #(1*2) data <= 1'b0;
        wait (done == 1'b1);
        #(2*40);
        ack <= 1'b1;
        #(2*40); 
        $finish;
    end

    initial begin
        $dumpfile("complete_timer.vcd");
        $dumpvars(0, tb_The_complete_timer);
    end

endmodule
    
