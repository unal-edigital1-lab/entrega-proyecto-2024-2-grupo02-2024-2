module MaquinaEstados (
	input             clk,
	input [2:0] humedad,
	input [2:0] nutricion,
	input [2:0] energia,
	input [2:0] mantenimiento,
	input [2:0] podado,
	input reposando,
	output reg [3:0] estado
	
);

parameter BIEN = 4'b0000;
parameter EXCELENTE = 4'b0001;
parameter INSOLADO = 4'b0010;
parameter DORMIDA = 4'b0011;
parameter DESNUTRIDA = 4'b0100;
parameter DESHIDRATADA = 4'b0101;
parameter DESCUIDADA = 4'b0110;
parameter REMONTADA = 4'b0111;
parameter DESOLADA = 4'b1000;
parameter MUERTE = 4'b1001;

reg [2:0] enfermo;
reg [2:0] dead;
reg [2:0] marchita;
reg [5:0] excelent;

wire a,b,c,d,e,f,g,h,i,j,k,l,m,n,o;

assign a = (energia < 5)?1'b1:1'b0;
assign b = (nutricion < 5)?1'b1:1'b0;
assign c = (humedad < 5)?1'b1:1'b0;
assign d = (podado < 5)?1'b1:1'b0;
assign e = (mantenimiento < 5)?1'b1:1'b0;

assign f = (energia < 3)?1'b1:1'b0;
assign g = (nutricion < 3)?1'b1:1'b0;
assign h = (humedad < 3)?1'b1:1'b0;
assign i = (podado < 3)?1'b1:1'b0;
assign j = (mantenimiento < 3)?1'b1:1'b0;

assign k = (energia < 2)?1'b1:1'b0;
assign l = (nutricion < 2)?1'b1:1'b0;
assign m = (humedad < 2)?1'b1:1'b0;
assign n = (podado < 2)?1'b1:1'b0;
assign o = (mantenimiento < 2)?1'b1:1'b0;

initial begin
	estado <= 0;
	enfermo <= 0;
	dead <= 0;
	marchita <= 0;
	excelent <= 0;
end


always @(posedge clk)begin

		

		enfermo <= f + g + h + i + j;
		dead <= k + l + m + n + o;
		marchita <= a + b + c + d + e;
		excelent <= humedad + nutricion + energia + mantenimiento + podado;
		
		if(reposando == 1)begin
			estado <= DORMIDA
		;
		end
		else begin
				if(enfermo >= 3)begin
					estado <= DESOLADA
				;
				end
				else begin
				if(marchita >= 2)begin
					estado <= MUERTE;
				end
				
					else begin
						if(b == 1)begin
							estado <= DESNUTRIDA
						;
						end
						else begin
							if(c == 1)begin
								estado <= DESHIDRATADA
							;
							end
							else begin
								if(d == 1)begin
									estado <= REMONTADA
								;
								end
								else begin
									if(e == 1)begin
										estado <= DESCUIDADA
									;
									end
									else begin
										if(a == 1)begin
											estado <= INSOLADO;
										end
										else begin
											if(excelent == 35)begin
												estado <= EXCELENTE;
											end
											else begin
												estado <= BIEN;
											end
										end
									end
								end
							end
						end
					end
				end			
			end
		end
		 
endmodule