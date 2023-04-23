local remap = vim.keymap.set

remap('n', '<leader>a', require('harpoon.mark').add_file)
remap('n', '<leader>h', require('harpoon.ui').toggle_quick_menu)
remap('n', '<c-t>1', function() require('harpoon.ui').nav_file(1) end)
remap('n', '<c-t>2', function() require('harpoon.ui').nav_file(2) end)
remap('n', '<c-t>3', function() require('harpoon.ui').nav_file(3) end)
remap('n', '<c-t>4', function() require('harpoon.ui').nav_file(4) end)
remap('n', '<c-t>5', function() require('harpoon.ui').nav_file(5) end)
remap('n', '<c-t>6', function() require('harpoon.ui').nav_file(6) end)
