module top_module (
    input clk,
    input d, 
    input r,   // synchronous reset
    output q);

    reg q_r;
    assign q = q_r;
    always @(posedge clk) 
        if (r) q_r <= 1'b0;
    	else   q_r <= d;
    
endmodule
