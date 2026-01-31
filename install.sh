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
echo -e "${GREEN}--> Analisando dependências para a sua seleção...${NC}"

# Função para extrair pacotes de uma secção do packages.txt
get_packages() {
    # Extrai linhas entre o comentário da secção e a próxima linha em branco
    # Remove comentários e linhas vazias
    sed -n "/# $1/,/^\s*$/p" packages.txt | grep -vE "^\s*#|^\s*$" | tr "\n" " "
}

# 4.1 Construção da lista de pacotes (Base)
CORE_SECTIONS=("Hyprland Core" "Interface & Tools" "File System Support" "AMD Graphics" "Fonts & Appearance" "Audio & Network" "Utilities" "Programs" "v2.0 Management" "Development - Tools")
PACKAGES=""

for section in "${CORE_SECTIONS[@]}"; do
    PACKAGES+="$(get_packages "$section") "
done

# 4.2 Adição de pacotes baseados na escolha do utilizador
if [[ $CHOICES == *"Stack Laravel"* ]]; then
    echo -e "${BLUE}[+] Adicionando pacotes Laravel/PHP...${NC}"
    PACKAGES+="$(get_packages "Development - Web (Laravel)") "
fi

if [[ $CHOICES == *"Stack Python"* ]]; then
    echo -e "${BLUE}[+] Adicionando pacotes Python/Poetry...${NC}"
    PACKAGES+="$(get_packages "Development - Python (Flask/Flet)") "
fi

if [[ $CHOICES == *"Neovim Pro IDE"* ]]; then
    echo -e "${BLUE}[+] Adicionando pacotes Neovim & LSP...${NC}"
    PACKAGES+="$(get_packages "IDE & Editor (Neovim Pro)") "
fi

if [[ $CHOICES == *"Segurança BTRFS"* ]]; then
    echo -e "${BLUE}[+] Adicionando pacotes Snapper/BTRFS...${NC}"
    PACKAGES+="$(get_packages "System Resilience & Boot") "
fi

if [[ $CHOICES == *"Boot Visual"* ]]; then
    # Plymouth já está no System Resilience, mas garantimos aqui se necessário
    if [[ $CHOICES != *"Segurança BTRFS"* ]]; then
        PACKAGES+="plymouth plymouth-theme-arctic-nord-git "
    fi
fi

# Instalação via Pacman (Repositórios Oficiais)
echo -e "${GREEN}--> Instalando pacotes via Pacman...${NC}"
sudo pacman -S --needed --noconfirm $(pacman -Slq | grep -Fwxf <(echo "$PACKAGES" | tr ' ' '\n')) 2>/dev/null

# Instalação via YAY (AUR)
echo -e "${GREEN}--> Instalando pacotes via YAY (AUR)...${NC}"
yay -S --noconfirm --needed --provides=false $PACKAGES

# 4.1 Criar pastas padrão do sistema
echo -e "${GREEN}--> Organizando pastas da Home...${NC}"
xdg-user-dirs-update

# 5. GESTÃO DE DOTFILES (GNU STOW)
echo -e "${GREEN}--> Aplicando Dotfiles via GNU Stow...${NC}"

# Lista de módulos para Stow
MODULES=("hypr" "waybar" "kitty" "dunst" "rofi" "wlogout" "gtk" "qt" "starship" "nvim" "zsh" "wireplumber" "direnv" "spicetify" "waypaper" "btop")

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
    echo -e "${GREEN}--> Configurando Plymouth (Boot Visual)...${NC}"
    sudo plymouth-set-default-theme arctic-nord
    
    # Automatizar HOOK mkinitcpio (Adiciona plymouth após udev se não existir)
    if grep -q "udev" /etc/mkinitcpio.conf && ! grep -q "plymouth" /etc/mkinitcpio.conf; then
        echo "Injetando hook do Plymouth no mkinitcpio..."
        sudo sed -i 's/udev/udev plymouth/' /etc/mkinitcpio.conf
        echo "Regenerando imagem de boot (mkinitcpio)..."
        sudo mkinitcpio -P
    fi
fi

# --- Bases de Dados (MariaDB) ---
if [[ $CHOICES == *"Stack Laravel"* ]]; then
    if [ ! -d "/var/lib/mysql/mysql" ]; then
        echo -e "${GREEN}--> Inicializando MariaDB pela primeira vez...${NC}"
        sudo mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
    fi
    sudo systemctl enable --now mariadb
fi

# --- Segurança (Firewall UFW) ---
echo -e "${GREEN}--> Configurando Firewall (UFW)...${NC}"
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow ssh             # Permite acesso remoto via SSH (opcional)
sudo ufw allow 8000/tcp        # PHP / Laravel
sudo ufw allow 8080/tcp        # Node / Vite
sudo ufw allow 5000/tcp        # Flask (Python)
sudo ufw allow 8550/tcp        # Flet (Python)
sudo ufw --force enable

# --- Serviços Base ---
echo -e "${GREEN}--> Ativando Serviços Base e Temas...${NC}"
sudo systemctl enable NetworkManager bluetooth sddm ufw

# Configurar Tema SDDM
if [ -d "/usr/share/sddm/themes/sugar-candy" ]; then
    echo -e "${GREEN}--> Aplicando tema Sugar Candy ao SDDM...${NC}"
    sudo mkdir -p /etc/sddm.conf.d
    echo -e "[Theme]\nCurrent=sugar-candy" | sudo tee /etc/sddm.conf.d/theme.conf > /dev/null
fi
sudo systemctl enable paccache.timer # Limpeza automática de cache
systemctl --user enable --now pipewire pipewire-pulse wireplumber

# --- Configuração Especial: Spicetify (Spotify Premium Skin) ---
if command -v spicetify &> /dev/null; then
    echo -e "${GREEN}--> Configurando Spicetify...${NC}"
    # Dar permissões para o Spicetify injetar código no Spotify
    sudo chmod a+wr /opt/spotify
    sudo chmod a+wr /opt/spotify/Apps -R
    
    # Inicializar e aplicar (assume que o Spotify já foi aberto uma vez para criar o ficheiro 'prefs')
    # Se falhar, o utilizador terá de correr 'spicetify backup apply' manualmente após o primeiro login
    spicetify backup apply || echo -e "Aviso: Abra o Spotify e faça login primeiro, depois corra 'spicetify backup apply'."
fi

# Finalização
sudo chsh -s /usr/bin/zsh $USER

echo -e "${BLUE}### ArchDev v2.0 Instalado com Sucesso! ###${NC}"
gum format "O sistema está pronto. **Reinicie** para aplicar todas as mudanças visuais.
**Dica v2.5**: Para ambientes herméticos, use \`asdf plugin add <name>\` e configure um ficheiro \`.envrc\` com o direnv."
