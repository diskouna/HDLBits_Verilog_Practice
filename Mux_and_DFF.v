module top_module (
    input clk,
    input w, R, E, L,
    output Q
);
	reg Q_r;
    assign Q = Q_r;
    
    wire mux_1, mux_2, Q_d;
    assign mux_1 = (E == 1'b1) ? w :  Q_r;
    assign mux_2 = (L == 1'b1) ? R : mux_1;
    assign Q_d = mux_2;
    
    always @(posedge clk) begin
    	Q_r <= Q_d;    
    end
    
endmodule
