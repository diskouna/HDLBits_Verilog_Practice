module top_module (
    input clk,
    input [7:0] d,
    output [7:0] q
);
    reg [7 : 0] q_r;
    assign q = q_r;
    
    always @(posedge clk)  q_r <= d;
endmodule
