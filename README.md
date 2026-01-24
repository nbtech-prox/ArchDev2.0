# ArchDev - Hyprland Nord Setup

![Preview](assets/preview.png)

![License](https://img.shields.io/badge/License-MIT-blue.svg) ![Arch](https://img.shields.io/badge/Arch-Linux-blue) ![Wayland](https://img.shields.io/badge/Wayland-100%25-green)

Configuração profissional e minimalista para **Arch Linux** com **Hyprland**, focada em desempenho (AMD Desktop), estética (Nord Theme) e produtividade (Dev).

## ✨ Características

*   **100% Wayland Puro**: Sem dependências legadas de X11.
*   **Tema Nord Consistente**: Todo o sistema unificado na paleta Nord (GTK, Qt, Waybar, Wofi, Terminal).
*   **Workflow Pro**: Navegação Hyprland estilo Vim/Carrossel e gestão de janelas avançada.
*   **Stack Dev Pronta**: PHP/Laravel, Python/Flask, Docker, ZSH (Powerline/Starship).
*   **Otimizado para AMD**: Variáveis de ambiente configuradas para drivers Mesa/Radeonsi.

## 🚀 Instalação

1.  Clone este repositório:
    ```bash
    git clone https://github.com/nbtech-prox/ArchDev.git
    cd ArchDev
    ```

2.  Dê permissão e execute o instalador (como user normal, **não** root):
    ```bash
    chmod +x install.sh
    ./install.sh
    ```

> O script irá instalar o `yay`, pacotes necessários, configurar temas e copiar as dotfiles.

## ⌨️ Atalhos Principais

| Tecla | Ação |
| :--- | :--- |
| `Super + Enter` | Abrir Terminal |
| `Super + B` | Abrir Firefox |
| `Super + E` | Abrir Ficheiros (Thunar) |
| `Super + W` | Menu de Apps (Wofi) |
| `Super + Q` | Fechar Janela |
| `Super + X` | Sair da Sessão |
| `Super + Esc` | Bloquear Ecrã |
| `PrintScreen` | Screenshot (Região -> Clipboard) |
| `Super + Tab` | Alternar Workspace (Anterior) |
| `Super + Ctrl + Setas` | Navegar Workspaces (Carrossel) |

## 🛠️ Stack Tecnológica
*   **Core**: Hyprland, Waybar, Wofi, Dunst
*   **Terminal**: Kitty + ZSH + Starship + Fastfetch
*   **Dev**: PHP 8.x, Python 3.x, Docker, VS Code

## 🎨 Notas de Aparência
*   **Firefox**: Instale a extensão oficial [Nordic Theme](https://addons.mozilla.org/en-US/firefox/addon/nordic-dark/) para completar o visual.
*   O script tenta aplicar automaticamente o `user.js` para forçar o Firefox a usar temas GTK.
