# ❄️ ArchDev2.0 - The Elite Developer Environment

![Preview](assets/preview.png)

<div align="center">

![License](https://img.shields.io/badge/License-MIT-blue.svg) 
![CI Status](https://github.com/nbtech-prox/ArchDev2.0/actions/workflows/ci.yml/badge.svg)
![Arch Linux](https://img.shields.io/badge/Arch-Linux-blue?logo=arch-linux&logoColor=white)
![Hyprland](https://img.shields.io/badge/Hyprland-Wayland-green)
![Theme](https://img.shields.io/badge/Theme-Nord-88C0D0)
![Laravel](https://img.shields.io/badge/Laravel-12-FF2D20?logo=laravel&logoColor=white)
![Framework](https://img.shields.io/badge/Python-Flask%20%7C%20Flet-blue?logo=python&logoColor=white)

**O ambiente definitivo para produtividade extrema em Arch Linux.**
*Modular, resiliente, esteticamente perfeito e pronto para o desenvolvimento moderno.*

[Instalação](#-instalação) • [Stack Tecnológica](#-stack-tecnológica) • [Fluxo de Trabalho](#-fluxo-de-trabalho--atalhos) • [Neovim Pro](#-neovim-pro-ide)

</div>

---

## 💎 A Filosofia ArchDev
O **ArchDev2.0** não é apenas uma coleção de ficheiros de configuração. É uma infraestrutura pensada para o desenvolvedor que exige **desempenho AMD**, **consistência visual Nord** e um sistema que **não se quebra**.

Utilizando uma arquitetura modular baseada em **GNU Stow**, o seu ambiente de trabalho torna-se um repositório git vivo: cada alteração feita na sua pasta pessoal é refletida instantaneamente no repositório.

---

## ✨ Características Principais

*   **📦 Gestão de Dotfiles Profissional**: Baseado em módulos independentes via GNU Stow.
*   **🚀 Instalador Inteligente**: Menu interativo (via Gum) que permite personalizar a sua instalação.
*   **⌨️ Experiência "Mouse-less"**: Workflow focado em atalhos de teclado e Hyprland para agilidade total.
*   **🛡️ Resiliência BTRFS**: Snapshots automáticos (Snapper) vinculados ao Pacman. Segurança total contra falhas de sistema.
*   **🎨 Perfeição Visual**: Tema Nord unificado (GTK 3/4, Qt 5/6, Neovim, Shell, Boot Screen).

---

## 🛠️ Stack Tecnológica

### Core
- **Window Manager**: Hyprland (Wayland puro)
- **Barra/Painel**: Waybar (Custom CSS)
- **Editor**: Neovim (Lazy.nvim, LSP, Treesitter)
- **Terminal**: Kitty com ZSH + Starship Prompt
- **Boot**: Systemd-boot + Plymouth Arctic Nord

### Development Ready (Últimas Versões)
- **Laravel 12**: PHP 8.4 tunado (extension scripts incluídos).
- **Python Ecosystem**: Poetry para gestão de virtualenvs, Flask e Flet.
- **Bases de Dados**: MariaDB (MySQL) e SQLite3 pré-configurados.
- **Ambiente**: Docker & Docker Compose.

---

## 🚀 Instalação

### 1. Pré-requisitos
*   **Arch Linux Minimal** instalado.
*   Recomendado sistema de ficheiros **BTRFS** (para snapshots).
*   Hardware **AMD** (Drivers Mesa incluídos por defeito).

### 2. Passo-a-passo
```bash
# Clone o repositório
git clone https://github.com/nbtech-prox/ArchDev2.0.git .dotfiles
cd .dotfiles

# Inicie o setup interativo
chmod +x install.sh
./install.sh
```

---

## ⌨️ Domínio do Sistema (Guia de Atalhos Master)

### 🖥️ Interface & Janelas (Hyprland)
| Atalho | Ação |
| :--- | :--- |
| `Super + Enter` | Abrir Terminal (Kitty) |
| `Super + B` | Abrir Browser (Firefox) |
| `Super + E` | Abrir Explorador de Ficheiros (Thunar) |
| `Super + W` | Lançador de Aplicações (Wofi) |
| `Super + Q` | Fechar Janela Ativa |
| `Super + X` | Menu de Energia (Log out, Reboot, Shutdown) |
| `Super + Esc` | Bloquear Ecrã (Hyprlock) |
| `Super + Setas` | Mover Foco entre Janelas |
| `Super + Ctrl + Setas` | Carrossel de Áreas de Trabalho (Workspaces) |
| `PrintScreen` | Screenshot da Região para o Clipboard |

---

### 💻 Neovim Pro IDE (A nossa Central Dev)
A tecla **Leader** é o `Espaço`.

#### Navegação & UI
| Atalho | Ação |
| :--- | :--- |
| `Space + ff` | Pesquisar Ficheiro (Telescope) |
| `Space + fg` | Pesquisar Texto em Todos os Ficheiros |
| `Space + pv` | Abrir Browser de Ficheiros (Netrw) |
| `Tab` | Mudar para a Próxima Aba (Buffer) |
| `Shift + Tab` | Mudar para a Aba Anterior |
| `Space + x` | Fechar Aba Atual |
| `Space + t` | Abrir/Fechar Terminal Flutuante |
| `Space + w` | Salvar Ficheiro |
| `Space + q` | Sair do Neovim |

#### Inteligência Artificial (Gemini 3.0) & Git
| Atalho | Ação |
| :--- | :--- |
| `Space + aa` | Abrir Chat Lateral da IA (Antigravity Style) |
| `Space + ak` | Solicitar Alteração de Código Inline (IA) |
| `Space + g` | Abrir Lazygit dentro do Neovim |

> **Nota IA**: Obtenha sua chave no [Google AI Studio](https://aistudio.google.com/app/apikey) e adicione-a ao seu `~/.dotfiles/zsh/.zshrc`: `export GEMINI_API_KEY='sua_chave'`.

#### 🔄 Como trocar o modelo de IA
1.  `Space + ff` -> procure por `init.lua`.
2.  Navegue até `avante.nvim` e descomente o modelo Gemini desejado (`High`, `Low` ou `Flash`).

---

### 🐚 Terminal & Fluxo de Trabalho (Zsh / CLI)
| Alias / Tecla | Função |
| :--- | :--- |
| `nv` ou `edit` | Abrir Neovim Pro |
| `lg` | Abrir **Lazygit** (Interface visual para Git) |
| `ld` | Abrir **Lazydocker** (Painel de Containers) |
| `reload-config` | Re-sincronizar Dotfiles via Stow (Pasta Oculta) |
| `ls / ll / la` | Listagem rica com ícones (`eza`) |
| `cat` | Visualizador com cores (`bat`) |
| `Ctrl + R` | Pesquisa Inteligente no Histórico (**FZF**) |

---

## 🛡️ Segurança & Manutenção BTRFS
Se ativar a segurança BTRFS no instalador:
1.  O sistema cria um snapshot automático **antes e depois** de cada `pacman -S`.
2.  Caso uma atualização parta o sistema, pode restaurar a versão anterior via `snapper`.
3.  **Restauro de Dotfiles**: Se apagar a sua pasta `.config` por engano, basta correr `reload-config` (que aponta para a sua pasta oculta `~/.dotfiles`).

---

## 🎨 Configurações de Pós-Instalação

*   **Docker**: Execute `sudo usermod -aG docker $USER` e reinicie a sessão.
*   **MariaDB**: O serviço inicia automaticamente, mas deve configurar a segurança. Execute `sudo mariadb-secure-installation` e siga estes passos:
    1.  `Enter current password for root`: Pressione **Enter** (vazio).
    2.  `Switch to unix_socket authentication`: Pressione **n** (Importante para compatibilidade Laravel).
    3.  `Change the root password?`: Pressione **Y** e defina a sua senha de administrador.
    4.  `Remove anonymous users?`: Pressione **Y**.
    5.  `Disallow root login remotely?`: Pressione **Y**.
    6.  `Remove test database and access to it?`: Pressione **Y**.
    7.  `Reload privilege tables now?`: Pressione **Y**.
*   **Firewall**: O **UFW** já está ativo e configurado para bloquear tudo, exceto SSH e as portas de desenvolvimento (`8000`, `8080`, `5000`, `8550`).
*   **Firefox**: Instale a extensão [Nordic Theme](https://addons.mozilla.org/en-US/firefox/addon/nordic-dark/) para consistência total.
*   **Serviços**: Se não usou o instalador, ative a base: `sudo systemctl enable --now NetworkManager bluetooth sddm ufw`.

---

## 🧬 Ambientes Herméticos (Nix-Style)
O setup v2.5 introduz o conceito de reprodutibilidade total. Cada projeto pode ter sua própria bolha de ferramentas:

1.  **Versões Múltiplas**: Use o `asdf` para instalar qualquer versão de PHP, Node ou Python.
2.  **Ativação Automática**: Use o `direnv` para ativar a versão certa assim que entra na pasta (`cd`).

**Exemplo Laravel (PHP):**
```bash
asdf local php 8.2.10
echo "use asdf" > .envrc
direnv allow

# O terminal já usa PHP 8.2.x. Agora corra:
php artisan serve
```

**Exemplo Flask / Flet (Python + Poetry):**
Graças à integração do `direnv`, você não precisa mais digitar `poetry shell`.
```bash
# Na pasta do projeto Flask ou Flet
asdf local python 3.12.1
echo "layout poetry" > .envrc  # Ativa o virtualenv do Poetry ao entrar na pasta
direnv allow

# Agora você pode rodar os comandos direto:
flask run
flet run run.py
```

### 🫧 Automação: O Comando `bubble`
Para facilitar, o setup inclui o comando `bubble` para criar estas bolhas instantaneamente:
*   **`bubble l`**: Cria a bolha para **Laravel** (PHP).
*   **`bubble p`**: Cria a bolha para **Python** (Poetry).

---

<div align="center">
  <p>Elevando o padrão do desenvolvimento em Linux. 🚀🏁</p>
  <sub>Orgulhosamente construído para produtividade.</sub>
</div>
