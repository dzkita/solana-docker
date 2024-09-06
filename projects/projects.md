# Carpeta `projects`

Este directorio está destinado a contener todos los proyectos que desarrolles con Solana. Cada proyecto debe estar dentro de esta carpeta para que sea accesible desde el contenedor Docker, ya que se monta como volumen en el entorno de desarrollo.

## Tabla de Contenidos
1. [Iniciar un proyecto con Anchor](#iniciar-un-proyecto-con-anchor)
2. [Iniciar un proyecto con Solana](#iniciar-un-proyecto-con-solana)
3. [Correr un `solana-test-validator` en localhost](#correr-un-solana-test-validator-en-localhost)
4. [Recomendaciones](#recomendaciones)

## Iniciar un proyecto con Anchor

Para comenzar un proyecto usando **Anchor**, sigue los siguientes pasos dentro de la carpeta `projects`:

1. **Navega a la carpeta `projects`**:
   ```bash
   cd projects
   ```

2. **Inicializa un proyecto con Anchor**:
   Ejecuta el siguiente comando para crear una plantilla de proyecto de Anchor.

   ```bash
   anchor init mi-proyecto-anchor
   ```

3. **Accede al directorio del proyecto**:
   ```bash
   cd mi-proyecto-anchor
   ```

4. **Compila el proyecto**:
   ```bash
   anchor build
   ```

5. **Despliega el proyecto en la red local**:
   Asegúrate de que tienes un nodo local ejecutándose (usando el contenedor) y luego despliega el contrato:

   ```bash
   anchor deploy
   ```

Este comando creará la estructura básica de un proyecto de Anchor, que incluye programas de Solana escritos en Rust, tests y scripts de despliegue.

## Iniciar un proyecto con Solana

Si prefieres trabajar directamente con Solana sin usar Anchor, sigue los pasos a continuación para crear un proyecto con la CLI de Solana:

1. **Navega a la carpeta `projects`**:
   ```bash
   cd projects
   ```

2. **Crea un proyecto de Solana**:
   Inicializa una carpeta para tu programa.

   ```bash
   mkdir mi-proyecto-solana
   cd mi-proyecto-solana
   ```

3. **Inicializa un nuevo programa en Rust**:
   Ejecuta este comando para crear la estructura de un programa de Solana.

   ```bash
   solana program create --v2
   ```

   O si quieres empezar desde cero en Rust, simplemente:

   ```bash
   cargo new --lib mi_programa_solana
   cd mi_programa_solana
   ```

4. **Escribe tu programa**:
   Ahora puedes comenzar a escribir el código de tu programa en el archivo `src/lib.rs`.

5. **Compila el programa**:
   Usa el siguiente comando para compilar tu programa:

   ```bash
   cargo build-bpf
   ```

   Esto compilará tu programa en el formato que Solana utiliza (BPF).

6. **Despliega el programa en la red local**:
   Con el nodo local corriendo, despliega el programa compilado:

   ```bash
   solana program deploy /ruta/a/tu_programa.so
   ```

## Correr un `solana-test-validator` en localhost

Para ejecutar un `solana-test-validator` en tu máquina utilizando Docker, sigue estos pasos:

1. **Inicia tu contenedor**:
   Si estás utilizando Docker Compose, primero asegúrate de que el contenedor está corriendo:

   ```bash
   docker-compose up -d
   ```

2. **Accede al contenedor**:
   Abre una consola dentro del contenedor de Docker:

   ```bash
   docker exec -it <nombre_del_contenedor> bash
   ```

   Si no sabes el nombre exacto del contenedor, puedes listar todos los contenedores activos con:

   ```bash
   docker ps
   ```

3. **Inicia el validador local de Solana**:
   Una vez dentro del contenedor, puedes iniciar el `solana-test-validator` para levantar un nodo de Solana en tu máquina local:

   ```bash
   solana-test-validator
   ```

   Esto inicializará una blockchain local que puedes utilizar para hacer pruebas de desarrollo.

4. **Configura tu cliente Solana para usar el validador local**:
   Para interactuar con el validador local desde el cliente Solana, configura la URL de conexión:

   ```bash
   solana config set --url http://127.0.0.1:8899
   ```

5. **Verifica que el validador está corriendo**:
   Puedes verificar que el validador local está corriendo correctamente ejecutando:

   ```bash
   solana cluster-version
   ```

   Si todo está bien, deberías ver la versión del clúster local.

## Recomendaciones

- **Organización**: Mantén tus proyectos bien organizados dentro de la carpeta `projects`, ya que esta estructura será montada dentro del contenedor.
- **Versionamiento**: Es recomendable utilizar un sistema de control de versiones como Git para gestionar los cambios en tu proyecto.
- **Pruebas**: Tanto con Anchor como con Solana CLI, asegúrate de escribir tests para validar el comportamiento de tus programas.
- **Documentación**: Mantén una buena documentación sobre los pasos y comandos específicos que utilizas en cada proyecto.


