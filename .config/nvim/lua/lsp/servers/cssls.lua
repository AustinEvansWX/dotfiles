local M = {}
M.setup = function(on_attach, capabilities)
	local lspconfig = require "lspconfig"

	capabilities.textDocument.completion.completionItem.snippetSupport = true

	lspconfig.cssls.setup {
		on_attach = on_attach,
		capabilities = capabilities,
	}
end

return M
