module top_module (
    input [7:0] in,
    output [31:0] out );//

    assign out = {{(32-8){in[7]}}, in };

endmodule
