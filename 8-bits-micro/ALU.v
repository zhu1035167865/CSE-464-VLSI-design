
module ALU (
input wire [7:0] a,
 input wire [7:0] b,
 input wire [1:0] ALU_sel,
 input wire [1:0] load_shift,
 output wire [7:0] result,
 output wire cout,
 output wire zout
);

reg [8:0] r;
reg rC;
reg rZ;

always @(a or b or ALU_sel or load_shift) begin
	case(ALU_sel) 
		2'b10: r <= a + b; //add
		2'b11: r <= a - b; //sub
		2'b01: r <= {1'b0, ~(a | b)}; //Nor
		2'b00:
			case(load_shift) 
				2'b11: r <= {1'b0, a>>1};
				2'b01: r <= {1'b0, a<<1};
				2'b10: r <= {1'b0, a};
				2'b00: r <= 0;
			endcase
	endcase
end

always @(r) begin
	rC <= r[8];
	rZ <= (r[7:0] == 0) ? 1:0;
end

assign cout = rC;
assign result = r[7:0]; 
assign zout = rZ; 

endmodule

