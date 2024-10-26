module top_module (
	input [2:0] SW,      // R
	input [1:0] KEY,     // L and clk
	output [2:0] LEDR);  // Q

    wire clk     = KEY[0];
    wire L       = KEY[1];
    wire [2:0] R = SW;

    reg [2:0] Q, Q_next;
    assign LEDR = Q;

    always @(*) begin
        Q_next = Q;
        Q_next[0] = L ? R[0] : Q[2];
        Q_next[1] = L ? R[1] : Q[0];
        Q_next[2] = L ? R[2] : (Q[1] ^ Q[2]);
    end 

    always @(posedge clk) Q <= Q_next;

endmodule
