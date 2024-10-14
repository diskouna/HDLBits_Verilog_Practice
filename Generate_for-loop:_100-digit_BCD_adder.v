module top_module( 
    input [399:0] a, b,
    input cin,
    output cout,
    output [399:0] sum );
    
    wire [99:0] cout_a;
    assign cout = cout_a[99];
    
    bcd_fadd bcd_fadd1_inst (
        .a(a[0 +: 4]),
        .b(b[0 +: 4]),
        .cin(cin),
        .sum(sum[0 +: 4]),
        .cout(cout_a[0])
    );
    
    genvar i;
    generate
        for (i = 1; i < 100; i = i + 1) begin : bcd_fadds
            bcd_fadd bcd_fadd_inst (
                .a(a[i*4 +: 4]),
                .b(b[i*4 +: 4]),
                .cin(cout_a[i-1]),
                .sum(sum[i*4 +: 4]),
                .cout(cout_a[i])
            );
        end
    endgenerate
endmodule
