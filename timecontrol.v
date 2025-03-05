module timecontrol(
input clk,
input botonpass,

output reg newtime,
output reg [2:0] velocidad
);

reg [24:0] count;
reg banderaboton;

initial begin
	newtime <= 0;
	velocidad <= 0;
	banderaboton <= 0;
	count <= 0;
end

parameter X1 = 3'b000;
parameter X2 = 3'b001;
parameter X5 = 3'b010;
parameter X10 = 3'b011;
parameter X50 = 3'b100;
parameter X100 = 3'b101;

always @(posedge clk)begin
	//cambio boton
	if(botonpass)begin
		if(banderaboton == 0)begin
			banderaboton <= 1;
			case(velocidad)
				X1:begin
					velocidad <= X2;
				end
				X2:begin
					velocidad <= X5;
				end
				X5:begin
					velocidad <= X10;
				end
				X10:begin
					velocidad <= X50;
				end
				X50:begin
					velocidad <= X100;
				end
				X100:begin
					velocidad <= X1;
				end
				default:begin
					velocidad <= X1;
				end
			endcase
		end
	end
	else begin
		banderaboton <= 0;
	end
	//
	//funcionamiento conteo
	case(velocidad)
		X1: begin
			if(count >= 25000000)begin
				count <= 0;
				newtime <= ~newtime;
			end
			else begin
				count <= count + 1'b1;
			end
		end
		
		X2: begin
			if(count >= 12500000)begin
				count <= 0;
				newtime <= ~newtime;
			end
			else begin
				count <= count + 1'b1;
			end
		end
		
		X5: begin
			if(count >= 5000000)begin
				count <= 0;
				newtime <= ~newtime;
			end
			else begin
				count <= count + 1'b1;
			end
		end
		
		X10: begin
			if(count >= 2500000)begin
				count <= 0;
				newtime <= ~newtime;
			end
			else begin
				count <= count + 1'b1;
			end
		end
		
		X50: begin
			if(count >= 500000)begin
				count <= 0;
				newtime <= ~newtime;
			end
			else begin
				count <= count + 1'b1;
			end
		end
		
		X100: begin
			if(count >= 250000)begin
				count <= 0;
				newtime <= ~newtime;
			end
			else begin
				count <= count + 1'b1;
			end
		end
		
		default: begin
			if(count >= 25000000)begin
				count <= 0;
				newtime <= ~newtime;
			end
			else begin
				count <= count + 1'b1;
			end
		end
	endcase
end

endmodule