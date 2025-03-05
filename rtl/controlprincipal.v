module controlprincipal(
	input clk,
	
	//botones
	input botonregar,
	input botonabonar,
	input botonpodar,
	input botonreposar,
	input botontest,
	input botonreset,
	
	//estado del tamaguchi
	input [3:0] estado,
	
	//banderas de sensores
	input interaccion,
	input claridad,
	
	//temporizador de paso de tiempo
	
	input passsecond,
	
	output reg [2:0]humedad,
	output reg [2:0]nutricion,
	output reg [2:0]energia,
	output reg [2:0]mantenimiento,
	output reg [2:0]cortado,
	
	output reg reposando
);


//contadores para disminuir automaticamente las necesidades
reg [9:0] counthumedad;
reg [9:0] countcortado;
reg [9:0] countnutricion;
reg [9:0] countenergia;
reg [9:0] countmantenimiento;

reg [9:0] countreposar;
reg [5:0] contadorjuego;
//contadores para conteo de 5 segundos reset y test
reg [27:0]countreset;
reg [27:0]counttest; //contar hasta 250.000.000

//banderas para simular el pulso de subida de cada circuito
reg banderapasotiempo;
reg banderaregabotonregar;
reg banderaabonar;
reg banderapodar;
reg banderareposar;
reg banderainteraccion;
reg banderatest;


//modo de operacion
reg mode;

parameter normal=1'b0;
parameter test=1'b1;


initial begin
	humedad<=7;
	nutricion <=7;
	energia <= 7;
	mantenimiento <=7;
	cortado <=7;
	reposando <= 0;
	counthumedad
 <= 0;
	countcortado
 <= 0;
	countnutricion
 <= 0;
	countenergia <= 0;
	countmantenimiento
 <= 0;
	countreposar
 <= 0;
	mode <= 0;
	
	countreset <= 0;
	counttest <= 0;
	contadorjuego <= 0;
	
	banderapasotiempo <= 0;
	banderaregabotonregar <= 0;
	banderaabonar <= 0;
	banderapodar
 <= 0;
	banderareposar
 <= 0;
	banderainteraccion <= 0;
	banderatest <= 0;
