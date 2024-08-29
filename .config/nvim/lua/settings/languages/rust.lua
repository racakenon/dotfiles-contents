local root_files = {
	'.git',
	'Cargo.toml'
}
local cmd = { 'rust-analyzer' }

require 'settings.languages.lsp'.setup('rust', 'rust-analyzer', root_files, cmd, {})
