module top_module (
    input d, 
    input ena,
    output q);
	
    reg q_r;
    assign q = q_r;
    always @(*) begin 
        if (ena) q_r = d;
    end 
endmodule
