module top_module (
    input clk,
    input d,
    output q
);
	reg q_p, q_n;
    assign q = (clk == 1'b1) ? q_p : q_n;
    always @(posedge clk) q_p <= d;
    always @(negedge clk) q_n <= d;
    
    
endmodule
