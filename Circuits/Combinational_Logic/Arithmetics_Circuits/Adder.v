module f_add ( 
    input a, b, cin,
    output cout, sum );
    assign sum = (a ^ b ^ cin);
    assign cout = (a&b) | (cin & (a ^ b)); 
endmodule

module top_module (
    input [3:0] x,
    input [3:0] y, 
    output [4:0] sum);
    
    wire [3:0] cout;

    assign sum[4] = cout[3];
    
    f_add f_add_1 (x[0], y[0], 1'b0,    cout[0], sum[0]);
    f_add f_add_2 (x[1], y[1], cout[0], cout[1], sum[1]);
    f_add f_add_3 (x[2], y[2], cout[1], cout[2], sum[2]);
    f_add f_add_4 (x[3], y[3], cout[2], cout[3], sum[3]);

endmodule
