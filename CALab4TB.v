module CALab4TB;


reg [31:0]A;
reg [31:0]B;
reg [2:0]Opcode;
reg Cin;
 

wire [31:0]S;
wire [3:0]Status;

 

Combined test(.A(A), .B(B), .Cin(Cin), .Opcode(Opcode), .S(S),.Status(Status));

 

always begin

A <= 32'b11100001101101111001010100111001;//{$random, $random};
B <= 32'b10011001110001001001010101011001;//{$random, $random};
Cin <= 1'b1;
Opcode <= 3'b000;
#100;
Opcode <= 3'b001;
#100;
Opcode <= 3'b010;
#100;
Opcode <= 3'b011;
#100;
Opcode <= 3'b100;
#100;
Opcode <= 3'b101;
#100;
Opcode <= 3'b110;
#100;
Opcode <= 3'b111;
#100;


$finish;
end



endmodule
