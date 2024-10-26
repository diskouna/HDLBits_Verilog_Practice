module top_module (
    input clk,
    input reset,
    output [9:0] q);

    reg [9 : 0] counter;
    assign q = counter;
    
    always @(posedge clk) begin
        if (reset) counter <= 0;
        else begin
            if (counter < 10'd999)
                counter <= counter + 1;
            else
                counter <= 0;
        end
    end
endmodule
