-- Neovim Keymaps
local keymap = vim.keymap

vim.g.mapleader = " " -- Space as leader

-- General
keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Project View (Netrw)" })
keymap.set("n", "<leader>w", ":w<CR>", { desc = "Save" })
keymap.set("n", "<leader>q", ":q<CR>", { desc = "Quit" })

-- Better window navigation
keymap.set("n", "<C-h>", "<C-w>h")
keymap.set("n", "<C-j>", "<C-w>j")
keymap.set("n", "<C-k>", "<C-w>k")
keymap.set("n", "<C-l>", "<C-w>l")

-- Clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "No Highlight" })
