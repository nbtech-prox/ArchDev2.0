return {
  -- Nord Theme
  {
    "shaunsingh/nord.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme nord]])
    end,
  },

  -- Treesitter (Syntax Highlighting)
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "lua", "python", "php", "bash", "javascript", "json", "yaml" },
        highlight = { enabled = true },
      })
    end,
  },

  -- Telescope (Fuzzy Finder)
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
    },
  },

  -- Avante.nvim (Antigravity Experience in Neovim)
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = false, -- set this to "*" to keep up to date with release, or false for latest
    opts = {
      provider = "gemini",
      gemini = {
        -- Modelos Gemini 3 (Selecione descomentando a linha desejada)
        -- model = "gemini-3.0-flash",           -- Ultra Rápido
        -- model = "gemini-3.0-pro-low",         -- Equilibrado
        model = "gemini-3.0-pro-high",           -- Máxima Inteligência (High)
        
        temperature = 0,                         -- Precisão máxima sem "alucinações"
        max_tokens = 16384,                      -- O máximo permitido para respostas longas
      },
      auto_suggestions_provider = "gemini", -- Enable copilot-style suggestions
      behaviour = {
        auto_suggestions = false, -- Change to true if you want inline suggestions
        auto_set_highlight_group = true,
        auto_set_keymaps = true,
        auto_apply_diff_after_generation = false,
        support_paste_from_clipboard = false,
      },
    },
    build = "make",
      dependencies = {
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "MeanderingProgrammer/render-markdown.nvim",
    },
  },

  -- UI: Status Line (Nerd Fonts)
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({ options = { theme = "nord", icons_enabled = true } })
    end,
  },

  -- UI: Tabs / Bufferline
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("bufferline").setup({
        options = {
          diagnostics = "nvim_lsp",
          show_buffer_icons = true,
          separator_style = "slant",
        }
      })
    end,
  },

  -- Terminal: Toggleterm
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        size = 20,
        open_mapping = [[<c-\>]],
        direction = "float",
        float_opts = { border = "curved" },
      })
    end,
  },

  -- Git: Lazygit inside Neovim
  {
    "kdheepak/lazygit.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
}
