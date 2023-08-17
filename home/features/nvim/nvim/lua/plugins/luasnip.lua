return {
  "L3MON4D3/LuaSnip",
  keys = function()
    return {}
  end,
  config = function()
    require("luasnip.loaders.from_lua").load {
      paths = vim.fn.stdpath("config") .. "/snippets/",
    }
    return false
  end,
}
