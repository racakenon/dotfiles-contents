local root_files = {
	'.luarc.json',
	'.luarc.jsonc',
	'.luacheckrc',
	'.stylua.toml',
	'stylua.toml',
	'selene.toml',
	'selene.yml',
	'.git',
	'lua'
}
local cmd = { 'lua-language-server' }

require 'settings.languages.lsp'.setup('lua', 'lua-language-server', root_files, cmd, {
	settings = {
		Lua = {
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
			},
		}
	}
})
