-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local api = vim.api
local ts = vim.treesitter
local ts_utils = require("nvim-treesitter.ts_utils")

M = M or {}

function M.format_node()
  local buf = api.nvim_get_current_buf()
  local node = ts_utils.get_node_at_cursor()
  local sr, _, er, _ = ts_utils.get_vim_range({ ts.get_node_range(node) }, buf)

  local range = {}
  range.start = { sr, -1 }
  range["end"] = { er + 1, -1 }
  vim.lsp.buf.format({
    range = range,
  })
end

local function format_line()
  local y = api.nvim_win_get_cursor(0)[1]
  local range = {}
  range.start = { y, -1 }
  range["end"] = { y + 1, -1 }
  vim.lsp.buf.format({
    range = range,
  })
end

function M.comma()
  local line = api.nvim_get_current_line()
  if api.nvim_win_get_cursor(0)[2] == line:len() and line:find("^%s*for.*") == nil then
    format_line()
  end
end

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "cpp" },
  callback = function(p)
    vim.bo.commentstring = "//%s"
    vim.b.autoformat = false
    vim.keymap.set("i", ";", ";<cmd>lua M.comma()<cr>", { buffer = p.buf })
    vim.keymap.set("i", "}", "}<cmd>lua M.format_node()<cr>", { buffer = p.buf })
  end,
})
