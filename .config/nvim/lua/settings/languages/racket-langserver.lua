require 'settings.languages.lsp'.setup('racket-langserver',
	{
		cmd = { 'racket', '-l', 'racket-langserver' },
		filetypes = { 'racket' },
		root_markers = { '.git' },
	}
)
