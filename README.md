# 🌀 TuringMachine Compiler (TMC)

**TMC** es un compilador robusto diseñado para traducir especificaciones de Máquinas de Turing deterministas en código ejecutable. 

A diferencia de un simple intérprete, este proyecto se enfoca en el rigor del análisis de lenguajes, pasando por fases de tokenización, análisis sintáctico (LL) y una profunda validación semántica para garantizar la integridad lógica de la máquina antes de su ejecución.

## 🚀 Propósito

El objetivo de este compilador es proporcionar un entorno formal para definir Máquinas de Turing mediante un lenguaje de alto nivel. 

Está diseñado para detectar errores lógicos comunes (como el no-determinismo o estados inalcanzables) en tiempo de compilación, facilitando el aprendizaje y la experimentación con la Teoría de la Computación.

> 📚 ¿Nuevo en esto? Si quieres profundizar en los fundamentos teóricos, te recomendamos leer sobre la [Máquina de Turing en Wikipedia](https://es.wikipedia.org/wiki/M%C3%A1quina_de_Turing) o consultar la [Stanford Encyclopedia of Philosophy](https://plato.stanford.edu/entries/turing-machine/).

## 🛠️ Instalación y Uso

Descarga la última versión del compilador desde la sección Releases y extrae el archivo `.tar.gz`

Instala el compilador en tu sistema ejecutando el script incluido:

```shell
sh install.sh
```

O si prefieres la instalación manual:

```shell
# Mueve el binario al PATH
sudo cp turing /usr/local/bin/

# Instala las paginas del manual
sudo cp turing.1.gz /usr/share/man/man1/
sudo mandb
```

## Ejecución

Para ejecutar el compilador ejecuta el siguiente comando:

```shell
turing MiArchivo.mt -o maquina.out
```

> Puedes ver los parámetros del compilador de la siguiente manera:
> ```shell
> turing -h
> ```

## Ejecutando el binario

El binario acepta un archivo de texto con la cinta inicial. 
También puedes definir un límite máximo de pasos para evitar ciclos infinitos (por defecto son 100).

```shell
./maquina.out cinta.txt [limite_pasos]
```

## 📝 Overview de Sintaxis

El lenguaje se divide en tres secciones principales:

> Declaración
> ```
> machine NombreMaquina:
> end
> ```
> 
> Definición
> ```
> config {
>   states: [q0, q1, q_final],
>   symbols: [0, 1, X, B],
>   start: q0,
>   blank: B,
>   finals: [q_final]
> }
> ```
> 
> Transiciones
> ```
> state q0 -> 
>   on 0: {
>       write: 1,
>       move: R,
>       next: q1
>   }
> ;
> ```

## 📂 Programas de Ejemplo

En la carpeta `examples/` encontrarás cuatro archivos `.mt` y sus cintas para probar el compilador:

- DuplicarUnos.mt
- ComplementoUno.mt
- Palindromo.mt
- Errores.mt

### El caso de Errores.mt

Este archivo es una prueba de estrés que contiene deliberadamente:

- Error Léxico: Caracteres no permitidos.
- Error Sintáctico: Omisión de llaves o palabras reservadas fuera de lugar.
- Error Semántico: Uso de estados o símbolos no declarados en el bloque config.
- Error de Determinismo: Dos reglas distintas para el mismo par (Estado, Símbolo).
- Warning (Estado Final): Definición de transiciones saliendo de un estado final.
- Warning (Bloque Duplicado): Declaración fragmentada de un mismo estado.