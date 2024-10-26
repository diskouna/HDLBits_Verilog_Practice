`default_nettype none 

module top_module (
    input clk,
    input reset,
    input enable,
    output [3:0] Q,
    output reg c_enable,
    output reg c_load,
    output [3:0] c_d
); //

    count4 the_counter (clk, c_enable, c_load, c_d , Q);

    assign c_enable = enable;
    assign c_d      = 4'h1;

    always @(*) begin 
        c_load = 1'b0;

        if (reset) begin
            c_load = 1'b1;
        end 
        else if (Q == 4'd12 & enable) begin
            c_load = 1'b1;
        end 
    end

endmodule
