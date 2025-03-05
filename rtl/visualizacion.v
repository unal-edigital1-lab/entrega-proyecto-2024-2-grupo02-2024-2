module visualizacion(
	input clk,
	input [2:0] velocidad,
	input [13:0] puntuacion,
	output reg [6:0] display,
	output reg [7:0]anodos
);

reg [3:0] decenavelocidad;
reg [3:0] unidadvelocidad;

wire[3:0] unimilpuntuacion;
wire[3:0] centenapuntuacion;
wire[3:0] decenapuntuacion;
wire[3:0] unidadpuntuacion;

reg[2:0] control;
reg[20:0] contador;
reg[3:0] numeroactual;
reg[6:0] displayneg;

initial begin
	display <= 0;
	anodos <= 0;
	decenavelocidad <= 0;
	unidadvelocidad <= 0;
	control <= 0;
	contador <= 0;
	numeroactual <= 0;
	displayneg <= 0;
end

bcd convertidor(clk, puntuacion, unimilpuntuacion, centenapuntuacion, decenapuntuacion, unidadpuntuacion);

always @(posedge clk)begin
	case(velocidad)
		3'b000:begin
			decenavelocidad <= 0;
			unidadvelocidad <= 1;
		end
		3'b001:begin
			decenavelocidad <= 0;
			unidadvelocidad <= 2;
		end
		3'b010:begin
			decenavelocidad <= 0;
			unidadvelocidad <= 5;
		end
		3'b011:begin
			decenavelocidad <= 1;
			unidadvelocidad <= 0;
		end
		3'b100:begin
			decenavelocidad <= 5;
			unidadvelocidad <= 0;
		end
		3'b101:begin
			decenavelocidad <= 9;
			unidadvelocidad <= 9;
		end
		default:begin
			decenavelocidad <= 0;
			unidadvelocidad <= 1;
		end
	endcase
	
	case(control)
		3'b000:begin
			anodos <= 8'b01111111;
			numeroactual <= decenavelocidad;
		end
		3'b001:begin
			anodos <= 8'b10111111;
			numeroactual <= unidadvelocidad;
		end
		3'b010:begin
			anodos <= 8'b11011111;
			numeroactual <= 4'b1111;
		end
		3'b011:begin
			anodos <= 8'b11101111;
			numeroactual <= 4'b1111;
		end
		3'b100:begin
			anodos <= 8'b11110111;
			numeroactual <= unimilpuntuacion;
		end
		3'b101:begin
			anodos <= 8'b11111011;
			numeroactual <= centenapuntuacion;
		end
		3'b110:begin
			anodos <= 8'b11111101;
			numeroactual <= decenapuntuacion;
		end
		3'b111:begin
			anodos <= 8'b11111110;
			numeroactual <= unidadpuntuacion;
		end
	endcase
	case(numeroactual)
		4'b0000:begin
			displayneg <= 7'b0111111;
		end
		4'b0001:begin
			displayneg <= 7'b0000110;
		end
		4'b0010:begin
			displayneg <= 7'b1011011;
		end
		4'b0011:begin
			displayneg <= 7'b1001111;
		end
		4'b0100:begin
			displayneg <= 7'b1100110;
		end
		4'b0101:begin
			displayneg <= 7'b1101101;
		end
		4'b0110:begin
			displayneg <= 7'b1111101;
		end
		4'b0111:begin
			displayneg <= 7'b0100111;
		end
		4'b1000:begin
			displayneg <= 7'b1111111;
		end
		4'b1001:begin
			displayneg <= 7'b1101111;
		end
		default:begin
			displayneg <= 7'b1000000;
		end
	endcase
	display <= ~displayneg;
end

always @(posedge clk)begin
	if(contador >= 50000)begin
		contador <= 0;
		control <= control + 1'b1;	
	end
	else begin
		contador <= contador + 1'b1;
	end
end


endmodule