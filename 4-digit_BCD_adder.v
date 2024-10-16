module top_module ( 
    input [15:0] a, b,
    input cin,
    output cout,
    output [15:0] sum );

    wire [3 : 0] cout_arr;
    assign cout = cout_arr[3];
 
    bcd_fadd bcd_fadd_1 (a[ 0 +: 4], b[ 0 +: 4],         cin, cout_arr[0], sum[ 0 +: 4]);
    bcd_fadd bcd_fadd_2 (a[ 4 +: 4], b[ 4 +: 4], cout_arr[0], cout_arr[1], sum[ 4 +: 4]);
    bcd_fadd bcd_fadd_3 (a[ 8 +: 4], b[ 8 +: 4], cout_arr[1], cout_arr[2], sum[ 8 +: 4]);
    bcd_fadd bcd_fadd_4 (a[12 +: 4], b[12 +: 4], cout_arr[2], cout_arr[3], sum[12 +: 4]);

endmodule
