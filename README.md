[![Open in Visual Studio Code](https://classroom.github.com/assets/open-in-vscode-2e0aaae1b6195c2367325f4f02e2d04e9abb55f0b24a779b69b11b9e10269abc.svg)](https://classroom.github.com/online_ide?assignment_repo_id=17798927&assignment_repo_type=AssignmentRepo)
# Entrega 1 del proyecto WP01
- Paula Ruiz
- Diego Vitoviz
- Duvan Tique
## Semáforo de 3 luces
Este proyecto implementa una controlador diguital de luz de trafico usando una FPGA y lenguaje HDL. El diseño simula un trafico de luz básico con tres estados (**Rojo**,**Amarillo**,**Verde**) usando una maquina de estados finitos (FMS) y un reloj.

## Objetivos:
- Diseñar e implementar un controlador de trafico de luz que opere en ciclos definidos usando la FPGA, demostrando el control de la base del estado  y la funcionalidad de la temporización.

## *Características del Proyecto*
- *Operación en tres estados:*
  - Rojo: Detener el tráfico.
  - Amarillo: Preparar para el cambio.
  - Verde: Permitir el paso.
- *Temporizadores ajustables* para la duración de cada estado.
- Diseñado para tarjetas FPGA de Intel/Altera.
- Totalmente probado con simulaciones e implementación en hardware.

---

## *Estructura del Proyecto*
```plaintext
TrafficLight-FPGA/
├── README.md          # Descripción general e instrucciones del proyecto
├── src/               # Archivos fuente en Verilog
│   ├── Traffic_Light.v  # Código del controlador de semáforo
│   └── constraints.qsf  # Archivo de asignación de pines
├── simulations/       # Testbench y resultados de simulación
│   ├── testbench.v      # Testbench para simulación
│   └── waveform.vcd     # Salida de simulación
└── LICENSE            # Licencia del proyecto
[14:51, 21/1/2025] +57 310 7363996: ### Modelo de Caja Negra
El controlador de semáforo se implementa como un módulo de caja negra con las siguientes entradas y salidas:

- *Entradas:*
  - clk: Señal de reloj (50 MHz).
  - reset: Botón de reinicio para restablecer el semáforo al estado inicial.

- *Salidas:*
  - red: Controla el LED rojo.
  - yellow: Controla el LED amarillo.
  - green: Controla el LED verde.

*Diagrama de Caja Negra:*

```plaintext
     +---------------------+
     |  Traffic Light FSM  |
     |                     |
clk  --->                 ---> red
reset --->                 ---> yellow
                          ---> green
     +---------------------+
[14:52, 21/1/2025] +57 310 7363996: ### Descripción funcional del sistema
El semáforo opera en un ciclo de tres estados:
1. *Estado Rojo:* La luz roja está activa durante 5 segundos, indicando que el tráfico debe detenerse.
2. *Estado Verde:* La luz verde está activa durante 5 segundos, permitiendo que el tráfico avance.
3. *Estado Amarillo:* La luz amarilla está activa durante 2 segundos, indicando la transición al estado rojo.

La transición entre estados se gestiona mediante una máquina de estados finita (FSM) sincronizada con un reloj de 50 MHz del FPGA. Cada estado tiene un temporizador implementado con contadores para definir su duración.
[14:52, 21/1/2025] +57 310 7363996: ### Diagrama de Bloques Funcionales
```plaintext
  +---------+       +--------------+       +----------------+
  |  Clock  | ----> |   FSM Logic  | ----> |  LED Drivers   |
  +---------+       +--------------+       +----------------+
                         ^                         ^
                         |                         |
                   Reset Button               Output LEDs
[14:52, 21/1/2025] +57 310 7363996: #### *b. Diagrama de conexión física*
Describe cómo se conectan los pines del FPGA a los LEDs. Por ejemplo:

markdown
### Diagrama de Conexión Física
- **LED Rojo:** Conectado al pin 12 del FPGA.
- **LED Amarillo:** Conectado al pin 13 del FPGA.
- **LED Verde:** Conectado al pin 14 del FPGA.

**Conexiones en el FPGA:**

plaintext
  FPGA Board
  +------------------+
  |                  |
  |   PIN_12 ------> Red LED
  |   PIN_13 ------> Yellow LED
  |   PIN_14 ------> Green LED
  +------------------+
