local home = vim.fn.expand("~/Documents/notes")

require('telekasten').setup({
    home = home,
    take_over_my_home = true,
    auto_set_filetype = true,
    dailies      = home .. '/' .. 'daily',
    weeklies     = home .. '/' .. 'weekly',
    templates    = home .. '/' .. 'templates',
    image_subdir = "img",
    extension    = ".md",
    new_note_filename = "uuid-title",
    uuid_type = "%Y%m%d%H%M",
    uuid_sep = "-",
    follow_creates_nonexisting = true,
    dailies_create_nonexisting = true,
    weeklies_create_nonexisting = true,
    journal_auto_open = true,
    template_new_note = home .. '/' .. 'templates/new_note.md',
    template_new_daily = home .. '/' .. 'templates/daily.md',
    template_new_weekly= home .. '/' .. 'templates/weekly.md',
    image_link_style = "markdown",
    sort = "filename",
    plug_into_calendar = false,
    close_after_yanking = false,
    insert_after_inserting = true,
    tag_notation = "#tag",
    command_palette_theme = "ivy",
    show_tags_theme = "ivy",
    subdirs_in_links = true,
    template_handling = "smart",
    new_note_location = "smart",
    rename_update_links = true,
    media_previewer = "telescope-media-files",
    follow_url_fallback = nil,
})

vim.keymap.set('n', '<leader>zf', function() require('telekasten').find_notes() end)
vim.keymap.set('n', '<leader>zn', function() require('telekasten').new_note() end)
vim.keymap.set('n', '<leader>zd', function() require('telekasten').goto_today() end)
vim.keymap.set('n', '<leader>zw', function() require('telekasten').goto_thisweek() end)

-- in notes
vim.keymap.set('n', '<leader>zl', function() require('telekasten').insert_link({i = true}) end)
vim.keymap.set('n', '<leader>zz', function() require('telekasten').follow_link() end)
vim.keymap.set('n', '<leader>zi', function() require('telekasten').paste_img_and_link() end)
vim.keymap.set('n', '<leader>zr', function() require('telekasten').rename_note() end)
vim.keymap.set({'n', 'v'}, '<leader>zt', function() require('telekasten').toggle_todo() end)

vim.keymap.set('n', '<leader>z', function() require('telekasten').panel() end)
