local ok, nvimtree = pcall(require, "nvim-tree")

if not ok then
	return
end

local api = require("nvim-tree.api")
local Event = require("nvim-tree.api").events.Event

api.events.subscribe(Event.Resize, function(size)
	local winWidth = tonumber(vim.api.nvim_exec("echo winwidth(1)", true))
	local winHeight = tonumber(vim.api.nvim_exec("echo winheight(1)", true))
	local row = winHeight / 2 - 20 / 2
	local col = winWidth / 2 - size / 2

	pcall(function()
		vim.api.nvim_win_set_config(0, { row = row, col = col, relative = "editor" })
	end)
end)

api.events.subscribe(Event.FileCreated, function(data)
	vim.cmd("NvimTreeToggle")
	vim.cmd("e" .. data.fname)

	if data.fname:sub(-#".html") == ".html" then
		vim.cmd("silent! 0r ~/.config/nvim/templates/template.html")
		vim.cmd("silent! w")
	end
end)

local signs = require("utils").signs

nvimtree.setup({
	disable_netrw = true,
	auto_reload_on_write = true,
	sort_by = "name",
	renderer = {
		special_files = {},
		add_trailing = false,
		highlight_git = true,
		indent_markers = {
			enable = true,
			icons = {
				corner = "└ ",
				edge = "│ ",
				none = "  ",
			},
		},
		icons = {
			webdev_colors = true,
			glyphs = {
				default = "",
				symlink = "",
				git = {
					unstaged = "",
					staged = "ﰶ",
					unmerged = "",
					renamed = "➜",
					untracked = "",
					deleted = "﯀",
					ignored = "",
				},
				folder = {
					arrow_open = "",
					arrow_closed = "",
					default = "",
					open = "",
					empty = "",
					empty_open = "",
					symlink = "",
					symlink_open = "",
				},
			},
			show = {
				git = true,
				folder = true,
				file = true,
				folder_arrow = false,
			},
		},
	},
	hijack_netrw = true,
	open_on_tab = false,
	hijack_cursor = true,
	update_cwd = true,
	diagnostics = {
		enable = false,
		icons = {
			hint = signs.Hint,
			info = signs.Info,
			warning = signs.Warning,
			error = signs.Error,
		},
	},
	update_focused_file = {
		enable = true,
		update_cwd = true,
		ignore_list = {},
	},
	system_open = {
		cmd = nil,
		args = {},
	},
	filters = {
		dotfiles = false,
		custom = {
			"^.git$",
		},
	},
	git = {
		enable = true,
		ignore = false,
		timeout = 500,
	},
	view = {
		adaptive_size = true,
		float = {
			enable = true,
			open_win_config = {
				relative = "editor",
				-- border = { "▗", "▄", "▖", "▌", "▘", "▀", "▝", "▐" },
				-- border = { " ", "─", " ", " ", " ", "─", " ", " " },
				border = "rounded",
				width = 30,
				height = 20,
				row = tonumber(vim.api.nvim_exec("echo winheight(0)", true)) / 2 - 20 / 2,
				col = tonumber(vim.api.nvim_exec("echo winwidth(0)", true)) / 2 - 30 / 2,
				noautocmd = true,
			},
		},
		hide_root_folder = false,
		side = "left",
		mappings = {
			custom_only = false,
			list = {},
		},
		number = false,
		relativenumber = false,
		signcolumn = "yes",
	},
	trash = {
		cmd = "trash",
		require_confirm = true,
	},
	actions = {
		change_dir = {
			global = false,
		},
		open_file = {
			quit_on_open = true,
		},
	},
})
