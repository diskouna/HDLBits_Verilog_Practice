module top_module (
    input clk,
    input resetn,   // synchronous reset
    input in,
    output out);


    reg [3:0] q, q_next;

    assign out = q[0];
    
    always @(*) begin
        q_next = {in, q[3 : 0+1]};
    end

    always @(posedge clk) 
        if (resetn == 1'b0) q <= 4'b0;
        else                q <= q_next;

endmodule
