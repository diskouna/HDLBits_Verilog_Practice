module top_module (
    input clk,
    input resetn,
    input [1:0] byteena,
    input [15:0] d,
    output [15:0] q
);
    reg [15:0] q_r, q_d;
    assign q = q_r;
    
    always @(*) begin
        q_d = q_r;
        if (byteena[0]) q_d[ 7:0] = d[ 7:0];
        if (byteena[1]) q_d[15:8] = d[15:8]; 
    end
    
    always @(posedge clk) begin
        if (resetn == 1'b0) q_r <= 16'd0;
        else                q_r <= q_d;
    end
        
endmodule
