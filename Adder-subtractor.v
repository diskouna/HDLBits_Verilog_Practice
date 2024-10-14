module top_module(
    input [31:0] a,
    input [31:0] b,
    input sub,
    output [31:0] sum
);
    // a + b : a + 0^b + 0
    // a - b : a + 1^b + 1
    
    wire c;
    
    add16 add_1 (.a(a[15 : 0]),  .b({16{sub}} ^ b[15: 0]), .cin(sub),  .sum(sum[15: 0]), .cout(c));
    add16 add_2 (.a(a[31 : 16]), .b({16{sub}} ^ b[31:16]), .cin(c), .sum(sum[31:16]), .cout());

endmodule
