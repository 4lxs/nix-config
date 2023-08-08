require("competitest").setup({
	testcases_use_single_file = true,
	compile_command = {
		cpp = {
			exec = "clang++",
			args = {
				"$(FNAME)",
				"-o", "$(FNOEXT)",
				"-DDEBUG",
				"-Wall",
				"-Wextra",
				"-pedantic",
				"-std=c++17",
				"-O2",
				"-Wshadow",
				"-Wformat=2",
				"-Wfloat-equal",
				"-Wconversion",
				"-Wshift-overflow",
				"-Wcast-qual",
				"-Wcast-align",
				"-D_GLIBCXX_DEBUG",
				"-D_GLIBCXX_DEBUG_PEDANTIC",
				"-D_FORTIFY_SOURCE=2",
				"-fsanitize=address",
				"-fsanitize=undefined",
				"-fno-sanitize-recover",
				"-fstack-protector",
			},
		},
	},
})

local map = vim.keymap.set
local cmds = require("competitest.commands")

map("n", "<leader>ca", "<cmd>CompetiTestAdd<cr>")
map("n", "<leader>ce", "<cmd>CompetiTestEdit<cr>")
map("n", "<leader>cd", "<cmd>CompetiTestDelete<cr>")
map("n", "<leader>cc", "<cmd>CompetiTestRun<cr>")
map("n", "<leader>cn", "<cmd>CompetiTestReceive<cr>")
