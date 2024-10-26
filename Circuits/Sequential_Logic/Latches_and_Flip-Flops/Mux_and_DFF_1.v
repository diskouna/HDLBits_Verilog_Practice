module top_module (
	input clk,
	input L,
	input r_in,
	input q_in,
	output reg Q);
    
    wire Q_d;
    assign Q_d = (L == 1'b1) ? r_in : q_in;
    
    always @(posedge clk) Q <= Q_d;    
    
endmodule
