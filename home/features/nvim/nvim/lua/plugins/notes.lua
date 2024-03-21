local notesDir = vim.fn.expand("~/Projects/notes")

-- keybinds
return {
  {
    "folke/which-key.nvim",
    keys = {
      -- { "<leader>nb", "<cmd>e " .. notesDir .. "/brain/index.md<cr>", desc = "brain" },
      -- { "<leader>nr", "<cmd>e " .. notesDir .. "/redteam/index.md<cr>", desc = "redteam" },
      -- { "<leader>nw", "<cmd>e " .. notesDir .. "/work/index.md<cr>", desc = "work" },
      -- { "<leader>ns", "<cmd>e " .. notesDir .. "/school/index.md<cr>", desc = "school" },
    },
    opts = {
      defaults = {
        -- ["<leader>n"] = { name = "+notes" },
        ["<leader>C"] = { name = "+copilot" },
        ["<leader>ct"] = { name = "+competitest" },
        ["<leader>v"] = { name = "+vim config" },
      },
    },
  },

  -- -- markdown (if html is a programming language, then so is markdown)
  -- {
  --   "neovim/nvim-lspconfig",
  --   opts = {
  --     inlay_hints = {
  --       enabled = true,
  --     },
  --     servers = {
  --       marksman = {},
  --     },
  --   },
  -- },
  -- -- {
  -- --   "4lxs/markim.nvim",
  -- --   dir = "~/Projects/markim.nvim",
  -- --   dev = true,
  -- --   opts = {},
  -- -- },
  -- -- { -- WARN: testing only. not updated to .10 yet
  -- --   "nvim-treesitter/playground",
  -- -- },
  -- {
  --   "preservim/vim-markdown",
  --   dependencies = "godlygeek/tabular",
  -- },
  -- {
  --   "lukas-reineke/headlines.nvim",
  --   dependencies = "nvim-treesitter/nvim-treesitter",
  --   opts = {},
  -- },
  -- {
  --   "iamcco/markdown-preview.nvim",
  --   ft = { "markdown" },
  --   build = function()
  --     vim.fn["mkdp#util#install"]()
  --   end,
  -- },

  --#region disabled
  -- {
  --   "nvim-neorg/neorg",
  --   keys = {
  --     { "<leader>nn", "<cmd>Neorg workspace brain<cr>", desc = "brain" },
  --     { "<leader>nm", "<cmd>Neorg workspace math<cr>", desc = "math" },
  --     { "<leader>nr", "<cmd>Neorg workspace maldev<cr>", desc = "redteam" },
  --     { "<leader>nw", "<cmd>Neorg workspace work<cr>", desc = "work" },
  --     { "<leader>ns", "<cmd>Neorg workspace school<cr>", desc = "school" },
  --   },
  --   build = ":Neorg sync-parsers",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --   },
  --   opts = {
  --     load = {
  --       ["core.defaults"] = {}, -- Loads default behaviour
  --       ["core.concealer"] = {}, -- Adds pretty icons to your documents
  --       ["core.dirman"] = { -- Manages Neorg workspaces
  --         config = {
  --           workspaces = {
  --             math = "~/Documents/notes/meth",
  --             maldev = "~/Documents/notes/maldev",
  --             brain = "~/Documents/notes/brain",
  --             work = "~/Documents/notes/work",
  --             school = "~/Documents/notes/school",
  --           },
  --           default_workspace = "brain",
  --         },
  --       },
  --       ["core.completion"] = {
  --         config = {
  --           engine = "nvim-cmp",
  --         },
  --       },
  --     },
  --   },
  -- },
  -- {
  --   "hrsh7th/nvim-cmp",
  --   dependencies = { "nvim-neorg/neorg" },
  --   ---@param opts cmp.ConfigSchema
  --   opts = function(_, opts)
  --     local cmp = require("cmp")
  --     opts.sources = cmp.config.sources(vim.list_extend(opts.sources, { { name = "neorg" } }))
  --   end,
  -- },
  --#endregion disabled
}
