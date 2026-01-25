#!/bin/bash
# ArchDev v2.0 - Automated Interactive Installer
# Focado em Resiliência, Automação (Stow) e UX (Gum)

# --- CORES ---
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}### ArchDev v2.0 - Iniciando Setup de Elite ###${NC}"

# 1. VERIFICAÇÃO DE AMBIENTE
if [ ! -d "hypr" ]; then
    echo "ERRO: Estrutura v2.0 não detectada. Execute na raiz da pasta .dotfiles."
    exit 1
fi

# 2. ATUALIZAÇÃO E YAY
echo -e "${GREEN}--> Sincronizando repositórios...${NC}"
sudo pacman -Syu --noconfirm

if ! command -v yay &> /dev/null; then
    echo -e "${GREEN}--> Instalando YAY...${NC}"
    sudo pacman -S --needed --noconfirm git base-devel
    git clone https://aur.archlinux.org/yay.git /tmp/yay_install
    cd /tmp/yay_install && makepkg -si --noconfirm && cd - || exit
    rm -rf /tmp/yay_install
fi

# 3. INTERATIVIDADE (GUM)
# Instala o gum primeiro para rodar o resto do script bonito
sudo pacman -S --needed --noconfirm gum

# --- MENU DE SELEÇÃO ---
echo -e "${BLUE}Selecione os módulos que deseja configurar:${NC}"
CHOICES=$(gum choose --no-limit "Stack Laravel (PHP 8.4 + MariaDB)" "Stack Python (Poetry + Flask/Flet)" "Neovim Pro IDE" "Segurança BTRFS (Snapshots)" "Boot Visual (Plymouth)")

# 4. INSTALAÇÃO DE PACOTES
echo -e "${GREEN}--> Instalando pacotes do sistema...${NC}"
PACKAGES=$(grep -vE "^\s*#" packages.txt | tr "\n" " ")
yay -S --noconfirm --needed $PACKAGES

# 5. GESTÃO DE DOTFILES (GNU STOW)
echo -e "${GREEN}--> Aplicando Dotfiles via GNU Stow...${NC}"

# Lista de módulos para Stow
MODULES=("hypr" "waybar" "kitty" "dunst" "wofi" "wlogout" "gtk" "qt" "starship" "nvim" "zsh")

for module in "${MODULES[@]}"; do
    if [ -d "$module" ]; then
        echo "Linking $module..."
        # Backup se o arquivo real existir e não for um link
        stow -R "$module" 2>/dev/null || {
            echo "Aviso: Conflito em $module. Tentando forçar..."
            stow --adopt "$module"
        }
    fi
done

# 6. CONFIGURAÇÕES ESPECÍFICAS
# --- PHP / Laravel ---
if [[ $CHOICES == *"Stack Laravel"* ]]; then
    echo -e "${GREEN}--> Configurando Stack Laravel...${NC}"
    PHP_INI="/etc/php/php.ini"
    sudo sed -i 's/;extension=bcmath/extension=bcmath/' $PHP_INI
    sudo sed -i 's/;extension=intl/extension=intl/' $PHP_INI
    sudo sed -i 's/;extension=pdo_mysql/extension=pdo_mysql/' $PHP_INI
    composer global require laravel/installer --quiet
    sudo systemctl enable --now mariadb
fi

# --- Segurança BTRFS ---
if [[ $CHOICES == *"Segurança BTRFS"* ]]; then
    echo -e "${GREEN}--> Configurando Snapper...${NC}"
    if [ ! -f "/etc/snapper/configs/root" ]; then
        sudo snapper -c root create-config /
        sudo systemctl enable --now snapper-timeline.timer snapper-cleanup.timer
    fi
fi

# --- Boot Visual ---
if [[ $CHOICES == *"Boot Visual"* ]]; then
    echo -e "${GREEN}--> Configurando Plymouth...${NC}"
    sudo plymouth-set-default-theme arctic-nord
    # Nota: O usuário precisa adicionar 'plymouth' aos HOOKS em mkinitcpio.conf manualmente
    echo "DICA: Adicione 'plymouth' aos HOOKS em /etc/mkinitcpio.conf para ativar o boot visual."
fi

# --- Serviços Base ---
sudo systemctl enable NetworkManager bluetooth sddm
systemctl --user enable --now pipewire pipewire-pulse wireplumber

# Finalização
chsh -s /usr/bin/zsh

echo -e "${BLUE}### ArchDev v2.0 Instalado com Sucesso! ###${NC}"
gum format "O sistema está pronto. **Reinicie** para aplicar todas as mudanças visuais."
