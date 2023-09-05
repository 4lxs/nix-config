return {
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
          fg = colors.green
        }
        highlights.DiffChange = {
          fg = colors.orange
        }
        highlights.DiffDelete = {
          fg = colors.red
        }
      end,
    },
  },
}
