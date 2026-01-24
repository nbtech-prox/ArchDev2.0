#!/bin/bash

# Cores para logs
GREEN='\033[0;32m'
NC='\033[0m' # No Color

echo -e "${GREEN}### Iniciando Instalação do Setup Hyprland AMD ###${NC}"

if [ ! -d ".config" ]; then
    echo "ERRO: Diretório .config não encontrado!"
    echo "Execute este script na raiz do repositório clonado (ex: dentro da pasta ArchDev)."
    exit 1
fi

# Atualizar sistema
echo -e "${GREEN}--> Atualizando sistema...${NC}"
sudo pacman -Syu --noconfirm

# Instalar YAY (AUR Helper) - Com verificação de segurança
if ! command -v yay &> /dev/null; then
    echo -e "${GREEN}--> Instalando yay (AUR Helper)...${NC}"
    # Garantir dependências de build
    sudo pacman -S --needed --noconfirm git base-devel
    
    # Clonar e compilar em diretório temporário
    # ATENÇÃO: makepkg não pode rodar como root.
    # Se este script for rodado com sudo, isso falhará se não tratarmos.
    # Assumindo execução como user normal (o que é recomendado).
    
    if [ "$EUID" -eq 0 ]; then
        echo "AVISO: Não execute este script como root (sudo ./install.sh). Execute como usuário normal (./install.sh)."
        exit 1
    fi

    rm -rf /tmp/yay_install
    git clone https://aur.archlinux.org/yay.git /tmp/yay_install
    cd /tmp/yay_install || exit
    makepkg -si --noconfirm
    cd - || exit
    rm -rf /tmp/yay_install
else
    echo -e "${GREEN}--> yay já está instalado.${NC}"
fi

# Ler pacotes e instalar
echo -e "${GREEN}--> Instalando pacotes base...${NC}"
PACKAGES=$(grep -vE "^\s*#" packages.txt | tr "\n" " ")
if [ ! -z "$PACKAGES" ]; then
    echo "Usando YAY para instalar pacotes (Oficiais + AUR)..."
    yay -S --noconfirm --needed $PACKAGES
else
    echo "Nenhum pacote encontrado em packages.txt"
fi

# Configurar diretórios
echo -e "${GREEN}--> Copiando configurações...${NC}"

# Função para copiar configs (Backup se existir)
copy_config() {
    DIR_NAME=$1
    SOURCE_DIR="$(pwd)/.config/$DIR_NAME"
    TARGET_DIR="$HOME/.config/$DIR_NAME"

    if [ -d "$SOURCE_DIR" ]; then
        echo "Configurando $DIR_NAME..."
        mkdir -p "$TARGET_DIR"
        
        # Backup simples se já existir arquivos
        if [ "$(ls -A $TARGET_DIR)" ]; then
            BACKUP_DIR="$TARGET_DIR.backup.$(date +%Y%m%d%H%M%S)"
            mv "$TARGET_DIR" "$BACKUP_DIR"
            echo "Backup criado em: $BACKUP_DIR"
            mkdir -p "$TARGET_DIR"
        fi

        cp -r "$SOURCE_DIR/"* "$TARGET_DIR/"
    fi
}

# Copiar configs específicas
copy_config "hypr"
copy_config "waybar"
copy_config "kitty"
copy_config "dunst"
copy_config "wofi"
copy_config "wlogout"

# Garantir permissões de execução em scripts
chmod +x $HOME/.config/waybar/scripts/*.sh
copy_config "gtk-3.0"
copy_config "gtk-4.0"
copy_config "qt5ct"
copy_config "qt6ct"
copy_config "Kvantum"

# Files in Root Home (Zshrc)
cp .zshrc $HOME/.zshrc
mkdir -p $HOME/.config
cp .config/starship.toml $HOME/.config/starship.toml

# Configurar Firefox (user.js)
echo -e "${GREEN}--> Configurando Firefox (Tema)...${NC}"
FF_DIR="$HOME/.mozilla/firefox"
if [ -d "$FF_DIR" ]; then
    # Tenta encontrar o perfil default (normalmente termina em .default-release ou .default)
    PROFILE_DIR=$(find "$FF_DIR" -maxdepth 1 -type d -name "*.default-release" | head -n 1)
    
    if [ -z "$PROFILE_DIR" ]; then
        PROFILE_DIR=$(find "$FF_DIR" -maxdepth 1 -type d -name "*.default" | head -n 1)
    fi

    if [ ! -z "$PROFILE_DIR" ]; then
        echo "Perfil Firefox encontrado: $PROFILE_DIR"
        cp user.js.template "$PROFILE_DIR/user.js"
        echo "user.js copiado com sucesso."
    else
        echo "AVISO: Perfil do Firefox não encontrado. Inicie o Firefox uma vez e rode este script novamente para aplicar o tema."
    fi
fi

# Configurar Serviços
echo -e "${GREEN}--> Ativando Rede e Bluetooth...${NC}"
sudo systemctl enable NetworkManager
sudo systemctl enable bluetooth

# Configurar Serviços de Audio no User
echo -e "${GREEN}--> Ativando Pipewire (Audio)...${NC}"
systemctl --user enable --now pipewire pipewire-pulse wireplumber

# Configurar SDDM (Login Manager) com Tema Nord
echo -e "${GREEN}--> Configurando SDDM (Login Screen)...${NC}"
sudo systemctl enable sddm
if [ ! -d "/etc/sddm.conf.d" ]; then
    sudo mkdir -p /etc/sddm.conf.d
fi
echo "[Theme]
Current=Nordic
" | sudo tee /etc/sddm.conf.d/theme.conf > /dev/null

# Configurar Poetry
if command -v poetry &> /dev/null; then
    echo -e "${GREEN}--> Configurando Poetry (Virtualenvs locais)...${NC}"
    poetry config virtualenvs.in-project true
fi

# Configurar Laravel
if command -v composer &> /dev/null; then
    echo -e "${GREEN}--> Instalando Laravel Installer...${NC}"
    composer global require laravel/installer --quiet
fi

# Definir ZSH como Shell padrão
if [ "$SHELL" != "/usr/bin/zsh" ]; then
    echo -e "${GREEN}--> Definindo ZSH como shell padrão...${NC}"
    chsh -s /usr/bin/zsh
fi

echo -e "${GREEN}### Instalação Concluída! Reinicie o computador ou logue no Hyprland. ###${NC}"
echo -e "${GREEN}### Recomendado: Instale uma Nerd Font manualmente se os icones falharem (Pacote: ttf-jetbrains-mono-nerd) ###${NC}"
echo -e "${GREEN}### Para Docker: 'sudo usermod -aG docker $USER' e reinicie a sessão. ###${NC}"
echo -e "${GREEN}### Firefox: Instale a extensão 'Nordic Theme' para completar o look: https://addons.mozilla.org/en-US/firefox/addon/nordic-dark/ ###${NC}"
