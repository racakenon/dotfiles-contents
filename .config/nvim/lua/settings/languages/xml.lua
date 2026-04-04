require 'settings.languages.lsp'.setup('lemminx',
	{
		cmd = { 'lemminx-linux' },
		filetypes = { 'xml', 'xsd', 'xsl', 'xslt', 'svg' },
		root_markers = { '.git' },
	}
)
