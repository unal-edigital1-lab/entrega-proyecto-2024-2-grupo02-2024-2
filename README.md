[![Open in Visual Studio Code](https://classroom.github.com/assets/open-in-vscode-2e0aaae1b6195c2367325f4f02e2d04e9abb55f0b24a779b69b11b9e10269abc.svg)](https://classroom.github.com/online_ide?assignment_repo_id=17798927&assignment_repo_type=AssignmentRepo)
# Especificación de Diseño del Proyecto Planta Virtual en FPGA
  -Diego Vitoviz
  -Paula Diaz
  -Duvan Tique

## 1. Introducción

### 1.1 Objetivo

Desarrollar un sistema de Planta Virtual en FPGA que simule el cuidado de una planta digital. Se implementará una lógica de estados para gestionar las necesidades de la planta y se permitirá la interacción mediante botones y sensores básicos.

### 1.2 Delimitaciones

El proyecto se enfocará en:

- Uso de botones físicos para la interacción.
- Inclusión de al menos un sensor para interacción avanzada.
- Representación del estado de la planta mediante una matriz de LED o display sencillo.
- Implementación en FPGA Cyclone IV usando Verilog.

## 2. Descripción General del Sistema

### 2.1 Contexto del Sistema

El sistema de Planta Virtual en FPGA simula el crecimiento y necesidades de una planta utilizando máquinas de estado finito para gestionar su desarrollo y bienestar.

### 2.2 Funcionalidad Principal

El usuario podrá interactuar con la planta mediante botones para regar, fertilizar y exponer a la luz. Se utilizará una matriz de LEDs o un display de 7 segmentos para visualizar el estado de la planta.

## 3. Requisitos del Sistema

### 3.1 Sistema de Botones

- **Reset:** Reinicia el crecimiento de la planta.
- **Test:** Permite navegar entre los estados de prueba.
- **Interacción:** Dos botones para regar y fertilizar la planta.

### 3.2 Sistema de Sensado

Se usará al menos un sensor para mejorar la interacción, como:

- **Sensor de humedad:** Detecta la necesidad de riego.
- **Sensor de luz:** Determina la cantidad de luz recibida y afecta el crecimiento de la planta.

### 3.3 Sistema de Visualización

- **Matriz de LED 8x8** para mostrar el estado de crecimiento de la planta.
- **Display de 7 segmentos** para representar niveles de hidratación o crecimiento.

## 4. Arquitectura del Sistema

### 4.1 Diagrama de Bloques

(Se incluirá un diagrama básico con FPGA, botones, sensores y pantalla).

### 4.2 Descripción de Componentes

- **FPGA:** Ejecuta la lógica del crecimiento de la planta.
- **Pantalla:** Matriz LED o display de 7 segmentos.
- **Botones:** Entrada principal de usuario.
- **Sensores:** Proporcionan datos adicionales al sistema.

### 4.3 Interfaces

- Comunicación entre FPGA y pantalla.
- Entradas digitales para botones.
- Integración con sensores seleccionados.

## 5. Modos de Operación

### 5.1 Modo Test

Permite verificar estados y funcionalidad sin esperar cambios naturales.

### 5.2 Modo Normal

El usuario interactúa con la planta, la cual responde según sus necesidades y el paso del tiempo.

### 5.3 Modo Aceleración (Opcional)

Incrementa la velocidad de simulación para observar cambios rápidos en el crecimiento.

## 6. Estados y Transiciones

### 6.1 Estados Principales

- **Seca:** Requiere riego.
- **Crecimiento:** Se desarrolla con el agua y la luz adecuadas.
- **Fertilización:** Necesita nutrientes para un mejor crecimiento.
- **Marchita:** Falta de agua, luz o fertilización.
- **Floreciendo:** Resultado de buen cuidado.

### 6.2 Transiciones

- Temporizadores para cambio de estados.
- Botones y sensores modifican el estado de la planta.
- Eventos aleatorios pueden afectar su crecimiento.

## 7. Requisitos de Implementación

- **Lenguaje:** Verilog.
- **Plataforma:** FPGA Cyclone IV.
- **Herramientas:** Quartus Prime.
- **Periféricos:** Botones, sensores y matriz LED.

## 8. Plan de Verificación y Validación

- Pruebas individuales de cada módulo.
- Simulación en Quartus antes de la implementación física.
- Validación del comportamiento con interacción real.

