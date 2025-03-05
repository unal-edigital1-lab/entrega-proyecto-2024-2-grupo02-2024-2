module needcomparator (

	 input [6:0] contadorpixel,
	 input [2:0] humedad,
	 input [2:0] nutricion,
	 input [2:0] energia,
	 input [2:0] mantenimiento,
	 input [2:0] cortado,
    output reg [23:0] colorout               
);

always @(*) begin
    case (contadorpixel)
        7'b1000000:begin
				if(humedad >= 0)begin colorout<=24'h00ff00;end
				else begin colorout<=24'h000000;
				end
			end
		  7'b1000001:begin
			if(humedad >= 1)begin colorout<=24'h00ff00;end
			else begin colorout<=24'h000000;end
		  end
		  7'b1000010:begin
			if(humedad >= 2)begin colorout<=24'h00ff00;end
			else begin colorout<=24'h000000;end
		  end
		  7'b1000011:begin
			if(humedad >= 3)begin colorout<=24'h00ff00;end
			else  begin colorout<=24'h000000;end
		  end
		  7'b1000100:begin
			if(humedad >= 4) begin colorout<=24'h00ff00; end
			else colorout<=24'h000000;
		  end
		  7'b1000101:begin
			if(humedad >= 5)begin colorout<=24'h00ff00; end
			else begin colorout<=24'h000000; end
		  end
		  7'b1000110:begin
			if(humedad >= 6)begin colorout<=24'h00ff00;end
			else begin colorout<=24'h000000;end
		  end
		  7'b1000111:begin
			if(humedad >= 7)begin colorout<=24'h00ff00;end
			else begin colorout<=24'h000000;end
		  end
		  
		  
		  
		  7'b1001000:begin
				if(nutricion >= 0)colorout<=24'hffff00;
				else colorout<=24'h000000;
		  end
		  7'b1001001:begin
				if(nutricion >= 1)colorout<=24'hffff00;
				else colorout<=24'h000000;
		  end
		  7'b1001010:begin
			if(nutricion >= 2)colorout<=24'hffff00;
			else colorout<=24'h000000;
		  end
		  7'b1001011:begin
			if(nutricion >= 3)colorout<=24'hffff00;
			else colorout<=24'h000000;
		  end
		  7'b1001100:begin
			if(nutricion >= 4)colorout<=24'hffff00;
			else colorout<=24'h000000;
		  end
		  7'b1001101:begin
			if(nutricion >= 5)colorout<=24'hffff00;
			else colorout<=24'h000000;
		  end
		  7'b1001110:begin
			if(nutricion >= 6)colorout<=24'hffff00;
			else colorout<=24'h000000;
		  end
		  7'b1001111:begin
			if(nutricion >= 7)colorout<=24'hffff00;
			else colorout<=24'h000000;
		  end
		  
		  
		  
		  
		  7'b1011000:begin
			if(energia >= 0)colorout<=24'hff0000;
			else colorout<=24'h000000;
		  end
		  7'b1011001:begin
			if(energia >= 1)colorout<=24'hff0000;
			else colorout<=24'h000000;
		  end
		  7'b1011010:begin
			if(energia >= 2)colorout<=24'hff0000;
			else colorout<=24'h000000;
		  end
		  7'b1011011:begin
			if(energia >= 3)colorout<=24'hff0000;
			else colorout<=24'h000000;
		  end
		  7'b1011100:begin
			if(energia >= 4)colorout<=24'hff0000;
			else colorout<=24'h000000;
		  end
		  7'b1011101:begin
			if(energia >= 5)colorout<=24'hff0000;
			else colorout<=24'h000000;
		  end
		  7'b1011110:begin
			if(energia >= 6)colorout<=24'hff0000;
			else colorout<=24'h000000;
		  end
		  7'b1011111:begin
			if(energia >= 7)colorout<=24'hff0000;
			else colorout<=24'h000000;
		  end
		  
		  
		  7'b1100000:begin
			if(mantenimiento >= 0)colorout<=24'h25ff00;
			else colorout<=24'h000000;
		  end
		  7'b1100001:begin
			if(mantenimiento >= 1)colorout<=24'h25ff00;
			else colorout<=24'h000000;
		  end
		  7'b1100010:begin
			if(mantenimiento >= 2)colorout<=24'h25ff00;
			else colorout<=24'h000000;
		  end
		  7'b1100011:begin
			if(mantenimiento >= 3)colorout<=24'h25ff00;
			else colorout<=24'h000000;
		  end
		  7'b1100100:begin
			if(mantenimiento >= 4)colorout<=24'h25ff00;
			else colorout<=24'h000000;
		  end
		  7'b1100101:begin
			if(mantenimiento >= 5)colorout<=24'h25ff00;
			else colorout<=24'h000000;
		  end
		  7'b1100110:begin
			if(mantenimiento >= 6)colorout<=24'h25ff00;
			else colorout<=24'h000000;
		  end
		  7'b1100111:begin
			if(mantenimiento >= 7)colorout<=24'h25ff00;
			else colorout<=24'h000000;
		  end
		  
		  
		  
		  
		  7'b1110000:begin
			if(cortado >= 0)colorout<=24'hb70cf2;
			else colorout<=24'h000000;
		  end
		  7'b1110001:begin
			if(cortado >= 1)colorout<=24'hb70cf2;
			else colorout<=24'h000000;
		  end
		  7'b1110010:begin
			if(cortado >= 2)colorout<=24'hb70cf2;
			else colorout<=24'h000000;
		  end
		  7'b1110011:begin
			if(cortado >= 3)colorout<=24'hb70cf2;
			else colorout<=24'h000000;
		  end
		  7'b1110100:begin
			if(cortado >= 4)colorout<=24'hb70cf2;
			else colorout<=24'h000000;
		  end
		  7'b1110101:begin
			if(cortado >= 5)colorout<=24'hb70cf2;
			else colorout<=24'h000000;
		  end
		  7'b1110110:begin
			if(cortado >= 6)colorout<=24'hb70cf2;
			else colorout<=24'h000000;
		  end
		  7'b1110111:begin
			if(cortado >= 7)colorout<=24'hb70cf2;
			else colorout<=24'h000000;
		  end
		  
        default: colorout = 0;  
		 
		 
    endcase
end

endmodule