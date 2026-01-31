require 'settings.languages.lsp'.setup('R languagesserver',
	{
	  cmd = { 'R', '--no-echo', '-e', 'languageserver::run()' },
	  filetypes = { 'r', 'rmd', 'quarto' },
		root_markers = {  '.git' },
	}
)
