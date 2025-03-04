i# Proyecto Tamagotchi Electrónica Digital

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

#### DIAGRAMA PAULA (va aquí)
### Subsistemas Esenciales
#### Control Principal:
* Coordina el decremento automático de necesidades con el paso del tiempo.
* Maneja la lógica de botones (regar, abonar, podar, reposar, test, reset).
* Actualiza niveles en función de interacción (sensor ultrasónico) y claridad (sensor de luz).
#### Lógica de Estados (StateLogic):
* Determina si el Tamagotchi está “bien”, “cansado”, “desnutrido”, “dormido”, etc., basándose en las necesidades recibidas de controlprincipal.
#### Sensores:
* Ultrasónico (ultrasonido.v): Envía trig, mide echo y establece interaccion si la distancia es menor a cierto umbral.
* Foto-resistencia + Amplificador: Genera la señal claridad (1 = luz, 0 = oscuridad).
#### Control de Tiempo (timecontrol):
* Genera un pulso (newtime o passsecond) con diferentes velocidades (X1, X2, X5, X10, X50, X100).
* Esto permite acelerar o desacelerar el juego.
#### Pantallas y Animación: 
* Transmisor (Transmisor.v) y ImageControl (ImageControl.v): Codifican los bits de color (24 bits/píxel) para las matrices LED.
* Muxes (mux64, mux24) y needcomparator: Seleccionan si pintar la imagen base o las barras de necesidades.
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

## Arquitectura del sistema 
### Módulo Top (Tamaguchi.v)
*









