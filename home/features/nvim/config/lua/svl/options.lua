local default_options = {
	backup = false, -- creates a backup file
	clipboard = "unnamedplus", -- allows neovim to access the system clipboard
	completeopt = { "menuone", "noselect" },
	conceallevel = 2, -- so that `` is visible in markdown files
	ignorecase = true, -- ignore case in search patterns
	smartcase = true, -- smart case
	mouse = "a", -- allow the mouse to be used in neovim
	pumheight = 10, -- pop up menu height
	showmode = false, -- we don't need to see things like -- INSERT -- anymore
	smartindent = true, -- make indenting smarter again
	splitbelow = true, -- force all horizontal splits to go below current window
	splitright = true, -- force all vertical splits to go to the right of current window
	swapfile = false, -- creates a swapfile
	termguicolors = true, -- set term gui colors (most terminals support this)
	-- timeoutlen = 1000, -- time to wait for a mapped sequence to complete (in milliseconds)
	title = true, -- set the title of window to the value of the titlestring
	-- opt.titlestring = "%<%F%=%l/%L - nvim" -- what the title of the window will be set to
	undofile = true, -- enable persistent undo
	updatetime = 100, -- faster completion
	writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
	expandtab = true, -- convert tabs to spaces
	shiftwidth = 2, -- the number of spaces inserted for each indentation
	tabstop = 2, -- insert 2 spaces for a tab
	cursorline = true, -- highlight the current line
	number = true, -- set numbered lines
	relativenumber = true,
	numberwidth = 2, -- set number column width to 2 {default 4}
	signcolumn = "yes", -- always show the sign column, otherwise it would shift the text each time
	wrap = false, -- display lines as one long line
	shadafile = vim.fn.stdpath("cache") .. "/shada",
	scrolloff = 8, -- minimal number of screen lines to keep above and below the cursor.
	sidescrolloff = 8, -- minimal number of screen lines to keep left and right of the cursor.
	ruler = false,
	laststatus = 3,
	list = true,
}

---  SETTINGS  ---
vim.opt.shortmess:append("c") -- don't show redundant messages from ins-completion-menu
vim.opt.shortmess:append("I") -- don't show the default intro message
vim.opt.whichwrap:append("<,>,[,],h,l")
-- vim.opt.listchars:append("space:⋅")
-- vim.opt.listchars:append("eol:↴")
vim.opt.formatoptions:remove("o") -- don't add comment leader when hitting o on comment line (use gco)

for k, v in pairs(default_options) do
	vim.opt[k] = v
end

-- highlight on yank
local api = vim.api
local yankGrp = api.nvim_create_augroup("YankHighlight", { clear = true })
api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = yankGrp,
})
