module top_module (
    input clk,
    input areset,   // active high asynchronous reset
    input [7:0] d,
    output [7:0] q
);
    reg [7 : 0] q_r;
    assign q = q_r;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin 
           q_r <= 8'd0; 
        end
        else begin 
           q_r <= d; 
        end
    end

endmodule
