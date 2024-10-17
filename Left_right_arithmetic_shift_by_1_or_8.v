module top_module(
    input clk,
    input load,
    input ena,
    input [1:0] amount,
    input [63:0] data,
    output reg [63:0] q
); 
    reg [63:0] q_next;

    always @(*) begin
        q_next = q;
        if (load)      q_next = data;
        else if(ena) begin
            case(amount)
                2'b00: q_next = {q[63-1 : 0], {1{1'b0}}};
                2'b01: q_next = {q[63-8 : 0], {8{1'b0}}};
                2'b10: q_next = {{1{q[63]}}, q[63 : 0+1]};
                2'b11: q_next = {{8{q[63]}}, q[63 : 0+8]};
                default: q_next = q;
            endcase
        end
    end    

    always @(posedge clk) q <= q_next;

endmodule
