return {
  {
    "nvim-neorg/neorg",
    build = ":Neorg sync-parsers",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { dir = "~/Projects/neorg-split" },
    },
    opts = {
      load = {
        ["core.defaults"] = {}, -- Loads default behaviour
        ["core.concealer"] = {}, -- Adds pretty icons to your documents
        ["core.dirman"] = { -- Manages Neorg workspaces
          config = {
            workspaces = {
              math = "~/Documents/notes/meth",
              maldev = "~/Documents/notes/maldev",
              brain = "~/Documents/notes/brain",
            },
            default_workspace = "brain",
          },
        },
        ["core.completion"] = {
          config = {
            engine = "nvim-cmp",
          },
        },
        ["external.split"] = {},
      },
    },
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "nvim-neorg/neorg" },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local cmp = require("cmp")
      opts.sources = cmp.config.sources(vim.list_extend(opts.sources, { { name = "neorg" } }))
    end,
  },
}
