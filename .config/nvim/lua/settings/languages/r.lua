require 'settings.languages.lsp'.setup('r_language_server',
	{
	  cmd = { 'R', '--no-echo', '-e', 'languageserver::run()' },
	  filetypes = { 'r', 'rmd', 'quarto' },
		root_markers = {  '.git' },
	}
)
