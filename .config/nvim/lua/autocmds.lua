-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	pattern = "*",
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
})

-- Disable comment new line
vim.api.nvim_create_autocmd("BufWinEnter", {
	pattern = "*",
	callback = function()
		vim.opt_local.formatoptions:remove({ "c", "r", "o" })
	end,
})

vim.api.nvim_create_autocmd("BufRead,BufNewFile", {
	pattern = "tsconfig.json",
	callback = function()
		vim.opt.filetype = "jsonc"
	end,
})

vim.api.nvim_create_autocmd("BufRead,BufNewFile", {
	pattern = "*.xaml",
	callback = function()
		vim.cmd("setlocal filetype=xml")
	end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = "*.xaml",
	callback = function()
		vim.lsp.buf.format()
	end,
})

vim.api.nvim_create_autocmd("BufNewFile", {
	pattern = "*.html",
	callback = function()
		vim.cmd("0r ~/.config/nvim/templates/html.skel")
	end,
})

-- Organize imports on save (Go)
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.go",
	callback = function()
		local params = vim.lsp.util.make_range_params()
		params.context = { only = { "source.organizeImports" } }
		local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 100)
		for _, res in pairs(result or {}) do
			for _, r in pairs(res.result or {}) do
				if r.edit then
					vim.lsp.util.apply_workspace_edit(r.edit, "UTF-8")
				else
					vim.lsp.buf.execute_command(r.command)
				end
			end
		end
	end,
})

-- Format Rust Files
--vim.api.nvim_create_autocmd("BufWritePost", {
--	pattern = "*.rs",
--	callback = function()
--		vim.cmd("silent! !cargo fmt")
--	end,
--})

-- Show diagnostics after saving
vim.api.nvim_create_autocmd("BufWrite", {
	pattern = "*.cpp,*.go,*.sol",
	callback = function()
		local success, _ = pcall(vim.diagnostic.show)
		if not success then
			print("Diagnostics error")
			return
		end
	end,
})

-- Format on save
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function()
		vim.cmd("silent! undojoin | silent! Neoformat")
	end,
})
