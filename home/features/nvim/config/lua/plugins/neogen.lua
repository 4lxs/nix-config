local remap = vim.keymap.set
local ng = require("neogen")

ng.setup({
  snippet_engine = "luasnip"
})

local function gen(type)
  return function()
    ng.generate{type = type}
  end
end

remap("n", "<leader>gg", gen('func'))
remap("n", "<leader>gc", gen('class'))
remap("n", "<leader>gt", gen('type'))
remap("n", "<leader>gf", gen('file'))
