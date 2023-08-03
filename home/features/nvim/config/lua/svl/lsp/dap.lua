local map = vim.keymap.set
local dap = require("dap")

dap.adapters.lldb = {
	type = "executable",
	command = "/usr/bin/lldb-vscode",
	name = "lldb",
}

dap.configurations.cpp = {
	{
		name = "Launch",
		type = "lldb",
		request = "launch",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
		cwd = "${workspaceFolder}",
		stopOnEntry = true,
		args = {},
	},
}

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

-- dap.setup({})
map("n", "<leader>db", dap.toggle_breakpoint)
map("n", "<leader>dd", dap.continue)
map("n", "<leader>dj", dap.step_over)
map("n", "<leader>dl", dap.step_into)
map("n", "<leader>dh", dap.step_out)
map("n", "<leader>dc", dap.close)
map("n", "<leader>dk", dap.disconnect)

-- dap ui
local dui = require("dapui")

dui.setup({})

vim.keymap.set("n", "<leader>du", dui.toggle)

dap.listeners.after.event_initialized["dapui_config"] = dui.open
dap.listeners.before.event_terminated["dapui_config"] = dui.close
dap.listeners.before.event_exited["dapui_config"] = dui.close

-- mason dap
require("mason-nvim-dap").setup({
	ensure_installed = { "lldb" },
	automatic_installation = true,
})

require("nvim-dap-virtual-text").setup({})
