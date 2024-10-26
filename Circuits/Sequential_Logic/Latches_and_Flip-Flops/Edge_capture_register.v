module top_module (
    input clk,
    input reset,
    input [31:0] in,
    output [31:0] out
);
    
    reg [31 : 0] out_q, shift_in;
    wire [31 : 0] out_d;
    assign out = out_q;
    
    assign out_d = out_q | ((~in) & shift_in);     
    
    always @(posedge clk) begin
		shift_in <= in;
    end 
    
    always @(posedge clk) begin
        if (reset) out_q <= 32'd0;
        else       out_q <= out_d;
    end
    
endmodule
