module top_module (
    input clk,
    input reset,
    output OneHertz,
    output [2:0] c_enable
); //

    wire [3:0] bcd_1, bcd_2, bcd_3;
    
    bcdcount counter0 (clk, reset, c_enable[0], bcd_1);
    bcdcount counter1 (clk, reset, c_enable[1], bcd_2);
    bcdcount counter2 (clk, reset, c_enable[2], bcd_3);
    
    assign c_enable[0] = 1'b1;
    assign c_enable[1] = (bcd_1 == 4'd9);
    assign c_enable[2] = (bcd_2 == 4'd9 & bcd_1 == 4'd9);
    assign OneHertz    = (bcd_3 == 4'd9 & bcd_2 == 4'd9 && bcd_1 == 4'd9);
 
endmodule
