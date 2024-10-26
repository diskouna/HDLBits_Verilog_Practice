module decade_counter (
	input clk,
    input reset,
    input ena,
    output [3 : 0] q,
    output reg cout
);
    reg [3 : 0] q_r, q_d;
    assign q = q_r;
    
    always @(*) begin
        cout = 1'b0;
        q_d  = q_r;
        if (ena) begin 
            if (q_r == 4'd9) begin 
                q_d  = 4'd0;
            	cout = 1'b1;
            end else begin
                q_d = q_r + 4'd1;
            end
        end
    end
            
    always @(posedge clk) begin
        if (reset) q_r <= 4'd0;
        else       q_r <= q_d;
    end
    
endmodule

module top_module (
    input clk,
    input reset,   // Synchronous active-high reset
    output [3:1] ena,
    output [15:0] q);

    wire [3:1] ena_int;
    assign ena = ena_int;
    
    decade_counter c_1 (.clk(clk), .reset(reset), .ena(1'b1),       .q(q[ 3: 0]), .cout(ena_int[1])); 
    decade_counter c_2 (.clk(clk), .reset(reset), .ena(ena_int[1]), .q(q[ 7: 4]), .cout(ena_int[2]));
    decade_counter c_3 (.clk(clk), .reset(reset), .ena(ena_int[2]), .q(q[11: 8]), .cout(ena_int[3]));
    decade_counter c_4 (.clk(clk), .reset(reset), .ena(ena_int[3]), .q(q[15:12]), .cout());
    
endmodule
