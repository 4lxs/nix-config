vim.keymap.set("n", "go", "<cmd>e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>", { desc = "Switch source/header" })
vim.keymap.set("n", "<tab>", "<c-^>")
vim.keymap.set("i", "<c-x>", "<tab>", { noremap = true })
vim.keymap.set("x", "<s-k>", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })
vim.keymap.set("v", "<s-j>", ":move'>+<CR>gv=gv", { noremap = true, silent = true })