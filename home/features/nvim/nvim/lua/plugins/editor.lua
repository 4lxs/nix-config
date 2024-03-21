local Util = require("lazyvim.util")

vim.g.tmux_navigator_disable_when_zoomed = 1

return {
  -- colorscheme
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight",
    },
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = true,
    opts = {
      flavour = "mocha",
      transparent_background = true,
    },
  },
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = {
      style = "night",
      transparent = true,
      on_highlights = function(highlights, colors)
        highlights.DiffAdd = {
          fg = colors.green,
        }
        highlights.DiffChange = {
          fg = colors.orange,
        }
        highlights.DiffDelete = {
          fg = colors.red,
        }
      end,
    },
  },

  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "-", "<CMD>Oil<CR>", desc = "Open parent directory" },
    },
    opts = {},
  },

  -- search
  {
    "folke/flash.nvim",
    opts = {
      modes = {
        search = {
          enabled = false,
        },
      },
    },
  },

  -- Heuristically set buffer options
  {
    "tpope/vim-sleuth",
  },

  -- git
  {
    "tpope/vim-fugitive",
    dependencies = { "tpope/vim-rhubarb" },
    -- stylua: ignore
    keys = {
      { "<leader>g/", function() Util.float_term({ "lazygit" }, { cwd = Util.get_root(), esc_esc = false, ctrl_hjkl = false }) end, desc = "Lazygit (root dir)", },
      { "<leader>gg", "<cmd>Git<cr>", desc = "git status" },
      { "<leader>gd", "<cmd>Gvdiff<cr>", desc = "git diff" },
      { "<leader>ga", "<cmd>Gwrite<cr>", desc = "git add" },
      { "<leader>gr", "<cmd>Gread<cr>", desc = "git reset" },
      { "<leader>gb", "<cmd>Git blame<cr>", desc = "git blame" },
      { "gh", "<cmd>diffget //2<cr>", desc = "Git our change in 3-way conflict" },
      { "gl", "<cmd>diffget //3<cr>", desc = "Git their change in 3-way conflict" },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    -- stylua: ignore
    keys = {
      { "<leader>gB", "<cmd>Gitsigns toggle_current_line_blame<cr>", desc = "toggle current line blame" },
    },
    opts = {
      signs = {
        change = { text = "~" },
      },
    },
  },

  -- lualine
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      opts.sections.lualine_b = {}
      opts.sections.lualine_z = {}
    end,
  },

  -- snippets
  {
    "L3MON4D3/LuaSnip",
    keys = {
      { "<leader>vs", require("luasnip.loaders").edit_snippet_files, desc = "edit snippets" },
    },
    config = function()
      require("luasnip.loaders.from_lua").load({
        paths = vim.fn.stdpath("config") .. "/snippets",
      })
      return false
    end,
  },

  -- surround
  {
    "echasnovski/mini.surround",
    opts = {
      mappings = {
        add = "ys",
        delete = "ds",
        replace = "cs",
      },
    },
  },

  -- undotree
  {
    "mbbill/undotree",
    keys = {
      { "<leader>uu", vim.cmd.UndotreeToggle },
    },
  },

  -- tmux
  {
    "christoomey/vim-tmux-navigator",
    keys = {
      { "<C-h>", "<cmd>TmuxNavigateLeft<cr>", desc = "Go to left window" },
      { "<C-j>", "<cmd>TmuxNavigateDown<cr>", desc = "Go to lower window" },
      { "<C-k>", "<cmd>TmuxNavigateUp<cr>", desc = "Go to upper window" },
      { "<C-l>", "<cmd>TmuxNavigateRight<cr>", desc = "Go to right window" },
    },
  },
  -- {
  --   "vimpostor/vim-tpipeline",
  --   dependencies = {
  --     "nvim-lualine/lualine.nvim", -- lualine reenables laststatus
  --   },
  --   init = function()
  --     vim.g.tpipeline_autoembed = 0
  --     vim.opt.laststatus = 0
  --   end,
  -- },

  {
    "dhruvasagar/vim-table-mode",
  },

  {
    "AckslD/nvim-FeMaco.lua",
    keys = {
      { "<leader>o", "<cmd>FeMaco<cr>", desc = "open fenced code block" },
    },
    opts = {},
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    enabled = false,
  },
  {
    "akinsho/bufferline.nvim",
    enabled = false,
  },
  {
    "nvim-pack/nvim-spectre",
    enabled = false,
  },
  {
    "dstein64/vim-startuptime",
    enabled = false,
  },
}
