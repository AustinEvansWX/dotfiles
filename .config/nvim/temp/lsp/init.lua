local utils = require("utils")

local servers = {
	"tsserver",
	"gopls",
	"solc",
	"julials",
	"html",
	"lemminx",
	"cssls",
	"clangd",
	"angularls",
	"null-ls",
	"rust_analyzer",
	"svelte",
	"pylsp",
}

-- Floating border
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
	opts = opts or {}
	opts.border = opts.border or { { " ", "FloatBorder" } }
	return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local lsp_formatting = function(bufnr)
	vim.lsp.buf.format({
		bufnr = bufnr,
	})
end

local opts = { noremap = true, silent = true, nowait = true }

vim.api.nvim_set_keymap("n", "<space>e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
vim.api.nvim_set_keymap("n", "<space>lp", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
vim.api.nvim_set_keymap("n", "<space>ln", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
vim.api.nvim_set_keymap("n", "<space>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
vim.api.nvim_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
vim.api.nvim_set_keymap("n", "<space>d", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
vim.api.nvim_set_keymap("n", "<space>K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
vim.api.nvim_set_keymap("n", "<space>i", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
vim.api.nvim_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
vim.api.nvim_set_keymap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
vim.api.nvim_set_keymap("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
vim.api.nvim_set_keymap("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
vim.api.nvim_set_keymap("n", "<space>T", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
vim.api.nvim_set_keymap("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
vim.api.nvim_set_keymap("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
vim.api.nvim_set_keymap("n", "<space>R", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
vim.api.nvim_set_keymap("n", "<space>lf", "<cmd>lua vim.lsp.buf.format()<CR>", opts)

--local on_attach = function(client, bufnr)
--	if client.supports_method("textDocument/formatting") then
--		utils.buf_command(bufnr, "LspFormatting", function()
--			lsp_formatting(bufnr)
--		end)
--
--		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
--		vim.api.nvim_create_autocmd("BufWritePre", {
--			group = augroup,
--			buffer = bufnr,
--			command = "LspFormatting",
--		})
--	end
--end

local capabilities = vim.lsp.protocol.make_client_capabilities()
local had_cmp_nvim_lsp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if had_cmp_nvim_lsp then
	capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
end

local handlers = {
	["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
}

local had_lspconfig = pcall(require, "lspconfig")
if had_lspconfig then
	for _, server in ipairs(servers) do
		require("lsp.servers." .. server).setup(on_attach, capabilities)
		if server ~= "null-ls" then
			require("lspconfig")[server].setup({ handlers = handlers })
		end
	end
end

-- Gutter sign icons
for type, icon in pairs(utils.signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- Prefix diagnostic virtual text
vim.diagnostic.config({
	virtual_text = {
		source = "always",
		prefix = " ",
		spacing = 6,
	},
	float = {
		source = "always",
		--border = { " ", "─", " ", " ", " ", "─", " ", " " },
		border = "rounded",
	},
})
