local ls = require("luasnip")
ls.config.setup {
  enable_autosnippets = true,
}
local snipfolder = '~/.config/nvim/lua/snippets/'

require('luasnip.loaders.from_lua').load {
  paths = snipfolder,
}
require('luasnip.loaders.from_vscode').lazy_load()

vim.keymap.set("i", "<c-l>", function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end)

local function edit_snips()
  local ft = vim.fn.expand('%:e')
  vim.cmd('e' .. snipfolder .. ft .. '.lua')
end

local function ls_files()
  return require("telescope.builtin").find_files({
    cwd = snipfolder,
  })
end

-- reload snippets
vim.keymap.set("n", "<leader>sr", "<cmd>source ~/.config/nvim/lua/plugins/luasnip.lua<CR>", {})
-- open curret ft snippet file
vim.keymap.set("n", "<leader>se", edit_snips, {})
-- search snippet config files
vim.keymap.set("n", "<leader>sf", ls_files, {})
