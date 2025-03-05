module controlpuntuacion(
	input clk,
	input [2:0] humedad,
	input [2:0] nutricion,
	input [2:0] energia,
	input [2:0] mantenimiento,
	input [2:0] cortado,
	input botonreset,
	input botontest,
	output reg [13:0]puntuacion
);

reg[27:0]countreset;
reg[27:0]counttest;
reg[25:0]contador;
//codigo para el bonus
wire [5:0] total;
wire bonus;
assign total = humedad + nutricion + energia + mantenimiento + cortado;
assign bonus = (total == 35)?1'b1:1'b0;

//banderas para la disminucion de puntos
wire losthumedad;
wire lostnutricion;
wire lostenergia;
wire lostmantenimiento;
wire lostcortado;

assign losthumedad = (humedad <= 2)?1'b1:1'b0;
assign lostnutricion = (nutricion <= 2)?1'b1:1'b0;
assign lostenergia = (energia <= 2)?1'b1:1'b0;
assign lostmantenimiento = (mantenimiento <= 2)?1'b1:1'b0;
assign lostcortado = (cortado <= 2)?1'b1:1'b0;

wire [2:0]puntosperdidos;
assign puntosperdidos = losthumedad+ lostnutricion + lostenergia+ lostmantenimiento + lostcortado;

wire deadhumedad;
wire deadnutricion;
wire deadenergia;
wire deadmantenimiento;
wire deadcortado;

assign deadhumedad = (humedad == 0)?1'b1:1'b0;
assign deadnutricion = (nutricion == 0)?1'b1:1'b0;
assign deadenergia = (energia == 0)?1'b1:1'b0;
assign deadmantenimiento = (mantenimiento == 0)?1'b1:1'b0;
assign deadcortado = (cortado == 0)?1'b1:1'b0;

wire [2:0]totalmalaracha;
assign totalmalaracha = deadhumedad+ deadnutricion + deadenergia+ deadmantenimiento + deadcortado;

wire [2:0]negativebonus;
assign negativebonus = (totalmalaracha>=2)?3'b101:3'b000;

wire [3:0]totalpuntosperdidos;
assign totalpuntosperdidos = negativebonus + puntosperdidos;

//banderas para el pulso de una vez
reg banderabonus;
reg banderahumedad;
reg banderanutricion;
reg banderaenergia;
reg banderamantenimiento;
reg banderacortado;

initial begin
countreset <= 250000000;
counttest <= 250000000;

banderabonus <= 0;

banderahumedad <= 1;
banderanutricion <= 1;
banderaenergia <= 1;
banderamantenimiento <= 1;
banderacortado <= 1;

contador <= 0;

puntuacion <= 0;
end



always @(posedge clk)begin
	//
	//funcionamiento del boton reset
	if(botonreset == 1)begin
		if(countreset == 0)puntuacion<=0;
		else countreset<=countreset-1'b1;
	end
	else countreset <=250000000;
	//
	//funcionamiento del boton test
	if(botontest == 1)begin
		if(counttest == 0)puntuacion<=0;
		else counttest<=counttest-1'b1;
	end
	else counttest <=250000000;
	//
	//funcionamiento bonus
	if(bonus == 1)begin
		if(banderabonus == 0)begin
			banderabonus <= 1;
			if(puntuacion <= 9994)puntuacion <= puntuacion + 5;
			else puntuacion<= 9999;
		end
	end
	else banderabonus <= 0;
	//
	//funcionamiento banderas up;
	if(humedad >= 6)begin
		if(banderahumedad == 0)begin
			banderahumedad <= 1;
			if(puntuacion < 9999)puntuacion <= puntuacion + 1'b1;
		end
	end
	else banderahumedad <= 0;
	//
	if(nutricion >= 6)begin
		if(banderanutricion == 0)begin
			banderanutricion <= 1;
			if(puntuacion < 9999)puntuacion <= puntuacion + 1'b1;
		end
	end
	else banderanutricion <= 0;
	//
	if(energia >= 6)begin
		if(banderaenergia == 0)begin
			banderaenergia <= 1;
			if(puntuacion < 9999)puntuacion <= puntuacion + 1'b1;
		end
	end
	else banderaenergia <= 0;
	//
	if(mantenimiento >= 6)begin
		if(banderamantenimiento == 0)begin
			banderamantenimiento <= 1;
			if(puntuacion < 9999)puntuacion <= puntuacion + 1'b1;
		end
	end
	else banderamantenimiento <= 0;
	//
	if(cortado >= 6)begin
		if(banderacortado == 0)begin
			banderacortado <= 1;
			if(puntuacion < 9999)puntuacion <= puntuacion + 1'b1;
		end
	end
	else banderacortado <= 0;
	//
	if(contador >= 50000000)begin
		contador <= 0;
		if(puntuacion >= totalpuntosperdidos)puntuacion <= puntuacion - totalpuntosperdidos;
		else puntuacion <= 0;
	end
	else contador <= contador + 1'b1;
end

endmodule