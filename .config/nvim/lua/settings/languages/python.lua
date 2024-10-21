local root_files = {
	'pyproject.toml',
	'ruff.toml',
	'.ruff.toml',
	'.git'
}
local cmd = { 'ruff', 'server' }

require 'settings.languages.lsp'.setup('python', 'ruff', root_files, cmd, { settings = {} })
cmd = { 'pyright-langserver', '--stdio' }
require 'settings.languages.lsp'.setup('python', 'pyright', root_files, cmd, {
	settings = {
		python = {
			analysis = {
				autoSearchPaths = true,
				useLibraryCodeForTypes = true,
				diagnosticMode = 'openFilesOnly',
			},
		},
	}
})
