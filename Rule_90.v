module top_module(
    input clk,
    input load,
    input [511:0] data,
    output [511:0] q ); 

    reg [511 : 0] data_q, data_d;
    
    assign q = data_q;
    always @(*) begin 
        if (load) data_d = data;
        else begin
            data_d = (data_q << 1) ^ (data_q >> 1);
        end
    end
    always @(posedge clk) data_q <= data_d;
    
endmodule
