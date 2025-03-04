# Proyecto Tamagotchi Electrónica Digital

*Paula Ruiz
*Duvan Tique
*Diego Vitoviz

## Descripción General y Especificaciones de los Sistemas
### Introducción 
El proyecto “Tamagotchi” emula una mascota virtual que reacciona a las atenciones del usuario. Se implementa en una FPGA (por ejemplo, Cyclone IV EP4CE6E22C8N) e incluye:
* Botones físicos: Para alimentar, regar, podar, reposar, activar modo prueba, acelerar el tiempo y resetear el juego.
* Sensores:
  * Ultrasónico (movimiento): Detecta cercanía del usuario sin necesidad de pulsar botones.
  * Luz (foto-resistencia con comparador): Indica claridad o noche.
*Pantallas:
  * Matrices LED WS2812 de 8×8 para mostrar la animación del Tamagotchi y sus barras de necesidades.
  * Display de 7 segmentos para visualizar la velocidad y la puntuación.
