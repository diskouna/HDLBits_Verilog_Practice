module fadd (
	input a, b, cin,
    output sum, cout
);
    assign {cout, sum} = a + b + cin;
endmodule

module top_module( 
    input [99:0] a, b,
    input cin,
    output [99:0] cout,
    output [99:0] sum );
	        
    fadd f_add1_inst (
        .a(a[0]),
        .b(b[0]),
        .cin(cin),
        .sum(sum[0]),
        .cout(cout[0])
    );
    
    genvar i;
    generate
        for (i = 1; i < 100; i = i + 1) begin : fadds
            fadd fadd_inst (
                .a(a[i]),
                .b(b[i]),
                .cin(cout[i-1]),
                .sum(sum[i]),
                .cout(cout[i])
            );
        end
    endgenerate
endmodule
