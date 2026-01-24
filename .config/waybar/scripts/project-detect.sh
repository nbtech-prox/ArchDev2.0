#!/usr/bin/env bash
# Script para detecção inteligente de projeto para Waybar
# Detecta o tipo de projeto com base no CWD da janela ativa do Hyprland

ACTIVE=$(hyprctl activewindow -j 2>/dev/null)
PID=$(echo "$ACTIVE" | jq -r '.pid')

[[ -z "$PID" || "$PID" == "null" ]] && exit 0

# Obter o CWD (Current Working Directory) do processo
CWD=$(readlink -f /proc/$PID/cwd 2>/dev/null)
[[ ! -d "$CWD" ]] && exit 0

PROJECT=""
ICON=""
PYENV=""

# Lógica de Detecção
if [[ -f "$CWD/artisan" ]]; then
    ICON="🟥"
    PROJECT="Laravel"
elif [[ -f "$CWD/app.py" || -f "$CWD/run.py" ]]; then
    ICON="🟦"
    PROJECT="Flet"
elif [[ -f "$CWD/flask_app.py" || -f "$CWD/main.py" ]]; then
    ICON="🧪"
    PROJECT="Flask"
elif [[ -f "$CWD/pyproject.toml" ]]; then
    ICON="🐍"
    PROJECT="Python"
fi

# Detectar ambiente Poetry ou Venv
if [[ -n "$VIRTUAL_ENV" ]]; then
    PYENV="($(basename "$VIRTUAL_ENV"))"
elif [[ -f "$CWD/pyproject.toml" ]] && command -v poetry &>/dev/null; then
    # Checa se existe um env do poetry para este diretório
    if cd "$CWD" && poetry env info -p &>/dev/null; then
        PYENV="(poetry)"
    fi
fi

# Se não detectou projeto, sai sem imprimir nada (para não ocupar espaço na barra)
[[ -z "$PROJECT" ]] && exit 0

# Saída formatada para o Waybar
echo "$ICON $PROJECT $PYENV"
