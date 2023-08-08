local function get_output(cmd)
	local handle = io.popen(cmd)
	if handle == nil then
		return ""
	end
	local result = handle:read("*a")
	handle:close()
	return string.gsub(result, "%s+", "")
end

local function diff_source()
	local gitsigns = vim.b.gitsigns_status_dict
	if gitsigns then
		return {
			added = gitsigns.added,
			modified = gitsigns.changed,
			removed = gitsigns.removed,
		}
	end
end

require("lualine").setup({
	options = {
		theme = "tokyonight",
		section_separators = { left = "", right = "" },
		component_separators = { left = "", right = "" },
	},
	sections = {
		lualine_a = {
			{
				"mode",
				fmt = function(_)
					return get_output('tmux display-message -p "#S"')
				end,
			},
		},
		lualine_b = {
			{
				"filetype",
				colored = true,
				icon_only = true,
			},
			{
				"filename",
				symbols = {
					modified = "",
					readonly = "[r]",
					unnamed = "[no name]",
				},
				padding = 0,
				color = { gui = "bold" },
			},
		},
		lualine_c = {},
		lualine_x = {
			{
				"diagnostics",
				-- sources = { 'nvim_diagnostics' },
				sections = { "error", "warn", "info", "hint" },
				symbols = { error = "☢️", warn = "⚠", info = "", hint = "❓" },
			},
		},
		lualine_y = {
			{ "diff", source = diff_source },
			{ "b:gitsigns_head", icon = "" },
		},
		lualine_z = {
			{
				"location",
				padding = 0,
			},
			"progress",
		},
	},
})
