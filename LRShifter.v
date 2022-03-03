module LRShifter(a, b, left, right);
input [31:0]a;
input [4:0]b;
output [31:0]left;
output [31:0]right;

assign left = a << b[4:0];
assign right = a >> b[4:0];

endmodule
