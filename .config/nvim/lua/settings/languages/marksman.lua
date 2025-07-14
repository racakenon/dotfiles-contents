require 'settings.languages.lsp'.setup('marksman',
	{
		cmd = { 'marksman', 'server' },
		filetypes = { 'markdown' },
		root_markers = { '.marksman.toml', '.git' },
	}
)
