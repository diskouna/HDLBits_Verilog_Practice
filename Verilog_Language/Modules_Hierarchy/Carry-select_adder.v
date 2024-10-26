module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);
    wire cout;
    wire [15 : 0] sum_1, sum_2;
    
    add16 add_1 (.a(a[15 : 0]), .b(b[15 : 0]), .cin(1'b0), .sum(sum[15 : 0]), .cout(cout));
    add16 add_2 (.a(a[31 : 16]), .b(b[31 : 16]), .cin(1'b0), .sum(sum_1), .cout());
    add16 add_3 (.a(a[31 : 16]), .b(b[31 : 16]), .cin(1'b1), .sum(sum_2), .cout());
    
    assign sum[31 : 16] = cout ? sum_2 : sum_1;
    
endmodule
