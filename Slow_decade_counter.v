module top_module (
    input clk,
    input slowena,
    input reset,
    output [3:0] q);
    
    reg [3:0] q_r, q_d;
    assign q = q_r;
    
    always @(*) begin
    	q_d = q_r;
        if (slowena) begin 
            q_d = q_r + 4'h1;
        	if (q_r == 4'd9) q_d = 4'h0;
        end
    end
    
    always @(posedge clk) begin
        if (reset) q_r <= 4'h0;
        else       q_r <= q_d;
    end
endmodule
