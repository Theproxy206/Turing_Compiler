# 🌀 TuringMachine Compiler (TMC)

**TMC** es un compilador robusto diseñado para traducir especificaciones de Máquinas de Turing deterministas en código ejecutable. 

A diferencia de un simple intérprete, este proyecto se enfoca en el rigor del análisis de lenguajes, pasando por fases de tokenización, análisis sintáctico (LL) y una profunda validación semántica para garantizar la integridad lógica de la máquina antes de su ejecución.

## 🚀 Propósito

El objetivo de este compilador es proporcionar un entorno formal para definir Máquinas de Turing mediante un lenguaje de alto nivel. 

Está diseñado para detectar errores lógicos comunes (como el no-determinismo o estados inalcanzables) en tiempo de compilación, facilitando el aprendizaje y la experimentación con la Teoría de la Computación.

> 📚 ¿Nuevo en esto? Si quieres profundizar en los fundamentos teóricos, te recomendamos leer sobre la [Máquina de Turing en Wikipedia](https://es.wikipedia.org/wiki/M%C3%A1quina_de_Turing) o consultar la [Stanford Encyclopedia of Philosophy](https://plato.stanford.edu/entries/turing-machine/).

## 🛠️ Instalación y Uso
Requisitos

> Java Development Kit (JDK) 8 o superior.

## Compilación

Para compilar todos los componentes del parser y las clases auxiliares, ejecuta desde la raíz del proyecto:
Bash

```shell
javac *.java
```

## Ejecución

Puedes ejecutar el compilador de dos formas:

Modo Archivo (Recomendado):
```shell
java TuringParser mi_archivo.mt
```

Modo Consola (Interactivo):
```shell
java TuringParser
```
>(Presiona Ctrl+D o Ctrl+Z al finalizar para procesar la entrada).

## 📝 Overview de Sintaxis

El lenguaje se divide en tres secciones principales:

- Declaración: machine NombreMaquina:
- Configuración: Bloque config { ... } donde se definen estados, alfabeto, estado inicial y símbolo blanco.
- Transiciones: Bloques state -> on { ... }; que definen el comportamiento de la máquina.

## 📂 Programas de Ejemplo

En la carpeta del repositorio encontrarás tres archivos clave para probar el compilador:

- DuplicarUnos.mt
- ComplementoUno.mt
- Errores.mt

### El caso de Errores.mt

Este archivo es una prueba de estrés que contiene deliberadamente:

- Error Léxico: Caracteres no permitidos.
- Error Sintáctico: Omisión de llaves o palabras reservadas fuera de lugar.
- Error Semántico: Uso de estados o símbolos no declarados en el bloque config.
- Error de Determinismo: Dos reglas distintas para el mismo par (Estado, Símbolo).
- Warning (Estado Final): Definición de transiciones saliendo de un estado final.
- Warning (Bloque Duplicado): Declaración fragmentada de un mismo estado.