end
//
//bloque para conteo de reset y test, y otros
always @(posedge clk)begin
	//
	//bloque de funcionamiento del paso de segundo
	if(passsecond == 1)begin
		if(banderapasotiempo == 0)begin
			banderapasotiempo <= 1;
			if(mode == 0)begin
				
		if(cortado < 5)begin
			if(counthumedad
		 < 599)begin
				counthumedad
			 <= counthumedad
			 + 1'b1;
			end
			else begin
				counthumedad
			 <= 0;
				if(humedad > 0)humedad <= humedad - 1'b1;
			end
		end
		else begin
			if(counthumedad
		 < 299)begin
				counthumedad
			 <= counthumedad
			 + 1'b1;
			end
			else begin
				counthumedad
			 <= 0;
				if(humedad > 0)humedad <= humedad - 1'b1;
			end
		end
		
		
		if(countcortado
	 < 419)begin
			countcortado
		 <=countcortado
		 + 1'b1;
		end
		else begin
			countcortado
		 <= 0;
			if(cortado > 0)cortado <= cortado - 1'b1;
		end
			
		if(countnutricion
	 < 299)begin	
			countnutricion
		 <=countnutricion
		 + 1'b1;
		end
		else begin
			countnutricion
		 <=0;
			if(nutricion > 0)nutricion <= nutricion - 1'b1;
		end
		
		if(countenergia < 419)begin
			countenergia <=countenergia + 1'b1;
		end
		else begin
			countenergia <= 0;
			if(energia > 0)energia <= energia - 1'b1;
		end
		
		if(countmantenimiento
	 < 179)begin
			countmantenimiento
		 <=countmantenimiento
		 + 1'b1;
		end
		else begin
			countmantenimiento
		 <= 0;
			if(mantenimiento > 0)mantenimiento <= mantenimiento - 1'b1;
		end
		
		if(reposando == 1)begin
			if(countreposar
		 >= 59)begin
				countreposar
			 <= 0;
				if(energia < 7)energia <= energia + 1'b1;
			end
			else begin
				countreposar
			 <= countreposar
			 + 1'b1;
			end
			countenergia <= 0;
		end
		else begin
			countreposar
		 <= 0;
		end
		
	end
		end
	end
	else begin
		banderapasotiempo <= 0;
	end
	//
	//bloque originalidad normal y funcionamiento test
	if(mode == 0)begin
	//
	//bloque funcionamiento reset
		if(claridad == 1)begin reposando <= 0; countreposar
	 <= 0;end
		if(interaccion == 1)begin reposando <= 0;countreposar
	 <= 0;end
		if(humedad < 5)begin reposando <= 0;countreposar
	 <= 0;end
		if(nutricion < 5)begin reposando <= 0;countreposar
	 <= 0;end
		if(energia == 7)begin reposando <= 0;countreposar
	 <= 0;end
		if(botontest == 1)begin
			if(counttest >= 250000000)begin
				mode <= 1;
				counttest <= 0;
			end
			else begin
				counttest <= counttest + 1'b1;
			end
		end
		else begin
			counttest <= 0;
		end
	end

	if(botonreset == 1)begin
			if(countreset >= 250000000)begin
			
				mode <= 0;
				humedad<=6;
				nutricion <=6;
				energia <= 6;
				mantenimiento <=6;
				cortado <=6;
				reposando <= 0;
				counthumedad
			 <= 0;
				countcortado
			 <= 0;
				countnutricion
			 <= 0;
				countenergia <= 0;
				countmantenimiento
			 <= 0;
				countreposar
			 <= 0;
				contadorjuego <= 0;
				countreset <= 0;
				
			end
			else begin
				countreset <= countreset + 1'b1;
			end
	end
	else begin
		countreset <= 0;
	end

	
	
	//
	//bloque regabotonregar
	if(botonregar == 1)begin
		if(banderaregabotonregar == 0)begin
			banderaregabotonregar <= 1;
			if(mode == 0)begin
			if(reposando == 0)begin
				if(interaccion == 1)begin
					if(humedad < 6)begin
						humedad <= humedad + 2'b10;
					end
					else begin
						if(humedad < 7)begin
							humedad <= humedad + 1'b1;
						end
					end
				end
				else begin
					if(humedad < 7)humedad <= humedad + 1'b1;
				end
				counthumedad
			 <= 0;
			end
			end
		end
	end
	else begin
		banderaregabotonregar <= 0;
	end
	//
	//bloque abonar
	if(botonabonar == 1)begin
		if(banderaabonar == 0)begin
			banderaabonar <= 1;
			if(mode == 0)begin
			if(reposando == 0)begin
				if(humedad >= 5)begin
					if(claridad == 1)begin
						if(nutricion < 6)begin
							nutricion <= nutricion + 2'b10;
						end
						else begin
							if(nutricion < 7)begin
								nutricion <= nutricion + 1'b1;
							end
						end
					end
					else begin
						if(nutricion < 7)nutricion <= nutricion + 1'b1;
					end
					countnutricion
				<= 0;
			
				end
			end
			end
		end
	end
	else begin
		banderaabonar <= 0;
	end
	//
	//bloquepodar

	if(botonpodar == 1)begin
		if(banderapodar
	 == 0)begin
			banderapodar
		 <= 1;
			if(mode == 0)begin
			if(reposando == 0)begin
				if(cortado < 7)begin 
					cortado <= cortado + 1'b1;
				end
				countcortado
			 <= 0;
			end
			end
		end
	end
	else begin
		banderapodar
	 <= 0;
	end
	//
	//bloque reposar

	if(botonreposar == 1)begin
		if(banderareposar
	 == 0)begin
			banderareposar
		 <= 1;
			if(mode == 0)begin
		if(claridad == 0)begin
			if(interaccion == 0)begin
				if (humedad > 4)begin
					if(nutricion > 4)begin
						reposando <= 1;
					end
				end
			end
		end
	end
		end
	end
	else begin
		banderareposar
	 <= 0;
	end
	//
	//bloque interaccion
	if(interaccion == 1)begin
		if(banderainteraccion == 0)begin
			banderainteraccion <= 1;
			if(humedad >4)begin
		if(nutricion >4)begin
			if(energia >4)begin
				if(contadorjuego > 1)begin
					contadorjuego <= 0;
					if(mantenimiento < 7)mantenimiento <= mantenimiento + 1'b1;
					countmantenimiento
				 <= 0;
				end
				else begin
					contadorjuego <= contadorjuego + 1'b1;
				end
			end
		end
	end
		end
	end
	else begin
		banderainteraccion <= 0;
	end
	//
	//bloque test
	if(botontest == 1)begin
		if(banderatest == 0)begin
			banderatest <= 1;
			if(mode == 1)begin
				case(estado)
					4'b0000:begin
							humedad<=7;
				nutricion <=7;
				energia <= 7;
				mantenimiento <=7;
				cortado <=7;
				reposando <= 0;
			end
			4'b0001:begin
				humedad<=6;
				nutricion <=6;
				energia <= 4;
				mantenimiento <=6;
				cortado <=6;
				reposando <= 0;
			end
			4'b0010:begin
				humedad<=6;
				nutricion <=6;
				energia <= 6;
				mantenimiento <=6;
				cortado <=6;
				reposando <= 1;
			end
			4'b0011:begin
				humedad<=6;
				nutricion <=4;
				energia <= 6;
				mantenimiento <=6;
				cortado <=6;
				reposando <= 0;
			end
			4'b0100:begin
				humedad<=4;
				nutricion <=6;
				energia <= 6;
				mantenimiento <=6;
				cortado <=6;
				reposando <= 0;
			end
			4'b0101:begin
				humedad<=6;
				nutricion <=6;
				energia <= 6;
				mantenimiento <=4;
				cortado <=6;
				reposando <= 0;
			end
			4'b0110:begin
				humedad<=6;
				nutricion <=6;
				energia <= 6;
				mantenimiento <=6;
				cortado <=4;
				reposando <= 0;
			end
			4'b0111:begin
				humedad<=2;
				nutricion <=2;
				energia <= 2;
				mantenimiento <=6;
				cortado <=6;
				reposando <= 0;
			end
			4'b1000:begin
				humedad<=1;
				nutricion <=1;
				energia <= 1;
				mantenimiento <=1;
				cortado <=6;
				reposando <= 0;
			end
			4'b1010:begin
				humedad<=6;
				nutricion <=6;
				energia <= 6;
				mantenimiento <=6;
				cortado <=6;
				reposando <= 0;
			end
			default:begin
				humedad<=6;
				nutricion <=6;
				energia <= 6;
				mantenimiento <=6;
				cortado <=6;
				reposando <= 0;
			end
		endcase
	end
		end
	end
	else begin
		banderatest <= 0;
	end
end



endmodule