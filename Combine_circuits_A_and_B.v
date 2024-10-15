
module mod_A (input x, input y, output z);
    assign z = (x ^ y) & x;
endmodule

module mod_B ( input x, input y, output z );
	assign z = x  ^~ y;

endmodule

module top_module (input x, input y, output z);
    wire z1, z2, z3, z4;

    mod_A IA_1 (x, y, z1);
    mod_B IB_1 (x, y, z2);
    mod_A IA_2 (x, y, z3);
    mod_B IB_2 (x, y, z4);

    assign z = (z1 | z2) ^ (z3 & z4);
 
endmodule
