module needcomparator (

	 input [6:0] contadorpixel,
	 input [2:0] humedad,
	 input [2:0] nutricion,
	 input [2:0] energia,
	 input [2:0] marchito,
	 input [2:0] podado,
    output reg [23:0] colorout               
);

always @(*) begin
    case (contadorpixel)
        7'b1000000:begin
				if(humedad >= 0)begin colorout<=24'h0096ff;end
				else begin colorout<=24'h000000;
				end
			end
		  7'b1000001:begin
			if(humedad >= 1)begin colorout<=24'h0096ff;end
			else begin colorout<=24'h000000;end
		  end
		  7'b1000010:begin
			if(humedad >= 2)begin colorout<=24'h0096ff;end
			else begin colorout<=24'h000000;end
		  end
		  7'b1000011:begin
			if(humedad >= 3)begin colorout<=24'h0096ff;end
			else  begin colorout<=24'h000000;end
		  end
		  7'b1000100:begin
			if(humedad >= 4) begin colorout<=24'h0096ff; end
			else colorout<=24'h000000;
		  end
		  7'b1000101:begin
			if(humedad >= 5)begin colorout<=24'h0096ff; end
			else begin colorout<=24'h000000; end
		  end
		  7'b1000110:begin
			if(humedad >= 6)begin colorout<=24'h0096ff;end
			else begin colorout<=24'h000000;end
		  end
		  7'b1000111:begin
			if(humedad >= 7)begin colorout<=24'h0096ff;end
			else begin colorout<=24'h000000;end
		  end
		  
		  
		  
		  7'b1001000:begin
				if(nutricion >= 0)colorout<=24'hfbff00;
				else colorout<=24'h000000;
		  end
		  7'b1001001:begin
				if(nutricion >= 1)colorout<=24'hfbff00;
				else colorout<=24'h000000;
		  end
		  7'b1001010:begin
			if(nutricion >= 2)colorout<=24'hfbff00;
			else colorout<=24'h000000;
		  end
		  7'b1001011:begin
			if(nutricion >= 3)colorout<=24'hfbff00;
			else colorout<=24'h000000;
		  end
		  7'b1001100:begin
			if(nutricion >= 4)colorout<=24'hfbff00;
			else colorout<=24'h000000;
		  end
		  7'b1001101:begin
			if(nutricion >= 5)colorout<=24'hfbff00;
			else colorout<=24'h000000;
		  end
		  7'b1001110:begin
			if(nutricion >= 6)colorout<=24'hfbff00;
			else colorout<=24'h000000;
		  end
		  7'b1001111:begin
			if(nutricion >= 7)colorout<=24'hfbff00;
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
			if(marchito >= 0)colorout<=24'hd700ff;
			else colorout<=24'h000000;
		  end
		  7'b1100001:begin
			if(marchito >= 1)colorout<=24'hd700ff;
			else colorout<=24'h000000;
		  end
		  7'b1100010:begin
			if(marchito >= 2)colorout<=24'hd700ff;
			else colorout<=24'h000000;
		  end
		  7'b1100011:begin
			if(marchito >= 3)colorout<=24'hd700ff;
			else colorout<=24'h000000;
		  end
		  7'b1100100:begin
			if(marchito >= 4)colorout<=24'hd700ff;
			else colorout<=24'h000000;
		  end
		  7'b1100101:begin
			if(marchito >= 5)colorout<=24'hd700ff;
			else colorout<=24'h000000;
		  end
		  7'b1100110:begin
			if(marchito >= 6)colorout<=24'hd700ff;
			else colorout<=24'h000000;
		  end
		  7'b1100111:begin
			if(marchito >= 7)colorout<=24'hd700ff;
			else colorout<=24'h000000;
		  end
		  
		  
		  
		  
		  7'b1110000:begin
			if(podado >= 0)colorout<=24'h24ff00;
			else colorout<=24'h000000;
		  end
		  7'b1110001:begin
			if(podado >= 1)colorout<=24'h24ff00;
			else colorout<=24'h000000;
		  end
		  7'b1110010:begin
			if(podado >= 2)colorout<=24'h24ff00;
			else colorout<=24'h000000;
		  end
		  7'b1110011:begin
			if(podado >= 3)colorout<=24'h24ff00;
			else colorout<=24'h000000;
		  end
		  7'b1110100:begin
			if(podado >= 4)colorout<=24'h24ff00;
			else colorout<=24'h000000;
		  end
		  7'b1110101:begin
			if(podado >= 5)colorout<=24'h24ff00;
			else colorout<=24'h000000;
		  end
		  7'b1110110:begin
			if(podado >= 6)colorout<=24'h24ff00;
			else colorout<=24'h000000;
		  end
		  7'b1110111:begin
			if(podado >= 7)colorout<=24'h24ff00;
			else colorout<=24'h000000;
		  end
		  
        default: colorout = 0;  
		 
		 
    endcase
end

endmodule