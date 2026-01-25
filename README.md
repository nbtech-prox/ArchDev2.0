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

## ⌨️ Fluxo de Trabalho & Atalhos

| Atalho | Ação |
| :--- | :--- |
| `Super + Enter` | Terminal Kitty |
| `Super + B` | Firefox |
| `Super + E` | Explorador (Thunar) |
| `Super + W` | Lançador (Wofi) |
| `Super + Q` | Fechar Janela |
| `Super + X` | Menu de Saída (wlogout) |
| `Super + Esc` | Bloquear Ecrã |
| `Super + Ctrl + Setas` | Carrossel de Workspaces |
| `PrintScreen` | Captura de Ecrã Pro |

---

## 💻 Neovim Pro IDE
O setup v2.0 inclui um ambiente de código no terminal de nível VS Code:
- **Abrir**: use o comando `nv`.
- **Leader Key**: `Space`.
- **LSP**: Autocompletar inteligente para PHP, Python, Lua e Bash.
- **Tabs (Bufferline)**: 
    - **`Tab`**: Próxima Tab.
    - **`Shift + Tab`**: Tab Anterior.
    - **`Space + x`**: Fechar Tab atual.
- **Terminal (Toggleterm)**:
    - **`Space + t`**: Abrir/Fechar Terminal flutuante integrando.
- **AI Suite (2026)**: Integrado via `avante.nvim` com suporte total aos modelos **Google Gemini 3.0**.
- **Comandos**:
    - **`Space + aa`**: Abrir Chat Lateral IA.
    - **`Space + ak`**: Pedir alteração de código inline.
- **Modelos Disponíveis**:
    - `Gemini 3.0 Pro High` (Default) - Máximo raciocínio.
    - `Gemini 3.0 Pro Low` - Equilíbrio entre velocidade e inteligência.
    - `Gemini 3.0 Flash` - Respostas instantâneas e leves.

#### 🔄 Como trocar o modelo de IA
Para alterar o cérebro da sua IA, siga estes passos:
1.  Abra o Neovim e procure o ficheiro de plugins: `Space + ff` -> procure por `init.lua`.
2.  Navegue até à secção `avante.nvim`.
3.  Descomente a linha do modelo desejado e comente a anterior.
4.  Grave o ficheiro (`Space + w`) e reinicie o Neovim.

> **Configuração Obrigatória**: Obtenha sua chave no [Google AI Studio](https://aistudio.google.com/app/apikey) e adicione-a ao seu `~/.dotfiles/zsh/.zshrc`: `export GEMINI_API_KEY='sua_chave_do_google_ai_studio'`.

#### 🎨 Consistência Visual
O Neovim usa agora `lualine` (barra de estado) e `bufferline` (tabs) com ícones **Nerd Fonts** de alta qualidade, 100% integrados no tema Nord.

---

## 🛡️ Segurança & Manutenção BTRFS
Se ativar a segurança BTRFS no instalador:
1.  O sistema cria um snapshot automático **antes e depois** de cada `pacman -S`.
2.  Caso uma atualização parta o sistema, pode restaurar a versão anterior via `snapper`.
3.  **Restauro de Dotfiles**: Se apagar a sua pasta `.config` por engano, basta correr `reload-config` (que aponta para a sua pasta oculta `~/.dotfiles`).

---

## 🎨 Configurações de Pós-Instalação

*   **Docker**: Execute `sudo usermod -aG docker $USER` e reinicie a sessão.
*   **MariaDB**: Execute `sudo mariadb-secure-installation` e siga o prompt (Recomendado: Use password tradicional, recuse unix_socket).
*   **Firewall**: O **UFW** já está ativo e configurado para bloquear tudo, exceto SSH e as portas de desenvolvimento (`8000`, `8080`, `5000`, `8550`).
*   **Firefox**: Instale a extensão [Nordic Theme](https://addons.mozilla.org/en-US/firefox/addon/nordic-dark/) para consistência total.
*   **Serviços**: Se não usou o instalador, ative a base: `sudo systemctl enable --now NetworkManager bluetooth sddm ufw`.

---

<div align="center">
  <p>Elevando o padrão do desenvolvimento em Linux. 🚀🏁</p>
  <sub>Orgulhosamente construído para produtividade.</sub>
</div>
