module top_module (
    input clk,
    input in, 
    output out);

    reg q_r;
    wire q_d;
    assign out = q_r;
    assign q_d = in ^ q_r;
    
    always @(posedge clk) q_r <= q_d;

endmodule
