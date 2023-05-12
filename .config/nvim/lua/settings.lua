local utils = require("utils")
local colors = require("colors")

vim.g.mapleader = " "

vim.cmd([[set fcs=eob:\ ]])
vim.cmd([[filetype plugin indent on]])

local options = {
	number = true,
	relativenumber = true,
	mouse = "",
	scrolloff = 8,
	sidescrolloff = 8,
	shiftwidth = 2,
	tabstop = 2,
	softtabstop = 2,
	termguicolors = true,
	smartindent = true,
	wrap = false,
	swapfile = false,
	backup = false,
	undofile = true,
	incsearch = true,
	hlsearch = false,
	hidden = true,
	errorbells = false,
	signcolumn = "yes",
	clipboard = "unnamedplus",
	fileencoding = "utf-8",
}

vim.opt.undodir = os.getenv("HOME") .. "/undodir"
vim.opt.shortmess:append("c")

for key, value in pairs(options) do
	vim.opt[key] = value
end

utils.setSpacesSize({ go = 2, python = 2, rust = 2, cpp = 2, c = 2 })

vim.cmd([[autocmd ColorScheme * highlight Normal guibg=none]])

colors.init()
