module Combined(A,B,Cin,Opcode,S,Status);

input  [31:0] A,B;
input Cin;
input [2:0]Opcode;

output [31:0]S;
output reg [3:0]Status;

wire [31:0] Cout;
wire [31:0] AdderToMux;
wire [31:0] MuxToOutside;
wire [31:0] Xoring,Anding,Oring,Noring;
wire [31:0] Left,Right;



assign Xoring = A ^ B;
assign Anding = A & B;
assign Oring = A|B;
assign Noring = ~(A|B);

Adder Adder_0(.A(A[0]),.B(B[0]),.Cin(Cin),.S(AdderToMux[0]),.Cout(Cout[0]));

	genvar x;
	generate
		for (x = 1; 32>x; x=x+1)begin: FA
			Adder AdderForver(.A(A[x]),.B(B[x]),.Cin(Cout[x-1]),.S(AdderToMux[x]),.Cout(Cout[x]));
		end
	endgenerate

LRShifter LRShifter0(.a(A), .b(B[4:0]),.left(Left),.right(Right));
	
	
Mux8x3 EntireMux(.s(Opcode), .out(MuxToOutside), .i0(Xoring), .i1(Anding), .i2(Oring), .i3(Noring), .i4(AdderToMux), .i5(Left), .i6(Right), .i7(32'b0));

always @(Opcode,MuxToOutside,Cout) begin
	
	Status[0] <= Cout;

	Status[1] <= MuxToOutside[31];
	if (MuxToOutside == 32'b0) begin
		Status[2] <= 1'b1;
	end
	else begin
	Status[2] <= 1'b0;
	end
	Status[3] <= (~A[31])&(~B[31])&(MuxToOutside[31]) | (A[31])&(B[31])&(~MuxToOutside[31]);
end

assign S = MuxToOutside;

endmodule
