module top_module (
    input clk,
    input enable,
    input S,
    input A, B, C,
    output Z);

    reg [7:0] q, q_next;

    assign Z = q[{A, B, C}];

    always @(*) begin
        q_next = q;
        if (enable)
            q_next = {q[7-1 : 0], S};
    end

    always @(posedge clk) 
        q <= q_next;

endmodule
