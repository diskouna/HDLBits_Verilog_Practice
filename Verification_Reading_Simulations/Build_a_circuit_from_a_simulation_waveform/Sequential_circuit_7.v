module top_module (
    input clk,
    input a,
    output reg q );

    always @(posedge clk)
        if (a) q <= 1'b0;
    	else   q <= 1'b1;
    
endmodule
