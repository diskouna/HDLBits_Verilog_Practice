module top_module (
    input clk,
    input j,
    input k,
    output Q); 

    reg Q_r, Q_d;
    assign Q = Q_r;
    
    always @(*) begin
        Q_d = Q_r;
        if (j ^ k) Q_d = j;
        else       Q_d = Q_r ^ (j & k);
    end
    
    always @(posedge clk) begin
        Q_r <= Q_d;
    end
endmodule
