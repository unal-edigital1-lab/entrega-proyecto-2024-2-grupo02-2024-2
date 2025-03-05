module Tamaguchi (
	input             clk,
	
	input botonregar,
	input botonabonar,
	input botonpodar,
	input botonreposar,
	
	input botontest,
	input botonreset,
	
	input botonacelerador,
	
	input botoninteraccion,
	
	input echo,
	input claridad,
	
	
	output  pinout,
	output [7:0] anodos,
	output [6:0] display,
	output ledclaridad,
	output ledinteraccion,
	output trig
);

//wires del transmisor de imagen
wire senddata;
wire done;

//wire estado tamaguchi
wire [3:0] estado;
wire reposando;


//wire direccion memoria
wire [3:0] adress;

//wire datos de memoria
wire [63:0] data;

//wires de necesidades
wire [2:0] humedad;
wire [2:0] nutricion;
wire [2:0] energia;
wire [2:0] mantenimiento;
wire [2:0] cortado;

//wires botones con antirrebote
wire debbotonregar;
wire debbotonabonar;
wire debbotonreposar;
wire debbotonpodar;
wire debbotonreset;
wire debbotontest;
wire debbotonacelerador;
wire debbotoninteraccion;

wire interaccion;

wire interaccionsensor;


//wires control de velocidad
wire pasosegundo;
wire [2:0] velocidad;

//wire puntuacion
wire[13:0]puntuacion;


assign ledclaridad = ~claridad;
assign ledinteraccion = ~interaccion;

assign interaccion = interaccionsensor | debbotoninteraccion;


//antirrebotes
debounce antirrebotehumedad(botonregar, clk, debbotonregar);
debounce antirreboteabono(botonabonar, clk, debbotonabonar);
debounce antirrebotereposar(botonreposar, clk, debbotonreposar);
debounce antirrebotepodar(botonpodar, clk, debbotonpodar);
debounce antirrebotereset(botonreset, clk, debbotonreset);
debounce antirrebotetest(botontest, clk, debbotontest);
debounce antirreboteacelerador(botonacelerador, clk, debbotonacelerador);
debounce antirreboteinteraccion(botoninteraccion, clk, debbotoninteraccion);

//instanciar modulos
Transmisor trans (clk, senddata, pinout, done);
ImageControl controlimagen (clk, estado, done,data, humedad, nutricion, energia, mantenimiento, cortado, senddata, adress);
StateLogic logica(clk, humedad, nutricion, energia, mantenimiento, cortado, reposando, estado);
ROManimation memoria(adress, clk, data);
controlprincipal control(clk, debbotonregar, debbotonabonar, debbotonpodar, debbotonreposar, debbotontest, debbotonreset, estado,  interaccion, claridad, pasosegundo, humedad, nutricion, energia, mantenimiento, cortado, reposando);
timecontrol controltiempo(clk, debbotonacelerador, pasosegundo, velocidad);
visualizacion segmentos(clk, velocidad, puntuacion, display, anodos);
controlpuntuacion timecontrolp(clk,humedad, nutricion, energia, mantenimiento, cortado, debbotonreset,debbotontest, puntuacion);

ultrasonido driver(clk, echo, trig, interaccionsensor);
endmodule