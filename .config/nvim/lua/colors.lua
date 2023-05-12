local _M = {}

_M.colors = {
	bg = "#2e3440",
	fg = "#ECEFF4",
	red = "#bf616a",
	orange = "#d08770",
	yellow = "#ebcb8b",
	blue = "#5e81ac",
	green = "#a3be8c",
	cyan = "#88c0d0",
	magenta = "#b48ead",
	pink = "#FFA19F",
	grey1 = "#f8fafc",
	grey2 = "#f0f1f4",
	grey3 = "#eaecf0",
	grey4 = "#d9dce3",
	grey5 = "#c4c9d4",
	grey6 = "#b5bcc9",
	grey7 = "#929cb0",
	grey8 = "#8e99ae",
	grey9 = "#74819a",
	grey10 = "#616d85",
	grey11 = "#464f62",
	grey12 = "#3a4150",
	grey13 = "#333a47",
	grey14 = "#242932",
	grey15 = "#1e222a",
	grey16 = "#1c1f26",
	grey17 = "#0f1115",
	grey18 = "#0d0e11",
	grey19 = "#020203",
}

_M.init = function()
	local isExistNord, onenord = pcall(require, "onenord")
	if isExistNord then
		onenord.setup({
			borders = true,
			fade_nc = false,
			styles = {
				comments = "italic",
				strings = "NONE",
				keywords = "NONE",
				functions = "italic",
				variables = "bold",
				diagnostics = "underline",
			},
			disable = {
				background = true,
				cursorline = false,
				eob_lines = true,
			},
			custom_highlights = {
				VertSplit = { fg = "#81a1c1" },
				BufferLineIndicatorSelected = { fg = _M.colors.cyan, bg = _M.colors.bg },
				BufferLineIndicatorVisible = { fg = _M.colors.cyan, bg = _M.colors.grey12 },
				BufferLineBufferSelected = { bg = _M.colors.bg },
				BufferLineBufferVisible = { bg = _M.colors.grey12 },
				BufferLineFill = { fg = _M.colors.fg, bg = "#00000000" },
				NvimTreeNormal = { fg = _M.colors.grey5 },
				WhichKeyFloat = { bg = _M.colors.grey14 },
				GitSignsAdd = { fg = _M.colors.green },
				GitSignsChange = { fg = _M.colors.orange },
				GitSignsDelete = { fg = _M.colors.red },
				NvimTreeFolderIcon = { fg = _M.colors.grey9 },
				NvimTreeIndentMarker = { fg = _M.colors.grey12 },

				NoiceMini = { bg = "#00000000" },
				NormalFloat = { bg = "#00000000" },
				FloatBorder = { bg = "#00000000" },
				NoiceCmdlinePopupBorder = { bg = "#00000000", fg = "#81a1c1" },
				NoiceSplitBorder = { bg = "#00000000", fg = "#81a1c1" },
				NoiceFormatProgressTodo = { bg = "#00000000", fg = "#81a1c1" },
				NoiceFormatProgressDone = { bg = "#00000000", fg = "#81a1c1" },

				TelescopeNormal = { bg = "#00000000" },
				TelescopePromptPrefix = { bg = "#00000000" },
				TelescopePromptNormal = { bg = "#00000000" },
				TelescopeResultsNormal = { bg = "#00000000" },
				TelescopePreviewNormal = { bg = "#00000000" },

				TelescopePromptBorder = { bg = "#00000000", fg = "#81a1c1" },
				TelescopeResultsBorder = { bg = "#00000000", fg = "#81a1c1" },
				TelescopePreviewBorder = { bg = "#00000000", fg = "#81a1c1" },

				TelescopePromptTitle = { fg = "#81a1c1" },
				TelescopeResultsTitle = { fg = "#81a1c1" },
				TelescopePreviewTitle = { fg = "#81a1c1" },

				PmenuSel = { bg = _M.colors.grey12 },
				Pmenu = { bg = "#00000000" },
				PMenuThumb = { bg = _M.colors.grey16 },

				LspFloatWinNormal = { fg = _M.colors.fg, bg = _M.colors.grey14 },
				LspFloatWinBorder = { fg = _M.colors.grey14 },
			},
		})
	end
end

return _M
