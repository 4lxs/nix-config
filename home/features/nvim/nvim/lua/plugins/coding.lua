return {
  -- competitest
  {
    "xeluxee/competitest.nvim",
    dependencies = "MunifTanjim/nui.nvim",
    opts = {
      received_problems_path = "$(CWD)/$(PROBLEM)/solution.$(FEXT)",
      compile_command = {
        cpp = { exec = "g++", args = { "-std=c++17", "-Wall", "$(FNAME)", "-o", "$(FNOEXT)" } },
      },
    },
  },

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

  -- github copilot
  {
    "jellydn/CopilotChat.nvim",
    opts = {
      mode = "split", -- newbuffer or split  , default: newbuffer
      prompts = {
        -- Code related prompts
        Explain = "Please explain how the following code works.",
        Review = "Please review the following code and provide suggestions for improvement.",
        Tests = "Please explain how the selected code works, then generate unit tests for it.",
        Refactor = "Please refactor the following code to improve its clarity and readability.",
        -- Text related prompts
        Summarize = "Please summarize the following text.",
        Spelling = "Please correct any grammar and spelling errors in the following text.",
        Wording = "Please improve the grammar and wording of the following text.",
        Concise = "Please rewrite the following text to make it more concise.",
      },
    },
    build = function()
      vim.defer_fn(function()
        vim.cmd("UpdateRemotePlugins")
        vim.notify("CopilotChat - Updated remote plugins. Please restart Neovim.")
      end, 3000)
    end,
    event = "VeryLazy",
    keys = {
      { "<leader>cce", "<cmd>CopilotChatExplain<cr>", desc = "CopilotChat - Explain code" },
      { "<leader>cct", "<cmd>CopilotChatTests<cr>", desc = "CopilotChat - Generate tests" },
      { "<leader>ccr", "<cmd>CopilotChatReview<cr>", desc = "CopilotChat - Review code" },
      { "<leader>ccR", "<cmd>CopilotChatRefactor<cr>", desc = "CopilotChat - Refactor code" },
      { "<leader>ccs", "<cmd>CopilotChatSummarize<cr>", desc = "CopilotChat - Summarize text" },
      { "<leader>ccS", "<cmd>CopilotChatSpelling<cr>", desc = "CopilotChat - Correct spelling" },
      { "<leader>ccw", "<cmd>CopilotChatWording<cr>", desc = "CopilotChat - Improve wording" },
      { "<leader>ccc", ":CopilotChat ", desc = "CopilotChat" },
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
        ["<CR>"] = cmp.mapping({
          i = function(fallback)
            if cmp.visible() and cmp.get_active_entry() then
              cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
            else
              fallback()
            end
          end,
          s = cmp.mapping.confirm({ select = true }),
          c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
        }),
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
          cmd = { "clangd", "--header-insertion=never" },
          root_dir = function(fname)
            return require("lspconfig.util").root_pattern("compile_commands.json", "compile_flags.txt")(fname)
              or require("lspconfig.util").find_git_ancestor(fname)
          end,
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

  --#region disabled

  {
    "rafamadriz/friendly-snippets",
    enabled = false,
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

  --#endregion
}
