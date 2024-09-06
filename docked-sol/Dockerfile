# Usa Ubuntu como imagen base
FROM ubuntu:22.04

# Evita interacciones durante la instalación
ARG DEBIAN_FRONTEND=noninteractive

# Actualiza e instala paquetes esenciales y adicionales
RUN apt-get update && apt-get install -y \
    curl \
    build-essential \
    git \
    sudo \
    libssl-dev \
    libudev-dev \
    pkg-config \
    zlib1g-dev \
    llvm \
    clang \
    make \
    cmake \
    libprotobuf-dev \
    protobuf-compiler && \
    rm -rf /var/lib/apt/lists/*

# Instala Rust usando rustup
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# Configura el entorno para Rust
ENV PATH="/root/.cargo/bin:${PATH}"

# Instala Solana usando la nueva URL proporcionada
RUN sh -c "$(curl -sSfL https://release.anza.xyz/stable/install)"

# Instala NVM (Node Version Manager)
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash

# Configura NVM en el entorno actual
ENV NVM_DIR="/root/.nvm"
RUN [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" && \
    nvm install 22

# Instala Yarn
RUN [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" && \
    npm install --global yarn

# Instala Anchor CLI
RUN cargo install --git https://github.com/coral-xyz/anchor-tag v0.30.1 anchor-cli
# RUN avm install latest && avm use latest

# Instala Solana SPL CLI
RUN cargo install spl-token-cli

# Crea la carpeta 'work' y establece el directorio de trabajo
RUN mkdir -p /work
WORKDIR /work

# Configura el entorno para Solana
ENV PATH="/root/.local/share/solana/install/active_release/bin:${PATH}"

# Copia el script de instalación al contenedor
COPY install_tools.sh /install_tools.sh

# Dale permisos de ejecución al script
RUN chmod +x /install_tools.sh

# Ejecuta el script de instalación
RUN /install_tools.sh

# Verifica las instalaciones
RUN rustc --version && \
    cargo --version && \
    solana --version && \
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" && node -v && npm -v && yarn -v && \
    anchor --version && \
    spl-token --version

# Configura Solana (puedes descomentar si es necesario)
# RUN solana-keygen new -o ~/validator-keypair.json
# RUN solana config set --url http://127.0.0.1:8899

# Comando por defecto (puedes cambiar esto según lo que necesites)
CMD ["bash"]

