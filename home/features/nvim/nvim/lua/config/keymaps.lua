-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "go", "<cmd>e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>", { desc = "Switch source/header" })
vim.keymap.set("n", "<tab>", "<cmd>e #<cr>")

vim.keymap.set("n", "<leader>nn", function()
  local filename = vim.fn.input({ prompt = "Name: " })
  vim.cmd("edit %:h/" .. filename .. ".md")
end)
