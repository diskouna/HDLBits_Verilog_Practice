module bcd2_counter #(
    parameter INIT_VALUE  = 8'd0,
    parameter RESET_VALUE = 8'd0,
    parameter MAX_VALUE   = {4'd5, 4'd9}
)(
    input           clk,
    input           reset,
    input           ena,
    output reg[7:0] counter,
    output       cout
);

    assign cout = (ena & counter == MAX_VALUE);

    always @(posedge clk) begin
        if (reset) begin
            counter <= RESET_VALUE;
        end
        else if (ena) begin
            if (counter >= MAX_VALUE) begin
                counter <= INIT_VALUE;
            end
            else begin
                if (counter[3:0] == 4'd9) begin
                    counter[7:4] <= counter[7:4] + 4'd1;
                    counter[3:0] <= 4'd0;
                end
                else begin
                    counter[3:0] <= counter[3:0] + 4'd1;
                end
            end  
        end
    end
endmodule

module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output [7:0] hh,
    output [7:0] mm,
    output [7:0] ss); 

    wire ena_mm, ena_hh, ena_pm;
    
    bcd2_counter BCD_SS (
        .clk(clk),
        .reset(reset),
        .ena(ena),
        .counter(ss),
        .cout(ena_mm)
    );

    bcd2_counter BCD_MM (
        .clk(clk),
        .reset(reset),
        .ena(ena_mm & ena),
        .counter(mm),
        .cout(ena_hh)
    );
    wire [7:0] hh_tmp;
    assign hh =(hh_tmp == {4'd0, 4'd0}) ? {4'd1, 4'd2} : hh_tmp;
 
    bcd2_counter #(
        .INIT_VALUE ({4'd0, 4'd0}), 
        .RESET_VALUE({4'd0, 4'd0}), 
        .MAX_VALUE  ({4'd1, 4'd1}) 
    ) BCD_HH (
        .clk(clk),
        .reset(reset),
        .ena(ena_hh & ena_mm & ena),
        .counter(hh_tmp),
        .cout(ena_pm)
    );

    always @(posedge clk)
        if (reset)                               pm <= 1'b0;
        else if (ena_pm & ena_hh & ena_mm & ena) pm <= ~pm;

endmodule
