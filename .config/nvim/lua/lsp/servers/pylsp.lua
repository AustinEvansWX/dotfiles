local M = {}
M.setup = function(on_attach, capabilities)
	local lspconfig = require("lspconfig")

	lspconfig.pylsp.setup({
		on_attach = on_attach,
		capabilities = capabilities,
		settings = {
			pylsp = {
				plugins = {
					pycodestyle = {
						ignore = { "W391" },
						maxLineLength = 100,
					},
				},
			},
		},
	})
end

return M
