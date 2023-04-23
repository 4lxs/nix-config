local ts = require('telescope')
local actions = require('telescope.actions')
local builtin = require('telescope.builtin')

ts.setup {
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close
      }
    }
  }
}

ts.load_extension('fzy_native')

vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
-- find config
vim.keymap.set('n', '<leader>fc', function ()
  builtin.find_files({cwd = '~/.config'})
end, {})
