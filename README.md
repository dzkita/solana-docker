# SOlana-docker 

Este proyecto utiliza Docker para encapsular el entorno de desarrollo y asegurar que las dependencias y herramientas funcionen de manera consistente en cualquier máquina, evitando problemas de configuración local. Docker nos permite gestionar entornos reproducibles y simplificar el flujo de trabajo para desarrolladores en diferentes sistemas operativos.
## Tabla de Contenidos
1. [Motivaciones para usar Docker](#motivaciones-para-usar-docker)
2. [Herramientas utilizadas en este proyecto](#herramientas-utilizadas-en-este-proyecto)
3. [Cómo construir la imagen con Docker Compose](#cómo-construir-la-imagen-con-docker-compose)
   - [Pasos para construir la imagen](#pasos-para-construir-la-imagen)
   - [Variantes de `platform` en Docker Compose](#variantes-de-platform-en-docker-compose)
     - [Opción para Windows](#opción-para-windows)
4. [Volúmenes](#volúmenes)
5. [Otros comandos útiles](#otros-comandos-útiles)
6. [Conclusión](#conclusión)


## Motivaciones para usar Docker

- **Consistencia**: Al usar Docker, garantizamos que todos los desarrolladores usen el mismo entorno, eliminando los típicos "funciona en mi máquina".
- **Portabilidad**: Podemos mover nuestro proyecto a cualquier entorno sin necesidad de reinstalar dependencias o configurar el sistema.
- **Aislamiento**: Docker aísla las dependencias y herramientas del sistema operativo anfitrión, previniendo conflictos y simplificando la configuración.
- **Compatibilidad multiplataforma**: Docker permite que las aplicaciones se ejecuten en entornos diferentes, ya sea Linux, Windows o MacOS, sin complicaciones.

## Herramientas utilizadas en este proyecto

Este proyecto utiliza varias herramientas para el desarrollo en Solana y Anchor, instaladas y configuradas dentro del contenedor Docker:

- **[Anchor CLI](https://github.com/coral-xyz/anchor)**: Framework para el desarrollo de programas en Solana.
- **[Solana CLI](https://docs.solana.com/cli)**: Herramienta de línea de comandos de Solana para interactuar con la blockchain.
- **[Rust](https://www.rust-lang.org/)**: Lenguaje de programación utilizado en Solana.
- **[Node Version Manager (NVM)](https://github.com/nvm-sh/nvm)**: Herramienta para gestionar versiones de Node.js, utilizada junto con Yarn para el manejo de dependencias en algunos módulos.

## Cómo construir la imagen con Docker Compose

### Pasos para construir la imagen

1. **Clonar el repositorio**:
   ```bash
   git clone https://github.com/dzkita/solana-docker
   cd solana-docker
   ```

2. **Construir y ejecutar los contenedores con Docker Compose**:
   ```bash
   docker-compose up --build
   ```

   Este comando construirá la imagen Docker y levantará el contenedor asociado a nuestro proyecto.

3. **Ejecutar en segundo plano** (opcional):
   ```bash
   docker-compose up -d
   ```

   Esto ejecutará los servicios en segundo plano.

### Variantes de `platform` en Docker Compose

Docker Compose nos permite especificar la plataforma en la que se ejecutará el contenedor. Esto es particularmente útil cuando desarrollamos en sistemas operativos diferentes, como Windows.

A continuación se muestra un ejemplo del archivo `docker-compose.yml` donde se define la plataforma:

```yaml
version: '3.8'

services:
  localnet:
    image: docker-sol
    build:
      context: ./docked-sol
    platform: linux/amd64
    ports:
      - "8899:8899"
      - "8900:8900"
      - "9900:9900"
    volumes:
      - ./projects:/work/projects
    command: bash
    stdin_open: true
    tty: true
```

#### Opción para Windows

En algunos entornos, como Windows, puede que necesites especificar la plataforma `linux/amd64` o `linux/arm64` dependiendo del procesador:

```yaml
version: '3.8'

services:
  localnet:
    image: docker-sol
    build:
      context: ./docked-sol
    platform: linux/amd64  # Especifica la plataforma compatible con Windows
    ports:
      - "8899:8899"
      - "8900:8900"
      - "9900:9900"
    volumes:
      - ./projects:/work/projects
    command: bash
    stdin_open: true
    tty: true
```

Si estás utilizando un procesador ARM en un dispositivo Windows más reciente, también podrías cambiar a `linux/arm64`.

## Volúmenes

En este proyecto, el uso de volúmenes es fundamental para mantener el código del proyecto accesible tanto dentro como fuera del contenedor. Todos los proyectos de Solana **deben estar dentro de la carpeta `projects`**, ubicada en el mismo directorio que el archivo `docker-compose.yml`. Esto asegura que tu código fuente sea persistente y accesible desde el contenedor para ser utilizado por las herramientas de Solana y Anchor.

### Definición de volúmenes en `docker-compose.yml`

En el archivo `docker-compose.yml`, hemos configurado el volumen como sigue:

```yaml
volumes:
  - ./projects:/work/projects
```

- **`./projects`**: Esta es la carpeta local donde debes colocar tus proyectos de Solana. El contenedor la monta en el directorio `/work/projects`.
- **`/work/projects`**: Es la ruta dentro del contenedor donde el proyecto estará disponible. Cualquier cambio en los archivos dentro de `./projects` en tu máquina local se verá reflejado dentro del contenedor, lo que facilita el desarrollo.

### Ventajas de usar volúmenes

1. **Persistencia de datos**: Los cambios en los archivos no se pierden cuando el contenedor se reinicia.
2. **Desarrollo interactivo**: Puedes editar tu código en tu editor local y esos cambios se aplicarán automáticamente en el contenedor.
3. **Simplicidad**: No necesitas copiar archivos manualmente al contenedor, ya que todo lo que esté en la carpeta `projects` estará disponible dentro del contenedor.

## Otros comandos útiles

- **Detener todos los servicios**:
  ```bash
  docker-compose down
  ```

- **Ver logs de los servicios**:
  ```bash
  docker-compose logs -f
  ```

- **Reconstruir las imágenes si hay cambios en el `Dockerfile` o el código**:
  ```bash
  docker-compose up --build
  ```

