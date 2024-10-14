module top_module (
    input clk,
    input reset,            // Synchronous reset
    input [7:0] d,
    output [7:0] q
);
    reg [7 : 0] q_r;
    assign q = q_r;
    
    always @(posedge clk)
        if (reset) q_r <= 8'd0;
    	else       q_r <= d;
    
endmodule
