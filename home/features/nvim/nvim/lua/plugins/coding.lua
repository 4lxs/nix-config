return {
  -- mason TODO: to be removed (use nix shell instead)
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "golangci-lint",
        "shfmt",
      },
    },
  },

  -- autocomplete
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-emoji",
    },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local luasnip = require("luasnip")
      local cmp = require("cmp")

      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.confirm({ select = true })
          elseif luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      })
    end,
  },

  -- log
  {
    "fei6409/log-highlight.nvim",
    config = function()
      require("log-highlight").setup({})
    end,
  },

  -- lua
  {
    "folke/neoconf.nvim",
    dependencies = { "folke/neodev.nvim" },
  },

  -- cpp
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- ccls = {
        --   init_options = {
        --     compilationDatabaseDirectory = "build",
        --     cache = {
        --       directory = vim.fn.stdpath("cache") .. "/ccls-cache/",
        --     },
        --     index = {
        --       threads = 0,
        --     },
        --     clang = {
        --       excludeArgs = { "-frounding-math" },
        --     },
        --     -- root_dir = function(fname)
        --     --   return require("lspconfig.util").root_pattern(
        --     --     "Makefile",
        --     --     "configure.ac",
        --     --     "configure.in",
        --     --     "config.h.in",
        --     --     "meson.build",
        --     --     "meson_options.txt",
        --     --     "build.ninja"
        --     --   )(fname) or require("lspconfig.util").root_pattern(
        --     --     "compile_commands.json",
        --     --     "compile_flags.txt"
        --     --   )(fname) or require("lspconfig.util").find_git_ancestor(fname)
        --     -- end,
        --     single_file_support = true,
        --   },
        -- },
        clangd = {
          cmd = { "clangd" },
        },
      },
    },
  },
  {
    "Civitasv/cmake-tools.nvim",
    opts = {
      cmake_build_directory = "build",
      cmake_kits_path = vim.fn.expand("~/code/cmake-kits.json"),
    },
  },

  -- nix
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        statix = {},
        nil_ls = {},
        nixd = {},
        rnix = {},
      },
    },
  },

  -- python
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pylsp = {
          plugins = {
            rope_autoimport = {
              enabled = true,
            },
          },
        },
      },
    },
  },

  -- htmx
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        htmx = {},
        html = {},
      },
    },
  },

  -- TODO: null-ls to efm
  -- {
  --   "neovim/nvim-lspconfig",
  --   opts = {
  --     servers = {
  --       efm = {
  --         init_options = {
  --           documentFormatting = true,
  --           documentRangeFormatting = true,
  --           hover = true,
  --           documentSymbol = true,
  --           codeAction = true,
  --           completion = true,
  --         },
  --         settings = {
  --           rootMarkers = { ".git/", ".envrc", ".clang-format" },
  --           languages = {
  --             lua = {
  --               { formatCommand = "lua-format -i", formatStdin = true },
  --             },
  --           },
  --         },
  --       },
  --     },
  --   },
  -- },
}
