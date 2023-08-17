return {
  {
    "jakemason/ouroboros",
    dependencies = { "nvim-lua/plenary.nvim" },
    ft = { "c", "cpp" },
    keys = {
      { "go", "<cmd>Ouroboros<CR>" },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      autoformat = false, -- TODO: figure out per filetype
      servers = {
        ccls = {
          init_options = {
            compilationDatabaseDirectory = "build",
            cache = {
              directory = vim.fn.stdpath("cache") .. "/ccls-cache/",
            },
            index = {
              threads = 0,
            },
            clang = {
              excludeArgs = { "-frounding-math" },
            },
            -- root_dir = function(fname)
            --   return require("lspconfig.util").root_pattern(
            --     "Makefile",
            --     "configure.ac",
            --     "configure.in",
            --     "config.h.in",
            --     "meson.build",
            --     "meson_options.txt",
            --     "build.ninja"
            --   )(fname) or require("lspconfig.util").root_pattern(
            --     "compile_commands.json",
            --     "compile_flags.txt"
            --   )(fname) or require("lspconfig.util").find_git_ancestor(fname)
            -- end,
            single_file_support = true,
          },
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
}
