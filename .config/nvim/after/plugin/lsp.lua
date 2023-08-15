local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(_, bufnr)
	local opts = { buffer = bufnr, remap = false }

	vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
	vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
	vim.keymap.set("n", "<leader>c", function() vim.lsp.buf.code_action() end, opts)
	vim.keymap.set("n", "<leader>t", function() vim.lsp.buf.references() end, opts)
	vim.keymap.set("n", "<leader>r", function() vim.lsp.buf.rename() end, opts)
	vim.keymap.set("n", "<leader>y", function() vim.lsp.buf.signature_help() end, opts)
	vim.keymap.set("n", "<leader>ws", function() vim.lsp.buf.workspace_symbol() end, opts)

	vim.keymap.set("n", "<leader>d", function() vim.diagnostic.open_float() end, opts)
	vim.keymap.set("n", "<leader><Down>", function() vim.diagnostic.goto_next() end, opts)
	vim.keymap.set("n", "<leader><Up>", function() vim.diagnostic.goto_prev() end, opts)
end)

require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

lsp.set_preferences({
  sign_icons = { }
})

local cmp = require('cmp')

cmp.setup({
	completion = {
		completeopt = "menu,menuone,noinsert",
		keyword_pattern = [[\%(-\?\d\+\%(\.\d\+\)\?\|\h\w*\%(-\w*\)*\)]],
		keyword_length = 1,
		col_offset = -3,
	},
	formatting = {
		fields = { "kind", "abbr", "menu" },
		format = function(_, vim_item)
			vim_item.menu = vim_item.kind
			return vim_item
		end,
	},
	snippet = {
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body)
		end,
	},
	mapping = {
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-q>"] = cmp.mapping.close(),
		["<Down>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif vim.fn["vsnip#available"](1) == 1 then
				vim.api.nvim_feedkeys(
					vim.api.nvim_replace_termcodes("<Plug>(vsnip-expand-or-jump)", true, true, true),
					"",
					true
				)
			else
				fallback()
			end
		end, { "i", "s", "c" }),
		["<Up>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif vim.fn["vsnip#jumpable"](-1) == 1 then
				vim.api.nvim_feedkeys(
					vim.api.nvim_replace_termcodes("<Plug>(vsnip-jump-prev)", true, true, true),
					"",
					true
				)
			else
				fallback()
			end
		end, { "i", "s", "c" }),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = false,
		}),
	},
	sources = {
		{ name = "nvim_lsp" },
		{ name = "nvim_lua" },
		{ name = "vsnip" },
		{ name = "path" },
		{ name = "buffer" },
		{ name = "nvim_lsp_signature_help" },
	},
	preselect = cmp.PreselectMode.None,
})

cmp.setup.cmdline("/", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	},
})

cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
})

lsp.setup()
