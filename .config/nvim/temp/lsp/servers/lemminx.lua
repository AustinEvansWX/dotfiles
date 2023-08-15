local M = {}
M.setup = function(on_attach, capabilities)
	local lspconfig = require("lspconfig")

	lspconfig.lemminx.setup({
		on_attach = on_attach,
		capabilities = capabilities,
		filetypes = { "xml", "xaml", "xsd", "xsl", "xslt", "svg" },
	})
end

return M
