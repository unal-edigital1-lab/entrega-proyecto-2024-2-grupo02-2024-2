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
