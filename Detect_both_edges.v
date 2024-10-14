module top_module (
    input clk,
    input [7:0] in,
    output [7:0] anyedge
);
    reg [7 : 0] shift_in, pedge_q;
    wire [7 : 0] pedge_d;
    
    assign pedge_d = ((in) ^ (shift_in));
    assign anyedge = pedge_q;
    
    always @(posedge clk) begin 
        shift_in <= in;
    	pedge_q  <= pedge_d;
    end
endmodule
