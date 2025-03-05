# Proyecto Tamagotchi Electrónica Digital

* Paula Ruiz
* Duvan Tique
* Diego Vitoviz

## Descripción General y Especificaciones de los Sistemas
### Introducción 
El proyecto “Tamagotchi” emula una mascota virtual que reacciona a las atenciones del usuario. Se implementa en una FPGA (por ejemplo, Cyclone IV EP4CE6E22C8N) e incluye:
* Botones físicos: Para alimentar, regar, podar, reposar, activar modo prueba, acelerar el tiempo y resetear el juego.
* Sensores:
  * Ultrasónico (movimiento): Detecta cercanía del usuario sin necesidad de pulsar botones.
  * Luz (foto-resistencia con comparador): Indica claridad o noche.
* Pantallas:
  * Matrices LED WS2812 de 8×8 para mostrar la animación del Tamagotchi y sus barras de necesidades.
  * Display de 7 segmentos para visualizar la velocidad y la puntuación.
El Tamagotchi mantiene cinco necesidades: humedad, nutrición, energía, mantenimiento, cortado (podado). Cada necesidad se expresa con 3 bits (valores 0 a 7). Cuando su nivel disminuye, el Tamagotchi cambia de estado (cansado, hambriento, etc.), repercutiendo en la puntuación final.
### Diagrama de Caja Negra

![Documentación](https://github.com/user-attachments/assets/0abf3178-ab55-4410-8a3d-d30f4a69f851)

### Subsistemas Esenciales
#### Control Principal:
* Coordina el decremento automático de necesidades con el paso del tiempo.
* Maneja la lógica de botones (regar, abonar, podar, reposar, test, reset).
* Actualiza niveles en función de interacción (sensor ultrasónico) y claridad (sensor de luz).
#### Lógica de Estados (Maquina de estados):
* Determina si el Tamagotchi del la planta está “bien”, “Insolada”, “Desnutrida”, “Muerta”, etc., basándose en las necesidades recibidas de controlprincipal.
  Para verificar cada uno de los estados correspondiente para la maquina de estados se realizo el siguiente test bench para probar cada una de los posibilidades
````
module MaquinaEstados_TB;

    // Entradas
    reg clk;
    reg [2:0] humedad;
    reg [2:0] nutricion;
    reg [2:0] energia;
    reg [2:0] mantenimiento;
    reg [2:0] podado;
    reg reposando;
    
    // Salida
    wire [3:0] estado;
    
    // Instanciar el módulo bajo prueba
    MaquinaEstados dut (
        .clk(clk),
        .humedad(humedad),
        .nutricion(nutricion),
        .energia(energia),
        .mantenimiento(mantenimiento),
        .podado(podado),
        .reposando(reposando),
        .estado(estado)
    );
    
    // Generar reloj
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    
    initial begin
        // Inicializar entradas
        humedad = 7;
        nutricion = 7;
        energia = 7;
        mantenimiento = 7;
        podado = 7;
        reposando = 0;
        
        #10;
        
        // Test 1: Estado DORMIDA (reposando=1)
        reposando = 1;
        #10;
        $display("Test 1: reposando=1 -> Estado = %b (DORMIDA)", estado);
        
        // Test 2: Estado DESOLADA (enfermo >= 3)
        reposando = 0;
        energia = 2;    // <3
        nutricion = 2;  // <3
        humedad = 2;    // <3
        podado = 3;     // >=3
        mantenimiento = 3; // >=3
        #10;
        $display("Test 2: enfermo >=3 -> Estado = %b (DESOLADA)", estado);
        
        // Test 3: Estado MUERTE (marchita >= 2)
        energia = 4;    // <5
        nutricion = 4;  // <5
        humedad = 5;    // >=5
        podado = 5;     // >=5
        mantenimiento = 5; // >=5
        #10;
        $display("Test 3: marchita >=2 -> Estado = %b (MUERTE)", estado);
        
        // Test 4: Estado DESNUTRIDA (nutricion <5)
        nutricion = 4;  // <5
        energia = 5;    // >=5
        humedad = 5;    // >=5
        podado = 5;     // >=5
        mantenimiento = 5; // >=5
        #10;
        $display("Test 4: nutricion <5 -> Estado = %b (DESNUTRIDA)", estado);
        
        // Test 5: Estado DESHIDRATADA (humedad <5)
        nutricion = 5;  // >=5
        humedad = 4;    // <5
        #10;
        $display("Test 5: humedad <5 -> Estado = %b (DESHIDRATADA)", estado);
        
        // Test 6: Estado REMONTADA (podado <5)
        humedad = 5;    // >=5
        podado = 4;     // <5
        #10;
        $display("Test 6: podado <5 -> Estado = %b (REMONTADA)", estado);
        
        // Test 7: Estado DESCUIDADA (mantenimiento <5)
        podado = 5;     // >=5
        mantenimiento = 4; // <5
        #10;
        $display("Test 7: mantenimiento <5 -> Estado = %b (DESCUIDADA)", estado);
        
        // Test 8: Estado INSOLADO (energia <5)
        mantenimiento = 5; // >=5
        energia = 4;    // <5
        #10;
        $display("Test 8: energia <5 -> Estado = %b (INSOLADO)", estado);
        
        // Test 9: Estado EXCELENTE (suma total =35)
        energia = 7;
        nutricion = 7;
        humedad = 7;
        podado = 7;
        mantenimiento = 7;
        #10;
        $display("Test 9: suma=35 -> Estado = %b (EXCELENTE)", estado);
        
        // Test 10: Estado BIEN (condiciones normales)
        energia = 5;
        nutricion = 5;
        humedad = 5;
        podado = 5;
        mantenimiento = 5;
        #10;
        $display("Test 10: condiciones normales -> Estado = %b (BIEN)", estado);
        
        // Finalizar simulación
        #10;
        $finish;
    end
    
endmodule
````
![Captura de pantalla 2025-03-04 215145](https://github.com/user-attachments/assets/5c2f6a65-7361-4a69-bb71-6bb1b2f027bb)
#### Sensores:
* Ultrasónico (ultrasonido.v): Envía trig, mide echo y establece interaccion si la distancia es menor a cierto umbral.
* Modulo sensor fotoresistencia: Genera una señal digital(1 = luz, 0 = oscuridad).
#### Control de Tiempo (timecontrol):
* Genera un pulso (newtime o passsecond) con diferentes velocidades (X1, X2, X5, X10, X50, X100).
* Esto permite acelerar o desacelerar el juego.
#### Pantallas y Animación: 
* Transmisor (Transmisor.v) y ImageControl (ImageControl.v): Codifican los bits de color (24 bits/píxel) para las matrices LED.
* Los multiplexores  (mux64, mux24) y needcomparator: Seleccionan si pintar la imagen base o las barras de necesidades.
* ROManimation: Guarda patrones de 64 bits que se combinan para la animación.
#### Visualización en 7 Segmentos:
* Módulo visualizacion maneja 8 dígitos multiplexados; muestra velocidad en los dos primeros dígitos y la puntuación en los últimos cuatro.
* bcd convierte la puntuación binaria (14 bits) a dígitos BCD.
#### Control de Puntuación (controlpuntuacion):
* Suma puntos cuando el Tamagotchi está en buenas condiciones (≥6 en sus necesidades).
* Descuenta puntos si varias necesidades están ≤2, con penalizaciones adicionales si llegan a 0.
* Aplica bonus (+5) si todas suman 35.
#### Debounce:
* Filtra el ruido de los botones físicos











