# ❄️ ArchDev - Premium Hyprland Setup

![Preview](assets/preview.png)

<div align="center">

![License](https://img.shields.io/badge/License-MIT-blue.svg) 
![CI Status](https://github.com/nbtech-prox/ArchDev/actions/workflows/ci.yml/badge.svg)
![Arch Linux](https://img.shields.io/badge/Arch-Linux-blue?logo=arch-linux&logoColor=white)
![Hyprland](https://img.shields.io/badge/Hyprland-Wayland-green)
![Theme](https://img.shields.io/badge/Theme-Nord-88C0D0)

**Uma configuração profissional e minimalista para Arch Linux, otimizada para desenvolvedores e hardware AMD.**

[Instalação](#-instalação) • [Stack Dev](#-stack-tecnológica) • [Atalhos](#-atalhos-principais) • [Inteligência](#-waybar-inteligente)

</div>

---

## ✨ Características de Elite

*   **⚡ Performance AMD**: Configurado especificamente para drivers Mesa/Radeonsi com variáveis de ambiente otimizadas.
*   **🎨 Estética Nord**: Interface unificada usando a paleta Nord em GTK3/4, Qt5/6, Waybar, Kitty e Wofi.
*   **⌨️ Workflow Vim-Style**: Gestão de janelas fluida com navegação em carrossel e workspaces dinâmicos.
*   **🚀 Stack Dev Moderna**: Ambiente pronto para Laravel (PHP 8.x) e Python (Poetry/Flask/Flet) com Docker integrado.
*   **🌐 100% Wayland**: Experiência moderna, sem rasgos de tela (screen tearing) e com animações suaves.

---

## 🛠️ Stack Tecnológica

### Core System
- **Window Manager**: Hyprland
- **Bar**: Waybar (Customizada)
- **Launcher**: Wofi (Nord Theme)
- **Notificações**: Dunst
- **Terminal**: Kitty com ZSH + Starship Prompt

### Development Ready
- **PHP**: Laravel Installer, Composer, PHP-GD, PHP-Intl, PHP-SQLite, PHP-MySQL.
- **Python**: **Poetry** (Gerenciamento de dependências), Flask, Flet.
- **Database**: MariaDB (MySQL), SQLite.
- **Tooling**: Docker & Docker Compose, Node.js & NPM.

---

## 🧠 Waybar Inteligente

Este setup inclui um script de detecção automática de projetos. A Waybar identifica em qual ambiente você está trabalhando baseado na janela ativa:

*   🟥 **Laravel**: Detectado via `artisan`.
*   🟦 **Flet**: Detectado via `app.py` / `run.py`.
*   🧪 **Flask**: Detectado via `main.py`.
*   🐍 **Python/Poetry**: Detectado via `pyproject.toml`.

---

## 🚀 Instalação

O processo é automatizado. Certifique-se de estar em um sistema Arch Linux limpo ou com Hyprland básico.

1.  **Clone o repositório**:
    ```bash
    git clone https://github.com/nbtech-prox/ArchDev.git
    cd ArchDev
    ```

2.  **Execute o instalador**:
    ```bash
    chmod +x install.sh
    ./install.sh
    ```

> **Aviso**: O script instalará o `yay` (se não existir), todas as dependências do `packages.txt` e configurará seus arquivos de sistema (`dotfiles`).

---

## ⌨️ Atalhos Principais

| Tecla | Ação |
| :--- | :--- |
| `Super + Enter` | Abrir Terminal (Kitty) |
| `Super + B` | Abrir Browser (Firefox) |
| `Super + E` | Abrir Ficheiros (Thunar) |
| `Super + W` | Menu de Apps (Wofi) |
| `Super + Q` | Fechar Janela Ativa |
| `Super + X` | Menu de Saída (wlogout) |
| `Super + Esc` | Bloquear Ecrã (hyprlock) |
| `PrintScreen` | Screenshot (Região -> Clipboard) |
| `Super + Ctrl + Setas` | Navegar Workspaces |

---

## 🎨 Notas de Aparência

*   **Firefox**: Para o visual completo, instale a extensão [Nordic Theme](https://addons.mozilla.org/en-US/firefox/addon/nordic-dark/).
*   **ZSH**: O setup inclui o Starship. Após instalar, você terá um prompt rápido e informativo.
*   **Docker**: Execute `sudo usermod -aG docker $USER` e reinicie a sessão para usar Docker sem sudo.
*   **MariaDB**: Recomendado correr `sudo mariadb-secure-installation` após a instalação para configurar a senha de root.

---

<p align="center">Criado com foco em produtividade e elegância. ☕</p>
