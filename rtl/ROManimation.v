module ROManimation  (
	input[3:0] adress,
   input clk,
   output reg[63:0] dataout
);


always @(*) begin
	case(adress)
		4'b0000: dataout<= 64'h2854443810141810;
		4'b0001: dataout<= 64'h142a221c08281808;
		4'b0010: dataout<= 64'h285444381151d9d5;
		4'b0011: dataout<= 64'h142a221c888a9bab;
		4'b0100: dataout<= 64'h18187e7e18181818;
		default: dataout<= 64'hffffffffffffffff;
	endcase
end


endmodule