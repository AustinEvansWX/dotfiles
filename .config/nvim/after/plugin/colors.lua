function SetColors(color)
	color = color or "nordic"
	vim.cmd.colorscheme(color)
end

SetColors()
