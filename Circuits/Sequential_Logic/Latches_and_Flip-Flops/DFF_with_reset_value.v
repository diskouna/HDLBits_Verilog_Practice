module top_module (
    input clk,
    input reset,
    input [7:0] d,
    output [7:0] q
);
    reg [7 : 0] q_r;
    assign q= q_r;
    
    always @(negedge clk) 
        if (reset) q_r <= 8'h34;
    	else       q_r <= d;
    
endmodule
