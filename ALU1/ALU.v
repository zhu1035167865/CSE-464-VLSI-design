
module ALU (a, b, ALU_sel, load_shift, result, cout, zout);
input [7:0] a, b;
input [1:0] ALU_sel, load_shift;
output[7:0] result;
output cout, zout;

wire cout, zout;
reg [8:0] r;

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

assign cout = r[8];
assign result =  r[7:0];
assign zout = (result==0)?1'b1:1'b0;

endmodule

