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
A modo de ejemplo, un diagrama global podría lucir así
#### DIAGRAMA PAULA
### Subsistemas Esenciales
#### Control Principal:
*Coordina el decremento automático de necesidades con el paso del tiempo.
