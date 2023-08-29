local Util = require("lazyvim.util")

return {
  {
    "tpope/vim-fugitive",
    dependencies = { "tpope/vim-rhubarb" },
    keys = {
      -- stylua: ignore
      { "<leader>g/", function() Util.float_term({ "lazygit" }, { cwd = Util.get_root(), esc_esc = false, ctrl_hjkl = false }) end, desc = "Lazygit (root dir)", },
      { "<leader>gg", "<cmd>Git<cr>", desc = "git status" },
      { "<leader>gd", "<cmd>Gvdiff<cr>", desc = "git diff" },
      { "<leader>ga", "<cmd>Gwrite<cr>", desc = "git add" },
      { "<leader>ga", "<cmd>Gread<cr>", desc = "git reset" },
      { "<leader>gl", "<cmd>Gread<cr>", desc = "git reset" },
      { "<leader>gb", "<cmd>Git blame<cr>", desc = "git blame" },
      { "<leader>gB", "<cmd>Gitsigns toggle_current_line_blame<cr>", desc = "toggle current line blame" },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = {
        change = { text = "~" },
      },
    },
  },
}
