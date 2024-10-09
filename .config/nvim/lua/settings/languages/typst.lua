local root_files = {
	'.git'
}
local cmd = { 'typst-lsp' }

require 'settings.languages.lsp'.setup('typst', 'typst-lsp', root_files, cmd, {})
