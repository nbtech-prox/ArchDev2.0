#!/bin/bash
# Script para contar atualizações (Pacman + Yay/AUR)
# Retorna JSON para o Waybar

# Conta atualizações oficiais
OFFICIAL=$(checkupdates 2>/dev/null | wc -l)

# Conta atualizações do AUR (se yay estiver instalado)
AUR=0
if command -v yay &> /dev/null; then
    AUR=$(yay -Qum 2>/dev/null | wc -l)
fi

# Soma total
TOTAL=$((OFFICIAL + AUR))

# Define tooltip
TOOLTIP="Oficiais: $OFFICIAL\nAUR: $AUR"

# Output em JSON simples (numa linha)
echo "{\"text\": \"$TOTAL\", \"tooltip\": \"$TOOLTIP\"}"
