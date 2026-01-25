# ❄️ ArchDev2.0 - The Elite Developer Environment

![Preview](assets/preview.png)

<div align="center">

![License](https://img.shields.io/badge/License-MIT-blue.svg) 
![CI Status](https://github.com/nbtech-prox/ArchDev2.0/actions/workflows/ci.yml/badge.svg)
![Version](https://img.shields.io/badge/Version-2.0-88C0D0)
![Strategy](https://img.shields.io/badge/Strategy-GNU_Stow-green)

**Uma arquitetura de elite para Arch Linux. Modular, resiliente e focada em automação extrema.**

[Instalação](#-instalação) • [Neovim Pro](#-neovim-pro-ide) • [Resiliência](#-segurança--resiliência) • [v1.0 (Legacy)](https://github.com/nbtech-prox/ArchDev/tree/v1.0)

</div>

---

## ✨ O que há de novo na v2.0?

*   **📦 Gestão via GNU Stow**: Chega de copiar ficheiros. Todo o seu sistema é gerido através de *symlinks* automáticos. Mude algo no repo e o sistema atualiza na hora.
*   **🛠️ Instalador Interativo (Gum)**: Um script amigável que permite escolher exatamente o que quer instalar (Laravel, Python, Neovim ou Backups).
*   **⌨️ Neovim Pro Experience**: Uma configuração modular do Neovim (Lazy.nvim) que transforma o seu terminal numa IDE poderosa com suporte LSP para PHP e Python.
*   **🛡️ Resiliência BTRFS**: Integração com Snapper para snapshots automáticos. Atualizações quebraram o sistema? Volte atrás em segundos.
*   **🎨 Boot Estilizado**: Tema Plymouth (Arctic Nord) para uma experiência coesa desde o momento em que liga o computador.

---

## 🚀 Instalação (v2.0)

**Pré-requisito**: Arch Linux Minimal (preferencialmente com sistema de ficheiros **BTRFS** se quiser snapshots).

1.  **Clone e Entre**:
    ```bash
    git clone https://github.com/nbtech-prox/ArchDev2.0.git
    cd ArchDev2.0
    ```

2.  **Execute o Setup Inteligente**:
    ```bash
    chmod +x install.sh
    ./install.sh
    ```

---

## ⌨️ Neovim Pro IDE
O ArchDev v2.0 traz o **Neovim** configurado para produção:
- **Atalho**: `nv` ou `edit`
- **Leader Key**: `Espaço`
- **`leader + ff`**: Procurar ficheiros (Telescope)
- **`leader + fg`**: Pesquisar texto nos ficheiros
- **`leader + w`**: Salvar rápido

---

## 🛡️ Segurança & Resiliência
Se selecionou "Segurança BTRFS" no instalador:
- O **Snapper** criará um ponto de restauro automático cada vez que usar o `pacman` ou `yay`.
- Os ficheiros de configuração (`dotfiles`) estão agora blindados via **Stow**. Se apagar algo na pasta `HOME` por engano, basta rodar `reload-config` para restaurar tudo.

---

## 🛠️ Stack Tecnológica (Modernizada)
- **Dotfile Manager**: GNU Stow
- **Editor**: Neovim (LSP, Treesitter, Telescope)
- **PHP**: Laravel 12 (PHP 8.4)
- **Python**: Poetry (Virtualenvs automáticos)
- **Boot**: Systemd-boot + Plymouth Arctic Nord

---

<p align="center">Elevando o padrão do desenvolvimento em Linux. 🚀🏁</p>
