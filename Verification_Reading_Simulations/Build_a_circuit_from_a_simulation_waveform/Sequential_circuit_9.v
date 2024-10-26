module top_module (
    input clk,
    input a,
    output reg [3:0] q );

    always @(posedge clk) 
        if (a)           q <= 4'h4;
        else if (q == 6) q <= 4'h0;
        else             q <= q + 4'h1; 

endmodule
