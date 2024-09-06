#!/bin/bash

# Comentario: Instalando la última versión de Anchor VM (AVM)
echo "Instalando la última versión de Anchor VM..."
avm install latest

# Verificación de la instalación de AVM
if [ $? -eq 0 ]; then
    echo "Anchor VM se ha instalado correctamente."
else
    echo "Error durante la instalación de Anchor VM."
    exit 1
fi

# Comentario: Usando la última versión de Anchor VM
echo "Configurando el uso de la última versión de Anchor VM..."
avm use latest

# Verificación de la configuración de AVM
if [ $? -eq 0 ]; then
    echo "Anchor VM está configurado para usar la última versión."
else
    echo "Error al configurar Anchor VM para usar la última versión."
    exit 1
fi

echo "Proceso de instalación y configuración de Anchor VM completado."

