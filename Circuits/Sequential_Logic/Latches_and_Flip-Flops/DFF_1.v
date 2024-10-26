module top_module (
    input clk,
    input d, 
    input ar,   // asynchronous reset
    output q);

    reg q_r;
    assign q = q_r;
    
    always @(posedge clk or posedge ar)
        if (ar) q_r <= 1'b0;
    	else    q_r <= d;
    
endmodule
