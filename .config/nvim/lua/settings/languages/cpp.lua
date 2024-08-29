local root_files = {
	'.clangd',
	'.clang-tidy',
	'.clang-format',
	'compile_commands.json',
	'compile_flags.txt',
	'configure.ac',
	'.git'
}
local cmd = { 'clangd' }

require 'settings.languages.lsp'.setup('cpp', 'clangd', root_files, cmd, {})
