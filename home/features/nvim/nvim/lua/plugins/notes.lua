local notesDir = vim.fn.expand("~/Projects/notes")

-- keybinds
return {
  {
    "folke/which-key.nvim",
    keys = {
      { "<leader>nb", "<cmd>e " .. notesDir .. "/brain/index.md<cr>", desc = "brain" },
      { "<leader>nr", "<cmd>e " .. notesDir .. "/redteam/index.md<cr>", desc = "redteam" },
      { "<leader>nw", "<cmd>e " .. notesDir .. "/work/index.md<cr>", desc = "work" },
      { "<leader>ns", "<cmd>e " .. notesDir .. "/school/index.md<cr>", desc = "school" },
    },
    opts = {
      defaults = {
        ["<leader>n"] = { name = "+notes" },
        ["<leader>cc"] = { name = "+copilot" },
        ["<leader>ct"] = { name = "+competitest" },
        ["<leader>v"] = { name = "+vim config" },
      },
    },
  },
}
